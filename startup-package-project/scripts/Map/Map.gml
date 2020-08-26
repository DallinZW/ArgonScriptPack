///@arg value
///@arg min
///@arg max
///@arg newmin
///@arg newmax
function Map(argument0, argument1, argument2, argument3, argument4) {

	var place = InverseLerp(argument1, argument2, argument0)
	return lerp(argument3, argument4, place)



}
