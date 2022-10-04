///@func x3d_get_point()
///@param cam_id "
///@param x "
///@param y "
///@param z "
///@param IsItX? "
var isitx=argument4

var In=argument0
var Ax=argument1
var Ay=argument2
var Az=argument3

var Cx=global.cam_x[In]
var Cy=global.cam_z[In]
var Cz=global.cam_y[In]

var Ox=global.cam_xdir[In]
var Oy=global.cam_zdir[In]-90
var Oz=0

var sep=1

var Ex=0
var Ey=0
var Ez=-1

var cOx=cos(degtorad(Ox))
var cOy=cos(degtorad(Oy))
var cOz=cos(degtorad(Oz))

var sOx=sin(degtorad(Ox))
var sOy=sin(degtorad(Oy))
var sOz=sin(degtorad(Oz))

var X=Ax-Cx
var Y=Ay-Cy
var Z=Az-Cz

var Dx=cOy*(sOz*Y+cOz*X)-sOy*Z
var Dy=sOx*(cOy*Z+sOy*(sOz*Y+cOz*X))+cOx*(cOz*Y-sOz*X)
var Dz=cOx*(cOy*Z+sOy*(sOz*Y+cOz*X))-sOx*(cOz*Y-sOz*X)

var Bx=(Ez/Dz)*Dx+Ex
var By=(Ez/Dz)*Dy+Ey

if isitx
return(Bx)
else
return(By)