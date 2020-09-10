// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function cam_update_position(x_position, y_position){
	x += (x_position - x) / speedfactor
	y += (y_position - y) / speedfactor
	CamSetPos(do_clamp)
}