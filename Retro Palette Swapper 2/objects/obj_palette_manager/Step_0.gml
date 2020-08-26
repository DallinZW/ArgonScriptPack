if(room==_init) room_goto_next();

if(mouse_check_button_pressed(mb_left) || gamepad_button_check_pressed(0,gp_face1))
	event_perform(ev_keypress,vk_enter);