///@desc renders/manages a menu created with the menu_add script
///@arg buffer
///@arg subbuffer
///@arg input_x
///@arg input_y
///@arg confirm
///@arg [change_sound]
///@arg [confirm_sound]
function menu_render_stacked_center() {

#region //set up the variables
var h = 0;
var str = "";
var w = array_length(menu_array)

var buffer = argument[0]
var subbuffer = argument[1]
var input_x = round(argument[2])
var input_y = round(argument[3])
var confirm = argument[4]
var sound = -1
var confirmsound = -1
if(argument_count > 5)
{
	sound = argument[5]
	confirmsound = argument[6]
}
#endregion

#region //update selected variables
	selectedtimer++

	//only let it change if the menu hasn't been confirmed yet
	if(!menu_confirmed)
	{
		if(input_y != 0 && select_index != -1)
		{
			if	(menu_DAS_timer_y == 0) || //if DAS timer is zero, push one
				(menu_DAS_timer_y >= menu_DAS_delay) && //or if DAS timer is more than delay
				((menu_DAS_timer_y - menu_DAS_delay) mod menu_DAS_speed == 0) //and it's ready to push again
			{
				//find the next available index, but if it's by DAS don't let it wraparound
				var temp_index = 0
				if(menu_DAS_timer_y >= menu_DAS_delay)
				{
					//if running by DAS
					var ptemp_index = 0
					temp_index = clamp(select_index + input_y, 0, w - 1)
					while(menu_array[temp_index][MENUDATA.SCRIPT] == -1)
					{
						//set prev to temp
						ptemp_index = temp_index
				
						//update temp, clamped within the bounds
						temp_index = clamp(temp_index + input_y, 0, w - 1)
				
						//if temp is the same as it was before, we've hit the bounds, break out
						if(ptemp_index == temp_index)
						{
							temp_index = select_index;
							break;
						}
					}
			
				}
				else
				{
					//if running by initial push
					//reset bump timer
					menu_bump_timer_y = 0
					temp_index = Wrap(select_index + input_y, 0, w - 1)
		
					//loop until we find a non-blank one
					while(menu_array[temp_index][MENUDATA.SCRIPT] == -1)
					{
						temp_index = Wrap(temp_index + input_y, 0, w - 1)
					}
				}
		
				//if it's the same, just do nothing
				//if it's different, do the cool things
				if(temp_index != select_index)
				{
					//reset bump timer
					menu_bump_timer_y = 0
			
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
	
			//increase the button held timer
			menu_DAS_timer_y++;
		}
		else
		{
			menu_DAS_timer_y = 0
		}
	}
#endregion

#region //draw the text
	for(var i = 0; i < w; i++)
	{
		//get string
		str = menu_array[i][MENUDATA.STRING]

		DrawSetText(menu_array[i][MENUDATA.COLOR], menu_array[i][MENUDATA.FONT], fa_center, fa_middle)
	
		//if we're selecting this index or not
		if(!(i == select_index))
		{
			//not selected, draw text
			draw_text(x, y + h, str)
			
			h += string_height(str) + buffer
		
			//check if it's a variable value
			if(is_string(menu_array[i][MENUDATA.SCRIPT]))
			{
				//it is a variable value
				h -= buffer - subbuffer
				
				//set text horizontal alignment
				draw_set_halign(fa_center)
				
				var value, minlimit, maxlimit
				//check if it's variable number style or array scrolling style
				if(is_array(menu_array[i][MENUDATA.MIN_VALUE]))
				{
					//it's array style
					var string_array = menu_array[i][MENUDATA.MIN_VALUE]
					var value_array = menu_array[i][MENUDATA.MAX_VALUE]
					
					value = string_array[menu_array[i][MENUDATA.STEP_SIZE]]
					
					minlimit = string_array[0]
					maxlimit = string_array[array_length(string_array) - 1]
				}
				else
				{
					//it's number style
					value = variable_global_get(menu_array[i][MENUDATA.SCRIPT])
					
					minlimit = menu_array[i][MENUDATA.MIN_VALUE]
					maxlimit = menu_array[i][MENUDATA.MAX_VALUE]
				}
				
				if(!is_string(value)) value = string(value)
				
				//draw text at x + variableoffset, y + h
				draw_text(x, y + h, value)
			
				//draw the arrows at prev position -/+ arrowdisplacement with tints if they're possible
				var arrowalpha = 1;
				draw_set_color(c_white)
				if(value == minlimit)
				{
					arrowalpha = menu_disabled_alpha
				}
				draw_sprite_ext(menu_arrows[0], 0, x - menu_array[i][MENUDATA.MAX_VALUE_WIDTH]/2 - sprite_get_width(menu_arrows[0]) * 2, y + h, 1, 1, 0, c_white, arrowalpha)
			
				arrowalpha = 1
				if(value == maxlimit)
				{
					arrowalpha = menu_disabled_alpha
				}
				draw_sprite_ext(menu_arrows[1], 0, x + menu_array[i][MENUDATA.MAX_VALUE_WIDTH]/2 + sprite_get_width(menu_arrows[0]) * 2, y + h, 1, 1, 0, c_white, arrowalpha)
				
				h += string_height(value) + buffer
			}
		}
		else
		{
			//selected
			draw_set_color(menu_array[i][MENUDATA.SELECTCOLOR])
		
			//figure out bump
			var yoff = 0;
			if(menu_bump_timer_y < menu_bump_time_y)
			{
				//update timer
				menu_bump_timer_y++
		
				yoff = sin(pi * menu_bump_timer_y / menu_bump_time_y) * menu_bump_size_y
			}
		
			//draw the text finally
			draw_text(x, y + yoff + h, str)
		
			//draw the pointer
			if(menu_pointer_sprite != -1)
			{
				draw_sprite(menu_pointer_sprite, 0, x - string_width(menu_array[i][MENUDATA.STRING]) / 2 - sprite_get_width(menu_pointer_sprite) * 2, y + h)
			}
			
			h += string_height(str) + buffer
		
			//check if it's variable value
			if(is_string(menu_array[i][MENUDATA.SCRIPT]))
			{
				//it is a variable value
				h -= buffer - subbuffer
			
				//set text horizontal alignment 
				draw_set_halign(fa_center)
				
				//initialize some variables
				var value, minlimit, maxlimit
				
				//check if it's array style or number style
				if(is_array(menu_array[i][MENUDATA.MIN_VALUE]))
				{
					//it's array style
					var string_array = menu_array[i][MENUDATA.MIN_VALUE]
					var value_array = menu_array[i][MENUDATA.MAX_VALUE]

					
					minlimit = string_array[0]
					maxlimit = string_array[array_length(string_array) - 1]
			
					//update array position based on input (using DAS)
					if(input_x != 0) && (menu_array[i][MENUDATA.STEP_SIZE] + input_x >= 0) && (menu_array[i][MENUDATA.STEP_SIZE] + input_x <= array_length(string_array) - 1)
					{
						if	(menu_DAS_timer_x == 0) || //if DAS timer is zero, push one
							(menu_DAS_timer_x >= menu_DAS_delay) && //or if DAS timer is more than delay
							((menu_DAS_timer_x - menu_DAS_delay) mod menu_DAS_speed == 0) //and it's ready to push again, push one
						{
							//update menu_array index
							menu_array[i][MENUDATA.STEP_SIZE] += input_x
					
							//update bump timer stuffs
							menu_bump_timer_x = 0
							menu_bump_dir_x = input_x
					
							//update the actual variable based on menu_array index
							variable_global_set(menu_array[i][MENUDATA.SCRIPT], value_array[menu_array[i][MENUDATA.STEP_SIZE]])
					
							//play the fun sound
							if(sound != -1)
							{
								audio_play_sound(sound, 10, false)
							}
						}
						menu_DAS_timer_x++;
					}
					else
					{
						menu_DAS_timer_x = 0
					}
					
					value = string_array[menu_array[i][MENUDATA.STEP_SIZE]]
					
					
				
					show_debug_message(menu_array[i][MENUDATA.MAX_VALUE_WIDTH])
					var arr = menu_array[i][MENUDATA.MIN_VALUE]
					show_debug_message(string_width(arr[menu_array[i][MENUDATA.STEP_SIZE]]))
					show_debug_message(arr[menu_array[i][MENUDATA.STEP_SIZE]])
				}
				else
				{
					//it's number style
					value = variable_global_get(menu_array[i][MENUDATA.SCRIPT])
					var _step = menu_array[i][MENUDATA.STEP_SIZE]
				
					minlimit = menu_array[i][MENUDATA.MIN_VALUE]
					maxlimit = menu_array[i][MENUDATA.MAX_VALUE]
			
					//update array position based on input (using DAS)
					if(input_x != 0) && (value + input_x >= minlimit) && (value + input_x <= maxlimit)
					{
						if	(menu_DAS_timer_x == 0) || //if DAS timer is zero, push one
							(menu_DAS_timer_x >= menu_DAS_delay) && //or if DAS timer is more than delay
							((menu_DAS_timer_x - menu_DAS_delay) mod menu_DAS_speed == 0) //and it's ready to push again, push one
						{
							//update menu_array index
							value += input_x * _step
					
							//update bump timer stuffs
							menu_bump_timer_x = 0
							menu_bump_dir_x = input_x
					
							//update the actual variable based on menu_array index
							variable_global_set(menu_array[i][MENUDATA.SCRIPT], value)
					
							//play the fun sound
							if(sound != -1)
							{
								audio_play_sound(sound, 10, false)
							}
						}
						menu_DAS_timer_x++;
					}
					else
					{
						menu_DAS_timer_x = 0
					}
					
					
				}
				
				//calculate bump
				var xoff = 0
				if(menu_bump_timer_x < menu_bump_time_x)
				{
					//update timer
					menu_bump_timer_x++
		
					xoff = menu_bump_dir_x * sin(pi * menu_bump_timer_x / menu_bump_time_x) * menu_bump_size_x
				}
				
				if(!is_string(value)) value = string(value)
				
				//draw text at x + variableoffset, y + h
				draw_text(x + xoff, y + h + yoff, value)
			
				//draw the arrows at prev position -/+ arrowdisplacement with tints if they're possible
				var arrowalpha = 1;
				draw_set_color(c_white)
				if(value == minlimit)
				{
					arrowalpha = menu_disabled_alpha
				}
				draw_sprite_ext(menu_arrows[0], 0, x - menu_array[i][MENUDATA.MAX_VALUE_WIDTH]/2 - sprite_get_width(menu_arrows[0]) * 2 + (xoff * (menu_bump_dir_x == -1)), y + h, 1, 1, 0, c_white, arrowalpha)
			
				arrowalpha = 1
				if(value == maxlimit)
				{
					arrowalpha = menu_disabled_alpha
				}
				draw_sprite_ext(menu_arrows[1], 0, x + menu_array[i][MENUDATA.MAX_VALUE_WIDTH]/2 + sprite_get_width(menu_arrows[1]) * 2 + (xoff * (menu_bump_dir_x == 1)), y + h , 1, 1, 0, c_white, arrowalpha)
				
				h += string_height(value) + buffer
				
			}
			else
			{
				//it aint a variable value
				if(confirm)
				{
					if(confirmsound != -1)
					{
						audio_play_sound(confirmsound, 10, false)
					}
					menu_bump_timer_y = 0
					menu_confirmed = true
				}
			}
		}
	}
	#endregion

	if(menu_confirmed) && (menu_bump_timer_y >= menu_bump_time_y)
	{
		menu_array[select_index][1]()
		menu_confirmed = false
	}
}