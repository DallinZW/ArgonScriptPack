/// @arg player_id
/// @arg input_id
/// @arg [count_press_as_hold=true]
function input_held() {

	var player_id	= argument[0];
	var input_id	= argument[1];
	var count_press_as_hold = true; if argument_count > 2 { count_press_as_hold = argument[2]; }

	return	(INPUT_STATES[player_id][input_id] == input_state.held) || 
			(INPUT_STATES[player_id][input_id] == input_state.pressed && count_press_as_hold);


}
