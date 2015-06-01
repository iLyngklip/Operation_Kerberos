/*
	Author: Dorbedo

	Description:
	Creates Mission "Return to Base".
	
	Parameter(s):
		0 :	ARRAY - Position der letzten AO
		
	Returns:
	BOOL
*/
#include "script_component.hpp"
CHECK(!isServer)
PARAMS_1(_position);
private["_ort","_position_rescue","_pow"];
_position_home = getMarkerPos "respawn_west";

//////////////////////////////////////////////////
////// Nachricht anzeigen 					 /////
//////////////////////////////////////////////////

[-1,{["rtb",1] call FM(disp_localization)}] FMP;

//////////////////////////////////////////////////
////// Überprüfung + Ende 					 /////
//////////////////////////////////////////////////

[
	15,
	{
		_a=0;
		{If (_x distance (_this select 0) < 300) then {_a=_a+1;};} forEach playableUnits;
		If (_a == (count playableUnits)) then {true}else{false};
	},
	[_position_home],
	{true},
	{
		LOG("Alle zurückgekehrt");
		[-1,{["rtb",2] call FM(disp_localization)}] FMP;
		[_position, 2000] spawn FM(cleanup_big);
	}
] call FM(taskhandler);

/*
aufgabenstatus=true;
while {aufgabenstatus} do {
	_a=0;
	sleep 15;
	
	{If (_x distance _position_home < 300) then {_a=_a+1;};} forEach playableUnits;
	
	If (_a == (count playableUnits)) then {aufgabenstatus=false};
};

[-1,{["rtb",2] call FM(disp_localization)}] FMP;
LOG("Alle zurückgekehrt");
[_position, 2000] spawn FM(cleanup_big);
*/
LOG("Exit RTB");