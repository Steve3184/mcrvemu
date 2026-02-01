scoreboard players operation #byte_off rv_data = #align_check rv_data

scoreboard players operation #ram_addr rv_data = #addr rv_data
scoreboard players operation #ram_addr rv_data -= #byte_off rv_data
scoreboard players operation #ram_addr rv_data -= #c_msb rv_data

scoreboard players operation #page rv_data = #ram_addr rv_data
scoreboard players operation #page rv_data /= #c32768 rv_data
scoreboard players operation #local rv_data = #ram_addr rv_data
scoreboard players operation #local rv_data %= #c32768 rv_data
scoreboard players operation #word_idx rv_data = #local rv_data
scoreboard players operation #word_idx rv_data /= #c4 rv_data

execute store result storage rv:data fetch.page int 1 run scoreboard players get #page rv_data
execute store result storage rv:data fetch.local int 1 run scoreboard players get #word_idx rv_data
function rv:core/fetch_macro with storage rv:data fetch
scoreboard players operation #val rv_data = #inst rv_data

execute if score #width rv_data matches 1 run function rv:core/mem/load_ram_ext_byte
execute if score #width rv_data matches 5 run function rv:core/mem/load_ram_ext_byte
execute if score #width rv_data matches 1 run return 1
execute if score #width rv_data matches 5 run return 1

execute if score #width rv_data matches 2 run function rv:core/mem/load_ram_ext_half
execute if score #width rv_data matches 6 run function rv:core/mem/load_ram_ext_half
execute if score #width rv_data matches 2 run return 1
execute if score #width rv_data matches 6 run return 1

