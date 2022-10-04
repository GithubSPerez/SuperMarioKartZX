#region changing track
var tchange=keyboard_check_pressed(vk_up)-keyboard_check_pressed(vk_down)
var ttchange=0//keyboard_check_pressed(ord("Y"))
if  tchange!=0 or ttchange
{
	save(track)
	global.track+=tchange
	if global.track<0 global.track=0
	var tmax=sprite_get_number(spr_tracks)-1
	if global.track>tmax global.track=tmax
	info_save()
	room_restart()
	exit
}
#endregion

if outdated exit

#region collisions
if editmode=0
{
	key=keyboard_get_number()
	if key>=0 and key<=9
	index=key

	x=clamp(floor(mouse_x/8)*8,0,global.xmaxland*8-8*(scale))
	y=clamp(floor(mouse_y/8)*8,0,global.ymaxland*8-8*(scale))
	if keyboard_check(vk_space) or mouse_check_button(mb_left)
	{
		if keyboard_check(vk_shift)
		{
			var paint=instance_create_depth(x,y,-1,obj_painter)
			paint.ind=collision[(x/8),(y/8)]
			paint.toind=index
		}
		else
		{
			for (var kx=0;kx<scale;kx++)
			{
				for (var ky=0;ky<scale;ky++)
				{
					collision[(x/8)+kx,(y/8)+ky]=index
				}
			}
		}
	}
}
#endregion
#region paths
if editmode=1 or editmode=3
{
	x=mouse_x
	y=mouse_y
	var xx=x//round(mouse_x/8)*8
	var yy=y//round(mouse_y/8)*8
	preangle+=keyboard_check(ord("Q"))-keyboard_check(ord("E"))
	presize+=(keyboard_check(ord("L"))-keyboard_check(ord("K")))/4
	if keyboard_check_pressed(ord("Z"))
	{
		var i=pindex
		pblock[i,p_exists]=1
		pblock[i,p_x]=xx+8
		pblock[i,p_y]=yy+8
		pblock[i,p_size]=presize
		pblock[i,p_angle]=preangle
		pblock[i,p_direction]=90
		pblock[i,p_cpu]=0
		pblock[i,p_type]=0
		var ins=instance_create_depth(pblock[i,p_x],pblock[i,p_y],-1,obj_pblock)
		ins.index=pindex
		pediting=ins
		if editmode=3
		{
			pblock[i,p_cpu]=1
			ins.mode=3
		}
		else
		{
			redpoint_number++
		}
		pindex++
	}
	if mouse_check_button(mb_left)
	{
		var check=1
		if instance_exists(pediting)
		{
			if pediting.edit!=-1
			{
				check=0
			}
		}
		if place_meeting(x,y,obj_pblock) and check
		{
			pediting=instance_place(x,y,obj_pblock)
		}
	}
	
	fastmode+=keyboard_check_pressed(ord("F"))
	fastmode%=2
	
	if keyboard_check_pressed(ord("N")) and key_check(vk_alt,0)
	{
		thot=0
		norsize=0
		with obj_pblock
		{
			if other.pblock[index,p_cpu]
			{
				other.norsize+=image_yscale
				other.thot++
			}
		}
		norsize/=thot
		with obj_pblock
		{
			if other.pblock[index,p_cpu]
			other.pblock[index,p_size]=other.norsize
		}
	}
}
#endregion
#region goal
if editmode=2
{
	x=floor(mouse_x/8)*8
	y=floor(mouse_y/8)*8
	if mouse_check_button(mb_left)
	{
		goal_x=x
		goal_y=y
	}
	goal_xscale+=keyboard_check_pressed(ord("L"))-keyboard_check_pressed(ord("J"))
	goal_yscale+=keyboard_check_pressed(ord("K"))-keyboard_check_pressed(ord("I"))
}
#endregion
#region objects
if editmode=4
{
	x=floor(mouse_x/8)*8
	y=floor(mouse_y/8)*8
	if keyboard_check(vk_shift)
	{
		x=mouse_x
		y=mouse_y
	}
	obj_top+=keyboard_check_pressed(ord("M"))-keyboard_check_pressed(ord("N"))
	obj_top=clamp(obj_top,obj_item_box,obj_player_manager)
	
	obj_rotation+=(keyboard_check_pressed(ord("Q"))-keyboard_check_pressed(ord("E")))*(90/(key_check(vk_shift,0)+1))
	var doit=keyboard_check(vk_space) or (keyboard_check(vk_alt) and keyboard_check_pressed(vk_space))
	if doit
	{
		var sel=instance_place(x,y,obj_preview)
		if sel=noone
		{
			obj[obj_ind,0]=1
			obj[obj_ind,1]=x
			obj[obj_ind,2]=y
			obj[obj_ind,3]=obj_top
			obj[obj_ind,4]=obj_rotation
			obj[obj_ind,5]=0
			obj[obj_ind,6]=0
			obj[obj_ind,7]=0
			var ins=instance_create_depth(x,y,depth-1,obj_preview)
			ins.index=obj_ind
			obj_selected=ins
			obj_ind++
			obj_count++
		}
		else
		{
			obj_selected=sel
		}
	}
	if keyboard_check(ord("B"))
	{
		var del=instance_place(x,y,obj_preview)
		if del!=noone
		{
			obj[del.index,0]=0
			obj_count--
			instance_destroy(del)
		}
	}
	if !instance_exists(obj_selected)
	{
		obj_selected=noone
	}
}
#endregion
#region BG
if editmode=5
{
	if input_type=0
	{
		if keyboard_check_pressed(ord("R"))
		{
			keyboard_string=string(r_col)
			input_type=1
		}
		if keyboard_check_pressed(ord("G"))
		{
			keyboard_string=string(g_col)
			input_type=2
		}
		if keyboard_check_pressed(ord("B"))
		{
			keyboard_string=string(b_col)
			input_type=3
		}
	}
	if input_type=1
	{
		r_col=keyboard_string
	}
	if input_type=2
	{
		g_col=keyboard_string
	}
	if input_type=3
	{
		b_col=keyboard_string
	}
	if keyboard_check_pressed(vk_enter)
	{
		keyboard_string=""
		r_col=string_digits(r_col)
		g_col=string_digits(g_col)
		b_col=string_digits(b_col)
		global.bg_col=make_color_rgb(r_col,g_col,b_col)
		input_type=0
	}
	if keyboard_check(vk_shift)
	{
		global.bg_front_img+=keyboard_check_pressed(ord("M"))-keyboard_check_pressed(ord("N"))
	}
	else
	{
		global.bg_img+=keyboard_check_pressed(ord("M"))-keyboard_check_pressed(ord("N"))
	}
	global.bg_fill_img+=keyboard_check_pressed(ord("J"))-keyboard_check_pressed(ord("H"))
	global.out_fill+=keyboard_check_pressed(ord("L"))-keyboard_check_pressed(ord("K"))
	global.bg_fill_img%=sprite_get_number(spr_bg_fill)
	global.out_fill%=10
}
else
{
	input_type=0
}
#endregion
#region auto fill
if editmode=6
{
	if !instance_exists(obj_terrain_detector)
	{
		instance_create_depth(0,0,depth-1,obj_terrain_detector)
	}
}
else
{
	if instance_exists(obj_terrain_detector)
	{
		instance_destroy(obj_terrain_detector)
	}
}
#endregion
#region music
if editmode=7
{
	var s=global.song
	if !audio_is_playing(global.music[s,0])
	{
		audio_stop_all()
		audio_play_sound(global.music[s,0],1,0)
	}
	
	var maxsong=array_height_2d(global.music)-1
	global.song+=(keyboard_check_pressed(ord("M"))-keyboard_check_pressed(ord("N")))*(1+5*keyboard_check(vk_shift))
	if global.song>maxsong
	{
		global.song=0
	}
	if global.song<0
	{
		global.song=maxsong
	}
}
else
{
	audio_stop_all()
}
#endregion
#region track type
if editmode=8
{
	if key_check("P",1)
	{
		global.track_type++
		global.track_type%=2
		
		global.xmaxland=128*(global.track_type+1)
		global.ymaxland=global.xmaxland
	}
	global.big_image+=key_check("M",1)-key_check("N",1)
	global.big_image%=sprite_get_number(spr_tracks_big)
}
#endregion
#region cancel feather
if editmode=9
{
	global.feather+=key_check("F",1)
	global.feather%=2
}
#endregion

if keyboard_check_pressed(vk_enter)
{
	save(track)
}
editmode+=keyboard_check_pressed(vk_right)-keyboard_check_pressed(vk_left)
/*
if keyboard_check_pressed(vk_right)-keyboard_check_pressed(vk_left)!=0
{
	instance_activate_all()
	with obj_pblock
	{
		if mode!=editmode
		{
			instance_deactivate
		}
	}
}
*/
layer_background_blend(layer_background_get_id(layer_get_id("Color")),global.bg_col)

if editmode<0 editmode=0
scale+=keyboard_check_pressed(ord("C"))-keyboard_check_pressed(ord("X"))
if scale<1 scale=1
var cam_spd=4*global.T
cam_x+=(keyboard_check(ord("D"))-keyboard_check(ord("A")))*cam_spd
cam_y+=(keyboard_check(ord("S"))-keyboard_check(ord("W")))*cam_spd
camera_set_view_pos(cam,cam_x,cam_y)
camera_set_view_size(cam,global.screen_w*scale,global.screen_h*scale)
if keyboard_check_pressed(vk_escape)
{
	save(track)
	room_goto(rm_game)
}
if keyboard_check_pressed(ord("T"))
{
	global.bg_type++
	global.bg_type%=2
	global.bg_img=0
}