var toroom=rm_cup_select
if global.mode=1
{
	toroom=rm_next_track
}
if global.time_trial
{
	toroom=rm_track_select
}
room_transition(toroom)