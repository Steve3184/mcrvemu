
data modify storage rv:data m set value {op:0, f3:0, f7:0, rs1:0, rs2:0, rd:0}

scoreboard players operation #op rv_data = #inst rv_data
scoreboard players operation #op rv_data %= #c128 rv_data
execute if score #op rv_data matches ..-1 run scoreboard players add #op rv_data 128
execute store result storage rv:data m.op int 1 run scoreboard players get #op rv_data

scoreboard players operation #temp rv_data = #inst rv_data
scoreboard players set #offset rv_data 0
execute if score #temp rv_data matches ..-1 run scoreboard players add #offset rv_data 16777216
execute if score #temp rv_data matches ..-1 run scoreboard players operation #temp rv_data -= #c_msb rv_data
scoreboard players operation #temp rv_data /= #c128 rv_data
scoreboard players operation #temp rv_data += #offset rv_data
scoreboard players operation #temp rv_data %= #c32 rv_data
execute store result storage rv:data m.rd int 1 run scoreboard players get #temp rv_data

scoreboard players operation #temp rv_data = #inst rv_data
scoreboard players set #offset rv_data 0
execute if score #temp rv_data matches ..-1 run scoreboard players add #offset rv_data 524288
execute if score #temp rv_data matches ..-1 run scoreboard players operation #temp rv_data -= #c_msb rv_data
scoreboard players operation #temp rv_data /= #c4096 rv_data
scoreboard players operation #temp rv_data += #offset rv_data
scoreboard players operation #temp rv_data %= #c8 rv_data
scoreboard players operation #f3 rv_data = #temp rv_data

scoreboard players operation #temp rv_data = #inst rv_data
scoreboard players set #offset rv_data 0
execute if score #temp rv_data matches ..-1 run scoreboard players add #offset rv_data 65536
execute if score #temp rv_data matches ..-1 run scoreboard players operation #temp rv_data -= #c_msb rv_data
scoreboard players operation #temp rv_data /= #c32768 rv_data
scoreboard players operation #temp rv_data += #offset rv_data
scoreboard players operation #temp rv_data %= #c32 rv_data
execute store result storage rv:data m.rs1 int 1 run scoreboard players get #temp rv_data

scoreboard players operation #temp rv_data = #inst rv_data
scoreboard players set #offset rv_data 0
execute if score #temp rv_data matches ..-1 run scoreboard players add #offset rv_data 2048
execute if score #temp rv_data matches ..-1 run scoreboard players operation #temp rv_data -= #c_msb rv_data
scoreboard players operation #temp rv_data /= #c1048576 rv_data
scoreboard players operation #temp rv_data += #offset rv_data
scoreboard players operation #temp_rs2 rv_data = #temp rv_data
scoreboard players operation #temp_rs2 rv_data %= #c32 rv_data
execute store result storage rv:data m.rs2 int 1 run scoreboard players get #temp_rs2 rv_data

scoreboard players operation #temp rv_data = #inst rv_data
scoreboard players set #offset rv_data 0
execute if score #temp rv_data matches ..-1 run scoreboard players add #offset rv_data 64
execute if score #temp rv_data matches ..-1 run scoreboard players operation #temp rv_data -= #c_msb rv_data
scoreboard players operation #temp rv_data /= #c33554432 rv_data
scoreboard players operation #temp rv_data += #offset rv_data
scoreboard players operation #temp rv_data %= #c128 rv_data
scoreboard players operation #f7 rv_data = #temp rv_data

scoreboard players set #mask_f3 rv_data 1
scoreboard players set #mask_f7 rv_data 1

execute if score #op rv_data matches 55 run scoreboard players set #mask_f3 rv_data 0
execute if score #op rv_data matches 23 run scoreboard players set #mask_f3 rv_data 0
execute if score #op rv_data matches 111 run scoreboard players set #mask_f3 rv_data 0
execute if score #mask_f3 rv_data matches 0 run scoreboard players set #mask_f7 rv_data 0

execute if score #op rv_data matches 99 run scoreboard players set #mask_f7 rv_data 0
execute if score #op rv_data matches 3 run scoreboard players set #mask_f7 rv_data 0
execute if score #op rv_data matches 35 run scoreboard players set #mask_f7 rv_data 0
execute if score #op rv_data matches 103 run scoreboard players set #mask_f7 rv_data 0
execute if score #op rv_data matches 15 run scoreboard players set #mask_f7 rv_data 0

execute if score #op rv_data matches 47 run scoreboard players operation #f7 rv_data /= #c4 rv_data

execute if score #op rv_data matches 115 unless score #f3 rv_data matches 0 run scoreboard players set #mask_f7 rv_data 0

execute if score #op rv_data matches 19 unless score #f3 rv_data matches 1 unless score #f3 rv_data matches 5 run scoreboard players set #mask_f7 rv_data 0

execute if score #mask_f3 rv_data matches 0 run scoreboard players set #f3 rv_data 0
execute if score #mask_f7 rv_data matches 0 run scoreboard players set #f7 rv_data 0

execute if score #op rv_data matches 115 if score #f3 rv_data matches 0 run scoreboard players operation #f7 rv_data *= #c32 rv_data
execute if score #op rv_data matches 115 if score #f3 rv_data matches 0 run scoreboard players operation #f7 rv_data += #temp_rs2 rv_data

execute store result storage rv:data m.f3 int 1 run scoreboard players get #f3 rv_data
execute store result storage rv:data m.f7 int 1 run scoreboard players get #f7 rv_data