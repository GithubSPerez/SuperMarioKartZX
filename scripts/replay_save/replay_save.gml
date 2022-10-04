var folder="replays"
if !directory_exists(folder)
{
	directory_create(folder)
}
var f=file_text_open_write(folder+"/replay_"+string(global.track))

var r=obj_input_manager

file_text_write_real(f,global.driver[0,2])
file_text_writeln(f)
var rep=array_height_2d(r.data)
file_text_write_real(f,rep)
file_text_writeln(f)

for (var data_ind=0;data_ind<rep;data_ind++)
{
	file_text_write_real(f,r.data[data_ind,0])

	var len=array_length_2d(r.data,data_ind)
	for (var i=0;i<len-5;i++)
	{
		var btt=r.data[data_ind,i+1]
		if btt!=-1
		{
			file_text_write_real(f,i+btt/10)
		}
	}
	file_text_write_real(f,-1)
	
	if len>r.key_numb
	{
		file_text_write_real(f,r.data[data_ind,i+1])
		file_text_write_real(f,r.data[data_ind,i+2])
		file_text_write_real(f,r.data[data_ind,i+3])
		file_text_write_real(f,r.data[data_ind,i+4])
	}
	file_text_writeln(f)
}
file_text_close(f)