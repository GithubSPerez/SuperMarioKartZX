if !audio_is_playing(sound)
{
	audio_sound_gain(sound,tovol,0)
	instance_destroy()
}