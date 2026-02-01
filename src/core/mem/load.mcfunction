
execute if score #addr rv_data matches 268435456..536870911 run function rv:core/mem/load_mmio
execute if score #addr rv_data matches 268435456..536870911 run return 1

execute if score #addr rv_data matches ..-2113929216 run function rv:core/mem/load_ram
execute if score #addr rv_data matches ..-2113929216 run return 1

scoreboard players set #cause rv_data 5
scoreboard players operation #tval rv_data = #addr rv_data
function rv:core/trap