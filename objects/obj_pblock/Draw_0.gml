if e.editmode!=mode exit
if step<2 exit;
var color=c_dkgray
var ob=e.pblock[index,p_type]
if ob=1
{
	color=c_red
}
if ob=2
{
	color=c_blue
}
if ob=3
{
	color=merge_color(c_purple,c_black,0.5)
}
if ob=4
{
	color=merge_color(c_blue,c_black,0.5)
}
if mode=1
{
	color=c_red
}
draw_sprite_ext(spr_pblock,0,x,y,1,image_yscale,image_angle,color,1)
draw_sprite_ext(spr_pblock_arrow,0,x,y,2,1,dir,color,1)
if mode=3
{
	draw_set_color(c_black)
	draw_circle(x,y,5,1)
	draw_circle(x,y,3,1)
	draw_set_color(c_white)
	if e.pediting=id
	{
		draw_set_color(c_blue)
	}
	draw_circle(x,y,4,1)
}
else
{
	draw_set_color(c_white)
	if e.pediting=id
	{
		draw_set_color(c_blue)
	}
	draw_text(x,y,e.pblock[index,p_type])
}
if instance_exists(ins) and e.pblock[index,p_type]=0
{
	var pcx=(x+ins.x)/2
	var pcy=(y+ins.y)/2
	/*
	var pdis=point_distance(rborder_x,rborder_y,ins.rborder_x,ins.rborder_y)
	var pdis2=point_distance(lborder_x,lborder_y,ins.lborder_x,ins.lborder_y)
	
	if pdis2>pdis
	{
		pdis=pdis2
	}
	*/
	var pdis=point_distance(x,y,ins.x,ins.y)
	var pdir=point_direction(x,y,ins.x,ins.y)
	draw_sprite_ext(spr_pblock,0,pcx,pcy,pdis/8,image_yscale,pdir,c_aqua,0.1)
	/*
	draw_line(lborder_x,lborder_y,ins.lborder_x,ins.lborder_y)
	draw_line(rborder_x,rborder_y,ins.rborder_x,ins.rborder_y)
	*/
}
//draw_circle(xd,yd,8,1)