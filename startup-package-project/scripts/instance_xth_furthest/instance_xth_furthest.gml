/// @description instance_xth_furthest(x,y,obj,n,variable,value)
/// @param x
/// @param y
/// @param obj
/// @param n
/// @param variable
/// @param value
/// @param operator
function instance_xth_furthest(argument0, argument1, argument2, argument3, argument4, argument5, argument6) {
	//gives you the nth furthest instance of type obj with variable = value to point x,y
	//Original by Andy Johnson
	//Modified by Rob van Saaze

	var _temp_,_array_;
	_array_ = ds_priority_create() //makes an array

	with(argument2)
	{
	    if variable_instance_exists(self,argument4) or is_real(argument4)
	        if evaluate(argument4,argument5,argument6)
	            ds_priority_add(_array_,id,point_distance(x,y,argument0,argument1))
	}
	//^ adds the instance to the list, sorting the list by distance ^
	repeat(max(argument3,1)-1)
	{ds_priority_delete_max(_array_)} //deletes the closest ones until n is reached
	if ds_priority_empty(_array_) return -1
	_temp_ = ds_priority_find_max(_array_)
	ds_priority_destroy(_array_)

	if instance_exists(_temp_)
	return _temp_ //returns the id of the nth-closest instance with var = val
	else return -1


}