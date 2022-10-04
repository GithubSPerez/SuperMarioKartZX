if start=0
{
	draw_text(0,0,"press backspace to auto fill")
}
if start=1
{
	draw_text(0,0,string(floor(progress/size*100))+"%")
}
if start=2
{
	for (var j=0;j<64;j++)
	{
		draw_sprite_ext(spr_wall,0,(j%8)*8,(floor(j/8))*8,1,1,0,patch[index,j],1)
	}
	if string_length(keyboard_string)>1
	{
		keyboard_string=string_copy(keyboard_string,2,1)
	}
	var knumb=real(string_digits(keyboard_string))
	draw_sprite(spr_collisions,knumb,0,0)
	draw_text(0,0,"\n"+string(index)+"/"+string(patch_number))
	if keyboard_check_pressed(vk_enter)
	{
		cube[index]=knumb
		//show_message(cube)
		index++
		if index>=patch_number
		{
			for (var i=0;i<size;i++)
			{
				for (var j=0;j<size;j++)
				{
					obj_editor.collision[i,j]=cube[tile[j,i]]
				}
			}
			start=0
		}
	}
	if keyboard_check_pressed(ord("Z"))
	{
		index--
	}
}