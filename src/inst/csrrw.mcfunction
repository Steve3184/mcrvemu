function rv:core/imm/decode_csr
$execute unless score #c0 rv_data matches $(rd) run function rv:core/csr/read with storage rv:data m

$execute unless score #c0 rv_data matches $(rd) run scoreboard players operation x$(rd) rv_data = #csr_val rv_data

$scoreboard players operation #csr_val rv_data = x$(rs1) rv_data
function rv:core/csr/write with storage rv:data m
