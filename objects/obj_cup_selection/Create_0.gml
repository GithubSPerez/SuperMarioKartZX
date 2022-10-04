cc=real(cc_get_string())
kk=clamp(cc,0,150)

cup_number=global.totalcups-(3-(kk/50))

pause=0
var ind=instance_create_depth(32,48,depth-1,obj_cup_ind)
ind.creator=1

highcclock=false
if cc>150
{
	for (var i=0;i<4;i++)
	{
		highcclock+=clamp(global.cup_won[cc/50-1,i],0,1)/4
	}
	if highcclock<1 highcclock=1
	else highcclock=0
}