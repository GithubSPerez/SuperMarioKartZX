if start=0 exit
if start=1
{
	gname=gamepad_get_description(device)
	display_name=string_lower(gname)
	if !ds_map_exists(In.inputs,gname)
	{
		input=In.input_sets
		In.input_sets++
		In.inputs[? gname]=input
	}
	else
	{
		input=In.inputs[? gname]
	}
	start=2
}
if key_check(vk_escape,1)
{
	with In
	{
		load_input()
	}
	alarm[0]=10
	start=0
	exit
}
var dev=device
var inp=input
var quit=false
if pressed>0
{
	pressed=1
}
if pressed<0
{
	pressed=0
}
for (var type=0;type<3;type++)
{
	var numb=gamepad_button_count(dev)
	if type=1
	{
		numb=gamepad_axis_count(dev)
	}
	if type=2
	{
		numb=gamepad_hat_count(dev)
	}
	for (var i=0;i<numb;i++)
	{
		var val=round(gamepad_button_check(dev,i))
		if type=1
		{
			val=gamepad_axis_value(dev,i)
			val=round(val+0.2*sign(val))
		}
		if type=2
		{
			val=round(gamepad_hat_value(dev,i))
		}
		if val!=0
		{
			if pressed<=0
			{
				rep=false
				for (var j=0;j<toset;j++)
				{
					if B_type(inp,j)=type and B_id(inp,j)=i and B_val(inp,j)=val
					{
						rep=true
					}
				}
				if !rep
				{
					B_set(inp,toset,i,type,val)
					ds_list_add(show_list,string(i)+","+string(type)+","+string(val))
					quit=true
					toset++
					pressed=1
					break
				}
			}
		}
		else if pressed>0
		{
			pressed-=((1/3)/numb)
		}
	}
	if numb=0 pressed-=1/3
	if quit
	{
		break
	}
}
if toset>BT.start
{
	start=0
	with In
	{
		save_input()
	}
	obj_control_config.deactive=45
	instance_destroy()
}