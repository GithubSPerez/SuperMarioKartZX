if editmode=0
{
	shader_set(sh_b_w)
}
if editmode!=5
{
	var tsprite=track_get_sprite()
	var tsize=sprite_get_width(tsprite)
	draw_sprite(tsprite,track_get_image(),tsize/2,tsize/2)
}

shader_reset()
if editmode=0
{
	for (var i=0;i<global.xmaxland;i++)
	{
		var drawnto=0
		for (var j=0;j<global.ymaxland;j++)
		{
			var coll=collision[i,j]
			if coll!=0
			{
				var yscale=1
				
				/*
				if j+yscale<global.ymaxland-1
				{
					while collision[i,j+yscale]=coll
					{
						yscale++
						if j+yscale>global.ymaxland-1
						{
							break
						}
					}
				}
				*/
				draw_sprite_ext(spr_collisions,coll,i*8,j*8,1,yscale,0,c_white,1)
				j+=yscale-1
			}
		}
	}
	draw_sprite_ext(spr_collisions,index,x,y,scale,scale,0,c_white,1)
}
if editmode=2
{
	draw_set_alpha(0.75)
	draw_set_color(c_white)
	draw_rectangle(goal_x,goal_y,goal_x+goal_xscale*8,goal_y+goal_yscale*8,0)
	draw_set_color(c_black)
	draw_rectangle(goal_x,goal_y,goal_x+goal_xscale*8,goal_y+goal_yscale*8,1)
	draw_set_alpha(1)
}
if editmode=4
{
	draw_sprite_ext(object_get_sprite(obj_top),0,x,y,1,1,obj_rotation,c_white,0.5)
}
if (editmode=3 or editmode=1) and fastmode
{
	draw_sprite_ext(spr_pblock,0,x,y,1,4,preangle,c_red,0.5)
}