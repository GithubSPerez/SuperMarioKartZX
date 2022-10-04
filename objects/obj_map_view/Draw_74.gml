if global.players=1
{
	draw_set_color(global.bg_col)
	draw_rectangle(0,global.screen_h/2,global.screen_w,global.screen_h,0)
	draw_reset()
}
draw_surface_ext(global.view_sur[1],0,global.screen_h/2,1/global.screen_scale,1/global.screen_scale,0,c_white,1)
surface_set_target(global.view_sur[1])
draw_clear_alpha(c_white,0)
surface_reset_target()