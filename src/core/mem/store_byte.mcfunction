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

scoreboard players operation #b0 rv_data = #w rv_data
scoreboard players operation #b0 rv_data %= #c256 rv_data
execute if score #b0 rv_data matches ..-1 run scoreboard players add #b0 rv_data 256

scoreboard players operation #b1 rv_data = #w_copy rv_data
scoreboard players operation #b1 rv_data /= #c256 rv_data
execute if score #msb rv_data matches 1 run scoreboard players add #b1 rv_data 8388608
scoreboard players operation #b1 rv_data %= #c256 rv_data

scoreboard players operation #b2 rv_data = #w_copy rv_data
scoreboard players operation #b2 rv_data /= #c65536 rv_data
execute if score #msb rv_data matches 1 run scoreboard players add #b2 rv_data 32768
scoreboard players operation #b2 rv_data %= #c256 rv_data

scoreboard players operation #b3 rv_data = #w_copy rv_data
scoreboard players operation #b3 rv_data /= #c16777216 rv_data
execute if score #msb rv_data matches 1 run scoreboard players add #b3 rv_data 128
scoreboard players operation #b3 rv_data %= #c256 rv_data

scoreboard players operation #new_b rv_data = #val rv_data
scoreboard players operation #new_b rv_data %= #c256 rv_data
execute if score #new_b rv_data matches ..-1 run scoreboard players add #new_b rv_data 256

execute if score #byte_off rv_data matches 0 run scoreboard players operation #b0 rv_data = #new_b rv_data
execute if score #byte_off rv_data matches 1 run scoreboard players operation #b1 rv_data = #new_b rv_data
execute if score #byte_off rv_data matches 2 run scoreboard players operation #b2 rv_data = #new_b rv_data
execute if score #byte_off rv_data matches 3 run scoreboard players operation #b3 rv_data = #new_b rv_data

scoreboard players operation #w rv_data = #b2 rv_data
scoreboard players operation #w rv_data *= #c65536 rv_data
scoreboard players operation #tmp rv_data = #b1 rv_data
scoreboard players operation #tmp rv_data *= #c256 rv_data
scoreboard players operation #w rv_data += #tmp rv_data
scoreboard players operation #w rv_data += #b0 rv_data

execute if score #b3 rv_data matches 128.. run scoreboard players operation #w rv_data += #c_msb rv_data
execute if score #b3 rv_data matches 128.. run scoreboard players operation #tmp rv_data = #b3 rv_data
execute if score #b3 rv_data matches 128.. run scoreboard players remove #tmp rv_data 128
execute if score #b3 rv_data matches 128.. run scoreboard players operation #tmp rv_data *= #c16777216 rv_data
execute if score #b3 rv_data matches 128.. run scoreboard players operation #w rv_data += #tmp rv_data

execute if score #b3 rv_data matches ..127 run scoreboard players operation #tmp rv_data = #b3 rv_data
execute if score #b3 rv_data matches ..127 run scoreboard players operation #tmp rv_data *= #c16777216 rv_data
execute if score #b3 rv_data matches ..127 run scoreboard players operation #w rv_data += #tmp rv_data

execute store result storage rv:data store.page int 1 run scoreboard players get #page rv_data
execute store result storage rv:data store.local int 1 run scoreboard players get #word_idx rv_data
execute store result storage rv:data store.val int 1 run scoreboard players get #w rv_data
function rv:core/mem/write_macro with storage rv:data store