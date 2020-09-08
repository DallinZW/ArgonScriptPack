global.test = 4
global.array_value = 1


init_menu(fDebug, sArrowL, sArrowR, 0.7, 5, 5, 5, 5, -1)
var defcol = c_white
var selcol = c_orange
var inacol = c_gray
menu_add_header("TEST", defcol)
menu_add("Play", function () { room_restart() }, inacol, selcol)
menu_add_variable("test", "test", inacol, selcol, 0, 10, 1)
menu_add_array("array_test", "array_value", inacol, selcol, ["apple", "banana", "grape"], [0, 1, 2])