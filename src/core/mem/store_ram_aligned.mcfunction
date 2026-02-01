scoreboard players operation #byte_off rv_data = #align_check rv_data

execute if score #width rv_data matches 4 run scoreboard players operation #ram_addr rv_data = #addr rv_data
execute if score #width rv_data matches 4 run scoreboard players operation #ram_addr rv_data -= #c_msb rv_data
execute if score #width rv_data matches 4 run scoreboard players operation #page rv_data = #ram_addr rv_data
execute if score #width rv_data matches 4 run scoreboard players operation #page rv_data /= #c32768 rv_data
execute if score #width rv_data matches 4 run scoreboard players operation #local rv_data = #ram_addr rv_data
execute if score #width rv_data matches 4 run scoreboard players operation #local rv_data %= #c32768 rv_data
execute if score #width rv_data matches 4 run scoreboard players operation #word_idx rv_data = #local rv_data
execute if score #width rv_data matches 4 run scoreboard players operation #word_idx rv_data /= #c4 rv_data

execute if score #width rv_data matches 4 store result storage rv:data store.page int 1 run scoreboard players get #page rv_data
execute if score #width rv_data matches 4 store result storage rv:data store.local int 1 run scoreboard players get #word_idx rv_data
execute if score #width rv_data matches 4 store result storage rv:data store.val int 1 run scoreboard players get #val rv_data
execute if score #width rv_data matches 4 run function rv:core/mem/write_macro with storage rv:data store
execute if score #width rv_data matches 4 run return 1

execute if score #width rv_data matches 1 run function rv:core/mem/store_byte
execute if score #width rv_data matches 2 run function rv:core/mem/store_half