vdis=8*3
hdis=8*2
completed=0
instance_create_depth(x,y+vdis*9,-1,obj_vlimit)
instance_create_depth(room_width/2,room_height,-1,obj_map_view)
instance_create_depth(0,0,0,obj_draw_new)
hdir=1
hdis=8*2
for (i=1;i<=global.drivers;i++)
{
	obj=obj_cpu
	j=global.place[global.drivers+1-i]
	if global.driver[j,0]=1
	{
		obj=obj_player
	}
	var xx=hdis*hdir
	var yy=vdis*(global.drivers+1)-vdis*i
	
	if i=0
	{
		while get_land((x+xx+16)/8,(y+yy)/8)!=0
		{
			hdis-=4
			xx=hdis*hdir
		}
	}
	ins=instance_create_depth(x+xx,y+yy,-1,obj)
	ins.character=global.driver[j,2]
	if global.driver[j,0]=1
	{
		ins.player=global.driver[j,1]
		global.cam_object[global.driver[j,1]-1]=ins
	}
	if obj=obj_cpu
	{
		ins.cpu_level=global.driver[j,1]
	}
	ins.driver_id=j
	hdir*=-1
}
for (var i=0;i<8;i++)
{
	global.won[i,0]=noone
	global.won[i,1]=noone
}
global.winplace=0
global.pwon=0
global.plost=1
global.plastlap=0
face_jy=17
face_sy=global.screen_h/2-face_jy*4
a=0

ctimer=0
depth=-1