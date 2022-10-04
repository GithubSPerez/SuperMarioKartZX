draw_sprite_tiled(spr_cup_border,0,0,0)
draw_set_color(c_black)
draw_rectangle(16,32,room_width-17,room_height-33,0)
draw_set_color(c_white)
draw_sprite_ext(spr_wall,0,9*16,16,14,2,0,c_black,1)
for (var shit=0;shit<2;shit++)
{
	draw_sprite_ext(spr_wall,0,0,(224-16)*shit,50,2,0,c_black,1)
}

draw_set_font(global.fnt_big)
draw_set_halign(fa_center)
draw_text(room_width/2,16,string(cc)+"ç class")

for (var i=0;i<cup_number;i++)
{
	font_set_stroke_color(c_red)
	var c1=c_blue
	var c2=c_aqua
	if i=global.cup
	{
		c1=c_red
		c2=c_yellow
	}
	if (i=3 and global.special_lock) or (i=4 and (global.super_lock or highcclock))
	{
		c1=c_black
		c2=c_dkgray
	}
	draw_set_color(c1)
	font_set_stroke_color(c2)
	draw_set_halign(fa_left)
	ijy=(4.3)*16
	jy=24
	if cc=50
	{
		jy=32
	}
	if cc>=150
	{
		jy=18
	}
	draw_text(8.5*16,ijy+jy*i,global.cup_name[i]+" cup race")
	var trophie_ind=cc/50-1
	font_reset_color()
	if global.cup_won[trophie_ind,i]!=0
	{
		draw_sprite(spr_trophie,global.cup_won[trophie_ind,i]-1+trophie_ind*3,7.5*16,ijy+jy*i+8)
	}
}
draw_reset()