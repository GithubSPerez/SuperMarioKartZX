vsp+=grav
z-=vsp
x+=xsp
y+=ysp
if z<-1
{
	ded=true
	instance_destroy()
}