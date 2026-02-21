execute if score #char_val rv_data matches 10 run return run function rv:core/vt/newline

scoreboard players operation #vt_idx rv_data = #vt_lptr rv_data
scoreboard players operation #vt_idx rv_data *= #c2 rv_data
scoreboard players remove #vt_idx rv_data 1

execute store result storage rv:data vt_tmp.idx int 1 run scoreboard players get #vt_idx rv_data
execute store result storage rv:data vt_tmp.charid int 1 run scoreboard players get #char_val rv_data

function rv:core/vt/append_to_row with storage rv:data vt_tmp
