if file_exists("tileset.png")
{
	if brush!=sprite_index
	{
		sprite_delete(brush)
	}
	brush=sprite_add("tileset.png",1,false,false,0,0)
	tilenumb=floor(sprite_get_height(brush)/tilesize*lines)
}