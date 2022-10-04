var qo=1+global.time_trial
var key_down=global.key_start[0] or global.key_b[0]
draw_sprite_stretched_ext(global.pausesprite,0,0,0,global.screen_w,global.screen_h,merge_color(c_gray,c_black,accept/30),1)
draw_set_halign(fa_center)
draw_set_valign(fa_center)
var restext=string_repeat(">",opt=0)+"resume"+string_repeat("<",opt=0)
var resettext=string_repeat(">",opt=1)+"reset"+string_repeat("<",opt=1)
var quittext=string_repeat(">",opt=qo)+"quit"+string_repeat("<",opt=qo)

draw_text(global.screen_w/2,global.screen_h/2,restext+"\n\n"+string_repeat(resettext+"\n\n",global.time_trial)+quittext+"\n"+string_repeat("(hold)",hold))
draw_set_font(global.fnt_big)
draw_text(global.screen_w/2,global.screen_h/2,"pause\n\n\n\n\n\n")
draw_reset()
if cooldown>0
{
	cooldown--
	exit
}
if !active exit

var move=(global.key_down_press[0]-global.key_up_press[0])
opt+=move
if opt<0 opt=qo
if opt>qo opt=0

if move!=0
{
	audio_play_new(snd_menu_move)
}

if key_down
{
	if opt=qo and hold
	{
		accept++
		if accept=30
		{
			var toroom=rm_menu
			if global.time_trial
			{
				toroom=rm_track_select
			}
			room_transition(toroom)
			audio_play_new(snd_menu_back)
			active=false
		}
	}
}
if !key_down or opt!=qo
{
	accept--
}
if accept<0 accept=0
if global.key_accept[0]
{
	if opt=0
	{
		instance_activate_all()
		audio_resume_all()
		global.key_start_press[0]=false
		//sprite_delete(global.pausesprite)
		instance_deactivate_object(id)
	}
	else if opt=qo
	{
		hold=true
	}
	else if global.time_trial and opt=1
	{
		obj_input_manager.recording=false
		room_transition(rm_next_track)
		audio_play_new(snd_menu_select)
		active=false
	}
}
if opt!=qo
{
	hold=false
}