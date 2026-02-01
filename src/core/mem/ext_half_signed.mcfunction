scoreboard players operation #val rv_data %= #c65536 rv_data
execute if score #val rv_data matches ..-1 run scoreboard players add #val rv_data 65536
execute if score #val rv_data matches 32768.. run scoreboard players remove #val rv_data 65536
