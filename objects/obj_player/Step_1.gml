lmin_z=min_z
smin_z+=sign(floor(min_z)-smin_z)

#region inputs
if global.time_trial
{
	var o=obj_input_manager
	if o.replay
	{
		if key_check(vk_backspace,1)
		{
			o.replay=false
			room_transition(rm_track_select)
		}
	}
}
if !cpu
{
	var p_i=player-1
	key_right=global.key_right[p_i]
	key_left=global.key_left[p_i]
	key_front=global.key_up[p_i]
	key_back=global.key_down[p_i]
	key_lookback=global.key_y[p_i]
	rkey_up=global.key_b[p_i]
	key_up=rkey_up
	key_jump=global.key_r_press[p_i]
	key_jump_hold=global.key_r[p_i]
	key_item=global.key_l[p_i] xor global.key_a[p_i]
	key_item_press=(global.key_l_press[p_i] and !global.key_a[p_i]) or (global.key_a_press[p_i] and !global.key_l[p_i])
	key_pause=global.key_start_press[p_i]
	
	/*
	if global.control_type[p_i]=0 and !global.joycon
	{
		rkey_up=global.key_up[p_i]
		key_up=rkey_up
		key_jump=global.key_a_press[p_i]
		key_item=global.key_b[p_i]
		key_item_press=global.key_b_press[p_i]
	}
	*/
	
	if global.online
	{
		if player>1
		{
			var sp=player-2
			if obj_server.p_instance[sp]!=id
			{
				obj_server.p_instance[sp]=id
			}
			for (var i=0;i<6;i++)
			{
				o_key[i]=obj_server.key[sp,i]
			}
			key_right=o_key[0]
			key_left=o_key[1]
			key_up=o_key[2]
			key_jump=(o_key[3] and last_o_key[3]=0)
			key_item=o_key[4]
			key_item_press=(o_key[4] and last_o_key[4]=0)
			for (var i=0;i<6;i++)
			{
				last_o_key[i]=o_key[i]
			}
		}
	}
}
#endregion



var pch=instance_place(x,y,obj_track_check)
var rpch=collision_circle(x,y,10,obj_track_check,true,true)
if z!=0
{
	pch=noone
	rpch=noone
}
if rpch!=noone
{
	point_to=rpch.point_to
	point_in=rpch
	point_from=rpch.point_from
	if lpoint_in=noone
	{
		path_angle=point_in.point_from.angle
	}
}
lpoint_in=pch



#region cpu
var auto=0
if cpu or win or bot
{
	auto=1
}
if !auto exit;
key_front=0
key_back=0
key_lookback=0
key_right=0
key_left=0
key_jump=0
key_jump_hold=0
rkey_up=0
key_up=1
key_item_press=0
key_item=0
key_pause=0

#region rubberbanding
band=1
if true//global.players=1
{
	totalp=1
	medrank=place_get_instance(place-1).rank
	var pus=false
	ins=noone
	if place=1 and !place_get_instance(place+1).cpu
	{
		pus=true
		medrank=0
		totalp=global.players
		if global.cup!=-1
		{
			totalp=1
		}
		with obj_player
		{
			if !cpu
			{
				if global.cup=-1
				{
					other.medrank+=rank
				}
				else
				{
					if rank>other.medrank
					{
						other.medrank=rank
					}
				}
				other.ins=id
			}
		}
	}
	if ins!=noone or !pus
	{
		var rango=1/2
		var deltarank=(medrank/totalp-rank)
		var rdeltarank=deltarank
		if deltarank<0
		{
			rdeltarank+=clamp(-deltarank,0,rango)
		}
		band=1+clamp(rdeltarank*0.6,-0.2,0.4+0.2*(cpu_level/4.5))
	}
}
#endregion
if cpu_level<1 cpu_level=1
#region path
pblock=instance_place(x+lengthdir_x(spd*8,path_angle),y+lengthdir_y(spd*8,path_angle),obj_track_path_cpu)
if pblock=noone
{
	
}
if (!ground and vsp>0)// or pblock=noone
{
	pblock=instance_nearest(x,y,obj_track_path_cpu)
}
if pblock!=noone and (z=min_z or vsp>0)
{
	lpa_x=pblock.x
	lpa_y=pblock.y
	natur_rnd+=irandom_range(-1,1)
	natur_rnd=clamp(natur_rnd,-nr_range*nr_multi,nr_range*nr_multi)
	path_angle=pblock.angle//+(random_range(-range,range))
	point_to=pblock.ins
	point_from=pblock
	correct_path=!point_from.type=1
	if pblock.type=3
	{
		//start_d=1
	}
	if pblock.type=4
	{
		//stop_d=1
	}
}
#endregion
#region items
if item=1 or item=2 or item=3
{
	if hold_state=0
	{
		key_item_press=1
	}
	ltime=current_time
	key_item=1
}
if item=4 or item=7 or item=8 or item=9
{
	key_item_press=1
}
if item=5 or item=6
{
	if floor(random_range(0,10))=1
	{
		key_item_press=1
	}
}
if hold_state>=1 and hold_state<=3
{
	key_item=1
	if current_time-ltime>=60*5 and place>1
	{
		key_item=0
	}
}
if win key_item=0
#endregion
var ang=path_angle
if instance_exists(point_from) and instance_exists(point_in) and instance_exists(point_to) and lap>0 and z>min_z-10
{
	if correct_path
	{
		//var odis=clamp(point_distance(x,y,point_from.x,point_from.y)+16*spd,0,point_in.image_xscale*8+8)
		var pdis=clamp(point_distance(x,y,point_from.x,point_from.y)+16*2,0,point_in.image_xscale*8+8)//clamp(,0,point_in.image_xscale*8+64)
		var pang=point_in.image_angle
		var ran_dis=natur_rnd*nr_multi
		point_x=point_from.x+lengthdir_x(ran_dis,pang+90)+lengthdir_x(pdis,pang)
		point_y=point_from.y+lengthdir_y(ran_dis,pang+90)+lengthdir_y(pdis,pang)
		ang=point_direction(x,y,point_x,point_y)
		if collision_circle(x,y,16,point_in,true,true)=noone or collision_circle(x,y,16,obj_wall,true,true)!=noone
		{
			ang=point_to.angle
			if point_to.ch!=noone
			{
				ang=point_direction(x,y,point_to.ch.x,point_to.ch.y)
			}
		}
	}
}
//ang+=natur_rnd
#region fuck.
/*
if get_land_distance(6,todir[1])
{
	var ang=todir[1]
	var rdegrees=0
	repeat 360
	{
		ang++
		rdegrees++
		if get_land_distance(6,todir[1]+ang)
		{
			break
		}
	}
	var ang=todir[1]
	var ldegrees=0
	repeat 360
	{
		ang--
		ldegrees++
		if get_land_distance(6,todir[1]+ang)
		{
			break
		}
	}
	if ldegrees<rdegrees
	{
		ang=todir[1]-ldegrees
	}
	else
	{
		ang=todir[1]+rdegrees
	}
}
*/
#endregion

/*
if land!=l_track and ground and land!=l_hole and land!=l_water and land!=l_water_deep
{
	var lpa_l=sqrt(power(abs(lpa_x-x),2)+power(abs(lpa_y-y),2))
	ang=point_direction(x,y,lpa_x+lengthdir_x(lpa_l,path_angle),lpa_y+lengthdir_y(lpa_l,path_angle))
	//ang=point_direction(x,y,npa_x,npa_y)
}
*/
/*
if !get_land_circle(x,y,0,3,false)
{
	ang=point_direction(x,y,npa_x,npa_y)
}
*/
var dif=angle_difference(ang,todir[1])
if !cantmove and lap>0
{
	if true//!bot
	{
		todir[1]+=dif/8*global.T
	}
	else
	{
		//todir[1]=ang
		
		if !drift
		{
			if dif>0
			{
				key_left=true
			}
			else if dif<0
			{
				key_right=true
			}
		}
		if abs(dif)>90 and !drift
		{
			key_jump=true
		}
	}
}

if land=0 and ground and correct_path and preparing=0 and lap>0// and !bot
{
	var correct_dis=2
	/*
	var check1=get_land(xcoord+lengthdir_x(correct_dis,dir+90),ycoord+lengthdir_y(correct_dis,dir+90))!=0
	var check2=get_land(xcoord+lengthdir_x(correct_dis,dir-90),ycoord+lengthdir_y(correct_dis,dir-90))!=0
	*/
	var check1=!place_meeting(x+lengthdir_x(correct_dis*8,dir+90),y+lengthdir_y(correct_dis*8,dir+90),obj_track_check)
	var check2=!place_meeting(x+lengthdir_x(correct_dis*8,dir-90),y+lengthdir_y(correct_dis*8,dir-90),obj_track_check)
	if true//place_meeting(x,y,point_in)
	{
		if check1
		{
			todir[1]-=cpu_level
		}
		//else
		if check2
		{
			todir[1]+=cpu_level
		}
	}
	/*
	if check1 and check2
	{
		for (var ld=0;ld<32;ld++)
		{
			if get_land(xcoord+lengthdir_x(ld,dir+90),ycoord+lengthdir_y(ld,dir+90))
			{
				break
			}
		}
		for (var rd=0;rd<32;rd++)
		{
			if get_land(xcoord+lengthdir_x(rd,dir-90),ycoord+lengthdir_y(rd,dir-90))
			{
				break
			}
		}
		if rd>ld
		{
			todir[1]-=cpu_level
		}
		else
		{
			todir[1]+=cpu_level
		}
	}
	*/
}
//max cpu level->4.5
//min cpu level->1
if cpu_level<4
key_up=sign(current_time%(2*cpu_level))

ini_boost=91-random_range(-2,1+(9-cpu_level*2))
if band>1.7
{
	key_up=true
}
if outtime>60*3 and ground
{
	if point_to.ch!=noone
	{
		point_in=point_to.ch
	}
	outtime=60*3
	todir[1]+=(point_direction(x,y,point_in.x,point_in.y)-todir[1])
	//key_up=false
	//key_jump=true
}


/*
if pch=noone and instance_exists(point_in) and instance_exists(point_to) and !cantmove and z=0
{
	
	//path_angle=point_from.angle
	//path_angle-=sign(angle_difference(point_direction(point_from.x,point_from.y,x,y),point_in.image_angle))///12*global.T
}
*/
var skip=false
if instance_exists(point_from)
{
	if point_from.type=1
	{
		skip=true
	}
}
if (!ground and outtime=0) or lap=0
{
	skip=true
}
if pch=noone and instance_exists(point_in) and !skip
{
	if rpch=noone and hurt=0 and correct_path
	{
		outtime+=global.T
	}
	x+=sign(point_in.x-x)/6*global.T//*(key_jump*5+1)
	y+=sign(point_in.y-y)/6*global.T//*(key_jump*5+1)
}
if place_meeting(x,y,obj_track_check)
{
	outtime=0
}
/*
if place_meeting(front_x,front_y,obj_wall) and z=0
{
	path_angle=point_in.point_from.angle
}
*/

/*
if !cantmove
{
	error_timer--
}
if error_timer<=0
{
	error_timer=400
	if floor(ldistance/20)=floor(error_distance/20)
	{
		respawn=2
	}
	error_distance=ldistance
}
*/
#endregion