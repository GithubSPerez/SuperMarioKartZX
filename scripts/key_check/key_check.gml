///@param key
///@param held-pressed-released(0-1-2)
var v=argument0
var t=argument1
if is_string(argument0)
{
	v=ord(argument0)
}
if t=0
{
	return(keyboard_check(v))
}
else if t=1
{
	return(keyboard_check_pressed(v))
}
else if t=2
{
	return(keyboard_check_released(v))
}