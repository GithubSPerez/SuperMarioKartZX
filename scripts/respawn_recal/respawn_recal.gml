///@param range
var range=argument0
torx1=checkp_x+lengthdir_x(checkp_l,checkp_ang)
tory1=checkp_y+lengthdir_y(checkp_l,checkp_ang)
torx2=checkp_x+lengthdir_x(checkp_l-8,checkp_ang)
tory2=checkp_y+lengthdir_y(checkp_l-8,checkp_ang)
cl=0
var range=40
for (var i=-range/2;i<range;i++)
{
	if get_land(torx2/8-1,tory2/8)=0 and get_land(torx2/8+1,tory2/8)=0  and get_land(torx2/8,tory2/8-1)=0 and get_land(torx2/8,tory2/8+1)=0
	{
		cl=i
		return(1)
	}
	torx2=checkp_x+lengthdir_x(checkp_l-8,checkp_ang+i)
	tory2=checkp_y+lengthdir_y(checkp_l-8,checkp_ang+i)
}
return(0)
if 0//cl=0
{
	cl=get_land(x/8,y/8)!=0
}