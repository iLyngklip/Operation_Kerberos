/*
    Author: Dorbedo

    Description:
        adds a restriced arsenal to object

    Parameter(s):
        0: Object <OBJECT>
        1: restricedSide <SIDE>

    Return
        none
*/
#define DEBUG_MODE_FULL
#include "script_component.hpp"
_this params ["_side"];
LOG_1(_side);
hint "generating Arsenal";

If !(isClass(missionConfigFile>>QGVAR(arsenal))) exitWith {[[],[],[],[]]};

private _itemBlacklist = (getArray(missionConfigFile>>QGVAR(arsenal)>> "ItemsBlacklist"));
private _weaponBlacklist = (getArray(missionConfigFile>>QGVAR(arsenal)>> "WeaponsBlacklist"));
private _backpackBlacklist = getArray(missionConfigFile>>QGVAR(arsenal)>> "BackpackBlacklist");
private _magazineBlacklist = getArray(missionConfigFile>>QGVAR(arsenal)>> "MagazineBlackList");

private _blackList = _itemBlacklist + _weaponBlacklist + _backpackBlacklist;

private _addItems = [];
private _addWeapons = [];
private _addBackpacks = [];
private _addMagazines = [];

private _configArray = (
    ("isclass _x" configclasses (configfile >> "cfgweapons")) +
    ("isclass _x && (getText(_x >> 'vehicleClass')=='Backpacks')" configclasses (configfile >> "cfgvehicles")) +
    ("isclass _x" configclasses (configfile >> "cfgglasses"))
);
private _dlcs = [];
private _BISClassBlack = [];
private _BISModelBlacK = [];
private _sideNumber = -1;

switch (_side) do {
    case west : {
        _dlcs = ["RHS_USAF","bwa3"];
        _BISClassBlack = ["_O_","_OG_","_I_","_IG_"];
        _BISModelBlacK = ["OPFOR","INDEP"];
        _sideNumber = 0;
    };
    case east : {
        _dlcs = ["RHS_AFRF"];
        _BISClassBlack = ["_B_","_BG_","_I_","_IG_"];
        _BISModelBlacK = ["BLUFOR","INDEP"];
        _sideNumber = 1;
    };
};

{
    private _class = _x;
    private _className = configname _x;
    private _isBase = if (isarray (_x >> "muzzles")) then {(_className call bis_fnc_baseWeapon == _className)} else {true};
    private _scope = if (isnumber (_class >> "scopeArsenal")) then {getnumber (_class >> "scopeArsenal")} else {getnumber (_class >> "scope")};
    if ((_scope > 1) && {(gettext (_class >> "model") != "")} && _isBase && {gettext (_class >> "displayName") != ""}&&{!(_className in _blacklist)}) then {
        (_className call bis_fnc_itemType) params ["_weaponTypeCategory","_weaponTypeSpecific"];
        if (!(_weaponTypeCategory in ["VehicleWeapon","Magazine"])) then {
            private _hinzufuegen = true;
            If (_className in _blacklist) then {_hinzufuegen = false;};

            If !(_weaponTypeSpecific in ["Backpack"]) then {
                If ((getText(_class>>"dlc") isEqualTo "")||{getText(_class>>"dlc") in ["Mark"]}) then {
                    private _namestring = [getText(_class>>"model"),"\"] call CBA_fnc_split;
                    private _namecount = {_x in _BISModelBlacK} count _namestring;
                    If ( _namecount > 0) then {
                        _hinzufuegen = false;
                    };
                    private _namestring = [_className,"\"] call CBA_fnc_split;
                    private _namecount = {_x in _BISClassBlack} count _namestring;
                    If ( _namecount > 0) then {
                        _hinzufuegen = false;
                    };
                }else{
                    if !((getText(_class>>"dlc"))in _dlcs) then {_hinzufuegen = false;};
                };
            };

            If (_hinzufuegen) then {
                switch (true) do {
                    case (_weaponTypeCategory in ["Weapon"]) : {
                        _addWeapons pushBackUnique _className;
                        private _magazines = getarray(_class >> "magazines");
                        {
                            private _scopeMag = if (isnumber (configFile >> "CfgMagazines" >> _x >> "scopeArsenal")) then {getnumber (configFile >> "CfgMagazines" >> _x >> "scopeArsenal")} else {getnumber (configFile >> "CfgMagazines" >> _x >> "scope")};
                            If ((!(_x in _magazineBlacklist))&& (_scope > 1)) then {
                                _addMagazines pushBackUnique _x;
                            };
                        }foreach _magazines;
                    };
                    case (_weaponTypeCategory in ["Mine"]) : {
                        _addMagazines pushBackUnique _className;
                    };
                    case ((_weaponTypeSpecific in ["Backpack"])&&(getNumber(_class >> "side")==_sideNumber)) : {
                        _addBackpacks pushBackUnique _className;
                    };
                    default {_addItems pushBackUnique _className;};
                };
            };
        };
    };
    hintSilent format["%1/%2",_forEachIndex,count _configArray];
} foreach _configArray;
{
    private _weapon = _x;
    {
        {
            private _mag = _x;
            if ((!(_mag in _magazineBlacklist))&&{!(_mag in _addMagazines)}) then {
                private _scopeMag = if (isnumber (configfile >> "cfgmagazines" >> _mag >> "scopeArsenal")) then {getnumber (configfile >> "cfgmagazines" >> _mag >> "scopeArsenal")} else {getnumber (configfile >> "cfgmagazines" >> _mag >> "scope")};
                if (_scopeMag > 1) then {
                    _addMagazines pushBack _x;
                };
            };
        } foreach getarray (_x >> "magazines");
    } foreach ("isclass _x" configclasses (configfile >> "cfgweapons" >> _weapon));
} foreach ["Put","Throw"];

hint "arsenal finished";
missionNamespace setVariable [format[QGVAR(arsenalList_%1),str _side],[_addWeapons,_addMagazines,_addItems,_addBackpacks]];