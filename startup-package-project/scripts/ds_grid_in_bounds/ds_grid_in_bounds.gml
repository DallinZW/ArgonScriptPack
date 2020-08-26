///@desc checks if a position is within the boundaries of a given ds_grid
///@arg grid
///@arg x
///@arg y
function ds_grid_in_bounds(argument0, argument1, argument2) {

	if(clamp(argument1, 0, ds_grid_width(argument0) - 1) != argument1) || (clamp(argument2, 0, ds_grid_height(argument0) - 1) != argument2)
	{
		return false
	}
	else
	{
		return true
	}


}
