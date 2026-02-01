$scoreboard players operation #addr rv_data = x$(rs1) rv_data
scoreboard players set #success rv_data 0
execute if score #res_valid rv_data matches 1 if score #addr rv_data = #res_addr rv_data run scoreboard players set #success rv_data 1

$execute if score #success rv_data matches 1 run scoreboard players operation #val rv_data = x$(rs2) rv_data
execute if score #success rv_data matches 1 run scoreboard players set #width rv_data 4
execute if score #success rv_data matches 1 run function rv:core/mem/store

$execute if score #success rv_data matches 1 run scoreboard players set x$(rd) rv_data 0
$execute if score #success rv_data matches 0 run scoreboard players set x$(rd) rv_data 1

scoreboard players set #res_valid rv_data 0