Vehicle_ComponentTotal(vehicleid)
{
	new count = 0;
    foreach(new pv : PVehicles)
    {
        if(vehicleid == pvData[pv][cVeh])
        {
            count += pvData[pv][cComponent];
        }
    }        
	return count;
}

CMD:unloadcomponent(playerid, params[])
{
	new ammount;
	if(sscanf(params, "d", ammount)) return Usage(playerid, "/unloadcomponent [ammount]");
	
    new Float: x, Float: y, Float: z;
    new vehicleid = GetPVarInt(playerid, "LastVehicleID");
    GetVehicleBoot(GetPVarInt(playerid, "LastVehicleID"), x, y, z);
    if(GetPlayerDistanceFromPoint(playerid, x, y, z) > 3.0) return Error(playerid, "Your last vehicle is too far away.");  
    if(!IsAMechanic(vehicleid)) return Error(playerid, "You have to use a pickup type car");
    
	if(ammount < pData[playerid][pComponent])
	{
		foreach(new pv : PVehicles)
		{
			if(vehicleid == pvData[pv][cVeh])
			{
				pvData[pv][cComponent] -= ammount;
				pData[playerid][pComponent] += ammount;
				SendClientMessageEx(playerid, COLOR_ARWIN, "COMPONENT: {FFFFFF}You have taken "YELLOW_E"%d "GREEN_E"Component "WHITE_E"from inside the pickup truck, total components: "YELLOW_E"%d", ammount, pvData[pv][cComponent]);
				if(pvData[pv][cComponent] == 0)
				{
					if(IsValidDynamicObject(ObjectVehicle[pvData[pv][cVeh]][0]))
					{
						DestroyDynamicObject(ObjectVehicle[pvData[pv][cVeh]][0]);
					}
					
				}
			}
		}
	}
	else SendClientMessage(playerid, -1, "ERROR: You don't have a component");
    return 1;
}

CMD:loadcomponent(playerid, params[])
{
	new ammount;
	if(sscanf(params, "d", ammount)) return Usage(playerid, "/loadcomponent [ammount]");
	
    new Float: x, Float: y, Float: z;
    new vehicleid = GetPVarInt(playerid, "LastVehicleID");
    GetVehicleBoot(GetPVarInt(playerid, "LastVehicleID"), x, y, z);
    if(GetPlayerDistanceFromPoint(playerid, x, y, z) > 3.0) return Error(playerid, "Your last vehicle is too far away.");  
    if(Vehicle_ComponentTotal(vehicleid) >= 1000) return Error(playerid, "You can no longer load component onto this vehicle.");    
    if(!IsAMechanic(vehicleid)) return Error(playerid, "You have to use a pickup type car");
    
	if(pData[playerid][pComponent] > ammount)
	{
		foreach(new pv : PVehicles)
		{
			if(vehicleid == pvData[pv][cVeh])
			{
				pvData[pv][cComponent] += ammount;
				pData[playerid][pComponent] -= ammount;
				SendClientMessageEx(playerid, COLOR_ARWIN, "COMPONENT: {FFFFFF}You've loaded "YELLOW_E"%d "GREEN_E"Component "WHITE_E"into the pickup truck, amount stored: "YELLOW_E"%d", ammount, pvData[pv][cComponent]);
				if(IsValidDynamicObject(ObjectVehicle[pvData[pv][cVeh]][0]))
				{
					DestroyDynamicObject(ObjectVehicle[pvData[pv][cVeh]][0]);
				}

				if(GetVehicleModel(pvData[pv][cVeh]) == 422)
				{
					ObjectVehicle[pvData[pv][cVeh]][0] = CreateDynamicObject(964,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
					AttachDynamicObjectToVehicle(ObjectVehicle[pvData[pv][cVeh]][0], pvData[pv][cVeh], 0.000, -1.370, -0.320, 0.000, 0.000, 0.000);
				}
				else if(GetVehicleModel(pvData[pv][cVeh]) == 543)
				{
					ObjectVehicle[pvData[pv][cVeh]][0] = CreateDynamicObject(964,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
					AttachDynamicObjectToVehicle(ObjectVehicle[pvData[pv][cVeh]][0], pvData[pv][cVeh], 0.000, -1.521, -0.250, 0.000, 0.000, 0.000);
				}	
				else if(GetVehicleModel(pvData[pv][cVeh]) == 525)
				{
					ObjectVehicle[pvData[pv][cVeh]][0] = CreateDynamicObject(964,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
					AttachDynamicObjectToVehicle(ObjectVehicle[pvData[pv][cVeh]][0], pvData[pv][cVeh], 0.000, -1.000, 0.190, 0.000, 0.000, 0.000);
				}
			}
		}
	}
	else SendClientMessage(playerid, -1, "ERROR: You don't have a component");
    return 1;
}

CMD:buytowtruck(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, 2330.1626,-2315.2642,13.5469)) return Error(playerid, "You have to be at the mechanic point");
	if(pData[playerid][pJob] == 2 || pData[playerid][pJob2] == 2)
	{
		new cost = GetVehicleCost(525);
		if(GetPlayerMoney(playerid) < cost) return Error(playerid, "Your money is not enough to buy a vehicle");
		new count = 0, limit = MAX_PLAYER_VEHICLE + pData[playerid][pVip];
		foreach(new ii : PVehicles)
		{
			if(pvData[ii][cOwner] == pData[playerid][pID])
				count++;
		}
		if(count >= limit)
		{
			Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
			return 1;
		}
		Server_Save();
		GivePlayerMoneyEx(playerid, -cost);
		new cQuery[1024];
		new Float:x,Float:y,Float:z, Float:a;
		new model, color1, color2;
		color1 = 0;
		color2 = 0;
		model = 525;
		x = 2320.6848;
		y = -2314.9629;
		z = 13.1147;
		a = 138.0695;
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, cost, x, y, z, a);
		mysql_tquery(g_SQL, cQuery, "OnVehBuyPV", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, cost, x, y, z, a);
	}
	return 1;
}

CMD:acceptmecha(playerid, params[])
{
	static otherid, Float:x, Float:y, Float:z;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/acceptmecha [playerid/PartOfName]");
	if(pData[playerid][pJob] == 2 || pData[playerid][pJob2] == 2)
	{
		if(pData[otherid][pMechaCall] > 0)
		{
			GetPlayerPos(otherid, x, y, z);
			SetPlayerCheckpoint(playerid, x, y, z, 5.0);
			SendClientMessageEx(playerid, COLOR_ARWIN, "SERVICE: "WHITE_E"You've accepted the mechanic request from {00FFFF}%s "YELLOW_E"%d", pData[otherid][pName], pData[otherid][pPhone]);
			SendClientMessageEx(otherid, COLOR_ARWIN, "SERVICE: {00FFFF}%s "YELLOW_E"(%d) "WHITE_E"has accepted your mechanic call. Please wait patiently until they arrive.", pData[playerid][pName], pData[playerid][pPhone]);
			SendClientMessageEx(playerid, COLOR_ARWIN, "SERVICE: Notes from client: "YELLOW_E"%s", pData[otherid][pServiceText]);
			SendClientMessageEx(playerid, COLOR_ARWIN, "GPS: Navigation set to client's current location");
			pData[otherid][pMechaCall] = -1;
			format(pData[otherid][pServiceText], 128, "");
		}
		else
		{
			Error(playerid, "That Player does not require any taxi service");
		}
	}	
	return 1;
}

CMD:vm(playerid, params[])
{
	if(pData[playerid][pJob] == 2 || pData[playerid][pJob2] == 2)
	{
		if(pData[playerid][pWorkshop] == -1)
		{
			if(pData[playerid][pMechDuty] == 1)
			{
				if(pData[playerid][pMechVeh] == INVALID_VEHICLE_ID)
				{
					new vehicleid = GetNearestVehicleToPlayer(playerid, 3.5, false);
					if(!GetHoodStatus(vehicleid) && !IsABike(vehicleid)) return Error(playerid,"Please open the vehicle Hood before checking services");

					if(vehicleid == INVALID_VEHICLE_ID) return Error(playerid, "Anda tidak berada di dekat kendaraan mana pun.");

					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "Anda sudah memeriksa kendaraan!");

					Info(playerid, "Don't move from your position or you will fail to check this vehicle!");
					
					pData[playerid][pMechanic] = SetTimerEx("CheckCar", 500, true, "dd", playerid, vehicleid);
					PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Examining Vehicle");
					PlayerTextDrawShow(playerid, ActiveTD[playerid]);
					ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					foreach(new pid : Player) 
					{
						if (pvData[vehicleid][cOwner] == pData[pid][pID])
						{
							SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"has started examining your {00FFFF}%s", pData[playerid][pName], GetVehicleName(vehicleid));
						}	
					}	
					return 1;
				}

				if(GetNearestVehicleToPlayer(playerid, 3.5, false) == pData[playerid][pMechVeh])
				{
					new Dstring[800], Float:health, engine;
					new panels, doors, light, tires, body;
					GetVehicleHealth(pData[playerid][pMechVeh], health);
					if(health > 1000.0) health = 1000.0;
					if(health > 0.0) health *= -1;
					engine = floatround(health, floatround_round) / 10 + 100;
					
					GetVehicleDamageStatus(pData[playerid][pMechVeh], panels, doors, light, tires);
					new cpanels = panels / 1000000;
					new lights = light / 2;
					new pintu;
					if(doors != 0) pintu = 5;
					if(doors == 0) pintu = 0;
					body = cpanels + lights + pintu + 20;
					format(Dstring, sizeof(Dstring), "Action\tComponent Cost\n\
					Repair Engine\t%d\n", engine);
					format(Dstring, sizeof(Dstring), "%sReplace Tires\t50\n", Dstring);
					format(Dstring, sizeof(Dstring), "%sRepair Body\t%d\n", Dstring, body);
					format(Dstring, sizeof(Dstring), "%sRespray Color\t60\n", Dstring);
					format(Dstring, sizeof(Dstring), "%sVehicle Upgrade\n", Dstring);
					ShowPlayerDialog(playerid, DIALOG_SERVICE, DIALOG_STYLE_TABLIST_HEADERS, "Vehicle Menu", Dstring, "Service", "Cancel");	
				}
				else
				{
					KillTimer(pData[playerid][pMechanic]);
					HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
					PlayerTextDrawHide(playerid, ActiveTD[playerid]);
					pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
					pData[playerid][pActivityTime] = 0;
					Info(playerid, "Your previous customer's vehicle has gone too far.");
					return 1;
				}
			}
			else return Error(playerid, "Anda harus on duty mechanic");
		}
		else
		{
			if(pData[playerid][pMechVeh] == INVALID_VEHICLE_ID)
			{
				new vehicleid = GetNearestVehicleToPlayer(playerid, 3.5, false);
				if(!GetHoodStatus(vehicleid) && !IsABike(vehicleid)) return Error(playerid,"Please open the vehicle Hood before checking services");
				if(vehicleid == INVALID_VEHICLE_ID) return Error(playerid, "Anda tidak berada di dekat kendaraan mana pun.");

				if(pData[playerid][pActivityTime] > 5) return Error(playerid, "Anda sudah memeriksa kendaraan!");

				Info(playerid, "Don't move from your position or you will fail to check this vehicle!");
				
				pData[playerid][pMechanic] = SetTimerEx("CheckCar", 500, true, "dd", playerid, vehicleid);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Examining Vehicle");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
				return 1;
			}

			if(GetNearestVehicleToPlayer(playerid, 3.5, false) == pData[playerid][pMechVeh])
			{
				new Dstring[800], Float:health, engine;
				new panels, doors, light, tires, body;
				GetVehicleHealth(pData[playerid][pMechVeh], health);
				if(health > 1000.0) health = 1000.0;
				if(health > 0.0) health *= -1;
				engine = floatround(health, floatround_round) / 10 + 100;
				
				GetVehicleDamageStatus(pData[playerid][pMechVeh], panels, doors, light, tires);
				new cpanels = panels / 1000000;
				new lights = light / 2;
				new pintu;
				if(doors != 0) pintu = 5;
				if(doors == 0) pintu = 0;
				body = cpanels + lights + pintu + 20;
				format(Dstring, sizeof(Dstring), "Action\tComponent Cost\n\
				Repair Engine\t%d\n", engine);
				format(Dstring, sizeof(Dstring), "%sReplace Tires\t50\n", Dstring);
				format(Dstring, sizeof(Dstring), "%sRepair Body\t%d\n", Dstring, body);
				format(Dstring, sizeof(Dstring), "%sRespray Color\t60\n", Dstring);
				format(Dstring, sizeof(Dstring), "%sVehicle Upgrade\n", Dstring);
				format(Dstring, sizeof(Dstring), "%sRemove Modification\n", Dstring);
				format(Dstring, sizeof(Dstring), "%sInstall Modification\n", Dstring);
				ShowPlayerDialog(playerid, DIALOG_SERVICE, DIALOG_STYLE_TABLIST_HEADERS, "Vehicle Menu", Dstring, "Service", "Cancel");	
			}
			else
			{
				KillTimer(pData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
				pData[playerid][pActivityTime] = 0;
				Info(playerid, "Your previous customer's vehicle has gone too far.");
				return 1;
			}
		}
	}
	else return Error(playerid, "You are not a mechanic!");	
	return 1;
}

// Private Vehicle Components
new pv_spoiler[20][0] =
{
	{1000},
	{1001},
	{1002},
	{1003},
	{1014},
	{1015},
	{1016},
	{1023},
	{1058},
	{1060},
	{1049},
	{1050},
	{1138},
	{1139},
	{1146},
	{1147},
	{1158},
	{1162},
	{1163},
	{1164}
};
new pv_nitro[3][0] =
{
    {1008},
    {1009},
    {1010}
};
new pv_fbumper[23][0] =
{
    {1117},
    {1152},
    {1153},
    {1155},
    {1157},
    {1160},
    {1165},
    {1166},
    {1169},
    {1170},
    {1171},
    {1172},
    {1173},
    {1174},
    {1175},
    {1179},
    {1181},
    {1182},
    {1185},
    {1188},
    {1189},
    {1190},
    {1191}
};
new pv_rbumper[22][0] =
{
    {1140},
    {1141},
    {1148},
    {1149},
    {1150},
    {1151},
    {1154},
    {1156},
    {1159},
    {1161},
    {1167},
    {1168},
    {1176},
    {1177},
    {1178},
    {1180},
    {1183},
    {1184},
    {1186},
    {1187},
    {1192},
    {1193}
};
new pv_exhaust[28][0] =
{
    {1018},
    {1019},
    {1020},
    {1021},
    {1022},
    {1028},
    {1029},
    {1037},
    {1043},
    {1044},
    {1045},
    {1046},
    {1059},
    {1064},
    {1065},
    {1066},
    {1089},
    {1092},
    {1104},
    {1105},
    {1113},
    {1114},
    {1126},
    {1127},
    {1129},
    {1132},
    {1135},
    {1136}
};
new pv_bventr[2][0] =
{
    {1142},
    {1144}
};
new pv_bventl[2][0] =
{
    {1143},
    {1145}
};
new pv_bscoop[4][0] =
{
	{1004},
	{1005},
	{1011},
	{1012}
};
new pv_roof[17][0] =
{
    {1006},
    {1032},
    {1033},
    {1035},
    {1038},
    {1053},
    {1054},
    {1055},
    {1061},
    {1067},
    {1068},
    {1088},
    {1091},
    {1103},
    {1128},
    {1130},
    {1131}
};
new pv_lskirt[21][0] =
{
    {1007},
    {1026},
    {1031},
    {1036},
    {1039},
    {1042},
    {1047},
    {1048},
    {1056},
    {1057},
    {1069},
    {1070},
    {1090},
    {1093},
    {1106},
    {1108},
    {1118},
    {1119},
    {1133},
    {1122},
    {1134}
};
new pv_rskirt[21][0] =
{
    {1017},
    {1027},
    {1030},
    {1040},
    {1041},
    {1051},
    {1052},
    {1062},
    {1063},
    {1071},
    {1072},
    {1094},
    {1095},
    {1099},
    {1101},
    {1102},
    {1107},
    {1120},
    {1121},
    {1124},
    {1137}
};
new pv_hydraulics[1][0] =
{
    {1087}
};
new pv_base[1][0] =
{
    {1086}
};
new pv_rbbars[4][0] =
{
    {1109},
    {1110},
    {1123},
    {1125}
};
new pv_fbbars[2][0] =
{
    {1115},
    {1116}
};
new pv_wheels[17][0] =
{
    {1025},
    {1073},
    {1074},
    {1075},
    {1076},
    {1077},
    {1078},
    {1079},
    {1080},
    {1081},
    {1082},
    {1083},
    {1084},
    {1085},
    {1096},
    {1097},
    {1098}
};
new pv_lights[2][0] =
{
	{1013},
	{1024}
};

//Mech JOB
function CheckCar(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	//if(!IsValidVehicle(vehicleid)) return 0;
	if(!IsValidTimer(pData[playerid][pMechanic])) return 0;
	if(pData[playerid][pJob] == 2 || pData[playerid][pJob2] == 2)
	{
		if(GetNearestVehicleToPlayer(playerid, 10.0, false) == vehicleid)
		{
			if(pData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
			{
				pData[playerid][pMechVeh] = vehicleid;
				InfoTD_MSG(playerid, 8000, "Checking done!");
				//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has successfully refulling the vehicle.", ReturnName(playerid));
				KillTimer(pData[playerid][pMechanic]);
				pData[playerid][pActivityTime] = 0;
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				TogglePlayerControllable(playerid, 1);
				ClearAnimations(playerid);
				return 1;
			}
			else if(pData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
			{
				pData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
			}
			else
			{
				Error(playerid, "Check files! You are not near the vehicle!");
				KillTimer(pData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				pData[playerid][pActivityTime] = 0;
				pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			}
		}
		else
		{
			Error(playerid, "Check files! You are not near the vehicle!");
			KillTimer(pData[playerid][pMechanic]);
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pActivityTime] = 0;
			pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			return 1;
		}
	}
	return 1;
}

function BodyFix(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	//if(!IsValidVehicle(vehicleid)) return 0;
	if(!IsValidTimer(pData[playerid][pMechanic])) return 0;
	if(pData[playerid][pJob] == 2 || pData[playerid][pJob2] == 2)
	{
		if(GetNearestVehicleToPlayer(playerid, 10.0, false) == vehicleid)
		{
			if(pData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
			{
				new panels, doors, light, tires;	
				GetVehicleDamageStatus(vehicleid, panels, doors, light, tires);		
				UpdateVehicleDamageStatus(vehicleid, 0, 0, 0, tires);
				
				InfoTD_MSG(playerid, 8000, "Fix body done!");
				pData[playerid][pMechVeh] = vehicleid;
				KillTimer(pData[playerid][pMechanic]);
				pData[playerid][pActivityTime] = 0;
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				ClearAnimations(playerid);
				return 1;
			}
			else if(pData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
			{
				pData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
			}
			else
			{
				Error(playerid, "Body fix file! You are not near the vehicle!");
				KillTimer(pData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				pData[playerid][pActivityTime] = 0;
				pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			}
		}
		else
		{
			Error(playerid, "Body fix file! You are not near the vehicle!");
			KillTimer(pData[playerid][pMechanic]);
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pActivityTime] = 0;
			pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			return 1;
		}
	}
	return 1;
}

function EngineFix(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	//if(!IsValidVehicle(vehicleid)) return 0;
	if(!IsValidTimer(pData[playerid][pMechanic])) return 0;
	if(pData[playerid][pJob] == 2 || pData[playerid][pJob2] == 2)
	{
		if(GetNearestVehicleToPlayer(playerid, 10.0, false) == vehicleid)
		{
			if(pData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
			{
				if(pvData[vehicleid][cMesinUpgrade] == 2)
				{
				    PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
					SetVehicleHealth(vehicleid, 2000.0);
					InfoTD_MSG(playerid, 8000, "Fix engine done!");
					pData[playerid][pMechVeh] = vehicleid;
					KillTimer(pData[playerid][pMechanic]);
					pData[playerid][pActivityTime] = 0;
					HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
					PlayerTextDrawHide(playerid, ActiveTD[playerid]);
					ClearAnimations(playerid);
				}
				else
				{
				    PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
				    SetVehicleHealth(vehicleid, 1000.0);
					InfoTD_MSG(playerid, 8000, "Fix engine done!");
					pData[playerid][pMechVeh] = vehicleid;
					KillTimer(pData[playerid][pMechanic]);
					pData[playerid][pActivityTime] = 0;
					HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
					PlayerTextDrawHide(playerid, ActiveTD[playerid]);
					ClearAnimations(playerid);
				}
				return 1;
			}
			else if(pData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
			{
				pData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
			}
			else
			{
				Error(playerid, "Engine fix fail! You are not near the vehicle!");
				KillTimer(pData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				pData[playerid][pActivityTime] = 0;
				pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			}
		}
		else
		{
			Error(playerid, "Engine fix fail! You are not near the vehicle!");
			KillTimer(pData[playerid][pMechanic]);
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pActivityTime] = 0;
			pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			return 1;
		}
	}
	return 1;
}

function TiresFix(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	//if(!IsValidVehicle(vehicleid)) return 0;
	if(!IsValidTimer(pData[playerid][pMechanic])) return 0;
	if(pData[playerid][pJob] == 2 || pData[playerid][pJob2] == 2)
	{
		if(GetNearestVehicleToPlayer(playerid, 10.0, false) == vehicleid)
		{
			if(pData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
			{
				new panels, doors, light, tires;	
				GetVehicleDamageStatus(vehicleid, panels, doors, light, tires);		
				UpdateVehicleDamageStatus(vehicleid, panels, doors, light, 0);
				
				InfoTD_MSG(playerid, 8000, "Fix Wheel done!");
				pData[playerid][pMechVeh] = vehicleid;
				KillTimer(pData[playerid][pMechanic]);
				pData[playerid][pActivityTime] = 0;
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				ClearAnimations(playerid);
				return 1;
			}
			else if(pData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
			{
				pData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
			}
			else
			{
				Error(playerid, "fix Wheel fail! You are not near the vehicle!");
				KillTimer(pData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				pData[playerid][pActivityTime] = 0;
				pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			}
		}
		else
		{
			Error(playerid, "fix Wheel fail! You are not near the vehicle!");
			KillTimer(pData[playerid][pMechanic]);
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pActivityTime] = 0;
			pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			return 1;
		}
	}
	return 1;
}

function SprayCar(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	//if(!IsValidVehicle(vehicleid)) return 0;
	if(!IsValidTimer(pData[playerid][pMechanic])) return 0;
	if(pData[playerid][pJob] == 2 || pData[playerid][pJob2] == 2)
	{
		if(GetNearestVehicleToPlayer(playerid, 10.0, false) == vehicleid)
		{
			if(pData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
			{
				
				ChangeVehicleColor(vehicleid, pData[playerid][pMechColor1], pData[playerid][pMechColor2]);
				foreach(new ii : PVehicles)
				{
					if(vehicleid == pvData[ii][cVeh])
					{
						pvData[ii][cColor1] = pData[playerid][pMechColor1];
						pvData[ii][cColor2] = pData[playerid][pMechColor2];
					}
				}
				InfoTD_MSG(playerid, 8000, "Spraying done!");
				pData[playerid][pMechVeh] = vehicleid;
				KillTimer(pData[playerid][pMechanic]);
				pData[playerid][pActivityTime] = 0;
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				ClearAnimations(playerid);
				return 1;
			}
			else if(pData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
			{
				pData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
			}
			else
			{
				Error(playerid, "Spraying car fail! You are not near the vehicle!");
				KillTimer(pData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				pData[playerid][pActivityTime] = 0;
				pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			}
		}
		else
		{
			Error(playerid, "Engine fix fail! You are not near the vehicle!");
			KillTimer(pData[playerid][pMechanic]);
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pActivityTime] = 0;
			pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			return 1;
		}
	}
	return 1;
}

function PaintjobCar(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	//if(!IsValidVehicle(vehicleid)) return 0;
	if(!IsValidTimer(pData[playerid][pMechanic])) return 0;
	if(pData[playerid][pJob] == 2 || pData[playerid][pJob2] == 2)
	{
		if(GetNearestVehicleToPlayer(playerid, 10.0, false) == vehicleid)
		{
			if(pData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
			{
				
				ChangeVehiclePaintjob(vehicleid, pData[playerid][pMechColor1]);
				foreach(new ii : PVehicles)
				{
					if(vehicleid == pvData[ii][cVeh])
					{
						pvData[ii][cPaintJob] = pData[playerid][pMechColor1];
					}
				}
				
				InfoTD_MSG(playerid, 8000, "Painting done!");
				pData[playerid][pMechVeh] = vehicleid;
				KillTimer(pData[playerid][pMechanic]);
				pData[playerid][pActivityTime] = 0;
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				ClearAnimations(playerid);
				return 1;
			}
			else if(pData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
			{
				pData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
			}
			else
			{
				Error(playerid, "Spraying car fail! You are not near the vehicle!");
				KillTimer(pData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				pData[playerid][pActivityTime] = 0;
				pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			}
		}
		else
		{
			Error(playerid, "Engine fix fail! You are not near the vehicle!");
			KillTimer(pData[playerid][pMechanic]);
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pActivityTime] = 0;
			pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			return 1;
		}
	}
	return 1;
}

function ModifCar(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	//if(!IsValidVehicle(vehicleid)) return 0;
	if(!IsValidTimer(pData[playerid][pMechanic])) return 0;
	if(pData[playerid][pJob] == 2 || pData[playerid][pJob2] == 2)
	{
		if(GetNearestVehicleToPlayer(playerid, 10.0, false) == vehicleid)
		{
			if(pData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
			{
				
				AddVehicleComponent(vehicleid, pData[playerid][pMechColor1]);
				SavePVComponents(vehicleid, pData[playerid][pMechColor1]);
				if(pData[playerid][pMechColor2] != 0)
				{
					AddVehicleComponent(vehicleid, pData[playerid][pMechColor2]);
					SavePVComponents(vehicleid, pData[playerid][pMechColor2]);
				}
				
				InfoTD_MSG(playerid, 8000, "Modif done!");
				pData[playerid][pMechVeh] = vehicleid;
				KillTimer(pData[playerid][pMechanic]);
				pData[playerid][pActivityTime] = 0;
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				TogglePlayerControllable(playerid, 1);
				ClearAnimations(playerid);
				PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
				return 1;
			}
			else if(pData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
			{
				pData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
			}
			else
			{
				Error(playerid, "Spraying car fail! You are not near the vehicle!");
				KillTimer(pData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				pData[playerid][pActivityTime] = 0;
				pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			}
		}
		else
		{
			Error(playerid, "Mofid fix fail! You are not near the vehicle!");
			KillTimer(pData[playerid][pMechanic]);
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pActivityTime] = 0;
			pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			return 1;
		}
	}
	return 1;
}

function UpgradeBody(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	//if(!IsValidVehicle(vehicleid)) return 0;
	if(!IsValidTimer(pData[playerid][pMechanic])) return 0;
	if(pData[playerid][pJob] == 2 || pData[playerid][pJob2] == 2)
	{
		if(GetNearestVehicleToPlayer(playerid, 10.0, false) == vehicleid)
		{
			if(pData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
			{
				foreach(new ii : PVehicles)
				{
					if(vehicleid == pvData[ii][cVeh])
					{
						pvData[ii][pvBodyUpgrade] = 1;
					}
				}
				InfoTD_MSG(playerid, 8000, "Upgrade done!");
				pData[playerid][pMechVeh] = vehicleid;
				KillTimer(pData[playerid][pMechanic]);
				pData[playerid][pActivityTime] = 0;
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				ClearAnimations(playerid);
				return 1;
			}
			else if(pData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
			{
				pData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
			}
			else
			{
				Error(playerid, "Upgrade Mesin fail! You are not near the vehicle!");
				KillTimer(pData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				pData[playerid][pActivityTime] = 0;
				pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			}
		}
		else
		{
			Error(playerid, "Upgrade Body fail! You are not near the vehicle!");
			KillTimer(pData[playerid][pMechanic]);
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pActivityTime] = 0;
			pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			return 1;
		}
	}
	return 1;
}

function UpgradeMesin(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	//if(!IsValidVehicle(vehicleid)) return 0;
	if(!IsValidTimer(pData[playerid][pMechanic])) return 0;
	if(pData[playerid][pJob] == 2 || pData[playerid][pJob2] == 2)
	{
		if(GetNearestVehicleToPlayer(playerid, 10.0, false) == vehicleid)
		{
			if(pData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
			{
				foreach(new ii : PVehicles)
				{
					if(vehicleid == pvData[ii][cVeh])
					{
						pvData[ii][cMesinUpgrade] = 1;
					}
				}
				InfoTD_MSG(playerid, 8000, "Upgrade done!");
				pData[playerid][pMechVeh] = vehicleid;
				KillTimer(pData[playerid][pMechanic]);
				pData[playerid][pActivityTime] = 0;
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				ClearAnimations(playerid);
				return 1;
			}
			else if(pData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
			{
				pData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
			}
			else
			{
				Error(playerid, "Upgrade Mesin fail! You are not near the vehicle!");
				KillTimer(pData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				pData[playerid][pActivityTime] = 0;
				pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			}
		}
		else
		{
			Error(playerid, "Upgrade Mesin fail! You are not near the vehicle!");
			KillTimer(pData[playerid][pMechanic]);
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pActivityTime] = 0;
			pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			return 1;
		}
	}
	return 1;
}

function NeonCar(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	//if(!IsValidVehicle(vehicleid)) return 0;
	if(!IsValidTimer(pData[playerid][pMechanic])) return 0;
	if(pData[playerid][pJob] == 2 || pData[playerid][pJob2] == 2)
	{
		if(GetNearestVehicleToPlayer(playerid, 10.0, false) == vehicleid)
		{
			if(pData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
			{
				if(pData[playerid][pMechColor1] == 0)
				{
					SetVehicleNeonLights(vehicleid, false, pData[playerid][pMechColor1], 0);
				}
				else
				{
					SetVehicleNeonLights(vehicleid, true, pData[playerid][pMechColor1], 0);
				}
				foreach(new ii : PVehicles)
				{
					if(vehicleid == pvData[ii][cVeh])
					{
						pvData[ii][cNeon] = pData[playerid][pMechColor1];
						
						if(pvData[ii][cNeon] == 0)
						{
							pvData[ii][cTogNeon] = 0;
						}
						else
						{
							pvData[ii][cTogNeon] = 1;
						}
					}
				}
				
				InfoTD_MSG(playerid, 8000, "Neon done!");
				pData[playerid][pMechVeh] = vehicleid;
				KillTimer(pData[playerid][pMechanic]);
				pData[playerid][pActivityTime] = 0;
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				ClearAnimations(playerid);
				return 1;
			}
			else if(pData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
			{
				pData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
			}
			else
			{
				Error(playerid, "Spraying car fail! You are not near the vehicle!");
				KillTimer(pData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				pData[playerid][pActivityTime] = 0;
				pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			}
		}
		else
		{
			Error(playerid, "Engine fix fail! You are not near the vehicle!");
			KillTimer(pData[playerid][pMechanic]);
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pActivityTime] = 0;
			pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			return 1;
		}
	}
	return 1;
}

function RemoveModification1(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidTimer(pData[playerid][pMechanic])) return 0;
	if(pData[playerid][pJob] == 2 || pData[playerid][pJob2] == 2)
	{
		if(GetNearestVehicleToPlayer(playerid, 10.0, false) == vehicleid)
		{
			if(pData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
			{
				foreach(new i : PVehicles)
				{
					if(vehicleid == pvData[i][cVeh])
					{
						pvData[i][cMod][0] = 0;
						new Float:XX,Float:YY,Float:ZZ; new Float:CarHP, Float:OldCarHP; new panels,doors,lights,tires;
						GetVehicleDamageStatus(pvData[i][cVeh],panels,doors,lights,tires);
						GetVehicleHealth(pvData[i][cVeh], CarHP); OldCarHP = CarHP;
						GetVehiclePos(pvData[i][cVeh],XX,YY,ZZ);
						SetVehicleToRespawn(pvData[i][cVeh]); SetVehiclePos(pvData[i][cVeh],XX,YY,ZZ);
						SetVehicleHealth(pvData[i][cVeh], OldCarHP);
						UpdateVehicleDamageStatus(pvData[i][cVeh],panels,doors,lights,tires);
						if(pvData[i][cPaintJob] != -1)
						{
							ChangeVehiclePaintjob(pvData[i][cVeh], pvData[i][cPaintJob]);
						}
						for(new mod = 0; mod < MAX_MODS; mod++)
						{
							if(pvData[i][cMod][mod]) AddVehicleComponent(pvData[i][cVeh], pvData[i][cMod][mod]);
						}
						if(pvData[i][cLocked] == 1)
						{
							SwitchVehicleDoors(pvData[i][cVeh], true);
						}
						else
						{
							SwitchVehicleDoors(pvData[i][cVeh], false);
						}
					}
				}
				pData[playerid][pMechVeh] = vehicleid;
				KillTimer(pData[playerid][pMechanic]);
				pData[playerid][pActivityTime] = 0;
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				ClearAnimations(playerid);
				return 1;
			}
			else if(pData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
			{
				pData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
			}
			else
			{
				Error(playerid, "Remove Modification fail! You are not near the vehicle!");
				KillTimer(pData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				pData[playerid][pActivityTime] = 0;
				pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			}
		}
		else
		{
			Error(playerid, "Remove Modificatio fail! You are not near the vehicle!");
			KillTimer(pData[playerid][pMechanic]);
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pActivityTime] = 0;
			pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			return 1;
		}
	}
	return 1;
}

function RemoveModification2(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidTimer(pData[playerid][pMechanic])) return 0;
	if(pData[playerid][pJob] == 2 || pData[playerid][pJob2] == 2)
	{
		if(GetNearestVehicleToPlayer(playerid, 10.0, false) == vehicleid)
		{
			if(pData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
			{
				foreach(new i : PVehicles)
				{
					if(vehicleid == pvData[i][cVeh])
					{
						pvData[i][cMod][1] = 0;
						new Float:XX,Float:YY,Float:ZZ; new Float:CarHP, Float:OldCarHP; new panels,doors,lights,tires;
						GetVehicleDamageStatus(pvData[i][cVeh],panels,doors,lights,tires);
						GetVehicleHealth(pvData[i][cVeh], CarHP); OldCarHP = CarHP;
						GetVehiclePos(pvData[i][cVeh],XX,YY,ZZ);
						SetVehicleToRespawn(pvData[i][cVeh]); SetVehiclePos(pvData[i][cVeh],XX,YY,ZZ);
						SetVehicleHealth(pvData[i][cVeh], OldCarHP);
						UpdateVehicleDamageStatus(pvData[i][cVeh],panels,doors,lights,tires);
						if(pvData[i][cPaintJob] != -1)
						{
							ChangeVehiclePaintjob(pvData[i][cVeh], pvData[i][cPaintJob]);
						}
						for(new mod = 0; mod < MAX_MODS; mod++)
						{
							if(pvData[i][cMod][mod]) AddVehicleComponent(pvData[i][cVeh], pvData[i][cMod][mod]);
						}
						if(pvData[i][cLocked] == 1)
						{
							SwitchVehicleDoors(pvData[i][cVeh], true);
						}
						else
						{
							SwitchVehicleDoors(pvData[i][cVeh], false);
						}
					}
				}
				
				pData[playerid][pMechVeh] = vehicleid;
				KillTimer(pData[playerid][pMechanic]);
				pData[playerid][pActivityTime] = 0;
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				ClearAnimations(playerid);
				return 1;
			}
			else if(pData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
			{
				pData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
			}
			else
			{
				Error(playerid, "Remove Modification fail! You are not near the vehicle!");
				KillTimer(pData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				pData[playerid][pActivityTime] = 0;
				pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			}
		}
		else
		{
			Error(playerid, "Remove Modificatio fail! You are not near the vehicle!");
			KillTimer(pData[playerid][pMechanic]);
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pActivityTime] = 0;
			pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			return 1;
		}
	}
	return 1;
}

function RemoveModification3(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidTimer(pData[playerid][pMechanic])) return 0;
	if(pData[playerid][pJob] == 2 || pData[playerid][pJob2] == 2)
	{
		if(GetNearestVehicleToPlayer(playerid, 10.0, false) == vehicleid)
		{
			if(pData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
			{
				foreach(new i : PVehicles)
				{
					if(vehicleid == pvData[i][cVeh])
					{
						pvData[i][cMod][2] = 0;
						new Float:XX,Float:YY,Float:ZZ; new Float:CarHP, Float:OldCarHP; new panels,doors,lights,tires;
						GetVehicleDamageStatus(pvData[i][cVeh],panels,doors,lights,tires);
						GetVehicleHealth(pvData[i][cVeh], CarHP); OldCarHP = CarHP;
						GetVehiclePos(pvData[i][cVeh],XX,YY,ZZ);
						SetVehicleToRespawn(pvData[i][cVeh]); SetVehiclePos(pvData[i][cVeh],XX,YY,ZZ);
						SetVehicleHealth(pvData[i][cVeh], OldCarHP);
						UpdateVehicleDamageStatus(pvData[i][cVeh],panels,doors,lights,tires);
						if(pvData[i][cPaintJob] != -1)
						{
							ChangeVehiclePaintjob(pvData[i][cVeh], pvData[i][cPaintJob]);
						}
						for(new mod = 0; mod < MAX_MODS; mod++)
						{
							if(pvData[i][cMod][mod]) AddVehicleComponent(pvData[i][cVeh], pvData[i][cMod][mod]);
						}
						if(pvData[i][cLocked] == 1)
						{
							SwitchVehicleDoors(pvData[i][cVeh], true);
						}
						else
						{
							SwitchVehicleDoors(pvData[i][cVeh], false);
						}
					}
				}
				pData[playerid][pMechVeh] = vehicleid;
				KillTimer(pData[playerid][pMechanic]);
				pData[playerid][pActivityTime] = 0;
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				ClearAnimations(playerid);
				return 1;
			}
			else if(pData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
			{
				pData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
			}
			else
			{
				Error(playerid, "Remove Modification fail! You are not near the vehicle!");
				KillTimer(pData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				pData[playerid][pActivityTime] = 0;
				pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			}
		}
		else
		{
			Error(playerid, "Remove Modificatio fail! You are not near the vehicle!");
			KillTimer(pData[playerid][pMechanic]);
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pActivityTime] = 0;
			pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			return 1;
		}
	}
	return 1;
}

function RemoveModification4(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidTimer(pData[playerid][pMechanic])) return 0;
	if(pData[playerid][pJob] == 2 || pData[playerid][pJob2] == 2)
	{
		if(GetNearestVehicleToPlayer(playerid, 10.0, false) == vehicleid)
		{
			if(pData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
			{
				foreach(new i : PVehicles)
				{
					if(vehicleid == pvData[i][cVeh])
					{
						pvData[i][cMod][3] = 0;
						new Float:XX,Float:YY,Float:ZZ; new Float:CarHP, Float:OldCarHP; new panels,doors,lights,tires;
						GetVehicleDamageStatus(pvData[i][cVeh],panels,doors,lights,tires);
						GetVehicleHealth(pvData[i][cVeh], CarHP); OldCarHP = CarHP;
						GetVehiclePos(pvData[i][cVeh],XX,YY,ZZ);
						SetVehicleToRespawn(pvData[i][cVeh]); SetVehiclePos(pvData[i][cVeh],XX,YY,ZZ);
						SetVehicleHealth(pvData[i][cVeh], OldCarHP);
						UpdateVehicleDamageStatus(pvData[i][cVeh],panels,doors,lights,tires);
						if(pvData[i][cPaintJob] != -1)
						{
							ChangeVehiclePaintjob(pvData[i][cVeh], pvData[i][cPaintJob]);
						}
						for(new mod = 0; mod < MAX_MODS; mod++)
						{
							if(pvData[i][cMod][mod]) AddVehicleComponent(pvData[i][cVeh], pvData[i][cMod][mod]);
						}
						if(pvData[i][cLocked] == 1)
						{
							SwitchVehicleDoors(pvData[i][cVeh], true);
						}
						else
						{
							SwitchVehicleDoors(pvData[i][cVeh], false);
						}
					}
				}
				pData[playerid][pMechVeh] = vehicleid;
				KillTimer(pData[playerid][pMechanic]);
				pData[playerid][pActivityTime] = 0;
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				ClearAnimations(playerid);
				return 1;
			}
			else if(pData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
			{
				pData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
			}
			else
			{
				Error(playerid, "Remove Modification fail! You are not near the vehicle!");
				KillTimer(pData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				pData[playerid][pActivityTime] = 0;
				pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			}
		}
		else
		{
			Error(playerid, "Remove Modificatio fail! You are not near the vehicle!");
			KillTimer(pData[playerid][pMechanic]);
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pActivityTime] = 0;
			pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			return 1;
		}
	}
	return 1;
}

function RemoveModification5(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidTimer(pData[playerid][pMechanic])) return 0;
	if(pData[playerid][pJob] == 2 || pData[playerid][pJob2] == 2)
	{
		if(GetNearestVehicleToPlayer(playerid, 10.0, false) == vehicleid)
		{
			if(pData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
			{
				foreach(new i : PVehicles)
				{
					if(vehicleid == pvData[i][cVeh])
					{
						pvData[i][cMod][4] = 0;
						new Float:XX,Float:YY,Float:ZZ; new Float:CarHP, Float:OldCarHP; new panels,doors,lights,tires;
						GetVehicleDamageStatus(pvData[i][cVeh],panels,doors,lights,tires);
						GetVehicleHealth(pvData[i][cVeh], CarHP); OldCarHP = CarHP;
						GetVehiclePos(pvData[i][cVeh],XX,YY,ZZ);
						SetVehicleToRespawn(pvData[i][cVeh]); SetVehiclePos(pvData[i][cVeh],XX,YY,ZZ);
						SetVehicleHealth(pvData[i][cVeh], OldCarHP);
						UpdateVehicleDamageStatus(pvData[i][cVeh],panels,doors,lights,tires);
						if(pvData[i][cPaintJob] != -1)
						{
							ChangeVehiclePaintjob(pvData[i][cVeh], pvData[i][cPaintJob]);
						}
						for(new mod = 0; mod < MAX_MODS; mod++)
						{
							if(pvData[i][cMod][mod]) AddVehicleComponent(pvData[i][cVeh], pvData[i][cMod][mod]);
						}
						if(pvData[i][cLocked] == 1)
						{
							SwitchVehicleDoors(pvData[i][cVeh], true);
						}
						else
						{
							SwitchVehicleDoors(pvData[i][cVeh], false);
						}
					}
				}
				pData[playerid][pMechVeh] = vehicleid;
				KillTimer(pData[playerid][pMechanic]);
				pData[playerid][pActivityTime] = 0;
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				ClearAnimations(playerid);
				return 1;
			}
			else if(pData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
			{
				pData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
			}
			else
			{
				Error(playerid, "Remove Modification fail! You are not near the vehicle!");
				KillTimer(pData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				pData[playerid][pActivityTime] = 0;
				pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			}
		}
		else
		{
			Error(playerid, "Remove Modificatio fail! You are not near the vehicle!");
			KillTimer(pData[playerid][pMechanic]);
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pActivityTime] = 0;
			pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			return 1;
		}
	}
	return 1;
}

function RemoveModification6(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidTimer(pData[playerid][pMechanic])) return 0;
	if(pData[playerid][pJob] == 2 || pData[playerid][pJob2] == 2)
	{
		if(GetNearestVehicleToPlayer(playerid, 10.0, false) == vehicleid)
		{
			if(pData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
			{
				foreach(new i : PVehicles)
				{
					if(vehicleid == pvData[i][cVeh])
					{
						pvData[i][cMod][5] = 0;
						new Float:XX,Float:YY,Float:ZZ; new Float:CarHP, Float:OldCarHP; new panels,doors,lights,tires;
						GetVehicleDamageStatus(pvData[i][cVeh],panels,doors,lights,tires);
						GetVehicleHealth(pvData[i][cVeh], CarHP); OldCarHP = CarHP;
						GetVehiclePos(pvData[i][cVeh],XX,YY,ZZ);
						SetVehicleToRespawn(pvData[i][cVeh]); SetVehiclePos(pvData[i][cVeh],XX,YY,ZZ);
						SetVehicleHealth(pvData[i][cVeh], OldCarHP);
						UpdateVehicleDamageStatus(pvData[i][cVeh],panels,doors,lights,tires);
						if(pvData[i][cPaintJob] != -1)
						{
							ChangeVehiclePaintjob(pvData[i][cVeh], pvData[i][cPaintJob]);
						}
						for(new mod = 0; mod < MAX_MODS; mod++)
						{
							if(pvData[i][cMod][mod]) AddVehicleComponent(pvData[i][cVeh], pvData[i][cMod][mod]);
						}
						if(pvData[i][cLocked] == 1)
						{
							SwitchVehicleDoors(pvData[i][cVeh], true);
						}
						else
						{
							SwitchVehicleDoors(pvData[i][cVeh], false);
						}
					}
				}
				pData[playerid][pMechVeh] = vehicleid;
				KillTimer(pData[playerid][pMechanic]);
				pData[playerid][pActivityTime] = 0;
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				ClearAnimations(playerid);
				return 1;
			}
			else if(pData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
			{
				pData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
			}
			else
			{
				Error(playerid, "Remove Modification fail! You are not near the vehicle!");
				KillTimer(pData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				pData[playerid][pActivityTime] = 0;
				pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			}
		}
		else
		{
			Error(playerid, "Remove Modificatio fail! You are not near the vehicle!");
			KillTimer(pData[playerid][pMechanic]);
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pActivityTime] = 0;
			pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			return 1;
		}
	}
	return 1;
}

function RemoveModification7(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidTimer(pData[playerid][pMechanic])) return 0;
	if(pData[playerid][pJob] == 2 || pData[playerid][pJob2] == 2)
	{
		if(GetNearestVehicleToPlayer(playerid, 10.0, false) == vehicleid)
		{
			if(pData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
			{
				foreach(new i : PVehicles)
				{
					if(vehicleid == pvData[i][cVeh])
					{
						pvData[i][cMod][6] = 0;
						new Float:XX,Float:YY,Float:ZZ; new Float:CarHP, Float:OldCarHP; new panels,doors,lights,tires;
						GetVehicleDamageStatus(pvData[i][cVeh],panels,doors,lights,tires);
						GetVehicleHealth(pvData[i][cVeh], CarHP); OldCarHP = CarHP;
						GetVehiclePos(pvData[i][cVeh],XX,YY,ZZ);
						SetVehicleToRespawn(pvData[i][cVeh]); SetVehiclePos(pvData[i][cVeh],XX,YY,ZZ);
						SetVehicleHealth(pvData[i][cVeh], OldCarHP);
						UpdateVehicleDamageStatus(pvData[i][cVeh],panels,doors,lights,tires);
						if(pvData[i][cPaintJob] != -1)
						{
							ChangeVehiclePaintjob(pvData[i][cVeh], pvData[i][cPaintJob]);
						}
						for(new mod = 0; mod < MAX_MODS; mod++)
						{
							if(pvData[i][cMod][mod]) AddVehicleComponent(pvData[i][cVeh], pvData[i][cMod][mod]);
						}
						if(pvData[i][cLocked] == 1)
						{
							SwitchVehicleDoors(pvData[i][cVeh], true);
						}
						else
						{
							SwitchVehicleDoors(pvData[i][cVeh], false);
						}
					}
				}
				pData[playerid][pMechVeh] = vehicleid;
				KillTimer(pData[playerid][pMechanic]);
				pData[playerid][pActivityTime] = 0;
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				ClearAnimations(playerid);
				return 1;
			}
			else if(pData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
			{
				pData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
			}
			else
			{
				Error(playerid, "Remove Modification fail! You are not near the vehicle!");
				KillTimer(pData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				pData[playerid][pActivityTime] = 0;
				pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			}
		}
		else
		{
			Error(playerid, "Remove Modificatio fail! You are not near the vehicle!");
			KillTimer(pData[playerid][pMechanic]);
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pActivityTime] = 0;
			pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			return 1;
		}
	}
	return 1;
}

function RemoveModification8(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidTimer(pData[playerid][pMechanic])) return 0;
	if(pData[playerid][pJob] == 2 || pData[playerid][pJob2] == 2)
	{
		if(GetNearestVehicleToPlayer(playerid, 10.0, false) == vehicleid)
		{
			if(pData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
			{
				foreach(new i : PVehicles)
				{
					if(vehicleid == pvData[i][cVeh])
					{
						pvData[i][cMod][7] = 0;
						new Float:XX,Float:YY,Float:ZZ; new Float:CarHP, Float:OldCarHP; new panels,doors,lights,tires;
						GetVehicleDamageStatus(pvData[i][cVeh],panels,doors,lights,tires);
						GetVehicleHealth(pvData[i][cVeh], CarHP); OldCarHP = CarHP;
						GetVehiclePos(pvData[i][cVeh],XX,YY,ZZ);
						SetVehicleToRespawn(pvData[i][cVeh]); SetVehiclePos(pvData[i][cVeh],XX,YY,ZZ);
						SetVehicleHealth(pvData[i][cVeh], OldCarHP);
						UpdateVehicleDamageStatus(pvData[i][cVeh],panels,doors,lights,tires);
						if(pvData[i][cPaintJob] != -1)
						{
							ChangeVehiclePaintjob(pvData[i][cVeh], pvData[i][cPaintJob]);
						}
						for(new mod = 0; mod < MAX_MODS; mod++)
						{
							if(pvData[i][cMod][mod]) AddVehicleComponent(pvData[i][cVeh], pvData[i][cMod][mod]);
						}
						if(pvData[i][cLocked] == 1)
						{
							SwitchVehicleDoors(pvData[i][cVeh], true);
						}
						else
						{
							SwitchVehicleDoors(pvData[i][cVeh], false);
						}
					}
				}
				pData[playerid][pMechVeh] = vehicleid;
				KillTimer(pData[playerid][pMechanic]);
				pData[playerid][pActivityTime] = 0;
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				ClearAnimations(playerid);
				return 1;
			}
			else if(pData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
			{
				pData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
			}
			else
			{
				Error(playerid, "Remove Modification fail! You are not near the vehicle!");
				KillTimer(pData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				pData[playerid][pActivityTime] = 0;
				pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			}
		}
		else
		{
			Error(playerid, "Remove Modificatio fail! You are not near the vehicle!");
			KillTimer(pData[playerid][pMechanic]);
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pActivityTime] = 0;
			pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			return 1;
		}
	}
	return 1;
}

function RemoveModification9(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidTimer(pData[playerid][pMechanic])) return 0;
	if(pData[playerid][pJob] == 2 || pData[playerid][pJob2] == 2)
	{
		if(GetNearestVehicleToPlayer(playerid, 10.0, false) == vehicleid)
		{
			if(pData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
			{
				foreach(new i : PVehicles)
				{
					if(vehicleid == pvData[i][cVeh])
					{
						pvData[i][cMod][8] = 0;
						new Float:XX,Float:YY,Float:ZZ; new Float:CarHP, Float:OldCarHP; new panels,doors,lights,tires;
						GetVehicleDamageStatus(pvData[i][cVeh],panels,doors,lights,tires);
						GetVehicleHealth(pvData[i][cVeh], CarHP); OldCarHP = CarHP;
						GetVehiclePos(pvData[i][cVeh],XX,YY,ZZ);
						SetVehicleToRespawn(pvData[i][cVeh]); SetVehiclePos(pvData[i][cVeh],XX,YY,ZZ);
						SetVehicleHealth(pvData[i][cVeh], OldCarHP);
						UpdateVehicleDamageStatus(pvData[i][cVeh],panels,doors,lights,tires);
						if(pvData[i][cPaintJob] != -1)
						{
							ChangeVehiclePaintjob(pvData[i][cVeh], pvData[i][cPaintJob]);
						}
						for(new mod = 0; mod < MAX_MODS; mod++)
						{
							if(pvData[i][cMod][mod]) AddVehicleComponent(pvData[i][cVeh], pvData[i][cMod][mod]);
						}
						if(pvData[i][cLocked] == 1)
						{
							SwitchVehicleDoors(pvData[i][cVeh], true);
						}
						else
						{
							SwitchVehicleDoors(pvData[i][cVeh], false);
						}
					}
				}
				pData[playerid][pMechVeh] = vehicleid;
				KillTimer(pData[playerid][pMechanic]);
				pData[playerid][pActivityTime] = 0;
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				ClearAnimations(playerid);
				return 1;
			}
			else if(pData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
			{
				pData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
			}
			else
			{
				Error(playerid, "Remove Modification fail! You are not near the vehicle!");
				KillTimer(pData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				pData[playerid][pActivityTime] = 0;
				pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			}
		}
		else
		{
			Error(playerid, "Remove Modificatio fail! You are not near the vehicle!");
			KillTimer(pData[playerid][pMechanic]);
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pActivityTime] = 0;
			pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			return 1;
		}
	}
	return 1;
}

function RemoveModification10(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidTimer(pData[playerid][pMechanic])) return 0;
	if(pData[playerid][pJob] == 2 || pData[playerid][pJob2] == 2)
	{
		if(GetNearestVehicleToPlayer(playerid, 10.0, false) == vehicleid)
		{
			if(pData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
			{
				foreach(new i : PVehicles)
				{
					if(vehicleid == pvData[i][cVeh])
					{
						pvData[i][cMod][8] = 0;
						new Float:XX,Float:YY,Float:ZZ; new Float:CarHP, Float:OldCarHP; new panels,doors,lights,tires;
						GetVehicleDamageStatus(pvData[i][cVeh],panels,doors,lights,tires);
						GetVehicleHealth(pvData[i][cVeh], CarHP); OldCarHP = CarHP;
						GetVehiclePos(pvData[i][cVeh],XX,YY,ZZ);
						SetVehicleToRespawn(pvData[i][cVeh]); SetVehiclePos(pvData[i][cVeh],XX,YY,ZZ);
						SetVehicleHealth(pvData[i][cVeh], OldCarHP);
						UpdateVehicleDamageStatus(pvData[i][cVeh],panels,doors,lights,tires);
						if(pvData[i][cPaintJob] != -1)
						{
							ChangeVehiclePaintjob(pvData[i][cVeh], pvData[i][cPaintJob]);
						}
						for(new mod = 0; mod < MAX_MODS; mod++)
						{
							if(pvData[i][cMod][mod]) AddVehicleComponent(pvData[i][cVeh], pvData[i][cMod][mod]);
						}
						if(pvData[i][cLocked] == 1)
						{
							SwitchVehicleDoors(pvData[i][cVeh], true);
						}
						else
						{
							SwitchVehicleDoors(pvData[i][cVeh], false);
						}
					}
				}
				pData[playerid][pMechVeh] = vehicleid;
				KillTimer(pData[playerid][pMechanic]);
				pData[playerid][pActivityTime] = 0;
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				ClearAnimations(playerid);
				return 1;
			}
			else if(pData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
			{
				pData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
			}
			else
			{
				Error(playerid, "Remove Modification fail! You are not near the vehicle!");
				KillTimer(pData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				pData[playerid][pActivityTime] = 0;
				pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			}
		}
		else
		{
			Error(playerid, "Remove Modificatio fail! You are not near the vehicle!");
			KillTimer(pData[playerid][pMechanic]);
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pActivityTime] = 0;
			pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			return 1;
		}
	}
	return 1;
}

function RemoveModification11(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidTimer(pData[playerid][pMechanic])) return 0;
	if(pData[playerid][pJob] == 2 || pData[playerid][pJob2] == 2)
	{
		if(GetNearestVehicleToPlayer(playerid, 10.0, false) == vehicleid)
		{
			if(pData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
			{
				foreach(new i : PVehicles)
				{
					if(vehicleid == pvData[i][cVeh])
					{
						pvData[i][cMod][10] = 0;
						new Float:XX,Float:YY,Float:ZZ; new Float:CarHP, Float:OldCarHP; new panels,doors,lights,tires;
						GetVehicleDamageStatus(pvData[i][cVeh],panels,doors,lights,tires);
						GetVehicleHealth(pvData[i][cVeh], CarHP); OldCarHP = CarHP;
						GetVehiclePos(pvData[i][cVeh],XX,YY,ZZ);
						SetVehicleToRespawn(pvData[i][cVeh]); SetVehiclePos(pvData[i][cVeh],XX,YY,ZZ);
						SetVehicleHealth(pvData[i][cVeh], OldCarHP);
						UpdateVehicleDamageStatus(pvData[i][cVeh],panels,doors,lights,tires);
						if(pvData[i][cPaintJob] != -1)
						{
							ChangeVehiclePaintjob(pvData[i][cVeh], pvData[i][cPaintJob]);
						}
						for(new mod = 0; mod < MAX_MODS; mod++)
						{
							if(pvData[i][cMod][mod]) AddVehicleComponent(pvData[i][cVeh], pvData[i][cMod][mod]);
						}
						if(pvData[i][cLocked] == 1)
						{
							SwitchVehicleDoors(pvData[i][cVeh], true);
						}
						else
						{
							SwitchVehicleDoors(pvData[i][cVeh], false);
						}
					}
				}
				pData[playerid][pMechVeh] = vehicleid;
				KillTimer(pData[playerid][pMechanic]);
				pData[playerid][pActivityTime] = 0;
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				ClearAnimations(playerid);
				return 1;
			}
			else if(pData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
			{
				pData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
			}
			else
			{
				Error(playerid, "Remove Modification fail! You are not near the vehicle!");
				KillTimer(pData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				pData[playerid][pActivityTime] = 0;
				pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			}
		}
		else
		{
			Error(playerid, "Remove Modificatio fail! You are not near the vehicle!");
			KillTimer(pData[playerid][pMechanic]);
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pActivityTime] = 0;
			pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			return 1;
		}
	}
	return 1;
}

function RemoveModification12(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidTimer(pData[playerid][pMechanic])) return 0;
	if(pData[playerid][pJob] == 2 || pData[playerid][pJob2] == 2)
	{
		if(GetNearestVehicleToPlayer(playerid, 10.0, false) == vehicleid)
		{
			if(pData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
			{
				foreach(new i : PVehicles)
				{
					if(vehicleid == pvData[i][cVeh])
					{
						pvData[i][cMod][11] = 0;
						new Float:XX,Float:YY,Float:ZZ; new Float:CarHP, Float:OldCarHP; new panels,doors,lights,tires;
						GetVehicleDamageStatus(pvData[i][cVeh],panels,doors,lights,tires);
						GetVehicleHealth(pvData[i][cVeh], CarHP); OldCarHP = CarHP;
						GetVehiclePos(pvData[i][cVeh],XX,YY,ZZ);
						SetVehicleToRespawn(pvData[i][cVeh]); SetVehiclePos(pvData[i][cVeh],XX,YY,ZZ);
						SetVehicleHealth(pvData[i][cVeh], OldCarHP);
						UpdateVehicleDamageStatus(pvData[i][cVeh],panels,doors,lights,tires);
						if(pvData[i][cPaintJob] != -1)
						{
							ChangeVehiclePaintjob(pvData[i][cVeh], pvData[i][cPaintJob]);
						}
						for(new mod = 0; mod < MAX_MODS; mod++)
						{
							if(pvData[i][cMod][mod]) AddVehicleComponent(pvData[i][cVeh], pvData[i][cMod][mod]);
						}
						if(pvData[i][cLocked] == 1)
						{
							SwitchVehicleDoors(pvData[i][cVeh], true);
						}
						else
						{
							SwitchVehicleDoors(pvData[i][cVeh], false);
						}
					}
				}
				pData[playerid][pMechVeh] = vehicleid;
				KillTimer(pData[playerid][pMechanic]);
				pData[playerid][pActivityTime] = 0;
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				ClearAnimations(playerid);
				return 1;
			}
			else if(pData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
			{
				pData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
			}
			else
			{
				Error(playerid, "Remove Modification fail! You are not near the vehicle!");
				KillTimer(pData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				pData[playerid][pActivityTime] = 0;
				pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			}
		}
		else
		{
			Error(playerid, "Remove Modificatio fail! You are not near the vehicle!");
			KillTimer(pData[playerid][pMechanic]);
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pActivityTime] = 0;
			pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			return 1;
		}
	}
	return 1;
}

function RemoveModification13(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidTimer(pData[playerid][pMechanic])) return 0;
	if(pData[playerid][pJob] == 2 || pData[playerid][pJob2] == 2)
	{
		if(GetNearestVehicleToPlayer(playerid, 10.0, false) == vehicleid)
		{
			if(pData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
			{
				foreach(new i : PVehicles)
				{
					if(vehicleid == pvData[i][cVeh])
					{
						pvData[i][cMod][12] = 0;
						new Float:XX,Float:YY,Float:ZZ; new Float:CarHP, Float:OldCarHP; new panels,doors,lights,tires;
						GetVehicleDamageStatus(pvData[i][cVeh],panels,doors,lights,tires);
						GetVehicleHealth(pvData[i][cVeh], CarHP); OldCarHP = CarHP;
						GetVehiclePos(pvData[i][cVeh],XX,YY,ZZ);
						SetVehicleToRespawn(pvData[i][cVeh]); SetVehiclePos(pvData[i][cVeh],XX,YY,ZZ);
						SetVehicleHealth(pvData[i][cVeh], OldCarHP);
						UpdateVehicleDamageStatus(pvData[i][cVeh],panels,doors,lights,tires);
						if(pvData[i][cPaintJob] != -1)
						{
							ChangeVehiclePaintjob(pvData[i][cVeh], pvData[i][cPaintJob]);
						}
						for(new mod = 0; mod < MAX_MODS; mod++)
						{
							if(pvData[i][cMod][mod]) AddVehicleComponent(pvData[i][cVeh], pvData[i][cMod][mod]);
						}
						if(pvData[i][cLocked] == 1)
						{
							SwitchVehicleDoors(pvData[i][cVeh], true);
						}
						else
						{
							SwitchVehicleDoors(pvData[i][cVeh], false);
						}
					}
				}
				pData[playerid][pMechVeh] = vehicleid;
				KillTimer(pData[playerid][pMechanic]);
				pData[playerid][pActivityTime] = 0;
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				ClearAnimations(playerid);
				return 1;
			}
			else if(pData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
			{
				pData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
			}
			else
			{
				Error(playerid, "Remove Modification fail! You are not near the vehicle!");
				KillTimer(pData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				pData[playerid][pActivityTime] = 0;
				pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			}
		}
		else
		{
			Error(playerid, "Remove Modificatio fail! You are not near the vehicle!");
			KillTimer(pData[playerid][pMechanic]);
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pActivityTime] = 0;
			pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			return 1;
		}
	}
	return 1;
}

function RemoveModification14(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidTimer(pData[playerid][pMechanic])) return 0;
	if(pData[playerid][pJob] == 2 || pData[playerid][pJob2] == 2)
	{
		if(GetNearestVehicleToPlayer(playerid, 10.0, false) == vehicleid)
		{
			if(pData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
			{
				foreach(new i : PVehicles)
				{
					if(vehicleid == pvData[i][cVeh])
					{
						pvData[i][cMod][13] = 0;
						new Float:XX,Float:YY,Float:ZZ; new Float:CarHP, Float:OldCarHP; new panels,doors,lights,tires;
						GetVehicleDamageStatus(pvData[i][cVeh],panels,doors,lights,tires);
						GetVehicleHealth(pvData[i][cVeh], CarHP); OldCarHP = CarHP;
						GetVehiclePos(pvData[i][cVeh],XX,YY,ZZ);
						SetVehicleToRespawn(pvData[i][cVeh]); SetVehiclePos(pvData[i][cVeh],XX,YY,ZZ);
						SetVehicleHealth(pvData[i][cVeh], OldCarHP);
						UpdateVehicleDamageStatus(pvData[i][cVeh],panels,doors,lights,tires);
						if(pvData[i][cPaintJob] != -1)
						{
							ChangeVehiclePaintjob(pvData[i][cVeh], pvData[i][cPaintJob]);
						}
						for(new mod = 0; mod < MAX_MODS; mod++)
						{
							if(pvData[i][cMod][mod]) AddVehicleComponent(pvData[i][cVeh], pvData[i][cMod][mod]);
						}
						if(pvData[i][cLocked] == 1)
						{
							SwitchVehicleDoors(pvData[i][cVeh], true);
						}
						else
						{
							SwitchVehicleDoors(pvData[i][cVeh], false);
						}
					}
				}
				pData[playerid][pMechVeh] = vehicleid;
				KillTimer(pData[playerid][pMechanic]);
				pData[playerid][pActivityTime] = 0;
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				ClearAnimations(playerid);
				return 1;
			}
			else if(pData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
			{
				pData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
			}
			else
			{
				Error(playerid, "Remove Modification fail! You are not near the vehicle!");
				KillTimer(pData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				pData[playerid][pActivityTime] = 0;
				pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			}
		}
		else
		{
			Error(playerid, "Remove Modificatio fail! You are not near the vehicle!");
			KillTimer(pData[playerid][pMechanic]);
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pActivityTime] = 0;
			pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
			return 1;
		}
	}
	return 1;
}

//mod0 spoiler
//mod1 hood
//mod2 roof
//mod3 side
//mod4 light
//mod5 nitro
//mod6 knalpot
//mod7 wheel
//mod8 streo
//mod9 hydraulic
//mod10 Front Bumper
//mod11 Rear Bumper
//mod13 vent

SavePVComponents(vehicleid, componentid)
{
	foreach(new ii: PVehicles)
	{
		if(vehicleid == pvData[ii][cVeh])
		{
			for(new s = 0; s < 20; s++)
			{
				if(componentid == pv_spoiler[s][0])
				{
					pvData[ii][cMod][0] = componentid;
				}
			}
			for(new s = 0; s < 4; s++)
			{
				if(componentid == pv_bscoop[s][0])
				{
					pvData[ii][cMod][1] = componentid;
				}
			}
            for(new s = 0; s < 17; s++)
			{
				if(componentid == pv_roof[s][0])
				{
					pvData[ii][cMod][2] = componentid;
				}
			}
            for(new s = 0; s < 21; s++)
			{
				if(componentid == pv_lskirt[s][0])
				{
					pvData[ii][cMod][3] = componentid;
				}
			}
            for(new s = 0; s < 2; s++)
			{
				if(componentid == pv_lights[s][0])
				{
					pvData[ii][cMod][4] = componentid;
				}
			}
            for(new s = 0; s < 3; s++)
			{
				if(componentid == pv_nitro[s][0])
				{
					pvData[ii][cMod][5] = componentid;
				}
			}
            for(new s = 0; s < 28; s++)
			{
				if(componentid == pv_exhaust[s][0])
				{
					pvData[ii][cMod][6] = componentid;
				}
			}
            for(new s = 0; s < 17; s++)
			{
				if(componentid == pv_wheels[s][0])
				{
					pvData[ii][cMod][7] = componentid;
				}
			}
            for(new s = 0; s < 1; s++)
			{
				if(componentid == pv_base[s][0])
				{
					pvData[ii][cMod][8] = componentid;
				}
			}
            for(new s = 0; s < 1; s++)
			{
				if(componentid == pv_hydraulics[s][0])
				{
					pvData[ii][cMod][9] = componentid;
				}
			}
            for(new s = 0; s < 23; s++)
			{
				if(componentid == pv_fbumper[s][0])
				{
					pvData[ii][cMod][10] = componentid;
				}
			}
            for(new s = 0; s < 22; s++)
			{
				if(componentid == pv_rbumper[s][0])
				{
					pvData[ii][cMod][11] = componentid;
				}
			}
            for(new s = 0; s < 2; s++)
			{
				if(componentid == pv_bventl[s][0])
				{
					pvData[ii][cMod][12] = componentid;
				}
			}
            for(new s = 0; s < 2; s++)
			{
				if(componentid == pv_bventr[s][0])
				{
					pvData[ii][cMod][13] = componentid;
				}
			}
            for(new s = 0; s < 21; s++)
			{
				if(componentid == pv_rskirt[s][0])
				{
					pvData[ii][cMod][14] = componentid;
				}
			}
            for(new s = 0; s < 4; s++)
			{
				if(componentid == pv_rbbars[s][0])
				{
					pvData[ii][cMod][15] = componentid;
				}
			}

			for(new s = 0; s < 2; s++)
			{
				if(componentid == pv_fbbars[s][0])
				{
					pvData[ii][cMod][16] = componentid;
				}
			}
        }    
	}
	return 1;
}