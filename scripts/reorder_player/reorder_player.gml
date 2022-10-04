var l=ds_list_create()
for (var i=0;i<global.drivers;i++)
{
	ds_list_add(l,global.pscore[i]+i/10)
}

ds_list_sort(l,0)
for (var i=0;i<global.drivers;i++)
{
	var val=ds_list_find_value(l,i)
	global.scoreplace[i]=round((val-floor(val))*10)
	//show_message(string(val-floor(val))+","+string(global.scoreplace[i])+","+string((val-floor(val))*10))
}