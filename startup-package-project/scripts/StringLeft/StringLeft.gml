///@arg str 
///@arg num
function StringLeft(argument0, argument1) {

	if(argument1 < 0){
		return string_copy(argument0, 1, string_length(argument0) + argument1);
	} else {
		return string_copy(argument0, 1, argument1);
	}


}
