function input_create() {
	/* This is a script that will initialize an input action by making sure we have given
	it a keyboard key, a gamepad key, and a default state for all players. It's a
	quick way of initializing our inputs before we start to use them. */

	/// @arg input_action
	/// @arg keyboard_hotkey
	/// @arg gamepad_key_-1_for_null
	///	@arg [mouse_key]

	var the_input_action		= argument[0];
	var the_input_hotkey		= argument[1];
	if(!is_array(the_input_hotkey) && the_input_hotkey != -1) the_input_hotkey = [the_input_hotkey]

	var the_input_gamepad_key	= argument[2];
	if(!is_array(the_input_gamepad_key) && the_input_gamepad_key != -1) the_input_gamepad_key = [the_input_gamepad_key]

	var the_input_mouse_key		= -1;
	if(argument_count > 3)
	{
		the_input_mouse_key		= argument[3];
	}
	if(!is_array(the_input_mouse_key) && the_input_mouse_key != -1) the_input_mouse_key = [the_input_mouse_key]

	// First we'll assign the keyboard and gamepad keys to this input action.
	INPUT_KEYBOARD_KEYS[the_input_action]	= the_input_hotkey;
	INPUT_GAMEPAD_KEYS[the_input_action]	= the_input_gamepad_key;
	INPUT_MOUSE_KEYS[the_input_action]		= the_input_mouse_key;

	// Then, we'll set this input action's state to "none" for all players.
	for ( var p = 0; p < MAX_PLAYERS; p++) {
		INPUT_STATES[p][the_input_action]	= input_state.none;
	}

	// Okay, let's pop back into init_inputs()!
}
