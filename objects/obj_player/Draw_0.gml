//draw_sprite(spr_object,0,xcoord*8,ycoord*8)
//draw_self()
draw_spr=1
nearone=place_get_instance(place+1)
var nd=0
if instance_exists(nearone)
{
	nd=point_distance(x+4,y+4,nearone.x+4,nearone.y+4)<20
}
if win or z>0 or nd or preparing>0 or lookback or global.time_trial or instance_exists(itmins)
{
	draw_spr=0
}

if show_cpu
{
	player=1
}
if view_current!=player-1 or !draw_spr
{
	var toang=(obj_draw_new.c_zdir[view_current]-dir)-90
	var tempind=get_angle_index(toang,8,12)
	if lookback
	{
		tempind=11
	}
	var xsc=angle_get_xscale(toang)
	if view_current=player-1 and !win and preparing=0 and !lookback
	{
		tempind=abs(index)
		xsc=-xscale
	}
	var tex=sprite_get_texture(spr,tempind)
	var dr=1
	if ghost>0
	{
		dr=floor(current_time/2)%2
		if view_current!=player-1
		{
			dr=0
		}
	}
	var col=c_white
	if star
	{
		col=make_color_hsv(current_time%255,255,240)
	}
	d_scale=s_scale
	/*
	d_scale*=(x3d_distance_to_camera(x,y,-z,view_current)/(32*2))
	d_scale/=floor((x3d_distance_to_camera(x,y,-z,view_current)/(32*2))*2)/2
	*/
	if dr
	{
		if star
		{
			var col=make_color_hsv(current_time%255,255,255)
			shader_set(sh_blend)
			shader_set_uniform_f(shader_get_uniform(sh_blend,"Red"),color_get_red(col)*100)
			shader_set_uniform_f(shader_get_uniform(sh_blend,"Green"),color_get_green(col)*100)
			shader_set_uniform_f(shader_get_uniform(sh_blend,"Blue"),color_get_blue(col)*100)
		}
		//show_message(col)
		x3d_draw_flat(wall,tex,x+4,y+4,-z/2+8*d_scale+roadeffect/2-0.5,xsc,d_scale)//s_scale)
		shader_reset()
	}
}
if show_cpu
{
	player=-1
}
if global.debug
{
	/*
	if instance_exists(point_to)
	draw_sprite(spr_object,0,point_to.x,point_to.y)
	*/
}
//draw_line(lneed.x,lneed.y,lneed.x+lengthdir_x(ldistance,spa),lneed.y+lengthdir_y(ldistance,spa))
