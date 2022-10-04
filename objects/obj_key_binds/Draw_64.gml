if setting=0
{
	for (var i=0;i<4;i++)
	{
		var ext=""
		if obj_input_manager.joykey[i,0]=noone
		{
			ext=" (not set)"
		}
		var txt="_player "+string(i+1)+ext
		if i=player
		{
			txt=string_replace(txt,"_",">")
		}
		draw_text_transformed(0,9*i,string_lower(txt),1,1,0)
		draw_set_halign(fa_right)
		draw_text(room_width,0,"press ctrl r to reset keys\n\n(you can reset in\nevery screen)")
		draw_reset()
	}
}
else if setting=1
{
	draw_text_transformed(0,0,"press "+name[key],1,1,0)
	draw_set_halign(fa_right)
	draw_text(room_width,0,"press esc to cancel")
	draw_reset()
}