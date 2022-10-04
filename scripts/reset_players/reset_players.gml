//0=is it player?
//1=level(cpu),player(player)
//2=character
if global.players>global.drivers global.drivers=global.players

for (var i=0;i<8;i++)
{
	already[i]=false
}
for (var ch=0;ch<global.players;ch++)
{
	already[global.pdriver[ch]]=true
}
	
for (var i=0;i<global.drivers;i++)
{
	global.driver[i,0]=0
	global.driver[i,1]=i/2+1+(8-global.drivers)
	global.driver[i,2]=irandom(7)
	
	if i>=global.players
	{
		var shit=0
		while recal_choose_ch(i)
		{
			global.driver[i,2]=irandom(7)
			shit++
			if shit>5000
			{
				show_message(global.driver[i,2])
				show_message(already)
			}
		}
		already[global.driver[i,2]]=true
	}
	
	global.place[i+1]=i*-1+(global.drivers-1)
	global.pscore[i]=0
	global.scoreplace[i]=global.place[i+1]
}
for (var pp=0;pp<global.players;pp++)
{
	global.driver[pp,0]=1
	global.driver[pp,1]=pp+1
	global.driver[pp,2]=global.pdriver[pp]
}