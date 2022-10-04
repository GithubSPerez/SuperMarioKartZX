global.hdivscreen=floor((global.players-1)/2)+1
var s=global.screen_scale

gpu_set_alphatestenable(true)
gpu_set_tex_repeat(true)
view_enabled = true;//Enable the use of views

for (var i=0;i<(floor((global.players-1)/2)+1)*2;i++)
{
	global.cam_x[i]=0
	global.cam_y[i]=0
	global.cam_z[i]=32

	global.cam_px[i]=0
	global.cam_py[i]=1
	global.cam_pz[i]=32

	c_xdir[i]=17
	c_ydir[i]=0
	c_zdir[i]=0
	global.cam_zdir[i]=0
	
	fz[i]=37
	plength[i]=41

	global.c_follow[i]=1
	global.cam_object[i]=obj_player
	
	view_set_visible(i, true);//Make this view visible
	view_set_wport(i,(global.screen_w/global.hdivscreen))
	view_set_hport(i,(global.screen_h/2))
	view_xport[i]=(global.screen_w/2)*(floor(i/2)%2)
	view_yport[i]=(global.screen_h/2)*(i%2)
	
	global.view_sur[i]=surface_create(view_wport[i]*s,view_hport[i]*s)
	view_surface_id[i]=global.view_sur[i]
	view_camera[i]=camera_create()
	x3d_create_camera(i)
}
if global.players=1 or global.players=3
{
	global.cam_object[global.players]=obj_map_view
	c_xdir[global.players]=66
	fz[global.players]=901*(global.track_type*0.5+1)
	plength[global.players]=-40
}

reposition=0

gpu_set_zwriteenable(true);//Enables writing to the z-buffer
//gpu_set_ztestenable(true);//Enables the depth testing, so far away things are drawn beind closer things
layer_force_draw_depth(true, 0);

display_set_gui_size(global.screen_w,global.screen_h)

global.maxrange=700

vis_dir=0