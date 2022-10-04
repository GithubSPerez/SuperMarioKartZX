if global.time_trial
{
	x-=16
	y+=64
}
character=0
z=0
min_z=0
lmin_z=0
smin_z=0

spd=0
dir=90
therot=0
maxspd[0]=2
maxspd[1]=3
todir[0]=dir
todir[1]=dir
ldir=dir
drift=false
ground=1
vsp=0
grav=0.4
jspd=3
todrift=true
rotdir=1
rotspd=0
vis_dir=dir+179.9
follow_dir=3
doffset=0
movdir=90
victory=0
curve_angle=25
band=1

rrotmax=2
orotmax=1.4
drotmax=1.8
rotmax=orotmax
canclose=0

recorrido=0

spd_dir=1
lspd=noone

xcoord=0
ycoord=0

land=0
landchange=false
lxcoord=0
lycoord=0

cantmove=1
hurt=0
hurt_timer=0
player=1
coins=0
item=0
getitem=false
hold_state=0
onhold_item=0
itmins=noone
getting_item=0
ltime=0

falling=0
respawn=0
respawn_timer=0
checkp_x=x
checkp_y=y
checkp_ang=90

mush_boost=0
ghost=0
ghost_time=5*60
mini=0
star=0
star_time=7*60

s_scale=1
lookback=false

impulse_spd=0
impulse_dir=90

path_angle=90
spa=90
pholder=instance_create_depth(x,y,-1,obj_pholder)
pholder.image_yscale=128
pholder.image_angle=90
wrong_dir=0
pcount=global.pneed
lap=0
dlap=1
lneed=obj_vlimit
ldistance=0
lpa_x=x
lpa_y=y
npa_x=x
npa_y=y
atg=0
latg=0
atgv=0

polvo=false

global.laps=5-2*global.track_type

show_cpu=0
cpu_level=3
cpu=false
nr_range=14
nr_multi=1
natur_rnd=irandom_range(-nr_range,nr_range)
outtime=0

win=0
bot=false
driver_id=0
rank=1
global.pausesprite=spr_delete
#region drawing
s_w=global.screen_w/global.hdivscreen
s_h=global.screen_h

s_x=s_w*(floor((player-1)/2)%2)
s_y=(s_h/2)*((player-1)%2)


draw_sur=surface_create(s_w,s_h/2)
draw_spr=1

index=0
dindex=0
xscale=1
roadeffect=0

bg_sur=noone
bg_x=0
bg_front_x=0
lvisdir=0

filler_sur=surface_create(s_w,s_h/2)
wall=x3d_create_vplane(16,16)
spr=spr_mario
d_place=place
not_update_place=0
lplace=d_place
rlplace=place
set_place=noone
nsize=1
#endregion
#region particles
par_timer=0
par_frames[0]=1
dust_color=c_white
odust_color=c_black
#region mud
par_frames[1]=4
for (var f=0;f<par_frames[1];f++)
{
	mud_big[f,0]=-f
	mud_big[f,1]=f
}
#endregion
#endregion
#region lakitu
lak_tox=s_w/2
lak_toy=-48
lak_x=lak_tox
lak_y=lak_toy
lak_var=0
lak_state=0
lak_sprite=spr_lakitu_lap

lak_timer=0
#endregion
key_item=0
key_item_press=0

psur=-1

for (var i=0;i<6;i++)
{
	o_key[i]=0
	last_o_key[i]=0
}

error_timer=400
error_distance=0

camera_distance=16

preparing=1
if global.time_trial
{
	preparing=3
	camera_distance=1
	follow_dir=1
}

ini_boost=0
time=0
racetime=0
laptime=0
llaptime=0

draw_laptime=0
draw_lapgood=false

motor_sound=noone
motor_stop=false

motor_pitch[0]=1
motor_pitch[1]=0.3
motor_pitch[2]=0.4
motor_pitch[3]=0.4

drift_sound=noone
itembox_sound=noone

thunder_time=0

point_to=noone
point_in=noone
point_from=noone

lpoint_in=noone

correct_path=true

front_x=x
front_y=y

ly=y

PICHULA=noone
bg_y=0

on_pull_hole=noone

replay_lock=false

pcredit=3*60
point_x=0
point_y=0

radjust=false
doradjust=false

for (var i=0;i<12;i++)
{
	ralarm[i]=-1
	ractive[i]=true
}