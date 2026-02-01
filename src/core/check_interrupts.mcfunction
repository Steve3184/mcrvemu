scoreboard players operation #v1l rv_data = mtime rv_data
scoreboard players operation #v1h rv_data = mtimeh rv_data
scoreboard players operation #v2l rv_data = mtimecmp rv_data
scoreboard players operation #v2h rv_data = mtimecmph rv_data
function rv:core/utils/compare64

execute if score #result rv_data matches 1 run function rv:core/utils/set_mtip
execute if score #result rv_data matches 1 if score #trap rv_data matches -3 run scoreboard players set #trap rv_data -1
execute if score #result rv_data matches 0 run function rv:core/utils/clear_mtip