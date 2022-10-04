if pause exit;
var change=global.key_right_press[0]-global.key_left_press[0]
var vchange=(global.key_down_press[0]-global.key_up_press[0])
if state=0
{
	if change!=0 or vchange!=0
	{
		audio_play_new(snd_menu_move)
	}
	option+=vchange
	option=clamp(option,0,2)
	if option=0
	{
		global.vsmaxpoints+=change
		if global.vsmaxpoints>20 global.vsmaxpoints=0
		if global.vsmaxpoints<0 global.vsmaxpoints=20
		versus_reset(global.vsmaxpoints)
	}
	else if option=1
	{
		global.drivers+=change
		var maxd=8
		var mind=clamp(global.players,2,8)
		if global.drivers<mind
		{
			global.drivers=maxd
		}
		if global.drivers>maxd
		{
			global.drivers=mind
		}
	}
	else if option=2
	{
		global.vsrandom+=change
		if global.vsrandom<0 global.vsrandom=1
		if global.vsrandom>1 global.vsrandom=0
	}
	if global.key_cancel[0] and (global.vspoints=global.vsmaxpoints)// or global.vsmaxpoints=0
	{
		pause=1
		audio_play_new(snd_menu_back)
		room_transition(rm_character_select)
		global.vsselected=0
	}
	else if global.key_accept[0]
	{
		audio_play_new(snd_menu_select)
		if !global.vsrandom
		{
			state=1
		}
		else
		{
			pause=1
			audio_sound_gain_reset(mus_menu,0,40,1)
			room_transition(rm_next_track)
		}
	}
}
else if state=1
{
	onlock=!(global.vscup<3 or (global.vscup=3 and !global.special_lock) or (global.vscup=4 and !global.super_lock))
	if change!=0 or vchange!=0
	{
		audio_play_new(snd_menu_move)
	}
	global.vstrack+=(global.key_down_press[0]-global.key_up_press[0])
	global.vstrack=clamp(global.vstrack,0,4)
	global.vscup+=(global.key_right_press[0]-global.key_left_press[0])
	global.vscup=clamp(global.vscup,0,4)//-global.special_lock-global.super_lock)
	if global.vscup=-1
	{
		global.vstrack=0
	}
	faketrack+=(global.vstrack-faketrack)/6
	fakecup+=(global.vscup-fakecup)/6
	var play_replay=(global.time_trial and (global.key_r_press[0] or key_check("R",1)))
	if global.key_cancel[0] and global.vspoints=global.vsmaxpoints and !global.time_trial
	{
		audio_play_new(snd_menu_back)
		state=0
	}
	else if (global.key_accept[0] or (play_replay and canwatch)) and !onlock
	{
		pause=1
		audio_sound_gain_reset(mus_menu,0,40,1)
		audio_play_new(snd_menu_select)
		if play_replay
		{
			global.init_replay=true
			//el obj_next_track tiene el codigo para cargar el replay
		}
		room_transition(rm_next_track)
	}
	if global.time_trial
	{
		if global.key_cancel[0]
		{
			pause=1
			audio_play_new(snd_menu_back)
			room_transition(rm_character_select)
		}
	}
}