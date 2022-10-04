///@func array_3d_get(array_id,x,y,z)
///@param array_id desc
///@param x desc
///@param y desc
///@param z desc
var xi=round(argument1)
var yi=round(argument2)
var zi=round(argument3)
//show_message(ds_map_find_value(argument0,string(xi)+","+string(yi)+","+string(zi)))
return(ds_map_find_value(argument0,string(xi)+","+string(yi)+","+string(zi)))