$execute if score #c0 rv_data matches $(rd) run return 0
$scoreboard players operation #v1 rv_data = x$(rs1) rv_data
$scoreboard players operation #v2 rv_data = x$(rs2) rv_data

$execute if score #v2 rv_data matches 0 run scoreboard players set x$(rd) rv_data -1
execute if score #v2 rv_data matches 0 run return 1
$execute if score #v1 rv_data matches ..-2147483648 if score #v2 rv_data matches -1 run scoreboard players operation x$(rd) rv_data = #c_msb rv_data
execute if score #v1 rv_data matches ..-2147483648 if score #v2 rv_data matches -1 run return 1

scoreboard players set #s1 rv_data 0
execute if score #v1 rv_data matches ..-1 run scoreboard players set #s1 rv_data 1
execute if score #s1 rv_data matches 1 run scoreboard players operation #v1 rv_data *= #c-1 rv_data

scoreboard players set #s2 rv_data 0
execute if score #v2 rv_data matches ..-1 run scoreboard players set #s2 rv_data 1
execute if score #s2 rv_data matches 1 run scoreboard players operation #v2 rv_data *= #c-1 rv_data

scoreboard players operation #res_sign rv_data = #s1 rv_data
scoreboard players operation #res_sign rv_data += #s2 rv_data
scoreboard players operation #res_sign rv_data %= #c2 rv_data

function rv:core/utils/divu
$scoreboard players operation x$(rd) rv_data = #val rv_data
$execute if score #res_sign rv_data matches 1 run scoreboard players operation x$(rd) rv_data *= #c-1 rv_data