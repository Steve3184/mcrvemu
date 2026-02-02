
scoreboard players set #val rv_data 0

execute if score #addr rv_data matches 268435456..268435463 run function rv:core/mem/load_uart

execute if score #addr rv_data matches 285212672 run scoreboard players operation #val rv_data = mip rv_data
execute if score #addr rv_data matches 285212672 run scoreboard players operation #val rv_data /= #c8 rv_data
execute if score #addr rv_data matches 285212672 run scoreboard players operation #val rv_data %= #c2 rv_data

execute if score #addr rv_data matches 285229056 run scoreboard players operation #val rv_data = mtimecmp rv_data
execute if score #addr rv_data matches 285229060 run scoreboard players operation #val rv_data = mtimecmph rv_data
execute if score #addr rv_data matches 285261816 run scoreboard players operation #val rv_data = mtime rv_data
execute if score #addr rv_data matches 285261820 run scoreboard players operation #val rv_data = mtimeh rv_data
