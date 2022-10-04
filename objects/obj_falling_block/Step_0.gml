if falling
{
	image_speed=1
	if image_index=4
	{
		var l=instance_create_depth(x,y,depth,obj_black_square)
		l.sprite_index=sprite_index
		instance_destroy()
		exit
	}
}