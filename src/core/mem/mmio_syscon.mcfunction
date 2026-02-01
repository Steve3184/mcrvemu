execute if score #val rv_data matches 21845 run scoreboard players set #trap rv_data -2
execute if score #val rv_data matches 21845 run tellraw @a "SYSCON: Poweroff Signal Received."

execute if score #val rv_data matches 30583 run scoreboard players set #trap rv_data -4
execute if score #val rv_data matches 30583 run tellraw @a "SYSCON: Reset Signal Received."
