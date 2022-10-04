var f=file_text_open_write("smk_input")

var t=input_sets
file_text_write_real(f,t)
file_text_writeln(f)

var key=ds_map_find_first(inputs)
while true
{
	file_text_write_string(f,key)
	file_text_writeln(f)
	file_text_write_real(f,inputs[? key])
	file_text_writeln(f)
	
	if ds_map_find_last(inputs)=key
	{
		break
	}
	key=ds_map_find_next(inputs,key)
}
for (var i=0;i<t;i++)
{
	var btns=array_length_2d(btt,i)/3
	file_text_write_real(f,btns)
	for (var j=0;j<btns;j++)
	{
		file_text_write_real(f,B_id(i,j))
		file_text_write_real(f,B_type(i,j))
		file_text_write_real(f,B_val(i,j))
	}
	file_text_writeln(f)
}
file_text_write_real(f,1)
file_text_writeln(f)
for (var i=0;i<4;i++)
{
	for (var j=0;j<array_length_2d(joykey,i);j++)
	{
		file_text_write_real(f,joykey[i,j])
	}
	file_text_writeln(f)
}
file_text_close(f)