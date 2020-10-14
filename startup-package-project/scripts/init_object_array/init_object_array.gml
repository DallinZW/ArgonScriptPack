///@desc initializes an object array
///@arg do_stick
///@arg [DAS_delay]
///@arg [DAS_speed]
function init_object_array()
{
	//erase old array, if it exists, to allow for layered objects
	object_array = 0
	
	select_index = 0

	object_array[0] = -1
	
	selectedtimer = 60 //just a high number so extra functionality doesn't mess up
						//if it isn't causing problems don't mess with it

	object_DAS_timer_x = 0
	object_DAS_timer_y = 0
	object_DAS_input_x = 0
	object_DAS_input_y = 0

	object_DAS_delay = 30
	object_DAS_speed = 4
	
	object_array_do_stick = argument[0]
	
	object_array_locked = false
	
	if(argument_count > 1)
	{
		object_DAS_delay = argument[1]
		object_DAS_speed = argument[2]
	}
}