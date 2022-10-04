if file_exists("info")
{
	var f=file_text_open_read("info")
	global.track=file_text_read_real(f)
	editmode=file_text_read_real(f)
	file_text_close(f)
}