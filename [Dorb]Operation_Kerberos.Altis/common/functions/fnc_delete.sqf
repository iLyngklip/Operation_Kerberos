/*
    Author: Dorbedo
    
    Description:
        deletes locations,objects,marker and groups or an array including these
    Parameter(s):
        0: ARRAY/OBJECT/LOCATION/GROUP/STRING - thing to delete
    Return:
        none
*/
#include "script_component.hpp"
_this params [["_delete",objNull,[[],objNull,"",grpNull,locationNull]]];
switch (typeName _delete) do {
    case "ARRAY" : {
        {_x call _fnc_scriptName;} forEach _delete;
    };
    case "OBJECT" : {
        If (vehicle _delete != _delete) then {
            unassignVehicle (vehicle _delete);
            _delete setPos [0,0,0];
        }else{
            if ({_x != _delete} count (crew _delete) > 0) then {
                (crew _delete) call _fnc_scriptName;
            };
        };
        deleteVehicle _delete;
    };
    case "GROUP" : {
        (units _delete) call _fnc_scriptName;
        {deleteWaypoint _x} forEach (wayPoints _delete);
        deleteGroup _delete;
    };
    case "LOCATION" : {
        deleteLocation _delete;
    };
    case "STRING" : {
        deleteMarker _this;
    };
    default {};
};
nil;