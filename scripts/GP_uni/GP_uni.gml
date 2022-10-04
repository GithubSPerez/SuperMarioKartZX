///@func GP_uni
///@param device
///@param input
///@param BT

var d=argument0
var bid=B_id(argument1,argument2)
var type=B_type(argument1,argument2)
var val=B_val(argument1,argument2)

var ret=gamepad_button_check(d,bid)
if type=1
{
	var ax=gamepad_axis_value(d,bid)
	ret=((sign(val)=sign(ax)) and abs(ax)>0.1)
}
else if type=2
{
	var hat=gamepad_hat_value(d,bid)
	/*
	if hat!=0
	{
		show_message(hat)
	}
	*/
	ret=(hat=val)
}
return(ret)