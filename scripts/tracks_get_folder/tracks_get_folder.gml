var folder="files"
var fullfol=folder+"/smk_tracks"
var z=working_directory+"smk_tracks.zip"
//show_message(z)
if !directory_exists(fullfol) or file_exists(z)
{
	if file_exists(z)
	{
		zip_unzip(z,folder)
		file_delete(z)
	}
	else
	{
		//get_open_filename_ext("","",z,"sas")
		show_message("game files corrupted or non existent")
		game_end()
		//directory_create(folder)
	}
}
return(fullfol)