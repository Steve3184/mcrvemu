scoreboard players set #cause rv_data 11
execute if score priv_mode rv_data matches 0 run scoreboard players set #cause rv_data 8
execute if score priv_mode rv_data matches 1 run scoreboard players set #cause rv_data 9
scoreboard players set #tval rv_data 0
function rv:core/trap
