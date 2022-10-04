if place_meeting(x,y,obj_painter)
{
	instance_destroy()
	exit
}
var xi=x/8
var yi=y/8
xof[0]=0
xof[1]=1
xof[2]=0
xof[3]=-1

yof[0]=-1
yof[1]=0
yof[2]=1
yof[3]=0
for (var i=0;i<4;i++)
{
	var chx=clamp(xi+xof[i],0,127)
	var chy=clamp(yi+yof[i],0,127)
	if obj_editor.collision[chx,chy]=ind
	{
		//show_message("yes")
		obj_editor.collision[chx,chy]=toind
		var paint=instance_create_depth(chx*8,chy*8,-1,obj_painter)
		paint.toind=toind
		paint.ind=ind
	}
}
obj_editor.collision[xi,yi]=toind
instance_destroy()