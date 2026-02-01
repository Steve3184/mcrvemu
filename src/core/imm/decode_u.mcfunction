
scoreboard players operation #imm rv_data = #inst rv_data

scoreboard players set #offset rv_data 0
execute if score #imm rv_data matches ..-1 run scoreboard players add #offset rv_data 524288
execute if score #imm rv_data matches ..-1 run scoreboard players operation #imm rv_data -= #c_msb rv_data
scoreboard players operation #imm rv_data /= #c4096 rv_data
scoreboard players operation #imm rv_data += #offset rv_data

scoreboard players operation #imm rv_data *= #c4096 rv_data
