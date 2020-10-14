/// @arg player_id
/// @arg input_id
/// @arg [count_press_as_hold=true]
function input_held() {

	var player_id	= argument[0];
	var input_id	= argument[1];
	var count_press_as_hold = true; if argument_count > 2 { count_press_as_hold = argument[2]; }

	return	(global.INPUT_STATES[player_id][input_id] == input_state.held) || 
			(global.INPUT_STATES[player_id][input_id] == input_state.pressed && count_press_as_hold);

	var inp = false
	if(player_id == -1)
	{
		for(var i = 0; i < global.MAX_PLAYERS; i++)
		{
			inp = inp ||	(global.INPUT_STATES[i][input_id] == input_state.held) || 
							(global.INPUT_STATES[i][input_id] == input_state.pressed && count_press_as_hold);
		}
	}
	else
	{
		inp =	(global.INPUT_STATES[player_id][input_id] == input_state.held) || 
				(global.INPUT_STATES[player_id][input_id] == input_state.pressed && count_press_as_hold);
	}
	return inp
}
