init_menu(fDebug, sArrowL, sArrowR, 0.7, 5, 5, 5, 5, sArrowR)

//instead of	name, variable, color x2, array, array, value,
//we do			name, variable, color x2, min, max, stepsize, and take value from variable
menu_add_variable("Max jump height", "jump_height_max", c_white, c_orange, 16, 80, 16)
menu_add_variable("Min jump height", "jump_height_min", c_white, c_orange, 16, 80, 16)

menu_add_variable("Minimum jump time", "min_jump_time", c_white, c_orange, 5, 80, 5)

menu_add("Confirm", function() { room_restart() }, c_white, c_aqua)