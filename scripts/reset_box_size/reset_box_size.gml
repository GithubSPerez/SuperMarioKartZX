var maxchar=1
var olen=array_length_2d(options,state)
for (var l=0;l<olen;l++)
{
	if string_length(options[state,l])>maxchar
	{
		maxchar=string_length(options[state,l])
	}
}
box_to_w=(maxchar+2)*8/12
box_to_h=(olen+0.1)*12/12
box_xspd=box_w/anti_spd
box_yspd=box_h/anti_spd
if box_w=0 and box_h=0
{
	box_xspd=box_to_w/anti_spd
	box_yspd=box_to_h/anti_spd
}
box_w*=-1
box_h*=-1
transition=2