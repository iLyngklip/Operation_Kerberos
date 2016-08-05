#include "script_component.hpp"
ADDON = false;

#include "XEH_PREP.sqf"

ADDON = true;

If (isNil QGVARMAIN(HC_enabled)) then {GVARMAIN(HC_enabled)=true;};

GVAR(istransfering) = false;
GVAR(HeadlessClients) = [];