/// @description Change palette with up/down (Basic)
/// @function Change palette with up/down 
/// @param Basic
if(keyboard_check_pressed(vk_up)  || gamepad_button_check_pressed(0,gp_padu))
    current_pal++;
if(keyboard_check_pressed(vk_down)  || gamepad_button_check_pressed(0,gp_padd))
    current_pal--;

current_pal=wrap(current_pal,0,pal_swap_get_pal_count(my_pal_sprite)-1);


///Desaturate current palette with custom palette.
var _build_pal=false;
if(keyboard_check(vk_space)  || gamepad_button_check(0,gp_padr))
{
    _build_pal=true;
    
    override_pal_index=clamp(override_pal_index+.01* delta_time * (60/1000000),1,2);
}
else
{
    override_pal_index=clamp(override_pal_index-.01* delta_time * (60/1000000),1,2);
    if(override_pal_index>1)
        _build_pal=true;
}

if(_build_pal)
{
    if(!surface_exists(override_surface))
        override_surface=surface_create(64,64);
    surface_set_target(override_surface);
    {   //Build Palette
        pal_swap_draw_palette(my_pal_sprite,0,0,0); //Draw Base Palette
        //Set current palette as palette "1";
        pal_swap_draw_palette(my_pal_sprite,current_pal,1,0);
        //Build Custom palette as palette "2";  
				//Try replacing with different color manipulation shaders!
        shader_set(shd_grayscale); 
        pal_swap_draw_palette(my_pal_sprite,current_pal,2,0);
        shader_reset();
    }
    surface_reset_target();
}   

