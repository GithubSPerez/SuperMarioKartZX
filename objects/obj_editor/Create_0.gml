audio_stop_intro()
audio_stop_all()
editmode=0
info_load()
track=global.track

outdated=0
//window_set_size(global.screen_w*3,global.screen_h*3)

//window_set_position(display_get_width()/2-global.screen_w*3/2,display_get_height()/2-global.screen_h*3/2)

display_set_gui_size(global.screen_w,global.screen_h)

#region collisions
size=256
for (var i=0;i<size;i++)
{
	for (var j=0;j<size;j++)
	{
		collision[i,j]=0
	}
}
index=0
#endregion

#region paths
#region macros

#endregion
pblock[0,p_exists]=0
pindex=0
pediting=noone
pdestroyed=0
preangle=90
presize=8

fastmode=0
#endregion

#region goal
goal_x=0
goal_y=0
goal_xscale=1
goal_yscale=1
#endregion

#region generic objects
obj[0,0]=0
obj_ind=0
obj_count=0
obj_top=obj_item_box
obj_selected=noone
obj_rotation=0
#endregion

redpoint_number=0
global.bg_img=0
global.bg_front_img=0
global.bg_fill_img=0
global.out_fill=l_lakitu
global.bg_col=c_white
global.bg_type=0
load(track)

r_col=color_get_red(global.bg_col)
g_col=color_get_green(global.bg_col)
b_col=color_get_blue(global.bg_col)
input_type=0
scale=1
cam=camera_create()
cam_x=0
cam_y=0
view_set_camera(0,cam)
vs=surface_create(256,224)
//view_surface_id[0]=vs

reset_players()