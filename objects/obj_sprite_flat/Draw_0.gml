//draw_sprite(mask_index,0,x,y)
var tex=sprite_get_texture(spr,image)
var rscale=sprite_get_height(spr)/32
var e=obj_land_manager
image_angle=e.obj[e_index,4]
x3d_draw_plane(drawing,tex,x,y,z+8*rscale,xangle,yangle,image_angle,rscale*scale,rscale*scale,-rscale*scale,true)
if ded=1
{
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