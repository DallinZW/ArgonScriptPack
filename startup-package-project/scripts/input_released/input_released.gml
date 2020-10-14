/// @arg player_id
/// @arg input_id
function input_released() {

	var player_id	= argument[0];
	var input_id	= argument[1];

	var inp = false
	if(player_id == -1)
	{
		for(var i = 0; i < global.MAX_PLAYERS; i++)
		{
			inp = inp || (global.INPUT_STATES[i][input_id] == input_state.released);
		}
	}
	else
	{
		inp = (global.INPUT_STATES[player_id][input_id] == input_state.released);
	}
	
	return inp
}
