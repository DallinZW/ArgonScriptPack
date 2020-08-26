///@arg val1
///@arg val2
///@arg seed
function getSeed(argument0, argument1, argument2) {

	var val1 = argument0;
	var val2 = argument1;
	var seed = argument2;

	random_set_seed(-val1);
	var firstseed = random(999999);
	random_set_seed(val2);
	var secondseed = random(999999);

	return firstseed + secondseed + seed



}
