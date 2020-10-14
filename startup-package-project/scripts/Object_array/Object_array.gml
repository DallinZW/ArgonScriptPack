//object array functions

/*	includes: 

	init_object_array: starts it up
	object_array_destroy: destroys the object array
	
	object_array_add: adds an object to the array
	object_array_get_active_object: find what object is currently active
	object_array_get_parent: CAN ONLY BE RUN BY AN OBJECT IN THE ARRAY: returns the creator of the array
	object_array_get_x_input: gets the x input, accounting for DAS, of the array
	object_array_get_y_input: gets the y input, accounting for DAS, of the array
	object_array_get_locked: returns whether or not an object array is locked, meaning it can't be changed through y input
	object_array_set_locked: changes whether or not an object array is locked, meaning it can't be changed through y input

	object_array_manage: run every step for an object array
*/

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

///@arg x
///@arg y
///@arg depth
///@arg object
///@arg stick
function object_array_add()
{
	var inst = instance_create_depth(argument[0], argument[1], argument[2], argument[3]) 
	var w = array_length(object_array)
	
	if(w == 1 && object_array[0] == -1)
	{
		w = 0
	}
	
	object_array[w] = inst
	
	//x_offset and y_offset: used for custom methods
	inst.x_offset = 0
	inst.y_offset = 0
	
	//object_array_xoff and object_array_yoff: used for sticking to creator
	inst.object_array_xoff = inst.x - x
	inst.object_array_yoff = inst.y - y
	inst.active = false
	inst.creator = id
	return inst
}

function object_array_destroy()
{
	for(var i = 0; i < array_length(object_array); i++)
	{
		instance_destroy(object_array[i])
	}
}

function object_array_get_active_object(array_creator){
	if(array_creator == undefined) array_creator = creator
	return array_creator.object_array[select_index];
}

function object_array_get_locked(array_creator)
{
	if(array_creator == undefined) array_creator = creator
	return array_creator.object_array_locked
}

function object_array_get_parent(){
	return creator
}

function object_array_get_x_input(array_creator_optional){
	if(array_creator_optional == undefined)
	{
		array_creator_optional = creator
	}
	
	return array_creator_optional.object_DAS_input_x
}

function object_array_get_y_input(array_creator_optional){
	if(array_creator_optional == undefined)
	{
		array_creator_optional = creator
	}
	
	return array_creator_optional.object_DAS_input_y
}

///@desc renders/manages a object_array created with the object_array_create script
///@arg input_x
///@arg input_y
///@arg [change_sound]
function object_array_manage()
{
	//set up variables
	var w = array_length(object_array)
	
	var input_x = round(argument[0])
	var input_y = round(argument[1])
	var sound = -1
	
	if(argument_count > 2)
	{
		sound = argument[2]
	}
	
	selectedtimer++
	
	//get das for both axes, apply input to selection menu if unlocked
	//x input
	object_DAS_input_x = 0
	if(input_x != 0)
	{
		if	((object_DAS_timer_x == 0) || //if DAS timer is zero, push one
			(object_DAS_timer_x >= object_DAS_delay && //or if DAS timer is more than delay
			((object_DAS_timer_x - object_DAS_delay) mod object_DAS_speed) == 0)) //and it's ready to push again
		{
			object_DAS_input_x = input_x
		}
		
		object_DAS_timer_x++
	}
	else
	{
		object_DAS_timer_x = 0
	}
	
	//y input
	object_DAS_input_y = 0
	if(input_y != 0)
	{
		if	((object_DAS_timer_y == 0) || //if DAS timer is zero, push one
			(object_DAS_timer_y >= object_DAS_delay && //or if DAS timer is more than delay
			((object_DAS_timer_y - object_DAS_delay) mod object_DAS_speed) == 0)) //and it's ready to push again
		{
			object_DAS_input_y = input_y
		}
		
		object_DAS_timer_y++
	}
	else
	{
		object_DAS_timer_y = 0
	}
	
	//selecting
	if(object_DAS_input_y != 0 && select_index != -1 && !object_array_locked)
	{
		//find the next available index, but if it's by DAS don't let it wraparound
		var temp_index;
		if(object_DAS_timer_y >= object_DAS_delay)
		{
			//if running by DAS (to make it stop at the end)
			temp_index = clamp(select_index + input_y, 0, w - 1)
		}
		else
		{
			//if running by initial push
			temp_index = Wrap(select_index + input_y, 0, w - 1)
		}
		
		//if it's the same, just do nothing
		//if it's different, do the cool things
		if(temp_index != select_index)
		{
			select_index = temp_index
			
			//reset the timer
			selectedtimer = 0
			
			//if we can play a sound, play one
			if(sound != -1)
			{
				audio_play_sound(sound, 10, false)
			}
		}
	}
	
	//do active sets and sticks and offsets because they're useful
	for(var i = 0; i < w; i++)
	{ 
		object_array[i].active = (i == select_index)
		
		with(object_array[i])
		{
			if(creator.object_array_do_stick) stick_to_angle(creator, object_array_xoff, object_array_yoff, 0)
			
			x += x_offset
			y += y_offset
		}
	}
}

function object_array_set_locked(lock, array_creator)
{
	if(array_creator == undefined) array_creator = creator
	array_creator.object_array_locked = lock
}