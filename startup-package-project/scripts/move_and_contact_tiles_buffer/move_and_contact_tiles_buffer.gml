// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function move_and_contact_tiles_buffer(	
tile_map_id, tile_size, velocity, 
up_left_buffer, up_right_buffer, left_top_buffer, left_bottom_buffer, 
right_top_buffer, right_bottom_buffer, bottom_left_buffer, bottom_right_buffer)
{
	move_and_contact_tiles_buffer_gradual(tile_map_id, tile_size, velocity, 1,
	up_left_buffer, up_right_buffer, left_top_buffer, left_bottom_buffer, 
	right_top_buffer, right_bottom_buffer, bottom_left_buffer, bottom_right_buffer)
}