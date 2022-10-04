global.pneed=0
global.laps=5
global.bsrest=0
global.bg_img=0
global.bg_fill_img=0
global.bg_col=c_white
global.out_fill=7
load(global.track,1)
size=global.xmaxland
layer_background_blend(layer_background_get_id(layer_get_id("Color")),global.bg_col)
pl_array[0,0]=0
pl_list=ds_list_create()
var ts=global.track_type+1
track=x3d_create_vplane(1024*ts,1024*ts)
global.plain_track=surface_create(1024*ts,1024*ts)
layer_set_visible(layer_get_id("Track"),0)

drew=false