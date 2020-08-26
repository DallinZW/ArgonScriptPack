varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 tintColor;

float ease(float inp, float outputmin, float outputmax, float inputmax)
{
	return outputmax * pow(inp / inputmax, 8.0) + outputmin;
}

void main()
{
	vec4 col = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	col.r = ease(v_vTexcoord.x, tintColor.r, col.r, 1.0);
	col.g = ease(v_vTexcoord.x, tintColor.g, col.g, 1.0);
	col.b = ease(v_vTexcoord.x, tintColor.b, col.b, 1.0);
	
    gl_FragColor = vec4(col);
}