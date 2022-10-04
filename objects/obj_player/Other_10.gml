win=1
if place<=4 and !global.time_trial
{
	hurt=9
	follow_dir=3
}
else if !cpu
{
	global.c_follow[player-1]=0
}
global.winplace++
place=global.winplace
set_place=global.winplace
global.place[place]=driver_id
global.won[place-1,0]=global.driver[driver_id,2]
global.won[place-1,1]=time
if !cpu
{
	//show_message(place)
	obj_player_manager.completed+=1/global.players
	if place<=4
	{
		global.plost=0
		if !global.pwon
		{
			global.music_type=2
			global.pwon=1
			global.win_char=character
		}
	}
	else
	{
		if !global.pwon
		{
			global.music_type=5
			global.pwon=1
			global.win_char=global.drivers
		}
	}
}