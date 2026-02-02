$scoreboard players operation #addr rv_data = x$(rs1) rv_data

scoreboard players operation #addr rv_data /= #c512 rv_data
scoreboard players operation #addr rv_data *= #c512 rv_data

scoreboard players operation #offset rv_data = #addr rv_data
scoreboard players operation #offset rv_data -= #c_msb rv_data

scoreboard players operation #page rv_data = #offset rv_data
scoreboard players operation #page rv_data /= #c32768 rv_data

scoreboard players operation #base_idx rv_data = #offset rv_data
scoreboard players operation #base_idx rv_data %= #c32768 rv_data
scoreboard players operation #base_idx rv_data /= #c4 rv_data

function rv:core/mem/zero_block_128
