var col=argument0

var red=color_get_red(col)/255
var green=color_get_green(col)/255
var blue=color_get_blue(col)/255

shader_set(sh_stroke_col)
var u_red=shader_get_uniform(sh_stroke_col,"Red")
var u_green=shader_get_uniform(sh_stroke_col,"Green")
var u_blue=shader_get_uniform(sh_stroke_col,"Blue")

shader_set_uniform_f(u_red,red)
shader_set_uniform_f(u_green,green)
shader_set_uniform_f(u_blue,blue)