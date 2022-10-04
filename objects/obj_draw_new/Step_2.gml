spd=4
rotspd=0.2
vsp=(keyboard_check(ord("W"))-keyboard_check(ord("S")))*spd
hsp=(keyboard_check(ord("D"))-keyboard_check(ord("A")))*spd
for (var i=0;i<clamp(global.players,2,8);i++)
{
	var ob=global.cam_object[i]
	if !instance_exists(ob)
	{
		global.cam_object[i]=id
		ob=id
	}
	if ob.object_index=obj_player
	{
		fz[i]=37
	}
	if global.c_follow[i]
	{
		c_zdir[i]=global.cam_object[i].vis_dir+180
		var tox=global.cam_object[i].x+4
		var toy=global.cam_object[i].y+4
		var zadd=0
		if ob.object_index=obj_player
		{
			fz[i]-=ob.smin_z/2
		}
		var tz=fz[i]+lengthdir_y(1,c_xdir[i])+zadd
		var len=plength[i]
		if global.cam_object[i].object_index=obj_player
		{
			len=plength[i]*global.cam_object[i].camera_distance
		}
		global.cam_x[i]=tox+lengthdir_x(len,c_zdir[i])
		global.cam_y[i]=toy+lengthdir_y(len,c_zdir[i])
		global.cam_z[i]=fz[i]

		global.cam_px[i]=global.cam_x[i]+lengthdir_x(-1,c_zdir[i])*lengthdir_x(1,c_xdir[i])
		global.cam_py[i]=global.cam_y[i]+lengthdir_y(-1,c_zdir[i])*lengthdir_x(1,c_xdir[i])
		global.cam_pz[i]=tz
	
		global.cam_xdir[i]=c_xdir[i]
		global.cam_zdir[i]=c_zdir[i]
	}
}
if keyboard_check_pressed(vk_escape) and global.debug
{
	room_goto(rm_editor)
}
#region updating 3d cam
for (var i=0;i<clamp(global.players,2,8);i++)
{
	var zz = global.cam_z[i]
	var xx = global.cam_x[i]
	var yy = global.cam_y[i]

	var pzz = global.cam_pz[i]
	var pxx = global.cam_px[i]
	var pyy = global.cam_py[i]

	//Build a matrix that looks from the camera location above, to the room center. The up vector points to -z
	mLookat = matrix_build_lookat(xx,yy,zz,pxx,pyy,pzz,0,0,-1);

	//Assign the matrix to the camera. This updates were the camera is looking from, without having to unnecessarily update the projection.
	camera_set_view_mat(view_camera[i], mLookat);
}
#endregion
#region lag
if global.track=26// and global.time_trial
{
	instance_deactivate_object(obj_sprite)
	with obj_player
	{
		if !cpu
		{
			var range=global.maxrange
			var xx=global.cam_x[player-1]+lengthdir_x(range/2,global.cam_zdir[player-1]+180)
			var yy=global.cam_y[player-1]+lengthdir_y(range/2,global.cam_zdir[player-1]+180)
			instance_activate_region(xx-range/2,yy-range/2,range,range,true)
		}
	}
}
if fps<58 global.maxrange--
if global.time%6=3
{
	if fps>58
	{
		global.maxrange++
	}
	if global.maxrange<250
	{
		global.maxrange=250
	}
}
#endregion
#region reposition (FINAL)
if !reposition exit;
plength[1]+=(keyboard_check(ord("S"))-keyboard_check(ord("W")))
c_xdir[1]+=(keyboard_check(vk_space)-keyboard_check(vk_shift))
fz[1]+=(keyboard_check(vk_up)-keyboard_check(vk_down))
#endregion