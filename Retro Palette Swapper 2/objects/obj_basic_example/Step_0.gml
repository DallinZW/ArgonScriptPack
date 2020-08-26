/// @description Change palette with up/down (Basic)
/// @function Change palette with up/down 
/// @param Basic
if(keyboard_check_pressed(vk_up)  || gamepad_button_check_pressed(0,gp_padu))
    current_pal++;
if(keyboard_check_pressed(vk_down)  || gamepad_button_check_pressed(0,gp_padd))
    current_pal--;

current_pal=wrap(current_pal,0,pal_swap_get_pal_count(my_pal_sprite)-1);

