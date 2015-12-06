/*
	Author: Dorbedo
	
	Description:
		generates waypoints
	
	Parameter(s):
		none

	Returns:
		none
*/
#include "script_component.hpp"
SCRIPT(waypoints_generate);
_this params[
	["_start",[],[[],objNull]],
	["_target",[],[[],objNull]],
	["_evade",false,[true]]
	];

_startKey = [_start] call FUNC(waypoints_next);
_targetKey = [_target] call FUNC(waypoints_next);

If (_startKey == _targetKey) exitWith {
	[_start,_target]
};

_startKeypos = getArray(missionconfigFile >> "maps" >> worldname >> _startKey >> "position");
_targetKeypos = getArray(missionconfigFile >> "maps" >> worldname >> _targetKey >> "position");
_Keydifferenz = 50;

//#undef DEBUG_MODE_FULL
/// waypoint = [value,distance to target, distance to start, key]
_counter = 0;
_active = true;
_waypointsActivated = [[0,floor((_startKeypos distance2D _targetKeypos)*10),0,_startKey]];
_waypointsDeactivated = [];
while {_active} do {
	
	If (count _waypointsActivated <1) exitWith {ERROR("NO MORE WAYPOINTS");_active = false;};
	_waypointsActivated sort true;
	
	(_waypointsActivated select 0) params ["_currentValue","_currentDistance","_currentWay","_currentWP"];
	//_currentWP = (_waypointsActivated select 0)select 2;
	(_currentWP splitString "_") params ["_currentKeyX","_currentKeyY"];
	_currentKeyX = parseNumber(_currentKeyX);
	_currentKeyY = parseNumber(_currentKeyY);
	/*XP*/
	_nextKey = format["%1_%2",_currentKeyX + _Keydifferenz,_currentKeyY];
	_nextValue = getNumber(missionconfigFile >> "maps" >> worldname >> _nextKey >> "XM");
	if (_nextValue > 0) then {
		private ["_nextPos","_value","_inside"];
		_nextPos = getArray(missionconfigFile >> "maps" >> worldname >> _nextKey >> "position");
		_value = _currentWay + _currentDistance + (If (_evade) then {[_nextKey] call FUNC(waypoints_evade)}else{0}); 
		_inside = 0;
		_inside = ({
				If ((_x select 3)isEqualTo _nextKey) then {
					If ((_x select 0)>_value) then {
						_x set [0,_value];
						_x set [2,_currentWay + _nextValue];
					};
					true;
				}else{false;};
			}count _waypointsActivated) + (
			{
				If ((_x select 3) isEqualTo _nextKey) then {true;}else{false;};
			}count _waypointsDeactivated);
		If (_inside < 1) then {
			_waypointsActivated pushBack [_value,floor((_nextPos distance2D _targetKeypos)*10),_currentWay + _nextValue,_nextKey];
		};
	};
	If ((_nextValue > 0)&&(_nextKey isEqualTo _targetKey)) exitWith {
		_waypointsDeactivated pushBack (_waypointsActivated deleteAt 0);
		_waypointsDeactivated pushBack [-1,0,0,_targetKey];
		_active = false;
	};
	/*XM*/
	_nextKey = format["%1_%2",_currentKeyX - _Keydifferenz,_currentKeyY];
	_nextValue = getNumber(missionconfigFile >> "maps" >> worldname >> _nextKey >> "XP");
	if (_nextValue > 0) then {
		private ["_nextPos","_value","_inside"];
		_nextPos = getArray(missionconfigFile >> "maps" >> worldname >> _nextKey >> "position");
		_value = _currentWay + _currentDistance + (If (_evade) then {[_nextKey] call FUNC(waypoints_evade)}else{0}); 
		_inside = 0;
		_inside = ({
				If ((_x select 3)isEqualTo _nextKey) then {
					If ((_x select 0)>_value) then {
						_x set [0,_value];
						_x set [2,_currentWay + _nextValue];
					};
					true;
				}else{false;};
			}count _waypointsActivated) + (
			{
				If ((_x select 3) isEqualTo _nextKey) then {true;}else{false;};
			}count _waypointsDeactivated);
		If (_inside < 1) then {
			_waypointsActivated pushBack [_value,floor((_nextPos distance2D _targetKeypos)*10),_currentWay + _nextValue,_nextKey];
		};
	};
	If ((_nextValue > 0)&&(_nextKey isEqualTo _targetKey)) exitWith {
		_waypointsDeactivated pushBack (_waypointsActivated deleteAt 0);
		_waypointsDeactivated pushBack [-1,0,0,_targetKey];
		_active = false;
	};
	/*YP*/
	_nextKey = format["%1_%2",_currentKeyX,_currentKeyY + _Keydifferenz];
	_nextValue = getNumber(missionconfigFile >> "maps" >> worldname >> _nextKey >> "YM");
	if (_nextValue > 0) then {
		private ["_nextPos","_value","_inside"];
		_nextPos = getArray(missionconfigFile >> "maps" >> worldname >> _nextKey >> "position");
		_value = _currentWay + _currentDistance + (If (_evade) then {[_nextKey] call FUNC(waypoints_evade)}else{0}); 
		_inside = 0;
		_inside = ({
				If ((_x select 3)isEqualTo _nextKey) then {
					If ((_x select 0)>_value) then {
						_x set [0,_value];
						_x set [2,_currentWay + _nextValue];
					};
					true;
				}else{false;};
			}count _waypointsActivated) + (
			{
				If ((_x select 3) isEqualTo _nextKey) then {true;}else{false;};
			}count _waypointsDeactivated);
		If (_inside < 1) then {
			_waypointsActivated pushBack [_value,floor((_nextPos distance2D _targetKeypos)*10),_currentWay + _nextValue,_nextKey];
		};
	};
	If ((_nextValue > 0)&&(_nextKey isEqualTo _targetKey)) exitWith {
		_waypointsDeactivated pushBack (_waypointsActivated deleteAt 0);
		_waypointsDeactivated pushBack [-1,0,0,_targetKey];
		_active = false;
	};
	/*YM*/
	_nextKey = format["%1_%2",_currentKeyX,_currentKeyY - _Keydifferenz];
	_nextValue = getNumber(missionconfigFile >> "maps" >> worldname >> _nextKey >> "YP");
	if (_nextValue > 0) then {
		private ["_nextPos","_value","_inside"];
		_nextPos = getArray(missionconfigFile >> "maps" >> worldname >> _nextKey >> "position");
		_value = _currentWay + _currentDistance + (If (_evade) then {[_nextKey] call FUNC(waypoints_evade)}else{0}); 
		_inside = 0;
		_inside = ({
				If ((_x select 3)isEqualTo _nextKey) then {
					If ((_x select 0)>_value) then {
						_x set [0,_value];
						_x set [2,_currentWay + _nextValue];
					};
					true;
				}else{false;};
			}count _waypointsActivated) + (
			{
				If ((_x select 3) isEqualTo _nextKey) then {true;}else{false;};
			}count _waypointsDeactivated);
		If (_inside < 1) then {
			_waypointsActivated pushBack [_value,floor((_nextPos distance2D _targetKeypos)*10),_currentWay + _nextValue,_nextKey];
		};
	};
	If ((_nextValue > 0)&&(_nextKey isEqualTo _targetKey)) exitWith {
		_waypointsDeactivated pushBack (_waypointsActivated deleteAt 0);
		_waypointsDeactivated pushBack [-1,0,0,_targetKey];
		_active = false;
	};
	////////
	////////
	////////
	/*XPYP*/
	_nextKey = format["%1_%2",_currentKeyX + _Keydifferenz,_currentKeyY + _Keydifferenz];
	_nextValue = getNumber(missionconfigFile >> "maps" >> worldname >> _nextKey >> "XMYM");
	if (_nextValue > 0) then {
		private ["_nextPos","_value","_inside"];
		_nextPos = getArray(missionconfigFile >> "maps" >> worldname >> _nextKey >> "position");
		_value = _currentWay + _currentDistance + (If (_evade) then {[_nextKey] call FUNC(waypoints_evade)}else{0}); 
		_inside = 0;
		_inside = ({
				If ((_x select 3)isEqualTo _nextKey) then {
					If ((_x select 0)>_value) then {
						_x set [0,_value];
						_x set [2,_currentWay + _nextValue];
					};
					true;
				}else{false;};
			}count _waypointsActivated) + (
			{
				If ((_x select 3) isEqualTo _nextKey) then {true;}else{false;};
			}count _waypointsDeactivated);
		If (_inside < 1) then {
			_waypointsActivated pushBack [_value,floor((_nextPos distance2D _targetKeypos)*10),_currentWay + _nextValue,_nextKey];
		};
	};
	If ((_nextValue > 0)&&(_nextKey isEqualTo _targetKey)) exitWith {
		_waypointsDeactivated pushBack (_waypointsActivated deleteAt 0);
		_waypointsDeactivated pushBack [-1,0,0,_targetKey];
		_active = false;
	};
	/*XMYM*/
	_nextKey = format["%1_%2",_currentKeyX - _Keydifferenz,_currentKeyY - _Keydifferenz];
	_nextValue = getNumber(missionconfigFile >> "maps" >> worldname >> _nextKey >> "XPYP");
	if (_nextValue > 0) then {
		private ["_nextPos","_value","_inside"];
		_nextPos = getArray(missionconfigFile >> "maps" >> worldname >> _nextKey >> "position");
		_value = _currentWay + _currentDistance + (If (_evade) then {[_nextKey] call FUNC(waypoints_evade)}else{0}); 
		_inside = 0;
		_inside = ({
				If ((_x select 3)isEqualTo _nextKey) then {
					If ((_x select 0)>_value) then {
						_x set [0,_value];
						_x set [2,_currentWay + _nextValue];
					};
					true;
				}else{false;};
			}count _waypointsActivated) + (
			{
				If ((_x select 3) isEqualTo _nextKey) then {true;}else{false;};
			}count _waypointsDeactivated);
		If (_inside < 1) then {
			_waypointsActivated pushBack [_value,floor((_nextPos distance2D _targetKeypos)*10),_currentWay + _nextValue,_nextKey];
		};
	};
	If ((_nextValue > 0)&&(_nextKey isEqualTo _targetKey)) exitWith {
		_waypointsDeactivated pushBack (_waypointsActivated deleteAt 0);
		_waypointsDeactivated pushBack [-1,0,0,_targetKey];
		_active = false;
	};
	/*XMYP*/
	_nextKey = format["%1_%2",_currentKeyX - _Keydifferenz,_currentKeyY + _Keydifferenz];
	_nextValue = getNumber(missionconfigFile >> "maps" >> worldname >> _nextKey >> "XPYM");
	if (_nextValue > 0) then {
		private ["_nextPos","_value","_inside"];
		_nextPos = getArray(missionconfigFile >> "maps" >> worldname >> _nextKey >> "position");
		_value = _currentWay + _currentDistance + (If (_evade) then {[_nextKey] call FUNC(waypoints_evade)}else{0}); 
		_inside = 0;
		_inside = ({
				If ((_x select 3)isEqualTo _nextKey) then {
					If ((_x select 0)>_value) then {
						_x set [0,_value];
						_x set [2,_currentWay + _nextValue];
					};
					true;
				}else{false;};
			}count _waypointsActivated) + (
			{
				If ((_x select 3) isEqualTo _nextKey) then {true;}else{false;};
			}count _waypointsDeactivated);
		If (_inside < 1) then {
			_waypointsActivated pushBack [_value,floor((_nextPos distance2D _targetKeypos)*10),_currentWay + _nextValue,_nextKey];
		};
	};
	If ((_nextValue > 0)&&(_nextKey isEqualTo _targetKey)) exitWith {
		_waypointsDeactivated pushBack (_waypointsActivated deleteAt 0);
		_waypointsDeactivated pushBack [-1,0,0,_targetKey];
		_active = false;
	};
	/*XPYM*/
	_nextKey = format["%1_%2",_currentKeyX + _Keydifferenz,_currentKeyY - _Keydifferenz];
	_nextValue = getNumber(missionconfigFile >> "maps" >> worldname >> _nextKey >> "XMYP");
	if (_nextValue > 0) then {
		private ["_nextPos","_value","_inside"];
		_nextPos = getArray(missionconfigFile >> "maps" >> worldname >> _nextKey >> "position");
		_value = _currentWay + _currentDistance + (If (_evade) then {[_nextKey] call FUNC(waypoints_evade)}else{0}); 
		_inside = 0;
		_inside = ({
				If ((_x select 3)isEqualTo _nextKey) then {
					If ((_x select 0)>_value) then {
						_x set [0,_value];
						_x set [2,_currentWay + _nextValue];
					};
					true;
				}else{false;};
			}count _waypointsActivated) + (
			{
				If ((_x select 3) isEqualTo _nextKey) then {true;}else{false;};
			}count _waypointsDeactivated);
		If (_inside < 1) then {
			_waypointsActivated pushBack [_value,floor((_nextPos distance2D _targetKeypos)*10),_currentWay + _nextValue,_nextKey];
		};
	};
	If ((_nextValue > 0)&&(_nextKey isEqualTo _targetKey)) exitWith {
		_waypointsDeactivated pushBack (_waypointsActivated deleteAt 0);
		_waypointsDeactivated pushBack [-1,0,0,_targetKey];
		_active = false;
	};
	
	_delete = (_waypointsActivated deleteAt 0);
	_waypointsDeactivated pushBack _delete;
};



{
	#ifdef DEBUG_MODE_FULL
		[getArray(missionconfigFile >> "maps" >> worldname >> (_x select 3) >> "position"),format["%1_%2_%3",_x select 0,_x select 1,_x select 2]] call EFUNC(common,debug_marker_create);
	#endif
}forEach _waypointsActivated;

{
	#ifdef DEBUG_MODE_FULL
		[getArray(missionconfigFile >> "maps" >> worldname >> (_x select 3) >> "position"),format["%1_%2_%3",_x select 0,_x select 1,_x select 2],"ColorBlue"] call EFUNC(common,debug_marker_create);
	#endif
}forEach _waypointsDeactivated;



_waypoints = [(_waypointsDeactivated deleteAt ((count _waypointsDeactivated) -1))select 3];
_active = true;
while {_active} do {
	_currentWpKey = _waypoints select ((count _waypoints) -1);
	_nextWP = "";
	if (_currentWpKey isEqualTo _startKey) exitWith {_active=false;};
	_value = 999999999;
	_value2 = 999999999;
	
	(_currentWpKey splitString "_") params ["_currentKeyX","_currentKeyY"];
	_currentKeyX = parseNumber(_currentKeyX);
	_currentKeyY = parseNumber(_currentKeyY);
	
	{
		_curWP = _x;
		_tempVal = -1;
		If !(_curWP in _waypoints) then {
			{
				If ((_x select 3)isEqualTo _curWP) then {
					If ((_x select 0)<=_value) then {
						If ((_x select 2)<=_value2) then {
							_nextWP = _x select 3;
							_value = _x select 0;
							_value2 = _x select 2;
						};
					};
				};
			} forEach _waypointsDeactivated;
		};
	}forEach [
		format["%1_%2",_currentKeyX + _Keydifferenz,_currentKeyY],
		format["%1_%2",_currentKeyX - _Keydifferenz,_currentKeyY],
		format["%1_%2",_currentKeyX,_currentKeyY + _Keydifferenz],
		format["%1_%2",_currentKeyX,_currentKeyY - _Keydifferenz],
		format["%1_%2",_currentKeyX - _Keydifferenz,_currentKeyY - _Keydifferenz],
		format["%1_%2",_currentKeyX + _Keydifferenz,_currentKeyY + _Keydifferenz],
		format["%1_%2",_currentKeyX - _Keydifferenz,_currentKeyY + _Keydifferenz],
		format["%1_%2",_currentKeyX + _Keydifferenz,_currentKeyY - _Keydifferenz],
		format["%1_%2",_currentKeyX - _Keydifferenz,_currentKeyY - _Keydifferenz]
		];
	If !(_nextWP isEqualTo "") then {
		_waypoints append [_nextWP];
		#ifdef DEBUG_MODE_FULL
		[getArray(missionconfigFile >> "maps" >> worldname >> _nextWP >> "position"),"","ColorBlack","hd_objective"] call EFUNC(common,debug_marker_create);
		#endif
	};
};

private ["_return"];
reverse _waypoints;
_return = [_start];
{
	_return pushBack (getArray(missionconfigFile >> "maps" >> worldname >> _x >> "position"));
} forEach _waypoints;
_return = _return pushBack _target;
_return





