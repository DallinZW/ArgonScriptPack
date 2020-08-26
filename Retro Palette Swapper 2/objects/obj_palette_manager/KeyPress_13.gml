/// @description Go to next room.
if(instance_exists(obj_room_change_swipe)) exit;

var _room;
if(!room_exists(room+1))
    _room=0;
else
    _room = room+1;

with(instance_create_depth(0,0,depth-1000,obj_room_change_swipe))
{
		target_room=_room;
}


