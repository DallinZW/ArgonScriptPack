///@desc initializes a menu
///@arg default_font
///@arg left_arrow_sprite
///@arg right_arrow_sprite
///@arg disabled_alpha
///@arg [bump_size_x]
///@arg [bump_time_x]
///@arg [bump_size_y]
///@arg [bump_time_y]
///@arg [pointer_sprite]
///@arg [DAS_delay]
///@arg [DAS_speed]
function init_menu() {

	//erase old menu, if it exists, to allow for layered menus

	menu_array = 0

	menu_array[0][0] = ""
	menu_array[0][1] = -1
	menu_array[0][2] = argument[0] //just needs any font that exists
	menu_array[0][3] = c_white
	menu_array[0][4] = c_white

	menu_default_font = argument[0]

	menu_pointer_sprite = -1
	menu_arrows = [argument[1], argument[2]]

	menu_disabled_alpha = argument[3]

	menu_bump_size_x = 0
	menu_bump_time_x = 0
	menu_bump_dir_x = 1
	menu_bump_size_y = 0
	menu_bump_time_y = 0
	menu_bump_dir_y = 1

	menu_DAS_timer_x = 0
	menu_DAS_timer_y = 0

	menu_DAS_delay = 30
	menu_DAS_speed = 4

	menu_confirmed = false

	if(argument_count > 4)
	{
		menu_bump_size_x = argument[4]
		menu_bump_time_x = argument[5]
		menu_bump_size_y = argument[6]
		menu_bump_time_y = argument[7]
	
		if(argument_count > 8)
		{
			menu_pointer_sprite = argument[8]
	
			if(argument_count > 9)
			{
				menu_DAS_delay = argument[9]
				menu_DAS_speed = argument[10]
			}
		}
	}

	menu_bump_timer_x = menu_bump_time_x
	menu_bump_timer_y = menu_bump_time_y


}
