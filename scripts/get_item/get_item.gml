///@func get_item()
///@param place "
///@param rank "
var p=argument0
var r=argument1
var mr=place_get_instance(p-1).rank
var ind=0
var dr=abs(mr-r)*4
var pr=p+dr

if pr>0 and pr<=4
{
	ind=1
}
if pr>4 and pr<=7
{
	ind=2
}
if pr>7
{
	ind=3
}
if place_get_instance(1).lap<=1
{
	ind=0
}

if p=1 ind=0
var k=0
for (var i=0;i<items;i++)
{
	if global.feather or i+1!=itm.feather
	{
		for (var j=0;j<global.prob[ind,i+1];j++)
		{
			pr[k]=i+1
			k++
		}
	}
}
var it=pr[random_range(0,k-1)]
/*
if p!=1
{
	if p=2
	{
		if abs(pr)>0.2
		{
			it=3
		}
	}
	if abs(rank-place_get_instance(1).rank)>0.5
	{
		//it=9
	}
}
*/
if global.bsrest>0
{
	while it=9 it=pr[random_range(0,k-1)]
}
if it=9 global.bsrest=20*60
return(it)