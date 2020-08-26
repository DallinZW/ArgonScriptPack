///@desc draws a pretty cool scatter graph
///@arg one_px_sprite
///@arg scaleArray
///@arg gridScrollMod
///@arg surfPing
///@arg surfPong
///@arg gridLineAlpha
///@arg gridLineWidth
///@arg dataColor
///@arg gridColor
///@arg gridLineDensityArray
///@arg dataScrollSpeed
///@arg dataArray/NaN
///@arg dataMin
///@arg dataMax
///@arg dataPointSprite
function draw_scatter_graph(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, argument9, argument10, argument11, argument12, argument13, argument14) {

	var onepx = argument0
	var xscale = argument1[0]
	var yscale = argument1[1]
	var gridscrollmod = argument2
	var surf_w = surface_get_width(argument3)
	var surf_h = surface_get_height(argument3)
	var gridlinesalpha = argument5
	var linewidth = argument6
	var col = argument7
	var col2 = argument8
	var gridxdist = argument9[0]
	var gridydist = argument9[1]
	var scrollspeed = argument10
	var data = argument11
	var datamin = argument12
	var datamax = argument13
	var dataSprite = argument14

	//draw axes
	draw_sprite_ext(onepx, 0, x, y + (1 - yscale) * surf_h, linewidth * xscale, surf_h * yscale, 0, col2, 1) //left
	draw_sprite_ext(onepx, 0, x, y + surf_h, surf_w * xscale, linewidth * yscale, 0, col2, 1) //bottom

	//draw gridlines
	//pulsing alpha
	var alphatemp = gridlinesalpha + sin(current_time/400) * 0.02

	//x axis
	for(var i = 0; i <= surf_h; i += (surf_h) * gridxdist)
	{
		draw_sprite_ext(onepx, 0, x, y + surf_h - i * yscale, surf_w * xscale, linewidth * yscale, 0, col2, alphatemp)
	}

	//y axis
	for(var i = gridydist * surf_w - Wrap(gridscrollmod * game_get_speed(gamespeed_fps) * scrollspeed * current_time/1000, 0, surf_w * gridydist); i <= surf_w; i += (surf_w) * gridydist)
	{
		draw_sprite_ext(sOne, 0, x + (i) * xscale, y + (1 - yscale) * surf_h, linewidth * xscale, surf_h * yscale, 0, col2, alphatemp)
	}
	
	//draw data on ping
	if(!(data[0] == NaN))
	{
		surface_set_target(argument3)
			for(var i = 0; i < array_length(data); i++)
			{
				draw_sprite(dataSprite, 0, surf_w - sprite_get_width(dataSprite), Map(data[i], datamin, datamax, surf_h, 0))
			}
		surface_reset_target()
	}
	
	//draw ping on pong, shifted left to create motion
	surface_set_target(argument4)
		draw_surface(argument3, 0 - scrollspeed, 0)
	surface_reset_target()
	
	//clear ping surface to prevent smearing
	surface_set_target(argument3)
		draw_clear_alpha(c_white, 0)
	
		//draw pong on ping to make shader and revert back to the ping surface
		shader_set(shTintXPos)
			shader_set_uniform_f(shader_get_uniform(shTintXPos, "tintColor"), color_get_red(col)/255, color_get_green(col)/255, color_get_blue(col)/255)
			draw_surface(argument4, 0, 0)
		shader_reset()
	surface_reset_target()

	//clear pong to prevent smearing
	surface_set_target(argument4)
		draw_clear_alpha(c_white, 0)
	surface_reset_target()

	//draw ping to application surface
	draw_surface_ext(argument3, x, y + (1 - yscale) * surf_h, xscale, yscale, 0, c_white, 1)


}
