if gravity=0
{
	y=ystart+dsin(global.time*20+72*inumb)/1.5
}
if star
{
	image_blend=make_color_hsv(current_time%255,255,240)
}
if hit
{
	var angle=global.time*15
	image_index=get_angle_index(angle,7,11)
	image_xscale=angle_get_xscale(angle)
}
if type=0 or type=1
{
	if sprite_index!=spr_yoshi
	{
		if x>32
		{
			if spawn=0
			{
				create_fake_player((type+1)%2)
				spawn=1
			}
		}
	}
	else
	{
		if x>room_width/5 and spawn=0
		{
			create_fake_player(2)
			spawn=1
		}
		if spawn=1 and place_meeting(x,y,obj_fake_sprite)
		{
			instance_destroy(obj_fake_sprite)
			spawn=2
			hit=1
			hspeed=-2
		}
		if x<0 and spawn=2
		{
			create_fake_player(3)
			spawn=3
		}
	}
}
if type=1
{
	y-=8
}
if type=2
{
	if x>room_width/5 and spawn=0
	{
		var shell=instance_create_depth(x,y-8,depth+1,obj_fake_sprite)
		shell.hspeed=4
		spawn=1
	}
	if spawn=1
	{
		if place_meeting(x,y,obj_fake_player)
		{
			hspeed=2.2
		}
	}
}
if type=3
{
	if x>64
	{
		if spawn=0
		{
			create_fake_player(4)
			spawn=1
		}
	}
	if x>room_width/3*2 and spawn=1
	{
		var banana=instance_create_depth(x,y-8,depth+1,obj_fake_sprite)
		banana.sprite_index=spr_banana
		banana.hspeed=-1
		spawn=2
	}
}
if type=4
{
	if spawn=0
	{
		if place_meeting(x,y,obj_fake_sprite)
		{
			hit=1
			hspeed=-2.5
			instance_destroy(obj_fake_sprite)
			spawn=1
		}
	}
	if spawn=1
	{
		if x<room_width/5*2
		{
			var banana=instance_create_depth(x,y-8,depth+1,obj_fake_sprite)
			banana.sprite_index=spr_banana
			banana.hspeed=-1
			spawn=2
		}
	}
	if spawn=2
	{
		if x<-16
		{
			instance_destroy(obj_fake_player)
			create_fake_player(5)
		}
	}
}
if type=5
{
	if spawn=0
	{
		if place_meeting(x-16,y,obj_fake_sprite)
		{
			instance_destroy(obj_fake_sprite)
			spawn=1
			hspeed=0
			hit=1
		}
	}
	if floor(spawn)=1
	{
		spawn+=0.1
	}
	if spawn=2
	{
		create_fake_player(6)
		spawn=3
	}
	if spawn=3
	{
		var tp=instance_place(x+80,y,obj_fake_player)
		if tp!=noone
		{
			if tp.sprite_index=spr_koopa
			{
				hit=0
				star=1
				hspeed=3
				image_index=7
				image_xscale=1
			}
		}
	}
	
}
if type=6
{
	if sprite_index!=spr_koopa
	{
		if spawn=0
		{
			create_fake_player(7)
			spawn=1
		}
		if spawn=1
		{
			if x>0
			{
				create_fake_player(6)
				spawn=2
			}
		}
	}
	else
	{
		if x>0 and spawn=0
		{
			spawn=2
		}
	}
	if spawn=2
	{
		tp=instance_place(x,y,obj_fake_player)
		if tp!=noone
		{
			if tp.star
			{
				hit=1
				hspeed=-2
				spawn=3
			}
		}
	}
	if spawn=3 and sprite_index=spr_luigi
	{
		if x<-128
		{
			instance_destroy(obj_fake_player)
			create_fake_player(1)
		}
	}
}
if type=7
{
	hspeed=-1
}
if type=8
{
	hspeed=1.5
	hit=1
	if x>room_width+100
	{
		instance_destroy()
	}
}
if type=9
{
	hspeed=1
	if x>room_width*0.75
	{
		type=10
		if inumb!=ch_koopa+1
		{
			create_fake_player(irandom_range(0,9))
		}
	}
}
if type=10
{
	hspeed+=(-1.5-hspeed)/10
	image_xscale=-1
	if y>ystart and gravity!=0
	{
		gravity=0
		vspeed=0
	}
	if place_meeting(x-24,y,obj_fake_player) and gravity=0
	{
		gravity=0.1
		vspeed=-3
	}
}