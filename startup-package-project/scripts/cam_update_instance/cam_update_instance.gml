// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function cam_update_instance(instance, x_offset, y_offset)
{
	cam_update_position(instance.x + x_offset, instance.y + y_offset)
}