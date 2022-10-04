draw_sprite_tiled(spr_title_bg,1,-global.time,0)
draw_set_font(global.fnt_big)
draw_set_halign(fa_center)
draw_set_color(c_red)
font_set_stroke_color(c_white)
draw_text(room_width/2,8,"results")
draw_reset()

for (var i=0;i<6;i++)
{
	var s=-1
	if i>2
	{
		s=1
	}
	draw_sprite(spr_cup_ind,global.cup+1,room_width/2+ind_jx*s+(16*(i%3)*s),16)
}
draw_set_color(merge_color(c_red,c_white,0.9))
font_set_stroke_color(c_red)
var sep=string_repeat("-",46)
draw_text(16,32,sep+"\n\n"+sep)

var st_jx=24
var st_jy=40
draw_text(st_jx,st_jy,cc_get_string()+"ç")
draw_set_halign(fa_center)
var cname="missing"
if global.cup!=-1
{
	cname=global.cup_name[global.cup]+" cup"
}
else
{
	cname="vs match"
}
draw_text(room_width/2,st_jy,cname)
draw_set_halign(fa_right)
var r=global.track_index
if global.mode=1
{
	r=global.played_matches
}
draw_text(room_width-st_jx,st_jy,"round "+string(r))
draw_reset()

var n_sy=64
for (var i=0;i<tnames;i++)
{
	var exchar="_"
	var extxt="nothing lol"
	var d_id=global.place[i+1]
	var cs=c_white
	var ct=c_white
	if state=0
	{
		//d_id=global.won[i,0]
		if i>3
		{
			cs=c_black
		}
		/*
		if isitplayer
		{
			cs=merge_color(c_red,c_white,floor(global.time/3)%2)
		}
		*/
		if i<=3
		{
			ct=txtcol[i]
		}
		extxt=timer_get_string(global.won[i,1])
	}
	else if floor(state)=1 or (state>=2 and state<=6)
	{
		cs=c_black
		d_id=global.scoreplace[i]
		extxt=round(pscdraw[d_id])
	}
	var d_img=global.driver[d_id,2]
	var isitplayer=global.driver[d_id,0]=1
	
	font_set_stroke_color(cs)
	draw_set_color(ct)
	var name=global.driver_name[d_img]
	draw_text(st_jx,n_sy+i*16,string(i+1)+"_"+name+exchar+string_repeat("·",41-(string_length(name)+string_length(extxt))))
	draw_set_halign(fa_right)
	draw_text(room_width-st_jx,n_sy+i*16,extxt)
	draw_reset()
	if isitplayer
	{
		draw_sprite(spr_p_numbers_ind,(global.time/10)%2+((global.driver[d_id,1]-1)*2),room_width-st_jx+4,n_sy+i*16)
	}
}