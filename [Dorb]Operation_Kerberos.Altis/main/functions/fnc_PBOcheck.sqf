/*
    Author: Dorbedo

    Description:
        Diagnosefunktion um Performance-Probleme zu analysieren

*/
#include "script_component.hpp"

CHECK(!isMultiplayer)

private _whitelist = getArray(missionConfigFile>>"PBOwhitelist");
if (_whitelist isEqualTo [])&&{!isNil "ace_common_checkPBOsWhitelist"}) then {
    _whitelist = tolower ace_common_checkPBOsWhitelist;
    _whitelist = _whitelist splitString "[,""']";
};

private _addons = "true" configClasses (configFile >> "CfgPatches");//
_addons = _addons apply {toLower configName _x};//
_addons = _addons select {
    (_x find "ace_" != 0)||
    (
        (_x find "ace_" == 0)&&
        {
            (
                {_x find "ace_" == 0} count (getArray(configFile >> "CfgPatches" >> _x >> "requiredAddons"))
            )==0
        }
    )
};

private _versions = 




