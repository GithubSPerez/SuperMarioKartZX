if toset<=BT.start
{
	draw_text(0,0,display_name)
	draw_text_transformed(0,10,"press "+global.bname[toset],2,2,0)
	draw_set_halign(fa_right)
	draw_text(global.screen_w,0,"press esc to cancel")
	if global.debug
	{
		for (var i=0;i<ds_list_size(show_list);i++)
		{
			draw_text(global.screen_w,9+8*i,ds_list_find_value(show_list,i))
		}
		draw_set_halign(fa_left)
		draw_text(0,64,pressed)
	}
	draw_reset()
}