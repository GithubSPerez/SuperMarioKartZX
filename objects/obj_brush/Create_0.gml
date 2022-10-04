audio_stop_all()
audio_stop_intro()

tilesize=8
lines=8
sidebarx=tilesize*lines

canvas=surface_create(2048,2048)
brush=sprite_index
tilenumb=1

load_tileset()

grid_size=8
grid=true
xoffset=0
yoffset=0

cam=camera_create()
cam_x=0
cam_y=0
scale=1
xdir=1
ydir=1
lxcoord=0
lycoord=0

tile=0

wallmode=false
wallind=0
walltile=0
wallmod=1/4
walltiles=4//4

done=false

for (var i=0;i<4;i++)
{
	gx[i]=x
	gy[i]=y
}

gx[0]=0
gy[0]=0

gx[1]=8
gy[1]=0

gx[2]=8
gy[2]=8

gx[3]=0
gy[3]=8

paint_angle=0
paint_length=10

view_enabled=true
view_visible[0]=true
view_wport[0]=global.screen_w
view_hport[0]=global.screen_h
view_set_camera(0,cam)