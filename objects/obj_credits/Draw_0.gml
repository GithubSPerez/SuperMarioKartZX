draw_sprite_tiled(spr_title_bg,1,y*0.8,0)
y-=0.2
draw_set_halign(fa_center)
draw_text(room_width/2,y,stxt)
draw_set_font(global.fnt_big)
draw_text(room_width/2,y,btxt)


var size=42
draw_sprite_ext(spr_title,0,room_width/2,clamp(y-size,-size,room_height/2),1,1,0,c_white,1-(y-room_height)/50)
if abs(y-ystart)>=510
{
	draw_set_valign(fa_center)
	draw_set_color(c_yellow)
	draw_text_transformed(room_width/2,room_height/2,"the end",2,2,dcos(global.time*5)*5)
	draw_set_font(global.fnt_main)
	draw_set_color(c_lime)
	draw_text(room_width/2,room_height*0.75,"you've unlocked something special...")
	if global.key_start_press[0] and active
	{
		room_transition(rm_menu)
		active=false
	}
}

draw_reset()