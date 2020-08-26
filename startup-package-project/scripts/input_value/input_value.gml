///@desc returns a joystick value
///@arg player_id
///@arg input_id
function input_value(argument0, argument1) {

	var player_id = argument0
	var input_id = argument1

	return INPUT_VALUES[player_id][input_id]


}
