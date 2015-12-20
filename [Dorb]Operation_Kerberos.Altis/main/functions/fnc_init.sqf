/*
    Author: Dorbedo
    
    Description:
        general initialization
    
    Parameter(s):
        None
        
    Return
        None
*/
#include "script_component.hpp"
SCRIPT(init);


/// initialize MODS
GVAR(mods_rds) = (isClass(configFile >> "CfgPatches" >> "RDS_StaticWeapons_Core"));
GVAR(mods_bwa) = (isClass(configFile >> "CfgPatches" >> "BWA3_Tracked"));

/// initialize SIDES
IF (isNil QGVAR(playerside)) then {
    GVARMAIN(playerside) = west;
};

If (GVARMAIN(playerside) == west) then {
    GVARMAIN(respawnmarker) = "respawn_west";
    GVARMAIN(side) = east;
    CIVILIAN setFriend [WEST, 1];

    WEST setFriend [CIVILIAN, 1];
    WEST setFriend [EAST, 0];
    WEST setFriend [INDEPENDENT, 0];

    EAST setFriend [CIVILIAN, 1];
    EAST setFriend [WEST, 0];
    EAST setFriend [INDEPENDENT, 1];

    INDEPENDENT setFriend [CIVILIAN, 1];
    INDEPENDENT setFriend [WEST, 0];
    INDEPENDENT setFriend [EAST, 1];
};
If (GVARMAIN(playerside) == east) then {
    GVARMAIN(respawnmarker) = "respawn_east";
    GVARMAIN(side) = west;
    CIVILIAN setFriend [EAST, 1];

    WEST setFriend [CIVILIAN, 1];
    WEST setFriend [EAST, 0];
    WEST setFriend [INDEPENDENT, 1];

    EAST setFriend [CIVILIAN, 1];
    EAST setFriend [WEST, 0];
    EAST setFriend [INDEPENDENT, 0];

    INDEPENDENT setFriend [CIVILIAN, 1];
    INDEPENDENT setFriend [WEST, 1];
    INDEPENDENT setFriend [EAST, 0];
};

