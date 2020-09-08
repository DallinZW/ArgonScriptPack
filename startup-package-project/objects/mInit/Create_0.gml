#macro TILESIZE 20

enum MENUDATA
{
	STRING,
	SCRIPT,
	FONT,
	COLOR,
	SELECTCOLOR,
	MIN_VALUE,
	MAX_VALUE,
	STEP_SIZE,
	MAX_VALUE_WIDTH
}

enum SIDE
{
	RIGHT,
	TOP,
	LEFT,
	BOTTOM
}

init_inputs(1);
pal_swap_init_system(shd_pal_swapper, shd_pal_html_sprite, shd_pal_html_surface)

CreateMeta(mInput)
CreateMeta(mDebug)

room_goto(rGame)