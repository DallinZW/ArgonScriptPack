// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function cam_update_object(object, x_offset, y_offset)
{
	x_test = 0;
	y_test = 0;
	var count = instance_number(object)
	
	with(object)
	{
		other.x_test += x
		other.y_test += y
	}
	
	x_test /= count
	y_test /= count
	
	cam_update_position(x_test + x_offset, y_test + y_offset)
}