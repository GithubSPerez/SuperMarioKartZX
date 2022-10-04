if view_current=not_d and hold exit;
if type=8 type=3
spr=spr_banana+type
var tex=sprite_get_texture(spr,img)
x3d_draw_flat(image,tex,x,y,z+4,1,1)