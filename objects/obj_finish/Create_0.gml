audio_stop_intro()
audio_stop_all()
audio_play_sound(mus_congratulations,0,0)
x=room_width/2
state=0
congrats_size=0
cvsp=0
cgrav=0.0025
place=noone
versus_reset(global.vsmaxpoints)
stands=clamp(global.drivers,1,3)
for (var i=0;i<stands;i++)
{
	if global.driver[global.scoreplace[i],0]=1
	{
		place=i
		break
	}
}
if place=noone
{
	room_goto(rm_game_over)
	exit
}
credits=false
if global.cup!=-1
{
	var actual=global.cup_won[real(cc_get_string())/50-1,global.cup]
	var toset=place+1
	if actual=0 or toset<actual
	{
		if global.cup_won[real(cc_get_string())/50-1,global.cup]=0
		{
			credits=true
		}
		global.cup_won[real(cc_get_string())/50-1,global.cup]=toset
		
		progress_save()
	}
	//show_message(place+1)
}
player_driver=global.driver[global.scoreplace[place],2]

jx[0]=0
jx[1]=-30
jx[2]=30
ftox=x+jx[place]

fish=instance_create_depth(room_width+48,room_height/3,depth-2,obj_fish)
fish.tox=ftox
s_y=43
jy[0]=0
jy[1]=8
jy[2]=16

pop=0
champ=0
img[0]=0
img[1]=0
img[2]=0

recieved=0

retro_sur=surface_create(400,224)

if !shader_is_compiled(sh_congrats)
{
	show_message("pene")
}
cup_name[0]="gold"
cup_name[1]="silver"
cup_name[2]="bronze"

compliment="great_race!"
if global.cup=3
{
	compliment="you_have_excellent_skills!"
}
if global.cup=4
{
	compliment="you're_a_super_mario_kart\n\nexpert!"
}
final_text=global.driver_name[player_driver]+"_wins_the_"+cup_name[place]+"_trophie."
char=0
alarm[0]=60*2

pene=0

sound=0