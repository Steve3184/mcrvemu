function rv:core/imm/decode_b
$scoreboard players operation #val1 rv_data = x$(rs1) rv_data
$scoreboard players operation #val2 rv_data = x$(rs2) rv_data
execute if score #val1 rv_data = #val2 rv_data run scoreboard players operation #target rv_data = #pc rv_data
execute if score #val1 rv_data = #val2 rv_data run scoreboard players operation #target rv_data += #imm rv_data
execute if score #val1 rv_data = #val2 rv_data run function rv:core/utils/check_jump_target
execute if score #val1 rv_data = #val2 rv_data if score #is_trap rv_data matches 1 run return 0
execute if score #val1 rv_data = #val2 rv_data run scoreboard players operation #pc rv_data = #target rv_data
execute if score #val1 rv_data = #val2 rv_data run scoreboard players remove #pc rv_data 4