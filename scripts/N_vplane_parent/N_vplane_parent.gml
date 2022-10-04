var xsize = (argument0/2)
var zsize = argument1/2;

//Begin defining a format
vertex_format_begin();

vertex_format_add_position_3d();//Add 3D position info
vertex_format_add_color();//Add color info
vertex_format_add_texcoord();//Texture coordinate info

//End building the format, and assign the format to the variable "format"
var format = vertex_format_end();

//Create the vertex buffer. Another function, vetex_create_buffer_ext can be used to create the buffer with its size predefined and fixed.
//With the standard vertex_create_buffer, the buffer will just grow automatically as needed.
var vb_plane = vertex_create_buffer();

//Begin building the buffer using the format defined previously
vertex_begin(vb_plane, format);

//Add the six vertices needed to draw a simple square plane.

//The first triangle
vertex_position_3d(vb_plane, -xsize, 0, -zsize);
vertex_color(vb_plane, c_white, 1);
vertex_texcoord(vb_plane, 0, 0);

vertex_position_3d(vb_plane, xsize, 0, -zsize);
vertex_color(vb_plane, c_white, 1);
vertex_texcoord(vb_plane, 1, 0);

vertex_position_3d(vb_plane, -xsize, 0, zsize);
vertex_color(vb_plane, c_white, 1);
vertex_texcoord(vb_plane, 0, 1);


//The second triangle. The winding order has been maintained so drawing is consistent if culling is enabled.
vertex_position_3d(vb_plane, -xsize, 0, zsize);
vertex_color(vb_plane, c_white, 1);
vertex_texcoord(vb_plane, 0, 1);

vertex_position_3d(vb_plane, xsize, 0, -zsize);
vertex_color(vb_plane, c_white, 1);
vertex_texcoord(vb_plane, 1, 0);

vertex_position_3d(vb_plane, xsize, 0, zsize);
vertex_color(vb_plane, c_white, 1);
vertex_texcoord(vb_plane, 1, 1);


//Finish building the buffer.
vertex_end(vb_plane);

return(vb_plane)