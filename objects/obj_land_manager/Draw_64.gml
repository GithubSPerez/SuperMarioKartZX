if !drew
{
	gpu_set_ztestenable(false)
	surface_set_target(global.plain_track)
	draw_sprite_ext(track_get_sprite(),track_get_image(),size*8/2,size*8/2,1,1,0,c_white,1)
	surface_reset_target()
	gpu_set_ztestenable(true)
	drew=true
}
/*
for (i=0;i<8;i++)
{
	draw_text(16,i*16,ds_list_find_value(pl_list,i))
}