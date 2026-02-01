function rv:core/mem/load_byte_unsigned

scoreboard players operation #shamt rv_data = #i rv_data
scoreboard players operation #shamt rv_data *= #c8 rv_data

scoreboard players operation #val_to_add rv_data = #val rv_data

execute if score #shamt rv_data matches 8 run scoreboard players operation #val_to_add rv_data *= #c256 rv_data
execute if score #shamt rv_data matches 16 run scoreboard players operation #val_to_add rv_data *= #c65536 rv_data

execute if score #shamt rv_data matches 24 if score #val_to_add rv_data matches ..127 run scoreboard players operation #val_to_add rv_data *= #c16777216 rv_data

execute if score #shamt rv_data matches 24 if score #val_to_add rv_data matches 128.. run scoreboard players operation #tmp rv_data = #val_to_add rv_data
execute if score #shamt rv_data matches 24 if score #val_to_add rv_data matches 128.. run scoreboard players remove #tmp rv_data 128
execute if score #shamt rv_data matches 24 if score #val_to_add rv_data matches 128.. run scoreboard players operation #tmp rv_data *= #c16777216 rv_data
execute if score #shamt rv_data matches 24 if score #val_to_add rv_data matches 128.. run scoreboard players operation #val_to_add rv_data = #tmp rv_data
execute if score #shamt rv_data matches 24 if score #val_to_add rv_data matches 128.. run scoreboard players operation #val_to_add rv_data += #c_msb rv_data

scoreboard players operation #result_val rv_data += #val_to_add rv_data

scoreboard players add #addr rv_data 1
scoreboard players add #i rv_data 1

scoreboard players set #limit rv_data 4
execute if score #saved_width rv_data matches 1 run scoreboard players set #limit rv_data 1
execute if score #saved_width rv_data matches 5 run scoreboard players set #limit rv_data 1
execute if score #saved_width rv_data matches 2 run scoreboard players set #limit rv_data 2
execute if score #saved_width rv_data matches 6 run scoreboard players set #limit rv_data 2

execute if score #i rv_data < #limit rv_data run function rv:core/mem/do_unaligned_load_loop
