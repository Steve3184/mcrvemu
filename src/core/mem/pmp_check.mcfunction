
scoreboard players set #pmp_fail rv_data 1

scoreboard players operation #end_addr rv_data = #addr rv_data
execute if score #width rv_data matches 2 run scoreboard players add #end_addr rv_data 1
execute if score #width rv_data matches 6 run scoreboard players add #end_addr rv_data 1
execute if score #width rv_data matches 4 run scoreboard players add #end_addr rv_data 3

execute if score #addr rv_data matches ..-2113929216 if score #end_addr rv_data matches ..-2113929216 run scoreboard players set #pmp_fail rv_data 0

execute if score #addr rv_data matches 268435456..536870911 if score #end_addr rv_data matches 268435456..536870911 run scoreboard players set #pmp_fail rv_data 0