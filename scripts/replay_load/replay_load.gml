var folder="replays"
if !directory_exists(folder)
{
	global.init_replay=false
	exit
}
var f=file_text_open_read(folder+"/replay_"+string(global.track))

if f=-1
{
	global.init_replay=false
	exit
}

var r=obj_input_manager

global.driver[0,2]=file_text_read_real(f)
file_text_readln(f)
var rep=file_text_read_real(f)
file_text_readln(f)

for (var data_ind=0;data_ind<rep;data_ind++)
{
	r.data[data_ind,0]=file_text_read_real(f)
	for (var i=0;i<r.key_numb;i++)
	{
		r.data[data_ind,i+1]=-1
	}

	while true
	{
		var read=file_text_read_real(f)
		if read!=-1
		{
			r.data[data_ind,floor(read)+1]=(read-floor(read))*10
		}
		else
		{
			r.data[data_ind,r.key_numb+1]=file_text_read_real(f)
			r.data[data_ind,r.key_numb+2]=file_text_read_real(f)
			r.data[data_ind,r.key_numb+3]=file_text_read_real(f)
			r.data[data_ind,r.key_numb+4]=file_text_read_real(f)
			break
		}
	}

	file_text_readln(f)
}
//show_message(r.data)
file_text_close(f)