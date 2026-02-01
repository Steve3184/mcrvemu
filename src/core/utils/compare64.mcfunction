
scoreboard players set #result rv_data 0

scoreboard players operation #v1h_u rv_data = #v1h rv_data
execute if score #v1h_u rv_data matches ..-1 run scoreboard players operation #v1h_u rv_data -= #c_msb rv_data
execute unless score #v1h_u rv_data matches ..-1 run scoreboard players operation #v1h_u rv_data += #c_msb rv_data

scoreboard players operation #v2h_u rv_data = #v2h rv_data
execute if score #v2h_u rv_data matches ..-1 run scoreboard players operation #v2h_u rv_data -= #c_msb rv_data
execute unless score #v2h_u rv_data matches ..-1 run scoreboard players operation #v2h_u rv_data += #c_msb rv_data

execute if score #v1h_u rv_data > #v2h_u rv_data run scoreboard players set #result rv_data 1
execute if score #v1h_u rv_data > #v2h_u rv_data run return 1
execute if score #v1h_u rv_data < #v2h_u rv_data run return 0

scoreboard players operation #v1l_u rv_data = #v1l rv_data
execute if score #v1l_u rv_data matches ..-1 run scoreboard players operation #v1l_u rv_data -= #c_msb rv_data
execute unless score #v1l_u rv_data matches ..-1 run scoreboard players operation #v1l_u rv_data += #c_msb rv_data

scoreboard players operation #v2l_u rv_data = #v2l rv_data
execute if score #v2l_u rv_data matches ..-1 run scoreboard players operation #v2l_u rv_data -= #c_msb rv_data
execute unless score #v2l_u rv_data matches ..-1 run scoreboard players operation #v2l_u rv_data += #c_msb rv_data

execute if score #v1l_u rv_data >= #v2l_u rv_data run scoreboard players set #result rv_data 1