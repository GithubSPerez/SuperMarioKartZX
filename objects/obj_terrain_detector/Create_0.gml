for (var i=0;i<200;i++)
{
	cube[i]=0
}
for (var j=0;j<global.xmaxland;j++)
{
	for (var i=0;i<global.ymaxland;i++)
	{
		tile[j,i]=0
		correct_land[j,i]=0
	}
}
for (var j=0;j<200;j++)
{
	for (var i=0;i<64;i++)
	{
		patch[j,i]=0
	}
}
progress=0
patch_number=0
/*
for (var j=0;j<8;j++)
{
	for (var i=0;i<8;i++)
	{
		tempcube[j,i]=0
	}
}
*/
sur=surface_create(global.xmaxland*8,global.ymaxland*8)
xx=0
yy=0
start=0
index=0
dtile=0

size=global.xmaxland