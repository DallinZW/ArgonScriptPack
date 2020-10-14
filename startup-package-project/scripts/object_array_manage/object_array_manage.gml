// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function object_array_manage(){

}///@desc renders/manages a object_array created with the object_array_create script
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