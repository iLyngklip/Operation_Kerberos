/*
    Author: Dorbedo
    
    Description:
        Sets the countdown
    
    Parameter(s):
        0:NUMBER - Time in seconds
        
    
*/
#include "script_component.hpp"

_this params [["_timer",0,[0]]];
CHECK(_timer<=0)
GVAR(countdown) = CBA_missiontime + _timer;
publicVariable QGVAR(countdown);
If (hasInterface) then {[] call FUNC(countdown_show);};
