draw_reset()
draw_rectangle(0,0,sidebarx+tilesize*2,global.screen_h,false)
draw_sprite(brush,0,0,0)
draw_sprite_ext(spr_mini_ramp,0,tilex,tiley,1,1,0,c_white,0.5)

draw_sprite_part_ext(brush,0,tilex,tiley,8,8,sidebarx+tilesize+(8*(xdir=-1)),tilesize+(8*(ydir=-1)),xdir,ydir,c_white,1)

if wallmode
{
	draw_text(global.screen_w/2,0,"wallmode on "+string(floor(wallind)))
}

/*
gx[2]=window_mouse_get_x()
gy[2]=window_mouse_get_y()
draw_sprite_pos(brush,0,gx[0],gy[0],gx[1],gy[1],gx[2],gy[2],gx[3],gy[3],1)
*/