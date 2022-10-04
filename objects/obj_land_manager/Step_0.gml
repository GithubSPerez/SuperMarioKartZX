if instance_exists(obj_player)
{
	i=0
	ds_list_clear(pl_list)
	with obj_player
	{
		other.pl_array[other.i,0]=clamp(lap,0,9)
		other.pl_array[other.i,1]=clamp(pcount,0,999)
		other.pl_array[other.i,2]=clamp(ldistance,0,9999)
		other.pl_array[other.i,3]=id
		other.i++
	}
	w[2]=4
	w[1]=3
	w[0]=1
	for (i=0;i<global.drivers;i++)
	{
		var ranking=i+pl_array[i,2]*10+pl_array[i,1]*power(10,5)+pl_array[i,0]*power(10,8)
		/*
		var ranking="1"
		for (j=0;j<3;j++)
		{
			str=string(floor(pl_array[other.i,j]))
			s_to_w=w[j]-string_length(str)
			repeat s_to_w
			{
				ranking=ranking+"0"
			}
			ranking=ranking+str
		}
		ranking=real(ranking+string(j))
		*/
		pl_array[i,4]=ranking
		ds_list_add(pl_list,ranking)
	}
	ds_list_sort(pl_list,0)
	for (i=0;i<global.drivers;i++)
	{
		pl_array[i,3].place=ds_list_find_index(pl_list,pl_array[i,4])+1
	}
}
else
{
	room_goto(rm_editor)
}
if global.bsrest>0 global.bsrest--