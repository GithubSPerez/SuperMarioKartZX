audio_stop_intro()
audio_stop_all()
mus=false

for (var i=0;i<global.players;i++)
{
	var ins=create_fake_player(8)
	ins.sprite_index=spr_mario+global.driver[i,2]
	ins.x-=34*i
	//show_message(ins.inumb)
}
ylimit=room_height/2-20
x=room_width/2
y=-100
grav=0.1
grav2=0.05
vsp=0
asp=0
instance_destroy(obj_transition)
cangoback=1