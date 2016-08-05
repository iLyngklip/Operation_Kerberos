#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.sqf"

ADDON = true;

/// init variables
GVAR(msg_cur) = [];
GVAR(msg_cur_ID) = 0;
GVAR(msg_waiting) = [];
