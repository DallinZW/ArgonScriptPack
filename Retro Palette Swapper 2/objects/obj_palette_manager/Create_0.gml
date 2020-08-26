/// @description Initilize System and add palettes

//This should be done before any drawing takes place 
//in a managing object that will persist through the entire game.
//Notice I've set it to persistent.  

//First Init the System, specify the name of the pal swap shader in case you've changed it for some reason.

pal_swap_init_system(shd_pal_swapper,shd_pal_html_sprite,shd_pal_html_surface);
#macro spacing 128
#macro pal_spacing 256


