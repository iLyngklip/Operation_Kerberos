/*
    Author: Dorbedo
    
    Description:
        Displays the timer
        called via publicVariableEventhandler
    
    Parameter(s):
        None
        
    
*/
#include "script_component.hpp"
CHECK(!hasInterface)
CHECK((isNil QGVAR(countdown))||{(GVAR(countdown)<CBA_missiontime)})
CHECK(!(isNil QGVAR(countdown_handler))&&{GVAR(countdown_handler)>=0})

GVAR(countdown_handler) = [
	{
		If ((!GVAR(countdown_show))||(GVAR(countdown)<CBA_missiontime)) exitWith {
			[_this select 1] call CBA_fnc_removePerFrameHandler;
			QGVAR(countdown_disp) cutRsc ["","PLAIN"];
			GVAR(countdown_handler) = -1;
		};
		private _idd = uiNamespace getVariable [QGVAR(countdown),displayNull];
		If (isNull _idd) then {
			QGVAR(countdown_disp) cutRsc [QGVAR(countdown),"PLAIN"];
			_idd = uiNamespace getVariable [QGVAR(countdown),displayNull];
		};
		///// sets the countdown timer;
		private _ctrl = (_idd displayCtrl 770201);
		_ctrl ctrlSetText format["%1",(floor((GVAR(countdown)-CBA_missiontime)/60))]
	},
	5
] call CBA_fnc_addPerFrameHandler;