scoreboard players operation #val1 rv_data = mstatus rv_data
scoreboard players set #val2 rv_data 128
function rv:alu/or
scoreboard players operation mstatus rv_data = #val rv_data
