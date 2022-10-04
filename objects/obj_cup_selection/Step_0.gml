if pause exit;
if global.key_cancel[0]
{
	audio_play_new(snd_menu_back)
	room_transition(rm_character_select)
	pause=1
}
if global.key_accept[0]
{
	audio_play_new(snd_menu_select)
	room_transition(rm_next_track)
	audio_sound_gain_reset(mus_menu,0,600,1)
	pause=1
}
var change=global.key_down_press[0]-global.key_up_press[0]
global.cup+=change
if change!=0
{
	audio_play_new(snd_menu_move)
}
var maxcn=cup_number-1
if (cc=100 and global.special_lock) or (cc=150 and global.super_lock) or (highcclock)
{
	maxcn--
}
if global.cup>maxcn
{
	global.cup=0
}
if global.cup<0 global.cup=maxcn

obj_cup_ind.image_index=global.cup+1