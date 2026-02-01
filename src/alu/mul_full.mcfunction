
scoreboard players operation #orig_v1 rv_data = #val1 rv_data
scoreboard players operation #orig_v2 rv_data = #val2 rv_data

scoreboard players operation #a0 rv_data = #val1 rv_data
scoreboard players operation #a0 rv_data %= #c65536 rv_data
execute if score #a0 rv_data matches ..-1 run scoreboard players add #a0 rv_data 65536

scoreboard players operation #a1 rv_data = #val1 rv_data
scoreboard players operation #a1 rv_data /= #c65536 rv_data
execute if score #val1 rv_data matches ..-1 run scoreboard players add #a1 rv_data 65536

scoreboard players operation #b0 rv_data = #val2 rv_data
scoreboard players operation #b0 rv_data %= #c65536 rv_data
execute if score #b0 rv_data matches ..-1 run scoreboard players add #b0 rv_data 65536

scoreboard players operation #b1 rv_data = #val2 rv_data
scoreboard players operation #b1 rv_data /= #c65536 rv_data
execute if score #val2 rv_data matches ..-1 run scoreboard players add #b1 rv_data 65536

scoreboard players operation #p0_lo rv_data = #a0 rv_data
scoreboard players operation #p0_lo rv_data *= #b0 rv_data
scoreboard players operation #p0_hi rv_data = #p0_lo rv_data
scoreboard players operation #p0_lo rv_data %= #c65536 rv_data
execute if score #p0_lo rv_data matches ..-1 run scoreboard players add #p0_lo rv_data 65536
scoreboard players operation #p0_hi rv_data -= #p0_lo rv_data
scoreboard players operation #p0_hi rv_data /= #c65536 rv_data
execute if score #p0_hi rv_data matches ..-1 run scoreboard players add #p0_hi rv_data 65536

scoreboard players operation #p1_lo rv_data = #a0 rv_data
scoreboard players operation #p1_lo rv_data *= #b1 rv_data
scoreboard players operation #p1_hi rv_data = #p1_lo rv_data
scoreboard players operation #p1_lo rv_data %= #c65536 rv_data
execute if score #p1_lo rv_data matches ..-1 run scoreboard players add #p1_lo rv_data 65536
scoreboard players operation #p1_hi rv_data -= #p1_lo rv_data
scoreboard players operation #p1_hi rv_data /= #c65536 rv_data
execute if score #p1_hi rv_data matches ..-1 run scoreboard players add #p1_hi rv_data 65536

scoreboard players operation #p2_lo rv_data = #a1 rv_data
scoreboard players operation #p2_lo rv_data *= #b0 rv_data
scoreboard players operation #p2_hi rv_data = #p2_lo rv_data
scoreboard players operation #p2_lo rv_data %= #c65536 rv_data
execute if score #p2_lo rv_data matches ..-1 run scoreboard players add #p2_lo rv_data 65536
scoreboard players operation #p2_hi rv_data -= #p2_lo rv_data
scoreboard players operation #p2_hi rv_data /= #c65536 rv_data
execute if score #p2_hi rv_data matches ..-1 run scoreboard players add #p2_hi rv_data 65536

scoreboard players operation #p3_lo rv_data = #a1 rv_data
scoreboard players operation #p3_lo rv_data *= #b1 rv_data
scoreboard players operation #p3_hi rv_data = #p3_lo rv_data
scoreboard players operation #p3_lo rv_data %= #c65536 rv_data
execute if score #p3_lo rv_data matches ..-1 run scoreboard players add #p3_lo rv_data 65536
scoreboard players operation #p3_hi rv_data -= #p3_lo rv_data
scoreboard players operation #p3_hi rv_data /= #c65536 rv_data
execute if score #p3_hi rv_data matches ..-1 run scoreboard players add #p3_hi rv_data 65536

scoreboard players operation #blk0 rv_data = #p0_lo rv_data

scoreboard players operation #blk1 rv_data = #p0_hi rv_data
scoreboard players operation #blk1 rv_data += #p1_lo rv_data
scoreboard players operation #blk1 rv_data += #p2_lo rv_data

scoreboard players operation #c12 rv_data = #blk1 rv_data
scoreboard players operation #blk1 rv_data %= #c65536 rv_data
execute if score #blk1 rv_data matches ..-1 run scoreboard players add #blk1 rv_data 65536
scoreboard players operation #c12 rv_data -= #blk1 rv_data
scoreboard players operation #c12 rv_data /= #c65536 rv_data
execute if score #c12 rv_data matches ..-1 run scoreboard players add #c12 rv_data 65536

scoreboard players operation #blk2 rv_data = #c12 rv_data
scoreboard players operation #blk2 rv_data += #p1_hi rv_data
scoreboard players operation #blk2 rv_data += #p2_hi rv_data
scoreboard players operation #blk2 rv_data += #p3_lo rv_data

scoreboard players operation #c23 rv_data = #blk2 rv_data
scoreboard players operation #blk2 rv_data %= #c65536 rv_data
execute if score #blk2 rv_data matches ..-1 run scoreboard players add #blk2 rv_data 65536
scoreboard players operation #c23 rv_data -= #blk2 rv_data
scoreboard players operation #c23 rv_data /= #c65536 rv_data
execute if score #c23 rv_data matches ..-1 run scoreboard players add #c23 rv_data 65536

scoreboard players operation #blk3 rv_data = #c23 rv_data
scoreboard players operation #blk3 rv_data += #p3_hi rv_data
scoreboard players operation #blk3 rv_data %= #c65536 rv_data
execute if score #blk3 rv_data matches ..-1 run scoreboard players add #blk3 rv_data 65536

scoreboard players operation #lo rv_data = #blk1 rv_data
scoreboard players operation #lo rv_data *= #c65536 rv_data
scoreboard players operation #lo rv_data += #blk0 rv_data

scoreboard players operation #hi rv_data = #blk3 rv_data
scoreboard players operation #hi rv_data *= #c65536 rv_data
scoreboard players operation #hi rv_data += #blk2 rv_data

execute if score #signed1 rv_data matches 1 if score #orig_v1 rv_data matches ..-1 run scoreboard players operation #hi rv_data -= #orig_v2 rv_data
execute if score #signed2 rv_data matches 1 if score #orig_v2 rv_data matches ..-1 run scoreboard players operation #hi rv_data -= #orig_v1 rv_data