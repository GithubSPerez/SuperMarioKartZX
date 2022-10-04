var f=file_text_open_write("info")
file_text_write_real(f,global.track)
file_text_write_real(f,editmode)
file_text_close(f)