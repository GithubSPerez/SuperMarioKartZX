var file=file_text_open_read("smk_save")
if file!=-1
{
	global.revolutions=file_text_read_real(file)
	for (var i=0;i<3+global.revolutions;i++)
	{
		for (var j=0;j<global.totalcups;j++)
		{
			global.cup_won[i,j]=file_text_read_real(file)
		}
	}
	for (var i=0;i<global.total_tracks;i++)
	{
		global.record[i,0]=file_text_read_real(file)
		global.record[i,1]=file_text_read_real(file)
	
		global.laprecord[i]=file_text_read_real(file)
	}
	global.display_scale=file_text_read_real(file)
	global.retro=file_text_read_real(file)
	global.joycon=file_text_read_real(file)
	file_text_close(file)
}