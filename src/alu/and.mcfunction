scoreboard players set #val rv_data 0

scoreboard players set #m rv_data 1
function rv:alu/and_bit
scoreboard players set #m rv_data 2
function rv:alu/and_bit
scoreboard players set #m rv_data 4
function rv:alu/and_bit
scoreboard players set #m rv_data 8
function rv:alu/and_bit
scoreboard players set #m rv_data 16
function rv:alu/and_bit
scoreboard players set #m rv_data 32
function rv:alu/and_bit
scoreboard players set #m rv_data 64
function rv:alu/and_bit
scoreboard players set #m rv_data 128
function rv:alu/and_bit
scoreboard players set #m rv_data 256
function rv:alu/and_bit
scoreboard players set #m rv_data 512
function rv:alu/and_bit
scoreboard players set #m rv_data 1024
function rv:alu/and_bit
scoreboard players set #m rv_data 2048
function rv:alu/and_bit
scoreboard players set #m rv_data 4096
function rv:alu/and_bit
scoreboard players set #m rv_data 8192
function rv:alu/and_bit
scoreboard players set #m rv_data 16384
function rv:alu/and_bit
scoreboard players set #m rv_data 32768
function rv:alu/and_bit
scoreboard players set #m rv_data 65536
function rv:alu/and_bit
scoreboard players set #m rv_data 131072
function rv:alu/and_bit
scoreboard players set #m rv_data 262144
function rv:alu/and_bit
scoreboard players set #m rv_data 524288
function rv:alu/and_bit
scoreboard players set #m rv_data 1048576
function rv:alu/and_bit
scoreboard players set #m rv_data 2097152
function rv:alu/and_bit
scoreboard players set #m rv_data 4194304
function rv:alu/and_bit
scoreboard players set #m rv_data 8388608
function rv:alu/and_bit
scoreboard players set #m rv_data 16777216
function rv:alu/and_bit
scoreboard players set #m rv_data 33554432
function rv:alu/and_bit
scoreboard players set #m rv_data 67108864
function rv:alu/and_bit
scoreboard players set #m rv_data 134217728
function rv:alu/and_bit
scoreboard players set #m rv_data 268435456
function rv:alu/and_bit
scoreboard players set #m rv_data 536870912
function rv:alu/and_bit
scoreboard players set #m rv_data 1073741824
function rv:alu/and_bit

execute if score #val1 rv_data matches ..-1 if score #val2 rv_data matches ..-1 run scoreboard players operation #val rv_data += #c_msb rv_data