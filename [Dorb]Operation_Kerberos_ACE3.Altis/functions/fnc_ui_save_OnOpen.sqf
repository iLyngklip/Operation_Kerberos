/*
    Author: Dorbedo

    Description:
    Updates the List
	
	

*/
#include "script_component.hpp"
SCRIPT(ui_save_OnOpen);
#define SAVE_IDD	600240
#define SAVE_LIST 600241
#define SAVE_EDIT 600245
private "_ctrlList";
_ctrlList = findDisplay SAVE_IDD displayCtrl SAVE_LIST;
If (!(ctrlShown _ctrlList)) exitWith {
	[_this select 1] call removePerFrameHandler;
	DORB_SAVE_ISOPENED=false;
};


disableSerialization;

private["_list","_sel"];

_list = profileNamespace getVariable [DORB_SAVE_LIST,[]];
_sel = [];
{
	_sel pushBack [[_x select 0],[_forEachIndex],[]];
}forEach _list;
If(_sel isEqualTo []) exitWith {lnbClear SAVE_LIST;};
lnbClear SAVE_LIST;
lnbAddArray [SAVE_LIST,_sel];