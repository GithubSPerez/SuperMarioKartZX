if state=0
{
	if tnames<global.drivers
	{
		tnames+=0.25
	}
	else
	{
		if global.key_accept[0]
		{
			for (var i=0;i<global.drivers;i++)
			{
				global.pscore[global.place[i+1]]+=global.points[i]
			}
			tnames=0
			state=1
		}
	}
}
if floor(state)=1
{
	if tnames<global.drivers
	{
		tnames+=0.25
	}
	else
	{
		state+=0.025
	}
}
if floor(state)=2
{
	var cunt=1
	time++
	for (var i=0;i<global.drivers;i++)
	{
		var ind=global.place[i+1]
		if pscdraw[ind]<global.pscore[ind]
		{
			pscdraw[ind]+=0.2
			cunt=0
		}
	}
	if cunt
	{
		alarm[0]=60
		state=3
	}
	else
	{
		if time%4=0
		{
			audio_play_new(snd_item)
		}
	}
}
if state=4
{
	if tnames>0
	{
		tnames-=0.25
	}
	else
	{
		reorder_player()
		state=5
	}
}
if state=5
{
	if tnames<global.drivers
	{
		tnames+=0.25
	}
	else
	{
		if global.key_accept[0]
		{
			audio_sound_gain_reset(music,0,600,1)
			room_transition(rm_next_track)
			state=6
		}
	}
}
if alarm[0]>-1
{
	alarm[0]--
}
if alarm[0]=0
{
	state=4
}