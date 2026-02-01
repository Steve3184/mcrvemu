function rv:core/imm/decode_i
$scoreboard players operation #target rv_data = x$(rs1) rv_data
scoreboard players operation #target rv_data += #imm rv_data
scoreboard players operation #target rv_data /= #c2 rv_data
scoreboard players operation #target rv_data *= #c2 rv_data

function rv:core/utils/check_jump_target
execute if score #is_trap rv_data matches 1 run return 0

$execute unless score #c0 rv_data matches $(rd) run scoreboard players operation x$(rd) rv_data = #pc rv_data
$execute unless score #c0 rv_data matches $(rd) run scoreboard players add x$(rd) rv_data 4

scoreboard players operation #pc rv_data = #target rv_data
scoreboard players remove #pc rv_data 4
