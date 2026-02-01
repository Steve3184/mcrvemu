scoreboard players operation #temp rv_data = mstatus rv_data
scoreboard players operation #temp rv_data /= #c8 rv_data
scoreboard players operation #temp rv_data %= #c2 rv_data
execute if score #temp rv_data matches 0 run scoreboard players add mstatus rv_data 8

scoreboard players set #trap rv_data -3
