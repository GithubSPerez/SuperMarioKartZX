while place_meeting(x,y,obj_wall)
{
    jpos[0]=0
    jpos[1]=0
    jpos[2]=0
    jpos[3]=0
    var i=0
    while place_meeting(x+jpos[0],y,obj_wall) jpos[0]++
    while place_meeting(x,y-jpos[1],obj_wall) jpos[1]++
    while place_meeting(x-jpos[2],y,obj_wall) jpos[2]++
    while place_meeting(x,y+jpos[3],obj_wall) jpos[3]++
    
    var minim=jpos[0]
    var ji=0
    i=0
    repeat 4
    {
        if jpos[i]<minim 
        {
            minim=jpos[i]
            ji=i
        }
        i++
    }
    x+=lengthdir_x(minim,ji*90)
    y+=lengthdir_y(minim,ji*90)
}
