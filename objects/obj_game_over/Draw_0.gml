vsp+=grav
if y>ylimit
{
	if !mus
	{
		audio_play_sound(mus_gameover,1,0)
		mus=true
	}
	y=ylimit
	vsp*=-0.5
	if vsp>-0.5
	{
		vsp=0
	}
}
y+=vsp
if vsp=0
{
	asp+=grav2
	image_angle+=asp
	if image_angle>5
	{
		asp*=-0.5
		image_angle=5
	}
}
draw_set_font(global.fnt_big)
draw_set_halign(fa_center)
draw_text_transformed(x,y,"game over",2,2,image_angle)
draw_reset()

if global.key_accept[0] and cangoback and !instance_exists(obj_fake_player)
{
	room_transition(rm_menu)
	cangoback=0
}