scoreboard players operation #val1 rv_data = mip rv_data
scoreboard players operation #val2 rv_data = mie rv_data
function rv:alu/and
scoreboard players operation #pending_ints rv_data = #val rv_data

scoreboard players operation #val1 rv_data = #pending_ints rv_data
scoreboard players set #val2 rv_data 128
function rv:alu/and

execute if score #val rv_data matches 128 run scoreboard players set #cause rv_data -2147483641
execute if score #val rv_data matches 128 run scoreboard players set #tval rv_data 0
execute if score #val rv_data matches 128 run return run function rv:core/trap

scoreboard players operation #val1 rv_data = #pending_ints rv_data
scoreboard players set #val2 rv_data 8
function rv:alu/and

execute if score #val rv_data matches 8 run scoreboard players set #cause rv_data -2147483645
execute if score #val rv_data matches 8 run scoreboard players set #tval rv_data 0
execute if score #val rv_data matches 8 run return run function rv:core/trap