fakecup=global.vscup
faketrack=global.vstrack
pause=0
rot=0
state=1
if !global.time_trial
{
	if global.vspoints=global.vsmaxpoints
	{
		state=0
	}
	else
	{
		if global.vsrandom
		{
			room_goto(rm_next_track)
		}
	}
}

option=0

if !audio_is_playing(mus_menu)
{
	audio_stop_all()
	audio_stop_intro()
	audio_play_sound(mus_menu,1,1)
}
canwatch=false

name[0]="mario circuit"
name[1]="mario circuit 2"
name[2]="mario circuit 3"
name[3]="mario circuit 4"

name[4]="choco island"
name[5]="choco island 2"

name[6]="donut plains"
name[7]="donut plains 2"
name[8]="donut plains 3"

name[9]="koopa beach"
name[10]="kooba beach 2"

name[11]="ghost valley"
name[12]="ghost valley 2"
name[13]="ghost valley 3"

name[14]="bowser castle"
name[15]="bowser castle 2"
name[16]="bowser castle 3"

name[17]="vanilla lake"
name[18]="vanilla lake 2"

name[19]="rainbow road"

name[20]="W¡rainbow road"
name[21]="mute city"
name[22]="dona"
name[23]="big blue"
name[24]="WU¡toad harbor"
name[25]="cue ball circuit"
name[26]="outrun beach"

onlock=false