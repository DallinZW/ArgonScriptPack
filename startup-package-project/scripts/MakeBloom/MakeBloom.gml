///@desc makes a given surface bloom
///@arg surfping
///@arg surfpong
///@arg bloom_threshold
function MakeBloom(argument0, argument1, argument2) {

	var surfPing = argument0
	var surfPong = argument1

	shader_set(shLuminanceCutoff);
		shader_set_uniform_f(shader_get_uniform(shLuminanceCutoff, "bloom_threshold"), argument2)
	
		surface_set_target(surfPing)
			draw_surface(application_surface, 0, 0)
		surface_reset_target()
	shader_set(shBlur)
		shader_set_uniform_f(shader_get_uniform(shBlur, "blur_steps"), 10);
		shader_set_uniform_f(shader_get_uniform(shBlur, "sigma"), 0.4)
		shader_set_uniform_f(shader_get_uniform(shBlur, "blur_vector"), 1, 0)
		shader_set_uniform_f(shader_get_uniform(shBlur, "texel_size"), 1/surface_get_width(surfPing), 1/surface_get_height(surfPing))
	
		surface_set_target(surfPong)
			draw_surface(surfPing, 0, 0)
		surface_reset_target()
	
		shader_set_uniform_f(shader_get_uniform(shBlur, "blur_vector"), 0, 1)
		surface_set_target(surfPing)
			draw_surface(surfPong, 0, 0)
		surface_reset_target()
	shader_reset()

	gpu_set_blendmode(bm_add)
	draw_surface(surfPing, 0, 0)
	gpu_set_blendmode(bm_normal)


}
