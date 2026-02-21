execute if score #val rv_data matches 27 run scoreboard players set #is_ansi rv_data 1
execute if score #is_ansi rv_data matches 1 run return run function rv:core/mem/uart_tx_ansi

scoreboard players operation #char_val rv_data = #val rv_data
function rv:core/vt/put_char

execute if score #val rv_data matches 10 run return run function rv:core/mem/uart_flush with storage rv:data uart

execute store result storage rv:data uart.charid int 1 run scoreboard players get #val rv_data

function rv:core/mem/uart_append_char with storage rv:data uart