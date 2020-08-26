// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function auto_array_create(min_val, max_val, step_val, do_string){
	var array = []
	for(var i = 0; i <= (max_val - min_val)/step_val; i++)
	{
		val = min_val + (i * step_val)
		if(do_string)
		{
			array[i] = string(val)
		}
		else
		{
			array[i] = val
		}
	}
	return array
}