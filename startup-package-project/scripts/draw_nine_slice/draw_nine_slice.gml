// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_nine_slice(spr, x1, y1, x2, y2){
	var part_width = sprite_get_width(spr) div 3
	var part_height = sprite_get_height(spr) div 3
	var w = x2 - x1
	var h = y2 - y1
	
	//middle
	draw_sprite_part_ext(spr, 0, part_width, part_height, 1, 1, x1 + part_width, y1 + part_height, w - (part_width * 2), h - (part_height * 2), c_white, 1);
	
	//corners
	//top left
	draw_sprite_part(spr, 0, 0, 0, part_width, part_height, x1, y1)
	//top right
	draw_sprite_part(spr, 0, part_width * 2, 0, part_width, part_height, x1 + w - part_width, y1)
	//bottom left
	draw_sprite_part(spr, 0, 0, part_height * 2, part_width, part_height, x1, y1 + h - part_height)
	//bottom right
	draw_sprite_part(spr, 0, part_width * 2, part_height * 2, part_width, part_height, x1 + w - part_width, y1 + h - part_height)
	
	//edges
	//left edge
	draw_sprite_part_ext(spr, 0, 0, part_height, part_width, 1, x1, y1 + part_height, 1, h - (part_height * 2), c_white, 1)
	//right edge
	draw_sprite_part_ext(spr, 0, part_width * 2, part_height, part_width, 1, x1 + w - part_width, y1 + part_height, 1, h - (part_height * 2), c_white, 1)
	//top edge
	draw_sprite_part_ext(spr, 0, part_width, 0, 1, part_height, x1 + part_width, y1, w - (part_width * 2), 1, c_white, 1)
	//bottom edge
	draw_sprite_part_ext(spr, 0, part_width, part_height * 2, 1, part_height, x1 + part_width, y1 + h - part_height, w - (part_width * 2), 1, c_white, 1)
}