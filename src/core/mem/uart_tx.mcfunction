
execute if score #val rv_data matches 10 run return run function rv:core/mem/uart_flush with storage rv:data uart

execute store result storage rv:data uart.charid int 1 run scoreboard players get #val rv_data

function rv:core/mem/uart_append_char with storage rv:data uart