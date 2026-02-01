scoreboard players operation #val2 rv_data = #rc_imm rv_data

scoreboard players set #minus_one rv_data -1
scoreboard players operation #val2 rv_data *= #minus_one rv_data
scoreboard players remove #val2 rv_data 1

scoreboard players operation #val1 rv_data = #csr_val rv_data
function rv:alu/and
scoreboard players operation #csr_val rv_data = #val rv_data
