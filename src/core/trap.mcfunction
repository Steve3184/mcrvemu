scoreboard players set #trap_occurred rv_data 1

scoreboard players operation mepc rv_data = #pc rv_data

scoreboard players operation mcause rv_data = #cause rv_data
scoreboard players operation mtval rv_data = #tval rv_data

scoreboard players set #mie_bit rv_data 0
scoreboard players operation #temp rv_data = mstatus rv_data
execute if score #temp rv_data matches ..-1 run scoreboard players operation #temp rv_data -= #c_msb rv_data
scoreboard players operation #temp rv_data /= #c8 rv_data
scoreboard players operation #temp rv_data %= #c2 rv_data
scoreboard players operation #mie_bit rv_data = #temp rv_data
execute if score #mie_bit rv_data matches 1 run function rv:core/utils/set_mpie
execute if score #mie_bit rv_data matches 0 run function rv:core/utils/clear_mpie
function rv:core/utils/clear_mie

scoreboard players operation #temp rv_data = mstatus rv_data
execute if score #temp rv_data matches ..-1 run scoreboard players operation #temp rv_data -= #c_msb rv_data
scoreboard players operation #temp rv_data /= #c2048 rv_data
scoreboard players operation #temp rv_data %= #c4 rv_data
scoreboard players operation #temp rv_data *= #c2048 rv_data
scoreboard players operation mstatus rv_data -= #temp rv_data
scoreboard players operation #temp rv_data = priv_mode rv_data
scoreboard players operation #temp rv_data *= #c2048 rv_data
scoreboard players operation mstatus rv_data += #temp rv_data

scoreboard players set priv_mode rv_data 3

scoreboard players operation #pc rv_data = mtvec rv_data
scoreboard players operation #pc rv_data /= #c4 rv_data
scoreboard players operation #pc rv_data *= #c4 rv_data

execute if score #cause rv_data matches 0.. run scoreboard players remove minstret rv_data 1
