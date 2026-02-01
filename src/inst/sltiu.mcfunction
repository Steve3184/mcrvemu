$execute if score #c0 rv_data matches $(rd) run return 0
function rv:core/imm/decode_i
$scoreboard players operation #v1 rv_data = x$(rs1) rv_data
scoreboard players operation #v2 rv_data = #imm rv_data

scoreboard players operation #v1 rv_data += #c_msb rv_data
scoreboard players operation #v2 rv_data += #c_msb rv_data

$scoreboard players set x$(rd) rv_data 0
$execute if score #v1 rv_data < #v2 rv_data run scoreboard players set x$(rd) rv_data 1