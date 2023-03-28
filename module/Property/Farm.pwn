
enum ladang
{
	laName[50],
	laOwner[MAX_PLAYER_NAME],
	laPrice,
	Float:laExtposX,
	Float:laExtposY,
	Float:laExtposZ,
	Float:laExtTanemX,
	Float:laExtTanemY,
	Float:laExtTanemZ,
	Float:laExtTanemA,
	laProduct,
	laWhite,
	laOrange,
    laPegawai1[32],
    laPegawai2[32],
    laPegawai3[32],
	wPicksafe,
	wInt,
	wPickup,
	Text3D:wLabelPoint
};

new laData[MAX_LADANG][ladang],
	Iterator:FARMS<MAX_LADANG>;

Ladang_Save(id)
{
	new dquery[2048];
	format(dquery, sizeof(dquery), "UPDATE ladang SET name='%s', owner='%s', price='%d', extposx='%f', extposy='%f', extposz='%f'",
	laData[id][laName],
	laData[id][laOwner],
	laData[id][laPrice],
	laData[id][laExtposX],
	laData[id][laExtposY],
	laData[id][laExtposZ]);

	format(dquery, sizeof(dquery), "%s, safex='%f', safey='%f', safez='%f', product='%d', white='%d', orange='%d' WHERE ID='%d'",
	dquery,
	laData[id][laExtTanemX],
	laData[id][laExtTanemY],
	laData[id][laExtTanemZ],
	laData[id][laProduct],
	laData[id][laWhite],
	laData[id][laOrange],
	id);
	return mysql_tquery(g_SQL, dquery);
}

Ladang_Refresh(id)
{
	if(id != -1)
	{
        if(IsValidDynamicPickup(laData[id][wPickup]))
            DestroyDynamicPickup(laData[id][wPickup]);

        if(IsValidDynamic3DTextLabel(laData[id][wLabelPoint]))
            DestroyDynamic3DTextLabel(laData[id][wLabelPoint]);

		new string[900];
        if(strcmp(laData[id][laOwner], "-"))
		{
            format(string, sizeof(string), "{00FFFF}[id:%d]\n{FFFFFF}Farm\n{FFFFFF}Name: "BLUE_E"%s\n"WHITE_E"Potato Stock: "YELLOW_E"%d\n"WHITE_E"Wheat Stock: "YELLOW_E"%d\n"WHITE_E"Orange Stock: "YELLOW_E"%d", id, laData[id][laName], laData[id][laWhite], laData[id][laOrange]);
            laData[id][wPickup] = CreateDynamicPickup(19132, 23, laData[id][laExtposX], laData[id][laExtposY], laData[id][laExtposZ]+0.2, 0, 0, _, 8.0);
			laData[id][wLabelPoint] = CreateDynamic3DTextLabel(string, COLOR_ARWIN, laData[id][laExtposX], laData[id][laExtposY], laData[id][laExtposZ]+0.5, 2.5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0, 0);
		}		
        else
        {
            format(string, sizeof(string), "{00FFFF}[id:%d]\n{00D900}This farm is for sale\n{FFFF00}Price: {00FF00}$%s\n{00D900}use '/buy' for buy this Farm", id, FormatMoney(laData[id][laPrice]));
            laData[id][wPickup] = CreateDynamicPickup(19132, 23, laData[id][laExtposX], laData[id][laExtposY], laData[id][laExtposZ]+0.2, 0, 0, _, 8.0);
			laData[id][wLabelPoint] = CreateDynamic3DTextLabel(string, COLOR_ARWIN, laData[id][laExtposX], laData[id][laExtposY], laData[id][laExtposZ]+0.5, 2.5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0, 0);
		}
	}
}

function FarmCreate(id)
{
	Ladang_Save(id);
	Ladang_Refresh(id);
	return 1;
}

function LoadFarm()
{
    new rows = cache_num_rows();
 	if(rows)
  	{
   		new wid, name[50], owner[MAX_PLAYER_NAME];
		for(new i; i < rows; i++)
		{
  			cache_get_value_name_int(i, "ID", wid);
	    	cache_get_value_name(i, "name", name);
			format(laData[wid][laName], 50, name);
		    cache_get_value_name(i, "owner", owner);
			format(laData[wid][laOwner], MAX_PLAYER_NAME, owner);
			cache_get_value_name_int(i, "price", laData[wid][laPrice]);
		    cache_get_value_name_float(i, "extposx", laData[wid][laExtposX]);
		    cache_get_value_name_float(i, "extposy", laData[wid][laExtposY]);
		    cache_get_value_name_float(i, "extposz", laData[wid][laExtposZ]);
			cache_get_value_name_float(i, "safex", laData[wid][laExtTanemX]);
			cache_get_value_name_float(i, "safey", laData[wid][laExtTanemY]);
			cache_get_value_name_float(i, "safez", laData[wid][laExtTanemZ]);
			cache_get_value_name_int(i, "product", laData[wid][laProduct]);
			cache_get_value_name_int(i, "white", laData[wid][laWhite]);
			cache_get_value_name_int(i, "orange", laData[wid][laOrange]);

			Iter_Add(FARMS, wid);
			Ladang_Refresh(wid);
	    }
	    printf("*** [Database: Loaded] farmer data (%d count).", rows);
	}
}

CMD:lacreate(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	new wid = Iter_Free(FARMS);
	if(wid == -1) return Error(playerid, "You cant create more workshop slot empty!");
	new name, query[128];
	if(sscanf(params, "d", name)) return Usage(playerid, "/lacreate [price]");

	format(laData[wid][laName], 50, "No Name");
	format(laData[wid][laOwner], 50, "-");
    format(laData[wid][laPegawai1], 50, "-");
    format(laData[wid][laPegawai2], 50, "-");
    format(laData[wid][laPegawai3], 50, "-");
	laData[wid][laPrice] = name;
	GetPlayerPos(playerid, laData[wid][laExtposX], laData[wid][laExtposY], laData[wid][laExtposZ]);
	laData[wid][laExtposX] = laData[wid][laExtposX];
	laData[wid][laExtposY] = laData[wid][laExtposY];
	laData[wid][laExtposZ] = laData[wid][laExtposZ];

	laData[wid][laProduct] = 0;
	laData[wid][laExtTanemX] = 0;
	laData[wid][laExtTanemY] = 0;
	laData[wid][laExtTanemZ] = 0;

	Iter_Add(FARMS, wid);
	new String[212];
	format(String, sizeof(String), "AdmWarn: "YELLOW_E"%s "WHITE_E"telah membuat Ladang ID "YELLOW_E"%d Harga "GREEN_E"$%s.", pData[playerid][pAdminname], wid, FormatMoney(name));
	SendClientAdm(COLOR_ARWIN, String, 4); 
	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO ladang SET ID=%d, price='%d'", wid, name);
	mysql_tquery(g_SQL, query, "FarmCreate", "i", wid);
	return 1;
}

CMD:ladelete(playerid, params[])
{
 	if(pData[playerid][pAdmin] < 4)
		return PermissionError(playerid);

    new wid, query[128];
	if(sscanf(params, "i", wid)) return Usage(playerid, "/ladelete [wid]");
	if(!Iter_Contains(FARMS, wid)) return Error(playerid, "The you specified ID of doesn't exist.");

    format(laData[wid][laName], 50, "None");
	format(laData[wid][laOwner], 50, "None");
    format(laData[wid][laPegawai1], 50, "-");
    format(laData[wid][laPegawai2], 50, "-");
    format(laData[wid][laPegawai3], 50, "-");
	laData[wid][laExtposX] = 0;
	laData[wid][laExtposY] = 0;
	laData[wid][laExtposZ] = 0;
	
	laData[wid][laProduct] = 0;
	laData[wid][laExtTanemX] = 0;
	laData[wid][laExtTanemY] = 0;
	laData[wid][laExtTanemZ] = 0;

	Iter_Remove(FARMS, wid);

	mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET ladang=-1,ladangrank=0 WHERE ladang=%d", wid);
	mysql_tquery(g_SQL, query);

	foreach(new ii : Player)
	{
 		if(pData[ii][pLadang] == wid)
   		{
			pData[ii][pLadang]= -1;
			pData[ii][pLadangRank] = 0;
		}
	}
	mysql_format(g_SQL, query, sizeof(query), "DELETE FROM ladang WHERE ID=%d", wid);
	mysql_tquery(g_SQL, query);
    SendStaffMessage(TOMATO, "AdmCmd: %s telah menghapus LAdang ID: %d.", pData[playerid][pAdminname], wid);
	return 1;
}


CMD:laedit(playerid, params[])
{
    static
        wid,
        type[24],
        string[128];

    if(pData[playerid][pAdmin] < 4)
        return PermissionError(playerid);

    if(sscanf(params, "ds[24]S()[128]", wid, type, string))
    {
        Usage(playerid, "/laedit [id] [name]");
        SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} location, name, area");
        return 1;
    }
    if((wid < 0 || wid >= MAX_LADANG))
        return Error(playerid, "You have specified an invalid ID.");
	if(!Iter_Contains(FARMS, wid)) return Error(playerid, "The you specified ID of doesn't exist.");

    if(!strcmp(type, "location", true))
    {
		GetPlayerPos(playerid, laData[wid][laExtposX], laData[wid][laExtposY], laData[wid][laExtposZ]);

        Ladang_Save(wid);
        Ladang_Refresh(wid);
        SendStaffMessage(TOMATO, "AdmCmd: %s has adjusted the location of entrance ID: %d.", pData[playerid][pAdminname], wid);
    }
    else if(!strcmp(type, "name", true))
    {
        new name[50];

        if(sscanf(string, "s[50]", name))
            return Usage(playerid, "/laedit [id] [name] [Name Ladang]");

        format(laData[wid][laName], 50, name);
		Ladang_Save(wid);

        SendStaffMessage(TOMATO, "AdmCmd: %s has changed the Ladang name ID: %d to: %s.", pData[playerid][pAdminname], wid, name);
    }
    if(!strcmp(type, "area", true))
    {
		GetPlayerPos(playerid, laData[wid][laExtTanemX], laData[wid][laExtTanemY], laData[wid][laExtTanemZ]);

        Ladang_Save(wid);
        Ladang_Refresh(wid);
        SendStaffMessage(TOMATO, "AdmCmd: %s has adjusted the location of entrance ID: %d.", pData[playerid][pAdminname], wid);
    }
    return 1;
}

CMD:lainvite(playerid, params[])
{
	if(pData[playerid][pLadang] == -1)
		return Error(playerid, "You are not in Ladang!");

	if(pData[playerid][pLadangRank] < 5)
		return Error(playerid, "You must farm owner!");

	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/lainvite [playerid/PartOfName]");

	if(!IsPlayerConnected(otherid))
		return Error(playerid, "Invalid ID.");

	if(otherid == playerid)
		return Error(playerid, "Invalid ID.");

	if(!NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "You must be near this player.");

	if(pData[otherid][pLadang] != -1)
		return Error(playerid, "Player tersebut sudah bergabung di ladang lain!");

	if(pData[otherid][pFaction] != 0)
		return Error(playerid, "Player tersebut sudah bergabung faction!");

	new count = 0, limit = 3;
	foreach(new ii : Player)
	{
		if(pData[ii][pLadang] == pData[playerid][pLadang])
			count++;
	}
	if(count >= limit)
	{
		Error(playerid, "Max Anggota Ladang hanya 4!");
		return 1;
	}
	pData[otherid][pLadangInvite] = pData[playerid][pLadang];
	pData[otherid][pLadangOffer] = playerid;
	Servers(playerid, "Anda telah menginvite %s untuk menjadi anggota Farm.", pData[otherid][pName]);
	Servers(otherid, "%s telah menginvite anda untuk menjadi anggota Farm. Type: /accept Farm", pData[playerid][pName]);
	return 1;
}

CMD:lasafe(playerid)
{
	if(pData[playerid][pLadang] == -1)
		return Error(playerid, "Anda bukan anggota Farm");

	new wid = pData[playerid][pLadang];
	if(IsPlayerInRangeOfPoint(playerid, 5.0, laData[wid][laExtposX], laData[wid][laExtposY], laData[wid][laExtposZ]))
    {
     	ShowPlayerDialog(playerid, FARM_SAFE, DIALOG_STYLE_LIST, "Ladang SAFE", "Potato\nWheat\nOrange\nChange Name Ladang", "Select", "Cancel");
    }
 	else
   	{
     	Error(playerid, "You aren't in range in area Ladang safe.");
    }
	return 1;
}

CMD:launinvite(playerid, params[])
{
	if(pData[playerid][pLadang] == -1)
		return Error(playerid, "You are not in farm!");

	if(pData[playerid][pLadangRank] < 5)
		return Error(playerid, "You must farm owner!");

	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/launinvite [playerid/PartOfName]");

	if(!IsPlayerConnected(otherid))
		return Error(playerid, "Invalid ID.");

	if(otherid == playerid)
		return Error(playerid, "Invalid ID.");

	if(pData[otherid][pLadangRank] > pData[playerid][pLadangRank])
		return Error(playerid, "You cant kick him.");

	pData[otherid][pLadangRank] = 0;
	pData[otherid][pLadang] = -1;
	Servers(playerid, "Anda telah mengeluarkan %s dari anggota Farm.", pData[otherid][pName]);
	Servers(otherid, "%s telah mengeluarkan anda dari anggota Farm.", pData[playerid][pName]);
	return 1;
}

CMD:lainfo(playerid, params[])
{
	if(pData[playerid][pLadang] == -1)
        return Error(playerid, "You must in ladang member to use this command!");

	ShowPlayerDialog(playerid, FARM_INFO, DIALOG_STYLE_LIST, "Farm Info", "Farm Info", "Select", "Cancel");
	return 1;
}

function ShowFarmInfo(playerid)
{
	new rows = cache_num_rows();
 	if(rows)
  	{
 		new name[50],
 			owner[50],
            wheat,
			orange,
			product,
			string[512];

		cache_get_value_index(0, 0, name);
		cache_get_value_index(0, 1, owner);
		cache_get_value_index_int(0, 2, product);
		cache_get_value_index_int(0, 3, wheat);
		cache_get_value_index_int(0, 3, orange);

		format(string, sizeof(string), "Farm ID: %d\nFarm Name: %s\nFarm owner: %s\nFarm Potato: %d\nFarm Wheat: %d\nFarm Orange: %d",
		pData[playerid][pLadang], name, owner, product, wheat, orange);

		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Farm Info", string, "Okay", "");
	}
}

CMD:sellfarm(playerid, params[])
{
	new wid = pData[playerid][pLadang];
	if(pData[playerid][pLadang] == -1)
        return Error(playerid, "You must in farm member to use this command!");
	if(pData[playerid][pLadangRank] < 6)
		return Error(playerid, "You must farm owner!");
	new string[212];
	new pay;
	pay = laData[wid][laPrice] / 80;
	format(string, sizeof(string), ""WHITE_E"Farm Name: "YELLOW_E"%s\n"WHITE_E"Farm Price: "GREEN_E"%s\nAnda Yakin ingin menjual farm", laData[wid][laName], FormatMoney(pay));
	ShowPlayerDialog(playerid, DIALOG_FARMSELL, DIALOG_STYLE_MSGBOX, "Farm Sell", string, "Okay", "Cancel");
	return 1;	
}

CMD:givefarm(playerid, params[])
{
	new otherid;
	new wid = pData[playerid][pLadang];
	if(pData[playerid][pLadang] == -1)
        return Error(playerid, "You must in farm member to use this command!");
	if(pData[playerid][pLadangRank] < 6)
		return Error(playerid, "You must farm owner!");
	if(sscanf(params, "d", otherid)) return Usage(playerid, "/givefarm [playerid/name]");
	
	if(!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 4.0))
        return Error(playerid, "The specified player is disconnected or not near you.");
	if(pData[otherid][pLadang] > 0) return Error(playerid, "Player Tersebut sudah bergabung/memiliki farm"); 
	
	GetPlayerName(otherid, laData[wid][laOwner], MAX_PLAYER_NAME);
	SendClientMessageEx(playerid, COLOR_ARWIN, "FARM: "WHITE_E"Anda berhasil memberika farm kepada player "YELLOW_E"%s", pData[otherid][pName]);
	SendClientMessageEx(otherid, COLOR_ARWIN, "FARM: "YELLOW_E"%s "WHITE_E"berhasil memberikan farm kepada anda", pData[playerid][pName]);
	Ladang_Refresh(wid);
	Ladang_Save(wid);
	pData[otherid][pLadang] = wid;
	pData[otherid][pLadangRank] = 6;
	pData[playerid][pLadang] = -1;
	pData[playerid][pLadangRank] = 0;
	return 1;	
}