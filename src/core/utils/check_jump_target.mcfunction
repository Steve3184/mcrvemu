scoreboard players operation #align_check rv_data = #target rv_data
scoreboard players operation #align_check rv_data %= #c4 rv_data
execute if score #align_check rv_data matches ..-1 run scoreboard players add #align_check rv_data 4

scoreboard players set #is_trap rv_data 0
execute unless score #align_check rv_data matches 0 run scoreboard players set #cause rv_data 0
execute unless score #align_check rv_data matches 0 run scoreboard players operation #tval rv_data = #target rv_data
execute unless score #align_check rv_data matches 0 run function rv:core/trap
execute unless score #align_check rv_data matches 0 run scoreboard players set #is_trap rv_data 1
