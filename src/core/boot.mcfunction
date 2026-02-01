scoreboard objectives add rv_data dummy

function rv:core/init_constants

function rv:core/init_ascii

function rv:core/init_ram

function rv:core/load_bin

scoreboard players set x10 rv_data 0
scoreboard players set x11 rv_data -2113961984

scoreboard players operation #pc rv_data = #c_msb rv_data

scoreboard players set #trap rv_data -1

data remove storage rv:data m
data modify storage rv:data m set value {op:0, f3:0, f7:0, rs1:0, rs2:0, rd:0}

data remove storage rv:data uart
data modify storage rv:data uart set value {buf: [], charid: 0}

tellraw @a "MCRVEmu Initialized."
