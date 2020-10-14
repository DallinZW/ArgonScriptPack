//ds_map convenience functions from Lazyey's Data Scripts
//ds_map_add_multiple, ds_map_find_key, ds_map_flip, ds_map_write_multiple

/// @function ds_map_add_multiple(_id, _key, _value, ...)
/// @desc Adds multiple keys and values to the given map
/// @arg {string} _key
/// @arg {*} _value
/// @arg ...
function ds_map_add_multiple() {

	var _map = argument[0];
	for (var i = 1; i < argument_count; ++i;)
	{
		var _key = argument[i];
		var _value = argument[++i];
		ds_map_add(_map, _key, _value);
	}
}

/// @function ds_map_find_key(_map, _value)
/// @desc Returns the first key that holds the given value in a map
/// @arg {real} _map
/// @arg {*} _value
function ds_map_find_key(argument0, argument1) {

	var _key = ds_map_find_first(argument0);
	while (not is_undefined(_key))
	{
		if (argument0[? _key] == argument1)
		{
			return _key
		}
		_key = ds_map_find_next(argument0, _key);
	}
}

/// @function ds_map_flip(_map)
/// @desc Returns a map with the keys and values swapped from the given map
/// @arg {real} _map
function ds_map_flip(argument0) {

	var _new_map = ds_map_create();
	var _key = ds_map_find_first(argument0);
	while (not is_undefined(_key))
	{
		ds_map_add(_new_map, argument0[? _key], _key);
		_key = ds_map_find_next(argument0, _key);
	}

	return _new_map
}

/// @function ds_map_write_multiple(_id, _key, _value, ...)
/// @desc Updates multiple values in the given map
/// @arg {real} _map_index
/// @arg {string} _key
/// @arg {*} _value
/// @arg ...
function ds_map_write_multiple() {

	var _map = argument[0];
	for (var i = 1; i < argument_count; i++;)
	{
		var _key = argument[i];
		var _value = argument[++i];
		if (not ds_map_exists(_map, _key)) show_error("Error in ds_map_write_multiple: key not found!", false);
		_map[? _key] = _value;
	}
}
