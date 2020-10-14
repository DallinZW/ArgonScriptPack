///@desc returns a joystick value
///@arg player_id
///@arg input_id
function input_value(argument0, argument1) {

	var player_id = argument0
	var input_id = argument1

	//add them all together, then clamp to -1, 1
	var inp = 0
	if(player_id == -1)
	{
		for(var i = 0; i < global.MAX_PLAYERS; i++)
		{
			inp += (global.INPUT_VALUES[i][input_id]);
		}
	}
	else
	{
		inp = global.INPUT_VALUES[player_id][input_id]
	}
	
	return clamp(inp, -1, 1)
}
