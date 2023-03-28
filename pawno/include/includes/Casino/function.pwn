
forward OnCasinoCreated(index);
public OnCasinoCreated(index)
{
	CasinoData[index][cID] = cache_insert_id();

	Casino_Sync(index);
	Casino_Save(index);
	return 1;
}

forward Casino_Load();
public Casino_Load()
{
	if(cache_num_rows())
	{
		for(new i = 0; i != cache_num_rows(); i++)
		{
            Iter_Add(Casino, i); // coba lagi
            cache_get_value_name_int(i, "casinoID", CasinoData[i][cID]);
            cache_get_value_name_int(i, "casinoOwner", CasinoData[i][cOwner]);
            cache_get_value_name_int(i, "casinoPrice", CasinoData[i][cPrice]);

            cache_get_value_name(i, "casinoName", CasinoData[i][cName], 128);
            cache_get_value_name(i, "casinoOwnerName", CasinoData[i][cOwnerName], 128);

            cache_get_value_name_float(i, "ExtPosX", CasinoData[i][cPosExtX]);
            cache_get_value_name_float(i, "ExtPosY", CasinoData[i][cPosExtY]);
            cache_get_value_name_float(i, "ExtPosZ", CasinoData[i][cPosExtZ]);
            cache_get_value_name_float(i, "ExtPosA", CasinoData[i][cPosExtA]);

            cache_get_value_name_float(i, "IntPosX", CasinoData[i][cPosIntX]);
            cache_get_value_name_float(i, "IntPosY", CasinoData[i][cPosIntY]);
            cache_get_value_name_float(i, "IntPosZ", CasinoData[i][cPosIntZ]);
            cache_get_value_name_float(i, "IntPosA", CasinoData[i][cPosIntA]);

            cache_get_value_name_int(i, "Interior", CasinoData[i][cPosInterior]);
            cache_get_value_name_int(i, "World", CasinoData[i][cPosWorld]);

            cache_get_value_name_int(i, "Vault", CasinoData[i][cVault]);
            cache_get_value_name_int(i, "int", CasinoData[i][cInt]);

            Casino_Sync(i);
        }

        printf("[Casino] Loaded %d Casino", cache_num_rows());
    }
    return 1;
}

Casino_IsExists(index)
{
    if(Iter_Contains(Casino, index))
        return 1;
    
    return 0;
}

Casino_Create(playerid)
{
    static index;
    new string[255];
    if((index = Iter_Free(Casino)) != cellmin)
    {
        Iter_Add(Casino, index);
        GetPlayerPos(playerid, CasinoData[index][cPosExtX],CasinoData[index][cPosExtY],CasinoData[index][cPosExtZ]);
        GetPlayerFacingAngle(playerid, CasinoData[index][cPosExtA]);

        format(CasinoData[index][cName], 128, "Casino");
        format(CasinoData[index][cOwnerName], 128, "None");
        CasinoData[index][cOwner] = -1;
        CasinoData[index][cPrice] = 99999999;

        CasinoData[index][cVault] = 0;

        CasinoData[index][cPosIntX] = 0;
        CasinoData[index][cPosIntY] = 0;
        CasinoData[index][cPosIntZ] = 0;
        CasinoData[index][cPosIntA] = 0;
        CasinoData[index][cInt] = 0;
        
        Casino_Type(index);
        format(string, sizeof(string), "INSERT INTO `casino` (`casinoOwner`) VALUES ('%d')", CasinoData[index][cOwner]);
        mysql_tquery(g_SQL, string, "OnCasinoCreated", "d", index);
        return index;
    }
    return INVALID_CASINO_ID;
}

Casino_Type(index)
{
    switch(random(2))
	{
		case 0:
		{
			CasinoData[index][cPosIntX] = 2018.3013;
			CasinoData[index][cPosIntY] = 1017.6812;
			CasinoData[index][cPosIntZ] = 996.8750;
			CasinoData[index][cPosIntA] = 267.9951;
			CasinoData[index][cInt] = 10;
		}
		case 1:
		{
			CasinoData[index][cPosIntX] = 2018.3013;
			CasinoData[index][cPosIntY] = 1017.6812;
			CasinoData[index][cPosIntZ] = 996.8750;
			CasinoData[index][cPosIntA] = 267.9951;
			CasinoData[index][cInt] = 5;
		}
	}
}

Casino_Delete(index)
{
    if(Casino_IsExists(index))
    {
        new string[255];
        Iter_Remove(Casino, index);
        format(string, sizeof(string), "DELETE FROM `casino` WHERE `casinoID` = '%d'", CasinoData[index][cID]);
        mysql_tquery(g_SQL, string);

        if(IsValidDynamicCP(CasinoData[index][cCheckpoint]))
            DestroyDynamicCP(CasinoData[index][cCheckpoint]);

        if(IsValidDynamicPickup(CasinoData[index][cPickup]))
            DestroyDynamicCP(CasinoData[index][cPickup]);

        if(IsValidDynamic3DTextLabel(CasinoData[index][cText]))
            DestroyDynamic3DTextLabel(CasinoData[index][cText]);

        new tmp_CasinoData[E_CASINO_DATA];
        CasinoData[index] = tmp_CasinoData;

        CasinoData[index][cCheckpoint] = INVALID_STREAMER_ID;
        CasinoData[index][cPickup] = INVALID_STREAMER_ID;
        CasinoData[index][cText] = Text3D:INVALID_3DTEXT_ID;

        return 1;
    }
    return 0;
}

Casino_Sync(index)
{
    if(Casino_IsExists(index))
    {
        new 
            Float:x = CasinoData[index][cPosExtX],
            Float:y = CasinoData[index][cPosExtY],
            Float:z = CasinoData[index][cPosExtZ],
            Float:intx = CasinoData[index][cPosIntX],
            Float:inty = CasinoData[index][cPosIntY],
            Float:intz = CasinoData[index][cPosIntZ],
            string[1024]
        ;

        if(IsValidDynamicCP(CasinoData[index][cCheckpoint]))
        {
            Streamer_SetFloatData(STREAMER_TYPE_CP, CasinoData[index][cCheckpoint], E_STREAMER_X, x);
            Streamer_SetFloatData(STREAMER_TYPE_CP, CasinoData[index][cCheckpoint], E_STREAMER_Y, y);
            Streamer_SetFloatData(STREAMER_TYPE_CP, CasinoData[index][cCheckpoint], E_STREAMER_Z, z);
        }
        else
        {
            //CasinoData[index][cCheckpoint] = CreateDynamicCP(x, y, z, 3.0);
            CasinoData[index][cCheckpoint] = CreateDynamicCP(intx, inty, intz, 3.0);
        }

        if(IsValidDynamicPickup(CasinoData[index][cPickup]))
        {
            Streamer_SetFloatData(STREAMER_TYPE_PICKUP, CasinoData[index][cPickup], E_STREAMER_X, x);
            Streamer_SetFloatData(STREAMER_TYPE_PICKUP, CasinoData[index][cPickup], E_STREAMER_Y, y);
            Streamer_SetFloatData(STREAMER_TYPE_PICKUP, CasinoData[index][cPickup], E_STREAMER_Z, z);
        }
        else
        {
            CasinoData[index][cPickup] = CreateDynamicPickup(1272, 23, x, y, z, -1, -1, -1, 10);
        }

        if(IsValidDynamic3DTextLabel(CasinoData[index][cText]))
        {
            Streamer_SetFloatData(STREAMER_TYPE_PICKUP, CasinoData[index][cText], E_STREAMER_X, x);
            Streamer_SetFloatData(STREAMER_TYPE_PICKUP, CasinoData[index][cText], E_STREAMER_Y, y);
            Streamer_SetFloatData(STREAMER_TYPE_PICKUP, CasinoData[index][cText], E_STREAMER_Z, z);

            if(CasinoData[index][cOwner] == -1) format(string, sizeof(string), "For Sale\n[ID : %d]\n%s\nOwner Name : %s\nPrice : %d\n", index, CasinoData[index][cName], CasinoData[index][cOwnerName], CasinoData[index][cPrice]);
            else format(string, sizeof(string), "[ID : %d]\n%s\n"WHITE_E"Owned by %s\nPress '{FF0000}F{FFFFFF}' to enter", index, CasinoData[index][cName], CasinoData[index][cOwnerName]);

            UpdateDynamic3DTextLabelText(CasinoData[index][cText], COLOR_WHITE, string);
        }
        else
        {
            if(CasinoData[index][cOwner] == -1) format(string, sizeof(string), "For Sale\n[ID : %d]\n%s\nOwner Name : %s\nPrice : %d\n", index, CasinoData[index][cName], CasinoData[index][cOwnerName], CasinoData[index][cPrice]);
            else format(string, sizeof(string), "[ID : %d]\n%s\n"WHITE_E"Owned by %s\nPress '{FF0000}F{FFFFFF}' to enter", index, CasinoData[index][cName], CasinoData[index][cOwnerName]);

            CasinoData[index][cText] = CreateDynamic3DTextLabel(string, COLOR_WHITE, x, y, z, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1);
        }
        return 1;
    }
    return 0;
}

Casino_IsOwned(playerid, index)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(index == -1) return 0;
	if(!strcmp(CasinoData[index][cOwnerName], pData[playerid][pName], true)) return 1;
	return 0;
}

Casino_Nearest(playerid)
{
    foreach(new i : Casino)
    {
        if(IsPlayerInRangeOfPoint(playerid, 5.0, CasinoData[i][cPosExtX], CasinoData[i][cPosExtY], CasinoData[i][cPosExtZ]))
            return i;
    }
    return INVALID_CASINO_ID;
}

Casino_Inside(playerid)
{
    foreach(new i : Casino)
    {
        if(GetPlayerVirtualWorld(playerid) == CasinoData[i][cPosWorld] && GetPlayerInterior(playerid) == CasinoData[i][cInt])
        {
            return i;
        }
    }
    return INVALID_CASINO_ID;
}

Casino_Save(index)
{
    new query[1024];
    if(Casino_IsExists(index))
    {
        format(query, sizeof(query), "UPDATE `casino` SET `casinoOwner` = '%s', `casinoPrice` = '%d', `casinoName` = '%d', `casinoOwnerName` = '%s', `ExtPosX` = '%f', `ExtPosY` = '%f', `ExtPosZ` = '%f', `ExtPosA` = '%f', `IntPosX` = '%f', `IntPosY` = '%f', `IntPosZ` = '%f', `IntPosA` = '%f', `Interior` = '%f', `World` = '%f', `Vault` = '%d', `int` = '%d' WHERE `casinoID` = '%d'",
        CasinoData[index][cOwner],
        CasinoData[index][cPrice],
        CasinoData[index][cName],
        CasinoData[index][cOwnerName],
        CasinoData[index][cPosExtX],
        CasinoData[index][cPosExtY],
        CasinoData[index][cPosExtZ],
        CasinoData[index][cPosExtA],
        CasinoData[index][cPosIntX],
        CasinoData[index][cPosIntY],
        CasinoData[index][cPosIntZ],
        CasinoData[index][cPosIntA],
        CasinoData[index][cPosInterior],
        CasinoData[index][cPosWorld],
        CasinoData[index][cVault],
        CasinoData[index][cInt],
        CasinoData[index][cID]    
        );
        return mysql_tquery(g_SQL, query);
    }
    return 0;
}

stock IsPlayerNearPlayer(playerid, targetid, Float:radius)
{
    static
        Float:fX,
        Float:fY,
        Float:fZ;

    GetPlayerPos(targetid, fX, fY, fZ);

    return (GetPlayerInterior(playerid) == GetPlayerInterior(targetid) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(targetid)) && IsPlayerInRangeOfPoint(playerid, radius, fX, fY, fZ);
}
