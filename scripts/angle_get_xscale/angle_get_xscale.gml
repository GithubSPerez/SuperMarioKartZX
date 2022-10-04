var angle=argument0
var dir=1
while angle>360 angle-=360
while angle<0 angle+=360

if angle>180
{
	angle=(angle*-1)+180*2
}
if angle>90 dir=-1
return(dir)