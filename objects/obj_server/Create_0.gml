global.netport=7000
global.netsock=network_create_server_raw(network_socket_tcp,global.netport,4)
while global.netsock<0
{
	global.netport++
	global.netsock=network_create_server_raw(network_socket_tcp,global.netport,4)
	if global.netport>8000
	{
		show_message("fuck")
		game_restart()
		exit
	}
}
show_message("server listo. port: "+string(global.netport))
total_k=6
for (var i=0;i<total_k;i++)
{
	key[0,i]=0
	key[1,i]=0
	key[2,i]=0
}
players=0
ongame=0
p_socket[0]=0
p_instance[0]=noone
p_instance[1]=noone
p_instance[2]=noone