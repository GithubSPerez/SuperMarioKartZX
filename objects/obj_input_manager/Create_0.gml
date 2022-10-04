key_numb=10
B_set(0,BT.up,vk_up,0,1)
B_set(0,BT.down,vk_down,0,1)
B_set(0,BT.left,vk_left,0,1)
B_set(0,BT.right,vk_right,0,1)

B_set(0,BT.B,ord("X"),0,1)
B_set(0,BT.A,ord("Z"),0,1)
B_set(0,BT.Y,vk_space,0,1)
B_set(0,BT.L,ord("S"),0,1)
B_set(0,BT.R,ord("C"),0,1)

B_set(0,BT.start,vk_enter,0,1)

B_set(1,BT.up,gp_axislv,1,-1)
B_set(1,BT.down,gp_axislv,1,1)
B_set(1,BT.left,gp_axislh,1,-1)
B_set(1,BT.right,gp_axislh,1,1)

B_set(1,BT.B,gp_face1,0,1)
B_set(1,BT.A,gp_face2,0,1)
B_set(1,BT.Y,gp_face3,0,1)
B_set(1,BT.L,gp_shoulderl,0,1)
B_set(1,BT.R,gp_shoulderr,0,1)

B_set(1,BT.start,gp_start,0,1)

input_sets=2

inputs=ds_map_create()
inputs[? "default_keyboard"]=0
inputs[? "default_gamepad"]=1
for (var i=0;i<8;i++)
{
	for (var j=0;j<key_numb;j++)
	{
		keyval[i,j]=0
		reckey[i,j]=0
		lkeyval[i,j]=0
	}
	global.control_type[i]=0
	global.key_right[i]=0
	global.key_right_press[i]=0
	global.key_left[i]=0
	global.key_left_press[i]=0
	global.key_up[i]=0
	global.key_up_press[i]=0
	global.key_down[i]=0
	global.key_down_press[i]=0
	global.key_b[i]=0
	global.key_b_press[i]=0
	global.key_a[i]=0
	global.key_a_press[i]=0
	global.key_y[i]=0
	global.key_y_press[i]=0
	global.key_l[i]=0
	global.key_l_press[i]=0
	global.key_r[i]=0
	global.key_r_press[i]=0
	global.key_start[i]=0
	global.key_start_press[i]=0
}
global.time=0

debug=0
global.debug=false
control_number=0

for (var i=0;i<gamepad_get_device_count();i++)
{
	control[i]=noone
}


#region joycon
/*
bttj[0]=ord("1")
bttj[1]=ord("A")
bttj[2]=ord("J")
for (var j=0;j<3;j++)
{
	for (var i=0;i<9;i++)
	{
		joykey[j,i]=bttj[j]+i
		//show_message(joykey[j,i])
	}
}
joykey[3,0]=ord("S")
joykey[3,1]=ord("T")
joykey[3,2]=ord("U")
joykey[3,3]=ord("V")
joykey[3,4]=ord("W")
joykey[3,5]=ord("X")
joykey[3,6]=ord("Y")
joykey[3,7]=ord("Z")
joykey[3,8]=ord("0")
*/
keyboard_ini()
#endregion
global.T=1

resizing=false
lsw=window_get_width()
lsh=window_get_height()

recording=false
recframe=0
recinput=0
recwritten=false
recpause=false

replay=false
repframe=0
repinput=0

global.init_recording=false
global.init_replay=false

data[0,0]=-1

//code_list=ds_list_create()

dirin[0]=BT.up
dirin[1]=BT.right
dirin[2]=BT.down
dirin[3]=BT.left

dircon[0]=2
dircon[1]=0
dircon[2]=3
dircon[3]=1

load_input()
//show_message(gamepad_get_device_count())