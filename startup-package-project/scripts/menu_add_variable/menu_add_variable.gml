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

	menu_array[w][MENUDATA.STRING] = argument[0]
	menu_array[w][MENUDATA.SCRIPT] = argument[1]
	menu_array[w][MENUDATA.FONT] = font
	menu_array[w][MENUDATA.COLOR] = argument[2]
	menu_array[w][MENUDATA.SELECTCOLOR] = argument[3]
	menu_array[w][MENUDATA.MIN_VALUE] = argument[4]
	menu_array[w][MENUDATA.MAX_VALUE] = argument[5]
	menu_array[w][MENUDATA.STEP_SIZE] = argument[6]
	
	//set the MAX_VALUE_WIDTH for the variable (if it is one)
	if(argument[6] != -1)
	{
		draw_set_font(font)
		var wid = 0;
		
		if(is_array(argument[4]))
		{
			var arr = argument[4]
			//it's an array style variable
			for(var i = 0; i < array_length(argument[4]); i++)
			{
				wid = max(wid, string_width(arr[i]))
			}
			menu_array[w][MENUDATA.MAX_VALUE_WIDTH] = wid
		}
		else
		{
			//it's a number style variable
			for(var i = argument[4]; i <= argument[5]; i += argument[6])
			{
				wid = max(wid, string_width(string(i)))
			}
			menu_array[w][MENUDATA.MAX_VALUE_WIDTH] = wid
		}
	}

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