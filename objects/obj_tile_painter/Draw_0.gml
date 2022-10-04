draw_self()
if clamp(x,0,2048)!=x or clamp(y,0,2048)!=y
{
	tile=-1
}
if place_meeting(x,y,obj_tile_painter) or tile=-1
{
	instance_destroy()
	exit
}
var xi=x-4
var yi=y-4
xof[0]=0
xof[1]=1
xof[2]=0
xof[3]=-1

yof[0]=-1
yof[1]=0
yof[2]=1
yof[3]=0

var cnv=obj_brush.canvas
for (var i=0;i<4;i++)
{
	var chx=x+xof[i]*8
	var chy=y+yof[i]*8
	if surface_getpixel(cnv,chx,chy)=col
	{	
		//show_message(string(surface_getpixel(cnv,chx,chy))+","+string(col))
		var paint=instance_create_depth(chx,chy,-1,obj_tile_painter)
		paint.tile=tile
		paint.col=col
		paint.visible=true
	}
}
surface_set_target(cnv)
draw_sprite_part(obj_brush.brush,0,obj_brush.tilex,obj_brush.tiley,8,8,xi,yi)
surface_reset_target()

instance_destroy()