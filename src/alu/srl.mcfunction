
scoreboard players operation #shamt rv_data %= #c32 rv_data

execute if score #shamt rv_data matches 16..31 run function rv:alu/do_srl_16
execute if score #shamt rv_data matches 16..31 run scoreboard players remove #shamt rv_data 16

execute if score #shamt rv_data matches 8..15 run function rv:alu/do_srl_8
execute if score #shamt rv_data matches 8..15 run scoreboard players remove #shamt rv_data 8

execute if score #shamt rv_data matches 4..7 run function rv:alu/do_srl_4
execute if score #shamt rv_data matches 4..7 run scoreboard players remove #shamt rv_data 4

execute if score #shamt rv_data matches 2..3 run function rv:alu/do_srl_2
execute if score #shamt rv_data matches 2..3 run scoreboard players remove #shamt rv_data 2

execute if score #shamt rv_data matches 1 run function rv:alu/do_srl_1
