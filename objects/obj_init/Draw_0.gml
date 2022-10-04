if !done
{
	surface_set_target(sur)
	for (var s=0;s<sprite_get_number(spr_bg_fill);s++)
	{
		for (var i=0;i<128;i++)
		{
			for (var j=0;j<128;j++)
			{
				draw_sprite(spr_bg_fill,s,i*8,j*8)
			}
		}
		global.bg_fill[s]=sprite_create_from_surface(sur,0,0,1024,1024,0,0,512,512)
	}
	surface_reset_target()
	
	if global.online
	{
		room_goto(rm_online_prep)
	}
	else
	{
		instance_create_depth(0,0,0,obj_intro)
	}
	done=true
	if global.display_scale=4
	{
		window_set_fullscreen(true)
	}
}