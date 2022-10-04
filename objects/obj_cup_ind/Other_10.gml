xx=x+16
yy=y
ddir=0
do
{
	var ins=instance_create_depth(xx,yy,depth,obj_cup_ind)
	if instance_exists(ins)
	{
		ins.dir=ddir
	}
	xx+=lengthdir_x(1,ddir)
	yy+=lengthdir_y(1,ddir)

	ddir=ind_get_dir(ddir,xx,yy)
}
until (xx=x and yy=y)
creator=0