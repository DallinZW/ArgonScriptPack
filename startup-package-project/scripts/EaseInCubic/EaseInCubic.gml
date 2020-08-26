///@desc easing
///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseInCubic(argument0, argument1, argument2, argument3) {

	return argument2 * power(argument0/argument3, 3) + argument1;


}
