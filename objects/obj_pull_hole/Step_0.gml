if y<512
{
	var e=obj_land_manager
	angle=e.obj[e_index,4]
	found=true
}
if found exit
with obj_pull_hole
{
	if id!=other.id
	{
		var e=obj_land_manager
		other.angle=e.obj[e_index,4]
		other.tox=x
		other.toy=y
		other.found=true
	}
}
image_angle=angle