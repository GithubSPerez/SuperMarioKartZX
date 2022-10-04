ind_jx=48
tnames=0
state=0
txtcol[0]=merge_color(c_aqua,c_blue,0.5)
txtcol[1]=c_lime
txtcol[2]=c_orange
txtcol[3]=c_red

for (var i=0;i<global.drivers;i++)
{
	pscdraw[i]=global.pscore[i]
}
audio_stop_all()
audio_stop_intro()
music=mus_rank_mario+global.win_char
audio_play_intro(music,global.rank_music[global.win_char,0],global.rank_music[global.win_char,1])

global.played_matches++
time=0