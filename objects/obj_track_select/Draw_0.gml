#region options
if state=0
{
	draw_sprite_tiled(spr_options_bg,0,global.time/10,global.time/10)
	
	draw_set_halign(fa_center)
	draw_set_valign(fa_center)
	
	var sx=room_width/2
	var sy=room_height/2
	
	draw_set_color(c_white)
	if option=0 draw_set_color(c_yellow)
	var indicator=global.vsmaxpoints
	if indicator=0
	{
		indicator="endless"
	}
	draw_text(sx,sy-18,"matches···<"+string(indicator)+">")
	
	draw_set_color(c_white)
	if option=1 draw_set_color(c_yellow)
	draw_text(sx,sy,"cpus···<"+string(global.drivers-global.players)+">")
	
	draw_set_color(c_white)
	if option=2 draw_set_color(c_yellow)
	copt[0]="choose"
	copt[1]="random"
	draw_text(sx,sy+16,"courses···<"+string(copt[global.vsrandom])+">")
	
	draw_reset()
}
#endregion
#region track selecting
if state=1
{
	var tscale=224/1024
	var t=-1
	if global.vscup!=-1
	{
		t=global.cup_track[global.vscup,global.vstrack]
	}
	var bgind=0
	if t>=4
	{
		bgind=7
	}
	if t>=6
	{
		bgind=4
	}
	if t>=9
	{
		bgind=5
	}
	if t>=11
	{
		bgind=1
	}
	if t>=14
	{
		bgind=2
	}
	if t>=17
	{
		bgind=6
	}
	if t>=19
	{
		bgind=1
	}
	if t=20
	{
		bgind=1
	}
	if t=21
	{
		bgind=9
	}
	if t=23
	{
		bgind=10
	}
	if t=24
	{
		bgind=5
	}
	if t=25
	{
		bgind=11
	}
	if t=26
	{
		bgind=5
	}
	if t!=-1
	{
		if onlock
		{
			shader_set(sh_b_w)
		}
		rot++
		draw_sprite_ext(global.bg_fill[bgind],0,room_width/2,room_height/2,tscale*2.2,tscale*2.2,!onlock*rot/5,c_white,1)
		draw_sprite_ext(spr_tracks,t,room_width/2,room_height/2,tscale,tscale,!onlock*rot/5,c_white,1)
		shader_reset()
	}
	else
	{
		draw_sprite_tiled(spr_random_track,0,global.time/3,global.time/3)
	}
	var jx=128*1.5
	var jy=16
	var sx=96
	var sy=64
	for (var i=0;i<global.totalcups;i++)
	{
		draw_set_color(c_yellow)
		draw_text(sx-jx*fakecup+jx*i,sy-32,global.cup_name[i]+" cup")
		for (var j=0;j<5;j++)
		{
			if global.vscup=i and global.vstrack=j
			{
				draw_sprite(spr_cursor,0,sx-jx*fakecup+jx*i-10,sy+jy*j)
			}
			draw_set_color(c_white)
			draw_text(sx-jx*fakecup+jx*i,sy+jy*j,name[global.cup_track[i,j]])
		}
	}
	if global.time_trial
	{
		draw_set_color(c_white)
		draw_set_alpha(0.9)
		var dx=global.screen_w/2+8*4.5
		draw_rectangle(dx-8,0,dx+8*13,global.screen_h,false)
		draw_reset()
		draw_records(dx,global.screen_h/2-8*4,global.cup_track[global.vscup,global.vstrack])
		
		var rptxt="no replay\ndata"
		canwatch=false
		
		if file_exists("replays/replay_"+string(global.cup_track[global.vscup,global.vstrack]))
		{
			rptxt="press ·r· to\nwatch replay"
			canwatch=true
		}
		draw_reset()
		draw_text(dx,global.screen_h-20,rptxt)
	}
	/*
	draw_text(sx-jx*fakecup-jx/2,sy,"random")
	if global.vscup=-1
	{
		draw_sprite(spr_cursor,0,sx-jx*fakecup-jx/2-10,sy)
	}
	*/
}
#endregion