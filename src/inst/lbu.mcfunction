$execute if score #c0 rv_data matches $(rd) run return 0
function rv:core/imm/decode_i
$scoreboard players operation #addr rv_data = x$(rs1) rv_data
scoreboard players operation #addr rv_data += #imm rv_data
scoreboard players set #width rv_data 5
function rv:core/mem/load
$scoreboard players operation x$(rd) rv_data = #val rv_data
