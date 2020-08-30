//this one works with the celeste jump- applying jump velocity as long as you hold space

vel = [0, 0]

collision = layer_tilemap_get_id("Collision")

p_id = 0

//choose jumpheight min and max (in pixels) and jumpmaxtime and let the math do
var jump_height_max = TILESIZE * 3
var jump_height_min = TILESIZE * 1
var min_jump_time = 17

//gravity, variable jump timer and max fall speed
//it's a lot of newtonian equations pls don't mess with it unless ABSOLUTELY NECESSARY
jumpsz = 2 * jump_height_min / ((min_jump_time - 1) / 2)
grv = -jumpsz / ((min_jump_time + 1) / 2)

variable_jump_max = ceil((jump_height_max - jump_height_min) / jumpsz)
variable_jump = variable_jump_max

maxvspeed = TILESIZE * 0.5

grv_speed_mod = 0.5

//halved gravity jump peak- when velocity is low enough and input held, gravity is halved
half_grv_threshold = TILESIZE * 0.1

//coyote time and jump buffers
coyote_time_max = 6
coyote_time = 0

jump_buffer_max = 9
jump_buffer = 0

grounded = false

//wall jumpin
wall_jump_xsize = TILESIZE * 0.2
wall_jump_ysize = TILESIZE * 0.4
jumpdir = 0

wall_grv = grv
maxvspeed_wall = maxvspeed/6

//walking and accelerations
walksp = TILESIZE * 0.12
accel = walksp * 0.1111
decel = walksp * 0.2222
aircontrol = walksp * 0.1

state = "idle"
statetimer = 0

gradual_change_position = [0, 0]

function StateSwitch(newstate)
{
	state = newstate
	statetimer = 0
}