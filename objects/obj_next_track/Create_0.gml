if global.cup!=-1
{
	if global.track_index=array_length_2d(global.cup_track,global.cup)
	{
		room_transition(rm_finish)
		exit
	}
	if global.track_index=0
	{
		reset_players()
	}
	global.track=global.cup_track[global.cup,global.track_index]
	global.track_index++
}
else
{
	//show_message("belt")
	if !global.time_trial
	{
		if !global.vsselected and global.vspoints>0
		{
			room_goto(rm_track_select)
			global.vsselected=1
			exit;
		}
		else
		{
			global.vsselected=0
		}
		if global.vspoints=0
		{
			room_transition(rm_finish)
			exit
		}
		if global.vspoints=global.vsmaxpoints or global.vspoints=-1
		{
			reset_players()
		}
		if !global.vsrandom
		{
			global.track=global.cup_track[global.vscup,global.vstrack]
		}
		else
		{
			while vs_set_random_track() {}
		}
		global.vspoints--
	}
	else
	{
		global.init_recording=true
		reset_players()
		global.track=global.cup_track[global.vscup,global.vstrack]
		if global.init_replay
		{
			global.init_recording=false
			global.lchar=global.driver[0,2]
			replay_load()
		}
	}
}
room_goto(rm_game)