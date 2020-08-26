/// @description Draw With Palette Swap    

pal_swap_set(my_pal_sprite,current_pal,false);
    draw_sprite_ext(sprite_index,image_index,x+spacing*image_xscale,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
pal_swap_reset();
                     
//Draw Original for comparison.
draw_sprite_ext(sprite_index,image_index,x-spacing*image_xscale,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);


