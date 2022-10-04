if played=0
{
	psong=audio_play_sound(song,1,0)
	played=1
}
if stop!=noone
{
	if audio_sound_get_track_position(psong)>=stop
	{
		audio_stop_sound(song)
	}
}
if played=1
{
	if !audio_is_playing(song)
	{
		psong=audio_play_sound(song,1,0)
		//show_message(time)
		audio_sound_set_track_position(psong,time)
	}
}
audio_sound_pitch(psong,pitch)
audio_sound_gain(psong,volume,0)