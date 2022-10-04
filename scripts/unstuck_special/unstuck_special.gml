var xx=x/8
var yy=y/8
//do
{
    jpos[0]=0
    jpos[1]=0
    jpos[2]=0
    jpos[3]=0
    var i=0
	var range=0
    while get_land_onstage(xx-range+jpos[0],yy) {jpos[0]++ if jpos[0]>128 break}// if jpos[0]>256}
    while get_land_onstage(xx,yy+range-jpos[1]) {jpos[1]++ if jpos[1]>128 break}
    while get_land_onstage(xx+range-jpos[2],yy) {jpos[2]++ if jpos[2]>128 break}
    while get_land_onstage(xx,yy-range+jpos[3]) {jpos[3]++ if jpos[3]>128 break}
    
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
    x+=lengthdir_x(minim*8,ji*90)
    y+=lengthdir_y(minim*8,ji*90)
	xx=x/8
	yy=y/8
}
//until get_land_onstage(xx,yy)!=9 and get_land_onstage(xx,yy)!=6 and get_land_onstage(xx,yy)!=5