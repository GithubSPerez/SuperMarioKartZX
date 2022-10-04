trophies=0
gtrophies=0
gtrophies100=0
gtrophies150=0
for (var i=0;i<3;i++)
{
	for (var j=0;j<4;j++)
	{
		if global.cup_won[i,j]!=0
		trophies++
		
		if global.cup_won[i,j]=1
		{
			gtrophies++
			if i=1
			{
				gtrophies100++
			}
			if i=2
			{
				gtrophies150++
			}
		}
	}
}
global.special_lock=(trophies<6 and gtrophies100<3)
global.class_lock=(trophies<7 and gtrophies100<4)
global.super_lock=(trophies<11 and gtrophies100+gtrophies150<8)

resizing=window_get_width()!=lsw or window_get_height()!=lsh
/*
if resizing
{
	global.screen_scale=ceil(window_get_height()/global.screen_h)
	global.screen_w=window_get_width()/global.screen_scale
	global.screen_h=window_get_height()/global.screen_scale
	
	var scale=1
	surface_resize(application_surface,window_get_width()/scale,window_get_height()/scale)
}
*/
lsw=window_get_width()
lsh=window_get_height()