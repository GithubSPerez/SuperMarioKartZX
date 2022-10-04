lpblock=instance_place(x,y,obj_pblock)
fpblock=instance_place(x,y,obj_pblock)
lpblock.type=1
e=obj_editor
dir=e.pblock[lpblock.index,p_direction]
for (var i=0;i<obj_editor.redpoint_number-1;i++)
{
	repeat 1024*2
	{
		x+=lengthdir_x(1,dir)
		y+=lengthdir_y(1,dir)
		var pblock=instance_place(x,y,obj_pblock)
		if pblock!=noone
		{
			if pblock!=lpblock
			{
				if pblock=fpblock
				{
					instance_destroy()
					e.pblock[fpblock.index,p_type]=1
					exit;
				}
				dir=e.pblock[pblock.index,p_direction]
				e.pblock[pblock.index,p_type]=i+2
				x=pblock.x
				y=pblock.y
				lpblock=pblock
				break;
			}
		}
	}
}
instance_destroy()