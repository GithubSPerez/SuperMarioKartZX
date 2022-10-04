//draw_surface(vs,0,0)
draw_set_color(c_white)
if outdated
{
	draw_text(0,0,"script outdated. update load script to edit.")
	draw_sprite_ext(spr_tracks,global.track,32,48,64/1024,64/1024,0,c_white,1)
	exit
}
if editmode=5
{
	draw_set_alpha(0.5)
	draw_rectangle(0,0,256,128,0)
	draw_set_alpha(1)
	txt[0]=""
	txt[1]=r_col
	txt[2]=g_col
	txt[3]=b_col
	draw_text(0,16,txt[input_type])
	draw_text(0,32,"bg fill sprite:")
	draw_sprite(spr_bg_fill,global.bg_fill_img,0,48)
	draw_text(0,64,"bg image:")
	draw_sprite(spr_bg_back+global.bg_type*2,global.bg_img,0,80)
	draw_sprite(spr_bg_front+global.bg_type*2,global.bg_front_img,0,80)
	draw_text(0,96,"out land:")
	draw_sprite(spr_collisions,global.out_fill,0,112)
}
if editmode=7
{
	draw_text(0,9,audio_get_name(global.music[global.song,0]))
}
if editmode=8
{
	draw_text(0,9,"press ·p· to change track type.\nchange image with ·n· and ·m·.")
}
if editmode=9
{
	var word="add"
	if global.feather
	{
		word="remove"
	}
	draw_text(0,9,"press ·f· to "+word+" feather")
}
draw_text(0,0,editmode)
if (editmode=3 or editmode=1) and fastmode
{
	draw_text(0,10,"fastmode on")
}