///@desc easing
///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseInSine(argument0, argument1, argument2, argument3) {

	return argument2 * (1 - cos(argument0 / argument3 * (pi / 2))) + argument1;


}
