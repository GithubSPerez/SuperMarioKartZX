if ds_list_size(global.tracklist)>global.total_tracks
{
	ds_list_clear(global.tracklist)
}
var rcup=round(random_range(0,array_height_2d(global.cup_track)-1-global.special_lock))
global.track=global.cup_track[rcup,round(random_range(0,array_length_2d(global.cup_track,rcup)-1))]
for (var i=0;i<ds_list_size(global.tracklist);i++)
{
	if global.track=ds_list_find_value(global.tracklist,i)
	{
		return(1)
	}
}
ds_list_add(global.tracklist,global.track)
return(0)