// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function object_array_get_locked(array_creator)
{
	if(array_creator == undefined) array_creator = creator
	return array_creator.object_array_locked
}