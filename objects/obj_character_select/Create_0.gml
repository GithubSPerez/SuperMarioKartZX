if !audio_is_playing(mus_menu)
{
	audio_stop_all()
	audio_stop_intro()
	audio_play_sound(mus_menu,1,1)
}
x=room_width/2
y=room_height/2

startx=x-80
starty=y-48

okjx=151
okjy=128
readys=0

ready[0]=0
ready[1]=0
ready[2]=0
ready[3]=0

state=0
cooldown=0

for (var i=0;i<8;i++)
{
	img_type[i]=0
	img_index[i]=7
}

bg_sur=surface_create(224,168)
sign_sur=surface_create(96,16)