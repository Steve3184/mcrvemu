$scoreboard players set #csr_idx rv_data $(csr)

execute if score #csr_idx rv_data matches 768 run scoreboard players operation mstatus rv_data = #csr_val rv_data
execute if score #csr_idx rv_data matches 772 run scoreboard players operation mie rv_data = #csr_val rv_data
execute if score #csr_idx rv_data matches 773 run scoreboard players operation mtvec rv_data = #csr_val rv_data
execute if score #csr_idx rv_data matches 832 run scoreboard players operation mscratch rv_data = #csr_val rv_data
execute if score #csr_idx rv_data matches 833 run scoreboard players operation mepc rv_data = #csr_val rv_data
execute if score #csr_idx rv_data matches 834 run scoreboard players operation mcause rv_data = #csr_val rv_data
execute if score #csr_idx rv_data matches 835 run scoreboard players operation mtval rv_data = #csr_val rv_data
execute if score #csr_idx rv_data matches 836 run scoreboard players operation mip rv_data = #csr_val rv_data

execute if score #csr_idx rv_data matches 2816 run scoreboard players operation mcycle rv_data = #csr_val rv_data
execute if score #csr_idx rv_data matches 2944 run scoreboard players operation mcycleh rv_data = #csr_val rv_data
execute if score #csr_idx rv_data matches 2818 run scoreboard players operation minstret rv_data = #csr_val rv_data
execute if score #csr_idx rv_data matches 2946 run scoreboard players operation minstreth rv_data = #csr_val rv_data
