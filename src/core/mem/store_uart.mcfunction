scoreboard players operation #off rv_data = #addr rv_data
scoreboard players operation #off rv_data %= #c8 rv_data
execute if score #off rv_data matches ..-1 run scoreboard players add #off rv_data 8

execute if score #off rv_data matches 0 run function rv:core/mem/uart_tx
