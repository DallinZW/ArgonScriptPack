// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function tile_collide_at_side(tile_map_id, tile_size, side, normal_modifier, low_modifier, high_modifier){
	
	var bbox_l = floor(round(x) - bbox_left + x)
	var bbox_r = ceil(bbox_right - round(x) + x)
	var bbox_t = floor(round(y) - bbox_top + y)
	var bbox_b = ceil(bbox_bottom - round(y) + y)
	
	normal_modifier		= abs(normal_modifier)
	low_modifier		= abs(low_modifier)
	high_modifier		= abs(high_modifier)
	
	var count;
	var collide = false
	
	switch(side)
	{
		case SIDE.RIGHT:
		{
			count = max(ceil((bbox_b - bbox_t) / tile_size) + 1, 2)
			 
			for(var i = 0; i < count; i++)
			{
				collide = (collide || tile_collide_at_points(tile_map_id, [bbox_r + normal_modifier, lerp(bbox_t + low_modifier, bbox_b - high_modifier, i/(count - 1))]));
			}
			break;
		}
		case SIDE.TOP:
		{
			count = max(ceil((bbox_r - bbox_l) / tile_size) + 1, 2)
			
			for(var i = 0; i < count; i++)
			{
				collide = (collide || tile_collide_at_points(tile_map_id, [lerp(bbox_l + low_modifier, bbox_r - high_modifier, i/(count - 1)), bbox_t - normal_modifier]));
			}
			break;
		}
		case SIDE.LEFT:
		{
			count = max(ceil((bbox_b - bbox_t) / tile_size) + 1, 2)
			
			for(var i = 0; i < count; i++)
			{
				collide = (collide || tile_collide_at_points(tile_map_id, [bbox_l - normal_modifier, lerp(bbox_t + low_modifier, bbox_b - high_modifier, i/(count - 1))]));
			}
			break;
		}
		case SIDE.BOTTOM:
		{
			count = max(ceil((bbox_r - bbox_l) / tile_size) + 1, 2)
			
			for(var i = 0; i < count; i++)
			{
				collide = (collide || tile_collide_at_points(tile_map_id, [lerp(bbox_l + low_modifier, bbox_r - high_modifier, i/(count - 1)), bbox_b + normal_modifier]));
			}
			break;
		}
	}
	
	return collide
}