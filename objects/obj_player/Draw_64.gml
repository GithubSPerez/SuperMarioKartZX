s_w=global.screen_w/global.hdivscreen
s_h=global.screen_h

s_x=s_w*(floor((player-1)/2))
s_y=(s_h/2)*((player-1)%2)

if cpu
{
	//draw_text(0,8,camera_visible())
	if !show_cpu
	exit;
	else
	player=1
}
if win or lookback or instance_exists(itmins)
{
	draw_spr=0
}
//draw_text(0,0,ini_boost)
#region setting up values
var jz=z-smin_z
var toindex=0
if rotdir!=0 and spd>0
{
	var sprdir=-rotdir
	if drift
	{
		toindex=5*sprdir
	}
	else
	{
		toindex=sprdir
		if floor(index)=0
		{
			dindex=sprdir
		}
	}
}
var indexspd=0.2*global.T
if dindex<toindex
{
	dindex+=indexspd
}
if dindex>toindex
{
	dindex-=indexspd
}
index=clamp(dindex,-5,5)

//hurt effects
if hurt=1.1
{
	index=get_angle_index(dir,8,12)*angle_get_xscale(dir)
}

if sign(index)!=0
xscale=sign(index)
if ground
recorrido+=spd*30
recorrido=recorrido%360
roadeffect=round(abs(sin(degtorad(recorrido))))

d_item=item
if getting_item
{
	d_item=(current_time/30)%items+1
}
#endregion
polvo=abs(index)>=3
#region draw
surface_set_target(draw_sur)
draw_clear_alpha(c_white,0)

//draw_surface(global.view_sur[0],0,0)
if draw_spr
{
	var dr=1
	if ghost
	{
		dr=floor(current_time/2)%2
	}
	var col=c_white
	if star
	{
		col=make_color_hsv(current_time%255,255,255)
	}
	var yrfx=roadeffect*!drift
	var xrfx=roadeffect*drift*ground*2*(abs(index)>=3)
	if dr
	draw_sprite_ext(spr,abs(index),s_w/2-xrfx,(s_h/2)-8+jz-yrfx,xscale*s_scale,s_scale,0,col,1)
}

/*
if hold and !lookback
{
	var it_spr=spr_banana+onhold_item-1
	var it_scale=1
	if onhold_item=9 
	{
		it_spr=spr_shell_b
		it_scale=16/2048
	}
	draw_sprite_ext(it_spr,0,s_w/2,(s_h/2)-10+jz,it_scale,it_scale,0,c_white,1)
}
*/

draw_set_color(c_white)
if !win
d_place=place
if lplace!=d_place
{
	nsize=3
}
lplace=d_place
if !win
{
	nsize+=(0.4-nsize)/6
}
else
{
	nsize=3
}

///HUD
if !global.time_trial
{
	if set_place!=noone d_place=set_place
	draw_sprite_ext(spr_rankings,d_place-1,s_w-8,s_h/2-8,clamp(nsize,0,1),clamp(nsize,0,1),0,c_white,0.75)
}
draw_set_alpha(1)

if !win
{
	draw_sprite(spr_item_holder,0,s_w/2,12)
	draw_sprite(spr_items,d_item,s_w/2,12)
	draw_set_align(fa_right,fa_bottom)
	var lift=9
	//draw_text(s_w*0.84,s_h/2-lift,"L*3")
	draw_text(s_w+(-40+30*global.time_trial),s_h/2-lift,"F*"+string(clamp(dlap,1,5)))
}

draw_set_align(fa_left,fa_top)

#region particles
if !win and !lookback
{
	var type=0
	var subtype=0
	var ind=0
	var par_xoff=s_w/2
	var par_yoff=(s_h/2)-8
	if ground and spd>0.1
	{
		if drift and polvo and !place_meeting(x,y,obj_goal)
		{
			type=1
			subtype=1
		}
		if land!=l_hole and land!=l_track
		{
			type=1
		}
	}
	subtype=0
	var do_col=true
	if global.players>0
	{
		do_col=false
		if landchange
		{
			do_col=true
		}
	}
	if do_col
	{
		odust_color=surface_getpixel(global.plain_track,x,y)
	}
	/*
	repeat 6//lag test
	{
		surface_getpixel(global.plain_track,x,y)
	}
	*/
	if odust_color!=c_black
	dust_color=merge_color(dust_color,odust_color,0.25)
	if type=1 and mini=0
	{
		ind=current_time%par_frames[1]
		draw_sprite_ext(spr_mud,1+subtype*2,par_xoff+mud_big[ind,0]/2-6-index,jz+par_yoff+mud_big[ind,1]/2-4,1,1,0,dust_color,1)
		draw_sprite_ext(spr_mud,1+subtype*2,par_xoff-mud_big[ind,0]/2+6-index,jz+par_yoff+mud_big[ind,1]/2-4,-1,1,0,dust_color,1)
	
		draw_sprite_ext(spr_mud,subtype*2,par_xoff+mud_big[ind,0]-12,jz+par_yoff+mud_big[ind,1],1,1,0,dust_color,1)
		draw_sprite_ext(spr_mud,subtype*2,par_xoff-mud_big[ind,0]+12,jz+par_yoff+mud_big[ind,1],-1,1,0,dust_color,1)
	}
}
#endregion
#endregion
#region lakitu
lak_sprite=spr_lakitu_lap
if wrong_way
{
	if lak_state=0 and hurt=0
	{
		lak_state=1
	}
}
else
{
	if lak_state=1
	{
		lak_state=0
	}
}
if lak_state=1
{
	lak_sprite=spr_lakitu_x
}
lak_var=600
if lak_state=0
{
	lak_tox=s_w/2
	lak_toy=-48
}
if lak_state!=0
{
	lak_tox=s_w/2+cos(current_time/lak_var)*(s_w/4)
	lak_toy=s_h/4+sin(current_time/lak_var*2)*(s_h/8)
}
if lak_state=3
{
	lak_tox=s_w/2
	lak_toy=s_h/2/4
	lak_sprite=spr_lakitu_lights
	if lak_timer>=60*3
	{
		lak_sprite=spr_lakitu_go
	}
}
if lak_state=2
{
	ralarm[0]=100
	lak_state=2.1
}
var lakq=4
var laks=2
repeat lakq*laks
{
	var six=sign(lak_tox-lak_x)*global.T
	var siy=sign(lak_toy-lak_y)*global.T
	var con=true
	var tinue=true
	if six!=0
	{
		lak_x+=six/lakq///6
		con=false
	}
	if siy!=0
	{
		lak_y+=siy/lakq
		tinue=false
	}
	if con and tinue
	{
		break
	}
}
if !win
{
	draw_sprite(lak_sprite,global.time/15,lak_x,lak_y)
	if lak_state=2.1
	{
		draw_sprite(spr_lap_sign,dlap-2,lak_x,lak_y)
	}
	if lak_state=3
	{
		draw_sprite(spr_lights,lak_timer/60,lak_x-22,lak_y)
	}
}
#endregion
#region timer
if radjust
{
	time=global.record[global.track,0]
}
draw_set_font(global.fnt_big)
draw_set_halign(fa_right)
draw_text(s_w-8,2,timer_get_string(time))

if draw_laptime>0
{
	draw_laptime--
	var c1=c_green
	var c2=c_lime
	if !draw_lapgood
	{
		c1=c_red
		c2=c_orange
	}
	draw_set_color(merge_color(c1,c2,abs(dcos(draw_laptime*2))))
	draw_set_alpha(draw_laptime/60)
	draw_text(s_w-8,20,timer_get_string(llaptime))
}
draw_reset()
#endregion
//draw_surface_ext(global.view_sur[player-1],0,0,0.25,0.25,0,c_red,1)
surface_reset_target()
draw_surface(draw_sur,s_x,s_y)

draw_reset()

var o=obj_input_manager
if o.replay
{
	draw_set_alpha(6-o.repframe/60)
	draw_text(0,0,"press backspace to stop")
}
if replay_lock and global.time_trial
{
	draw_set_alpha(1-abs(dcos(global.time))*0.5)
	draw_set_color(c_red)
	draw_text(0,0,"replay cant be saved")
}
if global.song=11
{
	draw_set_alpha(pcredit/60)
	draw_set_color(c_white)
	draw_text(0,0,"song by parabeetle x")
	draw_reset()
	pcredit--
}

draw_reset()

if show_cpu
{
	player=-1
}
if global.debug
{
	draw_text(0,0,spd)
	//draw_records(0,0,"")//global.record)
}