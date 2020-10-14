//saving and loading stolen from Lazyeye's Data Scripts
//json_load, json_save, json_secure_load, json_secure_save

/// @function json_load(_filename)
/// @desc Loads the JSON file and returns its data in a map
/// @arg {string} _filename
function json_load(argument0) {

	var _map = ds_map_create();
	var _buff = buffer_load(argument0);
	_map = json_decode(buffer_read(_buff, buffer_text));
	buffer_delete(_buff);
	return _map;
}

/// @function json_save()
/// @desc Saves the given map to a file in JSON format with the given filename.
/// @param {real} _map
/// @param {string} _filename
function json_save(argument0, argument1) {

	var _str = json_encode(argument0);
	var _buff = buffer_create(string_byte_length(_str), buffer_fixed, 1);
	buffer_write(_buff, buffer_text, _str);
	buffer_save(_buff, argument1);
	buffer_delete(_buff);
}

/// @function json_secure_load(_file, _crypt_key)
/// @desc Loads the encrypted JSON file and returns its data in a map
/// NOTE! This function will only work with the script 'json_secure_save' by lazyeye!
/// @arg {string} _file
/// @arg {real} _crypt_key
function json_secure_load(argument0, argument1) {

	// Set seed
	var _seed = random_get_seed();
	random_set_seed(argument1);

	// Decoding
	var _map = ds_map_create();
	var _buff = buffer_load(argument0);
	buffer_seek(_buff, buffer_seek_start, 0);
	var _new_buff = buffer_create(buffer_get_size(_buff) + 3, buffer_fixed, 1);
	repeat (buffer_get_size(_buff) / 4)
	{
	    var _bytes = buffer_read(_buff, buffer_u32);
	    var _bytes = _bytes ^ irandom(0xffffffff);
	    buffer_write(_new_buff, buffer_u32, _bytes);
	}

	// Cleanup / return map
	buffer_seek(_new_buff, buffer_seek_start, 0);
	var _map = json_decode(buffer_read(_new_buff, buffer_text));
	buffer_delete(_buff);
	buffer_delete(_new_buff);
	random_set_seed(_seed);
	return _map;


}

/// json_secure_save(_map, _filename, _crypt_key)
/// @description Saves the given ds_map to a file in an encoded JSON format
/// with the given filename and encryption key.
/// @arg {real} _map
/// @arg {string} _filename
/// @arg {real} _crypt_key
function json_secure_save(argument0, argument1, argument2) {

	// Recrod / set seed
	var _seed = random_get_seed();
	random_set_seed(argument2);

	// Encode data
	var _str = json_encode(argument0);
	var _buff = buffer_create(string_byte_length(_str), buffer_fixed, 1);

	// Create buffers
	buffer_write(_buff, buffer_text, _str);
	buffer_seek(_buff, buffer_seek_start, 0);
	buffer_resize(_buff, buffer_get_size(_buff) + 3);
	var _new_buff = buffer_create(buffer_get_size(_buff), buffer_fixed, 1);

	// Encode buffer
	repeat (buffer_get_size(_buff) / 4)
	{
	    var _bytes = buffer_read(_buff, buffer_u32);
	    var _bytes = _bytes ^ irandom(0xffffffff);
	    buffer_write(_new_buff, buffer_u32, _bytes);
	}

	// Save and cleanup
	buffer_save(_new_buff, argument1);
	buffer_delete(_buff);
	buffer_delete(_new_buff);
	random_set_seed(_seed);


}
