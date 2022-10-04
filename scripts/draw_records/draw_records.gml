///@param x
///@param y
///@param track
var xx=argument0
var yy=argument1
var t=argument2

var jjy=48
var jy=16

var p=global.record[t,1]

draw_set_font(global.fnt_main)
draw_text(xx,yy,"best time")
draw_text(xx,yy+jjy,"fastest lap")
draw_text(xx,yy+jjy+jy*0.6,timer_get_string(global.laprecord[t]))

draw_set_font(global.fnt_big)
draw_text(xx,yy+jy,timer_get_string(global.record[t,0]))
if p!=noone
{
	draw_sprite(spr_player_faces,p*3,xx+9*7,yy+jy)
}