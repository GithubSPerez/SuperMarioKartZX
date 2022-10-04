var d=instance_create_depth(x,y,depth,obj_ded_sprite)
d.spr=spr
if !cpu or camera_visible()
{
	audio_play_new(snd_itemdestroy)
}