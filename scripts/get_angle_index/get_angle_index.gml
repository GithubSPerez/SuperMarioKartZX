///@func get_angle_index()
///@param angle "
///@param 90º_index "
///@param 180º_index "
var angle=argument0
var ind_90=argument1
var ind_180=argument2
var Index=0
var divi=1
angle-=90
while angle>360 angle-=360
while angle<0 angle+=360

if angle>180
{
	angle=(angle*-1)+180*2
}
if angle>=0 and angle<=90
{
	divi=90/ind_90
	Index=angle/divi
}
if angle>90 and angle<=180
{
	angle-=90
	divi=90/(ind_180-ind_90)
	Index=ind_90+angle/divi
}
return(Index)