scoreboard players set #msb rv_data 0
execute if score #val rv_data matches ..-1 run scoreboard players set #msb rv_data 1
execute if score #val rv_data matches ..-1 run scoreboard players operation #val rv_data -= #c_msb rv_data

execute if score #byte_off rv_data matches 1 run scoreboard players operation #val rv_data /= #c256 rv_data
execute if score #byte_off rv_data matches 1 if score #msb rv_data matches 1 run scoreboard players add #val rv_data 8388608

execute if score #byte_off rv_data matches 2 run scoreboard players operation #val rv_data /= #c65536 rv_data
execute if score #byte_off rv_data matches 2 if score #msb rv_data matches 1 run scoreboard players add #val rv_data 32768

execute if score #byte_off rv_data matches 3 run scoreboard players operation #val rv_data /= #c16777216 rv_data
execute if score #byte_off rv_data matches 3 if score #msb rv_data matches 1 run scoreboard players add #val rv_data 128

scoreboard players operation #val rv_data %= #c256 rv_data
execute if score #val rv_data matches ..-1 run scoreboard players add #val rv_data 256

execute if score #width rv_data matches 1 if score #val rv_data matches 128.. run scoreboard players remove #val rv_data 256
