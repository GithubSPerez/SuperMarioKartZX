if !done
{
	for (var i=0;i<1024;i++)
	{
		ins=instance_place(x+dcos(angle)*i,y-dsin(angle)*i,obj_track_path_cpu)
		if ins!=noone
		{
			break
		}
	}
	if type!=1
	{
		if ins!=noone
		{
			ch=instance_create_depth((x+ins.x)/2,(y+ins.y)/2,depth,obj_track_check)
			ch.image_angle=point_direction(x,y,ins.x,ins.y)
			ch.image_yscale=image_yscale/2
			ch.image_xscale=point_distance(x,y,ins.x,ins.y)/8+4
			ch.point_to=ins
			ch.point_from=id
		}
	}
}
done=true