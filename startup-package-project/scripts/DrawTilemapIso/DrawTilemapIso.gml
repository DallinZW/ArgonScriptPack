///@arg tilemap_id
///@arg tile_width
///@arg tile_height
///@arg sprite
function DrawTilemapIso(argument0, argument1, argument2, argument3) {

	//TESTING SCREENSPACE RENDERING
	var tX, tY, subimg
	var camXmin = max(ScreenToTileX(CamX(), CamY(), argument1, argument2) - 1, 0)
	var camYmin = max(ScreenToTileY(CamX()+ CamWidth(), CamY(), argument1, argument2) - 1, 0)

	var camXmax = min(tilemap_get_width(argument0), ScreenToTileX(CamX() + CamWidth(), CamY() + CamHeight(), argument1, argument2) + 1)
	var camYmax = min(tilemap_get_height(argument0), ScreenToTileY(CamX(), CamY() + CamHeight(), argument1, argument2) + 1)

	//loop through each grid index
	for(var _x = camXmin; _x < camXmax; _x++)
	{
		for(var _y = camYmin; _y < camYmax; _y++)
		{
			subimg = tilemap_get(argument0, _x, _y)
			//if we're even drawing anything
			if(subimg != 0)
			{
				tX = TileToIsoX(_x, _y, argument1)
				tY = TileToIsoY(_x, _y, argument2)
		
				//draw the tile
				draw_sprite(argument3, subimg, tX, tY)
			}
		}
	}



}
