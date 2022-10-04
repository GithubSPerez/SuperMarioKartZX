if async_load[? "type"]=network_type_connect
{
	show_message("connection!")
	//p_socket[players]=async_load[? "socket"]
	ongame=1
}
if async_load[? "type"]=network_type_disconnect
{
	show_message("ya no hay connection...")
	ongame=0
}
if async_load[? "type"]=network_type_data
{
	var buff=async_load[? "buffer"]
	var sock=async_load[? "socket"]
	buffer_seek(buff,buffer_seek_start,0)
	var p=buffer_read(buff,buffer_u8)
	/*
	while p_socket[p]!=sock
	{
		p++
		if p=qplayers
		{
			show_message("fuck v2.")
			game_restart()
			exit
		}
	}
	*/
	for (var i=0;i<total_k;i++)
	{
		key[p,i]=buffer_read(buff,buffer_u8)
	}
}