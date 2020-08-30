///@desc easing
///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseOutQuad(argument0, argument1, argument2, argument3) {

	argument0 /= argument3;
	return -argument2 * argument0 * (argument0 - 2) + argument1;


}