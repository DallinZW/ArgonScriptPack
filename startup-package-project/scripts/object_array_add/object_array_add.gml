// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
///@arg x
///@arg y
///@arg depth
///@arg object
///@arg stick
function object_array_add()
{
	var inst = instance_create_depth(argument[0], argument[1], argument[2], argument[3]) 
	var w = array_length(object_array)
	
	if(w == 1 && object_array[0] == -1)
	{
		w = 0
	}
	
	object_array[w] = inst
	
	//x_offset and y_offset: used for custom methods
	inst.x_offset = 0
	inst.y_offset = 0
	
	//object_array_xoff and object_array_yoff: used for sticking to creator
	inst.object_array_xoff = inst.x - x
	inst.object_array_yoff = inst.y - y
	inst.active = false
	inst.creator = id
	return inst
}