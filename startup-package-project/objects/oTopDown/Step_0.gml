vel[0] = walksp * input_value(p_id, input_values.horizontal)
vel[1] = walksp * input_value(p_id, input_values.vertical)

move_and_contact_tiles(collision, TILESIZE, vel)

show_debug_message("x = " + string(x) + ", y = " + string(y))