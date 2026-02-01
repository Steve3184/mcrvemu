scoreboard players operation #pc rv_data = mepc rv_data

scoreboard players set #mpie_bit rv_data 0
scoreboard players operation #temp rv_data = mstatus rv_data
execute if score #temp rv_data matches ..-1 run scoreboard players operation #temp rv_data -= #c_msb rv_data
scoreboard players operation #temp rv_data /= #c128 rv_data
scoreboard players operation #temp rv_data %= #c2 rv_data
scoreboard players operation #mpie_bit rv_data = #temp rv_data

execute if score #mpie_bit rv_data matches 1 run function rv:core/utils/set_mie
execute if score #mpie_bit rv_data matches 0 run function rv:core/utils/clear_mie
function rv:core/utils/set_mpie

scoreboard players operation #temp rv_data = mstatus rv_data
execute if score #temp rv_data matches ..-1 run scoreboard players operation #temp rv_data -= #c_msb rv_data
scoreboard players operation #temp rv_data /= #c2048 rv_data
scoreboard players operation #temp rv_data %= #c4 rv_data
scoreboard players operation priv_mode rv_data = #temp rv_data

scoreboard players operation #temp rv_data *= #c2048 rv_data
scoreboard players operation mstatus rv_data -= #temp rv_data


scoreboard players remove #pc rv_data 4
