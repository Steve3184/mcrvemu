
scoreboard players set #imm rv_data 0

scoreboard players set #temp rv_data 0
execute if score #inst rv_data matches ..-1 run scoreboard players set #temp rv_data 1
scoreboard players operation #temp rv_data *= #c1048576 rv_data
scoreboard players operation #imm rv_data += #temp rv_data

scoreboard players operation #temp rv_data = #inst rv_data
scoreboard players set #offset rv_data 0
execute if score #temp rv_data matches ..-1 run scoreboard players add #offset rv_data 524288
execute if score #temp rv_data matches ..-1 run scoreboard players operation #temp rv_data -= #c_msb rv_data
scoreboard players operation #temp rv_data /= #c4096 rv_data
scoreboard players operation #temp rv_data += #offset rv_data
scoreboard players operation #temp rv_data %= #c256 rv_data
scoreboard players operation #temp rv_data *= #c4096 rv_data
scoreboard players operation #imm rv_data += #temp rv_data

scoreboard players operation #temp rv_data = #inst rv_data
scoreboard players set #offset rv_data 0
execute if score #temp rv_data matches ..-1 run scoreboard players add #offset rv_data 2048
execute if score #temp rv_data matches ..-1 run scoreboard players operation #temp rv_data -= #c_msb rv_data
scoreboard players operation #temp rv_data /= #c1048576 rv_data
scoreboard players operation #temp rv_data += #offset rv_data
scoreboard players operation #temp rv_data %= #c2 rv_data
scoreboard players operation #temp rv_data *= #c2048 rv_data
scoreboard players operation #imm rv_data += #temp rv_data

scoreboard players operation #temp rv_data = #inst rv_data
scoreboard players set #offset rv_data 0
execute if score #temp rv_data matches ..-1 run scoreboard players add #offset rv_data 1024
execute if score #temp rv_data matches ..-1 run scoreboard players operation #temp rv_data -= #c_msb rv_data
scoreboard players operation #temp rv_data /= #c2097152 rv_data
scoreboard players operation #temp rv_data += #offset rv_data
scoreboard players operation #temp rv_data %= #c1024 rv_data
scoreboard players operation #temp rv_data *= #c2 rv_data
scoreboard players operation #imm rv_data += #temp rv_data

execute if score #imm rv_data matches 1048576.. run scoreboard players remove #imm rv_data 2097152