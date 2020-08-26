///@param tile_map_id
///@param tile_size
///@param velocity_array
function move_and_contact_tiles(argument0, argument1, argument2) {
	var tile_map_id = argument0;
	var tile_size = argument1;
	var velocity = argument2;

	move_and_contact_tiles_buffer(tile_map_id, tile_size, velocity, 0, 0, 0, 0, 0, 0, 0, 0)
}