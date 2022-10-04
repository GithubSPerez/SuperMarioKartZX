if keyboard_check(vk_shift) and global.debug
{
	if keyboard_check(vk_alt)
	{
		//show_message("multicon activated")
		global.multicon=true
	}
	if global.joycon=false
	{
		control[0]=0
		control[1]=1
		control[2]=2
		control[3]=3
		control_number=3
	}
	else
	{
		control[0]=noone
		control[1]=noone
		control[2]=noone
		control[3]=noone
		control_number=0
	}
	global.joycon++
	global.joycon%=2
}