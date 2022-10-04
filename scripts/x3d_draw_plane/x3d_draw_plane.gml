///@func x3d_draw_plane()
///@param plane "
///@param texture "
///@param x "
///@param y "
///@param z "
///@param xrot "
///@param yrot "
///@param zrot "
///@param xscale "
///@param yscale "
///@param zscale "
///@param *adjusted "

var plane=argument[0]
var tex=argument[1]

var xx=argument[2]
var yy=argument[3]
var zz=argument[4]
var xxr=argument[5]
var yyr=argument[6]
var zzr=argument[7]
var xs=1
var ys=1
var zs=1
var ad=false
if argument_count>8
{
	var xs=argument[8]
	var ys=argument[9]
	var zs=argument[10]
}
if argument_count>11
{
	ad=argument[11]
}
xs/=1*!ad+global.divscreen*ad;
ys/=1*!ad+global.divscreen*ad;

var mat = matrix_build(xx,yy, zz, xxr, yyr, zzr, xs,ys,zs)
//The world matrix is what is used to transform drawing within "world" or "object" space.

matrix_set(matrix_world, mat);

//Draw the buffer
//if object_get_parent(object_index)!=obj_sprite and object_index!=obj_palm1
vertex_submit(plane, pr_trianglelist, tex);

//Resetting transforms can be done like this:
matrix_set(matrix_world, matrix_build_identity());