//	EaseIn, EaseOut, and EaseInOut functions for:
//	Sine, Quad, Cubic, Quart, Quint, Expo, Circ, Back, Elastic, and Bounce
//	As well as EaseLinear

///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseLinear(argument0, argument1, argument2, argument3) {
	return argument2 * argument0 / argument3 + argument1;
}

///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseInBack(argument0, argument1, argument2, argument3) {
	var _s = 1.70158;

	argument0 /= argument3;
	return argument2 * argument0 * argument0 * ((_s + 1) * argument0 - _s) + argument1;
}

///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseInOutBack(argument0, argument1, argument2, argument3) {
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
}

///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseOutBack(argument0, argument1, argument2, argument3) {
	var _s = 1.70158;

	argument0 = argument0/argument3 - 1;
	return argument2 * (argument0 * argument0 * ((_s + 1) * argument0 + _s) + 1) + argument1;
}

///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseInBounce(argument0, argument1, argument2, argument3) {
	return argument2 - EaseOutBounce(argument3 - argument0, 0, argument2, argument3) + argument1
}

///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseInOutBounce(argument0, argument1, argument2, argument3) {
	if (argument0 < argument3*0.5) 
	{
	    return (EaseInBounce(argument0*2, 0, argument2, argument3)*0.5 + argument1);
	}

	return (EaseOutBounce(argument0*2 - argument3, 0, argument2, argument3)*0.5 + argument2*0.5 + argument1);
}

///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseOutBounce(argument0, argument1, argument2, argument3) {
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
}

///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseInCirc(argument0, argument1, argument2, argument3) {
	argument0 /= argument3;
	return argument2 * (1 - sqrt(1 - argument0 * argument0)) + argument1;
}

///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseInOutCirc(argument0, argument1, argument2, argument3) {
	argument0 /= argument3 * 0.5;

	if (argument0 < 1)
	{
	    return argument2 * 0.5 * (1 - sqrt(1 - argument0 * argument0)) + argument1;
	}

	argument0 -= 2;
	return argument2 * 0.5 * (sqrt(1 - argument0 * argument0) + 1) + argument1;
}

///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseOutCirc(argument0, argument1, argument2, argument3) {
	argument0 = argument0 / argument3 - 1;
	return argument2 * sqrt(1 - argument0 * argument0) + argument1;
}

///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseInCubic(argument0, argument1, argument2, argument3) {
	return argument2 * power(argument0/argument3, 3) + argument1;
}

///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseInOutCubic(argument0, argument1, argument2, argument3) {
	argument0 /= argument3 * 0.5;

	if (argument0 < 1)
	{
	   return argument2 * 0.5 * power(argument0, 3) + argument1;
	}

	return argument2 * 0.5 * (power(argument0 - 2, 3) + 2) + argument1;
}

///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseOutCubic(argument0, argument1, argument2, argument3) {
	return argument2 * (power(argument0/argument3 - 1, 3) + 1) + argument1;
}

///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseInElastic(argument0, argument1, argument2, argument3) {
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
}

///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseInOutElastic(argument0, argument1, argument2, argument3) {
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
}

///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseOutElastic(argument0, argument1, argument2, argument3) {
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
}

///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseInExpo(argument0, argument1, argument2, argument3) {
	return argument2 * power(2, 10 * (argument0 / argument3 - 1)) + argument1;
}

///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseInOutExpo(argument0, argument1, argument2, argument3) {
	argument0 /= argument3 * 0.5;

	if (argument0 < 1) 
	{
	    return argument2 * 0.5 * power(2, 10 * --argument0) + argument1;
	}

	return argument2 * 0.5 * (-power(2, -10 * --argument0) + 2) + argument1;
}

///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseOutExpo(argument0, argument1, argument2, argument3) {
	return argument2 * (-power(2, -10 * argument0 / argument3) + 1) + argument1;
}

///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseInOutQuad(argument0, argument1, argument2, argument3) {
	argument0 /= argument3 * 0.5;

	if (argument0 < 1)
	{
	    return argument2 * 0.5 * argument0 * argument0 + argument1;
	}

	return argument2 * -0.5 * (--argument0 * (argument0 - 2) - 1) + argument1;
}

///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseInQuad(argument0, argument1, argument2, argument3) {
	argument0 /= argument3;
	return argument2 * argument0 * argument0 + argument1;
}

///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseOutQuad(argument0, argument1, argument2, argument3) {
	argument0 /= argument3;
	return -argument2 * argument0 * (argument0 - 2) + argument1;
}

///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseInOutQuart(argument0, argument1, argument2, argument3) {
	argument0 /= argument3 * 0.5;

	if (argument0 < 1) 
	{
	    return argument2 * 0.5 * power(argument0, 4) + argument1;
	}

	return argument2 * -0.5 * (power(argument0 - 2, 4) - 2) + argument1;
}

///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseInQuart(argument0, argument1, argument2, argument3) {
	return argument2 * power(argument0 / argument3, 4) + argument1;
}

///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseOutQuart(argument0, argument1, argument2, argument3) {
	return -argument2 * (power(argument0 / argument3 - 1, 4) - 1) + argument1;
}

///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseInOutQuint(argument0, argument1, argument2, argument3) {
	argument0 /= argument3 * 0.5;

	if (argument0 < 1)
	{
	    return argument2 * 0.5 * power(argument0, 5) + argument1;
	}

	return argument2 * 0.5 * (power(argument0 - 2, 5) + 2) + argument1;
}

///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseInQuint(argument0, argument1, argument2, argument3) {
	return argument2 * power(argument0 / argument3, 5) + argument1;
}

///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseOutQuint(argument0, argument1, argument2, argument3) {
	return argument2 * (power(argument0 / argument3 - 1, 5) + 1) + argument1;
}

///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseInOutSine(argument0, argument1, argument2, argument3) {
	return argument2 * 0.5 * (1 - cos(pi * argument0 / argument3)) + argument1;
}

///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseInSine(argument0, argument1, argument2, argument3) {
	return argument2 * (1 - cos(argument0 / argument3 * (pi / 2))) + argument1;
}

///@arg inputvalue
///@arg outputmin
///@arg outputmax
///@arg inputmax
function EaseOutSine(argument0, argument1, argument2, argument3) {
	return argument2 * sin(argument0 / argument3 * (pi / 2)) + argument1;
}