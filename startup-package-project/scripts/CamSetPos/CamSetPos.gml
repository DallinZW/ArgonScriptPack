///@desc sets camera position
///@arg clamp
function CamSetPos(argument0) {

	if(argument0)
	{
		camera_set_view_pos(view_camera[0], clamp(x, CamWidth() / 2, room_width - CamWidth() / 2) - (camera_get_view_width(view_camera[0]) / 2), clamp(y, CamHeight() / 2, room_height - CamHeight() / 2) - (camera_get_view_height(view_camera[0]) / 2))
	}
	else
	{
		camera_set_view_pos(view_camera[0], x - (camera_get_view_width(view_camera[0]) / 2), y - (camera_get_view_height(view_camera[0]) / 2))
	}


}
