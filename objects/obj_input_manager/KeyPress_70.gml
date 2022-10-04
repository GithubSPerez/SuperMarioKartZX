if keyboard_check(vk_shift) and global.debug
{
	reset_players()
	global.scoreplace[0]=0
	room_goto(rm_finish)
}