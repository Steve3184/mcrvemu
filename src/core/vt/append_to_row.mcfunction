$execute if score #char_val rv_data matches 39 run data modify storage rv:data uart.vt[$(idx)] append value "′"
$execute unless score #char_val rv_data matches 39 run data modify storage rv:data uart.vt[$(idx)] append from storage rv:data asciimap[$(charid)]
$execute store result score #line_len rv_data run data get storage rv:data uart.vt[$(idx)]
execute if score #line_len rv_data matches 80.. run function rv:core/vt/newline