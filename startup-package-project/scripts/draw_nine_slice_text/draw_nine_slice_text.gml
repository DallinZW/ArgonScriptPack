// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_nine_slice_text(spr, x1, y1, x2, y2, str, h_buffer, v_buffer, color, font)
{
	var part_width = sprite_get_width(spr)/3
	var part_height  = sprite_get_width(spr)/3
	
	draw_nine_slice(spr, x1, y1, x2, y2)
	
	DrawSetText(color, font, fa_left, fa_top)
	draw_text(x1 + part_width + h_buffer, y1 + v_buffer + part_height, string_wrap(str, x2 - x1 - (part_width + h_buffer) * 2))
}