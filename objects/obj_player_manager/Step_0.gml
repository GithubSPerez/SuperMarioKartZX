if completed=1
{
	ctimer=60*5
	completed=2
}
ctimer-=global.T
if ctimer<0
{
	ctimer=0
	if completed=2
	{
		if global.time_trial
		{
			music=mus_rank_mario+global.win_char
			audio_play_intro(music,global.rank_music[global.win_char,0],global.rank_music[global.win_char,1])
		}
		completed=3
		offset=0
		with obj_player
		{
			if !win
			{
				time+=other.offset
				other.offset+=600/3.5
				event_user(0)
			}
		}
	}
}
var minim=4
if global.drivers<minim minim=global.drivers
if completed=3 and (global.winplace>=minim)
{
	if !global.time_trial
	{
		room_transition(rm_results)
		completed=4
	}
	else
	{
		if global.key_accept[0]
		{
			room_transition(rm_track_select)
			completed=4
		}
	}
}