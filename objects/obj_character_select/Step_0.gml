if cooldown>0
{
	cooldown--
	exit
}
if state=0
{
	readys=0
	for (var i=0;i<global.players;i++)
	{
		readys+=ready[i]
	}
	if global.key_cancel[0] and readys=0
	{
		state=2
		audio_sound_gain_reset(mus_menu,0,600,1)
		room_transition(rm_menu)
	}
	for (var i=0;i<global.maxplayers;i++)
	{
		if i<global.players
		{
			if !ready[i]
			{
				var change=(global.key_down_press[i]-global.key_up_press[i])+(global.key_right_press[i]-global.key_left_press[i])
				if change!=0
				{
					audio_play_new(snd_menu_move)
				}
				global.pdriver[i]+=(global.key_right_press[i]-global.key_left_press[i])*2
				global.pdriver[i]+=(global.key_down_press[i]-global.key_up_press[i])
				global.pdriver[i]=clamp(global.pdriver[i],0,7)
			}
		}
		if global.key_accept[i]
		{
			audio_play_new(snd_menu_select)
			if !ready[i]
			{
				if global.players>=i+1
				{
					ready[i]=1
				}
				else
				{
					//global.players=i+1
					global.players++
					if global.players<i+1
					{
						maxcontrol=obj_input_manager.control[global.players-1]
						obj_input_manager.control[global.players-1]=obj_input_manager.control[i]
						obj_input_manager.control[i]=maxcontrol
						cooldown=10
					}
				}
			}
			else
			{
				if i=0
				{
					if readys=global.players
					{
						if global.maxplayers=1
						{
							state=1
						}
						else
						{
							if global.players>1
							{
								state=1
							}
						}
					}
				}
			}
		}
		if global.key_cancel[i]
		{
			audio_play_new(snd_menu_back)
			if ready[i]=0
			{
				/*
				if i!=0 and i<global.players
				{
					global.players--
					if i<global.players
					{
						maxcontrol=obj_input_manager.control[i]
						for (var j=i;j<global.maxplayers-i;j++)
						{
							obj_input_manager.control[j]=obj_input_manager.control[j+1]
						}
						obj_input_manager.control[3]=maxcontrol
						//global.players=i
					}
				}
				*/
			}
			else
			{
				ready[i]=0
			}
		}
	}
}
else if state=1
{
	for (var i=0;i<8;i++)
	{
		img_type[i]=1
		for (var j=0;j<global.players;j++)
		{
			if global.pdriver[j]=i
			{
				img_type[i]=2
			}
		}
	}
	alarm[0]=60
	state=2
}