//Does UI value displays with shake effects n stuff

/*
	Methods:
	
	init_draw_value: sets up the drawing value stuff
	draw_value: draws a value
	
	Enable:
		setup_do_colorthresholdmax
		setup_do_colorthresholdmin
		setup_do_explode
		setup_do_flash
		setup_do_gradualchange
		setup_do_hop
		setup_do_poschange
		setup_do_sound
		
	Disable:
		disable_do_colorthresholdmax
		disable_do_colorthresholdmin
		disable_do_explode
		disable_do_flash
		disable_do_gradualchange
		disable_do_hop
		disable_do_poschange
		disable_do_sound
*/

///@desc initializes variables needed for draw_value
function init_draw_value(value) {
	//MUST BE CALLED BEFORE INIT_DO_ANYTHING
	///@arg value

	pval = argument0
	oldval = argument0

	flash = false
	gradualchange = false
	poschange = false
	colorthresholdmax = false
	colorthresholdmin = false
	hop = false
	explode = false
	dosound = false
}


///@desc draws a value with cool effects
///@arg value
///@arg font
///@arg base_color
///@arg x_offset
///@arg y_offset
function draw_value() {

	var base_value_color = argument[2]

	var val = argument[0]

#region reset the value history checker & play sound
	if(val != pval)
	{
		if(flash)			flashtimer = 0
		if(gradualchange)	gradualchangetimer = 0
		if(poschange)		poschangetimer = 0;
		if(hop)				hoptimer = 0
		if(explode)			explodetimer = 0
	
		pval = val
	
		if(dosound) audio_play_sound(value_sound, 1, 0)
	}
#endregion

	var col = base_value_color;
#region choose color based on thresholds
	if(colorthresholdmax)
	{
		//we've hit the max threshold
		if(maxthreshold <= val) col = maxthresholdcolor
	}
	if(colorthresholdmin)
	{
		//we've hit the min threshold
		if(minthreshold >= val) col = minthresholdcolor
	}
#endregion

#region choose color based on flashing
	//if changing and flashing on
	if(flash)
	{
		if(flashtimer < flashtimermax)
		{
			//update timer
			flashtimer++;
		
			//if flashspeed is zero, just make the color flashcolor
			if(flashspeed == 0)
			{
				col = flashcolor
			}
			//maths to make flashing happen at speed of flashspeed 
				//(can't combine the ifs bc div by 0 error)
			else if ((flashtimer div flashspeed) % 2 == 0)
			{
				col = flashcolor
			}
		}
	}
#endregion

#region get the right value string
	var str = string(val)
	if(gradualchange)
	{
		if(gradualchangetimer < gradualchangetimermax)
		{
			//update timer
			gradualchangetimer++;
		
			//get the right interpolated string
			str = string(round(lerp(oldval + sign(val - oldval), val, gradualchangetimer/gradualchangetimermax)))
		}
		else
		{
			oldval = val
		}
	}
#endregion

	var xoff = 0;
	var yoff = 0;
#region get position change offsets
	if(poschange)
	{
		if(poschangetimer < poschangetimermax)
		{
			//update timer
			poschangetimer++;
		
			var dist;
			//check if we're going there, staying there, or leaving there
			if(poschangetimer > poschangetimermax - poschangespeed)
			{
				//leaving
				dist = EaseOutCubic(poschangetimermax - poschangetimer, 0, 1, poschangespeed)
			}
			else if(poschangetimer < poschangespeed)
			{
				//entering
				dist = EaseOutCubic(poschangetimer, 0, 1, poschangespeed)
			}
			else
			{
				//staying
				dist = 1
			}
			xoff = lerp(x, poschangex * GuiWidth(), dist)
			yoff = lerp(y, poschangey * GuiHeight(), dist)
		}
	}
#endregion

#region get explode offsets
	if(explode)
	{
		if(explodetimer < explodetimermax)
		{
			//update timer
			explodetimer++
		
			if(explodetimer % explodedelay == 0) ang = random(360)
			xoff += lengthdir_x(explodesize, ang)
			yoff += lengthdir_y(explodesize, ang)
		}
	}
#endregion

#region get hop offsets
	if(hop)
	{
		if(hoptimer < hopspeed)
		{
			//update timer
			hoptimer++
		
			yoff -= sin(pi * hoptimer / hopspeed) * hopheight
		}
	}
#endregion

	if(argument_count > 4)
	{
		xoff += argument[3]
		yoff += argument[4]
	}

	//draw text
	DrawSetText(col, argument[1], fa_middle, fa_center)
	draw_text(x + xoff, y + yoff, str)
}

///@desc initializes color threshold max for draw_value_ext
///@arg maxthreshold
///@arg color
function setup_do_colorthresholdmax(argument0, argument1) {
	colorthresholdmax = true
	maxthreshold = argument0
	maxthresholdcolor = argument1
}

///@desc initializes color threshold minimum for draw_value_ext
///@arg min
///@arg color
function setup_do_colorthresholdmin(argument0, argument1) {
	colorthresholdmin = true

	minthreshold = argument0
	minthresholdcolor = argument1
}

///@desc initializes explode for draw_value_ext
///@arg radius
///@arg time
///@arg delay
function setup_do_explode(argument0, argument1, argument2) {
	explode = true

	explodesize = argument0
	explodetimermax = argument1
	explodedelay = argument2

	explodetimer = explodetimermax
	ang = random(360)
}

///@desc initializes flash for draw_value_ext
///@arg flashcolor
///@arg flashspeed
///@arg flashtimermax
function setup_do_flash(argument0, argument1, argument2) {
	flash = true
	flashcolor = argument0
	flashspeed = argument1
	flashtimermax = argument2

	flashtimer = flashtimermax
}

///@desc initializes gradual change for draw_value_ext
///@arg time
function setup_do_gradualchange(argument0) {
	gradualchange = true
	gradualchangetimermax = argument0
	gradualchangetimer = argument0
}

///@desc initializes hop for draw_value_ext
///@arg hopspeed
///@arg height
function setup_do_hop(argument0, argument1) {
	hop = true

	hopspeed = argument0
	hopheight = argument1

	hoptimer = hopspeed
}

///@desc initializes position change for draw_value_ext
///@arg speed
///@arg time
///@arg x
///@arg y
function setup_do_poschange(argument0, argument1, argument2, argument3) {
	//X AND Y ARE ON A 0-1 GUI SCALE
	poschange = true

	poschangespeed = argument0
	poschangetimermax = argument1
	poschangex = argument2
	poschangey = argument3

	poschangetimer = poschangetimermax
}

///@desc initializes sound for draw_value_ext
///@arg sound
function setup_do_sound(argument0) {
	dosound = true
	value_sound = argument0
}

///@desc deactivates color threshold max for draw_value_ext
function disable_do_colorthresholdmax() {
	colorthresholdmax = false
}

///@desc deactivates color threshold minimum for draw_value_ext
function disable_do_colorthresholdmin() {
	colorthresholdmin = false
}

///@desc deactivates explode for draw_value_ext
function disable_do_explode() {
	explode = false
}

///@desc deactivates flash for draw_value_ext
function disable_do_flash() {
	flash = false
}

///@desc deactivates gradual change for draw_value_ext
function disable_do_gradualchange() {
	gradualchange = false
}

///@desc deactivates hop for draw_value_ext
function disable_do_hop() {
	hop = false
}

///@desc deactivates position change for draw_value_ext
function disable_do_poschange() {
	poschange = false
}

///@desc deactivates sound for draw_value_ext
function disable_do_sound() {
	dosound = false
}