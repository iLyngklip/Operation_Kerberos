/*
    Author: Dorbedo

    Description:
        Teleports Caller to his Squadleader

*/
#include "script_component.hpp"
_this params ["_host","_caller"];
TRACEV_2(_host,_caller);
Private _position = [];

if (leader _caller == _caller) exitWith {[QGVAR(message),[LSTRING(TELEPORT),[LSTRING(TELEPORT_LEAD_FAIL),LSTRING(TELEPORT_LEAD_ISLEADER)]]] call CBA_fnc_localEvent;};

Private _time = GETUVAR(GVAR(respawnTime),-1);
if ((_time > 0) && {(CBA_missionTime - _time) < 900}) exitWith {
    _time = floor (900 - CBA_missionTime + _time);
    [QGVAR(message),[LSTRING(TELEPORT),[format [localize LSTRING(TELEPORT_LEAD_WAIT),floor (_time / 60),floor (_time mod 60)]]]] call CBA_fnc_localEvent; 
};

if ((vehicle _caller) == _caller) then {
    Private _nearestEnemy = _caller findNearestEnemy (leader _caller);
    if (((leader _caller) distance _nearestEnemy)<350) then {
        [QGVAR(message),[LSTRING(TELEPORT),[LSTRING(TELEPORT_LEAD_FAIL),LSTRING(TELEPORT_LEAD_NEARENEMY)]]] call CBA_fnc_localEvent;
    }else{
        /// in vehicle
        If ((vehicle (leader _caller)) != (leader _caller)) then {
            Private _platzanzahl = (vehicle (leader _caller)) emptyPositions "cargo";
            If (_platzanzahl<1) then {
                [QGVAR(message),[LSTRING(TELEPORT),[LSTRING(TELEPORT_LEAD_FAIL),LSTRING(TELEPORT_LEAD_NOPLACE)]]] call CBA_fnc_localEvent;
            }else{
                _caller moveInCargo (vehicle (leader _caller));
            };
        }else{
            If (isTouchingGround (leader _caller)) then {
                _position = (getPos (leader _caller)) findEmptyPosition [1,15,"B_crew_F"];
                if (!(_position isEqualTo [])) then {
                    private "_stance";
                    _stance = stance (leader _caller);
                    If (_stance in ["STAND","CROUCH","PRONE"]) then {
                        _caller playActionNow _stance;
                    };
                    _caller setPos _position;
                };
            }else{
                [QGVAR(message),[LSTRING(TELEPORT),[LSTRING(TELEPORT_LEAD_FAIL),LSTRING(TELEPORT_LEAD_INAIR)]]] call CBA_fnc_localEvent;
            };
        };
    };
};
false;