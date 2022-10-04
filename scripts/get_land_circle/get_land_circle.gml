///@param x
///@param y
///@param land
///@param radio
///@param not_that_land
var xx=argument0
var yy=argument1
var range=argument2
var lnd=argument3
var reverse=argument4
for (var dir=0;dir<360;dir+=(360/8)/range)
{
	for (var o=0;o<range;o++)
	{
		var check1=get_land_onstage(xx+lengthdir_x(range*-1,dir),yy+lengthdir_y(range*-1,dir))
		var check2=get_land(xx+lengthdir_x(range,dir),yy+lengthdir_y(range,dir))
		if !reverse
		{
			if check1=lnd or check2=lnd
			{
				return(1)
			}
		}
		else
		{
			if check1!=lnd or check2!=lnd
			{
				return(1)
			}
		}
	}
}
return(0)