///@func x3d_camera_set_pos()
///@param id "
///@param x "
///@param y "
///@param z "
///@param relative "
var In=argument0
var cX=argument1
var cY=argument2
var cZ=argument3
if argument4
{
	global.x3d_cam[In,0]+=cX
	global.x3d_cam[In,1]+=cY
	global.x3d_cam[In,2]+=cZ
}
else
{
	global.x3d_cam[In,0]=cX
	global.x3d_cam[In,1]=cY
	global.x3d_cam[In,2]=cZ
}