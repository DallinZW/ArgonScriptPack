global.jump_height_max = 3 * TILESIZE
global.jump_height_min = 1 * TILESIZE
global.min_jump_time = 20

init_menu(fDebug, sOne, sOne, 0.7)
menu_add("Enter to open config", function() { event_user(0) }, c_gray, c_gray)