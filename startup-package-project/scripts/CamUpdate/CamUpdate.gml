///@arg clamp
///@arg follow
function CamUpdate(argument0, argument1) {
	x += (argument1.x - x) / speedfactor
	y += (argument1.y - y) / speedfactor
	CamSetPos(argument0)


}
