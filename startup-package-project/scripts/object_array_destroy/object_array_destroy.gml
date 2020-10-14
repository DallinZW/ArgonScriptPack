// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function object_array_destroy()
{
	for(var i = 0; i < array_length(object_array); i++)
	{
		instance_destroy(object_array[i])
	}
}