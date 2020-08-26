///@arg from
///@arg to
///@arg duration
///@arg offset
function Wave(argument0, argument1, argument2, argument3) {

	a4 = (argument1 - argument0) * 0.5;
	return argument0 + a4 + sin((((current_time * 0.001) + argument2 * argument3) / argument2) * (pi*2)) * a4;


}
