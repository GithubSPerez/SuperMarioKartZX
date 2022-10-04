//draw_sprite(mask_index,0,x,y)
if global.model[object_index]=-1
{
	global.model[object_index]=x3d_create_vplane(16,16)
}


var tex=sprite_get_texture(spr,image)
var rscale=sprite_get_height(spr)/32
var dscale=rscale


if 1 
{
	var render=1
	if render
	{
		//draw_set_alpha(alpha)
		x3d_draw_flat(global.model[object_index],tex,x,y,z+8*dscale,xdir,dscale*scale)
		//draw_reset()
	}
}
if ded=1
{
	audio_play_new(snd_itemdestroy)
	scale=-1
	vsp=2
	ded=2
	xsp=random_range(-1,1)
	ysp=random_range(-1,1)
}
if ded=2
{
	fall=1
	if z<-32 instance_destroy()
}
if fall
{
	vsp-=grav
	z+=vsp
	x+=xsp
	y+=ysp
}