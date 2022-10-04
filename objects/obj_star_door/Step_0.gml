/// @description Insert description here
// You can write your code in this editor
toangle=dsin(global.time*5)*4
yangle+=(toangle-yangle)/6
x+=(xstart-x)/6

if place_meeting(x-8,y,obj_player)
{
	yangle+=180*5
	x=xstart-16
}