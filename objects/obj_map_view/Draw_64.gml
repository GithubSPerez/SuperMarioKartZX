#region 2 player
if global.players=2
{
	shit=1
}
#endregion
#region 1 player
if global.players>1 exit;
surface_set_target(draw_sur)
draw_clear_alpha(c_white,0)
var s_w=global.screen_w
var s_h=global.screen_h
xmul=multi
xoff=s_w/2+xoffset
ymul=multi/2
yoff=yoffset
pl[0]=noone
ipl=noone
with obj_player
{
	other.pl[place-1]=id
	if player=1
	{
		other.ipl=id
	}
}
for (i=global.drivers-1;i>=-1;i--)
{
	if i=-1
	{
		var ins=ipl
		var check=1
	}
	else
	{
		var ins=pl[i]
		var check=pl[i]!=ipl
	}
	if check
	{
		with ins
		{
			var dxx=x3d_get_point(1,x,0,y,1)*other.xmul+other.xoff
			var dyy=x3d_get_point(1,x,0,y,0)*other.ymul+other.yoff
			if !cpu
			{
				draw_sprite_ext(spr_map_char_glow,0,dxx,dyy,1,1,0,c_white,1)
			}
			draw_sprite_ext(spr_map_char,character,dxx,dyy,1,1,0,c_white,1)
			if global.debug
			{
				draw_text(dxx,dyy,band)
			}
		}
	}
}
map_size=(s_h)/2
surface_reset_target()
draw_surface(draw_sur,0,s_h/2)
#endregion