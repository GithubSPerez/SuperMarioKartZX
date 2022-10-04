///@func array_3d_set(array_id,x,y,z,value)
///@param array_id desc
///@param x desc
///@param y desc
///@param z desc
///@param value desc
var xi=round(argument1)
var yi=round(argument2)
var zi=round(argument3)
var value=argument4
ds_map_replace(argument0,string(xi)+","+string(yi)+","+string(zi),value)