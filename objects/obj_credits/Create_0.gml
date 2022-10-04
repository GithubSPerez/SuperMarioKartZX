audio_stop_all()
audio_stop_intro()
audio_play_sound(mus_credits,0,false)
global.revolutions++
progress_save()
bigspace="\n\n\n\n\n\n"
stxt="<original game made by>/<coded by>\nseba perez\n\n<original music tracks by>\nsoyo oka\nyumiko kanki\nnaoto ishida\nhiroshi kawaguchi\npatrick phelan\nluis miguel\n\n<snes style arrangements by>\nseba perez\nparabeetle x\n\n\n<additional design>\nseba perez\njorge perez\n\n\nall original graphics downloaded\nfrom the spriters resource.\n\nthank you for playing!"
btxt="\nnintendo"

stxt=string_replace(stxt,"/",bigspace)
y=room_height+40
ystart=y

//create_fake_player(9)
depth=-10

active=true