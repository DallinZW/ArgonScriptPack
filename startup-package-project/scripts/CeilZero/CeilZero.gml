///@desc rounds a number away from 0
///@arg x
function CeilZero(argument0) {

	if(argument0 == 0)
	{
		return 0
	}
	else
	{
		if(sign(argument0) > 0)
		{
			return ceil(argument0)
		}
		else
		{
			return floor(argument0)
		}
	}


}
