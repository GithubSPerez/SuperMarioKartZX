var xx=argument0
var yy=argument1
var range=argument2
var lnd=argument3
var dir=argument4
var reverse=false

if lnd=-1
{
	reverse=true
	lnd=0
}
for (var o=0;o<range;o++)
{
	if !reverse
	{
		if get_land(xx+lengthdir_x(range*-1,dir),yy+lengthdir_y(range*-1,dir))=lnd or get_land(xx+lengthdir_x(range,dir),yy+lengthdir_y(range,dir))=lnd
		{
			return(1)
		}
	}
	else
	{
		if get_land(xx+lengthdir_x(range*-1,dir),yy+lengthdir_y(range*-1,dir))!=lnd or get_land(xx+lengthdir_x(range,dir),yy+lengthdir_y(range,dir))!=lnd
		{
			return(1)
		}
	}
}
return(0)