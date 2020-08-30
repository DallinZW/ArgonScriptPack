/// @function ds_list_delete_value(_list, _value)
/// @desc Finds and deletes the given value from a list
/// @arg {real} _list
/// @arg {*} _value
function ds_list_delete_value(argument0, argument1) {

	var _index = ds_list_find_index(argument0, argument1);
	ds_list_delete(argument0, _index);


}
