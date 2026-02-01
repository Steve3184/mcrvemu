$execute if score #c0 rv_data matches $(rd) run return 0
$scoreboard players operation #v1 rv_data = x$(rs1) rv_data
$scoreboard players operation #v2 rv_data = x$(rs2) rv_data

$execute if score #v2 rv_data matches 0 run scoreboard players operation x$(rd) rv_data = x$(rs1) rv_data
execute if score #v2 rv_data matches 0 run return 1

function rv:core/utils/divu
$scoreboard players operation x$(rd) rv_data = #rem rv_data
