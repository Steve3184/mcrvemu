scoreboard players operation #off rv_data = #addr rv_data
scoreboard players operation #off rv_data %= #c8 rv_data
execute if score #off rv_data matches ..-1 run scoreboard players add #off rv_data 8

execute store result score #buf_len rv_data run data get storage rv:data uart.rx_buf
execute if score #off rv_data matches 0 if score #buf_len rv_data matches 1.. store result score #val rv_data run data get storage rv:data uart.rx_buf[0]
execute if score #off rv_data matches 0 if score #buf_len rv_data matches 1.. run data remove storage rv:data uart.rx_buf[0]
execute if score #off rv_data matches 5 run scoreboard players set #val rv_data 96
execute if score #off rv_data matches 5 if score #buf_len rv_data matches 1.. run scoreboard players add #val rv_data 1

execute if score #addr rv_data matches 268435456 if score #width rv_data matches 4 if score #buf_len rv_data matches 1.. store result score #val rv_data run data get storage rv:data uart.rx_buf[0]
execute if score #addr rv_data matches 268435456 if score #width rv_data matches 4 if score #buf_len rv_data matches 1.. run data remove storage rv:data uart.rx_buf[0]
execute if score #addr rv_data matches 268435460 if score #width rv_data matches 4 run scoreboard players set #val rv_data 24576
execute if score #addr rv_data matches 268435460 if score #width rv_data matches 4 if score #buf_len rv_data matches 1.. run scoreboard players add #val rv_data 256
