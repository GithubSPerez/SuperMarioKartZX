surface_set_target(retro_sur)
draw_clear_alpha(c_white,0)

draw_sprite(spr_results_bg,0,0,0)

draw_self()
if 1//state=0 or state=1
{
	for (var i=0;i<stands;i++)
	{
		var dchamp=(i=0 and champ and place=0)
		var spr=spr_mario_victory+dchamp+(global.driver[global.scoreplace[i],2]*2)%16
		draw_sprite(spr,img[i],x+jx[i],y-s_y+jy[i])
		if place=0
		{
			if i=0
			{
				if champ
				{
					img[0]+=sprite_get_speed(spr)
					var bottle_g=dcos(img[0]*180+90)
					if spr=spr_yoshi_champ and bottle_g>0
					{
						draw_sprite(spr_bottle,0,x+jx[0]-8,y-s_y-8-bottle_g*32)
					}
				}
				else
				{
					draw_sprite(spr_bottle,pop,x+jx[i]-8,y-s_y+4)
				}
			}
			else
			{
				if recieved>0
				{
					img[i]+=0.05
				}
			}
		}
		else
		{
			if i=0
			{
				//draw_sprite(spr_bottle,0,x+jx[i]-8,y-s_y+8)
			}
			if recieved>0
			{
				img[i]+=0.05
			}
		}
	}
	if pop>0
	{
		pop+=0.02
	}
	if pop=2 and place=0
	{
		instance_create_depth(x+jx[0]-8,y-s_y+4,depth-1,obj_pop)
	}
	if pop>2.9
	{
		champ=1
	}
}
if state=1
{
	cvsp+=cgrav
	congrats_size+=cvsp
	if cvsp>1 cvsp=1
	if congrats_size>1.5
	{
		congrats_size=1.5
		cvsp*=-0.5
		if sound<4
		{
			var au=audio_play_new(snd_item)
			audio_sound_pitch(au,1-sound/111)
			sound++
		}
	}
	alarm[0]--
	if alarm[0]=0
	{
		//show_message("")
		state=2
	}
}
if state=2
{
	draw_reset()
	var full_str=final_text+"\n\n"+compliment
	draw_text(room_width/2-8*(string_length(final_text)/2),room_height/3,string_copy(full_str,1,char))
	char+=0.5
	if char>string_length(final_text) and !pene
	{
		if global.key_accept[0]
		{
			pene=1
			audio_sound_gain_reset(mus_congratulations,0,600,1)
			var tr=rm_menu
			if global.cup=4 and credits
			{
				tr=rm_credits
			}
			room_transition(tr)
		}
	}
}
var c_x=room_width/2
var c_y=room_height/5
draw_sprite_ext(spr_ribbon,place,c_x,c_y,congrats_size,congrats_size,0,c_white,1)
draw_sprite_ext(spr_congrats,global.time*0.2,c_x,c_y,congrats_size,congrats_size,0,c_white,1)

shader_set(sh_congrats)
shader_set_uniform_f(shader_get_uniform(sh_congrats,"time"),global.time)
draw_sprite_ext(spr_place_numbers,place,c_x,c_y,congrats_size,congrats_size,0,c_white,1)
shader_reset()

surface_reset_target()
draw_surface(retro_sur,0,0)