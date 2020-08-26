/// @description Change palette with up/down (Gradual)
/// @function Change palette with up/down 
/// @param Gradual
if(keyboard_check(vk_up)  || gamepad_button_check(0,gp_padu))
    current_pal+=.05* delta_time * (60/1000000);
if(keyboard_check(vk_down)  || gamepad_button_check(0,gp_padd))
    current_pal-=.05* delta_time * (60/1000000);

current_pal=clamp(current_pal,0,pal_swap_get_pal_count(my_pal_sprite)-1);


