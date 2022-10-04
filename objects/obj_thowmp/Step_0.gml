if global.time_trial
{
	instance_destroy()
}
if z>16
{
	can_touch=0
}
else
{
	can_touch=1
}
if timer>0
{
	timer-=global.T
}
if timer<0
{
	timer=0
	if !fall and !ascend and alarm[0]<=0
	{
		fall=1
	}
}
if z<0
{
	z=0
	fall=0
	alarm[0]=floor(60/global.T)
}
if ascend
{
	vsp=0
	z+=0.5
	if z=32
	{
		timer=wait
		ascend=0
	}
}
deadly=0
if fall and !ded
{
	deadly=1
}
if !ded and starman 
{
	deadly=1
	image+=1/2
}