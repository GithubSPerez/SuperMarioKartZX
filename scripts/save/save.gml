if outdated exit
var t=argument0
var name="smk_t"+string(t)
var folder=tracks_get_folder()
var file=file_text_open_write(folder+"/"+name)

var ver=5
file_text_write_real(file,ver)
file_text_writeln(file)

file_text_write_real(file,global.track_type)
if global.track_type
{
	file_text_write_real(file,global.big_image)
}
file_text_writeln(file)

file_text_write_real(file,global.feather)
file_text_writeln(file)

var size=128*(global.track_type+1)
for (var i=0;i<size;i++)
{
	for (var j=0;j<size;j++)
	{
		file_text_write_real(file,collision[i,j])
	}
	file_text_writeln(file)
}
file_text_write_real(file,pindex-pdestroyed)
file_text_writeln(file)
for (i=0;i<pindex;i++)
{
	if pblock[i,p_exists]
	{
		for (j=1;j<=p_type;j++)
		{
			file_text_write_real(file,pblock[i,j])
		}
		file_text_writeln(file)
	}
}
file_text_writeln(file)
file_text_write_real(file,goal_x)
file_text_write_real(file,goal_y)
file_text_write_real(file,goal_xscale)
file_text_write_real(file,goal_yscale)
file_text_writeln(file)
file_text_write_real(file,obj_count)
file_text_writeln(file)
for (i=0;i<obj_ind;i++)
{
	if obj[i,0]
	{
		for (j=0;j<obj_vals-1;j++)
		{
			if j!=2
			file_text_write_real(file,obj[i,j+1])
			else
			{
				file_text_write_string(file,object_get_name(obj[i,j+1]))
				file_text_writeln(file)
			}
		}
		file_text_writeln(file)
	}
}
file_text_writeln(file)
file_text_write_real(file,global.bg_img)
file_text_write_real(file,global.bg_front_img)
file_text_write_real(file,global.bg_fill_img)
file_text_write_real(file,global.out_fill)
var R=color_get_red(global.bg_col)
var G=color_get_green(global.bg_col)
var B=color_get_blue(global.bg_col)
file_text_write_real(file,R)
file_text_write_real(file,G)
file_text_write_real(file,B)
file_text_write_real(file,global.bg_type)
file_text_write_real(file,global.song)
file_text_close(file)