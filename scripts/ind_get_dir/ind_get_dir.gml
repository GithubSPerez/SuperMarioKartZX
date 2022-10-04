var DIR=argument0
var X=floor(argument1)
var Y=floor(argument2)
if X=xlimit and Y=ylimit
{
	DIR=0
}
if X=room_width-xlimit and Y=ylimit
{
	DIR=-90
}
if X=room_width-xlimit and Y=room_height-ylimit
{
	DIR=180
}
if X=xlimit and Y=room_height-ylimit
{
	DIR=90
}
return DIR