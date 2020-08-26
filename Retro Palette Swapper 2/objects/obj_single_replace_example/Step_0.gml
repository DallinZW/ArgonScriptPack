/// @description Change palette with up/down (Basic)
/// @function Change palette with up/down 
/// @param Basic
if(keyboard_check_pressed(vk_up)  || gamepad_button_check_pressed(0,gp_padu))
    current_pal++;
if(keyboard_check_pressed(vk_down)  || gamepad_button_check_pressed(0,gp_padu))
    current_pal--;

current_pal=wrap(current_pal,0,pal_swap_get_pal_count(my_pal_sprite)-1);


///Hold Space to change the top color to red by using a custom palette.
var _build_pal=false;
if(keyboard_check(vk_space)  || gamepad_button_check(0,gp_padr))
{
    _build_pal=true;
    override_pal_index=clamp(override_pal_index+.05* delta_time * (60/1000000),1,2);
}
else
{
    override_pal_index=clamp(override_pal_index-.05* delta_time * (60/1000000),1,2);
    if(override_pal_index>1)
        _build_pal=true;
}
if(_build_pal)
{
    if(!surface_exists(override_surface))
		{
			if(Pal_HTML5)
				override_surface=surface_create(64,64);
			else
        override_surface=surface_create(3,sprite_get_height(my_pal_sprite));
		}
		surface_set_target(override_surface);
    {   //Build Palette
				draw_clear_alpha(0,0);
        pal_swap_draw_palette(my_pal_sprite,0,0,0); //Draw Base Palette
        //Set current palette as palette "1";
        pal_swap_draw_palette(my_pal_sprite,current_pal,1,0);
        //Build Custom palette as palette "2";
        pal_swap_draw_palette(my_pal_sprite,current_pal,2,0); //Since we want the palette to remain
        //largely the same, we'll just draw the current palette to the surface.
        draw_set_color(c_red);
        draw_point(2,0); //Now we are overriding color 0, 1, 2, and 3 in the third column with red.
				draw_point(2,1);
				draw_point(2,2);
				draw_point(2,3);
    }
    surface_reset_target();
}


