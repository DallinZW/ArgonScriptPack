//set grounded (make sure we're on the tile, but not in it (eg, a gradual buffer))
grounded = tile_collide_at_side(collision, TILESIZE, SIDE.BOTTOM, 1, 0, 0)
			
onwall_left = tile_collide_at_side(collision, TILESIZE, SIDE.LEFT, 1, 0, 0)
onwall_right = tile_collide_at_side(collision, TILESIZE, SIDE.RIGHT, 1, 0, 0)

//decrease jump buffer
jump_buffer = clamp(jump_buffer - 1, 0, jump_buffer_max)
if(input_pressed(p_id, input_action.jump)) jump_buffer = jump_buffer_max

switch(state)
{
	case "idle":
	{
		//set variables at frame 0
		if(statetimer == 1)
		{
			coyote_time = coyote_time_max
		}
		
		var inp = input_value(p_id, input_values.horizontal)
		
		//convert to other states
		if(jump_buffer > 0)
		{
			StateSwitch("jumping")
		}
		else if (!grounded)
		{
			StateSwitch("falling")
		}
		else if (inp != 0)
		{
			StateSwitch("walking")
		}
		break;
	}
	case "walking":
	{
		//set variables at frame 0
		if(statetimer == 1)
		{
			coyote_time = coyote_time_max
		}
		
		//do horizontal movement
		var inp = input_value(p_id, input_values.horizontal)
		var modifier;
		if(abs(vel[0]) < abs(walksp * inp))
		{
			modifier = accel
		}
		else
		{
			modifier = decel
		}
		vel[0] = Approach(vel[0], walksp * inp, modifier)
		
		//convert to other states
		if(jump_buffer)
		{
			StateSwitch("jumping")
		}
		else if(!grounded)
		{
			StateSwitch("falling")
		}
		else if(vel[0] == 0)
		{
			StateSwitch("idle")
		}
		break;
	}
	case "jumping":
	{
		//set variables at frame 0
		if(statetimer == 1)
		{
			grounded = false
			coyote_time = 0
			jump_buffer = 0
			vel[1] = -jumpsz
			variable_jump = variable_jump_max
		}
		
		//do horizontal movement
		var inp = input_value(p_id, input_values.horizontal)
		vel[0] = Approach(vel[0], walksp * inp, aircontrol)
		
		var _grv = grv
		//do vertical movement
		if(!input_held(p_id, input_action.jump))
		{
			variable_jump = 0
		}
		//also, we can use this for halved gravity jump peak
		else if (abs(vel[1]) <= abs(half_grv_threshold))
		{
			_grv = grv/2
		}
		
		if(variable_jump > 0) && (abs(vel[1]) == abs(jumpsz))
		{
			variable_jump--
			
			vel[1] = clamp(-jumpsz, -maxvspeed, maxvspeed)
		}
		else
		{
			vel[1] = clamp(vel[1] - _grv, -maxvspeed, maxvspeed)
		}
		
		//convert to other states
		if(vel[1] > 0)
		{
			StateSwitch("falling")
		}
		if((sign(vel[0]) == -1 && onwall_left) || (sign(vel[0]) == 1 && onwall_right)) && (jump_buffer > 0)
		{
			StateSwitch("walljumping")
		}
		if(grounded)
		{
			if(vel[0] == 0)
			{
				StateSwitch("idle")
			}
			else
			{
				StateSwitch("walking")
			}
		}
		break;
	}
	case "falling":
	{
		//set variables at frame 0
		if(statetimer == 1)
		{
			
		}
		
		//update coyote time
		coyote_time = Approach(coyote_time, 0, 1)
		
		//do horizontal movement
		var inp = input_value(p_id, input_values.horizontal)
		vel[0] = Approach(vel[0], walksp * inp, aircontrol)
		
		//halved gravity jump peak
		var _grv = grv
		if (abs(vel[1]) <= abs(half_grv_threshold)) && input_held(p_id, input_action.jump)
		{
			_grv = grv/2
		}
		
		//do vertical movement
		vel[1] = clamp(vel[1] - _grv, -maxvspeed, clamp(maxvspeed + max(0, grv_speed_mod * input_value(p_id, input_values.vertical) * maxvspeed), -TILESIZE, TILESIZE))
		
		//if jump pressed
		if(jump_buffer > 0)
		{
			//convert to jumping if coyote time will let us
			if(coyote_time > 0)
			{
				StateSwitch("jumping")
			}
		}
		//other state switching
		else if(grounded)
		{
			if(vel[0] == 0)
			{
				StateSwitch("idle")
			}
			else
			{
				StateSwitch("walking")
			}
		}
		else //do wall jumps oh no
		{
			if((sign(vel[0]) == -1 && onwall_left) || (sign(vel[0]) == 1 && onwall_right))
			{
				StateSwitch("onwall")
			}
		}
		break;
	}
	case "onwall":
	{
		//frame one variable setting
		if(statetimer == 1)
		{
			if(onwall_left) jumpdir = -1
			if(onwall_right) jumpdir = 1
		}
		
		//do horizontal movement
		var inp = input_value(p_id, input_values.horizontal)
		vel[0] = Approach(vel[0], walksp * inp, aircontrol)
		
		//do vertical movement
		//vel[1] = clamp(vel[1] - wall_grv, -maxvspeed_wall, maxvspeed_wall)
		vel[1] = Approach(vel[1], maxvspeed_wall, wall_grv)
		
		//switch to other states
		if(grounded)
		{
			if(vel[0] == 0)
			{
				StateSwitch("idle")
			}
			else
			{
				StateSwitch("walking")
			}
		}
		else if(!onwall_left && jumpdir == -1) || (!onwall_right && jumpdir == 1)
		{
			if(onwall_left || onwall_right)
			{
				StateSwitch("onwall")
			}
			else
			{
				StateSwitch("falling")
			}
		}
		else if(jump_buffer > 0)
		{
			StateSwitch("walljumping")
		}
		break;
	}
	case "walljumping":
	{
		//frame one variable setting
		if(statetimer == 1)
		{
			if(onwall_left) jumpdir = -1
			if(onwall_right) jumpdir = 1
			
			vel[0] = wall_jump_xsize * jumpdir * -1
			vel[1] = -wall_jump_ysize
			
			grounded = false
			coyote_time = 0
			jump_buffer = 0
			variable_jump = variable_jump_max
		}
		
		//do horizontal movement
		var inp = input_value(p_id, input_values.horizontal)
		vel[0] = Approach(vel[0], walksp * inp, aircontrol)
		
		var _grv = grv
		
		//do vertical movement
		if(!input_held(p_id, input_action.jump))
		{
			variable_jump = 0
		}
		
		//also, we can use this for halved gravity jump peak
		else if (abs(vel[1]) <= abs(half_grv_threshold))
		{
			_grv = grv/2
		}
		
		if(variable_jump > 0) && (abs(vel[0]) == abs(wall_jump_xsize))
		{
			variable_jump--
			
			vel[0] = clamp(wall_jump_xsize * jumpdir * -1, -maxvspeed, maxvspeed)
			vel[1] = clamp(-wall_jump_ysize, -maxvspeed, maxvspeed)
		}
		else
		{
			vel[1] = clamp(vel[1] - _grv, -maxvspeed, maxvspeed)
		}
		
		//switch back to other states
		if(vel[1] > 0)
		{
			StateSwitch("falling")
		}
		else if(grounded)
		{
			if(vel[0] == 0)
			{
				StateSwitch("idle")
			}
			else
			{
				StateSwitch("walking")
			}
		}
		break;
	}
}
statetimer++

//move
gradual_change_position = move_and_contact_tiles_buffer_gradual(collision, TILESIZE, vel, 0.3, 4, 4, 2, 2, 2, 2, 1, 1)