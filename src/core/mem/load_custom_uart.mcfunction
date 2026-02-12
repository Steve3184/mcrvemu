scoreboard players set #val rv_data 0
execute store result score #buf_len rv_data run data get storage rv:data uart.rx_buf

execute if score #buf_len rv_data matches 1.. store result score #val rv_data run data get storage rv:data uart.rx_buf[0]
execute if score #buf_len rv_data matches 1.. run data remove storage rv:data uart.rx_buf[0]
