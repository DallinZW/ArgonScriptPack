///@desc adds a menu variable value
///@arg string
///@arg variable_string
///@arg color
///@arg selected_color
///@arg min
///@arg max
///@arg stepsize
///@arg [font]
function menu_add_variable() {

	var w = array_length(menu_array)

	if(w == 1 && menu_array[0][0] == "")
	{
		w = 0
	}

	var font = menu_default_font
	if(argument_count > 7)
	{
		font = argument[7]
	}

	menu_array[w][0] = argument[0]
	menu_array[w][1] = argument[1]
	menu_array[w][2] = font
	menu_array[w][3] = argument[2]
	menu_array[w][4] = argument[3]
	menu_array[w][5] = argument[4]
	menu_array[w][6] = argument[5]
	menu_array[w][7] = argument[6]

	select_index = 0;

	while(menu_array[select_index][MENUDATA.SCRIPT] == -1)
	{
		select_index++
		if(select_index >= w)
		{
			select_index = -1
			break;
		}
	}
	selectedtimer = 0
}