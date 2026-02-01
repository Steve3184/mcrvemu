scoreboard players operation #val1 rv_data = mip rv_data
scoreboard players set #val2 rv_data -129
function rv:alu/and
scoreboard players operation mip rv_data = #val rv_data
