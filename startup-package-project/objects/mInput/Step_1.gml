/* Welcome to the input manager, where the magic happens!

This object has two jobs:

1. To decide which device controls which player, and
2. To standardize all the inputs in a way that is easy to read.

Notice that this object is Persistent (the checkbox to the left, under "Visible").
This means the object can be created once at the start of the game, and it will live forever,
even between rooms.

Also notice that we are handling all of the inputs in the Begin Step event. This way, we can figure
out our input situation before we get to other things, like the normal Step event.

So, now it's on to the first job of the Input Manager: Assigning input devices to players!

First, we need to know how many gamepads we should be checking. */

var max_gamepad_slot = gamepad_get_device_count();
// Next, we'll check each gamepad and watch for buttons to be pressed.

for ( var gamepad_id = 0; gamepad_id < max_gamepad_slot; gamepad_id++){
	if gamepad_is_connected(gamepad_id) {
		/* When the player presses Start, "A", any of the Dpad buttons, or wiggles the joystick,
		we will assign the gamepad to a player, unless that gamepad is already in use. */
		
		if	gamepad_button_check_pressed(gamepad_id, gp_start) ||
			gamepad_button_check_pressed(gamepad_id, gp_face1) ||
			gamepad_button_check_pressed(gamepad_id, gp_padu) ||
			gamepad_button_check_pressed(gamepad_id, gp_padd) ||
			gamepad_button_check_pressed(gamepad_id, gp_padr) ||
			gamepad_button_check_pressed(gamepad_id, gp_padl) ||
			abs(gamepad_axis_value(gamepad_id, gp_axislh)) > .5 ||
			abs(gamepad_axis_value(gamepad_id, gp_axislv)) > .5 {
				
			var this_gamepad_player_id		= ds_list_find_index(PLAYER_GAMEPAD_IDS, gamepad_id);
			var gamepad_is_already_in_use	= (this_gamepad_player_id >= 0);
			
			if (!gamepad_is_already_in_use) {
				/* This gamepad hasn't been assigned to any players yet, so we want to assign it now
				because it has been activated! */
				
				var first_player_is_using_keyboard = (ds_list_find_value(PLAYER_GAMEPAD_IDS, 0) == -1);
				
				if first_player_is_using_keyboard {
					/* We will also check whether the first player is using a keyboard.
					If they are, we will swap them to the gamepad, allowing player 1
					to seamlessly switch between keyboard and controller. */
					
					ds_list_replace(PLAYER_GAMEPAD_IDS, 0, gamepad_id);
				}
				else if ds_list_size(PLAYER_GAMEPAD_IDS) < MAX_PLAYERS {
					/* This is a whole new player, so we'll add this gamepad to the list. */
					
					ds_list_add(PLAYER_GAMEPAD_IDS, gamepad_id); 
				}
			}
		}
	}
}

/* We also need to check for *disconnected* gamepads. So let's do that!

We'll allow the "Select" or "Back" button to disconnect the gamepad, or if the gamepad gets turned off or unplugged.

If it turns out that we've lost a gamepad, we will need to delete it from the list. So we want to
start at the end of the list and iterate down to zero, so deleting stuff doesn't mess up our counts. */

for ( var player_id = ds_list_size(PLAYER_GAMEPAD_IDS)-1; player_id >= 0; player_id--){
	var this_player_gamepad_id = PLAYER_GAMEPAD_IDS[| player_id];
	if (this_player_gamepad_id >= 0) {
		if !gamepad_is_connected(this_player_gamepad_id) || gamepad_button_check_pressed(this_player_gamepad_id, gp_select) {
			
			// Then we will remove this gamepad from our list by deleting the current player slot.
			ds_list_delete(PLAYER_GAMEPAD_IDS, player_id);
		}
	}
}

/* But there's one caveat! If we end up with nothing in the list, that means we have no players,
which is a bad situation. In that case, we should add -1 back in to the list, so player 1
is back to using a keyboard. */

if ds_list_empty(PLAYER_GAMEPAD_IDS) {
	ds_list_add(PLAYER_GAMEPAD_IDS, -1);
}

/* And last, if player 1 presses a keyboard or a mouse button, we want to switch them back to keyboard mode
by simply ensuring that the first player's gamepad ID is -1. */
if keyboard_check_pressed(vk_anykey) || mouse_check_button_pressed(mb_any){
	ds_list_replace(PLAYER_GAMEPAD_IDS, 0, -1);	
}

/* Our input manager is now connecting and disconnecting controllers and keyboards dynamically.

Next, we're going check our connected devices, read their inputs, and funnel all their inputs
into the same system. Later, that system will be read by the player! */

/* we'll initialize some temporary variables for the loops we'll go through for each input array. */
var inputstate_temp;
var inputvalue_temp;
var inputvalue_array;

for ( var player_id = 0; player_id < ds_list_size(PLAYER_GAMEPAD_IDS); player_id++){
	
	/* For this player, we're going to iterate through our various input actions
	and check the state of that button. Then, we'll update our INPUT_STATES array with the result. */
	
	var this_gamepad_id = ds_list_find_value(PLAYER_GAMEPAD_IDS, player_id);
	
	for ( var this_input_action = 0; this_input_action < array_length(INPUT_STATES[0]); this_input_action++){
		if this_gamepad_id != -1 
		{
			/* In this case, we have a gamepad connected. Let's check the gamepad for this input action! */
			var this_input_button = INPUT_GAMEPAD_KEYS[this_input_action];
			
			/* We reset our temporary variable so we can have them all set to none */
			inputstate_temp = input_state.none
			
			/* we're forcing each input to be an array, so we can loop through them and tell 
				which keys are being pressed. */
			if(this_input_button != -1)
			{
				for(var i = 0; i < array_length(this_input_button); i++)
				{
					/* the weird logic here is a priority list for what input state the variable 
					  inputstate_temp can be based on what previous inputs have set it to be */
					if (gamepad_button_check_pressed(this_gamepad_id, this_input_button[i])) && (inputstate_temp != input_state.pressed)
					{
						inputstate_temp = input_state.pressed;	
					}
					else if (gamepad_button_check(this_gamepad_id, this_input_button[i]))
					{
						inputstate_temp = input_state.held;	
					}
					else if (gamepad_button_check_released(this_gamepad_id, this_input_button[i])) && (inputstate_temp != input_state.pressed) && (inputstate_temp != input_state.held)
					{
						inputstate_temp = input_state.released;	
					}
					else if (inputstate_temp == input_state.none)
					{
						inputstate_temp = input_state.none;
					}
				}
			}
			
			INPUT_STATES[player_id][this_input_action] = inputstate_temp
		}
		else 
		{
			/* In this case, we have a keyboard connected. Let's check the keyboard for this input action! */
			var this_keyboard_button = INPUT_KEYBOARD_KEYS[this_input_action];
			
			/* We reset our temporary variable so we can have them all set to none */
			inputstate_temp = input_state.none
			
			/* we're forcing each input to be an array, so we can loop through them and tell 
				which keys are being pressed. */
			
			if(this_keyboard_button != -1)
			{
				for(var i = 0; i < array_length(this_keyboard_button); i++)
				{
					/* the weird logic here is a priority list for what input state the variable 
					  inputstate_temp can be based on what previous inputs have set it to be */
					if (keyboard_check_pressed(this_keyboard_button[i])) && (inputstate_temp != input_state.pressed)
					{
						inputstate_temp = input_state.pressed;	
					}
					else if (keyboard_check(this_keyboard_button[i]))
					{
						inputstate_temp = input_state.held;	
					}
					else if (keyboard_check_released(this_keyboard_button[i])) && (inputstate_temp != input_state.pressed) && (inputstate_temp != input_state.held)
					{
						inputstate_temp = input_state.released;	
					}
					else if (inputstate_temp == input_state.none)
					{
						inputstate_temp = input_state.none;
					}
				}
			}
			
			/* the keyboard also is often in use with the mouse, so we'll check for mouse input at the same time */
			var this_mouse_button = INPUT_MOUSE_KEYS[this_input_action]
			
			if(this_mouse_button != -1)
			{
				for(var i = 0; i < array_length(this_mouse_button); i++)
				{
					/* the weird logic here is a priority list for what input state the variable 
					  inputstate_temp can be based on what previous inputs have set it to be */
					if (mouse_check_button_pressed(this_mouse_button[i])) && (inputstate_temp != input_state.pressed)
					{
						inputstate_temp = input_state.pressed;	
					}
					else if (mouse_check_button(this_mouse_button[i]))
					{
						inputstate_temp = input_state.held;	
					}
					else if (mouse_check_button_released(this_mouse_button[i])) && (inputstate_temp != input_state.pressed) && (inputstate_temp != input_state.held)
					{
						inputstate_temp = input_state.released;	
					}
					else if (inputstate_temp == input_state.none)
					{
						inputstate_temp = input_state.none;
					}
				}
			}
			
			INPUT_STATES[player_id][this_input_action] = inputstate_temp
			
			/* We have updated the state of this input action for this player in our INPUT_STATES array. */
		}
	}
	
	/* now we can sort through each input value, just like we did with the input actions! */
	
	for ( var this_input_value = 0; this_input_value < array_length(INPUT_VALUE_DATA); this_input_value++)
	{
		//first, let's set the value based just on the input_states.
		
		//we'll start with the positive data
		inputvalue_temp = 0
		inputvalue_array = INPUT_VALUE_DATA[this_input_value][input_value_data.positive]
		
		for (var i = 0; i < array_length(INPUT_VALUE_DATA[this_input_value][input_value_data.positive]); i++)
		{
			inputvalue_temp = max(input_held(player_id, inputvalue_array[i]), inputvalue_temp)
		}
		
		INPUT_VALUES[player_id][this_input_value] = inputvalue_temp
		
		//now add the negative data
		inputvalue_temp = 0
		inputvalue_array = INPUT_VALUE_DATA[this_input_value][input_value_data.negative]
		
		for (var i = 0; i < array_length(INPUT_VALUE_DATA[this_input_value][input_value_data.negative]); i++)
		{
			inputvalue_temp = max(input_held(player_id, inputvalue_array[i]), inputvalue_temp)
		}
		
		INPUT_VALUES[player_id][this_input_value] -= inputvalue_temp
		
		//if this is a gamepad, we need to check the axis too (as long as it's not -1 and it's absolute value is more than it already is)
		inputvalue_temp = INPUT_VALUES[player_id][this_input_value]
		inputvalue_array = INPUT_VALUE_DATA[this_input_value][input_value_data.axis]
		if (this_gamepad_id != -1)
		{
			if(INPUT_VALUE_DATA[this_input_value][input_value_data.axis] != -1)
			{
				//we know it's an array, so we'll loop through it
				for(var i = 0; i < array_length(inputvalue_array); i++)
				{
					if(abs(inputvalue_temp) < abs(gamepad_axis_value(this_gamepad_id, inputvalue_array[i])))
					{
						inputvalue_temp = gamepad_axis_value(this_gamepad_id, inputvalue_array[i])
					}
				}
				INPUT_VALUES[player_id][this_input_value] = inputvalue_temp
			}
		}
	}
}

/* Now we're done processing inputs! To recap, what we did in this object was:
	1. Connect and disconnect devices, allowing for multiple players and different control devices (keyboard or controller).
	2. Read the button presses for each input_action from each player's device
	3. Write those input action states for each player into our standardized INPUT_STATES array.
	
Now that we have our input states stored conveniently, we can create a few convenience scripts so that other
objects can easily read these inputs. To do this, I have made the following scripts, which you can pop open and inspect:

	input_pressed()		-- If a player has pressed a certain input action, this will return true. Otherwise, false.
	input_held()		-- If a player is holding a certain input action, this will return true. Otherwise, false.
	input_released()	-- If a player has released a certain input action, this will return true. Otherwise, false.
	input_value()		-- returns the value of an axis (scale of -1 to 1)
	
Now, let's put these scripts into action! I've created a simple player object that just moves around, using our input_actions.
Let's take a look at the object called o_player, and jump into its Create event! */
	