///@desc easing
///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseInCirc(argument0, argument1, argument2, argument3) {

	argument0 /= argument3;
	return argument2 * (1 - sqrt(1 - argument0 * argument0)) + argument1;


}
