var e=obj_editor
spr=object_get_sprite(e.obj[index,3])
sprite_index=spr

image_blend=c_white
if e.obj_selected=id
{
	image_blend=c_lime
	var o=e.obj[index,3]
	if o=obj_item_box or o=obj_boost or o=obj_ramp or o=obj_ramp_inv
	{
		e.obj[index,4]+=(keyboard_check_pressed(ord("Q"))-keyboard_check_pressed(ord("E")))*90
	}
}
image_angle=e.obj[index,4]

var delme=instance_place(x,y,obj_preview)
if delme!=noone
{
	if delme.x=x and delme.y=y
	{
		obj_editor.obj[index,0]=0
		obj_editor.obj_count--
		instance_destroy()
		exit
	}
}