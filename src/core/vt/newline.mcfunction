scoreboard players add #vt_lptr rv_data 1
execute if score #vt_lptr rv_data matches 26.. run function rv:core/vt/scroll
execute if score #vt_lptr rv_data matches 26.. run scoreboard players set #vt_lptr rv_data 25
