if type=8 type=3
if type=3 hold=0
if hold exit
if type=1
{
	var block=instance_place(x+xsp,y+ysp,obj_wall)
	if block!=noone
	{
		unstuck()
		dir=point_direction(block.x+4,block.y+4,x,y)
		if camera_visible()
		{
			audio_play_new(snd_shell_hit)
		}
		hits++
		todir=dir
	}
	if hits>=10
	{
		instance_destroy()
		exit;
	}
}
if type=1 or type=2 or type=3
{
	xsp=lengthdir_x(spd,dir)
	ysp=lengthdir_y(spd,dir)
}
if type=2 or type=3
{
	if !follow
	{
		if type!=3
		{
			var pblock=instance_place(x,y,obj_track_path_cpu)
			if pblock!=noone
			{
				if pblock.type=1
				{
					instance_destroy()
				}
				tardir=pblock.angle
			}
			todir=tardir
			var correct_dis=2
			if get_land(x/8+lengthdir_x(correct_dis,dir+90),y/8+lengthdir_y(correct_dis,dir+90))!=0
			{
				todir-=4
				dir-=4
			}
			else
			if get_land(x/8+lengthdir_x(correct_dis,dir-90),y/8+lengthdir_y(correct_dis,dir-90))!=0
			{
				todir+=4
				dir+=4
			}
			var point_in=instance_place(x,y,obj_track_check)
			if !instance_exists(point_in)
			{
				var point_in=instance_nearest(x,y,obj_track_check)
				if instance_exists(point_in)
				{
					if !place_meeting(x,y,point_in)
					{
						x+=sign(point_in.x-x)
						y+=sign(point_in.y-y)
					}
					else
					{
						todir=point_in.image_angle
					}
				}
			}
			dir+=angle_difference(todir,dir)/6
		}
		else
		{
			var p1=place_get_instance(1)
			dir=point_direction(x,y,p1.x,p1.y)
		}
	}
	else
	{
		if type=3
		{
			near_p=place_get_instance(1)
		}
		dir=point_direction(x,y,near_p.x+4,near_p.y+4)
	}
	if !follow
	{
		near_p=instance_nearest(x,y,obj_player)
		if type=3
		{
			near_p=place_get_instance(1)
		}
		if near_p!=target
		{
			if point_distance(x,y,near_p.x+4,near_p.y+4)<64
			{
				follow=1
			}
		}
	}
	var block=instance_place(x+xsp,y+ysp,obj_wall)
	if block!=noone
	{
		if block.can_touch and type!=3
		{
			instance_destroy()
		}
	}
}
if type=3
{
	spd=5
}
var titem=instance_place(x,y,obj_obstacle)
if titem!=noone
{
	if titem.type!=3
	{
		instance_destroy(titem)
	}
	if type!=3
	{
		instance_destroy()
	}
}
x+=xsp*global.T
y+=ysp*global.T

var grav=0.3
var land=get_land(x/8,y/8)
if x<0 or x>global.xmaxland*8 or y<0 or y>global.ymaxland*8
{
	land=global.out_fill
}
zsp-=0.3*global.T
z+=zsp*global.T

if z<0 and land!=l_hole and land!=l_water_deep
{
	z=0
	zsp=0
	if type=0
	{
		xsp=0
		ysp=0
	}
}
if type=3
{
	z+=((24-16*follow+dsin(current_time)*4)-z)/6
	zsp=0
}
if z<0 and type!=3 instance_destroy()