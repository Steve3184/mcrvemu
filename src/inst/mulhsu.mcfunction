$execute if score #c0 rv_data matches $(rd) run return 0
$scoreboard players operation #val1 rv_data = x$(rs1) rv_data
$scoreboard players operation #val2 rv_data = x$(rs2) rv_data
scoreboard players set #signed1 rv_data 1
scoreboard players set #signed2 rv_data 0
function rv:alu/mul_full
$scoreboard players operation x$(rd) rv_data = #hi rv_data
