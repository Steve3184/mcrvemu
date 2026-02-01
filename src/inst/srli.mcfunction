$execute if score #c0 rv_data matches $(rd) run return 0
$scoreboard players operation #val rv_data = x$(rs1) rv_data
$scoreboard players set #shamt rv_data $(rs2)
function rv:alu/srl
$scoreboard players operation x$(rd) rv_data = #val rv_data
