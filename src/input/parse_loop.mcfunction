execute store result score #len rv_data run data get storage rv:data uart.input.input_buf
execute if score #len rv_data matches 0 run return 0
data modify storage rv:data uart.input.char_str set string storage rv:data uart.input.input_buf 0 1
data modify storage rv:data uart.input.input_buf set string storage rv:data uart.input.input_buf 1
function rv:input/char_to_int
data modify storage rv:data uart.rx_buf append from storage rv:data uart.input.char_val
function rv:input/parse_loop