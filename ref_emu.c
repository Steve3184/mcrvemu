#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <termios.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <signal.h>
#include "dtb_data.h" 

#define RAM_SIZE (32*1024*1024)
#define RAM_OFFSET 0x80000000
#define DTB_FIXED_ADDR 0x81ff8000

static uint8_t ram_image[RAM_SIZE];
struct MiniRV32IMAState *core;
static struct termios oldt;

static char uart_line_buf[2048];
static int uart_line_ptr = 0;
static char custom_uart_line_buf[2048];
static int custom_uart_line_ptr = 0;

static uint8_t custom_uart_rx_buf[2048];
static int custom_uart_rx_head = 0;
static int custom_uart_rx_tail = 0;

static const char *snapshot_trigger = NULL;
static const char *snapshot_out = NULL;
static int snapshot_pending = 0;

static uint32_t HandleControlStore(uint32_t addy, uint32_t val);
static uint32_t HandleControlLoad(uint32_t addy);
void DumpSnapshot(const char *filename);

static void ResetKeyboardInput() {
    tcsetattr(STDIN_FILENO, TCSANOW, &oldt);
    int flags = fcntl(STDIN_FILENO, F_GETFL, 0);
    fcntl(STDIN_FILENO, F_SETFL, flags & ~O_NONBLOCK);
}

static void CtrlC(int sig) {
    ResetKeyboardInput();
    exit(sig);
}

static void CaptureKeyboardInput() {
    struct termios newt;
    tcgetattr(STDIN_FILENO, &oldt);
    newt = oldt;
    newt.c_lflag &= ~(ICANON | ECHO);
    tcsetattr(STDIN_FILENO, TCSANOW, &newt);
    
    int flags = fcntl(STDIN_FILENO, F_GETFL, 0);
    fcntl(STDIN_FILENO, F_SETFL, flags | O_NONBLOCK);

    atexit(ResetKeyboardInput);
    signal(SIGINT, CtrlC);
}

static void PollKeyboard() {
    uint8_t ch;
    while (read(STDIN_FILENO, &ch, 1) > 0) {
        if (ch == 127) ch = 8;
        
        int next = (custom_uart_rx_tail + 1) % sizeof(custom_uart_rx_buf);
        if (next != custom_uart_rx_head) {
            custom_uart_rx_buf[custom_uart_rx_tail] = ch;
            custom_uart_rx_tail = next;
        }
    }
}

#define MINIRV32_DECORATE  static
#define MINI_RV32_RAM_SIZE RAM_SIZE
#define MINIRV32_IMPLEMENTATION
#define MINIRV32_MMIO_RANGE(n)  ((n >> 28) == 0x1)
#define MINIRV32_HANDLE_MEM_STORE_CONTROL( addy, val ) if( HandleControlStore( addy, val ) ) return val;
#define MINIRV32_HANDLE_MEM_LOAD_CONTROL( addy, rval ) rval = HandleControlLoad( addy );

#include "mini-rv32ima.h"

int main(int argc, char **argv) {
    if (argc < 2) {
        printf("Usage: %s <image> [trigger_string] [output_snapshot]\n", argv[0]);
        return -1;
    }

    if (argc >= 4) {
        snapshot_trigger = argv[2];
        snapshot_out = argv[3];
    }

    FILE *f = fopen(argv[1], "rb");
    if (!f) return -2;
    fseek(f, 0, SEEK_END);
    long flen = ftell(f);
    fseek(f, 0, SEEK_SET);
    if (flen > RAM_SIZE) flen = RAM_SIZE;
    fread(ram_image, 1, flen, f);
    fclose(f);

    uint32_t dtb_ram_offset = DTB_FIXED_ADDR - RAM_OFFSET;
    memcpy(ram_image + dtb_ram_offset, dtb_data, sizeof(dtb_data));

    core = malloc(sizeof(struct MiniRV32IMAState));
    memset(core, 0, sizeof(struct MiniRV32IMAState));

    core->pc = RAM_OFFSET;
    core->regs[11] = DTB_FIXED_ADDR;
    core->extraflags |= 3;
    
    printf("MiniRV32IMA running. DTB at 0x%08x\n", DTB_FIXED_ADDR);
    
    CaptureKeyboardInput();
    
    while (1) {
        int ret = MiniRV32IMAStep(core, ram_image, 0, 800, 800);
        
        PollKeyboard();

        if (snapshot_pending) {
            DumpSnapshot(snapshot_out);
            exit(0);
        }
        if (ret == 0x5555) { printf("\nPoweroff.\n"); break; }
        if (ret == 0x7777) { printf("\nReboot.\n"); core->pc = RAM_OFFSET; }
    }
    ResetKeyboardInput();
    return 0;
}
static uint32_t HandleControlStore(uint32_t addy, uint32_t val) {
    if (addy == 0x10000000 || addy == 0x1da00000) {
        char c = val & 0xFF;
        char *buf = (addy == 0x10000000) ? uart_line_buf : custom_uart_line_buf;
        int *ptr = (addy == 0x10000000) ? &uart_line_ptr : &custom_uart_line_ptr;

        putchar(c); 
        fflush(stdout);

        if (c == '\n' || c == '\r') {
            buf[*ptr] = 0; 
            if (snapshot_trigger && snapshot_out && strstr(buf, snapshot_trigger)) {
                snapshot_pending = 1;
            }
            *ptr = 0; 
        } else {
            if (*ptr < 2047) {
                buf[(*ptr)++] = c;
            }
        }
        return 0;
    }

    if (addy == 0x11004004) { core->timermatchh = val; return 0; }
    if (addy == 0x11004000) { core->timermatchl = val; return 0; }
    if (addy == 0x11100000) return val; 

    return 0;
}

static uint32_t HandleControlLoad(uint32_t addy) {
    if (addy == 0x10000005) return 0x60; 

    if (addy == 0x1da00004) {
        if (custom_uart_rx_head != custom_uart_rx_tail) {
            uint32_t val = custom_uart_rx_buf[custom_uart_rx_head];
            custom_uart_rx_head = (custom_uart_rx_head + 1) % sizeof(custom_uart_rx_buf);
            return val;
        }
        return 0; 
    }

    if (addy == 0x1100bffc) return core->timerh;
    if (addy == 0x1100bff8) return core->timerl;

    return 0;
}

void DumpSnapshot(const char *filename) {
    FILE *f = fopen(filename, "w");
    if (!f) return;
    fprintf(f, "# MCRVEmu VM Snapshot, generated by script. DO NOT EDIT\n");
    fprintf(f, "scoreboard players set #pc rv_data %d\n", (int)core->pc);
    fprintf(f, "scoreboard players set priv_mode rv_data %d\n", (int)(core->extraflags & 3));
    fprintf(f, "scoreboard players set mstatus rv_data %d\n", (int)core->mstatus);
    fprintf(f, "scoreboard players set mepc rv_data %d\n", (int)core->mepc);
    fprintf(f, "scoreboard players set mcause rv_data %d\n", (int)core->mcause);
    fprintf(f, "scoreboard players set mtval rv_data %d\n", (int)core->mtval);
    fprintf(f, "scoreboard players set mtvec rv_data %d\n", (int)core->mtvec);
    fprintf(f, "scoreboard players set mscratch rv_data %d\n", (int)core->mscratch);
    fprintf(f, "scoreboard players set mie rv_data %d\n", (int)core->mie);
    fprintf(f, "scoreboard players set mip rv_data %d\n", (int)core->mip);
    fprintf(f, "scoreboard players set mtime rv_data %d\n", (int)core->timerl);
    fprintf(f, "scoreboard players set mtimeh rv_data %d\n", (int)core->timerh);
    fprintf(f, "scoreboard players set mtimecmp rv_data %d\n", (int)core->timermatchl);
    fprintf(f, "scoreboard players set mtimecmph rv_data %d\n", (int)core->timermatchh);
    fprintf(f, "scoreboard players set mcycle rv_data %d\n", (int)core->cyclel);
    fprintf(f, "scoreboard players set mcycleh rv_data %d\n", (int)core->cycleh);

    for (int i = 1; i < 32; i++) {
        fprintf(f, "scoreboard players set x%d rv_data %d\n", i, (int)core->regs[i]);
    }
    
    if (core->regs[4] == 0) printf("[WARNING] tp is 0 at dump!\n");
    printf("[DEBUG] mscratch: %08x, mtvec: %08x, sp: %08x, tp: %08x, priv: %d\n", 
           core->mscratch, core->mtvec, core->regs[2], core->regs[4], (int)(core->extraflags & 3));

    uint32_t *words = (uint32_t *)ram_image;
    for (int p = 0; p < 1024; p++) {
        int page_has_data = 0;
        for (int i = 0; i < 8192; i++) {
            if (words[p * 8192 + i] != 0) { page_has_data = 1; break; }
        }
        if (page_has_data) {
            fprintf(f, "data modify storage rv:data ram[%d] set value [I;", p);
            for (int i = 0; i < 8192; i++) {
                fprintf(f, "%d%s", (int)words[p * 8192 + i], (i == 8191) ? "" : ",");
            }
            fprintf(f, "]\n");
        }
    }

    if (uart_line_ptr > 0) {
        fprintf(f, "data modify storage rv:data uart.buf set value []\n");
        for(int i=0; i<uart_line_ptr; i++) {
            fprintf(f, "data modify storage rv:data uart.buf append from storage rv:data asciimap[%d]\n", (int)uart_line_buf[i]);
        }
        fprintf(f, "scoreboard players set #uart_count rv_data %d\n", uart_line_ptr);
    }

    if (core->extraflags & 4) {
        fprintf(f, "scoreboard players set #trap rv_data -3\n");
    } else {
        fprintf(f, "scoreboard players set #trap rv_data -1\n");
    }
    fclose(f);
    printf("\n[*] Snapshot dumped to %s\n", filename);
    ResetKeyboardInput();
}
