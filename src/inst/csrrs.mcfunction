function rv:core/imm/decode_csr
$scoreboard players operation #val2 rv_data = x$(rs1) rv_data
function rv:core/csr/read with storage rv:data m

$execute unless score #c0 rv_data matches $(rd) run scoreboard players operation x$(rd) rv_data = #csr_val rv_data

$execute unless score #c0 rv_data matches $(rs1) run function rv:core/csr/do_rs
$execute unless score #c0 rv_data matches $(rs1) run function rv:core/csr/write with storage rv:data m