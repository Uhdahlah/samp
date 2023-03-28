#include <YSI\y_hooks>
//workshop System
#define MAX_WORKSHOP 20

enum workshop
{
	wName[50],
	wOwner[MAX_PLAYER_NAME],
	wPrice,
	Float:wExtposX,
	Float:wExtposY,
	Float:wExtposZ,
	Float:wSafeposX,
	Float:wSafeposY,
	Float:wSafeposZ,
	Float:wSafeposA,
	wMoney,
	wComponent,
	wsPapanMT,	
	wsPapanText[255],
	Float:wsPapanX,
	Float:wsPapanY,
	Float:wsPapanZ,
	Float:wsPapanRotX,
	Float:wsPapanRotY,
	Float:wsPapanRotZ,
	Text3D:wLabelsafe,
	wsPapan,
	wPicksafe,
	wInt,
	wPickup,
	Text3D:wLabelPoint
};

new wData[MAX_WORKSHOP][workshop],
	Iterator:WORKSHOPS<MAX_WORKSHOP>;
new wsEditID[MAX_PLAYERS];
new wsEdit[MAX_PLAYERS]; //1=postext,2-3=gate,4-5=gate2
new Float:wsPos[MAX_PLAYERS][3];
new Float:wsRot[MAX_PLAYERS][3];

/*hook OnGameModeInit()
{
	mysql_tquery(g_SQL, "SELECT * FROM `workshops`", "LoadWorkshops");
	return 1;
}*/

hook OnPlayerConnect(playerid)
{
	pData[playerid][pWorkInvite] = -1;
	pData[playerid][pWorkOffer] = -1;	
	return 1;
}

Workshop_Save(id)
{
	new dquery[2048];
	format(dquery, sizeof(dquery), "UPDATE workshops SET name='%s', owner='%s', price='%d', extposx='%f', extposy='%f', extposz='%f'",
	wData[id][wName],
	wData[id][wOwner],
	wData[id][wPrice],
	wData[id][wExtposX],
	wData[id][wExtposY],
	wData[id][wExtposZ]);

	format(dquery, sizeof(dquery), "%s, safex='%f', safey='%f', safez='%f', money='%d', component='%d'", 
	dquery,
	wData[id][wSafeposX],
	wData[id][wSafeposY],
	wData[id][wSafeposZ],
	wData[id][wMoney],
	wData[id][wComponent]);

	format(dquery, sizeof(dquery), "%s, papanmt='%d', text='%s', posmtx='%f', posmty='%f', posmtz='%f', posmtrotx='%f', posmtroty='%f', posmtrotz='%f' WHERE ID='%d'",
	dquery,
	wData[id][wsPapanMT],
	wData[id][wsPapanText],
	wData[id][wsPapanX],
	wData[id][wsPapanY],
	wData[id][wsPapanZ],
	wData[id][wsPapanRotX],
	wData[id][wsPapanRotY],
	wData[id][wsPapanRotZ],
	id);
	strcat((wData[id][wsPapanText] = '\n', wData[id][wsPapanText]), wData[id][wsPapanText], 255);
	return mysql_tquery(g_SQL, dquery);
}

Workshop_Refresh(id)
{
	if(id != -1)
	{
        if(IsValidDynamicPickup(wData[id][wPickup]))
            DestroyDynamicPickup(wData[id][wPickup]);

        if(IsValidDynamic3DTextLabel(wData[id][wLabelPoint]))
            DestroyDynamic3DTextLabel(wData[id][wLabelPoint]);

		new string[212], String[212];
        if(strcmp(wData[id][wOwner], "-"))
		{
			if(IsValidDynamicPickup(wData[id][wPickup]))
				DestroyDynamicPickup(wData[id][wPickup]);

			if(IsValidDynamic3DTextLabel(wData[id][wLabelPoint]))
				DestroyDynamic3DTextLabel(wData[id][wLabelPoint]);

			DestroyDynamicObject(wData[id][wsPapan]);
			format(String, sizeof(String), "%s\n%s", wData[id][wName], ColouredText(wData[id][wsPapanText]));
			FormatText(String);
			wData[id][wsPapan] = CreateDynamicObject(18244, wData[id][wsPapanX], wData[id][wsPapanY], wData[id][wsPapanZ], wData[id][wsPapanRotX], wData[id][wsPapanRotY], wData[id][wsPapanRotZ]);
			SetDynamicObjectMaterialText(wData[id][wsPapan], 0, String, 130, "Arial", 45, 1, 0xFFFFFFFF, 0xFF000000, 1);
		}		
        else
        {
            format(string, sizeof(string), "{00FFFF}[ID: %d]\n{00FF00}This workshop for sell\n{FFFFFF}Addres: {FFFF00}%s\n{FFFFFF}Price: {FFFF00}$%s", id, GetLocation(wData[id][wExtposX], wData[id][wExtposY], wData[id][wExtposZ]), FormatMoney(wData[id][wPrice]));
            wData[id][wPickup] = CreateDynamicPickup(1239, 23, wData[id][wExtposX], wData[id][wExtposY], wData[id][wExtposZ]+0.2, 0, 0, _, 8.0);
			wData[id][wLabelPoint] = CreateDynamic3DTextLabel(string, COLOR_ARWIN, wData[id][wExtposX], wData[id][wExtposY], wData[id][wExtposZ]+0.5, 2.5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0, 0);
			DestroyDynamicObject(wData[id][wsPapan]);
			wData[id][wsPapan] = CreateDynamicObject(18244, wData[id][wsPapanX], wData[id][wsPapanY], wData[id][wsPapanZ], wData[id][wsPapanRotX], wData[id][wsPapanRotY], wData[id][wsPapanRotZ]);
			SetDynamicObjectMaterialText(wData[id][wsPapan], 0, string, 130, "Arial", 45, 1, 0xFFFFFFFF, 0xFF000000, 1);
		}
	}
}

function OnWorkshopCreated(id)
{
	Workshop_Save(id);
	Workshop_Refresh(id);
	return 1;
}

function LoadWorkshops()
{
    new rows = cache_num_rows();
 	if(rows)
  	{
   		new wid, name[50], kontol[50], owner[MAX_PLAYER_NAME];
		for(new i; i < rows; i++)
		{
  			cache_get_value_name_int(i, "ID", wid);
	    	cache_get_value_name(i, "name", name);
			format(wData[wid][wName], 50, name);
		    cache_get_value_name(i, "owner", owner);
			format(wData[wid][wOwner], MAX_PLAYER_NAME, owner);
			cache_get_value_name_int(i, "price", wData[wid][wPrice]);
		    cache_get_value_name_float(i, "extposx", wData[wid][wExtposX]);
		    cache_get_value_name_float(i, "extposy", wData[wid][wExtposY]);
		    cache_get_value_name_float(i, "extposz", wData[wid][wExtposZ]);
			cache_get_value_name_float(i, "safex", wData[wid][wSafeposX]);
			cache_get_value_name_float(i, "safey", wData[wid][wSafeposY]);
			cache_get_value_name_float(i, "safez", wData[wid][wSafeposZ]);
			cache_get_value_name_int(i, "money", wData[wid][wMoney]);
			cache_get_value_name_int(i, "component", wData[wid][wComponent]);	
			cache_get_value_name_int(i, "papanmt", wData[wid][wsPapanMT]);	
			cache_get_value_name(i, "text", kontol);
			format(wData[wid][wsPapanText], 500, kontol);
		    cache_get_value_name_float(i, "posmtx", wData[wid][wsPapanX]);
		    cache_get_value_name_float(i, "posmty", wData[wid][wsPapanY]);
		    cache_get_value_name_float(i, "posmtz", wData[wid][wsPapanZ]);
			cache_get_value_name_float(i, "posmtrotx", wData[wid][wsPapanRotX]);
			cache_get_value_name_float(i, "posmtroty", wData[wid][wsPapanRotY]);
			cache_get_value_name_float(i, "posmtrotz", wData[wid][wsPapanRotZ]);

			Iter_Add(WORKSHOPS, wid);
			Workshop_Refresh(wid);
	    }
	    printf("*** [Database: Loaded] workshop data (%d count).", rows);
	}
}

CMD:wcreate(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	new wid = Iter_Free(WORKSHOPS);
	if(wid == -1) return Error(playerid, "You cant create more workshop slot empty!");
	new name, query[128];
	if(sscanf(params, "d", name)) return Usage(playerid, "/wcreate [price]");

	format(wData[wid][wName], 50, "-");
	format(wData[wid][wOwner], 50, "-");
	wData[wid][wPrice] = name;
	GetPlayerPos(playerid, wData[wid][wExtposX], wData[wid][wExtposY], wData[wid][wExtposZ]);
	wData[wid][wExtposX] = wData[wid][wExtposX];
	wData[wid][wExtposY] = wData[wid][wExtposY];
	wData[wid][wExtposZ] = wData[wid][wExtposZ];
	GetPlayerPos(playerid, wData[wid][wsPapanX], wData[wid][wsPapanY], wData[wid][wsPapanZ]);

	wData[wid][wMoney] = 0;
	wData[wid][wComponent] = 0;
	wData[wid][wSafeposX] = 0;
	wData[wid][wSafeposY] = 0;
	wData[wid][wSafeposZ] = 0;
	wData[wid][wsPapanMT] = 1;
	wData[wid][wsPapanRotX] = 0;
	wData[wid][wsPapanRotY] = 0;
	wData[wid][wsPapanRotZ] = 0;
	DestroyDynamicObject(wData[wid][wsPapan]);
	wData[wid][wsPapan] = CreateDynamicObject(18244, wData[wid][wsPapanX], wData[wid][wsPapanY], wData[wid][wsPapanZ], wData[wid][wsPapanRotX], wData[wid][wsPapanRotY], wData[wid][wsPapanRotZ]);
	SetDynamicObjectMaterialText(wData[wid][wsPapan], 0, "none", 130, "Arial", 45, 0, 0xFFFFFFFF, 0xFF000000, 1);

	SendStaffMessage(COLOR_RED, "AdmCmd: %s has been create Workshop ID: %d dengan harga $%d", pData[playerid][pAdminname], wid, name);

	Iter_Add(WORKSHOPS, wid);
	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO workshops SET ID=%d, name='%s', owner='%s', price='%d'", wid, wData[wid][wName], wData[wid][wOwner], name);
	mysql_tquery(g_SQL, query, "OnWorkshopCreated", "i", wid);
	return 1;
}

CMD:wdelete(playerid, params[])
{
 	if(pData[playerid][pAdmin] < 4)
		return PermissionError(playerid);

    new wid, query[128];
	if(sscanf(params, "i", wid)) return Usage(playerid, "/wdelete [wid]");
	if(!Iter_Contains(WORKSHOPS, wid)) return Error(playerid, "The you specified ID of doesn't exist.");

    format(wData[wid][wName], 50, "None");
	format(wData[wid][wOwner], 50, "None");
	wData[wid][wExtposX] = 0;
	wData[wid][wExtposY] = 0;
	wData[wid][wExtposZ] = 0;
	
	wData[wid][wMoney] = 0;
	wData[wid][wComponent] = 0;
	wData[wid][wSafeposX] = 0;
	wData[wid][wSafeposY] = 0;
	wData[wid][wSafeposZ] = 0;
	wData[wid][wsPapanMT] = 0;
	wData[wid][wsPapanX] = 0;
	wData[wid][wsPapanY] = 0;
	wData[wid][wsPapanZ] = 0;
	wData[wid][wsPapanRotX] = 0;
	wData[wid][wsPapanRotY] = 0;
	wData[wid][wsPapanRotZ] = 0;
	DestroyDynamicObject(wData[wid][wsPapan]);

	Iter_Remove(WORKSHOPS, wid);

	mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET workshop=-1,workshoprank=0 WHERE workshop=%d", wid);
	mysql_tquery(g_SQL, query);

	foreach(new ii : Player)
	{
 		if(pData[ii][pWorkshop] == wid)
   		{
			pData[ii][pWorkshop]= -1;
			pData[ii][pWorkshopRank] = 0;
		}
	}
	mysql_format(g_SQL, query, sizeof(query), "DELETE FROM workshops WHERE ID=%d", wid);
	mysql_tquery(g_SQL, query);
    SendStaffMessage(COLOR_RED, "AdmCmd: %s telah menghapus workshop ID: %d.", pData[playerid][pAdminname], wid);
	return 1;
}


CMD:wedit(playerid, params[])
{
    static
        wid,
        type[24],
        string[128];

    if(pData[playerid][pAdmin] < 4)
        return PermissionError(playerid);

    if(sscanf(params, "ds[24]S()[128]", wid, type, string))
    {
        Usage(playerid, "/wedit [id] [name]");
        SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} location, name, money, component, pospapan");
        return 1;
    }
    if((wid < 0 || wid >= MAX_WORKSHOP))
        return Error(playerid, "You have specified an invalid ID.");
	if(!Iter_Contains(WORKSHOPS, wid)) return Error(playerid, "The you specified ID of doesn't exist.");

    if(!strcmp(type, "location", true))
    {
		GetPlayerPos(playerid, wData[wid][wExtposX], wData[wid][wExtposY], wData[wid][wExtposZ]);

        Workshop_Save(wid);
        Workshop_Refresh(wid);
        SendStaffMessage(COLOR_RED, "AdmCmd: %s has adjusted the location of entrance ID: %d.", pData[playerid][pAdminname], wid);
    }
    else if(!strcmp(type, "name", true))
    {
        new name[50];

        if(sscanf(string, "s[50]", name))
            return Usage(playerid, "/wedit [id] [name] [wname]");

        format(wData[wid][wName], 50, name);
		Workshop_Save(wid);

        SendStaffMessage(COLOR_LRED, "AdmCmd: %s has changed the workshop name ID: %d to: %s.", pData[playerid][pAdminname], wid, name);
    }
    else if(!strcmp(type, "money", true))
    {
        new money;

        if(sscanf(string, "d", money))
            return Usage(playerid, "/wedit [id] [money] [ammount]");

        wData[wid][wMoney] = money;

        Workshop_Save(wid);

		SendStaffMessage(COLOR_LRED, "AdmCmd: %s has changed the workshop money ID: %d to $%s.", pData[playerid][pAdminname], wid, FormatMoney(money));
    }
	else if(!strcmp(type, "component", true))
    {
        new comp;

        if(sscanf(string, "d", comp))
            return Usage(playerid, "/wedit [id] [component] [ammount]");

        wData[wid][wComponent] = comp;

        Workshop_Save(wid);
        
		SendStaffMessage(COLOR_LRED, "AdmCmd: %s has changed the workshop component ID: %d to %s.", pData[playerid][pAdminname], wid, comp);
    }
    else if(!strcmp(type, "pospapan", true))
    {
		if(sscanf(params, "s[32]i", params)) return SendClientMessage(playerid, COLOR_WHITE, "KEGUNAAN: /wedit [id] [pospapan]");
		wsEdit[playerid] = 1;
		wsEditID[playerid] = wid;
		GetDynamicObjectPos(wData[wid][wsPapan], wsPos[playerid][0], wsPos[playerid][1], wsPos[playerid][2]);
		GetDynamicObjectRot(wData[wid][wsPapan], wsRot[playerid][0], wsRot[playerid][1], wsRot[playerid][2]);
		EditDynamicObject(playerid, wData[wid][wsPapan]);
		format(string, sizeof(string), " Anda sekarang mengedit Posisi Papan WorkShop ID %d.", wid);
		SendClientMessage(playerid, COLOR_WHITE, string);
    }
    return 1;
}

CMD:winvite(playerid, params[])
{
	if(pData[playerid][pWorkshop] == -1)
		return Error(playerid, "You are not in workshop!");

	if(pData[playerid][pWorkshopRank] < 5)
		return Error(playerid, "Only workshop owners can use this access!");

	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/winvite [playerid/PartOfName]");

	if(!IsPlayerConnected(otherid))
		return Error(playerid, "Invalid ID.");

	if(otherid == playerid)
		return Error(playerid, "Invalid ID.");

	if(!NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "You must be near this player.");

	if(pData[otherid][pWorkshop] != -1)
		return Error(playerid, "Player tersebut sudah bergabung di workshop lain!");

	if(pData[otherid][pFaction] != 0)
		return Error(playerid, "Player tersebut sudah bergabung faction!");

	new count = 0, limit = 3;
	foreach(new ii : Player)
	{
		if(pData[ii][pWorkshop] == pData[playerid][pWorkshop])
			count++;
	}
	if(count >= limit)
	{
		Error(playerid, "Max Anggota Workshop hanya 4!");
		return 1;
	}
	pData[otherid][pWorkInvite] = pData[playerid][pWorkshop];
	pData[otherid][pWorkOffer] = playerid;
	Servers(playerid, "Anda telah menginvite %s untuk menjadi anggota workshop.", pData[otherid][pName]);
	Servers(otherid, "%s telah menginvite anda untuk menjadi anggota workshop. Type: /accept workshop", pData[playerid][pName]);
	return 1;
}


CMD:wsafe(playerid)
{
	if(pData[playerid][pWorkshop] == -1)
		return Error(playerid, "Anda bukan anggota workshop");

	new wid = pData[playerid][pWorkshop];
	if(IsPlayerInRangeOfPoint(playerid, 5.0, wData[wid][wExtposX], wData[wid][wExtposY], wData[wid][wExtposZ]))
    {
     	ShowPlayerDialog(playerid, WORKSHOP_SAFE, DIALOG_STYLE_LIST, "Workshop SAFE", "Edit Board Text\nChange Name Workshop\nComponent\nMoney", "Select", "Cancel");
    }
 	else
   	{
     	Error(playerid, "You aren't in range in area workshop safe.");
    }
	return 1;
}

CMD:wuninvite(playerid, params[])
{
	if(pData[playerid][pWorkshop] == -1)
		return Error(playerid, "You are not in workshop!");

	if(pData[playerid][pWorkshopRank] < 5)
		return Error(playerid, "Only workshop owners can use this access!");

	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/wuninvite [playerid/PartOfName]");

	if(!IsPlayerConnected(otherid))
		return Error(playerid, "Invalid ID.");

	if(otherid == playerid)
		return Error(playerid, "Invalid ID.");

	if(pData[otherid][pWorkshopRank] > pData[playerid][pWorkshopRank])
		return Error(playerid, "You cant kick him.");

	pData[otherid][pWorkshopRank] = 0;
	pData[otherid][pWorkshop] = -1;
	Servers(playerid, "Anda telah mengeluarkan %s dari anggota workshop.", pData[otherid][pName]);
	Servers(otherid, "%s telah mengeluarkan anda dari anggota workshop.", pData[playerid][pName]);
	return 1;
}

//alias:winfo("wStat", "wStats")
CMD:winfo(playerid, params[])
{
	if(pData[playerid][pWorkshop] == -1)
        return Error(playerid, "You must in workshop member to use this command!");

	ShowPlayerDialog(playerid, WORKSHOP_INFO, DIALOG_STYLE_LIST, "Workshop Info", "Workshop Info\nWorkshop Online\nWorkshop Member", "Select", "Cancel");
	return 1;
}

function ShowWorkshopInfo(playerid)
{
	new rows = cache_num_rows();
 	if(rows)
  	{
 		new wname[50],
 			wowner[50],
			wcomponent,
			wmoney,
			string[512];

		cache_get_value_index(0, 0, wname);
		cache_get_value_index(0, 1, wowner);
		cache_get_value_index_int(0, 2, wcomponent);
		cache_get_value_index_int(0, 3, wmoney);

		format(string, sizeof(string), "Workshop ID: %d\nWorkshop Name: %s\nWorkshop owner: %s\nWorkshop Component: %d\nWorkshop Money: $%s",
		pData[playerid][pWorkshop], wname, wowner, wcomponent, FormatMoney(wmoney));

		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Workshop Info", string, "Okay", "");
	}
}

function ShowWorkshopMember(playerid)
{
	new rows = cache_num_rows(), username[50], wrank, query[1048];
 	if(rows)
  	{
		for(new i = 0; i != rows; i++)
		{
			cache_get_value_index(i, 0, username);

			format(query, sizeof(query), "%s"WHITE_E"%d. %s ", query, (i+1), username);

			cache_get_value_index_int(i, 1, wrank);
			if(wrank == 1)
			{
				strcat(query, "{00FFFF}Mechanic");
			}
			else if(wrank == 6)
			{
				strcat(query, "{00FFFF}Owner Mechanic");
			}
			else
			{
				strcat(query, "{00FFFF}None(0)");
			}
			strcat(query, "\n{FFFFFF}");
		}
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Workshop Member", query, "Okay", "");
	}
}

CMD:sellworkshop(playerid, params[])
{
	new wid = pData[playerid][pWorkshop];
	if(pData[playerid][pWorkshop] == -1)
        return Error(playerid, "You must in workshop member to use this command!");
	if(pData[playerid][pWorkshopRank] < 6)
		return Error(playerid, "You must workshop owner!");
	new string[212];
	new pay;
	pay = wData[wid][wPrice] / 80;
	format(string, sizeof(string), ""WHITE_E"Workshop Name: "YELLOW_E"%s\n"WHITE_E"Workshop Price: "GREEN_E"%s\nAnda Yakin ingin menjual Workshop", wData[wid][wName], FormatMoney(pay));
	ShowPlayerDialog(playerid, DIALOG_WORKSHOPSELL, DIALOG_STYLE_MSGBOX, "Workshop", string, "Okay", "Cancel");
	return 1;	
}

CMD:giveworkshop(playerid, params[])
{
	new otherid;
	new wid = pData[playerid][pWorkshop];
	if(pData[playerid][pWorkshop] == -1)
        return Error(playerid, "You must in workshop member to use this command!");
	if(pData[playerid][pWorkshopRank] < 6)
		return Error(playerid, "You must workshop owner!");
	if(sscanf(params, "d", otherid)) return Usage(playerid, "/giveworkshop [playerid/name]");
	
	if(!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 4.0))
        return Error(playerid, "The specified player is disconnected or not near you.");
	if(pData[otherid][pWorkshop] > 0) return Error(playerid, "Player Tersebut sudah bergabung/memiliki workshop"); 
	
	GetPlayerName(otherid, wData[wid][wOwner], MAX_PLAYER_NAME);
	SendClientMessageEx(playerid, COLOR_ARWIN, "WORKSHOP: "WHITE_E"Anda berhasil memberika workshop kepada player "YELLOW_E"%s", pData[otherid][pName]);
	SendClientMessageEx(otherid, COLOR_ARWIN, "WORKSHOP: "YELLOW_E"%s "WHITE_E"berhasil memberikan workshop kepada anda", pData[playerid][pName]);
	Workshop_Refresh(wid);
	Workshop_Save(wid);
	pData[otherid][pWorkshop] = wid;
	pData[otherid][pWorkshopRank] = 6;
	pData[playerid][pWorkshop] = -1;
	pData[playerid][pWorkshopRank] = 0;
	return 1;	
}