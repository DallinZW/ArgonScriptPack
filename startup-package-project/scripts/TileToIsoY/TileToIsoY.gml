///@arg tileX
///@arg tileY
///@arg isoHeight
function TileToIsoY(argument0, argument1, argument2) {

	//(tileX and tileY are grid position, not world space)
	return (argument0 + argument1) * (argument2 * 0.5)


}
