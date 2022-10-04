options[4,0]="single player"
options[4,1]="multi player"

options[1,0]="grand prix"
options[1,1]="vs match"
options[1,2]="time trial"

options[2,0]="grand prix"
options[2,1]="vs match"

options[3,0]="50ç__class"
options[3,1]="100ç_class"
options[3,2]="150ç_class"

options[0,0]="start game"
options[0,1]="options"
options[0,2]="quit"

options[5,0]="screen_size"
options[5,1]="pixelated_look"
options[5,2]="edit_controls"

options[6,0]="gamepad"
options[6,1]="keyboard multiplayer "
options[6,2]="key binds"

ccswitch=false

goto[4,0]=1
goto[4,1]=2
gotfrom[0]=noone

goto[1,0]=-1
goto[1,1]=-1
goto[1,2]=-1

goto[2,0]=-1
goto[2,1]=-1

goto[3,0]=-1
goto[3,1]=-1
goto[3,2]=-1

goto[0,0]=4
goto[0,1]=5
goto[0,2]=-1

goto[5,0]=-1
goto[5,1]=-1
goto[5,2]=6

goto[6,0]=-1
goto[6,1]=-1
goto[6,2]=-1

color[0]=merge_color(c_blue,c_aqua,0.5)
color[1]=c_fuchsia
color[2]=merge_color(c_lime,c_green,0.4)

state=0
opt=0
lopt[0]=0
pause=0
toroom=noone
transition=0

box_w=0
box_h=0
box_to_w=box_w
box_to_h=box_h
box_x=room_width/2
box_y=room_height/3*2
box_xspd=0
box_yspd=0
anti_spd=16

global.drivers=8

reset_box_size()

if !shader_is_compiled(sh_stroke_col)
{
	show_message("fuck")
}