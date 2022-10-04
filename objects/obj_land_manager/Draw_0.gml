if global.bg_fill_img!=3
{
	var maxd=3+global.track_type
	//draw_sprite_tiled(global.bg_fill[global.bg_fill_img],0,-1024+d*1024,-1024+f*1024)
	for (var d=0;d<maxd;d++)
	{
		for (var f=0;f<maxd;f++)
		{
			var skip=(d=1 and f=1)
			if maxd=4
			{
				skip=((d=1 or d=2) and (f=1 or f=2))
			}
			if !skip
			{
				draw_sprite(global.bg_fill[global.bg_fill_img],0,-1024+d*1024+512,-1024+f*1024+512)
			}
		}
	}
}
tex=sprite_get_texture(track_get_sprite(),track_get_image())
x3d_draw_plane(track,tex,(size*8)/2,(size*8)/2,-0.01,90,0,0,2,1,1)
/*
for (var i=0;i<128;i++)
{
	for (var j=0;j<128;j++)
	{
		if collision[i,j]!=0
		draw_sprite(spr_collisions,collision[i,j],i*8,j*8)
	}
}
*/