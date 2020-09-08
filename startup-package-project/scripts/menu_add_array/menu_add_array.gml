// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
///@arg string
///@arg variable_string
///@arg color
///@arg selected_color
///@arg string_array
///@arg value_array
///@arg [font]
function menu_add_array(){
	
	//find our current position
	var index = array_find_index(argument[5], variable_global_get(argument[1]))
	index = (index == -1) ? 0 : index;
	
	if(argument_count > 6)
	{
		menu_add_variable(argument[0], argument[1], argument[2], argument[3], argument[4], argument[5], index, argument[6])
	}
	else
	{
		menu_add_variable(argument[0], argument[1], argument[2], argument[3], argument[4], argument[5], index)
	}
}