$execute if score #c0 rv_data matches $(rd) run return 0
function rv:core/imm/decode_u
$scoreboard players operation x$(rd) rv_data = #imm rv_data
