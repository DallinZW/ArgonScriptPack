///@desc draws rectangle with the cooldown circle thin
///@arg x1
///@arg y1
///@arg x2
///@arg y2
///@arg value1
///@arg value2
///@arg sprite
function draw_rectangle_cd_texture(argument0, argument1, argument2, argument3, argument4, argument5, argument6) {

	var v1, v2, x1, x2, y1, y2, xm, ym, vd, vx1, vy1, vx2, vy2, vl;

	v1 = min(argument4, argument5)
	v2 = max(argument4, argument5)

	if(v2 <= 0 || v1 >= 1 || v1 == v2) return 0 //nothing to be drawn

	//top left corner
	x1 = argument0;
	y1 = argument1;

	//bottom right corner
	x2 = argument2;
	y2 = argument3;

	if(v1 <= 0 && v2 >= 1) return draw_rectangle(x1, y1, x2, y2, false) //all the way filled

	//middle point
	xm = (x1 + x2)/2;
	ym = (y1 + y2)/2;

	//lets go
	draw_primitive_begin_texture(pr_trianglefan, sprite_get_texture(argument6, 0))

	draw_vertex_texture(xm, ym, 0.5, 0.5) //middle vertex

	//calc angle and vector from value 1
	vd = pi * (v1 * 2 - 0.5)
	vx1 = cos(vd)
	vy1 = sin(vd)

	//normalize vector
	vl = max(abs(vx1), abs(vy1))
	if(vl < 1)
	{
		vx1 /= vl
		vy1 /= vl
	}

	//draw value 1 vertex
	draw_vertex_texture(xm + vx1 * (x2 - x1) / 2, ym + vy1 * (y2 - y1) / 2, (vx1 + 1) / 2, (vy1 + 1) / 2)

	//draw corners as far as you can draw them
	if(v1 <= 1/8 && v2 >= 1/8) draw_vertex_texture(x2, y1, 1, 0)
	if(v1 <= 3/8 && v2 >= 3/8) draw_vertex_texture(x2, y2, 1, 1)
	if(v1 <= 5/8 && v2 >= 5/8) draw_vertex_texture(x1, y2, 0, 1)
	if(v1 <= 7/8 && v2 >= 7/8) draw_vertex_texture(x1, y1, 0, 0)

	//calc angle and vector from value 2
	vd = pi * (v2 * 2 - 0.5)
	vx2 = cos(vd)
	vy2 = sin(vd)

	//normalize vector
	vl = max(abs(vx2), abs(vy2))
	if(vl < 1)
	{
		vx2 /= vl
		vy2 /= vl
	}

	draw_vertex_texture(xm + vx2 * (x2 - x1) / 2, ym + vy2 * (y2 - y1) / 2, (vx2 + 1) / 2, (vy2 + 1) / 2)
	draw_primitive_end()


}
