global.time++
global.display_w=window_get_width()
global.display_h=window_get_height()
global.screen_scale=clamp(global.display_w/400,1,3)

if global.retro
{
	global.screen_scale=1
}

if room=rm_game
{
	if global.init_recording
	{
		recording=true
		global.init_recording=false
	}
	else if global.init_replay
	{
		replay=true
		global.init_replay=false
	}
}
else
{
	recording=false
	replay=false
}
if replay and recording
{
	replay=false
	recording=false
}
if !replay
{
	repframe=0
	repinput=0
#region keyboard
for (var i=0;i<1+(global.players-1)*debug;i++)
{
	i=control_number
	keyval[i,0]=key_check(B_id(0,BT.right),0)

	keyval[i,1]=key_check(B_id(0,BT.left),0)

	keyval[i,2]=key_check(B_id(0,BT.up),0)

	keyval[i,3]=key_check(B_id(0,BT.down),0)

	keyval[i,4]=key_check(B_id(0,BT.B),0)

	keyval[i,5]=key_check(B_id(0,BT.A),0)

	keyval[i,6]=key_check(B_id(0,BT.L),0)

	keyval[i,7]=key_check(B_id(0,BT.R),0)
	
	keyval[i,8]=key_check(B_id(0,BT.start),0)
	
	keyval[i,9]=key_check(B_id(0,BT.Y),0)
}
#endregion
#region joycon mode
if global.joycon
{
	if !global.multicon
	{
		for (var i=0;i<4;i++)
		{
			for (var j=0;j<key_numb;j++)
			{
				keyval[i,j]=key_check(joykey[i,j],0)
			}
		}
	}
	else
	{
		/*
		for (var i=0;i<2;i++)
		{
			var c=i*2
			var c2=c+1
			
			keyval[i,0]=key_check(joykey[c2,2],0)
			keyval[i,1]=key_check(joykey[c2,3],0)
			keyval[i,2]=key_check(joykey[c2,1],0)
			keyval[i,3]=key_check(joykey[c2,0],0)
			
			keyval[i,4]=key_check(joykey[c,5],0)
			keyval[i,5]=key_check(joykey[c,9],0)
			keyval[i,2]=key_check(joykey[c,1],0)
			keyval[i,3]=key_check(joykey[c,0],0)
		}
		*/
	}
}
#endregion
#region gamepads
var t_c=gamepad_get_device_count()
if !global.joycon and !instance_exists(obj_gamepad)
{
	#region connecting and disconnecting
	for (var i=0;i<global.realplayers;i++)
	{
		if control[i]=noone
		{
			var alreadyc=0
			for (var j=0;j<t_c;j++)
			{
				if gamepad_is_connected(j) and !alreadyc
				{
					if gamepad_get_description(j)!="Steam Virtual GamePad"
					{
						var new=1
						for (var k=0;k<4;k++)
						{
							if control[k]=j
							{
								new=0
							}
						}
						if new
						{
							//show_message(gamepad_get_description(j))
							control[i]=j
							control_number++
							alreadyc=1
						}
					}
				}
			}
		}
		else
		{
			if !gamepad_is_connected(control[i])
			{
				control[i]=noone
				for (var j=i;j<t_c;j++)
				{
					if j=t_c-1
					{
						control[j]=noone
						break
					}
					control[j]=control[j+1]
				}
				control_number--
			}
		}
	}
	#endregion
	#region inputs
	
	for (var i=0;i<control_number;i++)
	{
		var d=control[i]
		var ctm=1
		
		var name=gamepad_get_description(d)
		if ds_map_exists(inputs,name)
		{
			ctm=inputs[? name]
		}
		
		gamepad_set_axis_deadzone(d,0.3)
		
		keyval[i,0]=GP_uni(d,ctm,BT.right)

		keyval[i,1]=GP_uni(d,ctm,BT.left)//clamp(-gamepad_axis_value(d,gp_axislh),0,1)>0.6 or gamepad_button_check(d,B_id(ctm,BT.left))

		keyval[i,2]=GP_uni(d,ctm,BT.up)//clamp(-gamepad_axis_value(d,gp_axislv),0,1)>0.6 or gamepad_button_check(d,B_id(ctm,BT.up))

		keyval[i,3]=GP_uni(d,ctm,BT.down)//clamp(gamepad_axis_value(d,gp_axislv),0,1)>0.6 or gamepad_button_check(d,B_id(ctm,BT.down))
		
		if B_type(ctm,BT.up)=2
		{
			var hatval=GP_value(d,ctm,BT.up)
			for (var j=0;j<4;j++)
			{
				if hatval=B_val(ctm,dirin[j])+B_val(ctm,dirin[(j+1)%4])
				{
					//show_message(j)
					keyval[i,dircon[j]]=true
					//show_message(dircon[j])
					keyval[i,dircon[(j+1)%4]]=true
				}
			}
		}

		keyval[i,4]=GP_uni(d,ctm,BT.B)

		keyval[i,5]=GP_uni(d,ctm,BT.A)

		keyval[i,6]=GP_uni(d,ctm,BT.L)// or gamepad_button_check(d,gp_shoulderlb)

		keyval[i,7]=GP_uni(d,ctm,BT.R)// or gamepad_button_check(d,gp_shoulderrb)

		keyval[i,8]=GP_uni(d,ctm,BT.start)
		
		keyval[i,9]=GP_uni(d,ctm,BT.Y)
	}
	#endregion
}
#endregion
#region all players
var mp=global.realplayers
for (var j=0;j<key_numb;j++)
{
	keyval[mp,j]=0
	lkeyval[mp,j]=0
}
for (var i=0;i<mp;i++)
{
	for (var j=0;j<key_numb;j++)
	{
		keyval[mp,j]+=keyval[i,j]
		keyval[mp,j]=sign(keyval[mp,j])
		
		lkeyval[mp,j]+=lkeyval[i,j]
		lkeyval[mp,j]=sign(lkeyval[mp,j])
	}
}
#endregion
}
else
{
	if data[repinput,0]=-1
	{
		keyval[4]=true
		replay=false
	}
	if data[repinput,0]=repframe
	{
		for (var i=0;i<key_numb;i++)
		{
			var dat=data[repinput,i+1]
			if dat!=-1
			{
				keyval[i]=dat
				if i=8
				{
					keyval[i]=0
				}
			}
		}
		var tx=data[repinput,i+1]
		var ty=data[repinput,i+2]
		var ts=data[repinput,i+3]
		var td=data[repinput,i+4]
		if tx!=0 and ty!=0
		{
			obj_player.x=tx
			obj_player.y=ty
			obj_player.spd=ts
			obj_player.todir[1]=td
		}
		repinput++
	}
	repframe++
}

#region recording
recpause=instance_exists(obj_pause)
if recording
{
	if !recpause
	{
		for (var i=0;i<key_numb;i++)
		{
			if keyval[i]!=lkeyval[i] or recinput=0
			{
				if !recwritten
				{
					recwritten=true
					data[recinput,0]=recframe
					data[recinput+1,0]=-1
					for (var j=0;j<key_numb;j++)
					{
						data[recinput,j+1]=-1
					}
				}
				data[recinput,i+1]=keyval[i]
			}
		}
		data[recinput,i+1]=obj_player.x
		data[recinput,i+2]=obj_player.y
		data[recinput,i+3]=obj_player.spd
		data[recinput,i+4]=obj_player.todir[1]
		if recwritten
		{
			recinput++
		}
		recframe++
		recwritten=false
	}
}
else
{
	recframe=0
	recinput=0
}
#endregion
#region global vars
for (var i=0;i<global.realplayers+1;i++)
{
	global.key_right[i]=keyval[i,0]
	global.key_right_press[i]=keyval[i,0] and !lkeyval[i,0]

	global.key_left[i]=keyval[i,1]
	global.key_left_press[i]=keyval[i,1] and !lkeyval[i,1]

	global.key_up[i]=keyval[i,2]
	global.key_up_press[i]=keyval[i,2] and !lkeyval[i,2]

	global.key_down[i]=keyval[i,3]
	global.key_down_press[i]=keyval[i,3] and !lkeyval[i,3]

	global.key_b[i]=keyval[i,4]
	global.key_b_press[i]=keyval[i,4] and !lkeyval[i,4]

	global.key_a[i]=keyval[i,5]
	global.key_a_press[i]=keyval[i,5] and !lkeyval[i,5]

	global.key_l[i]=keyval[i,6]
	global.key_l_press[i]=keyval[i,6] and !lkeyval[i,6]

	global.key_r[i]=keyval[i,7]
	global.key_r_press[i]=keyval[i,7] and !lkeyval[i,7]

	global.key_start[i]=keyval[i,8]
	global.key_start_press[i]=keyval[i,8] and !lkeyval[i,8]
	
	global.key_y[i]=keyval[i,9]
	global.key_y_press[i]=keyval[i,9] and !lkeyval[i,9]
	
	global.key_accept[i]=global.key_start_press[i] or global.key_b_press[i]
	global.key_cancel[i]=global.key_a_press[i]
}
#endregion

for (var i=0;i<4;i++)
{
	for (var j=0;j<key_numb;j++)
	{
		lkeyval[i,j]=keyval[i,j]
	}
}

global.time_trial=(global.drivers=1)

global.T=delta_time/1000000*60

if global.time_trial
{
	global.T=1
}

if global.drivers<global.players
{
	global.drivers=global.players
}

var dstr="pumahue"
var str=keyboard_string
var dslen=string_length(dstr)
if string_copy(str,string_length(str)-dslen,dslen)=dstr
{
	audio_play_new(snd_thunder)
	global.debug++
	global.debug%=2
	keyboard_string=""
}

if global.debug
{
	if keyboard_check(vk_rshift)
	{
		global.T*=4
	}
	if keyboard_check_pressed(ord("V"))
	{
		with obj_track_check
		{
			visible++
			visible%=2
		}
	}
}

if key_check(vk_control,0) and key_check("R",1)
{
	audio_play_new(snd_itemdestroy)
	keyboard_ini()
	save_input()
}