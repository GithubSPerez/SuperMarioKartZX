if e.editmode!=mode 
{
	x=-1024
	image_yscale=0.1
	exit
}
x=e.pblock[index,p_x]
y=e.pblock[index,p_y]
image_yscale=e.pblock[index,p_size]

if abs(angle_difference(e.pblock[index,p_angle],e.pblock[index,p_direction]))>90
{
	e.pblock[index,p_angle]+=180
}
image_angle=e.pblock[index,p_angle]
dir=e.pblock[index,p_direction]
xd=x+lengthdir_x(24,dir)
yd=y+lengthdir_y(24,dir)

if step=0
keyboard_string=e.pblock[index,p_type]

step++
if 1//e.pediting=id
{
	if mouse_check_button_pressed(mb_left)
	{
		var range=8
		if mouse_x>xd-range and mouse_x<xd+range and mouse_y>yd-range and mouse_y<yd+range
		{
			edit=0
		}
		else
		{
			range=4
			if mouse_x>x-range and mouse_x<x+range and mouse_y>y-range and mouse_y<y+range
			{
				edit=1
			}
		}
	}
}
if e.pediting=id
{
	e.pblock[index,p_size]+=(keyboard_check(ord("L"))-keyboard_check(ord("K")))*0.25
	if e.pblock[index,p_size]<1 e.pblock[index,p_size]=1
	
	e.pblock[index,p_angle]+=(keyboard_check(ord("Q"))-keyboard_check(ord("E")))
	
	if mode=3
	{
		if keyboard_get_number()!=-1
		e.pblock[index,p_type]=clamp(keyboard_get_number(),0,9)
	}
	else
	{
		e.pblock[index,p_type]+=(keyboard_check_pressed(ord("M"))-keyboard_check_pressed(ord("N")))
		e.pblock[index,p_type]+=(keyboard_check_pressed(ord("J"))-keyboard_check_pressed(ord("H")))*5
		e.pblock[index,p_type]+=(keyboard_check_pressed(ord("U"))-keyboard_check_pressed(ord("Y")))*10
	}
	
	if keyboard_check_pressed(vk_backspace)
	{
		e.pblock[index,p_exists]=0
		e.pediting=noone
		e.pdestroyed++
		e.redpoint_number--
		instance_destroy()
		exit;
	}
	if keyboard_check_pressed(ord("P"))
	{
		instance_create_depth(x,y,-1,obj_orderer)
	}
	if mode=3
	{
		e.pblock[index,p_type]+=keyboard_check_pressed(ord("J"))
		e.pblock[index,p_type]%=2
	}
}
var tx=round(mouse_x/8)*8
var ty=round(mouse_y/8)*8
if edit=0 or (e.pediting=id and e.fastmode and keyboard_check(vk_shift))
{
	e.pblock[index,p_direction]=point_direction(x,y,mouse_x,mouse_y)
}
if edit=1 or (e.pediting=id and e.fastmode and keyboard_check(vk_alt))
{
	e.pblock[index,p_x]=mouse_x
	e.pblock[index,p_y]=mouse_y
}
if mouse_check_button_released(mb_left)
{
	edit=-1
}
if global.time%30=0
{
	
	
	for (var i=0;i<1024;i++)
	{
		ins=instance_place(x+dcos(dir)*i,y-dsin(dir)*i,obj_pblock)
		if ins!=noone
		{
			break
		}
	}
}
lborder_x=x+lengthdir_x(8*image_yscale,image_angle+90)
lborder_y=y+lengthdir_y(8*image_yscale,image_angle+90)
rborder_x=x+lengthdir_x(8*image_yscale,image_angle-90)
rborder_y=y+lengthdir_y(8*image_yscale,image_angle-90)
if !e.pblock[index,p_exists]
{
	instance_destroy()
}