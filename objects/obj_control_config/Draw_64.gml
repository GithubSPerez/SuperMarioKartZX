if !instance_exists(config)
{
	for(var i=0;i<total_c;i++)
	{
		var txt="_"+gamepad_get_description(i)
		if i=device
		{
			txt=string_replace(txt,"_",">")
		}
		draw_text_transformed(0,9*i,string_lower(txt),1,1,0)
	}
}