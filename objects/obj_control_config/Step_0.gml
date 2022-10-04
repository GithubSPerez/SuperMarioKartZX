if deactive>0
{
	deactive--
	exit
}
if !active exit
var mp=global.realplayers
if instance_exists(config) exit
if global.key_cancel[mp]
{
	audio_play_new(snd_menu_back)
	room_transition(rm_menu)
	active=false
	exit
}
total_c=gamepad_get_device_count()

device+=global.key_down_press[mp]-global.key_up_press[mp]
while !gamepad_is_connected(device)
{
	device++
	if device>=total_c
	{
		device=0
		break
	}
}

if device<0 device=total_c-1

if global.key_start_press[mp]
{
	create=true
}
if create
{
	if !global.key_start[mp]
	{
		config=instance_create_depth(x,y,depth,obj_gamepad)
		config.device=device
		config.start=1
		create=false
	}
}