///@desc makes a menu 'header'
///@arg string
///@arg color
///@arg [font]
function menu_add_header() {

	var font = menu_default_font

	if(argument_count > 2)
	{
		font = argument[2]
	}

	menu_add(argument[0], -1, argument[1], c_white, font)


}
