import sys
import os
import struct
import shutil
import json

# RV32IMA + Zicsr + Zifencei
INST_MAP = {
    "add":      {"op": 0x33, "f3": 0x0, "f7": 0x00},
    "sub":      {"op": 0x33, "f3": 0x0, "f7": 0x20},
    "sll":      {"op": 0x33, "f3": 0x1, "f7": 0x00},
    "slt":      {"op": 0x33, "f3": 0x2, "f7": 0x00},
    "sltu":     {"op": 0x33, "f3": 0x3, "f7": 0x00},
    "xor":      {"op": 0x33, "f3": 0x4, "f7": 0x00},
    "srl":      {"op": 0x33, "f3": 0x5, "f7": 0x00},
    "sra":      {"op": 0x33, "f3": 0x5, "f7": 0x20},
    "or":       {"op": 0x33, "f3": 0x6, "f7": 0x00},
    "and":      {"op": 0x33, "f3": 0x7, "f7": 0x00},
    "addi":     {"op": 0x13, "f3": 0x0, "f7": 0x0},
    "slti":     {"op": 0x13, "f3": 0x2, "f7": 0x0},
    "sltiu":    {"op": 0x13, "f3": 0x3, "f7": 0x0},
    "xori":     {"op": 0x13, "f3": 0x4, "f7": 0x0},
    "ori":      {"op": 0x13, "f3": 0x6, "f7": 0x0},
    "andi":     {"op": 0x13, "f3": 0x7, "f7": 0x0},
    "slli":     {"op": 0x13, "f3": 0x1, "f7": 0x00},
    "srli":     {"op": 0x13, "f3": 0x5, "f7": 0x00},
    "srai":     {"op": 0x13, "f3": 0x5, "f7": 0x20},
    "lb":       {"op": 0x03, "f3": 0x0, "f7": 0x0},
    "lh":       {"op": 0x03, "f3": 0x1, "f7": 0x0},
    "lw":       {"op": 0x03, "f3": 0x2, "f7": 0x0},
    "lbu":      {"op": 0x03, "f3": 0x4, "f7": 0x0},
    "lhu":      {"op": 0x03, "f3": 0x5, "f7": 0x0},
    "sb":       {"op": 0x23, "f3": 0x0, "f7": 0x0},
    "sh":       {"op": 0x23, "f3": 0x1, "f7": 0x0},
    "sw":       {"op": 0x23, "f3": 0x2, "f7": 0x0},
    "beq":      {"op": 0x63, "f3": 0x0, "f7": 0x0},
    "bne":      {"op": 0x63, "f3": 0x1, "f7": 0x0},
    "blt":      {"op": 0x63, "f3": 0x4, "f7": 0x0},
    "bge":      {"op": 0x63, "f3": 0x5, "f7": 0x0},
    "bltu":     {"op": 0x63, "f3": 0x6, "f7": 0x0},
    "bgeu":     {"op": 0x63, "f3": 0x7, "f7": 0x0},
    "lui":      {"op": 0x37, "f3": 0x0, "f7": 0x0},
    "auipc":    {"op": 0x17, "f3": 0x0, "f7": 0x0},
    "jal":      {"op": 0x6F, "f3": 0x0, "f7": 0x0},
    "jalr":     {"op": 0x67, "f3": 0x0, "f7": 0x0},
    "fence":    {"op": 0x0F, "f3": 0x0, "f7": 0x0},
    "fence.i":  {"op": 0x0F, "f3": 0x1, "f7": 0x0},
    "ecall":    {"op": 0x73, "f3": 0x0, "f7": 0x0},
    "ebreak":   {"op": 0x73, "f3": 0x0, "f7": 0x1},
    "mret":     {"op": 0x73, "f3": 0x0, "f7": 0x302},
    "wfi":      {"op": 0x73, "f3": 0x0, "f7": 0x105},
    "csrrw":    {"op": 0x73, "f3": 0x1, "f7": 0x0},
    "csrrs":    {"op": 0x73, "f3": 0x2, "f7": 0x0},
    "csrrc":    {"op": 0x73, "f3": 0x3, "f7": 0x0},
    "csrrwi":   {"op": 0x73, "f3": 0x5, "f7": 0x0},
    "csrrsi":   {"op": 0x73, "f3": 0x6, "f7": 0x0},
    "csrrci":   {"op": 0x73, "f3": 0x7, "f7": 0x0},
    "mul":      {"op": 0x33, "f3": 0x0, "f7": 0x01},
    "mulh":     {"op": 0x33, "f3": 0x1, "f7": 0x01},
    "mulhsu":   {"op": 0x33, "f3": 0x2, "f7": 0x01},
    "mulhu":    {"op": 0x33, "f3": 0x3, "f7": 0x01},
    "div":      {"op": 0x33, "f3": 0x4, "f7": 0x01},
    "divu":     {"op": 0x33, "f3": 0x5, "f7": 0x01},
    "rem":      {"op": 0x33, "f3": 0x6, "f7": 0x01},
    "remu":     {"op": 0x33, "f3": 0x7, "f7": 0x01},
    "lr.w":      {"op": 0x2F, "f3": 0x2, "f7": 0x02},
    "sc.w":      {"op": 0x2F, "f3": 0x2, "f7": 0x03},
    "amoswap.w": {"op": 0x2F, "f3": 0x2, "f7": 0x01},
    "amoadd.w":  {"op": 0x2F, "f3": 0x2, "f7": 0x00},
    "amoxor.w":  {"op": 0x2F, "f3": 0x2, "f7": 0x04},
    "amoand.w":  {"op": 0x2F, "f3": 0x2, "f7": 0x0C},
    "amoor.w":   {"op": 0x2F, "f3": 0x2, "f7": 0x08},
    "amomin.w":  {"op": 0x2F, "f3": 0x2, "f7": 0x10},
    "amomax.w":  {"op": 0x2F, "f3": 0x2, "f7": 0x14},
    "amominu.w": {"op": 0x2F, "f3": 0x2, "f7": 0x18},
    "amomaxu.w": {"op": 0x2F, "f3": 0x2, "f7": 0x1C},
    "cbo.zero":  {"op": 0x0F, "f3": 0x2, "f7": 0x04},
}

def generate_ram_init(f):
    f.write("# Initialize 32MB RAM (Exponential Append)\n")
    f.write("data modify storage rv:data temp.page set value [I;0,0,0,0,0,0,0,0]\n")
    for _ in range(10): # 8 * 2^10 = 8192
        f.write("data modify storage rv:data temp.page append from storage rv:data temp.page[]\n")
    
    f.write("data modify storage rv:data ram set value []\n")
    f.write("data modify storage rv:data ram append from storage rv:data temp.page\n")
    for _ in range(10): # 1 * 2^10 = 1024
        f.write("data modify storage rv:data ram append from storage rv:data ram[]\n")
    f.write("data remove storage rv:data temp\n")

def generate_ascii_init(dist_dir):
    ascii_list = []
    for i in range(128):
        if 32 <= i <= 126:
            ascii_list.append(chr(i))
        else:
            ascii_list.append("")
    json_list = json.dumps(ascii_list)
    with open(f"{dist_dir}/data/rv/function/core/init_ascii.mcfunction", 'w', encoding='utf-8') as f:
        f.write(f"data modify storage rv:data asciimap set value {json_list}\n")
        f.write("data modify storage rv:data uart_buf set value \"\"\n")

def bin_to_mc(input_file, dist_dir):
    try:
        with open(input_file, 'rb') as f:
            data = f.read()
    except: return

    padding = (4 - len(data) % 4) % 4
    data += b'\x00' * padding

    words = [struct.unpack('<i', data[i:i+4])[0] for i in range(0, len(data), 4)]
    
    dtb_words = []
    if os.path.exists("devicetree.dtb"):
        with open("devicetree.dtb", 'rb') as f:
            dtb_data = f.read()
            if len(dtb_data) > 8192:
                print("Error: DTB size exceeds 8KB")
                sys.exit(1)
            padding = (4 - len(dtb_data) % 4) % 4
            dtb_data += b'\x00' * padding
            dtb_words = [struct.unpack('<i', dtb_data[i:i+4])[0] for i in range(0, len(dtb_data), 4)]

    with open(f"{dist_dir}/data/rv/function/core/load_bin.mcfunction", 'w') as f:
        page_size = 8192
        for i in range(0, len(words), page_size):
            page_idx = i // page_size
            if page_idx >= 1024: break
            page_data = words[i:i+page_size]
            if any(w != 0 for w in page_data):
                padded_data = list(page_data) + [0] * (page_size - len(page_data))
                f.write(f"data modify storage rv:data ram[{page_idx}] set value [I;{','.join(map(str, padded_data))}]\n")
        
        if dtb_words:
            padded_dtb = list(dtb_words) + [0] * (page_size - len(dtb_words))
            f.write(f"data modify storage rv:data ram[1023] set value [I;{','.join(map(str, padded_dtb))}]\n")
            

def main():
    if len(sys.argv) < 3: return
    bin_file, dist_dir = sys.argv[1], sys.argv[2]
    
    if os.path.exists(dist_dir): shutil.rmtree(dist_dir)
    os.makedirs(f"{dist_dir}/data/rv/function/inst", exist_ok=True)
    os.makedirs(f"{dist_dir}/data/minecraft/tags/function", exist_ok=True)

    for filename in os.listdir("src/inst"):
        if not filename.endswith(".mcfunction"): continue
        name = filename.replace(".mcfunction", "")
        if name in INST_MAP:
            m = INST_MAP[name]
            target_name = f"op{m['op']}_f{m['f3']}_s{m['f7']}.mcfunction"
            with open(f"src/inst/{filename}", 'r') as src, open(f"{dist_dir}/data/rv/function/inst/{target_name}", 'w') as dst:
                dst.write(src.read())

    for item in os.listdir("src"):
        src_path = os.path.join("src", item)
        if os.path.isdir(src_path) and item != "inst":
            shutil.copytree(src_path, f"{dist_dir}/data/rv/function/{item}")

    with open(f"{dist_dir}/data/rv/function/core/init_ram.mcfunction", 'w') as f:
        generate_ram_init(f)

    generate_ascii_init(dist_dir)

    bin_to_mc(bin_file, dist_dir)
    with open(f"{dist_dir}/pack.mcmeta", 'w') as f: f.write('{"pack":{"pack_format":48,"description":"mcrvemu"}}')
    with open(f"{dist_dir}/data/minecraft/tags/function/load.json", 'w') as f: f.write('{"values":["rv:core/boot"]}')
    with open(f"{dist_dir}/data/minecraft/tags/function/tick.json", 'w') as f: f.write('{"values":["rv:core/loop"]}')
    
    with open(f"{dist_dir}/data/rv/function/core/loop.mcfunction", 'w') as f:
        for _ in range(820): f.write("execute if score #trap rv_data matches -1 run function rv:core/step\n")
        f.write("scoreboard players add mtime rv_data 50\n")
        f.write("execute if score mtime rv_data matches ..-1 run scoreboard players add mtimeh rv_data 1\n")
        f.write("function rv:core/check_interrupts\n")
        f.write("scoreboard players operation #mstatus_mie rv_data = mstatus rv_data\n")
        f.write("scoreboard players operation #mstatus_mie rv_data /= #c8 rv_data\n")
        f.write("scoreboard players operation #mstatus_mie rv_data %= #c2 rv_data\n")
        f.write("execute if score #mstatus_mie rv_data matches 1 run function rv:core/dispatch_interrupt\n")

if __name__ == "__main__": main()
