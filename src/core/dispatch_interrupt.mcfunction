scoreboard players operation #val1 rv_data = mip rv_data
scoreboard players operation #val2 rv_data = mie rv_data
function rv:alu/and
scoreboard players operation #pending_ints rv_data = #val rv_data

scoreboard players operation #temp rv_data = #pending_ints rv_data
scoreboard players operation #temp rv_data /= #c128 rv_data
scoreboard players operation #temp rv_data %= #c2 rv_data

execute if score #temp rv_data matches 1 run scoreboard players set #cause rv_data -2147483641
execute if score #temp rv_data matches 1 run scoreboard players set #tval rv_data 0
execute if score #temp rv_data matches 1 run function rv:core/trap
