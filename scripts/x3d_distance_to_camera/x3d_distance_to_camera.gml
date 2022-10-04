///@func x3d_distance_to_camera()
///@param x "
///@param y "
///@param z "
///@param cam id "
var x1=argument0
var y1=argument1
var z1=argument2
var cam=argument3
var x2=global.cam_x[cam]
var y2=global.cam_y[cam]
var z2=global.cam_z[cam]
return(point_distance_3d(x1,y1,z1,x2,y2,z2))