function rv:core/mem/pmp_check
execute if score #pmp_fail rv_data matches 1 run scoreboard players set #cause rv_data 7
execute if score #pmp_fail rv_data matches 1 run scoreboard players operation #tval rv_data = #addr rv_data
execute if score #pmp_fail rv_data matches 1 run function rv:core/trap
execute if score #pmp_fail rv_data matches 1 run return 0

scoreboard players operation #align_check rv_data = #addr rv_data
scoreboard players operation #align_check rv_data %= #c4 rv_data
execute if score #align_check rv_data matches ..-1 run scoreboard players add #align_check rv_data 4

scoreboard players set #misaligned rv_data 0
execute if score #width rv_data matches 4 unless score #align_check rv_data matches 0 run scoreboard players set #misaligned rv_data 1
execute if score #width rv_data matches 2 if score #align_check rv_data matches 1 run scoreboard players set #misaligned rv_data 1
execute if score #width rv_data matches 2 if score #align_check rv_data matches 3 run scoreboard players set #misaligned rv_data 1

execute if score #misaligned rv_data matches 1 run function rv:core/mem/store_ram_unaligned
execute if score #misaligned rv_data matches 1 run return 1

function rv:core/mem/store_ram_aligned