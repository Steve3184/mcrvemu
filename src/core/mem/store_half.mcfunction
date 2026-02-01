scoreboard players operation #byte_off rv_data = #addr rv_data
scoreboard players operation #byte_off rv_data %= #c4 rv_data
execute if score #byte_off rv_data matches ..-1 run scoreboard players add #byte_off rv_data 4
scoreboard players operation #aligned_addr rv_data = #addr rv_data
scoreboard players operation #aligned_addr rv_data -= #byte_off rv_data

scoreboard players operation #ram_addr rv_data = #aligned_addr rv_data
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
scoreboard players operation #w rv_data = #inst rv_data

scoreboard players operation #w_copy rv_data = #w rv_data
scoreboard players set #msb rv_data 0
execute if score #w_copy rv_data matches ..-1 run scoreboard players set #msb rv_data 1
execute if score #w_copy rv_data matches ..-1 run scoreboard players operation #w_copy rv_data -= #c_msb rv_data

scoreboard players operation #h0 rv_data = #w rv_data
scoreboard players operation #h0 rv_data %= #c65536 rv_data
execute if score #h0 rv_data matches ..-1 run scoreboard players add #h0 rv_data 65536

scoreboard players operation #h1 rv_data = #w_copy rv_data
scoreboard players operation #h1 rv_data /= #c65536 rv_data
execute if score #msb rv_data matches 1 run scoreboard players add #h1 rv_data 32768
scoreboard players operation #h1 rv_data %= #c65536 rv_data

scoreboard players operation #new_h rv_data = #val rv_data
scoreboard players operation #new_h rv_data %= #c65536 rv_data
execute if score #new_h rv_data matches ..-1 run scoreboard players add #new_h rv_data 65536

execute if score #byte_off rv_data matches 0 run scoreboard players operation #h0 rv_data = #new_h rv_data
execute if score #byte_off rv_data matches 2 run scoreboard players operation #h1 rv_data = #new_h rv_data

scoreboard players operation #w rv_data = #h0 rv_data

execute if score #h1 rv_data matches 32768.. run scoreboard players operation #w rv_data += #c_msb rv_data
execute if score #h1 rv_data matches 32768.. run scoreboard players operation #tmp rv_data = #h1 rv_data
execute if score #h1 rv_data matches 32768.. run scoreboard players remove #tmp rv_data 32768
execute if score #h1 rv_data matches 32768.. run scoreboard players operation #tmp rv_data *= #c65536 rv_data
execute if score #h1 rv_data matches 32768.. run scoreboard players operation #w rv_data += #tmp rv_data

execute if score #h1 rv_data matches ..32767 run scoreboard players operation #tmp rv_data = #h1 rv_data
execute if score #h1 rv_data matches ..32767 run scoreboard players operation #tmp rv_data *= #c65536 rv_data
execute if score #h1 rv_data matches ..32767 run scoreboard players operation #w rv_data += #tmp rv_data

execute store result storage rv:data store.page int 1 run scoreboard players get #page rv_data
execute store result storage rv:data store.local int 1 run scoreboard players get #word_idx rv_data
execute store result storage rv:data store.val int 1 run scoreboard players get #w rv_data
function rv:core/mem/write_macro with storage rv:data store