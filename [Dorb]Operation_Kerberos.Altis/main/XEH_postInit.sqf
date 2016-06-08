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

/// initialize MODS
GVARMAIN(mods_TFAR) = (isClass(configFile >> "CfgPatches" >> "task_force_radio"));
GVARMAIN(mods_bwa) = (isClass(configFile >> "CfgPatches" >> "BWA3_Tracked"));


[] call FUNC(PBOcheck);