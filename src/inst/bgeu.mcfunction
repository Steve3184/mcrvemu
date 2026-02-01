function rv:core/imm/decode_b
$scoreboard players operation #val1 rv_data = x$(rs1) rv_data
$scoreboard players operation #val2 rv_data = x$(rs2) rv_data
scoreboard players operation #v1_u rv_data = #val1 rv_data
scoreboard players operation #v1_u rv_data += #c_msb rv_data
scoreboard players operation #v2_u rv_data = #val2 rv_data
scoreboard players operation #v2_u rv_data += #c_msb rv_data
execute if score #v1_u rv_data >= #v2_u rv_data run scoreboard players operation #target rv_data = #pc rv_data
execute if score #v1_u rv_data >= #v2_u rv_data run scoreboard players operation #target rv_data += #imm rv_data
execute if score #v1_u rv_data >= #v2_u rv_data run function rv:core/utils/check_jump_target
execute if score #v1_u rv_data >= #v2_u rv_data if score #is_trap rv_data matches 1 run return 0
execute if score #v1_u rv_data >= #v2_u rv_data run scoreboard players operation #pc rv_data = #target rv_data
execute if score #v1_u rv_data >= #v2_u rv_data run scoreboard players remove #pc rv_data 4