$execute if score #c0 rv_data matches $(rd) run return 0
$scoreboard players operation #addr rv_data = x$(rs1) rv_data
scoreboard players set #width rv_data 4
function rv:core/mem/load
$scoreboard players operation x$(rd) rv_data = #val rv_data
$scoreboard players operation #res_addr rv_data = x$(rs1) rv_data
scoreboard players set #res_valid rv_data 1
