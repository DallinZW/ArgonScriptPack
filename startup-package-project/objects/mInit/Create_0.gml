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
	STEP_SIZE
}

enum SIDE
{
	RIGHT,
	TOP,
	LEFT,
	BOTTOM
}

init_inputs(1);

CreateMeta(mInput)
CreateMeta(mDebug)

room_goto(rGame)