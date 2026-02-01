$scoreboard players operation #addr rv_data = x$(rs1) rv_data
scoreboard players set #width rv_data 4
function rv:core/mem/load
$scoreboard players operation #rs2_val rv_data = x$(rs2) rv_data
$execute unless score #c0 rv_data matches $(rd) run scoreboard players operation x$(rd) rv_data = #val rv_data
execute if score #rs2_val rv_data > #val rv_data run scoreboard players operation #val rv_data = #rs2_val rv_data
function rv:core/mem/store