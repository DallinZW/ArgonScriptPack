/// @arg player_id
/// @arg input_id
/// @arg input_id
function input_released() {

	var player_id	= argument[0];
	var input_id	= argument[1];

	return INPUT_STATES[player_id][input_id] == input_state.released;


}
