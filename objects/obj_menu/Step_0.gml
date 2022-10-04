var mp=global.realplayers
if pause exit
if transition!=0 exit
var omax=array_length_2d(options,state)
var optchange=global.key_down_press[mp]-global.key_up_press[mp]
opt+=optchange
if opt<0 opt=omax-1
if opt=omax opt=0

if optchange!=0
{
	audio_play_new(snd_menu_move)
}

if global.class_lock
{
	if state=3 and opt>1
	{
		opt=0
	}
}

if state=3 and global.revolutions>0
{
	var ccschange=global.key_l_press[mp] or key_check("L",1)
	ccswitch+=ccschange*((ccswitch>0)+1)
	ccswitch%=1+(global.revolutions*2)
	options[3,2]=string(150+50*ccswitch)+"ç_class"+string_repeat("_l",floor(global.time/20)%2)
	if ccschange!=0
	{
		audio_play_new(snd_pass)
	}
}

if global.key_accept[mp]
{
	audio_play_new(snd_menu_select)
	if goto[state,opt]=-1
	{
		global.players=1
		if state=1
		{
			
			global.drivers=8
			if opt=0
			{
				global.mode=0
				global.maxplayers=1
				goto[1,0]=3
			}
			else if opt=1
			{
				global.mode=1
				global.maxplayers=1
				global.cup=-1
				goto[1,1]=3
			}
			else if opt=2
			{
				global.mode=1
				global.maxplayers=1
				global.cup=-1
				global.drivers=1
				global.cc=1.25
				toroom=rm_character_select
			}
		}
		else if state=2
		{
			//global.players=1
			if opt=0
			{
				global.mode=0
				global.maxplayers=4
				goto[2,0]=3
			}
			else if opt=1
			{
				global.mode=1
				global.maxplayers=4
				global.cup=-1
				goto[2,1]=3
			}
		}
		else if state=3
		{
			toroom=rm_character_select
			global.cc=0.75+(0.25*opt)+(0.25*ccswitch*(opt=2))
		}
		else if state=0
		{
			if opt=2
			{
				toroom=rm_quit
			}
		}
		else if state=5
		{
			if opt=0
			{
				global.display_scale++
				if global.display_scale>4
				{
					global.display_scale=1
				}
				if global.display_scale=4
				{
					window_set_fullscreen(true)
					//gpu_set_tex_filter(true)
				}
				else
				{
					window_set_fullscreen(false)
					window_set_size(global.display_scale*400,global.display_scale*224)
					//gpu_set_tex_filter(false)
					alarm[0]=10
				}
			}
			else if opt=1
			{
				global.retro++
				global.retro%=2
			}
			progress_save()
		}
		else if state=6
		{
			if opt=0
			{
				if gamepad_is_connected(0) or gamepad_is_connected(4)
				{
					toroom=rm_gamepad
				}
				else
				{
					audio_stop_sound(snd_menu_select)
					audio_play_new(snd_menu_back)
				}
			}
			else if opt=1
			{
				global.joycon++
				global.joycon%=2
			}
			else if opt=2
			{
				if global.joycon
				{
					toroom=rm_key
				}
				else
				{
					audio_stop_sound(snd_menu_select)
					audio_play_new(snd_menu_back)
				}
			}
			progress_save()
		}
	}
	if goto[state,opt]!=-1
	{
		var gt=goto[state,opt]
		gotfrom[gt]=state
		lopt[gt]=opt
		state=gt
		opt=0
		
		reset_box_size()
	}
}
ss[0]="x1"
ss[1]="x2"
ss[2]="x3"
ss[3]="full"

ts[0]="normal"
ts[1]="pixelated"

km[0]="off"
km[1]="on"

options[5,0]="screen_size>___"+ss[global.display_scale-1]
options[5,1]="3d_resolution>_"+ts[global.retro]

options[6,1]="keyboard multiplayer "+km[global.joycon]
if global.key_cancel[mp] and gotfrom[state]!=noone
{
	//audio_play_new(snd_menu_back)
	opt=lopt[state]
	state=gotfrom[state]
	reset_box_size()
}
if toroom!=noone
{
	pause=1
	audio_sound_gain_reset(mus_intro,0,600,0.5)
	room_transition(toroom)
}