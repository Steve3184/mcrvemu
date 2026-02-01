scoreboard players operation #rem rv_data *= #c2 rv_data

scoreboard players operation #t rv_data = #v1 rv_data
execute if score #cur_mask rv_data matches ..-1 if score #v1 rv_data matches ..-1 run scoreboard players add #rem rv_data 1
execute unless score #cur_mask rv_data matches ..-1 run function rv:core/utils/divu_check_bit

scoreboard players operation #r_u rv_data = #rem rv_data
scoreboard players operation #r_u rv_data += #c_msb rv_data
scoreboard players operation #v2_u rv_data = #v2 rv_data
scoreboard players operation #v2_u rv_data += #c_msb rv_data

execute if score #r_u rv_data >= #v2_u rv_data run scoreboard players operation #rem rv_data -= #v2 rv_data
execute if score #r_u rv_data >= #v2_u rv_data run scoreboard players operation #val rv_data += #cur_mask rv_data

scoreboard players operation #cur_mask rv_data /= #c2 rv_data
execute if score #cur_mask rv_data matches ..-1 run scoreboard players operation #cur_mask rv_data *= #c-1 rv_data

scoreboard players remove #count rv_data 1
execute if score #count rv_data matches 1.. run function rv:core/utils/divu_loop