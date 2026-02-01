scoreboard players operation #pc_align rv_data = #pc rv_data
scoreboard players operation #pc_align rv_data %= #c4 rv_data
execute if score #pc_align rv_data matches ..-1 run scoreboard players add #pc_align rv_data 4

execute unless score #pc_align rv_data matches 0 run scoreboard players set #cause rv_data 0
execute unless score #pc_align rv_data matches 0 run scoreboard players operation #tval rv_data = #pc rv_data
execute unless score #pc_align rv_data matches 0 run function rv:core/trap
execute unless score #pc_align rv_data matches 0 run return 0

scoreboard players set #trap_occurred rv_data 0
scoreboard players add mcycle rv_data 1
execute if score mcycle rv_data matches ..-1 run scoreboard players add mcycleh rv_data 1

scoreboard players operation #pc_at_start rv_data = #pc rv_data

scoreboard players operation #addr rv_data = #pc rv_data
scoreboard players operation #addr rv_data -= #c_msb rv_data
scoreboard players operation #word_idx rv_data = #addr rv_data
scoreboard players operation #word_idx rv_data /= #c4 rv_data
scoreboard players operation #page rv_data = #word_idx rv_data
scoreboard players operation #page rv_data /= #c8192 rv_data
scoreboard players operation #local rv_data = #word_idx rv_data
scoreboard players operation #local rv_data %= #c8192 rv_data
execute store result storage rv:data fetch.page int 1 run scoreboard players get #page rv_data
execute store result storage rv:data fetch.local int 1 run scoreboard players get #local rv_data
function rv:core/fetch_macro with storage rv:data fetch

function rv:core/decode
function rv:core/execute_inst with storage rv:data m

execute if score #trap_occurred rv_data matches 0 run scoreboard players add #pc rv_data 4
execute if score #trap_occurred rv_data matches 0 run scoreboard players add minstret rv_data 1
execute if score #trap_occurred rv_data matches 0 if score minstret rv_data matches ..-1 run scoreboard players add minstreth rv_data 1

scoreboard players set x0 rv_data 0
