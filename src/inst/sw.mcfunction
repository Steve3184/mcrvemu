function rv:core/imm/decode_s
$scoreboard players operation #addr rv_data = x$(rs1) rv_data
scoreboard players operation #addr rv_data += #imm rv_data
$scoreboard players operation #val rv_data = x$(rs2) rv_data
scoreboard players set #width rv_data 4
function rv:core/mem/store
