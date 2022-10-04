randomize()
global.screen_w=400
global.screen_h=224
global.retro=false
global.display_scale=3
global.divscreen=2
global.players=1
global.drivers=8
global.hdivscreen=floor((global.players-1)/2)+1
global.bg_type=0
global.track=0
global.track_type=0
global.big_image=0
global.feather=true

global.cc=1.25
global.revolutions=0
global.special_lock=1
global.class_lock=1
global.super_lock=1
global.xmaxland=128
global.ymaxland=128
global.fnt_main=font_add_sprite_ext(spr_font,"abcdefghijklmnopqrstuvwxyz0123456789:.%/?-_'\"·!<>()*LCFçG|áéíóWU´`,",1,0)
global.fnt_big=font_add_sprite_ext(spr_big_font,"abcdefghijklmnopqrstuvwxyz0123456789'\"ç",1,0)

global.pchar[0]="á"
global.pchar[1]="é"
global.pchar[2]="í"
global.pchar[3]="ó"
#macro l_track 0
#macro l_dirt 1
#macro l_mud 2
#macro l_grass 3
#macro l_water 4
#macro l_water_deep 5
#macro l_wall 6
#macro l_lakitu 7
#macro l_snow 8
#macro l_hole 9

#macro obj_vals 8

enum BT
{
	up,down,left,right,A,B,X,Y,L,R,start
}
global.bname[BT.up]="up"
global.bname[BT.down]="down"
global.bname[BT.left]="left"
global.bname[BT.right]="right"
global.bname[BT.A]="a"
global.bname[BT.B]="b"
global.bname[BT.X]="x"
global.bname[BT.Y]="y"
global.bname[BT.L]="l"
global.bname[BT.R]="r"
global.bname[BT.start]="start"

#region stats
#macro ch_mario 0
#macro ch_luigi 1
#macro ch_peach 2
#macro ch_yoshi 3
#macro ch_bowser 4
#macro ch_dk 5
#macro ch_toad 6
#macro ch_koopa 7
#macro ch_wario 8
#macro ch_waluigi 9
global.driver_name[0]="mario"
global.driver_name[1]="luigi"
global.driver_name[2]="princess"
global.driver_name[3]="yoshi"
global.driver_name[4]="bowser"
global.driver_name[5]="donkey_kong_jr"
global.driver_name[6]="toad"
global.driver_name[7]="koopa_troopa"

global.speed[0]=1.02
global.handle[0]=1
global.weight[0]=1
global.aceleration[0]=1
global.push[0]=1

global.speed[1]=1
global.handle[1]=0.97
global.weight[1]=1
global.aceleration[1]=1.5
global.push[1]=0.8

global.speed[2]=1.12
global.handle[2]=1
global.weight[2]=1.1
global.aceleration[2]=0.8
global.push[2]=1.5

global.speed[3]=0.97
global.handle[3]=1.2
global.weight[3]=0.7
global.aceleration[3]=1
global.push[3]=0.5

global.speed[4]=1.03
global.handle[4]=0.95
global.weight[4]=1.35
global.aceleration[4]=0.9
#endregion
#region pblock
#macro p_exists 0
#macro p_x 1
#macro p_y 2
#macro p_size 3
#macro p_angle 4
#macro p_direction 5
#macro p_cpu 6
#macro p_type 7
#endregion
#region item probabilities

#macro items 9

enum itm
{
	none,banana,shell_g,shell_r,mushroom,ghost,feather,ray,star,shell_b
}

var set=0
global.prob[set,1]=50
global.prob[set,2]=25
global.prob[set,3]=15
global.prob[set,4]=0
global.prob[set,5]=2
global.prob[set,6]=0
global.prob[set,7]=0
global.prob[set,8]=0
global.prob[set,9]=0
set++
global.prob[set,1]=0
global.prob[set,2]=35
global.prob[set,3]=25
global.prob[set,4]=8
global.prob[set,5]=2
global.prob[set,6]=12
global.prob[set,7]=0
global.prob[set,8]=2
global.prob[set,9]=0
set++
global.prob[set,1]=0
global.prob[set,2]=10
global.prob[set,3]=15
global.prob[set,4]=30
global.prob[set,5]=2
global.prob[set,6]=12
global.prob[set,7]=2
global.prob[set,8]=10
global.prob[set,9]=8
set++
global.prob[set,itm.banana]=0
global.prob[set,itm.shell_g]=0
global.prob[set,itm.shell_r]=0
global.prob[set,itm.mushroom]=15
global.prob[set,itm.ghost]=0
global.prob[set,itm.feather]=0
global.prob[set,itm.ray]=2
global.prob[set,itm.star]=30
global.prob[set,itm.shell_b]=1
set++
#endregion
#region tracks
global.cup=0
global.track_index=0
global.vscup=0
global.vstrack=0
global.vsselected=0
global.tracklist=ds_list_create()
global.total_tracks=sprite_get_number(spr_tracks)
global.vsrandom=0
versus_reset(5)

for (var i=0;i<global.total_tracks;i++)
{
	global.record[i,0]=noone
	global.record[i,1]=noone
	
	global.laprecord[i]=noone
}

global.cup_track[0,0]=0
global.cup_track[0,1]=6
global.cup_track[0,2]=11
global.cup_track[0,3]=14
global.cup_track[0,4]=1

global.cup_track[1,0]=4
global.cup_track[1,1]=12
global.cup_track[1,2]=7
global.cup_track[1,3]=15
global.cup_track[1,4]=2

global.cup_track[2,0]=9
global.cup_track[2,1]=5
global.cup_track[2,2]=17
global.cup_track[2,3]=16
global.cup_track[2,4]=3

global.cup_track[3,0]=8
global.cup_track[3,1]=10
global.cup_track[3,2]=13
global.cup_track[3,3]=18
global.cup_track[3,4]=19

global.cup_track[4,0]=24
global.cup_track[4,1]=23
global.cup_track[4,2]=25
global.cup_track[4,3]=26
global.cup_track[4,4]=20
#endregion
#region music
global.music[0,0]=mus_mario_circuit
global.music[0,1]=4.101
global.music[1,0]=mus_choco_island
global.music[1,1]=1.985
global.music[2,0]=mus_donut_plains
global.music[2,1]=0.684
global.music[3,0]=mus_ghost_valley
global.music[3,1]=2.3
global.music[4,0]=mus_bowser_castle
global.music[4,1]=4.272
global.music[5,0]=mus_koopa_beach
global.music[5,1]=1.525
global.music[6,0]=mus_vanilla_lake
global.music[6,1]=0
global.music[7,0]=mus_rainbow_road
global.music[7,1]=6.606
global.music[8,0]=mus_mute_city
global.music[8,1]=0
global.music[9,0]=mus_big_blue
global.music[9,1]=0
global.music[10,0]=mus_toad_harbor
global.music[10,1]=6.563
global.music[11,0]=mus_rainbow_road_wii
global.music[11,1]=11.222
global.music[12,0]=mus_outrun
global.music[12,1]=21.221
global.music[13,0]=mus_cue_ball
global.music[13,1]=7.416

global.rank_music[0,0]=0.53//mario
global.rank_music[0,1]=3.065
global.rank_music[1,0]=0.485//luigi
global.rank_music[1,1]=2.781
global.rank_music[2,0]=0.791//peach
global.rank_music[2,1]=6.698
global.rank_music[3,0]=0.7//yoshi
global.rank_music[3,1]=4.799
global.rank_music[4,0]=0.674//bowser
global.rank_music[4,1]=3.95
global.rank_music[5,0]=0.397//dk
global.rank_music[5,1]=4.034
global.rank_music[6,0]=0.976//toad
global.rank_music[6,1]=6.507
global.rank_music[7,0]=0.794//koopa
global.rank_music[7,1]=4.729
global.rank_music[8,0]=0//lost
global.rank_music[8,1]=15.792

global.song=0
#endregion
global.cup_name[0]="mushroom"
global.cup_name[1]="flower"
global.cup_name[2]="star"
global.cup_name[3]="special"
global.cup_name[4]="super"

global.points[0]=10
global.points[1]=8
global.points[2]=6
global.points[3]=4
global.points[4]=3
global.points[5]=2
global.points[6]=1
global.points[7]=0

for (var i=0;i<8;i++)
{
	global.pdriver[i]=i
}

reset_players()

global.position=1

draw_set_font(global.fnt_main)
sur=surface_create(1024,1024)

global.online=0
global.mode=0
global.maxplayers=1
global.realplayers=4

global.totalcups=5

for (var i=0;i<50;i++)
{
	for (var j=0;j<global.totalcups;j++)
	{
		global.cup_won[i,j]=0
	}
}

global.joycon=0
progress_load()

done=false
window_set_size(global.display_scale*400,global.display_scale*224)
alarm[0]=1

draw_reset()

for (var i=0;i<500;i++)
{
	global.model[i]=-1
}