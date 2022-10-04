if state=0
{
	timer++
	if timer>=maxtime
	{
		room_goto(toroom)
		state=1
		timer=maxtime+5
	}
}
else if state=1
{
	timer--
	if timer<=0
	{
		instance_destroy()
	}
}