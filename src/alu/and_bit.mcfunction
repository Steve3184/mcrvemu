scoreboard players operation #t1 rv_data = #val1 rv_data
execute if score #t1 rv_data matches ..-1 run scoreboard players operation #t1 rv_data -= #c_msb rv_data
scoreboard players operation #t1 rv_data /= #m rv_data
scoreboard players operation #t1 rv_data %= #c2 rv_data

scoreboard players operation #t2 rv_data = #val2 rv_data
execute if score #t2 rv_data matches ..-1 run scoreboard players operation #t2 rv_data -= #c_msb rv_data
scoreboard players operation #t2 rv_data /= #m rv_data
scoreboard players operation #t2 rv_data %= #c2 rv_data

execute if score #t1 rv_data matches 1 if score #t2 rv_data matches 1 run scoreboard players operation #val rv_data += #m rv_data
