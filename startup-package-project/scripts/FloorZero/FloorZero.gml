///@desc rounds a number towards 0
///@arg x
function FloorZero(argument0) {

	if(argument0 == 0)
	{
		return 0
	}
	else
	{
		if(sign(argument0) > 0)
		{
			return floor(argument0)
		}
		else
		{
			return ceil(argument0)
		}
	}


}
