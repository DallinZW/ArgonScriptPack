///@desc adds a menu command
///@arg string
///@arg script
///@arg color
///@arg selected color
///@arg [font]
function menu_add() {

	var font = menu_default_font
	if(argument_count > 4)
	{
		font = argument[4]
	}

	//sort of janky but it's the best resolution to the DRY rule
	//the script exists in the same row as the variable name string depending on what the menu entry is

	menu_add_variable(argument[0], argument[1], argument[2], argument[3], 0, 0, 0, font)


}
