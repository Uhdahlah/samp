#define MAX_SPEED_CAMERAS           50

enum speedData 
{
	speedID,
	speedExists,
	Float:speedPos[4],
	Float:speedRange,
	Float:speedLimit,
	speedObject,
	Text3D:speedText3D,
	sMapIcon
};
new SpeedData[MAX_SPEED_CAMERAS][speedData];

stock Speed_Refresh(speedid)
{
	if (speedid != -1 && SpeedData[speedid][speedExists])
	{
	    new
	        string[64];

		if (IsValidDynamicObject(SpeedData[speedid][speedObject]))
		    DestroyDynamicObject(SpeedData[speedid][speedObject]);

		if (IsValidDynamic3DTextLabel(SpeedData[speedid][speedText3D]))
		    DestroyDynamic3DTextLabel(SpeedData[speedid][speedText3D]);

		format(string, sizeof(string), "{00FFFF}[SpeedCamera]\n"GREY_E"Max Speed: %.0f MPH Speed Limit", SpeedData[speedid][speedLimit]);

		SpeedData[speedid][speedText3D] = CreateDynamic3DTextLabel(string, 0xFF0000FF, SpeedData[speedid][speedPos][0], SpeedData[speedid][speedPos][1], SpeedData[speedid][speedPos][2] + 2.5, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0);
        SpeedData[speedid][speedObject] = CreateDynamicObject(18880, SpeedData[speedid][speedPos][0], SpeedData[speedid][speedPos][1], SpeedData[speedid][speedPos][2], 0.0, 0.0, SpeedData[speedid][speedPos][3]);
	}
	return 1;
}

stock Speed_Save(speedid)
{
	new
	    query[255];

	format(query, sizeof(query), "UPDATE `speedcameras` SET `speedRange` = '%.4f', `speedLimit` = '%.4f', `speedX` = '%.4f', `speedY` = '%.4f', `speedZ` = '%.4f', `speedAngle` = '%.4f' WHERE `speedID` = '%d'",
	    SpeedData[speedid][speedRange],
	    SpeedData[speedid][speedLimit],
	    SpeedData[speedid][speedPos][0],
	    SpeedData[speedid][speedPos][1],
	    SpeedData[speedid][speedPos][2],
	    SpeedData[speedid][speedPos][3],
	    SpeedData[speedid][speedID]
	);
	return mysql_tquery(g_SQL, query);
}

stock Speed_Nearest(playerid)
{
	for (new i = 0; i < MAX_SPEED_CAMERAS; i ++) if (SpeedData[i][speedExists] && IsPlayerInRangeOfPoint(playerid, SpeedData[i][speedRange], SpeedData[i][speedPos][0], SpeedData[i][speedPos][1], SpeedData[i][speedPos][2]))
	    return i;

	return -1;
}

stock Speed_Delete(speedid)
{
    if (speedid != -1 && SpeedData[speedid][speedExists])
	{
	    new
	        string[64];

		if (IsValidDynamicObject(SpeedData[speedid][speedObject]))
		    DestroyDynamicObject(SpeedData[speedid][speedObject]);

		if (IsValidDynamic3DTextLabel(SpeedData[speedid][speedText3D]))
		    DestroyDynamic3DTextLabel(SpeedData[speedid][speedText3D]);

		format(string, sizeof(string), "DELETE FROM `speedcameras` WHERE `speedID` = '%d'", SpeedData[speedid][speedID]);
		mysql_tquery(g_SQL, string);

		SpeedData[speedid][speedExists] = false;
		SpeedData[speedid][speedLimit] = 0.0;
		SpeedData[speedid][speedRange] = 0.0;
		SpeedData[speedid][speedID] = 0;
	}
	return 1;
}

stock Speed_Create(playerid, Float:limit, Float:range)
{
	new
	    Float:x,
	    Float:y,
	    Float:z,
	    Float:angle;

	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);

	for (new i = 0; i < MAX_SPEED_CAMERAS; i ++) if (!SpeedData[i][speedExists])
	{
	    SpeedData[i][speedExists] = true;
	    SpeedData[i][speedRange] = range;
        SpeedData[i][speedLimit] = limit;

		SpeedData[i][speedPos][0] = x + (1.5 * floatsin(-angle, degrees));
	    SpeedData[i][speedPos][1] = y + (1.5 * floatcos(-angle, degrees));
	    SpeedData[i][speedPos][2] = z - 1.2;
	    SpeedData[i][speedPos][3] = angle;

	    Speed_Refresh(i);
	    mysql_tquery(g_SQL, "INSERT INTO `speedcameras` (`speedRange`) VALUES(0.0)", "OnSpeedCreated", "d", i);
	    return i;
	}
	return -1;
}

forward OnSpeedCreated(speedid);
public OnSpeedCreated(speedid)
{
	if (speedid == -1 || !SpeedData[speedid][speedExists])
	    return 0;

	SpeedData[speedid][speedID] = cache_insert_id();
	Speed_Save(speedid);

	return 1;
}

function LoadSpeedCam()
{
    new rows = cache_num_rows();
 	if(rows)
  	{
   		new wid;
		for(new i; i < rows; i++)
		{
  			cache_get_value_name_int(i, "speedID", wid);
		    cache_get_value_name_float(i, "speedRange", SpeedData[wid][speedRange]);
		    cache_get_value_name_float(i, "speedLimit", SpeedData[wid][speedLimit]);
		    cache_get_value_name_float(i, "speedX", SpeedData[wid][speedPos][0]);
			cache_get_value_name_float(i, "speedY", SpeedData[wid][speedPos][1]);
			cache_get_value_name_float(i, "speedZ", SpeedData[wid][speedPos][2]);
			cache_get_value_name_float(i, "speedAngle", SpeedData[wid][speedPos][3]);

            SpeedData[wid][speedExists] = true;
			Speed_Refresh(wid);
	    }
	    printf("*** [Database: Loaded] speed cam data (%d count).", rows);
	}
}

ptask SpeedCams[1000](playerid)
{
    new str[212];
	for (new i = 0; i < MAX_SPEED_CAMERAS; i ++) 
    {
        if (IsPlayerInRangeOfPoint(playerid, SpeedData[i][speedRange], SpeedData[i][speedPos][0], SpeedData[i][speedPos][1], SpeedData[i][speedPos][2]))
        {
            if(GetPlayerSpeed(playerid) > SpeedData[i][speedLimit])
            {
                new price = 100 + floatround(GetPlayerSpeed(playerid) - SpeedData[i][speedLimit]);
                
                SendClientMessageEx(playerid, COLOR_ARWIN, "SPEED: "WHITE_E"Speeding {00FFFF}(%.0f/%.0f mph)", GetPlayerSpeed(playerid), SpeedData[i][speedLimit]);
                format(str, sizeof(str), "SPEED: "WHITE_E"You have received a "YELLOW_E"%s "WHITE_E"speeding ticket.", FormatMoney(price));
                SendClientMessageEx(playerid, COLOR_ARWIN, str);
                GivePlayerMoneyEx(playerid, -price);
            }
        } 
	}
}

CMD:createspeed(playerid, params[])
{
	static
	    Float:limit,
	    Float:range;
    if(pData[playerid][pAdmin] < 6)
	    return PermissionError(playerid);

	if (sscanf(params, "ff", limit, range))
		return Usage(playerid, "/createspeed [speed limit] [range] (default range: 30)");

	if (limit < 5.0 || limit > 200.0)
	    return Info(playerid, "The speed limit can't be below 5 or above 200.");

	if (range < 5.0 || range > 50.0)
	    return Info(playerid, "The range can't be below 5 or above 50.");

	if (Speed_Nearest(playerid) != -1)
	    return Info(playerid, "You can't do this in range another speed camera.");

	new id = Speed_Create(playerid, limit, range);

	if (id == -1)
	    return Info(playerid, "The server has reached the limit for speed cameras.");

	Info(playerid, "You have created speed camera ID: %d.", id);
	return 1;
}

CMD:gotospeed(playerid, params[])
{
	new houseid;

    if(pData[playerid][pAdmin] < 6)
	    return PermissionError(playerid);

	if(sscanf(params, "i", houseid))
	{
	    return Usage(playerid, "/gotogate [gateid]");
	}
	if(!(0 <= houseid < MAX_SPEED_CAMERAS) || !SpeedData[houseid][speedExists])
	{
	    return Info(playerid, "Invalid gate.");
	}
	SetPlayerPos(playerid, SpeedData[houseid][speedPos][0] - (2.5 * floatsin(-SpeedData[houseid][speedPos][3], degrees)), SpeedData[houseid][speedPos][1] - (2.5 * floatcos(-SpeedData[houseid][speedPos][3], degrees)), SpeedData[houseid][speedPos][2]);
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	SetCameraBehindPlayer(playerid);
	return 1;
}

CMD:destroyspeed(playerid, params[])
{
	static
	    id = 0;

    if(pData[playerid][pAdmin] < 6)
	    return PermissionError(playerid);

	if (sscanf(params, "d", id))
	    return Usage(playerid, "/destroyspeed [speed id]");

	if ((id < 0 || id >= MAX_SPEED_CAMERAS) || !SpeedData[id][speedExists])
	    return Info(playerid, "You have specified an invalid speed camera ID.");

	Speed_Delete(id);
	DestroyDynamicMapIcon(SpeedData[id][sMapIcon]);
	Info(playerid, "You have successfully destroyed speed camera ID: %d.", id);
	return 1;
}
