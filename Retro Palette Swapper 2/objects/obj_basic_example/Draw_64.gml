/// @description Instructions
draw_set_font(fnt_instructions);
draw_set_text_alignment(7,c_white);
draw_text(20.5,20.5,"Press UP and DOWN to shift colors"+
             "\nPress Enter to proceed to next example");
draw_set_font(fnt_title);						 
draw_set_text_alignment(5,c_white);
draw_text(room_width/2,room_height-40,"Basic Palette Swap");
///Draw With Palette Swap     
pal_swap_set(my_pal_sprite,current_pal,false);
    draw_sprite_ext(sprite_index,image_index,x+spacing*image_xscale,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
pal_swap_reset();
                     
//Draw Original for comparison.
draw_sprite_ext(sprite_index,image_index,x-spacing*image_xscale,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);


///Draw Palette
var _pal_scale=8;
var _yoff=-15*_pal_scale
var _xoff=(pal_swap_get_pal_count(my_pal_sprite)*.5)*_pal_scale;
draw_sprite_ext(my_pal_sprite,0,x-_xoff,y+_yoff,_pal_scale,_pal_scale,0,c_white,1);
    
//Draw a rectangle around the current palette.
draw_set_color(c_green);
draw_rectangle(x-_xoff+_pal_scale*current_pal,y+_yoff,x-_xoff+_pal_scale*current_pal+_pal_scale,y+_yoff+pal_swap_get_color_count(my_pal_sprite)*_pal_scale,true);

