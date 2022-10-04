var draw=false
if argument_count>0
{
	draw=argument[0]
}
for (var i=0;i<global.players;i++)
{
	var ins=player_get_instance(i+1)
	xx=ins.x
	yy=ins.y
	if draw
	{
		//ins=global.cam_object[view_current]
		var xx=global.cam_x[view_current]
		var yy=global.cam_y[view_current]
	}
	var ang=point_direction(x,y,xx,yy)+180
	var dis=point_distance(x,y,xx,yy)
	var dir=global.cam_zdir[view_current]+180
	var dif=angle_difference(ang,dir)+90
	
	var range=180
	if draw
	{
		draw_set_color(c_red)
		draw_line(xx,yy,xx+lengthdir_x(300,dir+range/2),yy+lengthdir_y(300,dir+range/2))
		draw_line(xx,yy,xx+lengthdir_x(300,dir-range/2),yy+lengthdir_y(300,dir-range/2))
		draw_reset()
	}
	if (dif>90-range/2 and dif<90+range/2)// or dis<32
	{
		return(1)
	}
	if draw
	{
		return(0)
	}
}
return(0)