if argument0!=clamp(argument0,0,global.xmaxland-1) or argument1!=clamp(argument1,0,global.ymaxland-1)
{
	return(0)
}
return(get_land(argument0,argument1))