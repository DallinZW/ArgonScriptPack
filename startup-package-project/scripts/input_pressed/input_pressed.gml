/// @arg player_id
/// @arg input_id
function input_pressed(argument0, argument1) {

	var player_id	= argument0;
	var input_id	= argument1;

	var inp = false
	if(player_id == -1)
	{
		for(var i = 0; i < global.MAX_PLAYERS; i++)
		{
			inp = inp || (global.INPUT_STATES[i][input_id] == input_state.pressed);
		}
	}
	else
	{
		inp = (global.INPUT_STATES[player_id][input_id] == input_state.pressed);
	}
	
	return inp
}