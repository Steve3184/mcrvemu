function rv:core/imm/decode_csr
function rv:core/csr/read with storage rv:data m
$execute unless score #c0 rv_data matches $(rd) run scoreboard players operation x$(rd) rv_data = #csr_val rv_data
$scoreboard players set #csr_val rv_data $(rs1)
function rv:core/csr/write with storage rv:data m
