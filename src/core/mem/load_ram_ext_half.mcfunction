scoreboard players set #msb rv_data 0
execute if score #val rv_data matches ..-1 run scoreboard players set #msb rv_data 1
execute if score #val rv_data matches ..-1 run scoreboard players operation #val rv_data -= #c_msb rv_data

execute if score #byte_off rv_data matches 2 run scoreboard players operation #val rv_data /= #c65536 rv_data
execute if score #byte_off rv_data matches 2 if score #msb rv_data matches 1 run scoreboard players add #val rv_data 32768

scoreboard players operation #val rv_data %= #c65536 rv_data
execute if score #val rv_data matches ..-1 run scoreboard players add #val rv_data 65536

execute if score #width rv_data matches 2 if score #val rv_data matches 32768.. run scoreboard players remove #val rv_data 65536
