if !global.time_trial
{
	for (var i=0;i<8;i++)
	{
		if global.won[i,0]!=noone
		{
			var jy=face_sy+face_jy*i
			draw_set_font(global.fnt_big)
			draw_text(2,jy,i+1)
			var jind=((global.time+i*22)/8)%2
			if i>3
			{
				jind=2
			}
			draw_sprite(spr_player_faces,global.won[i,0]*3+jind,12,jy)
			draw_reset()
		}
	}
}
else
{
	if completed>2
	{
		a+=0.05
		draw_set_alpha(a)
		draw_records(global.screen_w/2-8*4.5,global.screen_h/4-8*4,global.track)
		draw_reset()
	}
}