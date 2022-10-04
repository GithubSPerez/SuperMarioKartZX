///@func array_3d_create(xsize,ysize,zsize,value)
///@param xsize desc
///@param ysize desc
///@param zsize desc
///@param value desc
var mid=ds_map_create()
var xs=argument0
var ys=argument1
var zs=argument2
var val=argument3
for (xi=0;xi<xs;xi++)
{
	for (yi=0;yi<ys;yi++)
	{
		for (zi=0;zi<zs;zi++)
		{
			ds_map_add(mid,string(xi)+","+string(yi)+","+string(zi),val)
		}
	}
}
return(mid)