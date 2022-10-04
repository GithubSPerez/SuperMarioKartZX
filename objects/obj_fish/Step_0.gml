if go
{
	if hspeed>-spd
	{
		hspeed-=acel
	}
}
else
{
	if hspeed<0
	{
		hspeed+=acel
	}
}
image_speed=hspeed/spd
if state=0
{
	if x<tox+16
	{
		go=0
		state=1
	}
}
if state=1
{
	if hspeed=0
	{
		state=2
		alarm[0]=60
	}
}
if state=2
{
	image_xscale=1+dcos((50-alarm[0])*50)*0.02
	if alarm[0]%10=0
	{
		audio_play_new(snd_jump)
	}
	alarm[0]--
	if alarm[0]=0
	{
		var t=instance_create_depth(tox,y,depth-1,obj_falling_trohpie)
		t.vsp=-6
		state=3
		alarm[1]=120
		image_xscale=1
		audio_stop_sound(snd_jump)
	}
}
if state=3
{
	alarm[1]--
	if alarm[1]=0
	{
		obj_finish.recieved=1
		go=1
		state=4
	}
}
if state=4
{
	if x<room_width/3+32
	{
		obj_finish.pop=1
		state=5
	}
}
if state=5
{
	if x<0
	{
		obj_finish.state=1
		state=6
	}
}
if place_meeting(x,y,obj_pop)
{
	explode=1
	instance_destroy(obj_pop)
}
if explode=1
{
	image_xscale-=0.01
	if image_xscale<0.01 image_xscale=0.01
	ex_timer++
	go=0
	
	var multi=15
	var length=image_xscale*64
	
	image_angle=ex_timer*multi+90
	x+=5-image_xscale*5
	y=ystart+dsin(ex_timer*multi)*length
	if x>room_width*2
	{
		audio_play_new(snd_grow)
		obj_finish.state=1
		instance_destroy()
	}
}
if floor(image_index)=0
{
	if !sound
	{
		audio_play_new(snd_itemdestroy)
		sound=true
	}
}
else
{
	sound=false
}
image_yscale=image_xscale