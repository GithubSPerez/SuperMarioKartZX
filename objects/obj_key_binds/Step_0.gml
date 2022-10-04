var mp=global.realplayers
var im=obj_input_manager
if !active exit
if setting=0
{
	player+=(global.key_down_press[mp]-global.key_up_press[mp])

	if player=-1 player=3
	if player=4 player=0
	
	if global.key_a_press[mp]
	{
		room_transition(rm_menu)
		active=false
		exit
	}
	if global.key_start_press[mp]
	{
		doit=true
	}
	if !global.key_start[mp] and doit
	{
		setting=true
		doit=false
	}
}
else if setting=1
{
	if key_check(vk_escape,1)
	{
		with im
		{
			load_input()
		}
		setting=0
		key=0
		exit
	}
	if key_check(vk_anykey,1)
	{
		im.joykey[player,key]=keyboard_lastkey
		key++
		if key=skip key++
		if key=im.key_numb
		{
			key=0
			setting=2
			alarm[0]=10
			with im
			{
				save_input()
			}
		}
	}
}