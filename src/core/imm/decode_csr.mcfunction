scoreboard players operation #temp_csr rv_data = #inst rv_data

scoreboard players set #offset rv_data 0
execute if score #temp_csr rv_data matches ..-1 run scoreboard players add #offset rv_data 2048
execute if score #temp_csr rv_data matches ..-1 run scoreboard players operation #temp_csr rv_data -= #c_msb rv_data
scoreboard players operation #temp_csr rv_data /= #c1048576 rv_data
scoreboard players operation #temp_csr rv_data += #offset rv_data

scoreboard players operation #temp_csr rv_data %= #c4096 rv_data
execute store result storage rv:data m.csr int 1 run scoreboard players get #temp_csr rv_data
