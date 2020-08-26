/// @description mouse_over()
///Returns true if cursor is within object's bounding box
function mouse_over() {
	return (mouse_x >= bbox_left &&
	        mouse_x <= bbox_right &&
	        mouse_y >= bbox_top &&
	        mouse_y <= bbox_bottom);



}
