///@desc renders/manages a menu created with the menu_add script
///@arg buffer
///@arg input_x
///@arg input_y
///@arg confirm
///@arg variable_offset
///@arg variable_arrows_displacement
///@arg [horizontal_offset]
///@arg [horizontal_offset_speed]
///@arg [change_sound]
///@arg [confirm_sound]
function menu_render_ext() {

#region //set up the variables
var h = 0;
var str = "";
var w = array_length(menu_array)

var buffer = argument[0]
var input_x = round(argument[1])
var input_y = round(argument[2])
var confirm = argument[3]
var variable_offset = argument[4]
var variable_arrows_displacement = argument[5]
var horizontal_offset = 0
var horizontal_offset_speed = 0
var sound = -1
var confirmsound = -1
if(argument_count > 7)
{
	horizontal_offset = argument[6]
	horizontal_offset_speed = argument[7]
	
	if(argument_count > 9)
	{
		sound = argument[8]
		confirmsound = argument[9]
	}
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

		DrawSetText(menu_array[i][MENUDATA.COLOR], menu_array[i][MENUDATA.FONT], fa_left, fa_middle)
	
		//if we're selecting this index or not
		if(!(i == select_index))
		{
			//not selected, draw text
			draw_text(x, y + h, str)
		
			//check if it's a variable value
			if(is_string(menu_array[i][MENUDATA.SCRIPT]))
			{
				//it is a variable value
				var value = variable_global_get(menu_array[i][MENUDATA.SCRIPT])
				
				var minlimit = menu_array[i][MENUDATA.MIN_VALUE]
				var maxlimit = menu_array[i][MENUDATA.MAX_VALUE]
			
				//set text horizontal alignment to middle
				draw_set_halign(fa_center)
			
				//draw text at x + variableoffset, y + h
				draw_text(x + variable_offset, y + h, value)
			
				//draw the arrows at prev position -/+ arrowdisplacement with tints if they're possible
				var arrowalpha = 1;
				draw_set_color(c_white)
				if(value == minlimit)
				{
					arrowalpha = menu_disabled_alpha
				}
				draw_sprite_ext(menu_arrows[0], 0, x + variable_offset - variable_arrows_displacement, y + h, 1, 1, 0, c_white, arrowalpha)
			
				arrowalpha = 1
				if(value == maxlimit)
				{
					arrowalpha = menu_disabled_alpha
				}
				draw_sprite_ext(menu_arrows[1], 0, x + variable_offset + variable_arrows_displacement, y + h, 1, 1, 0, c_white, arrowalpha)
			}
		}
		else
		{
			//selected
			draw_set_color(menu_array[i][MENUDATA.SELECTCOLOR])
		
			//figure out horizontal offset
			var xoff = 0;
			var yoff = 0;
			if(horizontal_offset > 0)
			{
				xoff = EaseOutCubic(min(selectedtimer, horizontal_offset_speed), 0, horizontal_offset, horizontal_offset_speed)
			}
		
			//figure out bump
			if(menu_bump_timer_y < menu_bump_time_y)
			{
				//update timer
				menu_bump_timer_y++
		
				yoff = sin(pi * menu_bump_timer_y / menu_bump_time_y) * menu_bump_size_y
			}
		
			//draw the text finally
			draw_text(x + xoff, y + yoff + h, str)
		
			//draw the pointer
			if(menu_pointer_sprite != -1)
			{
				draw_sprite(menu_pointer_sprite, 0, x, y + h)
			}
		
			//check if it's variable value
			if(is_string(menu_array[i][MENUDATA.SCRIPT]))
			{
				//it is a variable value
				var value = variable_global_get(menu_array[i][MENUDATA.SCRIPT])
				var _step = menu_array[i][MENUDATA.STEP_SIZE]
				
				var minlimit = menu_array[i][MENUDATA.MIN_VALUE]
				var maxlimit = menu_array[i][MENUDATA.MAX_VALUE]
			
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
			
				//calculate bump
				xoff = 0
				if(menu_bump_timer_x < menu_bump_time_x)
				{
					//update timer
					menu_bump_timer_x++
		
					xoff = menu_bump_dir_x * sin(pi * menu_bump_timer_x / menu_bump_time_x) * menu_bump_size_x
				}
			
				//set text horizontal alignment to middle
				draw_set_halign(fa_center)
			
				//draw text at x + variableoffset, y + h
				draw_text(x + variable_offset + xoff, y + h, value)
			
				//draw the arrows at prev position -/+ arrowdisplacement with tints if they're possible
				var arrowalpha = 1;
				draw_set_color(c_white)
				if(value == minlimit)
				{
					arrowalpha = menu_disabled_alpha
				}
				draw_sprite_ext(menu_arrows[0], 0, x + variable_offset - variable_arrows_displacement + (xoff * (menu_bump_dir_x == -1)), y + h, 1, 1, 0, c_white, arrowalpha)
			
				arrowalpha = 1
				if(value == maxlimit)
				{
					arrowalpha = menu_disabled_alpha
				}
				draw_sprite_ext(menu_arrows[1], 0, x + variable_offset + variable_arrows_displacement + (xoff * (menu_bump_dir_x == 1)), y + h, 1, 1, 0, c_white, arrowalpha)
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
		h += string_height(str) + buffer
	}
	#endregion

	if(menu_confirmed) && (menu_bump_timer_y >= menu_bump_time_y)
	{
		menu_array[select_index][1]()
		menu_confirmed = false
	}
}