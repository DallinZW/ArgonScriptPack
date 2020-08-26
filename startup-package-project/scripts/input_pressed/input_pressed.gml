/// @arg player_id
/// @arg input_id
function input_pressed(argument0, argument1) {

	var player_id	= argument0;
	var input_id	= argument1;

	return INPUT_STATES[player_id][input_id] == input_state.pressed;


}
