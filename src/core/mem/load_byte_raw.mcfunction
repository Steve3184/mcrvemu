
scoreboard players operation #byte_off rv_data = #addr rv_data
scoreboard players operation #byte_off rv_data %= #c4 rv_data
execute if score #byte_off rv_data matches ..-1 run scoreboard players add #byte_off rv_data 4

scoreboard players operation #aligned_addr rv_data = #addr rv_data
scoreboard players operation #aligned_addr rv_data -= #byte_off rv_data

scoreboard players operation #saved_addr_raw rv_data = #addr rv_data
scoreboard players operation #addr rv_data = #aligned_addr rv_data

scoreboard players operation #ram_addr rv_data = #addr rv_data
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
scoreboard players operation #raw_v rv_data = #inst rv_data

scoreboard players set #msb rv_data 0
execute if score #raw_v rv_data matches ..-1 run scoreboard players set #msb rv_data 1
execute if score #raw_v rv_data matches ..-1 run scoreboard players operation #raw_v rv_data -= #c_msb rv_data

execute if score #byte_off rv_data matches 1 run scoreboard players operation #raw_v rv_data /= #c256 rv_data
execute if score #byte_off rv_data matches 1 if score #msb rv_data matches 1 run scoreboard players add #raw_v rv_data 8388608

execute if score #byte_off rv_data matches 2 run scoreboard players operation #raw_v rv_data /= #c65536 rv_data
execute if score #byte_off rv_data matches 2 if score #msb rv_data matches 1 run scoreboard players add #raw_v rv_data 32768

execute if score #byte_off rv_data matches 3 run scoreboard players operation #raw_v rv_data /= #c16777216 rv_data
execute if score #byte_off rv_data matches 3 if score #msb rv_data matches 1 run scoreboard players add #raw_v rv_data 128

scoreboard players operation #raw_v rv_data %= #c256 rv_data
execute if score #raw_v rv_data matches ..-1 run scoreboard players add #raw_v rv_data 256
scoreboard players operation #val rv_data = #raw_v rv_data

scoreboard players operation #addr rv_data = #saved_addr_raw rv_data
