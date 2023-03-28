

enum gsinfo
{
	gsStock,
	Float:gsPosX,
	Float:gsPosY,
	Float:gsPosZ,
	Text3D:gsLabel,
	gsPickup
};

new gsData[MAX_GSTATION][gsinfo],
	Iterator: GStation<MAX_GSTATION>;
	
GStation_Refresh(gsid)
{
	if(gsid != -1)
    {
        if(IsValidDynamic3DTextLabel(gsData[gsid][gsLabel]))
        DestroyDynamic3DTextLabel(gsData[gsid][gsLabel]);

        if(IsValidDynamicPickup(gsData[gsid][gsPickup]))
       	DestroyDynamicPickup(gsData[gsid][gsPickup]);

    	static
        string[255];

		format(string, sizeof(string), "[GAS STATION ID: %d]\n"WHITE_E"Gas Stock: "YELLOW_E"%d liters\n"WHITE_E"Price: "LG_E"$%s /liters\n\n"WHITE_E"Type '"RED_E"/fill"WHITE_E"' to refill", gsid, gsData[gsid][gsStock], FormatMoney(HargaBensin));
		gsData[gsid][gsPickup] = CreateDynamicPickup(19134, 23, gsData[gsid][gsPosX], gsData[gsid][gsPosY], gsData[gsid][gsPosZ]+0.2, -1, -1, -1, 5.0);
		gsData[gsid][gsLabel] = CreateDynamic3DTextLabel(string, COLOR_GREEN, gsData[gsid][gsPosX], gsData[gsid][gsPosY], gsData[gsid][gsPosZ]+0.5, 4.5);
	}
    return 1;
}

function LoadGStations()
{
    static gsid;
	
	new rows = cache_num_rows();
 	if(rows)
  	{
		for(new i; i < rows; i++)
		{
			cache_get_value_name_int(i, "id", gsid);
			cache_get_value_name_int(i, "stock", gsData[gsid][gsStock]);
			cache_get_value_name_float(i, "posx", gsData[gsid][gsPosX]);
			cache_get_value_name_float(i, "posy", gsData[gsid][gsPosY]);
			cache_get_value_name_float(i, "posz", gsData[gsid][gsPosZ]);
			GStation_Refresh(gsid);
			Iter_Add(GStation, gsid);
		}
		printf("*** [Database: Loaded] gas station data (%d count).", rows);
	}
}

GStation_Save(gsid)
{
	new cQuery[512];
	format(cQuery, sizeof(cQuery), "UPDATE gstations SET stock='%d', posx='%f', posy='%f', posz='%f' WHERE id='%d'",
	gsData[gsid][gsStock],
	gsData[gsid][gsPosX],
	gsData[gsid][gsPosY],
	gsData[gsid][gsPosZ],
	gsid
	);
	return mysql_tquery(g_SQL, cQuery);
}

CMD:creategs(playerid, params[])
{
	if(pData[playerid][pAdmin] < 4)
		return PermissionError(playerid);
	
	new gsid = Iter_Free(GStation), query[128];
	if(gsid == -1) return Error(playerid, "You cant create more gs!");

	GetPlayerPos(playerid, gsData[gsid][gsPosX], gsData[gsid][gsPosY], gsData[gsid][gsPosZ]);
    GStation_Refresh(gsid);
	Iter_Add(GStation, gsid);

	new String[212];
	format(String, sizeof(String), "AdmWarn: "YELLOW_E"%s "WHITE_E"telah membuat GasStation ID "YELLOW_E"%d.", pData[playerid][pAdminname], gsid);
	SendClientAdm(COLOR_ARWIN, String, 4); 

	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO gstations SET id='%d', stock='%d', posx='%f', posy='%f', posz='%f'", gsid, gsData[gsid][gsStock], gsData[gsid][gsPosX], gsData[gsid][gsPosY], gsData[gsid][gsPosZ]);
	mysql_tquery(g_SQL, query, "OnGstationCreated", "i", gsid);
	return 1;
}

function OnGstationCreated(gsid)
{
	GStation_Save(gsid);
	return 1;
}

CMD:gotogs(playerid, params[])
{
	new gsid;
	if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);
		
	if(sscanf(params, "d", gsid))
		return Usage(playerid, "/gotogs [id]");
		
	if(!Iter_Contains(GStation, gsid)) return Error(playerid, "The gs you specified ID of doesn't exist.");
	SetPlayerPosition(playerid, gsData[gsid][gsPosX], gsData[gsid][gsPosY], gsData[gsid][gsPosZ], 2.0);
    SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	pData[playerid][pInBiz] = -1;
	pData[playerid][pInDoor] = -1;
	pData[playerid][pInHouse] = -1;
	Servers(playerid, "You has teleport to gs id %d", gsid);
	return 1;
}

CMD:editgs(playerid, params[])
{
    static
        gsid,
        type[24],
        string[128];

    if(pData[playerid][pAdmin] < 4)
        return PermissionError(playerid);

    if(sscanf(params, "ds[24]S()[128]", gsid, type, string))
    {
        Usage(playerid, "/editgs [id] [name]");
        SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} location, delete");
        return 1;
    }
    if((gsid < 0 || gsid >= MAX_GSTATION))
        return Error(playerid, "You have specified an invagsid ID.");
	if(!Iter_Contains(GStation, gsid)) return Error(playerid, "The doors you specified ID of doesn't exist.");

    if(!strcmp(type, "location", true))
    {
		GetPlayerPos(playerid, gsData[gsid][gsPosX], gsData[gsid][gsPosY], gsData[gsid][gsPosZ]);
        GStation_Save(gsid);
		GStation_Refresh(gsid);

        SendAdminMessage(COLOR_RED, "%s has adjusted the location of gs ID: %d.", pData[playerid][pAdminname], gsid);
    }
    else if(!strcmp(type, "delete", true))
    {
		new query[128];
		DestroyDynamic3DTextLabel(gsData[gsid][gsLabel]);
		DestroyDynamicPickup(gsData[gsid][gsPickup]);
		gsData[gsid][gsPosX] = 0;
		gsData[gsid][gsPosY] = 0;
		gsData[gsid][gsPosY] = 0;
		gsData[gsid][gsStock] = 0;
		gsData[gsid][gsLabel] = Text3D: INVALID_3DTEXT_ID;
		gsData[gsid][gsPickup] = -1;
		Iter_Remove(GStation, gsid);
		mysql_format(g_SQL, query, sizeof(query), "DELETE FROM gstations WHERE id=%d", gsid);
		mysql_tquery(g_SQL, query);
        SendAdminMessage(COLOR_RED, "%s has delete gs ID: %d.", pData[playerid][pAdminname], gsid);
    }
    return 1;
}

CMD:fill(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return Error(playerid, "You must driver a vehicle engine.");
	
	new vehid = GetPlayerVehicleID(playerid);
	if(!IsEngineVehicle(vehid))
            return Error(playerid, "You are not in engine vehicle.");
	
	if(GetEngineStatus(vehid))
					return Error(playerid, "Turn off vehicle engine.");
			
	if(GetVehicleFuel(vehid) >= 999.0)
		return Error(playerid, "This vehicle gas is full.");
	
	if(pData[playerid][pFill] != -1)
		return Error(playerid, "You already filling vehicle. please wait!");
		
	foreach(new gsid : GStation)
	{
		if(IsPlayerInRangeOfPoint(playerid, 4.0, gsData[gsid][gsPosX], gsData[gsid][gsPosY], gsData[gsid][gsPosZ]))
		{
			new String[212];
			format(String, sizeof(String), "{FFFFFF}Price per gallon: {00FF00}$%s\n{FFFFFF}Stock: {FFFF00}%d gallon(s).",FormatMoney(HargaBensin), gsData[gsid][gsStock]);
			ShowPlayerDialog( playerid, DIALOG_REFUEL, DIALOG_STYLE_INPUT, "Buy Gasoline", String, "Fill", "Cancel");
		}
	}
	return 1;
}

function Filling(playerid)
{
	if(!IsValidTimer(pData[playerid][pFillTime])) return 0;
	foreach(new gsid : GStation)
	{
		if(!IsPlayerInRangeOfPoint(playerid, 4.0, gsData[gsid][gsPosX], gsData[gsid][gsPosY], gsData[gsid][gsPosZ]) && !IsPlayerInAnyVehicle(playerid) || GetVehicleFuel(GetPlayerVehicleID(playerid)) >= 999.0 || GetPlayerMoney(playerid) < HargaBensin)
		{
			StopFilling(playerid);
			return 1;
		}
		else
		{
			if(GetEngineStatus(GetPlayerVehicleID(playerid)))
					return StopFilling(playerid);
			new old = GetVehicleFuel(GetPlayerVehicleID(playerid));
			SetVehicleFuel(GetPlayerVehicleID(playerid), old + 200);
			if(GetVehicleFuel(GetPlayerVehicleID(playerid)) >= 999.0)
			{
				SetVehicleFuel(GetPlayerVehicleID(playerid), 1000);
			}
			return 1;
		}
	}
	return 1;
}

StopFilling(playerid)
{
	new gsid = pData[playerid][pFill];
	GStation_Refresh(gsid);
	KillTimer(pData[playerid][pFillTime]);
	pData[playerid][pFillPrice] = 0;
	pData[playerid][pFill] = -1;
	return 1;
}
