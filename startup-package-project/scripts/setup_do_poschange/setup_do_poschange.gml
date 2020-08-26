///@desc initializes position change for draw_value_ext
///@arg speed
///@arg time
///@arg x
///@arg y
function setup_do_poschange(argument0, argument1, argument2, argument3) {

	//X AND Y ARE ON A 0-1 GUI SCALE

	poschange = true

	poschangespeed = argument0
	poschangetimermax = argument1
	poschangex = argument2
	poschangey = argument3

	poschangetimer = poschangetimermax


}
