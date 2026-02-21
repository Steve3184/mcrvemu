data modify storage rv:data uart.input.temp_page set from entity @s Inventory[{Slot:-106b}].components."minecraft:writable_book_content".pages[0].raw
execute unless data storage rv:data uart.input.temp_page run return 0
execute if data storage rv:data uart.input{temp_page:""} run return 0
clear @s writable_book[custom_data={rv_keyboard:1b}] 1
item replace entity @s weapon.offhand with writable_book[custom_data={rv_keyboard:1b},item_name='{"text":"UART Keyboard","italic":false,"color":"gold"}',writable_book_content={pages:[]}]
data modify storage rv:data uart.input.input_buf set from storage rv:data uart.input.temp_page
function rv:input/parse_loop
data modify storage rv:data uart.input.temp_page set value ""