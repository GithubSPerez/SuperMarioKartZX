//First, create the camera. We could use camera_create_view, but that is more useful in a 2D environment
var view=argument0
var camera = view_camera[view];
var xsize=-view_get_wport(view)
var ysize=(view_get_hport(view)*global.divscreen)

//Then, we need to build a projection matrix. I keep this in instance scope in case I need to reassign it later. (Though you can retrieve matrices from a camera with camera_get functions
//I use matrix_build_projection_perspective_fov, as it gives the most control over how your projections looks.
//Here's how I use the arguments: I give a 60 degree vertical field of view, with a ratio of view_wport/view_hport, with a 32 unit near clipping plane, and a 32000 far clipping plane. Some of these values may need tweaking to your liking.
var projMat = matrix_build_projection_perspective_fov(60, xsize/ysize, 1, 32000);

//Now we assign the projection matrix to the camera
camera_set_proj_mat(camera, projMat);

//Finally, we bind the camera to the view
//view_set_camera(view, camera);

//Assigns the update script named "camera_update_script" to the camera belonging to view0
//camera_set_update_script(view_camera[view], argument1);