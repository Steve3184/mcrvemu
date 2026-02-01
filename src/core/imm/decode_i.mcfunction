
scoreboard players operation #imm rv_data = #inst rv_data

scoreboard players set #offset rv_data 0
execute if score #imm rv_data matches ..-1 run scoreboard players add #offset rv_data 2048
execute if score #imm rv_data matches ..-1 run scoreboard players operation #imm rv_data -= #c_msb rv_data
scoreboard players operation #imm rv_data /= #c1048576 rv_data
scoreboard players operation #imm rv_data += #offset rv_data

execute if score #inst rv_data matches ..-1 run scoreboard players remove #imm rv_data 4096
