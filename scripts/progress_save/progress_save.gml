var file=file_text_open_write("smk_save")

file_text_write_real(file,global.revolutions)
for (var i=0;i<3+global.revolutions;i++)
{
	for (var j=0;j<global.totalcups;j++)
	{
		file_text_write_real(file,global.cup_won[i,j])
	}
}
for (var j=0;j<global.total_tracks;j++)
{
	
	file_text_write_real(file,global.record[j,0])
	file_text_write_real(file,global.record[j,1])
	
	if global.laprecord[j]<600
	{
		global.laprecord[j]=noone
	}
	file_text_write_real(file,global.laprecord[j])
}
file_text_write_real(file,global.display_scale)
file_text_write_real(file,global.retro)
file_text_write_real(file,global.joycon)
file_text_close(file)