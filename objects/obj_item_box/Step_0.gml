if global.time_trial
{
	instance_destroy()
}
image_index=full
var e=obj_land_manager
image_angle=e.obj[e_index,4]
if full=1
{
	timer+=global.T
	if timer>=4*60
	{
		full=0
		timer=0
	}
}