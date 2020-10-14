///@desc initializes the input manager
///@arg max_players
function init_inputs(argument0) {

	/* This is where we set up the DATA STRUCTURES for handling all of our inputs.

	First, we're going to set up a bunch of "Input Actions." These actions are going to be tied
	to different key presses and whatnot later on. This is how we standardize our input system.
	To keep this project simple, we're just going to have a character that moves up, down, left, and right.

	We'll set up our Input Actions as an enumerator, because enumerators are easy to work with, and it will
	automatically assign the ID numbers of each of the input actions. To learn more about enumerators,
	you can just middle-click the word 'enum' below. */

	enum input_action { up, down, left,	right, jump, confirm, back };

	// Next, we'll make an enum for input values- eg gamepads axes and multi-button thingies.

	enum input_values { horizontal, vertical }

	/* Next, we're going to initialize a few different input *states* in the same way.

	We'll then be able to connect these inputs states to different input actions for different players.

	For example, we will be able to know that Player 1 is holding the "Left" input, while
	player 2 just released the "Up" input. But more on that later! For now, we'll just initialize.*/

	enum input_state { none, pressed, held,	released };

	//now, make an enum for sorting through the input_value data array

	enum input_value_data { positive, negative, axis }

	// Now we'll set up some global variables to store all of our different bits of information.

	global.MAX_PLAYERS			= argument0;	// This is a variable that lets us set the maximum number of players we want to handle.
	global.INPUT_STATES			= 0;	// This will be a 2D array that holds the state of each input action for each player.
	global.INPUT_VALUES			= 0;	// This will be a 2D array that holds the value of each joystick for each player.
	global.INPUT_VALUE_DATA		= 0;	// This will be a 2D array that holds the inputs and joysticks for each input_value.
	global.INPUT_KEYBOARD_KEYS	= 0;	// This will be a 1D array that holds the keyboard hotkey assignments for each input action.
	global.INPUT_GAMEPAD_KEYS	= 0;	// This will be a 1D array that holds the gamepad hotkey assignments for each input action.
	global.INPUT_MOUSE_KEYS		= 0;	// This will be a 1D array that holds the mouse hotkey assignments for each input action.

	// Next, we'll create a list that will let us store the control method assigned to each player.
	global.PLAYER_GAMEPAD_IDS = ds_list_create(); 
	
	//this one will be a list that stores disconnected controllers
	global.PLAYER_GAMEPAD_DISCONNECTS = ds_list_create(); 

	ds_list_add(global.PLAYER_GAMEPAD_IDS, -1);
	ds_list_add(global.PLAYER_GAMEPAD_DISCONNECTS, false);

	/* Each position in the PLAYER_GAMEPAD_IDS list corresponds to a unique player.

	We use a gamepad ID of -1 to represent that the player is not using a gamepad, but is instead using a keyboard.
	We've started by adding a -1 to the list, so that the first player is initialized as using the keyboard.

	Next, we'll run a custom script called input_create() to initialize our different inputs. Go ahead
	and pop open the input_create() script to see what it does! */

	input_create(input_action.up,		[ord("W"), vk_up],		gp_padu);
	input_create(input_action.down,		[ord("S"), vk_down],	gp_padd);
	input_create(input_action.left,		[ord("A"), vk_left],	gp_padl);
	input_create(input_action.right,	[ord("D"), vk_right],	gp_padr);
	input_create(input_action.jump,		[vk_lshift, vk_space],	gp_face2);
	input_create(input_action.confirm,	vk_enter, gp_face1)
	input_create(input_action.back,	[vk_rshift, vk_lshift], gp_face2)
	input_value_create(input_values.horizontal,	input_action.right, input_action.left,	gp_axislh)
	input_value_create(input_values.vertical,	input_action.down,	input_action.up,	gp_axislv)

	/* lastly, let's set up our deadzones! */
	//gamepad_ids go from 0-11
	for(var i = 0; i < 12; i++)
	{
		gamepad_set_axis_deadzone(i, 0.71)
	}
	/* We have initialized all of our input actions and given them keyboard and gamepad keys.

	Now, we can create our input manager object, which will be the mastermind that pulls everything together.

	Go ahead and open up o_input_manager, and take a look at its "Begin Step" event!*/


}
