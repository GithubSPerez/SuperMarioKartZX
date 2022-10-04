var gone=false
if key_pause and preparing=0 and player=1 and !global.pwon
{
	replay_lock=true
	instance_deactivate_all(false)
	instance_activate_object(obj_pause)
	instance_activate_object(obj_input_manager)
	obj_pause.cooldown=10
	audio_pause_all()
	sprite_delete(global.pausesprite)
	screen_save("screen")
	global.pausesprite=sprite_add("screen",1,false,false,0,0)
	audio_play_new(snd_pause)
	exit
}
t=global.T
#region debug
if global.debug and !cpu
{
	cpu_level=4.5
	bot+=keyboard_check_pressed(ord("K"))
	bot%=2
	
	lap+=keyboard_check_pressed(ord("L"))
	min_z+=(key_check("P",0)-key_check("O",0))*8
	if key_check("I",1)
	{
		min_z=0
	}
}
#endregion
#region time
if !win and preparing=0
{
	time+=t
	laptime+=t
}
#endregion
#region sound vars
play_jump=false
play_land=false
play_goal=false
play_boost=false
play_hit=false
play_wall=false
play_wall_cpu=false
play_itembox=false
play_pass=false
play_throw=false
play_gothit=false
play_star=false
play_ghost=false
play_feather=false
play_thunder=false
play_stolen=false

if place!=rlplace
{
	play_pass=true
}
rlplace=place

stop_itembox=false
#endregion
#region stats
mask_index=spr_object
to_scale=1
var rstat_ind=floor(character/2)
var stat_ind=rstat_ind

handle=global.handle[stat_ind]

if cpu or bot
{
	var ins=place_get_instance(place+1)
	mindis=-1
	tostat=ch_mario
	/*
	with obj_player
	{
		if !cpu
		{
			var d=point_distance(x,y,other.x,other.y)
			if other.mindis=-1 or d<other.mindis
			{
				other.tostat=floor(character/2)
				other.mindis=d
			}
		}
	}
	*/
	stat_ind=tostat
}
push=global.push[rstat_ind]
if mini>0
{
	to_scale=0.5
	mask_index=spr_mini_hitbox
	mini--
}
s_scale+=(to_scale-s_scale)/8
has_star=star>0

acel=0.009*global.aceleration[stat_ind]*(has_star*4+1)*t
omaxs[0]=1.6*global.speed[stat_ind]*s_scale+(has_star*0.5)
omaxs[1]=2.5*global.speed[stat_ind]*s_scale+(has_star*0.5)-(0.8*(cpu and (global.cup=4 or global.vscup=4)))
if cpu or bot
{
	omaxs[0]=1.6*band*s_scale+(has_star*0.5)
	omaxs[1]=2.45*band*s_scale+(has_star*0.5)
	acel*=band
}
omaxs[0]*=global.cc
omaxs[1]*=global.cc

weight=global.weight[stat_ind]*s_scale*(has_star+1)

orotacel=0.1*t
rotacel=orotacel*(handle+has_star)
rotdeacel=orotacel
var rcurve=curve_angle/handle
if has_star
{
	rcurve=35
}

spr=spr_mario+character
#endregion
#region land
xcoord=round(x/8)
ycoord=round(y/8)
rland=get_land(xcoord,ycoord)

landchange=false
if lxcoord!=xcoord or lycoord!=ycoord
{
	landchange=true
}
lxcoord=xcoord
lycoord=ycoord

var l=obj_land_manager
if xcoord<0 or xcoord>l.size-1 or ycoord<0 or ycoord>l.size-1
{
	rland=global.out_fill
	land=rland
}
else
{
	if ground
	land=rland//obj_land_manager.collision[xcoord,ycoord]
}
if z<min_z-8 land=l_track
if star>0 or mush_boost>0
{
	if land=l_dirt or land=l_snow or land=l_grass
	{
		land=0
	}
}
var waterfall=0
if land=5
{
	if spd=0 and !waterfall
	{
		waterfall=1
	}
	else
	{
		if ground
		{
			ground=0
			vsp=-2
		}
		spd-=acel
		key_up=0
	}
}
if land=7 and respawn=0
{
	cantmove=1
	respawn=2
	spd=0
	/*
	if place_meeting(x,y,obj_goal)
	{
		lap--
	}
	*/
}
if (land=l_hole and z>-1) or waterfall
{
	//min_z=128*2
	falling=true
	ground=0
	draw_spr=0
	/*
	if place_meeting(x,y,obj_goal)
	{
		lap--
	}
	*/
}
if land=l_water_deep
{
	key_up=false
}
#endregion
#region path
var pblock=instance_place(x,y,obj_track_path)
if pblock!=noone
{
	if !cpu and !bot
	{
		path_angle=pblock.angle
	}
	pcount=pblock.type
	not_update_place=10
	spa=pblock.angle
	lneed=pblock
	if respawn=0
	{
		checkp_x=pblock.x
		checkp_y=pblock.y
		
		npb=noone
		fpb=noone
		with obj_track_path
		{
			if type=other.pcount+1
			{
				other.npb=id
			}
			if type=1
			{
				other.fpb=id
			}
		}
		if npb=noone
		{
			npb=fpb
		}
		if instance_exists(npb)
		{
			npa_x=npb.x
			npa_y=npb.y
		}
		
		checkp_ang=pblock.angle//point_direction(checkp_x,checkp_y,npa_x,npa_y)
	}
}
/*
var pblock=instance_place(x,y,obj_track_path_cpu)
if pblock!=noone
{
	checkp_x=pblock.x
	checkp_y=pblock.y
	checkp_ang=pblock.angle
}
*/
if angle_get_yscale(dir-path_angle+90)=1 and !hurt
{
	wrong_way=1
}
else
{
	wrong_way=0
}
#endregion
#region goal
if obj_input_manager.replay
{
	doradjust=true
}
var g=obj_goal
atg=x>g.x and x<g.x+g.image_xscale*8
var lapup=false
var lapdown=false
if atg
{
	if ly>=g.y and y<g.y
	{
		lapup=true
	}
	else if ly<g.y and y>=g.y
	{
		lapdown=true
	}
}
ly=y
if !win
{
	if lapup
	{
		lap++
		
		pcount=0
		if lap>global.laps
		{
			play_goal=true
			event_user(0)
		}
	}
	else if lapdown
	{
		lap--
	}
	if lap>dlap and lap!=1
	{
		if global.time_trial
		{
			draw_lapgood=true
			llaptime=laptime
			var rec=global.laprecord[global.track]
			if rec!=noone
			{
				if laptime>rec 
				{
					laptime=rec
					draw_lapgood=false
				}
			}
			global.laprecord[global.track]=laptime
			progress_save()
			laptime=0
			draw_laptime=60*2
		}
		
		if lap!=global.laps+1
		{
			dlap++
			if dlap=global.laps
			{
				if !global.plastlap and !cpu
				{
					global.music_type=4
				}
			}
			lak_state=2
		}
		else if global.time_trial
		{
			if doradjust
			{
				radjust=true
			}
			if !obj_input_manager.replay
			{
				var ltime=time
				var rec=global.record[global.track,0]
				var sav=false
				if rec!=noone
				{
					if time>rec
					{
						time=rec
					}
					else
					{
						sav=true
					}
				}
				else
				{
					sav=true
				}
				if sav
				{
					if !replay_lock
					{
						replay_save()
					}
					global.record[global.track,1]=character
				}
				global.record[global.track,0]=time
				progress_save()
				time=ltime
			}
			else
			{
				radjust=true
			}
		}
	}
}
latg=place_meeting(x,y,obj_goal)
#endregion
#region rank
ldistance=sqrt(power(abs(lneed.x-x),2)+power(abs(lneed.y-y),2))

rank=lap+(pcount/(instance_number(obj_track_path)+1))
#endregion
#region hurt
#region getting_hit
var obs=instance_place(x,y,obj_obstacle)
if obs!=noone and ghost=0 and ground
{
	if obs.dont_hurt!=id
	{
		if obs.z<min_z+8
		{
			if star
			{
				instance_destroy(obs)
			}
			else
			{
				hurt=1
				play_hit=true
				/*
				impulse_dir=point_direction(obs.x,obs.y,x,y)
				if obs.type=0
				{
					impulse_dir=dir
				}
				impulse_spd=1
				*/
				if (cpu and !obs.cpu) or (!cpu)
				{
					play_gothit=true
				}
				if obs.type=3
				{
					if place=1
					{
						instance_destroy(obs)
					}
				}
				else
				instance_destroy(obs)
			}
		}
	}
}
#endregion
#region effects
if hurt_timer>0 
hurt_timer-=t
if hurt_timer<0
{
	hurt_timer=0
}
#region spin
var spin_time=floor(clamp(1/(global.cc-0.25)+0.25,0.25,1.25)*60)
if hurt=1
{
	if star or ghost
	{
		hurt=0
	}
	else
	{
		spd/=1.6
		ldir=todir[1]
		play_hit=true
		follow_dir=0
		cantmove=1
		hurt_timer=spin_time
		hurt=1.1
	}
}
if hurt=1.1
{
	todir[1]+=(360/spin_time)*3*t
	if hurt_timer=0
	{
		follow_dir=2
		cantmove=0
		hurt=1.2
		hurt_timer=10
	}
}
if hurt=1.2
{
	if hurt_timer=0
	{
		//todir[1]=ldir
		follow_dir=1
		hurt=0
	}
}
#endregion
#region end cutscene
if victory
{
	follow_dir=3
}
if hurt=9
{
	hurt_timer=150
	victory=1
	hurt=9.1
}
if hurt=9.1
{
	if hurt_timer=0
	{
		if !cpu
		global.c_follow[player-1]=0
		
		victory=0
	}
}
#endregion
#endregion
#endregion
#region movement
if cantmove
{
	key_up=0
	key_right=0
	key_left=0
	key_jump=0
	key_item_press=false
}
maxspd[0]=omaxs[0]
maxspd[1]=omaxs[1]
if land=l_water or land=l_snow
{
	maxspd[1]=omaxs[0]
	drift=0
}
if land=l_dirt or land=l_grass
{
	maxspd[0]=omaxs[0]/2
	maxspd[1]=omaxs[0]/2
	drift=0
}
superspd=spd>maxspd[0]

var rotstop=(spd=0 and ground)
rotdir=(key_left-key_right)
rotsmulti=clamp(spd/(omaxs[0]/global.cc),0.1,1)
if !ground
{
	rotsmulti=1
}
if rotstop
{
	rotdir=0
}
if abs(rotspd)>rotmax/2 and (therot)>45 and /*spd>(omaxs[1]-omaxs[0]/3)/global.cc and*/ ground and !star and key_up
{
	drift=1
}
if spd=0
{
	drift=0
}
if (drift and canclose) or has_star
{
	rotmax+=0.009*abs(rotdir)*(1.2-key_up*0.2)*t
}
else
{
	rotmax=orotmax
	canclose=0
}
if rotdir=1
{
	rotspd+=rotacel*rotsmulti
	if rotspd>rotmax 
	{
		rotspd=rotmax
	}
}
if rotdir=-1
{
	rotspd-=rotacel*rotsmulti
	if rotspd<-rotmax 
	{
		rotspd=-rotmax
	}
}
if rotmax>rrotmax rotmax=rrotmax
if rotdir=0
{
	therot--
	if therot<0 therot=0
	//var acelmulti=1-(drift and ground)*0.5
	if 1//!slide
	{
		if rotspd>0 {rotspd-=rotdeacel}
		if rotspd<0 {rotspd+=rotdeacel}
	}
	rotspd=deadpoint(rotspd,rotacel*1.3)
}
else if !drift
{
	therot+=abs(rotdir)
}
if key_jump and ground
{
	z=min_z
	if !drift
	{
		drift=true
	}
	else if rotdir=0
	{
		drift=false
	}
	vsp=-jspd
	ground=0
	
	canclose=1
	rotmax=drotmax
	play_jump=true
}
if respawn=0
{
	if ground and z>min_z
	{
		z=min_z
	}
	if ground and z<min_z
	{
		if abs(lmin_z-min_z)>4
		{
			ground=false
		}
		else
		{
			z=min_z
		}
	}
}
if ground and rotspd=0 and rotdir=0
{
	drift=false
}
if key_up and spd_dir=1
{
	if !superspd
	spd+=acel
	else
	spd+=acel/4
}
else
{
	if !superspd
	spd-=acel*0.9
	else
	spd-=acel
	
	if spd_dir=-1 and ground
	{
		spd-=acel*6
	}
}
if spd<0 
{
	spd=0
	spd_dir=1
}
if spd>maxspd[1] spd-=acel*3

if land=l_water_deep
{
	spd*=0.99
}

todir[1]+=rotspd*t
//slide=((10-stable)+15*drift)
dir=todir[1]

var slide=drift and ground
var rot=rotmax-slide/2.7
if !ground
{
	rot=rotmax*1.25
}
var movlookat=dir
if drift
{
	movlookat=dir-rcurve*rotdir
}
if land=l_mud and drift
{
	rot=rotmax*1.5
	movlookat=dir-70*rotdir
	//if angle_difference(movdir,dir-90*rotdir)<0 rot*=-2
}
var ang_dif=angle_difference(movdir,movlookat)
if abs(ang_dif)<15 and abs(ang_dif)>5 and spd>omaxs[0]/6
{
	rot/=3
}
/*
if 0//(ground and drift and abs(dindex)>=3)
{
	rot=rotmax*1.5
	movlookat=dir-45*rotdir
}
*/
var mierdangle=weight
if has_star
{
	mierdangle=0.5
}
if ang_dif<0 movdir+=rot*t/mierdangle
if ang_dif>0 movdir-=rot*t/mierdangle

var maxdriftang=100
/*
if 0//abs(angle_difference(movdir,movlookat))>100 and hurt=0
{
	hurt=1
	impulse_dir=movdir
	impulse_spd=spd
	movdir=movlookat
}
*/
if abs(angle_difference(movdir,movlookat))>maxdriftang
{
	movdir=movlookat+maxdriftang*sign(angle_difference(movdir,movlookat))
}
if cpu or bot
{
	movdir=dir
}
if floor(hurt)=1
{
	movdir=ldir
}
var xsp=lengthdir_x(spd*spd_dir*t,movdir)
var ysp=lengthdir_y(spd*spd_dir*t,movdir)
#endregion
#region itembox
var itmbox=instance_place(x,y,obj_item_box)
var itmtime=2.5*60
if itmbox!=noone and ground
{
	if !itmbox.full and item=0 and getting_item=0
	{
		getting_item=itmtime
		getitem=true
		play_itembox=true
		itmbox.full=1
	}
}
getting_item-=t
if getting_item<0 getting_item=0
if (getitem and getting_item=0) or (key_item_press and getting_item>1 and getting_item<itmtime*0.75)
{
	item=get_item(place,rank)
	stop_itembox=true
	getting_item=0
	getitem=0
	key_item_press=0
}
#endregion
#region items
var brang=5
var frang=7
var back_x=x+4+lengthdir_x(brang,dir+180)
var back_y=y+4+lengthdir_y(brang,dir+180)
front_x=x+4+lengthdir_x(frang*3,dir)
front_y=y+4+lengthdir_y(frang*3,dir)
hold=0
if key_item_press
{
	toitem=0
	if item>0
	{
		if item=1
		{
			itmins=instance_create_depth(back_x,back_y,depth,obj_obstacle)
			itmins.hold=1
			itmins.cpu=cpu
			hold_state=1
		}
		if item=2 or item=3
		{
			itmins=instance_create_depth(back_x,back_y,depth,obj_obstacle)
			itmins.type=item-1
			itmins.hold=1
			itmins.cpu=cpu
			hold_state=item
		}
		if item>=1 and item<=3
		{
			itmins.dont_hurt=id
		}
		if item=4
		{
			mush_boost=60
			if spd<omaxs[0]
			{
				spd=omaxs[0]
			}
			play_boost=true
		}
		if item=5
		{
			with obj_player
			{
				if id!=other.id
				{
					if item>0 and item!=5
					{
						other.toitem=item
						play_stolen=true
						item=0
						break;
					}
				}
			}
			play_ghost=true
			ghost=ghost_time
			star=0
		}
		if item=6
		{
			ground=0
			play_feather=true
			vsp=-jspd*2*(grav/0.3)
		}
		if item=7
		{
			with obj_player
			{
				if id!=other.id and ghost=0 and star=0
				{
					mini=60*(12-place)
					impulse_dir=dir
					impulse_spd=1
					hurt=1
				}
				thunder_time=60
			}
			play_thunder=true
		}
		if item=8
		{
			star=star_time
			play_star=true
			ghost=0
		}
		if item=9
		{
			itmins=instance_create_depth(front_x,front_y,depth,obj_obstacle)
			itmins.type=3
			itmins.not_d=player-1
			itmins.dir=dir
			itmins.target=id
			itmins.todir=path_angle
			itmins.tardir=path_angle
			itmins.cpu=cpu
			itmins=noone
			play_throw=true
		}
	}
	onhold_item=item
	item=toitem
}
if key_item
{
	if (hold_state>0) and instance_exists(itmins)
	{
		itmins.x=back_x
		itmins.y=back_y
		itmins.z=-z/2
		hold=1
	}
}
if !instance_exists(itmins)
{
	hold_state=0
}
if !key_item
{
	if hold_state=1
	{
		itmins.dont_hurt=noone
		itmins.hold=0
		if key_front
		{
			play_throw=true
			itmins.zsp=4
			var ispd=6
			itmins.xsp=dcos(-vis_dir)*ispd
			itmins.ysp=dsin(-vis_dir)*ispd
			itmins.z=z+16
		}
		itmins=noone
	}
	if hold_state=2 or hold_state=3
	{
		if itmins.type!=2
		{
			itmins.dont_hurt=noone
		}
		play_throw=true
		with itmins
		{
			hold=0
			x=other.front_x
			y=other.front_y
			dir=other.dir
			if type=2
			{
				//x=other.x+lengthdir_x(12,other.path_angle)
				//y=other.y+lengthdir_y(12,other.path_angle)
				target=other.id//place_get_instance(other.place-1)
				dir=other.todir[1]
				todir=other.path_angle
				tardir=other.path_angle
			}
		}
		if key_back and itmins.type=1
		{
			itmins.x=back_x
			itmins.y=back_y
			itmins.dir+=180
		}
		itmins=noone
	}
	hold_state=0
}
#endregion
#region ground interaction
if place_meeting(x,y,obj_boost) and ground
{
	mush_boost=60
	play_boost=true
}
var ramp=instance_place(x,y,obj_ramp)
if ramp!=noone and ground
{
	ground=0
	impulse_dir=dir
	if !mush_boost
	{
		impulse_spd=2.5-spd+0.2
	}
	vsp=(-ramp.jspd-abs(sign(mush_boost))*3)*(grav/0.3)
}
var pull_hole=instance_place(x,y,obj_pull_hole)
if pull_hole!=noone
{
	if min_z=0
	{
		if vsp>=0 and z>-8
		{
			min_z=64
			ground=false
			on_pull_hole=pull_hole
		}
	}
}
if on_pull_hole!=noone
{
	if !place_meeting(x,y,on_pull_hole)
	{
		x+=(on_pull_hole.x-x)/6
		y+=(on_pull_hole.y-y)/6
	}
	if z>=64
	{
		todir[1]=on_pull_hole.angle
		movdir=todir[1]
		x=on_pull_hole.tox
		y=on_pull_hole.toy
		vsp=-8
		min_z=0
		z=0
		ground=false
		on_pull_hole=noone
	}
}
#endregion
#region habilities
if mush_boost>0
{
	if mush_boost>30
	{
		impulse_spd=3.5
	}
	impulse_dir=dir
	mush_boost-=t
	if mush_boost<0 mush_boost=0
	if land=l_water_deep or land=l_hole
	{
		mush_boost=0
		spd=omaxs[0]
	}
}

ghost-=t
star-=t
if ghost<0 ghost=0
if star<0 star=0
#endregion
#region impulse
var tplayer=instance_place(x,y,obj_player)
if tplayer!=noone
{
	if z>min_z-16 and tplayer.z>min_z-16 and ghost=0 and tplayer.ghost=0
	{
		impulse_dir=point_direction(tplayer.x,tplayer.y,x,y)
		tplayer.impulse_dir=point_direction(x,y,tplayer.x,tplayer.y)
		impulse_spd=tplayer.push
		tplayer.impulse_spd=push
		if (mini>0 and tplayer.mini=0) or (tplayer.star and !star)
		{
			hurt=1
		}
		if (tplayer.mini>0 and mini=0) or (star>0 and !tplayer.star)
		{
			tplayer.hurt=1
		}
		play_wall=true
		if !tplayer.cpu
		{
			play_wall_cpu=true
		}
		//show_message(play_wall)
	}
}
var block=instance_place(x+xsp,y+ysp,obj_wall)
if block!=noone and z>min_z-16
{
	//unstuck()
	var cpu_not_skip=(block.object_index=obj_falling_block or block.object_index=obj_ice)
	var hit=1
	if block.object_index!=obj_wall
	{
		if cpu and !cpu_not_skip hit=0
		if star hit=2
		if !block.can_touch hit=0
		if block.can_touch
		{
			if block.deadly and hurt=0 hurt=1
		}
	}
	if hit=1
	{
		if lspd=noone// and (place!=1 or global.cup!=-1)
		{
			if !ground
			{
				lspd=spd
			}
			else
			{
				lspd=noone
			}
		}
		play_wall=true
		impulse_dir=point_direction(block.x,block.y,x,y)
		impulse_spd=1
		spd/=1.1
		mush_boost=0
		unstuck()
	}
	if hit=2
	{
		block.ded=1
	}
	if (cpu and cpu_not_skip) or !cpu
	{
		block.falling=1
	}
}
if impulse_spd>0 impulse_spd-=acel*6
if impulse_spd<0 impulse_spd=0
if land=l_water_deep
{
	if z>min_z-2
	{
		spd/=1.2
		mush_boost/=1.2
	}
	impulse_spd/=1.1
}
var im_xsp=lengthdir_x(impulse_spd,impulse_dir)
var im_ysp=lengthdir_y(impulse_spd,impulse_dir)
#endregion
x+=xsp+im_xsp*t
y+=ysp+im_ysp*t
#region falling
if !ground and respawn=0
{
	vsp+=grav*t
	z+=vsp*t
	var f_dis=100
	if z>min_z+falling*8 and falling
	{
		spd=0
		cantmove=1
		item=0
		mush_boost=0
		impulse_spd=0
		if instance_exists(itmins)
		{
			itmins.hold=false
			itmins=noone
		}
	}
	if z>min_z and z<min_z+8
	{
		if rland!=l_hole and rland!=l_water_deep
		{
			falling=false
			ground=true
			z=min_z
			vsp=0
			if lspd!=noone
			{
				spd=lspd
				impulse_spd=0
				spd_dir=1
				lspd=noone
			}
			play_land=true
			if todrift=false
			{
				todrift=true
			}
		}
	}
	if z>min_z+f_dis*falling
	{
		if land=l_water_deep and z<1
		{
			repeat 2
			instance_create_depth(back_x,back_y,depth,obj_drop)
		}
		ground=true
		lspd=noone
		z=min_z+f_dis*falling
		if z>min_z
		{
			respawn=1
		}
		vsp=0
	}
}
#endregion
#region respawning
respawn_timer-=t
if respawn_timer<0 respawn_timer=0
if respawn=1
{
	respawn_timer=40
	respawn=1.1
}
if respawn=1.1
{
	spd+=(0-spd)/6
	if respawn_timer=0
	{
		respawn_timer=40
		respawn=1.2
	}
}
if respawn=1.2
{
	ground=false
	z=min_z+64+respawn_timer*4-global.screen_h/2
	if respawn_timer=0
	{
		respawn_timer=40
		dothat=1
		checkp_l=sqrt(power(abs(checkp_x-x),2)+power(abs(checkp_y-y),2))+8
		respawn=1.3
	}
}
if respawn=1.3 or respawn=2.2
{
	/*
	if dothat
	{
		/*
		rl=16
		range=6
		var done=respawn_recal(range)
		/*
		torx2=checkp_x
		tory2=checkp_y
		done=true
		var bias=1000
		while !done
		{
			checkp_l-=8
			bias--
			if bias<=0
			{
				show_message("while overflow!")
				checkp_l=0
				break
			}
			done=respawn_recal(range)
		}
		//respawn_recal(range)
		dothat=0
		/*
		if !instance_exists(point_in)
		{
			point_in=instance_nearest(x,y,obj_track_check)
		}
		if !instance_exists(point_in)
		{
			point_in=goal
		}
		torx2=point_in.x
		tory2=point_in.x
	}
	*/
	var goto=point_in
	if !place_meeting(x,y,goto)
	{
		goto=instance_nearest(x,y,obj_track_check)
	}
	if !instance_exists(goto)
	{
		goto=obj_player_manager
	}
	x+=(goto.x-x)/20*t
	y+=(goto.y-y)/20*t
	follow_dir=2
	todir[1]=goto.image_angle
	movdir=goto.image_angle
	if respawn_timer=0
	{
		//unstuck_special()
		ground=0
		respawn=0
		falling=0
		cantmove=0
		follow_dir=1
	}
}
if respawn=2
{
	impulse_spd=0
	respawn_timer=40
	respawn=2.05
}
if respawn=2.05
{
	if respawn_timer=0
	{
		respawn_timer=40
		respawn=2.1
	}
}
if respawn=2.1
{
	z+=((min_z+64-global.screen_h/2)-z)/30
	if respawn_timer=0
	{
		respawn_timer=50
		checkp_l=sqrt(power(abs(checkp_x-x),2)+power(abs(checkp_y-y),2))-64
		dothat=1
		respawn=2.2
	}
}
#endregion
#region preparing
if preparing=1
{
	//vis_dir=dir+180
	camera_distance-=0.16*t
	if camera_distance<=1
	{
		camera_distance=1
		preparing=2
	}
}
else if preparing=2
{
	follow_dir=2
	ralarm[1]=70
	preparing=2.1
}
else if preparing=3
{
	lak_state=3
	ralarm[2]=50
	ralarm[4]=100
	preparing=3.1
}
else if preparing=4
{
	if rkey_up
	{
		ini_boost+=t
	}
	else if ini_boost>0
	{
		ini_boost-=t
	}
	lak_timer+=t
	if lak_timer>=60*3
	{
		preparing=0
		cantmove=0
		follow_dir=1
		if ini_boost>100
		{
			hurt=1
		}
		else if ini_boost>60*1.5
		{
			mush_boost=31
			spd=omaxs[0]
			play_boost=true
		}
		ralarm[3]=60
	}
}
#endregion
#region alarmas
for (var i=0;i<12;i++)
{
	if ralarm[i]>=0
	{
		ractive[i]=false
	}
	ralarm[i]-=t
	if ralarm[i]<-1
	{
		ralarm[i]=-1
		if !ractive[i]
		{
			event_perform(ev_alarm,i)
			ractive[i]=true
		}
	}
}
#endregion
#region cam direction (TIENE QUE ESTAR AL FINAL)
if cpu exit;
if !global.c_follow[player-1] exit;
lookback=(key_lookback and follow_dir=1)
if drift
{
	if doffset<45 doffset+=t
}
else
{
	if doffset>0 doffset-=t
}
if follow_dir=1
{
	vis_dir=dir
	if lookback
	{
		vis_dir+=180
	}
}
if follow_dir=2
{
	vis_dir+=angle_difference(dir,vis_dir)/6*t
}
if follow_dir=3
{
	vis_dir+=angle_difference((dir+180),vis_dir)/15*t
}
if follow_dir=4
{
	vis_dir+=180
}
vis_dir=angle_get_correct(vis_dir)
#endregion