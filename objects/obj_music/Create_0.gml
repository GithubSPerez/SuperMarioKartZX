audio_stop_all()
audio_stop_intro()
if !global.time_trial
{
	audio_play_sound(mus_begin_race,1,0)
}
global.music_type=0
s=noone
silence=0
silence_time=0