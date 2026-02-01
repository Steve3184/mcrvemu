scoreboard players set #csr_val rv_data 0
$scoreboard players set #csr_idx rv_data $(csr)

execute if score #csr_idx rv_data matches 768 run scoreboard players operation #csr_val rv_data = mstatus rv_data
execute if score #csr_idx rv_data matches 769 run scoreboard players operation #csr_val rv_data = misa rv_data
execute if score #csr_idx rv_data matches 772 run scoreboard players operation #csr_val rv_data = mie rv_data
execute if score #csr_idx rv_data matches 773 run scoreboard players operation #csr_val rv_data = mtvec rv_data
execute if score #csr_idx rv_data matches 832 run scoreboard players operation #csr_val rv_data = mscratch rv_data
execute if score #csr_idx rv_data matches 833 run scoreboard players operation #csr_val rv_data = mepc rv_data
execute if score #csr_idx rv_data matches 834 run scoreboard players operation #csr_val rv_data = mcause rv_data
execute if score #csr_idx rv_data matches 835 run scoreboard players operation #csr_val rv_data = mtval rv_data
execute if score #csr_idx rv_data matches 836 run scoreboard players operation #csr_val rv_data = mip rv_data

execute if score #csr_idx rv_data matches 2816 run scoreboard players operation #csr_val rv_data = mcycle rv_data
execute if score #csr_idx rv_data matches 2944 run scoreboard players operation #csr_val rv_data = mcycleh rv_data
execute if score #csr_idx rv_data matches 2818 run scoreboard players operation #csr_val rv_data = minstret rv_data
execute if score #csr_idx rv_data matches 2946 run scoreboard players operation #csr_val rv_data = minstreth rv_data

execute if score #csr_idx rv_data matches 3072 run scoreboard players operation #csr_val rv_data = mcycle rv_data
execute if score #csr_idx rv_data matches 3200 run scoreboard players operation #csr_val rv_data = mcycleh rv_data
execute if score #csr_idx rv_data matches 3074 run scoreboard players operation #csr_val rv_data = minstret rv_data
execute if score #csr_idx rv_data matches 3202 run scoreboard players operation #csr_val rv_data = minstreth rv_data

execute if score #csr_idx rv_data matches 3857 run scoreboard players set #csr_val rv_data -15732481
execute if score #csr_idx rv_data matches 3858 run scoreboard players set #csr_val rv_data 0
execute if score #csr_idx rv_data matches 3859 run scoreboard players set #csr_val rv_data 0
execute if score #csr_idx rv_data matches 3860 run scoreboard players set #csr_val rv_data 0
