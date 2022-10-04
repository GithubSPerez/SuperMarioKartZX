if global.cc=0.75
{
	return("50")
}
return(string((global.cc+(global.cc-1))*100))
if global.cc=1
{
	return("100")
}
if global.cc=1.25
{
	return("150")
}
if global.cc=1.5
{
	return("200")
}