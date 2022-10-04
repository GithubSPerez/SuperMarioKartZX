///@param timer
///@param how_much_is_second
///@param unit(0=second-1=minute)
var t=argument0
var tt=argument1
var u=argument2
if u=0
{
	var rs=(t/tt)
	return(rs%60)
}
else
{
	var rs=(t/tt/60)
	return(floor(rs%60))
}