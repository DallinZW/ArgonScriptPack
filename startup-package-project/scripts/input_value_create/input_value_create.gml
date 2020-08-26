function input_value_create() {
	/* This is a script that will initialize an input value by making sure we have given
	it keyboard keys, a gamepad joystick/key, and a default state for all players. It's a
	quick way of initializing our inputs before we start to use them. */

	/// @arg input_value
	/// @arg positive_input_actions
	/// @arg negative_input_actions
	/// @arg [joystick_id]

	var the_input_value		= argument[0];
	var the_positive_input_actions		= argument[1];
	if(!is_array(the_positive_input_actions) && the_positive_input_actions != -1) the_positive_input_actions = [the_positive_input_actions]

	var the_negative_input_actions	= argument[2];
	if(!is_array(the_negative_input_actions) && the_negative_input_actions != -1) the_negative_input_actions = [the_negative_input_actions]

	var the_axis = -1
	if(argument_count > 3)
	{
		the_axis = argument[3]
	}
	if(!is_array(the_axis)) the_axis = [the_axis]

	// First we'll assign the input_value_data the info for this action
	INPUT_VALUE_DATA[the_input_value][input_value_data.positive]	= the_positive_input_actions;
	INPUT_VALUE_DATA[the_input_value][input_value_data.negative]	= the_negative_input_actions;
	INPUT_VALUE_DATA[the_input_value][input_value_data.axis]		= the_axis;

	// Then, we'll set this input action's state to 0 for all players.
	for ( var p = 0; p < MAX_PLAYERS; p++) {
		INPUT_VALUES[p][the_input_value] = 0;
	}

	// Okay, let's pop back into init_inputs()!


}
