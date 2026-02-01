scoreboard players set #offset rv_data 0
execute if score #val rv_data matches ..-1 run scoreboard players add #offset rv_data 1073741824
execute if score #val rv_data matches ..-1 run scoreboard players operation #val rv_data -= #c_msb rv_data
scoreboard players operation #val rv_data /= #c2 rv_data
scoreboard players operation #val rv_data += #offset rv_data
