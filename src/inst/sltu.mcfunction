$execute if score #c0 rv_data matches $(rd) run return 0
$scoreboard players operation #val1 rv_data = x$(rs1) rv_data
$scoreboard players operation #val2 rv_data = x$(rs2) rv_data

scoreboard players operation #val1 rv_data += #c_msb rv_data
scoreboard players operation #val2 rv_data += #c_msb rv_data

$scoreboard players set x$(rd) rv_data 0
$execute if score #val1 rv_data < #val2 rv_data run scoreboard players set x$(rd) rv_data 1
