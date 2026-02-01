
scoreboard players set #imm rv_data 0

scoreboard players operation #temp rv_data = #inst rv_data
scoreboard players set #offset rv_data 0
execute if score #temp rv_data matches ..-1 run scoreboard players add #offset rv_data 64
execute if score #temp rv_data matches ..-1 run scoreboard players operation #temp rv_data -= #c_msb rv_data
scoreboard players operation #temp rv_data /= #c33554432 rv_data
scoreboard players operation #temp rv_data += #offset rv_data
scoreboard players operation #temp rv_data %= #c128 rv_data
scoreboard players operation #temp rv_data *= #c32 rv_data
scoreboard players operation #imm rv_data += #temp rv_data

scoreboard players operation #temp rv_data = #inst rv_data
scoreboard players set #offset rv_data 0
execute if score #temp rv_data matches ..-1 run scoreboard players add #offset rv_data 16777216
execute if score #temp rv_data matches ..-1 run scoreboard players operation #temp rv_data -= #c_msb rv_data
scoreboard players operation #temp rv_data /= #c128 rv_data
scoreboard players operation #temp rv_data += #offset rv_data
scoreboard players operation #temp rv_data %= #c32 rv_data
scoreboard players operation #imm rv_data += #temp rv_data

execute if score #imm rv_data matches 2048.. run scoreboard players remove #imm rv_data 4096
