#region sounds
var stat_ind=floor(character/2)
if !cpu
{
	var pgain=1/global.players
	if (preparing>=3 or preparing=0) and !win
	{
		if !audio_is_playing(motor_sound)
		{
			motor_sound=audio_play_sound(snd_motor+stat_ind,0,true)
		}
		audio_sound_pitch(motor_sound,(1+spd/2+(ini_boost/100)*(preparing=4))*motor_pitch[stat_ind])
		audio_sound_gain(motor_sound,pgain,0)
	}
	else
	{
		if win
		{
			if !motor_stop
			{
				//show_message("shit")
				audio_sound_gain_reset(motor_sound,0,800,1)
				motor_stop=true
			}
		}
		else
		{
			audio_stop_sound(motor_sound)
		}
	}
	if drift and polvo and ground
	{
		if !audio_is_playing(drift_sound)
		{
			drift_sound=audio_play_sound(snd_drift,0,true)
		}
		audio_sound_gain(drift_sound,pgain,0)
	}
	else
	{
		audio_stop_sound(drift_sound)
	}
	if play_goal
	{
		audio_play_new(snd_goal)
	}
	if play_itembox
	{
		itembox_sound=audio_play_sound(snd_itembox,1,0)
	}
	if stop_itembox
	{
		audio_stop_sound(itembox_sound)
		audio_play_new(snd_item)
	}
	if play_pass
	{
		audio_play_new(snd_pass)
	}
	if play_star
	{
		audio_play_new(mus_star)
		obj_music.silence=0
		obj_music.silence_time=star_time
	}
	if play_ghost
	{
		audio_play_new(snd_boo)
		obj_music.silence=0.4
		obj_music.silence_time=ghost_time
	}
	if play_stolen
	{
		audio_play_new(snd_stolen)
	}
	if play_hit
	{
		audio_play_new(snd_hit)
		audio_sound_pitch(snd_hit,0.6)
	}
	if play_land
	{
		audio_play_new(snd_land)
	}
	if play_thunder
	{
		audio_play_new(snd_thunder)
	}
	if wrong_way
	{
		if !audio_is_playing(snd_wrong_way)
		{
			audio_play_new(snd_wrong_way)
		}
	}
}
if !cpu or camera_visible()
{
	if play_jump
	{
		audio_play_new(snd_jump)
	}
	if play_boost
	{
		audio_play_new(snd_boost)
	}
	if play_wall
	{
		audio_play_new(snd_wall)
	}
	if play_throw
	{
		var s=audio_play_new(snd_throw)
		audio_sound_pitch(s,1.5)
	}
	if play_feather
	{
		audio_play_new(snd_feather)
	}
}
if play_wall_cpu
{
	audio_play_new(snd_wall)
}
if play_gothit
{
	audio_play_new(snd_gothit)
}
#endregion