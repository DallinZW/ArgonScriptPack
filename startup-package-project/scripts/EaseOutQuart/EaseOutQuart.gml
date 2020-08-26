///@desc easing
///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseOutQuart(argument0, argument1, argument2, argument3) {

	return -argument2 * (power(argument0 / argument3 - 1, 4) - 1) + argument1;


}
