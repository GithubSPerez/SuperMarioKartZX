if !menu_open
bg_x=(-global.time)
draw_sprite_tiled(spr_title_bg,0,bg_x,0)
draw_self()

draw_sprite(spr_zx,0,x,y+48+sin(global.time/10))