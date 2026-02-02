scoreboard players operation #off rv_data = #addr rv_data
scoreboard players operation #off rv_data %= #c8 rv_data
execute if score #off rv_data matches ..-1 run scoreboard players add #off rv_data 8

execute if score #off rv_data matches 5 run scoreboard players set #val rv_data 96

execute if score #addr rv_data matches 268435460 if score #width rv_data matches 4 run scoreboard players set #val rv_data 24576
