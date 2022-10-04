grav=0.3
vsp=0
headhit=false
draw=false
image_index=obj_finish.place+(clamp(real(cc_get_string())/50-1,0,2))*3

audio_play_new(snd_throw)

hit=0