var f=file_text_open_read("smk_input")
if f=-1 exit

ds_map_destroy(inputs)
inputs=ds_map_create()
inputs[? "default_keyboard"]=0
inputs[? "default_gamepad"]=1

var t=file_text_read_real(f)
input_sets=t
file_text_readln(f)

for (var i=0;i<t;i++)
{
	var key=file_text_read_string(f)
	file_text_readln(f)
	inputs[? key]=file_text_read_real(f)
	file_text_readln(f)
}

for (var i=0;i<t;i++)
{
	var btns=file_text_read_real(f)
	
	for (var j=0;j<btns;j++)
	{
		var bid=file_text_read_real(f)
		var bty=file_text_read_real(f)
		var bva=file_text_read_real(f)
		B_set(i,j,bid,bty,bva)
	}
	file_text_readln(f)
}
if file_text_read_real(f)
{
	file_text_readln(f)
	for (var i=0;i<4;i++)
	{
		for (var j=0;j<array_length_2d(joykey,i);j++)
		{
			joykey[i,j]=file_text_read_real(f)
		}
		file_text_readln(f)
	}
}
//else show_message("no key data")
file_text_close(f)