scoreboard players operation #val1 rv_data = mstatus rv_data
scoreboard players set #val2 rv_data -129
function rv:alu/and
scoreboard players operation mstatus rv_data = #val rv_data
