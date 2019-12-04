#define EaseLinear
/// EaseLinear(inputvalue,outputmin,outputmax,inputmax)

return argument2 * argument0 / argument3 + argument1;

#define EaseInQuad
/// EaseInQuad(inputvalue,outputmin,outputmax,inputmax)

argument0 /= argument3;
return argument2 * argument0 * argument0 + argument1;

#define EaseOutQuad
/// EaseOutQuad(inputvalue,outputmin,outputmax,inputmax)

argument0 /= argument3;
return -argument2 * argument0 * (argument0 - 2) + argument1;

#define EaseInOutQuad
/// EaseInOutQuad(inputvalue,outputmin,outputmax,inputmax)

argument0 /= argument3 * 0.5;

if (argument0 < 1)
{
    return argument2 * 0.5 * argument0 * argument0 + argument1;
}

return argument2 * -0.5 * (--argument0 * (argument0 - 2) - 1) + argument1;


#define EaseInCubic
/// EaseInCubic(inputvalue,outputmin,outputmax,inputmax)

return argument2 * power(argument0/argument3, 3) + argument1;

#define EaseOutCubic
/// EaseOutCubic(inputvalue,outputmin,outputmax,inputmax)

return argument2 * (power(argument0/argument3 - 1, 3) + 1) + argument1;

#define EaseInOutCubic
/// EaseInOutCubic(inputvalue,outputmin,outputmax,inputmax)

argument0 /= argument3 * 0.5;

if (argument0 < 1)
{
   return argument2 * 0.5 * power(argument0, 3) + argument1;
}

return argument2 * 0.5 * (power(argument0 - 2, 3) + 2) + argument1;

#define EaseInQuart
/// EaseInQuart(inputvalue,outputmin,outputmax,inputmax)

return argument2 * power(argument0 / argument3, 4) + argument1;

#define EaseOutQuart
/// EaseOutQuart(inputvalue,outputmin,outputmax,inputmax)

return -argument2 * (power(argument0 / argument3 - 1, 4) - 1) + argument1;

#define EaseInOutQuart
/// EaseInOutQuart(inputvalue,outputmin,outputmax,inputmax)

argument0 /= argument3 * 0.5;

if (argument0 < 1) 
{
    return argument2 * 0.5 * power(argument0, 4) + argument1;
}

return argument2 * -0.5 * (power(argument0 - 2, 4) - 2) + argument1;

#define EaseInQuint
/// EaseInQuint(inputvalue,outputmin,outputmax,inputmax)

return argument2 * power(argument0 / argument3, 5) + argument1;

#define EaseOutQuint
/// EaseOutQuint(inputvalue,outputmin,outputmax,inputmax)

return argument2 * (power(argument0 / argument3 - 1, 5) + 1) + argument1;

#define EaseInOutQuint
/// EaseInOutQuint(inputvalue,outputmin,outputmax,inputmax)

argument0 /= argument3 * 0.5;

if (argument0 < 1)
{
    return argument2 * 0.5 * power(argument0, 5) + argument1;
}

return argument2 * 0.5 * (power(argument0 - 2, 5) + 2) + argument1;

#define EaseInSine
/// EaseInSine(inputvalue,outputmin,outputmax,inputmax)

return argument2 * (1 - cos(argument0 / argument3 * (pi / 2))) + argument1;

#define EaseOutSine
/// EaseOutSine(inputvalue,outputmin,outputmax,inputmax)

return argument2 * sin(argument0 / argument3 * (pi / 2)) + argument1;

#define EaseInOutSine
 /// EaseInOutSine(inputvalue,outputmin,outputmax,inputmax)

return argument2 * 0.5 * (1 - cos(pi * argument0 / argument3)) + argument1;

#define EaseInCirc
/// EaseInCirc(inputvalue,outputmin,outputmax,inputmax)

argument0 /= argument3;
return argument2 * (1 - sqrt(1 - argument0 * argument0)) + argument1;

#define EaseOutCirc
/// EaseOutCirc(inputvalue,outputmin,outputmax,inputmax)

argument0 = argument0 / argument3 - 1;
return argument2 * sqrt(1 - argument0 * argument0) + argument1;

#define EaseInOutCirc
/// EaseInOutCirc(inputvalue,outputmin,outputmax,inputmax)

argument0 /= argument3 * 0.5;

if (argument0 < 1)
{
    return argument2 * 0.5 * (1 - sqrt(1 - argument0 * argument0)) + argument1;
}

argument0 -= 2;
return argument2 * 0.5 * (sqrt(1 - argument0 * argument0) + 1) + argument1;

#define EaseInExpo
/// EaseInExpo(inputvalue,outputmin,outputmax,inputmax)

return argument2 * power(2, 10 * (argument0 / argument3 - 1)) + argument1;

#define EaseOutExpo
/// EaseOutExpo(inputvalue,outputmin,outputmax,inputmax)

return argument2 * (-power(2, -10 * argument0 / argument3) + 1) + argument1;

#define EaseInOutExpo
/// EaseInOutExpo(inputvalue,outputmin,outputmax,inputmax)

argument0 /= argument3 * 0.5;

if (argument0 < 1) 
{
    return argument2 * 0.5 * power(2, 10 * --argument0) + argument1;
}

return argument2 * 0.5 * (-power(2, -10 * --argument0) + 2) + argument1;

#define EaseInElastic
/// EaseInElastic(inputvalue,outputmin,outputmax,inputmax)

var _s = 1.70158;
var _p = 0;
var _a = argument2;

if (argument0 == 0 || _a == 0) 
{
    return argument1; 
}

argument0 /= argument3;

if (argument0 == 1) 
{
    return argument1+argument2; 
}

if (_p == 0) 
{
    _p = argument3*0.3;
}

if (_a < abs(argument2)) 
{ 
    _a = argument2; 
    _s = _p*0.25; 
}
else
{
    _s = _p / (2 * pi) * arcsin (argument2 / _a);
}

return -(_a * power(2,10 * (--argument0)) * sin((argument0 * argument3 - _s) * (2 * pi) / _p)) + argument1;

#define EaseOutElastic
/// EaseOutElastic(inputvalue,outputmin,outputmax,inputmax)

var _s = 1.70158;
var _p = 0;
var _a = argument2;

if (argument0 == 0 || _a == 0)
{
    return argument1;
}

argument0 /= argument3;

if (argument0 == 1)
{
    return argument1 + argument2;
}

if (_p == 0)
{
    _p = argument3 * 0.3;
}

if (_a < abs(argument2)) 
{ 
    _a = argument2;
    _s = _p * 0.25; 
}
else 
{
    _s = _p / (2 * pi) * arcsin (argument2 / _a);
}

return _a * power(2, -10 * argument0) * sin((argument0 * argument3 - _s) * (2 * pi) / _p ) + argument2 + argument1;

#define EaseInOutElastic
/// EaseInOutElastic(inputvalue,outputmin,outputmax,inputmax)

var _s = 1.70158;
var _p = 0;
var _a = argument2;

if (argument0 == 0 || _a == 0)
{
    return argument1;
}

argument0 /= argument3*0.5;

if (argument0 == 2)
{
    return argument1+argument2; 
}

if (_p == 0)
{
    _p = argument3 * (0.3 * 1.5);
}

if (_a < abs(argument2)) 
{ 
    _a = argument2; 
    _s = _p * 0.25; 
}
else
{
    _s = _p / (2 * pi) * arcsin (argument2 / _a);
}

if (argument0 < 1)
{
    return -0.5 * (_a * power(2, 10 * (--argument0)) * sin((argument0 * argument3 - _s) * (2 * pi) / _p)) + argument1;
}

return _a * power(2, -10 * (--argument0)) * sin((argument0 * argument3 - _s) * (2 * pi) / _p) * 0.5 + argument2 + argument1;

#define EaseInBack
/// EaseInBack(inputvalue,outputmin,outputmax,inputmax)

var _s = 1.70158;

argument0 /= argument3;
return argument2 * argument0 * argument0 * ((_s + 1) * argument0 - _s) + argument1;

#define EaseOutBack
/// EaseOutBack(inputvalue,outputmin,outputmax,inputmax)

var _s = 1.70158;

argument0 = argument0/argument3 - 1;
return argument2 * (argument0 * argument0 * ((_s + 1) * argument0 + _s) + 1) + argument1;

#define EaseInOutBack
/// EaseInOutBack(inputvalue,outputmin,outputmax,inputmax)

var _s = 1.70158;

argument0 = argument0/argument3*2

if (argument0 < 1)
{
    _s *= 1.525;
    return argument2 * 0.5 * (argument0 * argument0 * ((_s + 1) * argument0 - _s)) + argument1;
}

argument0 -= 2;
_s *= 1.525

return argument2 * 0.5 * (argument0 * argument0 * ((_s + 1) * argument0 + _s) + 2) + argument1;

#define EaseInBounce
/// EaseInBounce(inputvalue,outputmin,outputmax,inputmax)

return argument2 - EaseOutBounce(argument3 - argument0, 0, argument2, argument3) + argument1

#define EaseOutBounce
/// EaseOutBounce(inputvalue,outputmin,outputmax,inputmax)

argument0 /= argument3;

if (argument0 < 1/2.75)
{
    return argument2 * 7.5625 * argument0 * argument0 + argument1;
}
else
if (argument0 < 2/2.75)
{
    argument0 -= 1.5/2.75;
    return argument2 * (7.5625 * argument0 * argument0 + 0.75) + argument1;
}
else
if (argument0 < 2.5/2.75)
{
    argument0 -= 2.25/2.75;
    return argument2 * (7.5625 * argument0 * argument0 + 0.9375) + argument1;
}
else
{
    argument0 -= 2.625/2.75;
    return argument2 * (7.5625 * argument0 * argument0 + 0.984375) + argument1;
}


#define EaseInOutBounce
/// EaseInOutBounce(inputvalue,outputmin,outputmax,inputmax)

if (argument0 < argument3*0.5) 
{
    return (EaseInBounce(argument0*2, 0, argument2, argument3)*0.5 + argument1);
}

return (EaseOutBounce(argument0*2 - argument3, 0, argument2, argument3)*0.5 + argument2*0.5 + argument1);

#define Approach
/// Approach(a, b, amount)

//moves "a" towards "b" by "amount" and returns a result
if (argument0 < argument1)
{
    argument0 += argument2;
    if (argument0 > argument1){
        return argument1;
	}
}
else
{
    argument0 -= argument2;
    if (argument0 < argument1){
        return argument1;
	}
}
return argument0;

#define Wave
/// Wave(from, to, duration, offset)
// Returns a value that will wave back and forth between [from-to] over [duration] seconds
// Examples
//      image_angle = Wave(-45,45,1,0)  -> rock back and forth 90 degrees in a second
//      x = Wave(-10,10,0.25,0)         -> move left and right quickly

// Or here is a fun one! Make an object be all squishy!! ^u^
//      image_xscale = Wave(0.5, 2.0, 1.0, 0.0)
//      image_yscale = Wave(2.0, 0.5, 1.0, 0.0)

a4 = (argument1 - argument0) * 0.5;
return argument0 + a4 + sin((((current_time * 0.001) + argument2 * argument3) / argument2) * (pi*2)) * a4;

#define Wrap
/// @description Wrap(value, min, max)
/// @function Wrap
/// @param value
/// @param min
/// @param max
// Returns the value wrapped, values over or under will be wrapped around

if (argument0 mod 1 == 0)
{
	while (argument0 > argument2 || argument0 < argument1)
	{
		if (argument0 > argument2)
			argument0 += argument1 - argument2 - 1;
		else if (argument0 < argument1)
			argument0 += argument2 - argument1 + 1;
	}
	return(argument0);
}
else	
{
	var vOld = argument0 + 1;
	while (argument0 != vOld)
	{
		vOld = argument0;
		if (argument0 < argument1)
			argument0 = argument2 - (argument1 - argument0);
		else if (argument0 > argument2)
			argument0 = argument1 + (argument0 - argument2);
	}
	return(argument0);
}

#define JumpInDirection
/// @description JumpInDirection(distance, direction)
/// @param distance
/// @param direction

// Teleports parent object to a spot based on given direction and distance

x += lengthdir_x(argument0,argument1)
y += lengthdir_y(argument0,argument1)

#define Chance
/// @description Chance(percent)
/// @param percent

// Returns true or false depending on RNG
// ex: 
//		Chance(0.7);	-> Returns true 70% of the time

return argument0 > random(1);

#define StringLeft
///@arg str 
///@arg num

if(argument1 < 0){
	return string_copy(argument0, 1, string_length(argument0) + argument1);
} else {
	return string_copy(argument0, 1, argument1);
}

#define DrawSetText
/// @desc DrawSetText(color, font, halign, valign)
/// @arg color
/// @arg font
/// @arg halign
/// @arg valign

draw_set_color(argument0);
draw_set_font(argument1);
draw_set_halign(argument2);
draw_set_valign(argument3);

#define SaveStringToFile
///@arg filename
///@arg string

var _filename = argument0;
var _string = argument1;

var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
buffer_write(_buffer, buffer_string, _string);
buffer_save(_buffer, _filename);
buffer_delete(_buffer);

#define LoadJSONFromFile
///@arg filename

var _filename = argument0;

var _buffer = buffer_load(_filename);
var _string = buffer_read(_buffer, buffer_string);
buffer_delete(_buffer);

var _json = json_decode(_string);
return _json;

#define CheckGrounded
///@desc returns grounded variable
///@arg tilemap
///@arg tilesize

var realy = y

y = 0

var bottom_origin_distance = bbox_bottom - round(y)
var top_origin_distance = bbox_top - round(y)
var intensity = ((sprite_width - 1) div argument1) + 2
var boxwidth = bbox_right - bbox_left
var bump = 0

y = realy

for(var i = 0; i < intensity; i++)
{
	bump = max(bump, tilemap_get_at_pixel(argument0, bbox_left + ((boxwidth / (intensity - 1)) * i), ceil(y + bottom_origin_distance) + 1))
}
if(bump != 0)
{
	return true
}
return false

#define Xcollision
///@desc does X collisions
///@arg hsp
///@arg tilemap
///@arg tilesize

var realx = x

x = 0

var bottom_origin_distance = bbox_bottom - round(y)
var top_origin_distance = bbox_top - round(y)
var right_origin_distance = bbox_right - round(x)
var left_origin_distance = bbox_left - round(x)
var intensity = ((sprite_height - 1) div argument2) + 2;
var boxheight = bbox_bottom - bbox_top;
var bump = 0;

x = realx

if(argument0 > 0)
{
	for(var i = 0; i < intensity; i++)
	{
		bump = max(bump, tilemap_get_at_pixel(argument1, ceil(x + right_origin_distance + argument0), y + top_origin_distance + ((boxheight / (intensity - 1)) * i)))
	}
	if(bump != 0)
	{
		return argument2 - ((right_origin_distance + x) mod argument2) - 1
	}
	return argument0
} 
else if (argument0 < 0)
{
	for(var i = 0; i < intensity; i++)
	{
		bump = max(bump, tilemap_get_at_pixel(argument1, floor(x + left_origin_distance + argument0), y + top_origin_distance + ((boxheight / (intensity - 1)) * i)))
	}
	if(bump != 0)
	{
		return -((left_origin_distance + x) mod argument2)
	}
	return argument0
}
else
{
	return 0
}

#define Ycollision
///@desc does Y collisions
///@arg vsp
///@arg tilemap
///@arg tilesize

var realy = y

y = 0

var bottom_origin_distance = bbox_bottom - round(y)
var top_origin_distance = bbox_top - round(y)
var right_origin_distance = bbox_right - round(x)
var left_origin_distance = bbox_left - round(x)
var intensity = ((sprite_width - 1) div argument2) + 2
var boxwidth = bbox_right - bbox_left
var bump = 0

y = realy

if(argument0 > 0)
{
	for(var i = 0; i < intensity; i++)
	{
		bump = max(bump, tilemap_get_at_pixel(argument1, x + left_origin_distance + ((boxwidth / (intensity - 1)) * i), ceil(y + bottom_origin_distance + argument0)))
	}
	if(bump != 0)
	{
		return argument2 - ((bottom_origin_distance + y) mod argument2) - 1
	}
	return argument0
} 
else if (argument0 < 0)
{
	for(var i = 0; i < intensity; i++)
	{
		bump = max(bump, tilemap_get_at_pixel(argument1, x + left_origin_distance + ((boxwidth / (intensity - 1)) * i), floor(y + top_origin_distance + argument0)))
	}
	if(bump != 0)
	{
		return -((top_origin_distance + y) mod argument2)
	}
	return argument0
}
else
{
	return 0
}

#define CustomXCollide
hsp = Xcollision(clamp(hsp, -TILESIZE, TILESIZE), collision, TILESIZE)
x += hsp

#define CustomYCollide
vsp = Ycollision(clamp(vsp, -TILESIZE, TILESIZE), collision, TILESIZE)
y += vsp

#define CustomTileCollide
///@desc does a full custom collision motion application thing
CustomXCollide()
CustomYCollide()

#define CheckOnWall
///@desc Checks whether the player is on a wall

var realx = x

x = 0

var right_origin_distance = bbox_right - round(x)
var left_origin_distance = bbox_left - round(x)
var intensity = ((sprite_height - 1) div argument1) + 2;
var boxheight = bbox_bottom - bbox_top;
var bump = 0;

x = realx

if(argument2 > 0)
{
	for(var i = 0; i < intensity; i++)
	{
		bump = max(bump, tilemap_get_at_pixel(argument0, ceil(x + right_origin_distance + sign(argument2)), bbox_top + ((boxheight / (intensity - 1)) * i)))
	}
	if(bump != 0)
	{
		return 1
	}
}
else if (argument2 < 0)
{
	for(var i = 0; i < intensity; i++)
	{
		bump = max(bump, tilemap_get_at_pixel(argument0, floor(x + left_origin_distance + sign(argument2)), bbox_top + ((boxheight / (intensity - 1)) * i)))
	}
	if(bump != 0)
	{
		return -1
	}
}

return 0

#define CamWidth
return camera_get_view_width(view_camera[0])

#define CamHeight
return camera_get_view_height(view_camera[0])

#define CreateCam
if(!instance_exists(oCamera))
{
	if(!layer_exists("Camera"))
	{
		var camlay = layer_create(1, "Camera")
	}
	return instance_create_layer(x, y, camlay, oCamera)
}

#define ParralaxLayerMove
if(layer_exists(argument0))
{
	layer_x(argument0, x/argument1);
}

#define CamSetPos
///@desc sets camera position
///@arg camID
///@arg clamp

if(argument1)
{
	camera_set_view_pos(argument0, clamp(x, CamWidth() / 2, room_width - CamWidth() / 2) - (camera_get_view_width(view_camera[0]) / 2), clamp(y, CamHeight() / 2, room_height - CamHeight() / 2) - (camera_get_view_height(view_camera[0]) / 2))
}
else
{
	camera_set_view_pos(argument0, x - (camera_get_view_width(view_camera[0]) / 2), y - (camera_get_view_height(view_camera[0]) / 2))
}
#define CamInit
speedfactor = argument0
cam = view_camera[0]

#define CamUpdate
x += (follow.x - x) / speedfactor
y += (follow.y - y) / speedfactor

CamSetPos(argument0, argument1)

#define CreateMeta
var inst = instance_create_depth(0, 0, 0, argument0);
inst.persistent = true
return inst