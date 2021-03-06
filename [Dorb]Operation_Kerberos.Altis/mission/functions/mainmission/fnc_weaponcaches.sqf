    /*
    Author: Dorbedo

    Description:
        Creates Mission "DEVICE".

    Parameter(s):
        0 :    ARRAY - Position

    Returns:
    BOOL
*/
#include "script_component.hpp"
SCRIPT(weaponcache);
_this params [["_position",[],[[]],[2,3]]];
TRACEV_1(_position);
CHECK(_position isEqualTo [])
/********************
    create Target
********************/
private ["_rad","_gebaeudepos_arr","_rand","_targets"];
_targets = [];
_rad = 800;
_gebaeudepos_arr = [];
_gebaeudepos_arr = [_position,_rad] call EFUNC(common,get_buildings);

_rand = ((floor(random 5)) + 8);

for "_i" from 1 to _rand do{
    private["_einheit","_spawngebaeude","_spawnposition","_unit"];
    _einheit = selectRandom EGVAR(spawn,list_weaponcache);
    _spawngebaeude = selectRandom _gebaeudepos_arr;
    _spawnposition = selectRandom _spawngebaeude;
    _unit = createVehicle [_einheit,_spawnposition, [], 0, "NONE"];
    _targets pushBack _unit;
};
/********************
    boom
********************/
{
    _x addEventHandler ["killed",{"Bo_Mk82" createVehicle (getpos (_this select 0));}];
    #ifdef DEBUG_MODE_FULL
        [getPos _x,"CACHE","ColorBlack","hd_destroy"] call EFUNC(common,debug_marker_create);
    #endif
}forEach _targets;

/********************
    taskhandler
********************/

[
    QUOTE(_this params['_targets'];private '_a';_a = {alive _x}count _targets;If (_a < (((count _targets)*0.5)-4)) then {true}else{false};),
    [_targets],
    "true"
]