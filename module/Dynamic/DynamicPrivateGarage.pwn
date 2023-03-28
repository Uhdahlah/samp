#define MAX_GARKOT           50

enum garkotdata 
{
	speedID,
	Float:speedPos[4],
	Text3D:speedText3D,
    speedExists,
    garkotpickup
};
new GarkotData[MAX_GARKOT][garkotdata];

stock Speed_Refresh(speedid)
{
	if (speedid != -1)
	{
	    new
	        string[212];

		if(IsValidDynamicPickup(GarkotData[speedid][garkotpickup]))
            DestroyDynamicPickup(GarkotData[speedid][garkotpickup]);

		if (IsValidDynamic3DTextLabel(GarkotData[speedid][speedText3D]))
		    DestroyDynamic3DTextLabel(GarkotData[speedid][speedText3D]);

		format(string, sizeof(string), "{00FFFF}[Private Garage]\n"WHITE_E"Gunakan "YELLOW_E"'/gd' "WHITE_E"Untuk Memasukan Kendaraan\n"WHITE_E"Gunakan "YELLOW_E"'/gs' "WHITE_E"Untuk Mengeluarkan Kendaraan");

		GarkotData[speedid][speedText3D] = CreateDynamic3DTextLabel(string, 0xFF0000FF, GarkotData[speedid][speedPos][0], GarkotData[speedid][speedPos][1], GarkotData[speedid][speedPos][2] + 1.0, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0);
        GarkotData[speedid][garkotpickup] = CreateDynamicPickup(1239, 23, GarkotData[speedid][speedPos][0], GarkotData[speedid][speedPos][1], GarkotData[speedid][speedPos][2]+1.0, 0, -1, _, 10.0);
        GarkotData[speedid][speedExists] = true;
    }
	return 1;
}

stock Speed_Save(speedid)
{
	new
	    query[255];

	format(query, sizeof(query), "UPDATE `garkot` SET `speedX` = '%.4f', `speedY` = '%.4f', `speedZ` = '%.4f', `speedAngle` = '%.4f' WHERE `speedID` = '%d'",
	    GarkotData[speedid][speedPos][0],
	    GarkotData[speedid][speedPos][1],
	    GarkotData[speedid][speedPos][2],
	    GarkotData[speedid][speedPos][3],
	    GarkotData[speedid][speedID]
	);
	return mysql_tquery(g_SQL, query);
}

stock Garkot_Delete(speedid)
{
    if (speedid != -1)
	{
	    new
	        string[64];

		if(IsValidDynamicPickup(GarkotData[speedid][garkotpickup]))
            DestroyDynamicPickup(GarkotData[speedid][garkotpickup]);

		if (IsValidDynamic3DTextLabel(GarkotData[speedid][speedText3D]))
		    DestroyDynamic3DTextLabel(GarkotData[speedid][speedText3D]);

		format(string, sizeof(string), "DELETE FROM `garkot` WHERE `speedID` = '%d'", GarkotData[speedid][speedID]);
		mysql_tquery(g_SQL, string);

		GarkotData[speedid][speedID] = 0;
        GarkotData[speedid][speedExists] = false;
	}
	return 1;
}

stock Garkot_Create(playerid)
{
	new
	    Float:x,
	    Float:y,
	    Float:z,
	    Float:angle;

	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);

	for (new i = 0; i < MAX_GARKOT; i ++) if (!GarkotData[i][speedExists])
	{
		GarkotData[i][speedPos][0] = x + (1.5 * floatsin(-angle, degrees));
	    GarkotData[i][speedPos][1] = y + (1.5 * floatcos(-angle, degrees));
	    GarkotData[i][speedPos][2] = z - 1.2;
	    GarkotData[i][speedPos][3] = angle;
        GarkotData[i][speedExists] = true;

	    Speed_Refresh(i);
	    mysql_tquery(g_SQL, "INSERT INTO `garkot` (`speedRange`) VALUES(0.0)", "OnGarkotCreated", "d", i);
	    return i;
	}
	return -1;
}

forward OnGarkotCreated(speedid);
public OnGarkotCreated(speedid)
{
	if (speedid == -1)
	    return 0;

	GarkotData[speedid][speedID] = cache_insert_id();
	Speed_Save(speedid);

	return 1;
}

function LoadGarkot()
{
    new rows = cache_num_rows();
 	if(rows)
  	{
   		new wid;
		for(new i; i < rows; i++)
		{
  			cache_get_value_name_int(i, "speedID", wid);
		    cache_get_value_name_float(i, "speedX", GarkotData[wid][speedPos][0]);
			cache_get_value_name_float(i, "speedY", GarkotData[wid][speedPos][1]);
			cache_get_value_name_float(i, "speedZ", GarkotData[wid][speedPos][2]);
			cache_get_value_name_float(i, "speedAngle", GarkotData[wid][speedPos][3]);

			Speed_Refresh(wid);
	    }
	    printf("*** [Database: Loaded] garkot data (%d count).", rows);
	}
}

CMD:creategarkot(playerid, params[])
{
    if(pData[playerid][pAdmin] < 6)
	    return PermissionError(playerid);

	new id = Garkot_Create(playerid);

	if (id == -1)
	    return Info(playerid, "The server has reached the limit for garkot.");

	Info(playerid, "You have created garkot ID: %d.", id);
	return 1;
}

CMD:gotogarkot(playerid, params[])
{
	new houseid;

    if(pData[playerid][pAdmin] < 6)
	    return PermissionError(playerid);

	if(sscanf(params, "i", houseid))
	{
	    return Usage(playerid, "/gotogarkot [garkotid]");
	}
	if(!(0 <= houseid < MAX_GARKOT))
	{
	    return Info(playerid, "Invalid garkot.");
	}
	SetPlayerPos(playerid, GarkotData[houseid][speedPos][0] - (2.5 * floatsin(-GarkotData[houseid][speedPos][3], degrees)), GarkotData[houseid][speedPos][1] - (2.5 * floatcos(-GarkotData[houseid][speedPos][3], degrees)), GarkotData[houseid][speedPos][2]);
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	SetCameraBehindPlayer(playerid);
	return 1;
}

CMD:destroygarkot(playerid, params[])
{
	static
	    id = 0;

    if(pData[playerid][pAdmin] < 6)
	    return PermissionError(playerid);

	if (sscanf(params, "d", id))
	    return Usage(playerid, "/destroygarkot [garkot id]");

	if ((id < 0 || id >= MAX_GARKOT))
	    return Info(playerid, "You have specified an invalid garkot ID.");

	Garkot_Delete(id);
	Info(playerid, "You have successfully destroyed garkot ID: %d.", id);
	return 1;
}

CMD:gd(playerid, params[])
{
    new vehicleid = GetPlayerVehicleID(playerid);
    for (new i = 0; i < MAX_GARKOT; i ++) 
    {
        if (IsPlayerInRangeOfPoint(playerid, 5.0, GarkotData[i][speedPos][0], GarkotData[i][speedPos][1], GarkotData[i][speedPos][2]))
        {
            foreach(new ii : PVehicles)
            {
                if(vehicleid == pvData[ii][cVeh])
                {
                    pvData[ii][cImpound] = 4;
                }
            }
            SetVehicleVirtualWorld(vehicleid, 12);
            SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"You have successfully "YELLOW_E"despawned "WHITE_E"the {00FFFF}%s "WHITE_E"vehicle", GetVehicleName(vehicleid));
        }
    }            
    return 1;
}

CMD:gs(playerid, params[])
{
    for (new i = 0; i < MAX_GARKOT; i ++) 
    {
        if (IsPlayerInRangeOfPoint(playerid, 5.0, GarkotData[i][speedPos][0], GarkotData[i][speedPos][1], GarkotData[i][speedPos][2]))
        {
            new found = false, msg2[512];
            format(msg2, sizeof(msg2), "Model(ID)\n");
            for(new vehicleid = 0; vehicleid < MAX_VEHICLES; vehicleid++)
            {
                if(pvData[vehicleid][cImpound] == 4)
                {
                    if(pvData[vehicleid][cOwner] == pData[playerid][pID])
                    {
                        gListedItems[playerid][found] = i;
                        format(msg2, sizeof(msg2), "%s{00FFFF}%s(%d)\n", msg2, GetVehicleModelName(pvData[vehicleid][cModel]), pvData[vehicleid][cVeh]);
                        found++;
                    }
                }
            }
            if(found)
                ShowPlayerDialog(playerid, DIALOG_SPAWNEDGARKOT, DIALOG_STYLE_TABLIST_HEADERS, "Private Garage", msg2, "Select", "Close");
        }
    }            
    return 1;
}