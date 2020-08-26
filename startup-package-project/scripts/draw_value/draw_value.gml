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
