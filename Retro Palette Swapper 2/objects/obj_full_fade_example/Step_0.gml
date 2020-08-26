/// @description Change palette with up/down (Basic)
/// @function Change palette with up/down 
/// @param Basic
if(keyboard_check_pressed(vk_up)  || gamepad_button_check_pressed(0,gp_padu))
    current_pal++;
if(keyboard_check_pressed(vk_down)  || gamepad_button_check_pressed(0,gp_padd))
    current_pal--;

current_pal=wrap(current_pal,0,pal_swap_get_pal_count(my_pal_sprite)-1);

///Fade to solid color With Override Pal when space pressed.
var _build_pal=false;
if(keyboard_check(vk_space)   || gamepad_button_check(0,gp_padr))
{   //Let's fade!
    _build_pal=true;
    
    override_pal_index=clamp(override_pal_index+.01* delta_time * (60/1000000),1,2); 
    //This animates the fade by gradually moving from pal index 1 to pal index 2)
}
else
{
    override_pal_index=clamp(override_pal_index-.01* delta_time * (60/1000000),1,2);
    //This animates the fade back
    if(override_pal_index>1)
        _build_pal=true;
}

if(_build_pal)
{   //We are overriding the palette for fading.  Let's build a custom palette.
    if(!surface_exists(override_surface))
        override_surface=surface_create(64,64); //Create the override palette surface if it doesn't exist.
    surface_set_target(override_surface);
    {   //Build Palette
        pal_swap_draw_palette(my_pal_sprite,0,0,0); //Draw Base Palette to the surface
        //Set current palette as palette "1";
        pal_swap_draw_palette(my_pal_sprite,current_pal,1,0);
        //Build Custom palette as palette "2";
        draw_set_color(c_white);
        //Just drawing a line of white vertically down the surface.  
        draw_line(2,-1,2,sprite_get_height(my_pal_sprite) - !Pal_HTML5); //Draw_line apparently works a bit different on HTML5...
        
    }
    surface_reset_target();
}   

