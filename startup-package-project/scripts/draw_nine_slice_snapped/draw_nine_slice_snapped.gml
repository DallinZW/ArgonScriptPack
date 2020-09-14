// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_nine_slice_snapped(spr, x1, y1, x2, y2){
	var part_width = sprite_get_width(spr) div 3
	var part_height = sprite_get_height(spr) div 3
	var w = x2 - x1
	var h = y2 - y1
	var columns = w div part_width
	var rows = h div part_height
	
	//draw corners
	draw_sprite_part(spr, 0, 0, 0, part_width, part_height, x1, y1) //tl
	draw_sprite_part(spr, 0, part_width * 2, 0, part_width, part_height, x1 + (columns * part_width), y1) //tr
	draw_sprite_part(spr, 0, 0, part_height * 2, part_width, part_height, x1, y1 + (rows * part_height)) //bl
	draw_sprite_part(spr, 0, part_width * 2, part_height * 2, part_width, part_height, x1 + (columns * part_width), y1 + (rows * part_height)) //br
	
	//draw edges
	//vertical
	for(var i = 1; i < rows; i++)
	{
		draw_sprite_part(spr, 0, 0, part_height, part_width, part_height, x1, y1 + (i * part_height))
		draw_sprite_part(spr, 0, part_width * 2, part_height, part_width, part_height, x1 + (columns * part_width), y1 + (i * part_height))
	}
	
	//horizontal
	for(var i = 1; i < columns; i++)
	{
		draw_sprite_part(spr, 0, part_width, 0, part_width, part_height, x1 + (i * part_width), y1)
		draw_sprite_part(spr, 0, part_width, part_height * 2, part_width, part_height, x1 + (i * part_width), y1 + (rows * part_height))
	}
	
	//draw middle
	for(var _x = 1; _x < columns; _x++)
	{
		for(var _y = 1; _y < rows; _y++)
		{
			draw_sprite_part(spr, 0, part_width, part_height, part_width, part_height, x1 + (_x * part_width), y1 + (_y * part_height))
		}
	}
}