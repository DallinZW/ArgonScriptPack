/// @description Change palette with up/down (Gradual)
/// @function Change palette with up/down 
/// @param Gradual
if(keyboard_check(vk_up)  || gamepad_button_check_pressed(0,gp_padu))
    current_pal+=.05* delta_time * (60/1000000);
if(keyboard_check(vk_down)  || gamepad_button_check_pressed(0,gp_padd))
    current_pal-=.05* delta_time * (60/1000000);

current_pal=clamp(current_pal,0,pal_swap_get_pal_count(my_pal_sprite)-1);
var _tree_id=layer_get_id("Trees");
var _clutter_id=layer_get_id("Clutter");


//After enabling pall swapping on these layers in the room start event
//we can use it.  Disable it by pressing space.
if(keyboard_check(vk_space)  || gamepad_button_check(0,gp_padr))
{
  pal_swap_set_layer(my_pal_sprite,0,_tree_id,false);
	pal_swap_set_layer(my_pal_sprite,0,_clutter_id,false);
}
else
{
  pal_swap_set_layer(my_pal_sprite,current_pal,_tree_id,false);
	pal_swap_set_layer(my_pal_sprite,current_pal,_clutter_id,false);
}