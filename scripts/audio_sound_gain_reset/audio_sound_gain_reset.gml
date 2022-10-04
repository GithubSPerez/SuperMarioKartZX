///@param sound
///@param volume
///@param time
///@param reset_volume
var song=argument0
var vol=argument1
var time=argument2
var tovol=argument3
audio_sound_gain(song,vol,time)
var ins=instance_create_depth(0,0,0,obj_sound_reset)
ins.sound=song
ins.tovol=tovol