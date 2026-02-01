
scoreboard players operation #ua_addr rv_data = #addr rv_data
scoreboard players operation #ua_val rv_data = #val rv_data
scoreboard players operation #ua_width rv_data = #width rv_data

scoreboard players operation #tmp rv_data = #ua_val rv_data
scoreboard players set #msb rv_data 0
execute if score #tmp rv_data matches ..-1 run scoreboard players set #msb rv_data 1
execute if score #tmp rv_data matches ..-1 run scoreboard players operation #tmp rv_data -= #c_msb rv_data

scoreboard players operation #sv0 rv_data = #ua_val rv_data
scoreboard players operation #sv0 rv_data %= #c256 rv_data
execute if score #sv0 rv_data matches ..-1 run scoreboard players add #sv0 rv_data 256

scoreboard players operation #sv1 rv_data = #tmp rv_data
scoreboard players operation #sv1 rv_data /= #c256 rv_data
execute if score #msb rv_data matches 1 run scoreboard players add #sv1 rv_data 8388608
scoreboard players operation #sv1 rv_data %= #c256 rv_data

scoreboard players operation #sv2 rv_data = #tmp rv_data
scoreboard players operation #sv2 rv_data /= #c65536 rv_data
execute if score #msb rv_data matches 1 run scoreboard players add #sv2 rv_data 32768
scoreboard players operation #sv2 rv_data %= #c256 rv_data

scoreboard players operation #sv3 rv_data = #tmp rv_data
scoreboard players operation #sv3 rv_data /= #c16777216 rv_data
execute if score #msb rv_data matches 1 run scoreboard players add #sv3 rv_data 128
scoreboard players operation #sv3 rv_data %= #c256 rv_data

scoreboard players operation #addr rv_data = #ua_addr rv_data
scoreboard players operation #val rv_data = #sv0 rv_data
function rv:core/mem/store_byte

scoreboard players add #addr rv_data 1
scoreboard players operation #val rv_data = #sv1 rv_data
function rv:core/mem/store_byte

execute if score #ua_width rv_data matches 4 run scoreboard players add #addr rv_data 1
execute if score #ua_width rv_data matches 4 run scoreboard players operation #val rv_data = #sv2 rv_data
execute if score #ua_width rv_data matches 4 run function rv:core/mem/store_byte

execute if score #ua_width rv_data matches 4 run scoreboard players add #addr rv_data 1
execute if score #ua_width rv_data matches 4 run scoreboard players operation #val rv_data = #sv3 rv_data
execute if score #ua_width rv_data matches 4 run function rv:core/mem/store_byte

scoreboard players operation #addr rv_data = #ua_addr rv_data
scoreboard players operation #val rv_data = #ua_val rv_data
scoreboard players operation #width rv_data = #ua_width rv_data