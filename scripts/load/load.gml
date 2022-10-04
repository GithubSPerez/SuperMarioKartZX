redpoint_number=0
global.xmaxland=128
global.ymaxland=128
var t=argument[0]
var add=0
if argument_count=2
{
	add=1
}
var name="smk_t"+string(t)

var folder=tracks_get_folder()
var file=file_text_open_read(folder+"/"+name)
if file!=-1
{
	var ver=5
	f_ver=file_text_read_real(file)
	file_text_readln(file)
	if ver!=f_ver
	{
		outdated=1
		file_text_close(file)
		exit
	}
	global.track_type=file_text_read_real(file)
	global.xmaxland=128
	global.ymaxland=128
	if global.track_type
	{
		global.big_image=file_text_read_real(file)
		global.xmaxland=256
		global.ymaxland=256
	}
	file_text_readln(file)
	
	global.feather=file_text_read_real(file)
	file_text_readln(file)

	var size=128*(global.track_type+1)
	for (var i=0;i<size;i++)
	{
		for (var j=0;j<size;j++)
		{
			collision[i,j]=file_text_read_real(file)
			if add
			{
				if collision[i,j]=l_wall
				{
					instance_create_depth(i*8,j*8,-1,obj_wall)
				}
			}
		}
		file_text_readln(file)
	}
	pindex=file_text_read_real(file)
	file_text_readln(file)
	for (i=0;i<pindex;i++)
	{
		pblock[i,p_exists]=1
		for (j=1;j<=p_type;j++)
		{
			pblock[i,j]=file_text_read_real(file)
		}
		if !add
		{
			var ins=instance_create_depth(pblock[i,p_x],pblock[i,p_y],-1,obj_pblock)
			ins.index=i
			if pblock[i,p_cpu]
			{
				ins.mode=3
			}
			else
			{
				redpoint_number++
			}
		}
		else
		{
			if !pblock[i,p_cpu]
			{
				var ins=instance_create_depth(pblock[i,p_x],pblock[i,p_y],-1,obj_track_path)
				if pblock[i,p_type]=1
				{
					global.pneed++
				}
			}
			else
			{
				var ins=instance_create_depth(pblock[i,p_x],pblock[i,p_y],-1,obj_track_path_cpu)
			}
			ins.index=i
		}
		file_text_readln(file)
	}
	file_text_readln(file)
	goal_x=file_text_read_real(file)
	goal_y=file_text_read_real(file)
	goal_xscale=file_text_read_real(file)
	goal_yscale=file_text_read_real(file)
	if add
	{
		var g=instance_create_depth(goal_x,goal_y,-1,obj_goal)
		g.image_xscale=goal_xscale
		g.image_yscale=goal_yscale
	}
	file_text_readln(file)
	obj_count=file_text_read_real(file)
	obj_ind=obj_count
	file_text_readln(file)
	for (i=0;i<obj_ind;i++)
	{
		obj[i,0]=1
		for (j=0;j<obj_vals-1;j++)
		{
			if j!=2
			obj[i,j+1]=file_text_read_real(file)
			else
			{
				var text=string_delete(file_text_read_string(file),1,1)
				//show_message(","+text+","+string(asset_get_index(text)))
				obj[i,j+1]=asset_get_index(text)
				file_text_readln(file)
			}
		}
		if add
		{
			var ins=instance_create_depth(obj[i,1],obj[i,2],-1,obj[i,3])
			ins.e_index=i
		}
		else
		{
			var prev=instance_create_depth(obj[i,1],obj[i,2],-1,obj_preview)
			prev.index=i
		}
		file_text_readln(file)
	}
	global.bg_img=file_text_read_real(file)
	global.bg_front_img=file_text_read_real(file)
	global.bg_fill_img=file_text_read_real(file)
	global.out_fill=file_text_read_real(file)
	var R=real(file_text_read_real(file))
	var G=real(file_text_read_real(file))
	var B=real(file_text_read_real(file))
	global.bg_col=make_color_rgb(R,G,B)
	global.bg_type=file_text_read_real(file)
	global.song=file_text_read_real(file)
	file_text_close(file)
}