///@desc draws a pie chart
///@arg ds_list_data
///@arg ds_list_colors
///@arg total_buffer_size
///@arg pie_sprite
function draw_pie_chart(argument0, argument1, argument2, argument3) {

	//get total values
	var total = 0;
	for(var i = 0; i < ds_list_size(argument0); i++)
	{
		total += argument0[| i];
	}

	//buffer bonus
	var buffsize = argument2 * total/ds_list_size(argument0)
	total *= 1 + argument2

	//draw each section of the pie chart
	var v, vmod, value;
	value = 0
	vmod = 1

	for(var i = 0; i < ds_list_size(argument0); i++)
	{
		vmod = ((sin(current_time/1500) + 1) / 2)
	
		v = argument0[| i] / total
	
		//set color
		draw_set_color(argument1[| Wrap(i, 0, ds_list_size(argument1 - 1))])
	
		//draw colored part
		draw_rectangle_cd_texture(bbox_left, bbox_top, bbox_right, bbox_bottom, value, value + vmod * v, argument3)
	
		//adjust value
		value += v * vmod //for the bit that just went
		value += buffsize/total * vmod //for the buffer
	}

	draw_set_color(c_white)


}
