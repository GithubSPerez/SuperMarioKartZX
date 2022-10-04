vsp+=grav
y+=vsp
if place_meeting(x,y+26,obj_finish) and !headhit
{
	vsp*=-0.5
	headhit=true
	draw=true
	audio_play_new(snd_item)
}
if y>obj_finish.y
{
	y=obj_finish.y
	vsp*=-0.5
	if hit<3
	{
		audio_play_new(snd_item)
		hit++
	}
}