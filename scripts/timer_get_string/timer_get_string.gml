///@param timer
var time=argument0
if time=noone
{
	return("no record")
}
var second=time/60
var showmin=floor(second/60)
if showmin<10
{
	showmin="0"+string(showmin)
}
var showsec=floor(second)%60
if showsec<10
{
	showsec="0"+string(showsec)
}
var showmsec=floor(((second)-floor(second))*100%100)

if showmsec<10
{
	showmsec="0"+string(showmsec)
}
return(string(showmin)+"'"+string(showsec)+"\""+string(showmsec))