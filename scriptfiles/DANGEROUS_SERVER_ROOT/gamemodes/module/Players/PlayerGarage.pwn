
/*==============================================================================
         					     Garkot
===============================================================================*/

#define MAX_PARKPOINT 300

enum    E_PARK
{
	// loaded from db
	Float: parkX,
	Float: parkY,
	Float: parkZ,
	parkInt,
	parkWorld,
	// temp
	parkPickup,
	Text3D: parkLabel
}

new ppData[MAX_PARKPOINT][E_PARK],
	Iterator:Parks<MAX_PARKPOINT>;
	
GetClosestParks(playerid, Float: range = 4.3)
{
	new id = -1, Float: dist = range, Float: tempdist;
	foreach(new i : Parks)
	{
	    tempdist = GetPlayerDistanceFromPoint(playerid, ppData[i][parkX], ppData[i][parkY], ppData[i][parkZ]);

	    if(tempdist > range) continue;
		if(tempdist <= dist && GetPlayerInterior(playerid) == ppData[i][parkInt] && GetPlayerVirtualWorld(playerid) == ppData[i][parkWorld])
		{
			dist = tempdist;
			id = i;
		}
	}
	return id;
}

CountParkedVeh(id)
{
	if(id > -1)
	{
		new count = 0;
		foreach(new i : PVehicles)
		{
			if(pvData[i][cPark] == id)
				count++;
		}
		return count;
	}
	return 0;
}

GetAnyVehiclePark(i)
{
	new tmpcount;
	foreach(new id : PVehicles)
	{
	    if(pvData[id][cPark] == i)
	    {
     		tmpcount++;
		}
	}
	return tmpcount;
}

ReturnAnyVehiclePark(slot, i)
{
	new tmpcount;
	if(slot < 1 && slot > MAX_PRIVATE_VEHICLE) return -1;
	foreach(new id : PVehicles)
	{
	    if(pvData[id][cPark] == i && pvData[id][cPark] > -1)
	    {
     		tmpcount++;
       		if(tmpcount == slot)
       		{
        		return id;
  			}
	    }
	}
	return -1;
}

function LoadPark()
{
	new rows;
	cache_get_row_count(rows);
	if(rows)
  	{
 		new id, i = 0, str[528];
		while(i < rows)
		{
			format(str, sizeof(str), "{00FFFF}[ID: %d]\n"GREEN_E"Garage\n"WHITE_E"Press 'Kelakson' to store vehicle\nPress 'H' to take vehicle", id);
		    cache_get_value_name_int(i, "id", id);
			cache_get_value_name_float(i, "posx", ppData[id][parkX]);
			cache_get_value_name_float(i, "posy", ppData[id][parkY]);
			cache_get_value_name_float(i, "posz", ppData[id][parkZ]);
			cache_get_value_name_int(i, "interior", ppData[id][parkInt]);
			cache_get_value_name_int(i, "world", ppData[id][parkWorld]);
			ppData[id][parkPickup] = CreateDynamicPickup(1316, 23, ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ], ppData[id][parkWorld],  ppData[id][parkInt], -1, 50);
			ppData[id][parkLabel] = CreateDynamic3DTextLabel(str, COLOR_ARWIN, ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ]+0.3, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ppData[id][parkWorld], ppData[id][parkInt], -1, 10.0);
			Iter_Add(Parks, id);
	    	i++;
		}
		printf("*** [Database: Loaded] garage data (%d count).", i);
	}
}

Park_Save(id)
{
	new cQuery[512];
	format(cQuery, sizeof(cQuery), "UPDATE parks SET posx='%f', posy='%f', posz='%f', interior=%d, world=%d WHERE id=%d",
	ppData[id][parkX],
	ppData[id][parkY],
	ppData[id][parkZ],
	ppData[id][parkInt],
	ppData[id][parkWorld],
	id
	);
	return mysql_tquery(g_SQL, cQuery);
}

CMD:createpark(playerid, params[])
{
	if(pData[playerid][pAdmin] < 4)
			return PermissionError(playerid);
		
	new id = Iter_Free(Parks), query[512];
	if(id == -1) return Error(playerid, "Can't add any more Park Point.");
 	new Float: x, Float: y, Float: z;
 	GetPlayerPos(playerid, x, y, z);
	
	ppData[id][parkX] = x;
	ppData[id][parkY] = y;
	ppData[id][parkZ] = z;
	ppData[id][parkInt] = GetPlayerInterior(playerid);
	ppData[id][parkWorld] = GetPlayerVirtualWorld(playerid);
	
	new str[128];
	format(str, sizeof(str), "{00FFFF}[ID: %d]\n"GREEN_E"Garage\n"WHITE_E"Use '/storeveh' to store vehicle\nUse '/takeveh' to take vehicle", id);
	ppData[id][parkPickup] = CreateDynamicPickup(1316, 23, ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ], ppData[id][parkWorld],  ppData[id][parkInt], -1, 50);
	ppData[id][parkLabel] = CreateDynamic3DTextLabel(str, COLOR_ARWIN, ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ] + 0.3, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ppData[id][parkWorld], ppData[id][parkInt], -1, 10.0);
	Iter_Add(Parks, id);
	
	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO parks SET id=%d, posx='%f', posy='%f', posz='%f', interior=%d, world=%d", id, ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ], GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
	mysql_tquery(g_SQL, query, "OnParkCreated", "ii", playerid, id);
	return 1;
}

function OnParkCreated(playerid, id)
{
	Park_Save(id);
	Servers(playerid, "You has created Park Point id: %d.", id);
	return 1;
}

CMD:setparkpos(playerid, params[])
{
    if(pData[playerid][pAdmin] < 4)
			return PermissionError(playerid);

	new id;
	if(sscanf(params, "i", id)) return Usage(playerid, "/setparkpos [id]");
	if(!Iter_Contains(Parks, id)) return Error(playerid, "Invalid ID.");
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	ppData[id][parkX] = x;
	ppData[id][parkY] = y;
	ppData[id][parkZ] = z;
	ppData[id][parkInt] = GetPlayerInterior(playerid);
	ppData[id][parkWorld] = GetPlayerVirtualWorld(playerid);

	if(IsValidDynamicPickup(ppData[id][parkPickup]))
		DestroyDynamicPickup(ppData[id][parkPickup]), ppData[id][parkPickup] = -1;

	if(IsValidDynamic3DTextLabel(ppData[id][parkLabel]))
		DestroyDynamic3DTextLabel(ppData[id][parkLabel]), ppData[id][parkLabel] = Text3D: INVALID_3DTEXT_ID;


	
	new str[128];
	ppData[id][parkPickup] = CreateDynamicPickup(1239, 23, ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ], ppData[id][parkWorld],  ppData[id][parkInt], -1, 50);
	format(str, sizeof(str), "{00FFFF}[ID: %d]\n"GREEN_E"Garage\n"WHITE_E"Use '/storeveh' to store vehicle\nUse '/takeveh' to take vehicle", id);
	ppData[id][parkLabel] = CreateDynamic3DTextLabel(str, COLOR_ARWIN, ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ] + 0.3, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ppData[id][parkWorld], ppData[id][parkInt], -1, 10.0);
	Park_Save(id);
	return 1;
}

CMD:removepark(playerid, params[])
{
    if(pData[playerid][pAdmin] < 4)
			return PermissionError(playerid);
		
	new id, query[512];
	if(sscanf(params, "i", id)) return Usage(playerid, "/removepark [id]");
	if(!Iter_Contains(Parks, id)) return Error(playerid, "Invalid ID.");
	
	DestroyDynamic3DTextLabel(ppData[id][parkLabel]);
	DestroyDynamicPickup(ppData[id][parkPickup]);
	
	ppData[id][parkX] = ppData[id][parkY] = ppData[id][parkZ] = 0.0;
	ppData[id][parkInt] = ppData[id][parkWorld] = 0;
	ppData[id][parkPickup] = -1;
	ppData[id][parkLabel] = Text3D: -1;
	Iter_Remove(Parks, id);
	
	mysql_format(g_SQL, query, sizeof(query), "DELETE FROM parks WHERE id=%d", id);
	mysql_tquery(g_SQL, query);
	Servers(playerid, "Remove a Park Point ID %d.", id);
	return 1;
}

CMD:gotopark(playerid, params[])
{
 	new id;
	if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);

	if(sscanf(params, "d", id))
		return SendClientMessageEx(playerid, COLOR_WHITE, "[USAGE]: /gotodoor [id]");
	if(!Iter_Contains(Parks, id)) return Error(playerid, "The park you specified ID of doesn't exist.");
	SetPlayerPos(playerid, ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ]);
    SetPlayerInterior(playerid, ppData[id][parkInt]);
    SetPlayerVirtualWorld(playerid, ppData[id][parkWorld]);
	pData[playerid][pInDoor] = -1;
	pData[playerid][pInHouse] = -1;
	pData[playerid][pInBiz] = -1;
	Servers(playerid, "You has teleport to park id %d", id);
	return 1;
}

CMD:storeveh(playerid, params[])
{
    foreach(new i : Parks)
    {
        if(IsPlayerInRangeOfPoint(playerid, 2.3, ppData[i][parkX], ppData[i][parkY], ppData[i][parkZ]))
        {
            if(!IsPlayerInAnyVehicle(playerid)) return Error(playerid, "You must be in Vehicle");
			new id = -1;
			id = GetClosestParks(playerid);
			
			if(id > -1)
			{
				if(CountParkedVeh(id) >= 5)
					return Error(playerid, "Maximal vehicles in garage 3!");

				new carid = GetPlayerVehicleID(playerid);

                GetVehiclePos(pvData[carid][cVeh], pvData[carid][cPosX], pvData[carid][cPosY], pvData[carid][cPosZ]);
                GetVehicleZAngle(pvData[carid][cVeh], pvData[carid][cPosA]);
                GetVehicleHealth(pvData[carid][cVeh], pvData[carid][cHealth]);
                PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
                SendClientMessageEx(playerid, COLOR_ARWIN, "GARAGE: "WHITE_E"You managed to put the {00FFFF}%s's "WHITE_E"vehicle into the garage", GetVehicleName(carid));
                SetPlayerArmedWeapon(playerid, 0);
                RemovePlayerFromVehicle(playerid);
                SwitchVehicleEngine(carid, false);
                SwitchVehicleLight(carid, false);
                foreach(new vehicleid : PVehicles)
                {
                    if(pvData[vehicleid][cVeh] == carid)
                    {
                        pvData[vehicleid][cPark] = i;
                        new rand = RandomEx(111111, 999999);
                        SetVehicleVirtualWorld(pvData[vehicleid][cVeh], rand);
                    }
                }
                
			}
        }
    }
    return 1;
}

CMD:takeveh(playerid, params[])
{
    foreach(new i : Parks)
    {
        if(IsPlayerInRangeOfPoint(playerid, 2.3, ppData[i][parkX], ppData[i][parkY], ppData[i][parkZ]))
        {
            if(GetAnyVehiclePark(i) <= 0) return Error(playerid, "Your vehicle is not in the garage");
            new id, count = GetAnyVehiclePark(i), location[515], lstr[515];

            strcat(location,"No\tPlate\tVehicle(ID)\n",sizeof(location));
            Loop(itt, (count + 1), 1)
            {
                pData[playerid][pPark] = i;
                id = ReturnAnyVehiclePark(itt, i);
                if(itt == count)
                {
                    format(lstr,sizeof(lstr), "%d\t"YELLOW_E"%s\t%s(%d)\n", itt, pvData[id][cPlate], GetVehicleModelName(pvData[id][cModel]), pvData[id][cVeh]);
                }
                else format(lstr,sizeof(lstr), "%d\t"YELLOW_E"%s\t%s(%d)\n", itt, pvData[id][cPlate], GetVehicleModelName(pvData[id][cModel]), pvData[id][cVeh]);
                strcat(location,lstr,sizeof(location));
            }
            ShowPlayerDialog(playerid, DIALOG_PICKUPVEH, DIALOG_STYLE_TABLIST_HEADERS,"Garage Vehicle",location,"Take","Cancel");
        }
    }
    return 1;
}

