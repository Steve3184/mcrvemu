
scoreboard players operation #ua_addr rv_data = #addr rv_data
scoreboard players operation #ua_width rv_data = #width rv_data

scoreboard players operation #addr rv_data = #ua_addr rv_data
function rv:core/mem/load_byte_raw
scoreboard players operation #r0 rv_data = #val rv_data

scoreboard players add #addr rv_data 1
function rv:core/mem/load_byte_raw
scoreboard players operation #r1 rv_data = #val rv_data

scoreboard players add #addr rv_data 1
function rv:core/mem/load_byte_raw
scoreboard players operation #r2 rv_data = #val rv_data

scoreboard players add #addr rv_data 1
function rv:core/mem/load_byte_raw
scoreboard players operation #r3 rv_data = #val rv_data

scoreboard players set #val rv_data 0
scoreboard players operation #val rv_data += #r0 rv_data
scoreboard players operation #t rv_data = #r1 rv_data
scoreboard players operation #t rv_data *= #c256 rv_data
scoreboard players operation #val rv_data += #t rv_data
scoreboard players operation #t rv_data = #r2 rv_data
scoreboard players operation #t rv_data *= #c65536 rv_data
scoreboard players operation #val rv_data += #t rv_data

execute if score #r3 rv_data matches 128.. run scoreboard players operation #val rv_data += #c_msb rv_data
execute if score #r3 rv_data matches 128.. run scoreboard players operation #t rv_data = #r3 rv_data
execute if score #r3 rv_data matches 128.. run scoreboard players remove #t rv_data 128
execute if score #r3 rv_data matches 128.. run scoreboard players operation #t rv_data *= #c16777216 rv_data
execute if score #r3 rv_data matches 128.. run scoreboard players operation #val rv_data += #t rv_data

execute if score #r3 rv_data matches ..127 run scoreboard players operation #t rv_data = #r3 rv_data
execute if score #r3 rv_data matches ..127 run scoreboard players operation #t rv_data *= #c16777216 rv_data
execute if score #r3 rv_data matches ..127 run scoreboard players operation #val rv_data += #t rv_data

scoreboard players operation #addr rv_data = #ua_addr rv_data
scoreboard players operation #width rv_data = #ua_width rv_data

execute if score #width rv_data matches 2 run function rv:core/mem/ext_half_signed
execute if score #width rv_data matches 6 run function rv:core/mem/ext_half_unsigned