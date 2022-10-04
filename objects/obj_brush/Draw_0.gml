var cam_spd=4*global.T
cam_x+=(keyboard_check(ord("D"))-keyboard_check(ord("A")))*cam_spd
cam_y+=(keyboard_check(ord("S"))-keyboard_check(ord("W")))*cam_spd
camera_set_view_pos(cam,cam_x,cam_y)
scale+=keyboard_check_pressed(ord("U"))-keyboard_check_pressed(ord("Y"))
if scale<1 scale=1
camera_set_view_size(cam,global.screen_w*scale,global.screen_h*scale)

var xchange=key_check("X",1)
var ychange=key_check("C",1)
if xchange
{
	xdir*=-1
}
if ychange
{
	ydir*=-1
}

xcoord=floor(mouse_x/grid_size)*grid_size
ycoord=floor(mouse_y/grid_size)*grid_size
draw_sprite(spr_tracks_big,1,2048/2,2048/2)

if key_check("K",1)
{
	wallmode++
	wallmode%=2
	wallind=0
}
if wallmode
{
	if ((xcoord!=lxcoord or ycoord!=lycoord) and key_check(vk_space,0)) or key_check("F",1)
	{
		wallind+=wallmod
		tile=walltile+floor(wallind)
		if wallind=walltiles
		{
			wallind=0
			tile-=walltiles
		}
	}
}

var tchange=key_check("E",1)-key_check("Q",1)
tile+=tchange
tile%=tilenumb
if tile<0 tile=tilenumb-1
tilex=(tile%lines)*tilesize
tiley=floor(tile/lines)*tilesize

grid+=key_check("G",1)
grid%=2

if grid
{
	draw_sprite_tiled(spr_grid,0,0,0)
}


xoffset+=(key_check(vk_right,1)-key_check(vk_left,1))*4
yoffset+=(key_check(vk_down,1)-key_check(vk_up,1))*4

if mouse_x>cam_x+sidebarx*scale
{
	surface_set_target(canvas)
	if !done
	{
		draw_sprite(spr_tracks_big,1,2048/2,2048/2)
		done=true
	}
	if key_check(vk_shift,0) and key_check(vk_alt,0) and key_check("P",1)
	{
		for (var i=0;i<256;i++)
		{
			for (var j=0;j<256;j++)
			{
				draw_tile_ex(1,i*8,j*8)
			}
		}
	}
	if keyboard_check(vk_space)
	{
		if !key_check(vk_shift,0)
		{
			if !key_check("Z",0) or surface_getpixel(canvas,xcoord,ycoord)!=c_black
			{
				draw_tile_ex(1,xcoord,ycoord)//draw_sprite(brush,0,xcoord+xoffset,ycoord+yoffset)
			}
		}
		else
		{
			for (var i=0;i<paint_length;i++)
			{
				var dx=floor((xcoord+lengthdir_x(i*8,paint_angle))/8)*8
				var dy=floor((ycoord+lengthdir_y(i*8,paint_angle))/8)*8

				//surface_reset_target()
				var dr=true//surface_getpixel(canvas,dx+4,dy+4)=c_white
				//surface_set_target(canvas)

				if dr
				{
					draw_tile_ex(1,dx,dy)
				}
			}
		}
	}
	if key_check("J",1)
	{
		var p=instance_create_depth(xcoord+4,ycoord+4,depth-1,obj_tile_painter)
		p.col=surface_getpixel(canvas,p.x,p.y)
		p.tile=1
		p.visible=true
	}
	if keyboard_check(ord("B"))
	{
		gpu_set_blendmode(bm_subtract)
		draw_sprite(spr_wall,0,xcoord,ycoord)
		gpu_set_blendmode(bm_normal)
	}
	surface_reset_target()
}
else
{
	if mouse_check_button_pressed(mb_left)
	{
		tile=floor((mouse_x-cam_x)/scale/tilesize)%lines+floor((mouse_y-cam_y)/scale/tilesize)*lines
	}
}

if !wallmode
{
	walltile=tile
}

draw_surface(canvas,0,0)

if !key_check(vk_shift,0)
{
	draw_tile_ex(0.5,xcoord,ycoord)
}
else
{
	paint_length+=key_check("M",1)-key_check("N",1)
	paint_angle-=key_check("P",0)-key_check("O",0)
	for (var i=0;i<paint_length;i++)
	{
		var dx=floor((xcoord+lengthdir_x(i*8,paint_angle))/8)*8
		var dy=floor((ycoord+lengthdir_y(i*8,paint_angle))/8)*8
		draw_tile_ex(0.5,dx,dy)
	}
}

if keyboard_check_pressed(vk_backspace)
{
	var f=get_open_filename("|*.png","brush")
	file_copy(f,"tileset.png")
	load_tileset()
	/*
	if file_exists(f)
	{
		var tileset=surface_create(sidebarx,1024)
		surface_set_target(tileset)
		draw_sprite(brush,0,0,0)
		tilex=(tilenumb%lines)*tilesize
		tiley=floor(tilenumb/lines)*tilesize
		var todrw=sprite_add(f,1,false,false,0,0)
		draw_sprite(todrw,0,tilex,tiley)
		surface_reset_target()
		if brush!=sprite_index
		{
			sprite_delete(brush)
		}
		brush=sprite_create_from_surface(tileset,0,0,sidebarx,1024,false,false,0,0)
		sprite_save(brush,0,"tileset.png")
		tilenumb++
		var ff=file_text_open_write("tilenumb")
		file_text_write_real(ff,tilenumb)
		file_text_close(ff)
	}
	else
	{
		show_message(f+" no existe")
	}
	*/
}
if keyboard_check_pressed(vk_escape)
{
	var f=get_open_filename("|*.png","load")
	file_copy(f,"mapsave")
	var f="mapsave"
	
	if file_exists(f)
	{
		var s=sprite_add(f,1,false,false,0,0)
		surface_set_target(canvas)
		draw_sprite(s,0,0,0)
		surface_reset_target()
		sprite_delete(s)
	}
	else
	{
		show_message(f+" no existe")
	}
}
if keyboard_check_pressed(vk_enter)
{
	var f=get_save_filename("|*.png","save")
	surface_save(canvas,f)
}

lxcoord=xcoord
lycoord=ycoord