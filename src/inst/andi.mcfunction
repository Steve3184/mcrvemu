$execute if score #c0 rv_data matches $(rd) run return 0
function rv:core/imm/decode_i
$scoreboard players operation #val1 rv_data = x$(rs1) rv_data
scoreboard players operation #val2 rv_data = #imm rv_data
function rv:alu/and
$scoreboard players operation x$(rd) rv_data = #val rv_data
