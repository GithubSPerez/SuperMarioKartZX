var m=global.music_type
if m=1
{
	//audio_stop_all()
	audio_stop_intro()
	//show_message(global.music[global.song,1])
	s=audio_play_intro(global.music[global.song,0],global.music[global.song,1],noone)
}
else if m=2
{
	//audio_stop_all()
	audio_stop_intro()
	s=audio_play_sound(mus_you_win,1,0)
}
else if m=3
{
	//audio_stop_all()
	audio_stop_intro()
	s=audio_play_intro(global.music[global.song,0],global.music[global.song,1],noone)
	s.pitch=1.1
}
else if m=4
{
	//audio_stop_all()
	audio_stop_intro()
	s=audio_play_new(snd_final_lap)
}
else if m=5
{
	//audio_stop_all()
	audio_stop_intro()
	s=audio_play_sound(mus_you_lose,1,0)
}
global.music_type=0
if instance_exists(s)
{
	s.volume=1
	if silence_time>0
	{
		s.volume=silence
		silence_time-=global.T
	}
}