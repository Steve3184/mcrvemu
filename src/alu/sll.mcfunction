scoreboard players operation #shamt rv_data %= #c32 rv_data
execute if score #shamt rv_data matches ..-1 run scoreboard players add #shamt rv_data 32

execute if score #shamt rv_data matches 16.. run scoreboard players operation #val rv_data *= #c65536 rv_data
execute if score #shamt rv_data matches 16.. run scoreboard players remove #shamt rv_data 16

execute if score #shamt rv_data matches 8.. run scoreboard players operation #val rv_data *= #c256 rv_data
execute if score #shamt rv_data matches 8.. run scoreboard players remove #shamt rv_data 8

execute if score #shamt rv_data matches 4.. run scoreboard players operation #val rv_data *= #c16 rv_data
execute if score #shamt rv_data matches 4.. run scoreboard players remove #shamt rv_data 4

execute if score #shamt rv_data matches 2.. run scoreboard players operation #val rv_data *= #c4 rv_data
execute if score #shamt rv_data matches 2.. run scoreboard players remove #shamt rv_data 2

execute if score #shamt rv_data matches 1.. run scoreboard players operation #val rv_data *= #c2 rv_data