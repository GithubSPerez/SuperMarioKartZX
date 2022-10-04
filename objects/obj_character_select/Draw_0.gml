var bgjx=0
if state=0
{
	bgjx=-global.time
}
draw_sprite_tiled(spr_ch_bg2,0,0,0)

draw_sprite_ext(spr_character_select,0,x+8,y+8,1,1,0,c_black,1)

surface_set_target(bg_sur)
draw_sprite_tiled(spr_ch_bg,0,bgjx,32)
surface_reset_target()

draw_surface(bg_sur,startx-32,starty-24)

surface_set_target(sign_sur)
draw_sprite_tiled(spr_choose_driver,0,-global.time/1.5,0)
surface_reset_target()

draw_surface(sign_sur,startx+32,starty-40)

draw_self()
draw_set_color(c_white)
for (var i=0;i<global.players;i++)
{
	var p=global.pdriver[i]
	var tp=global.players
	var jx=floor(p/2)*48
	var jy=(p%2)*64
	
	
	var jpx=0
	for (var j=0;j<i+1;j++)
	{
		if global.pdriver[j]=p and j!=i
		{
			jpx+=floor(16/tp)
		}
	}
	draw_sprite(spr_pnumbers+(tp-1),i+(ready[i]*tp),startx+jx+jpx,starty+jy)
}
for (var i=0;i<8;i++)
{
	var sjy=0
	if img_type[i]=0
	{
		sjy=(dcos(global.time*25+i*78)/2)
	}
	if img_type[i]=2
	{
		if img_index[i]<11.5
		{
			img_index[i]+=1/6
		}
	}
	var chjx=48
	var chjy=64
	draw_sprite(spr_mario+i,img_index[i],startx+8+chjx*(floor(i/2)),starty+48+sjy+chjy*(i%2))
}
if readys=global.players and !(global.maxplayers>1 and global.players=1)
{
	var txt="ok?"
	draw_set_color(c_white)
	if state=2
	{
		txt="ok"
		draw_set_color(c_yellow)
	}
	draw_text(startx+okjx,starty+okjy,txt)
}

if global.players<global.maxplayers
{
	draw_reset()
	draw_set_halign(fa_center)
	draw_set_color(merge_color(c_white,c_yellow,global.time%60>30))
	draw_text(global.screen_w/2,4,"press start to join")
	draw_reset()
}