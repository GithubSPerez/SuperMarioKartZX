if global.key_accept[global.realplayers]
{
	if !menu_open
	{
		instance_create_depth(0,0,depth-1,obj_menu)
		instance_destroy(obj_fake_player)
		instance_destroy(obj_fake_sprite)
		menu_open=1
	}
}