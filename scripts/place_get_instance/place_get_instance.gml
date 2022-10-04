///@func place_get_instance()
///@param place "
with obj_player
{
	if place=clamp(argument0,1,global.drivers)
	{
		return(id)
	}
}
return(id)