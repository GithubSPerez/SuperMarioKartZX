if !cpu
{
	gpu_set_ztestenable(false)
	var col=c_white
	if thunder_time>0
	{
		thunder_time-=global.T
		col=merge_color(c_yellow,c_dkgray,(thunder_time%3)/3)
	}
	draw_set_color(global.bg_col)
	//draw_rectangle(s_x,s_y,s_x+s_w,s_y+s_h,0)
	
	if global.bg_fill_img!=3
	{
		surface_set_target(filler_sur)
		draw_sprite_tiled_ext(spr_bg_fill,global.bg_fill_img,0,0,0.62,0.62,col,1)
		surface_reset_target()
	
		draw_surface(filler_sur,s_x,s_y)
	}
	draw_set_color(c_white)
	surface_free(bg_sur)
	bg_sur=noone
	if bg_sur=noone
	{
		if global.bg_type=0
		{
			var h=32-4
			if global.bg_img=10
			{
				h=s_h/2//global.divscreen
				//show_message(h)
			}
			bg_sur=surface_create(s_w,h)
		}
		else
		{
			bg_sur=surface_create(s_w,s_h/2)
		}
	}
	//show_message(surface_exists(bg_sur))
	surface_set_target(bg_sur)
	var j_y=0
	var bsize=768*2
	var fsize=1280
	var scale=1
	if global.bg_type=1
	{
		scale=1
		bsize=256*3*scale
		fsize=bsize*2
		bg_y-=dsin(vis_dir)/9
		j_y=-32+bg_y
	}
	var bg_spd=angle_difference(vis_dir,lvisdir)
	lvisdir=vis_dir
	bg_x+=bg_spd*3
	bg_front_x+=bg_spd*5
	draw_sprite_tiled_ext(spr_bg_back+global.bg_type*2,global.bg_img,bg_x/*bsize*vis_dir/360*/,-4+j_y,scale,scale,col,1)
	draw_sprite_tiled_ext(spr_bg_front+global.bg_type*2,global.bg_front_img,bg_front_x/*fsize*vis_dir/360*/,-4,scale,scale,col,1)
	
	surface_reset_target()
	draw_surface(bg_sur,s_x,s_y)
	
	var view_i=player-1
	
	/*
	surface_set_target(global.view_sur[view_i])
	draw_surface(global.lag_surface[view_i],0,0)
	surface_reset_target()
	*/
	draw_surface_ext(global.view_sur[view_i],s_x,s_y,1/global.screen_scale,1/global.screen_scale,0,col,1)
	surface_set_target(global.view_sur[view_i])
	draw_clear_alpha(c_white,0)
	surface_reset_target()
	/*
	if global.time%4=3
	{
		surface_set_target(global.lag_surface[view_i])
		draw_clear_alpha(c_white,0)
		surface_reset_target()
	}
	*/
	gpu_set_ztestenable(true)
}