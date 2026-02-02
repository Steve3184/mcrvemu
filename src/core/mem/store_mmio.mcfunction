
execute if score #addr rv_data matches 286261248 run function rv:core/mem/mmio_syscon
execute if score #addr rv_data matches 286261248 unless score #trap rv_data matches -1 run scoreboard players set #trap_occurred rv_data 1

execute if score #addr rv_data matches 285212672 if score #val rv_data matches 1 run scoreboard players operation #val1 rv_data = mip rv_data
execute if score #addr rv_data matches 285212672 if score #val rv_data matches 1 run scoreboard players set #val2 rv_data 8
execute if score #addr rv_data matches 285212672 if score #val rv_data matches 1 run function rv:alu/or
execute if score #addr rv_data matches 285212672 if score #val rv_data matches 1 run scoreboard players operation mip rv_data = #val rv_data

execute if score #addr rv_data matches 285212672 if score #val rv_data matches 0 run scoreboard players operation #val1 rv_data = mip rv_data
execute if score #addr rv_data matches 285212672 if score #val rv_data matches 0 run scoreboard players set #val2 rv_data -9
execute if score #addr rv_data matches 285212672 if score #val rv_data matches 0 run function rv:alu/and
execute if score #addr rv_data matches 285212672 if score #val rv_data matches 0 run scoreboard players operation mip rv_data = #val rv_data

execute if score #addr rv_data matches 285229056 run scoreboard players operation mtimecmp rv_data = #val rv_data
execute if score #addr rv_data matches 285229060 run scoreboard players operation mtimecmph rv_data = #val rv_data

execute if score #addr rv_data matches 285261816 run scoreboard players operation mtime rv_data = #val rv_data
execute if score #addr rv_data matches 285261820 run scoreboard players operation mtimeh rv_data = #val rv_data

execute if score #addr rv_data matches 285229056..285261823 run function rv:core/check_interrupts

execute if score #addr rv_data matches 268435456..268435463 run function rv:core/mem/store_uart
