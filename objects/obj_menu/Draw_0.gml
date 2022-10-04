if box_w<box_to_w
{
	box_w+=box_xspd
	if box_w>=box_to_w
	{
		box_w=box_to_w
		transition--
	}
}
if box_h<box_to_h
{
	box_h+=box_yspd
	if box_h>=box_to_h
	{
		box_h=box_to_h
		transition--
	}
}
draw_sprite_ext(spr_menu_box,0,box_x,box_y,box_w,box_h,0,c_white,1)
if transition!=0 exit
for (var i=0;i<array_length_2d(options,state);i++)
{
	var txt_x=box_x-8*abs(box_w)+20
	var txt_y=box_y-8*abs(box_h)+6+i*12
	draw_set_color(c_white)
	if opt=i
	{
		draw_sprite(spr_cursor,0,txt_x-12,txt_y)
	}
	font_set_stroke_color(color[i%3])
	if global.class_lock
	{
		if state=3 and i=2
		{
			draw_set_color(c_black)
			font_set_stroke_color(c_dkgray)
		}
	}
	draw_text(txt_x,txt_y,options[state,i])
	draw_set_color(c_white)
	font_reset_color()
}