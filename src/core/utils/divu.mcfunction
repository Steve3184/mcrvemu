
scoreboard players set #val rv_data 0
scoreboard players set #rem rv_data 0
scoreboard players set #count rv_data 32

scoreboard players operation #cur_mask rv_data = #c_msb rv_data

function rv:core/utils/divu_loop
