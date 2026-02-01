scoreboard players operation #t rv_data /= #cur_mask rv_data
scoreboard players operation #t rv_data %= #c2 rv_data
execute if score #t rv_data matches 1.. run scoreboard players add #rem rv_data 1
execute if score #t rv_data matches ..-1 run scoreboard players add #rem rv_data 1
