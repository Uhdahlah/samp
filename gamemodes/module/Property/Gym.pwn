#define MAX_GYMOBJECT 10
#define MAX_GYMPOINT 10

enum GYMObjectInfo
{
    Float: GYMOBJPosX,
	Float: GYMOBJPosY,
	Float: GYMOBJPosZ,
	Float: GYMOBJPosRX,
	Float: GYMOBJPosRY,
	Float: GYMOBJPosRZ,
	GYMvw,
	GYMint,
	Text3D:GYMOBJText,
	GYMOBJType,
	GYMOBJObject,
	GYMOBJUsed,
	GYMOBJCondition,
    GYMOBJId
};

new GYMInfo[MAX_GYMOBJECT][GYMObjectInfo],
	Iterator:GYMInfo<MAX_OBJECTS>;
new gymEdit[MAX_PLAYERS];
new gymEditID[MAX_PLAYERS];

enum bbInfo
{
    GymId,
	Float:bbPos[3],
	Text3D:bbText,
	bbPickup,
	GymVw,
	GymInt
};
new GymPoint[MAX_GYMPOINT][bbInfo],
	Iterator:GymPoint<MAX_GYMPOINT>;

//Function
function LoadGYMObject()
{
    for(new index = 0; index != cache_num_rows(); index++)
	{
		new id = Iter_Free(GYMInfo), string[512];

		Iter_Add(GYMInfo, index);

        cache_get_value_name_int(id, "id", GYMInfo[id][GYMOBJId]);
		cache_get_value_name_float(id, "posx", GYMInfo[id][GYMOBJPosX]);
		cache_get_value_name_float(id, "posy", GYMInfo[id][GYMOBJPosY]);
		cache_get_value_name_float(id, "posz", GYMInfo[id][GYMOBJPosZ]);
		cache_get_value_name_float(id, "posrx", GYMInfo[id][GYMOBJPosRX]);
		cache_get_value_name_float(id, "posry", GYMInfo[id][GYMOBJPosRY]);
		cache_get_value_name_float(id, "posrz", GYMInfo[id][GYMOBJPosRZ]);
		cache_get_value_name_int(id, "interior", GYMInfo[id][GYMint]);
		cache_get_value_name_int(id, "world", GYMInfo[id][GYMvw]);
		cache_get_value_name_int(id, "objecttype", GYMInfo[id][GYMOBJType]);
		cache_get_value_name_int(id, "objcondition", GYMInfo[id][GYMOBJCondition]);
		cache_get_value_name_int(id, "used", GYMInfo[id][GYMOBJUsed]);

        if(GYMInfo[id][GYMOBJType] == 1)
		{
			GYMInfo[id][GYMOBJObject] = CreateDynamicObject(2627, GYMInfo[id][GYMOBJPosX], GYMInfo[id][GYMOBJPosY], GYMInfo[id][GYMOBJPosZ], GYMInfo[id][GYMOBJPosRX], GYMInfo[id][GYMOBJPosRY], GYMInfo[id][GYMOBJPosRZ], GYMInfo[id][GYMvw], GYMInfo[id][GYMint], -1, 10.0, 10.0);
		}
		if(GYMInfo[id][GYMOBJType] == 2)
		{
			GYMInfo[id][GYMOBJObject] = CreateDynamicObject(2630, GYMInfo[id][GYMOBJPosX], GYMInfo[id][GYMOBJPosY], GYMInfo[id][GYMOBJPosZ], GYMInfo[id][GYMOBJPosRX], GYMInfo[id][GYMOBJPosRY], GYMInfo[id][GYMOBJPosRZ], GYMInfo[id][GYMvw], GYMInfo[id][GYMint], -1, 10.0, 10.0);
		}
		if(GYMInfo[id][GYMOBJType] == 3)
		{
			GYMInfo[id][GYMOBJObject] = CreateDynamicObject(1985, GYMInfo[id][GYMOBJPosX], GYMInfo[id][GYMOBJPosY], GYMInfo[id][GYMOBJPosZ], GYMInfo[id][GYMOBJPosRX], GYMInfo[id][GYMOBJPosRY], GYMInfo[id][GYMOBJPosRZ], GYMInfo[id][GYMvw], GYMInfo[id][GYMint], -1, 10.0, 10.0);
		}
        if(GYMInfo[id][GYMOBJUsed] != 1)
        {
            format(string, 128, "[ID:%d]\n{00FF00}Available\n%d/1000", id, GYMInfo[id][GYMOBJCondition]);
		    GYMInfo[id][GYMOBJText] = CreateDynamic3DTextLabel(string, COLOR_YELLOW, GYMInfo[id][GYMOBJPosX], GYMInfo[id][GYMOBJPosY], GYMInfo[id][GYMOBJPosZ], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GYMInfo[id][GYMvw], GYMInfo[id][GYMint], -1, 10.0);
        }
        else
        {
            format(string, 128, "[ID:%d]\n{FF0000}Not Available\n%d/1000", id, GYMInfo[id][GYMOBJCondition]);
		    GYMInfo[id][GYMOBJText] = CreateDynamic3DTextLabel(string, COLOR_YELLOW, GYMInfo[id][GYMOBJPosX], GYMInfo[id][GYMOBJPosY], GYMInfo[id][GYMOBJPosZ], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GYMInfo[id][GYMvw], GYMInfo[id][GYMint], -1, 10.0);
        }

		Machine_Refresh(id);
	}
	printf("*** [Database: Loaded] GYM Machine data (%d count).", cache_num_rows());
	return 1;
}

SaveGYMObject(id)
{
	new query[500];
	format(query, sizeof(query), "UPDATE gymmachine SET objecttype='%d', objcondition='%d', used='%d', posx='%f', posy='%f', posz='%f', posrx='%f', posry='%f', posrz='%f', interior='%d', world='%d' WHERE id='%d'",
    GYMInfo[id][GYMOBJType],
    GYMInfo[id][GYMOBJCondition],
	GYMInfo[id][GYMOBJUsed],
    GYMInfo[id][GYMOBJPosX],
	GYMInfo[id][GYMOBJPosY],
	GYMInfo[id][GYMOBJPosZ],
	GYMInfo[id][GYMOBJPosRX],
	GYMInfo[id][GYMOBJPosRY],
	GYMInfo[id][GYMOBJPosRZ],
	GYMInfo[id][GYMint],
    GYMInfo[id][GYMvw],
    GYMInfo[id][GYMOBJId]
    );
	mysql_tquery(g_SQL, query);
	return 1;
}

function LoadGym()
{
    for(new index = 0; index != cache_num_rows(); index++)
	{
		new id = Iter_Free(GymPoint), string[512];

		Iter_Add(GymPoint, index);

		cache_get_value_int(id, "id", GymPoint[id][GymId]);
		cache_get_value_float(id, "posx", GymPoint[id][bbPos][0]);
		cache_get_value_float(id, "posy", GymPoint[id][bbPos][1]);
		cache_get_value_float(id, "posz", GymPoint[id][bbPos][2]);
		cache_get_value_name_int(id, "interior", GymPoint[id][GymInt]);
		cache_get_value_name_int(id, "world", GymPoint[id][GymVw]);

        GymPoint[id][bbPickup] = CreateDynamicPickup(1274, 23, GymPoint[id][bbPos][0], GymPoint[id][bbPos][1], GymPoint[id][bbPos][2], GymPoint[id][GymVw], GymPoint[id][GymInt]);
		format(string, 128, "[ID:%d]\n{00FF00}Gym point\n{FFFFFF}use '/buy' here", id);
		GymPoint[id][bbText] = CreateDynamic3DTextLabel(string, COLOR_YELLOW, GymPoint[id][bbPos][0], GymPoint[id][bbPos][1], GymPoint[id][bbPos][2], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GymPoint[id][GymVw], GymPoint[id][GymInt], -1, 10.0);

		GYM_Refresh(id);
	}
	printf("*** [Database: Loaded] GYM data (%d count).", cache_num_rows());
	return 1;
}

SaveGym(id)
{
    if(Iter_Contains(GymPoint, id))
	{
		new query[500];
		format(query, sizeof(query), "UPDATE `gympoint` SET posx='%f', posy='%f', posz='%f', interior='%d', world='%d' WHERE `id` = %d",
		GymPoint[id][bbPos][0],
        GymPoint[id][bbPos][1],
		GymPoint[id][bbPos][2],
        GymPoint[id][GymInt],
        GymPoint[id][GymVw],
		GymPoint[id][GymId]
		);

		mysql_tquery(g_SQL, query);
	}
	return 1;
}

Machine_Refresh(index)
{
	if(Iter_Contains(GYMInfo, index))
	{
		new string[512];
		if(IsValidDynamic3DTextLabel(GYMInfo[index][GYMOBJText]))
			DestroyDynamic3DTextLabel(GYMInfo[index][GYMOBJText]);

		if(GYMInfo[index][GYMOBJUsed] != 1)
        {
            format(string, 128, "[ID:%d]\n{00FF00}Available\n%d/1000", index, GYMInfo[index][GYMOBJCondition]);
		    GYMInfo[index][GYMOBJText] = CreateDynamic3DTextLabel(string, COLOR_YELLOW, GYMInfo[index][GYMOBJPosX], GYMInfo[index][GYMOBJPosY], GYMInfo[index][GYMOBJPosZ], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GYMInfo[index][GYMvw], GYMInfo[index][GYMint], -1, 10.0);
        }
        else
        {
            format(string, 128, "[ID:%d]\n{FF0000}Not Available\n%d/1000", index, GYMInfo[index][GYMOBJCondition]);
		    GYMInfo[index][GYMOBJText] = CreateDynamic3DTextLabel(string, COLOR_YELLOW, GYMInfo[index][GYMOBJPosX], GYMInfo[index][GYMOBJPosY], GYMInfo[index][GYMOBJPosZ], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GYMInfo[index][GYMvw], GYMInfo[index][GYMint], -1, 10.0);
        }
	}
	return 1;
}

GYM_Refresh(index)
{
	new string[512];
	if(Iter_Contains(GymPoint, index))
	{
        if(IsValidDynamicPickup(GymPoint[index][bbPickup]))
			DestroyDynamicPickup(GymPoint[index][bbPickup]);

		if(IsValidDynamic3DTextLabel(GymPoint[index][bbText]))
			DestroyDynamic3DTextLabel(GymPoint[index][bbText]);

		GymPoint[index][bbPickup] = CreateDynamicPickup(1274, 23, GymPoint[index][bbPos][0], GymPoint[index][bbPos][1], GymPoint[index][bbPos][2], GymPoint[index][GymVw], GymPoint[index][GymInt]);
		format(string, 128, "[ID:%d]\n{00FF00}Gym point\n{FFFFFF}use '/buy' here", index);
		GymPoint[index][bbText] = CreateDynamic3DTextLabel(string, COLOR_YELLOW, GymPoint[index][bbPos][0], GymPoint[index][bbPos][1], GymPoint[index][bbPos][2], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GymPoint[index][GymVw], GymPoint[index][GymInt], -1, 10.0);
	}
	return 1;
}

function FitnessTime(playerid)
{
    if(!IsValidTimer(pData[playerid][pActivity])) return 0;
	{
		if(pData[playerid][pActivityTime] >= 100)
		{
			InfoTD_MSG(playerid, 8000, "Done!");
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pActivityTime] = 0;
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pEnergy] -= 3;
			UpFitStats(playerid, playerid);
			ClearAnimations(playerid);
			return 1;
		}
		else if(pData[playerid][pActivityTime] < 100)
		{
			pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
		}
	}
	return 1;
}

function OnMachineCreated(playerid, machineid) 
{
	SaveGYMObject(machineid);
	Servers(playerid, "You has created GYM Machine id: %d.", machineid);
	return 1;
}
function OnGymPointCreated(playerid, id)
{
	SaveGym(id);
	Servers(playerid, "You has created GYM Point id: %d.", id);
	return 1;
}

// Adm cmd
CMD:createmachine(playerid, params[])
{
	new String[128];
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

    new choice[32];
	if(sscanf(params, "s[32]", choice))
	{
		SendClientMessageEx(playerid, COLOR_WHITE, "USE: /createmachine [bike, treadmill, boxing]");
		return 1;
	}
	if(strcmp(choice, "bike", true) == 0)
	{
        new machineid = Iter_Free(GYMInfo), query[512];
		if(machineid == -1) return Error(playerid, "Can't add Machine anymore.");
		new Float: x, Float: y, Float: z;
 		GetPlayerPos(playerid, x, y, z);

		GYMInfo[machineid][GYMOBJType] = 2;
    	GYMInfo[machineid][GYMOBJPosX] = x;
		GYMInfo[machineid][GYMOBJPosY] = y;
		GYMInfo[machineid][GYMOBJPosZ] = z;
		GYMInfo[machineid][GYMOBJPosRX] = GYMInfo[machineid][GYMOBJPosRY] = GYMInfo[machineid][GYMOBJPosRZ] = 0.0;
		GYMInfo[machineid][GYMOBJCondition] =  1000;
		GYMInfo[machineid][GYMvw] = GetPlayerVirtualWorld(playerid); 
		GYMInfo[machineid][GYMint] = GetPlayerInterior(playerid);

		GYMInfo[machineid][GYMOBJObject] = CreateDynamicObject(2630, GYMInfo[machineid][GYMOBJPosX], GYMInfo[machineid][GYMOBJPosY], GYMInfo[machineid][GYMOBJPosZ], GYMInfo[machineid][GYMOBJPosRX], GYMInfo[machineid][GYMOBJPosRY], GYMInfo[machineid][GYMOBJPosRZ], GYMInfo[machineid][GYMvw], GYMInfo[machineid][GYMint], -1, 10.0, 10.0);
    	format(String, 128, "[ID:%d]\n{00FF00}Available\n%d/1000", machineid, GYMInfo[machineid][GYMOBJCondition]);
		GYMInfo[machineid][GYMOBJText] = CreateDynamic3DTextLabel(String, COLOR_YELLOW, GYMInfo[machineid][GYMOBJPosX], GYMInfo[machineid][GYMOBJPosY], GYMInfo[machineid][GYMOBJPosZ], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GYMInfo[machineid][GYMvw], GYMInfo[machineid][GYMint], -1, 10.0);
    	Iter_Add(GYMInfo, machineid);

		mysql_format(g_SQL, query, sizeof(query), "INSERT INTO gymmachine SET id='%d', objecttype='%d', objcondition='%d', used='%d', posx='%f', posy='%f', posz='%f', posrx='%f', posry='%f', posrz='%f', interior='%d', world='%d'", machineid, GYMInfo[machineid][GYMOBJType], 1000, 0, GYMInfo[machineid][GYMOBJPosX], GYMInfo[machineid][GYMOBJPosY], GYMInfo[machineid][GYMOBJPosZ], GYMInfo[machineid][GYMOBJPosRX], GYMInfo[machineid][GYMOBJPosRY], GYMInfo[machineid][GYMOBJPosRZ], GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
		mysql_tquery(g_SQL, query, "OnMachineCreated", "ii", playerid, machineid);
	}
	else if(strcmp(choice, "treadmill", true) == 0)
	{
	    new machineid = Iter_Free(GYMInfo), query[512];
		if(machineid == -1) return Error(playerid, "Can't add any more Machine.");
		new Float: x, Float: y, Float: z;
 		GetPlayerPos(playerid, x, y, z);
		GYMInfo[machineid][GYMOBJType] = 1;
    	GYMInfo[machineid][GYMOBJPosX] = x;
		GYMInfo[machineid][GYMOBJPosY] = y;
		GYMInfo[machineid][GYMOBJPosZ] = z;
		GYMInfo[machineid][GYMOBJPosRX] = GYMInfo[machineid][GYMOBJPosRY] = GYMInfo[machineid][GYMOBJPosRZ] = 0.0;
		GYMInfo[machineid][GYMOBJCondition] =  1000;
		GYMInfo[machineid][GYMvw] = GetPlayerVirtualWorld(playerid); 
		GYMInfo[machineid][GYMint] = GetPlayerInterior(playerid);

		GYMInfo[machineid][GYMOBJObject] = CreateDynamicObject(2627, GYMInfo[machineid][GYMOBJPosX], GYMInfo[machineid][GYMOBJPosY], GYMInfo[machineid][GYMOBJPosZ], GYMInfo[machineid][GYMOBJPosRX], GYMInfo[machineid][GYMOBJPosRY], GYMInfo[machineid][GYMOBJPosRZ], GYMInfo[machineid][GYMvw], GYMInfo[machineid][GYMint], -1, 10.0, 10.0);
    	format(String, 128, "[ID:%d]\n{00FF00}Available\n%d/1000", machineid, GYMInfo[machineid][GYMOBJCondition]);
		GYMInfo[machineid][GYMOBJText] = CreateDynamic3DTextLabel(String, COLOR_YELLOW, GYMInfo[machineid][GYMOBJPosX], GYMInfo[machineid][GYMOBJPosY], GYMInfo[machineid][GYMOBJPosZ], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GYMInfo[machineid][GYMvw], GYMInfo[machineid][GYMint], -1, 10.0);
		Iter_Add(GYMInfo, machineid);

		mysql_format(g_SQL, query, sizeof(query), "INSERT INTO gymmachine SET id='%d', objecttype='%d', objcondition='%d', used='%d', posx='%f', posy='%f', posz='%f', posrx='%f', posry='%f', posrz='%f', interior='%d', world='%d'", machineid, GYMInfo[machineid][GYMOBJType], 1000, 0, GYMInfo[machineid][GYMOBJPosX], GYMInfo[machineid][GYMOBJPosY], GYMInfo[machineid][GYMOBJPosZ], GYMInfo[machineid][GYMOBJPosRX], GYMInfo[machineid][GYMOBJPosRY], GYMInfo[machineid][GYMOBJPosRZ], GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
		mysql_tquery(g_SQL, query, "OnMachineCreated", "ii", playerid, machineid);
	}
	else if(strcmp(choice, "boxing", true) == 0)
	{
	    new machineid = Iter_Free(GYMInfo), query[512];
		if(machineid == -1) return Error(playerid, "Can't add any more Machine.");
		new Float: x, Float: y, Float: z;
 		GetPlayerPos(playerid, x, y, z);
		GYMInfo[machineid][GYMOBJType] = 3;
    	GYMInfo[machineid][GYMOBJPosX] = x;
		GYMInfo[machineid][GYMOBJPosY] = y;
		GYMInfo[machineid][GYMOBJPosZ] = z;
		GYMInfo[machineid][GYMOBJPosRX] = GYMInfo[machineid][GYMOBJPosRY] = GYMInfo[machineid][GYMOBJPosRZ] = 0.0;
		GYMInfo[machineid][GYMOBJCondition] =  1000;
		GYMInfo[machineid][GYMvw] = GetPlayerVirtualWorld(playerid); 
		GYMInfo[machineid][GYMint] = GetPlayerInterior(playerid);

		GYMInfo[machineid][GYMOBJObject] = CreateDynamicObject(1985, GYMInfo[machineid][GYMOBJPosX], GYMInfo[machineid][GYMOBJPosY], GYMInfo[machineid][GYMOBJPosZ], GYMInfo[machineid][GYMOBJPosRX], GYMInfo[machineid][GYMOBJPosRY], GYMInfo[machineid][GYMOBJPosRZ], GYMInfo[machineid][GYMvw], GYMInfo[machineid][GYMint], -1, 10.0, 10.0);
    	format(String, 128, "[ID:%d]\n{00FF00}Available\n%d/1000", machineid, GYMInfo[machineid][GYMOBJCondition]);
		GYMInfo[machineid][GYMOBJText] = CreateDynamic3DTextLabel(String, COLOR_YELLOW, GYMInfo[machineid][GYMOBJPosX], GYMInfo[machineid][GYMOBJPosY], GYMInfo[machineid][GYMOBJPosZ], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GYMInfo[machineid][GYMvw], GYMInfo[machineid][GYMint], -1, 10.0);
		Iter_Add(GYMInfo, machineid);

		mysql_format(g_SQL, query, sizeof(query), "INSERT INTO gymmachine SET id='%d', objecttype='%d', objcondition='%d', used='%d', posx='%f', posy='%f', posz='%f', posrx='%f', posry='%f', posrz='%f', interior='%d', world='%d'", machineid, GYMInfo[machineid][GYMOBJType], 1000, 0, GYMInfo[machineid][GYMOBJPosX], GYMInfo[machineid][GYMOBJPosY], GYMInfo[machineid][GYMOBJPosZ], GYMInfo[machineid][GYMOBJPosRX], GYMInfo[machineid][GYMOBJPosRY], GYMInfo[machineid][GYMOBJPosRZ], GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
		mysql_tquery(g_SQL, query, "OnMachineCreated", "ii", playerid, machineid);
	}
	
	return 1;
}
CMD:editmachine(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	if(gymEditID[playerid] != -1) return Error(playerid, "You're already editing.");

	new id;
	if(sscanf(params, "i", id)) return Usage(playerid, "/editatm [id]");
	if(!Iter_Contains(GYMInfo, id)) return Error(playerid, "Invalid ID.");

	if(!IsPlayerInRangeOfPoint(playerid, 30.0, GYMInfo[id][GYMOBJPosX], GYMInfo[id][GYMOBJPosY], GYMInfo[id][GYMOBJPosZ])) return Error(playerid, "You're not near the atm you want to edit.");
	gymEdit[playerid] = 1;
	gymEditID[playerid] = id;
	EditDynamicObject(playerid, GYMInfo[id][GYMOBJObject]);
	return 1;
}
CMD:resetmachine(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	new id;
	if(sscanf(params, "i", id)) return Usage(playerid, "/editatm [id]");
	if(!Iter_Contains(GYMInfo, id)) return Error(playerid, "Invalid ID.");

	if(!IsPlayerInRangeOfPoint(playerid, 30.0, GYMInfo[id][GYMOBJPosX], GYMInfo[id][GYMOBJPosY], GYMInfo[id][GYMOBJPosZ])) return Error(playerid, "You're not near the atm you want to edit.");
	
	GYMInfo[id][GYMOBJUsed] = 0;
	GYMInfo[id][GYMOBJCondition] = 1000;
	Machine_Refresh(id);
	SaveGYMObject(id);

	return 1;
}
CMD:deletemachine(playerid, params[])
{
	new id, query[512];
	if(pData[playerid][pAdmin] < 5) return PermissionError(playerid);
	if(sscanf(params, "i", id)) return Usage(playerid, "/deletemachine [id]");
	if(!Iter_Contains(GYMInfo, id)) return Error(playerid, "Invalid ID.");

	DestroyDynamicObject(GYMInfo[id][GYMOBJObject]);
  	DestroyDynamic3DTextLabel(GYMInfo[id][GYMOBJText]);

	GYMInfo[id][GYMOBJPosX] = GYMInfo[id][GYMOBJPosY] = GYMInfo[id][GYMOBJPosZ] = GYMInfo[id][GYMOBJPosRX] = GYMInfo[id][GYMOBJPosRY] = GYMInfo[id][GYMOBJPosRZ] = 0.0;
  	GYMInfo[id][GYMint] = GYMInfo[id][GYMvw] = 0;
	GYMInfo[id][GYMOBJObject] = -1;
	GYMInfo[id][GYMOBJText] = Text3D: -1;
	
	Iter_Remove(GYMInfo, id);
	
	mysql_format(g_SQL, query, sizeof(query), "DELETE FROM gymmachine WHERE id=%d", id);
	mysql_tquery(g_SQL, query);
	Servers(playerid, "You removed GYM Machine id %d.", id);
	return 1;
}
CMD:creategym(playerid, params[])
{
    new String[200];
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
 	new id = Iter_Free(GymPoint), query[512];
	if(id == -1) return Error(playerid, "Can't add GYM Point anymore.");
	new Float: x, Float: y, Float: z;
 	GetPlayerPos(playerid, x, y, z);
	GymPoint[id][bbPos][0] = x;
	GymPoint[id][bbPos][1] = y;
	GymPoint[id][bbPos][2] = z;
	GymPoint[id][GymVw] = GetPlayerVirtualWorld(playerid);
	GymPoint[id][GymInt] = GetPlayerInterior(playerid);
	GymPoint[id][bbPickup] = CreateDynamicPickup(1274, 23, x, y, z, GymPoint[id][GymVw], GymPoint[id][GymInt]);
	format(String, 128, "[ID:%d]\n{00FF00}Gym point\n{FFFFFF}use '/buy' here", id);
	GymPoint[id][bbText] = CreateDynamic3DTextLabel(String, COLOR_YELLOW, x, y, z, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GymPoint[id][GymVw], GymPoint[id][GymInt], -1, 10.0);
	Iter_Add(GymPoint, id);
	
	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO gympoint SET id='%d', posx='%d', posy='%d', posz='%d', interior='%d', world='%d'", id, GymPoint[id][bbPos][0], GymPoint[id][bbPos][1], GymPoint[id][bbPos][2], GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
	mysql_tquery(g_SQL, query, "OnGymPointCreated", "ii", playerid, id);
	return 1;
}

CMD:fitness(playerid, params[])
{
	new String[200];

	if(pData[playerid][pGymVip] < 1)
		return SendClientMessage(playerid, -1, "ERROR: Anda tidak memiliki GYM Membership");

    if(pData[playerid][pEnergy] < 15)
    	return SendClientMessage(playerid, -1, "ERROR: Anda kekurangan Energi untuk melakukan Fitness");

    /*if(pData[playerid][pFitnessTimer] > 0)
    {
    	SendClientMessage(playerid, -1, "ERROR: Anda harus menunggu %d menit untuk melakukan Fitness kembali", pData[playerid][pFitnessTimer]);
		return 1;
	}*/
    for(new idx = 0; idx < sizeof(GYMInfo); idx++)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 2.5, GYMInfo[idx][GYMOBJPosX], GYMInfo[idx][GYMOBJPosY], GYMInfo[idx][GYMOBJPosZ]))
		{
		    if(GYMInfo[idx][GYMOBJType] == 1)
			{
				pData[playerid][pFitnessTimer] = 1*60;
				pData[playerid][pFitnessType] = 1;
				GYMInfo[idx][GYMOBJCondition] -= Random(50, 100);
				DestroyDynamic3DTextLabel(GYMInfo[idx][GYMOBJText]);
				format(String, 128, "[ID:%d]\n{00FF00}Available\n%d/1000", idx, GYMInfo[idx][GYMOBJCondition]);
				GYMInfo[idx][GYMOBJText] = CreateDynamic3DTextLabel(String, COLOR_YELLOW, GYMInfo[idx][GYMOBJPosX], GYMInfo[idx][GYMOBJPosY], GYMInfo[idx][GYMOBJPosZ], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GYMInfo[idx][GYMvw], GYMInfo[idx][GYMint], -1, 10.0);
				SetPlayerPos(playerid, GYMInfo[idx][GYMOBJPosX], GYMInfo[idx][GYMOBJPosY], GYMInfo[idx][GYMOBJPosZ]);
				SetPlayerFacingAngle(playerid, GYMInfo[idx][GYMOBJPosRZ]);
				ApplyAnimation(playerid, "GYMNASIUM", "gym_tread_sprint", 4.1, 0, 0, 0, 0, 9999999);
				SetCameraBehindPlayer(playerid);

				pData[playerid][pActivity] = SetTimerEx("FitnessTime", 1300, true, "i", playerid);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Progress..");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);

				Streamer_Update(playerid);
			}
			if(GYMInfo[idx][GYMOBJType] == 2)
			{
				pData[playerid][pFitnessTimer] = 1*60;
				pData[playerid][pFitnessType] = 2;
	         	GYMInfo[idx][GYMOBJCondition] -= Random(50, 100);
				DestroyDynamic3DTextLabel(GYMInfo[idx][GYMOBJText]);
				format(String, 128, "[ID:%d]\n{00FF00}Available\n%d/1000", idx, GYMInfo[idx][GYMOBJCondition]);
				GYMInfo[idx][GYMOBJText] = CreateDynamic3DTextLabel(String, COLOR_YELLOW, GYMInfo[idx][GYMOBJPosX], GYMInfo[idx][GYMOBJPosY], GYMInfo[idx][GYMOBJPosZ], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GYMInfo[idx][GYMvw], GYMInfo[idx][GYMint], -1, 10.0);
				SetPlayerFacingAngle(playerid, GYMInfo[idx][GYMOBJPosRZ]);
				ApplyAnimation(playerid, "GYMNASIUM", "gym_bike_faster", 4.1, 0, 0, 0, 0, 9999999);
				SetCameraBehindPlayer(playerid);

				pData[playerid][pActivity] = SetTimerEx("FitnessTime", 1300, true, "i", playerid);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Progress..");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);

				Streamer_Update(playerid);
			}
			if(GYMInfo[idx][GYMOBJType] == 3)
			{
				pData[playerid][pFitnessTimer] = 1*60;
				pData[playerid][pFitnessType] = 3;
	         	GYMInfo[idx][GYMOBJCondition] -= Random(50, 100);
				DestroyDynamic3DTextLabel(GYMInfo[idx][GYMOBJText]);
				format(String, 128, "[ID:%d]\n{00FF00}Available\n%d/1000", idx, GYMInfo[idx][GYMOBJCondition]);
				GYMInfo[idx][GYMOBJText] = CreateDynamic3DTextLabel(String, COLOR_YELLOW, GYMInfo[idx][GYMOBJPosX], GYMInfo[idx][GYMOBJPosY], GYMInfo[idx][GYMOBJPosZ], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GYMInfo[idx][GYMvw], GYMInfo[idx][GYMint], -1, 10.0);
				ApplyAnimation(playerid, "GYMNASIUM", "GYMshadowbox", 4.1, 0, 0, 0, 0, 9999999);
				SetCameraBehindPlayer(playerid);

				pData[playerid][pActivity] = SetTimerEx("FitnessTime", 1300, true, "i", playerid);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Progress..");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);

				Streamer_Update(playerid);
			}
			return idx;
		}
	}
 	return 1;
}

CMD:fstyle(playerid, params[])
{
	new CMDSString[1024], _tmpstring[128], found = false;
	if(pData[playerid][pLevel] > 1) strcat(_tmpstring, "Normal\n"), gListedItems[playerid][found++] = 1;
	if(pData[playerid][pHasBoxing] == 1) strcat(_tmpstring, "Boxing\n"), gListedItems[playerid][found++] = 2;
	if(pData[playerid][pHasElbow] == 1) strcat(_tmpstring, "Elbow\n"), gListedItems[playerid][found++] = 3;
	if(pData[playerid][pHasKneehead] == 1) strcat(_tmpstring, "Kneehead\n"), gListedItems[playerid][found++] = 4;
	if(pData[playerid][pHasKungfu] == 1) strcat(_tmpstring, "Kung Fu\n"), gListedItems[playerid][found++] = 5;
	if(pData[playerid][pHasGrabkick] == 1) strcat(_tmpstring, "Grab Kick\n"), gListedItems[playerid][found++] = 6;
	
	strcat(CMDSString, _tmpstring);

	if(strlen(CMDSString) > 0)
    {
       ShowPlayerDialog(playerid, DIALOG_FIGHTSTYLE, DIALOG_STYLE_LIST, "Fight Style", CMDSString, "Set", "Close");
    }
    else
    {
       SendClientMessage(playerid, -1, "You don't have any Fight Styles.");
    }
}