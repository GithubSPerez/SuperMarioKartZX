if keyboard_check_pressed(vk_backspace) and start=0
{
	surface_set_target(sur)
	var pos=global.xmaxland*8/2
	draw_sprite(track_get_sprite(),track_get_image(),pos,pos)
	surface_reset_target()
	buff=buffer_getpixel_begin(sur)
	start=1
	progress=0
	keyboard_string="0"
}
if start=1
{
	for (var i=0;i<size;i++)
	{
		for (var p=0;p<64;p++)
		{
			tempcube[p]=buffer_getpixel(buff,i*8+p%8,progress*8+floor(p/8),size*8,size*8)
			//show_message(string(i*8+p%8)+","+string(progress*8+floor(p/8)))
		}
		var repeated=0
		var tile_id=0
		for (var s=0;s<patch_number;s++)
		{
			var checktype=0
			repeat 1//4
			{
				var equal_points=0
				for (var c=0;c<64;c++)
				{
					var check=0
					//var falpha=(7+(8*floor(c/8)))-(c-(8*floor(c/8)))
					if checktype=0
					{
						check=tempcube[c]=patch[s,c]
					}
					/*
					else if checktype=1
					{
						check=tempcube[c]=patch[s,falpha]
					}
					else if checktype=2
					{
						check=tempcube[c]=patch[s,63-falpha]
					}
					else if checktype=3
					{
						check=tempcube[c]=patch[s,63-c]
					}
					*/
					if check
					{
						equal_points++
					}
				}
				if equal_points>=64
				{
					repeated=1
					tile_id=s
					break
				}
				/*
				else
				{
					checktype++
				}
				*/
			}
		}
		if !repeated
		{
			for (var cc=0;cc<64;cc++)
			{
				patch[patch_number,cc]=tempcube[cc]
			}
			tile_id=patch_number
			patch_number++
		}
		tile[progress,i]=tile_id
	}
	progress++
	if progress=size
	{
		start=2
		show_message(tile)
	}
}
if start=2
{
	var sx=dtile%size
	var sy=floor(dtile/size)
	while tile[sx,sy]!=index
	{
		dtile++
		sx=dtile%size
		sy=floor(dtile/size)
		if dtile>=size*size
		{
			dtile=0
			break
		}
	}

	draw_sprite(spr_pointer,0,sy*8,sx*8)
	obj_editor.cam_x=sy*8-100
	obj_editor.cam_y=sx*8-100
}