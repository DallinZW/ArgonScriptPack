// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function move_and_contact_tiles_buffer_gradual(	
tile_map_id, tile_size, velocity, gradual_change_modifier, 
up_left_buffer, up_right_buffer, left_top_buffer, left_bottom_buffer, 
right_top_buffer, right_bottom_buffer, bottom_left_buffer, bottom_right_buffer)
{
	if(gradual_change_modifier <= 0) || (gradual_change_modifier > 1)
	{
		gradual_change_modifier = 0
	}
	//initialize the collision offset variables 
	if(!variable_instance_exists(self, "collision_x_offset"))
	{
		collision_x_offset = 0
		collision_y_offset = 0
	}
	
	//also just reset them if they're small enough (avoid dumb floating point things)
	if(abs(collision_x_offset) <= 0.5) collision_x_offset = 0
	if(abs(collision_y_offset) <= 0.5) collision_y_offset = 0
	
	//buffer values are in pixels, not percentages
	
	// For the velocity array
	var vector2_x = 0;
	var vector2_y = 1;

	// Move horizontally
	x += velocity[vector2_x];

	//make custom bbox values
	var bbox_l, bbox_r, bbox_t, bbox_b, count, collide, collide_min, collide_max, collide_temp;


	//get bounding boxes as distances from x and y
	bbox_l = floor(round(x) - bbox_left + x)
	bbox_r = ceil(bbox_right - round(x) + x)
	bbox_t = floor(round(y) - bbox_top + y)
	bbox_b = ceil(bbox_bottom - round(y) + y)

	count = max(ceil((bbox_b - bbox_t) / tile_size) + 1, 2)
	collide = false
	collide_min = false
	collide_max = false
	collide_temp = false
	
	// Right collisions
	if (velocity[vector2_x] > 0) 
	{
		//we're moving right
		//for sideways, check without buffer first 
		collide = tile_collide_at_side(tile_map_id, tile_size, SIDE.RIGHT, 0, 0, 0)
		
		//if we're not clear
		if (collide) 
		{
			collide_min = tile_collide_at_points(tile_map_id, [bbox_r, bbox_t]);
			collide_max = tile_collide_at_points(tile_map_id, [bbox_r, bbox_b]);
			
			//if one side got hit and one didn't
			if(collide_min != collide_max)
			{
				//check for collision buffers
				collide = tile_collide_at_side(tile_map_id, tile_size, SIDE.RIGHT, 0, right_top_buffer, right_bottom_buffer)
				
				//if we can't get past the buffer or if we don't more speed than the buffer
				if(collide) || (collide_min && abs(velocity[vector2_x]) < up_right_buffer && velocity[vector2_y] < 0) || (collide_max && abs(velocity[vector2_x]) < bottom_right_buffer && velocity[vector2_y] > 0)
				{
					//we can't get there anyway, collide normally
					x = bbox_r - (bbox_r mod tile_size)
					x -= bbox_right - x + 1
					velocity[@ vector2_x] = 0;
				}
				else
				{
					//the buffer allows us to get there, but only if we push up/down
					if(collide_min)
					{
						//we hit the TOP side, so push DOWN
						collision_y_offset = y
						y = bbox_t - (bbox_t mod tile_size)
						y += tile_size+y-bbox_top;
						collision_y_offset = collision_y_offset - y
					}
					
					if(collide_max)
					{
						collision_y_offset = y
						//we hit the BOTTOM side, so push UP
						y = bbox_b - (bbox_b mod tile_size)
						y -= bbox_bottom-y + 1;
						collision_y_offset = collision_y_offset - y
					}
				}
			}
			else
			{
				//both sides got hit, just collide
				x = bbox_r - (bbox_r mod tile_size)
				x -= bbox_right - x + 1
				velocity[@ vector2_x] = 0;
			}
		}
	} 
	else 
	{
		//we're moving left
		//for sideways, check without buffer first
		collide = tile_collide_at_side(tile_map_id, tile_size, SIDE.LEFT, 0, 0, 0)
		
		//if we're not clear
		if (collide) 
		{
			collide_min = tile_collide_at_points(tile_map_id, [bbox_l, bbox_t]);
			collide_max = tile_collide_at_points(tile_map_id, [bbox_l, bbox_b]);
			
			//if one side got hit and one didn't
			if(collide_min != collide_max)
			{
				//check for collision buffers
				collide = tile_collide_at_side(tile_map_id, tile_size, SIDE.LEFT, 0, left_top_buffer, left_bottom_buffer)
				
				//if we can't get past the buffer or if we don't more speed than the buffer
				if(collide) || (collide_min && abs(velocity[vector2_x]) < up_left_buffer && velocity[vector2_y] < 0) || (collide_max && abs(velocity[vector2_x]) < bottom_left_buffer && velocity[vector2_y] > 0)
				{
					//we can't get there anyway, collide normally
					x = bbox_l - (bbox_l mod tile_size)
					x += tile_size + x - bbox_left
					velocity[@ vector2_x] = 0;
				}
				else
				{
					//the buffer allows us to get there, but only if we push up/down
					if(collide_min)
					{
						collision_y_offset = y
						//we hit the TOP side, so push DOWN
						y = bbox_t - (bbox_t mod tile_size)
						y += tile_size+y-bbox_top;
						collision_y_offset = collision_y_offset - y
					}
					
					if(collide_max)
					{
						collision_y_offset = y
						//we hit the BOTTOM side, so push UP
						y = bbox_b - (bbox_b mod tile_size)
						y -= bbox_bottom-y + 1;
						collision_y_offset = collision_y_offset - y
					}
				}
			}
			else
			{
				//both sides got hit, just collide
				x = bbox_l - (bbox_l mod tile_size)
				x += tile_size + x - bbox_left
				velocity[@ vector2_x] = 0;
			}
		}
	}
	
	// Move vertically
	y += velocity[vector2_y];

	//update bounding boxes as distances from x and y
	bbox_l = floor(round(x) - bbox_left + x)
	bbox_r = ceil(bbox_right - round(x) + x)
	bbox_t = floor(round(y) - bbox_top + y)
	bbox_b = ceil(bbox_bottom - round(y) + y)

	count = max(ceil((bbox_r - bbox_l) / tile_size) + 1, 2)
	collide = false
	collide_min = false
	collide_max = false
	collide_temp = false
	
	// Vertical collisions
	if velocity[vector2_y] > 0 
	{
		//we're going down
		//for vertical, check without buffer first
		collide = tile_collide_at_side(tile_map_id, tile_size, SIDE.BOTTOM, 0, 0, 0)
		
		//if we're not clear
		if (collide) 
		{
			collide_min = tile_collide_at_points(tile_map_id, [bbox_l, bbox_b]);
			collide_max = tile_collide_at_points(tile_map_id, [bbox_r, bbox_b]);
			
			//if one side got hit and one didn't
			if(collide_min != collide_max)
			{
				//check for collision buffers
				collide = tile_collide_at_side(tile_map_id, tile_size, SIDE.BOTTOM, 0, bottom_left_buffer, bottom_right_buffer)
				
				//if we can't get past the buffer or if we don't more speed than the buffer
				if(collide) || (collide_min && abs(velocity[vector2_y]) < left_bottom_buffer && velocity[vector2_x] < 0) || (collide_max && abs(velocity[vector2_y]) < right_bottom_buffer && velocity[vector2_x] > 0)
				{
					//we can't get there anyway, collide normally
					y = bbox_b - (bbox_b mod tile_size)
					y -= bbox_bottom-y + 1;
					velocity[@ vector2_y] = 0;
				}
				else
				{
					//the buffer allows us to get there, but only if we push left/right
					if(collide_min)
					{
						collision_x_offset = x
						//we hit the LEFT side, so push RIGHT
						x = bbox_l - (bbox_l mod tile_size)
						x += tile_size + x - bbox_left
						collision_x_offset = collision_x_offset - x
					}
					
					if(collide_max)
					{
						collision_x_offset = x
						//we hit the RIGHT side, so push LEFT
						x = bbox_r - (bbox_r mod tile_size)
						x -= bbox_right - x + 1
						collision_x_offset = collision_x_offset - x
					}
				}
			}
			else
			{
				//both sides got hit, just collide
				y = bbox_b - (bbox_b mod tile_size)
				y -= bbox_bottom-y + 1;
				velocity[@ vector2_y] = 0;
			}
		}
	} 
	else 
	{
		//we're going up
		//for vertical, check without buffer first
		collide = tile_collide_at_side(tile_map_id, tile_size, SIDE.TOP, 0, 0, 0)
		
		//if we're not clear
		if (collide) 
		{
			collide_min = tile_collide_at_points(tile_map_id, [bbox_l, bbox_t]);
			collide_max = tile_collide_at_points(tile_map_id, [bbox_r, bbox_t]);
			
			//if one side got hit and one didn't
			if(collide_min != collide_max)
			{
				//check for collision buffers
				collide = tile_collide_at_side(tile_map_id, tile_size, SIDE.TOP, 0, up_left_buffer, up_right_buffer)
				
				//if we can't get past the buffer or if we don't more speed than the buffer
				if(collide) || (collide_min && abs(velocity[vector2_y]) < left_top_buffer && velocity[vector2_x] < 0) || (collide_max && abs(velocity[vector2_y]) < right_top_buffer && velocity[vector2_x] > 0)
				{
					//we can't get there anyway, collide normally
					y = bbox_t - (bbox_t mod tile_size)
					y += tile_size+y-bbox_top;
					velocity[@ vector2_y] = 0;
				}
				else
				{
					//the buffer allows us to get there, but only if we push left/right
					if(collide_min)
					{
						collision_x_offset = x
						//we hit the LEFT side, so push RIGHT
						x = bbox_l - (bbox_l mod tile_size)
						x += tile_size + x - bbox_left
						collision_x_offset = collision_x_offset - x
					}
					
					if(collide_max)
					{
						collision_x_offset = x
						//we hit the RIGHT side, so push LEFT
						x = bbox_r - (bbox_r mod tile_size)
						x -= bbox_right - x + 1
						collision_x_offset = collision_x_offset - x
					}
				}
			}
			else
			{
				//both sides got hit, just collide
				y = bbox_t - (bbox_t mod tile_size)
				y += tile_size+y-bbox_top;
				velocity[@ vector2_y] = 0;
			}
		}
	}
	
	//add the positions to the collision offsets, after you lerp them with gradual_change_modifier to be smaller
	collision_x_offset = lerp(collision_x_offset, 0, gradual_change_modifier)
	collision_y_offset = lerp(collision_y_offset, 0, gradual_change_modifier)
	
	return [collision_x_offset, collision_y_offset]
}