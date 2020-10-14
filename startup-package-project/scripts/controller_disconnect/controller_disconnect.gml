// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function controller_disconnect(player_id){
	global.PLAYER_GAMEPAD_DISCONNECTS[| player_id] = true
}