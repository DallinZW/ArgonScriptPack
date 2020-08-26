function CamY() {
	if(argument_count > 0) var cam_id = argument[0]; else var cam_id = 0
	return camera_get_view_y(view_camera[cam_id])


}
