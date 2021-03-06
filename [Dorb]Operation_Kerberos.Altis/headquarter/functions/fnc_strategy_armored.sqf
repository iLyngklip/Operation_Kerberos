/*
    Author: Dorbedo
    
    Description:
        revon
    
    Parameter(s):
        none

    Returns:
        none
*/
#include "script_component.hpp"
SCRIPT(strategy_armored);
_this params ["_currentLogic"];

private _currentPos = getPos _currentLogic;
private _currentTroops = _currentLogic getVariable [QGVAR(troopsNeeded),0];
private _spawnpos = [_currentPos,6000,2] call EFUNC(common,random_pos);
CHECKRET((_spawnpos isEqualTo []),0);

GVAR(callIn_armored) = GVAR(callIn_armored) - 1;

private _allTanks = getArray(missionconfigfile >> "unitlists" >> str GVARMAIN(side) >> GVARMAIN(side_type)>> "callIn" >> "armored" >> "units");
private _TankVehType = selectRandom _allTanks;
_spawnpos set [2,1500];
_dir = [_spawnpos, _currentPos] call BIS_fnc_dirTo;

([_spawnpos,GVARMAIN(side),_TankVehType,_dir,true,true,"FLY"] call EFUNC(spawn,vehicle)) params ["_tankGroup","_tankVeh"];

SETVAR(_tankGroup,GVAR(target),_currentPos);
SETVAR(_tankGroup,GVAR(state),'attack');
[_tankGroup] call FUNC(state_change);

([_tankGroup] call FUNC(strength)) params ["_type","_strength"];
_currentTroops - _strength;