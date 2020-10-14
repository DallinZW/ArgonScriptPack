//DS_list convenience methods from Lazyeye's Data Scripts
//ds_list_add_list, ds_list_add_map, ds_list_create_from_keys, ds_list_create_from_map, ds_list_delete_value, ds_list_pop_bot, ds_list_pop_top, ds_list_swap_values

/// @function ds_list_add_list(_list, _list)
/// @desc Adds a list to a list (for the purpose of JSON encoding)
/// @arg {real} _target_list
/// @arg {real} _source_list
function ds_list_add_list(argument0, argument1) {

	ds_list_add(argument0, argument1);
	var _index = ds_list_find_index(argument0, argument1);
	ds_list_mark_as_list(argument0, _index);


}

/// @function ds_list_add_map(_list, _map)
/// @desc Adds a map to a list (for the purpose of JSON encoding)
/// @arg {real} _list
/// @arg {real} _map
function ds_list_add_map(argument0, argument1) {

	ds_list_add(argument0, argument1);
	var _index = ds_list_find_index(argument0, argument1);
	ds_list_mark_as_map(argument0, _index);


}

/// @function ds_list_create_from_keys(_map)
/// @desc Creates a list out of the given map's keys
/// @arg {real} _map
function ds_list_create_from_keys(argument0) {

	// Indices 
	var _list = ds_list_create();
	var _map = argument0;

	// DS testing (hardly a guarentee due to lack of true data types, but a basic check)
	if (not ds_exists(_map, ds_type_map))
	{
		show_error("Error in ds_list_add_map_values: " + string(_map) + " does not point to a valid map.", false);
		exit;
	}

	// Loop through map
	var _key = ds_map_find_first(_map);
	while (not is_undefined(_key))
	{
		ds_list_add(_list, _key);
		_key = ds_map_find_next(_map, _key);
	}

	// Return the new list
	return _list;


}

/// @function ds_list_create_from_map(_map)
/// @desc Creates a list out of the given map's values
/// @arg {real} _map
function ds_list_create_from_map(argument0) {

	// Indexes 
	var _list_index = ds_list_create();
	var _map_index = argument0;

	// DS testing (hardly a guarentee due to lack of true data types, but a basic check)
	if (not ds_exists(_map_index, ds_type_map))
	{
		show_error("Error in ds_list_add_map_values: " + string(_map_index) + " does not point to a valid map.", false);
		exit;
	}

	// Loop through map
	var _key = ds_map_find_first(_map_index);
	while (not is_undefined(_key))
	{
		var _value = _map_index[? _key];
	
		// DS testing
		if (ds_exists(_value, ds_type_list))
		{
			ds_list_add(_list_index, _value);
		}
		else if (ds_exists(_value, ds_type_map))
		{
			ds_list_add(_list_index, _value);
		}
		else
		{
			ds_list_add(_list_index, _value);
		}
		_key = ds_map_find_next(_map_index, _key);
	}

	// Return the new list
	return _list_index;


}

/// @function ds_list_delete_value(_list, _value)
/// @desc Finds and deletes the given value from a list
/// @arg {real} _list
/// @arg {*} _value
function ds_list_delete_value(argument0, argument1) {

	var _index = ds_list_find_index(argument0, argument1);
	ds_list_delete(argument0, _index);


}

/// @function ds_list_pop_bot(_list)
/// @desc Returns and removes the top value (0 index) from a list
/// Yes, pop_back would be more proper, but pop_bot also sounds hilarious
/// @arg {real} _list
function ds_list_pop_bot(argument0) {

	var _val = argument0[| ds_list_size(argument0) - 1];
	ds_list_delete(argument0, ds_list_size(argument0) - 1);
	return _val


}

/// @function ds_list_pop_top(_list)
/// @desc Returns and removes the top value (0 index) from a list
/// Yes, pop_front would be more proper, but pop_top sounds hilarious
/// @arg {real} _list
function ds_list_pop_top(argument0) {

	var _val = argument0[| 0];
	ds_list_delete(argument0, 0);
	return _val


}

/// @function ds_list_swap_values(_list, _index_one, _index_two)
/// @desc Takes the given two indices and swaps their values in a list
/// @arg {real} _list
/// @arg {real} _index_one
/// @arg {real} _index_two
function ds_list_swap_values(argument0, argument1, argument2) {

	var _list = argument0;
	var _index_one = argument1;
	var _index_two = argument2;
	var _val_one = _list[| _index_one];
	var _val_two = _list[| _index_two];
	_list[| _index_one] = _val_two;
	_list[| _index_two] = _val_one;


}
