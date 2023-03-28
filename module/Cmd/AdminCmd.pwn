CMD:acmds(playerid)
{
	if(pData[playerid][pAdmin] < 1)
		return PermissionError(playerid);

	new line3[2480];
	strcat(line3, ""WHITE_E"Staff Administrator Commands:"LB2_E"\n\
 	/aduty /a /h /asay /togooc /o /goto /sendto /gethere /freeze /unfreeze /revive /spec /slap\n\
 	/caps /peject /astats /ostats /acuff /auncuff /jetpack /getip /aka /akaip /jail /unjail\n\
	/kick /ban /unban /respawnsapd /respawnsags /respawnsamd /respawnsana /respawnjobs /setvw /setint\n\
	/reports /ar /dr /vmodels /vehname /apv /aveh /gotoveh /getveh /respawnveh /respawnrad\n\
	/myactivity /resetactivity");

	strcat(line3, "\n\n"WHITE_E"Administrator Commands:"LB2_E"\n\
 	/sethp /clearreports /afix /setskin /akill /ann /cd /settime /setweather\n\
    /ojail /owarn /setam /gotoco /gotohouse /gotobisnis /gotodoor /gotolocker /gotogs /setcs /unsetcs");

	strcat(line3, "\n\n"WHITE_E"Senior Admin Commands:"LB2_E"\n\
	/oban /reloadweap /resetweap /sethbe /sethealt\n\
 	/createdoor /editdoor");

	strcat(line3, ""WHITE_E"\n\nLead Admin Commands:"LB2_E"\n\
	/setname /setvip /setfaction /setleader /takemoney /takegold /giveweap\n\
	/veh /destroyveh /unverif");

	strcat(line3, "\n\n"WHITE_E"Head Admin Commands:"LB2_E"\n\
	/sethelperlevel /setadminname /setmoney /givemoney /setbankmoney /givebankmoney\n\
	/setmaterial /setcomponent /createpv /destroypv /explode\n\n\
	"WHITE_E"Developer:"LB2_E"\n\
	/setadminlevel /setgold /givegold /setstock /setprice\n\
	/setpassword /createhouse /edithouse /createbisnis /editbisnis\n\
	/createcdos /cedit /createtoll /tedit /wcreate /wedit");

	strcat(line3, "\n"BLUE_E""WHITE_E"- Anti-Cheat is actived.\n\
	"PINK_E"NOTE: Semua log perintah admin disimpan dalam database! | Abuse Commands? Kick And Demote Premanent!.");
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""YELLOW_E"Staff Commands", line3, "OK","");
	return true;
}


CMD:hcmds(playerid)
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] == 0)
		return PermissionError(playerid);

	new line3[2480];
	strcat(line3, ""WHITE_E"Junior Helper Commands:"LB2_E"\n\
 	/aduty /h /asay /o /goto /sendto /gethere /freeze /unfreeze\n\
	/kick /slap /caps /acuff /auncuff /reports /ar /dr");

	strcat(line3, "\n\n"WHITE_E"Senior Helper Commands:"LB2_E"\n\
 	/spec /peject /astats /ostats /jetpack\n\
    /jail /unjail");

	strcat(line3, "\n\n"WHITE_E"Head Helper Commands:"LB2_E"\n\
	/respawnsapd /respawnsags /respawnsamd /respawnsana /respawnjobs\n");

	strcat(line3, "\n"BLUE_E""WHITE_E"- Anti-Cheat is actived.\n\
	"PINK_E"NOTE: Semua log perintah admin disimpan dalam database | Abuse Commands? Kick And Demote Premanent!.");
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""YELLOW_E"Staff Commands", line3, "OK","");
	return true;
}

// CMD:playsong(playerid, params[])
// {
// 	if(pData[playerid][pAdmin] < 1)
// 	if(pData[playerid][pHelper] == 0)
// 		return PermissionError(playerid);
// 	new songname[128], Float:x, Float:y, Float:z;
// 	if (sscanf(params, "s[128]", songname))
// 	{
// 		Usage(playerid, "/playsong <link>");
// 		return 1;
// 	}

// 	GetPlayerPos(playerid, x, y, z);
// 	foreach(new ii : Player)
// 	{
// 		if(IsPlayerInRangeOfPoint(ii, 35.0, x, y, z))
// 		{
// 			PlayAudioStreamForPlayer(ii, songname);
// 			Servers(ii, "/stopsong, /togsong");
// 		}
// 	}
// 	return 1;
// }

CMD:admins(playerid, params[])
{
	new count = 0, line3[512];
	if(pData[playerid][pAdmin] > 0)
	{
		foreach(new i:Player)
		{
			if(pData[i][pAdmin] > 0 || pData[i][pHelper] > 0)
			{
				format(line3, sizeof(line3), "%s\n"WHITE_E"[%s"WHITE_E"] %s(%s) (ID: %i)", line3, GetStaffRank(i), pData[i][pName], pData[i][pAdminname], i);
				count++;
			}
		}
		if(count > 0)
		{
			ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"Staff Online", line3, "Close", "");
		}
		else return ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"Staff Online", "Tidak ada admin online!", "Close", "");
	}
	else
	{
		foreach(new i:Player)
		{
			if(pData[i][pAdmin] > 0 || pData[i][pHelper] > 0)
			{
				if(pData[i][pAdminDuty] == 1)
				{
					format(line3, sizeof(line3), "%s\n"WHITE_E"[%s"WHITE_E"] %s (ID: %i)", line3, GetStaffRank(i), pData[i][pAdminname], i);
					count++;
				}
			}
		}
		if(count > 0)
		{
			ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"Staff Online", line3, "Close", "");
		}
		else return ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"Staff Online", "Tidak ada admin yang onduty!", "Close", "");
	}
	return 1;
}

CMD:adminjail(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] == 0)
			return PermissionError(playerid);

	new count = 0, line3[512];
	foreach(new i:Player)
	{
		if(pData[i][pJail] > 0)
		{
			format(line3, sizeof(line3), "AdmCmd: %s\n"WHITE_E"%s(ID: %d) [Jail Time: %d seconds]", line3, pData[i][pName], i, pData[i][pJailTime]);
			count++;
		}
	}
	if(count > 0)
	{
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"Jail Player", line3, "Close", "");
	}
	else
	{
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"Jail Player", "Tidak ada player yang di jail!", "Close", "");
	}
	return 1;
}

//---------------------------[ Admin Level 1 ]--------------------
CMD:aduty(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] == 0)
			return PermissionError(playerid);

	if(!strcmp(pData[playerid][pAdminname], "None"))
		return Error(playerid, "Anda harus set nama admin dengan owner!");

	GetPlayerHealth(playerid, HealthDuty[playerid]);
	if(!pData[playerid][pAdminDuty])
    {
		if(pData[playerid][pAdmin] > 0)
		{
			SetPlayerColor(playerid, 0xFF000000);
			pData[playerid][pAdminDuty] = 1;
			SetPlayerName(playerid, pData[playerid][pAdminname]);
			SetPlayerHealthEx(playerid, 100);
			SendStaffMessage(COLOR_RED, "AdmCmd: %s telah on duty admin.", pData[playerid][pName]);
		}
		else
		{
			SetPlayerColor(playerid, COLOR_GREEN);
			pData[playerid][pAdminDuty] = 1;
			SetPlayerName(playerid, pData[playerid][pAdminname]);
			SetPlayerHealthEx(playerid, 100);
			SendStaffMessage(COLOR_RED, "AdmCmd: %s telah on helper duty.", pData[playerid][pName]);
		}
    }
    else
    {
        if(pData[playerid][pFaction] != -1 && pData[playerid][pOnDuty])
            SetFactionColor(playerid);
        else
            SetPlayerColor(playerid, COLOR_WHITE);

        SetPlayerName(playerid, pData[playerid][pName]);
        pData[playerid][pAdminDuty] = 0;
		SetPlayerHealthEx(playerid, HealthDuty[playerid]);
        SendStaffMessage(COLOR_RED, "AdmCmd: %s telah off admin duty.", pData[playerid][pName]);
    }
	return 1;
}

CMD:gotobus(playerid, params[])
{
	SetPlayerPos(playerid, 2022.0273, 2235.2402, 2103.9536);
  	SetPlayerFacingAngle(playerid, 0);
    SetCameraBehindPlayer(playerid);
    SetPlayerInterior(playerid, 1);

	return 1;
}

CMD:asay(playerid, params[])
{
    new text[225];

    if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] == 0)
			return PermissionError(playerid);

    if(sscanf(params,"s[225]",text))
        return Usage(playerid, "/asay [text]");

    SendClientMessageToAllEx(TOMATO,"AdmCmd: (%s) "YELLOW_E"%s: "LG_E"%s", GetStaffRank(playerid), pData[playerid][pAdminname], ColouredText(text));
    return 1;
}

CMD:setlevel(playerid, params[])
{
    if(pData[playerid][pAdmin] < 5) return PermissionError(playerid);
    {
        new targetid, level;
		if(sscanf(params, "ui", targetid, level)) return Usage(playerid, "/setlevel [playerid/PartOfName] [Level]");
		{
	    	pData[targetid][pLevel] = level;
	    	Servers(targetid, "AdmCmd:  %s telah meng-set level kamu menjadi %d", pData[playerid][pAdminname], level);
	    	Servers(playerid, "%s telah kamu set level nya menjadi %d", pData[targetid][pName], level);
		}
	}
	return 1;
}

CMD:h(playerid, params[])
{
    if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] == 0)
			return PermissionError(playerid);

	if(isnull(params))
	{
	    Usage(playerid, "/h <text>");
	    return true;
	}

    // Decide about multi-line msgs
	new i = -1;
	new line[512];
	if(strlen(params) > 70)
	{
		i = strfind(params, " ", false, 60);
		if(i > 80 || i == -1) i = 70;

		// store the second line text
		line = " ";
		strcat(line, params[i]);

		// delete the rest from msg
		params[i] = EOS;
	}
	new mstr[512];
	format(mstr, sizeof(mstr), "(( %s(%i): %s ))", GetStaffRank(playerid), pData[playerid][pAdminname], playerid, params);
	foreach(new ii : Player)
	{
		if(pData[ii][pAdmin] > 0 || pData[ii][pHelper] == 1)
		{
			SendClientMessage(ii, COLOR_LB, mstr);
		}
	}
	if(i != -1)
	{
		foreach(new ii : Player)
		{
			if(pData[ii][pAdmin] > 0 || pData[ii][pHelper] == 1)
			{
				SendClientMessage(ii, COLOR_LB, line);
			}
		}
	}
	return 1;
}

CMD:a(playerid, params[])
{
    if(pData[playerid][pAdmin] < 1)
			return PermissionError(playerid);

	if(isnull(params))
	{
	    Usage(playerid, "/a <text>");
	    return true;
	}

    // Decide about multi-line msgs
	new i = -1;
	new line[512];
	if(strlen(params) > 70)
	{
		i = strfind(params, " ", false, 60);
		if(i > 80 || i == -1) i = 70;

		// store the second line text
		line = " ";
		strcat(line, params[i]);

		// delete the rest from msg
		params[i] = EOS;
	}
	new mstr[512];
	format(mstr, sizeof(mstr), "(( %s(%i): %s ))", pData[playerid][pAdminname], playerid, params);
	foreach(new ii : Player)
	{
		if(pData[ii][pAdmin] > 0)
		{
			SendClientMessage(ii, COLOR_LB, mstr);
		}
	}
	if(i != -1)
	{
		foreach(new ii : Player)
		{
			if(pData[ii][pAdmin] > 0)
			{
				SendClientMessage(ii, COLOR_LB, line);
			}
		}
	}
	return true;
}

CMD:setcs(playerid, params[])
{
    if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);
 	new otherid;
 	
 	Servers(otherid, "Your CS has approved by %s.", pData[playerid][pAdminname]);
 	
 	if(sscanf(params, "d", otherid)) return Usage(playerid, "/setcs [playerid]");

 	if(pData[otherid][pCS] != 0) return Error(playerid, "Character story anda sudah di approve!");
 	SendStaffMessage(COLOR_RED, "AdmCmd: %s has approved Character Story %s (ID: %d).", pData[playerid][pAdminname], pData[otherid][pName], otherid);
 	SendClientMessageEx(otherid, COLOR_RED, "Your CS has approved by %s", pData[playerid][pAdminname]);
 	
 	pData[otherid][pCS] = 1;
 	return 1;
}

CMD:unsetcs(playerid, params[])
{
    if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);
 	new otherid;

 	if(sscanf(params, "d", otherid)) return Usage(playerid, "/unsetcs [playerid]");

 	if(pData[otherid][pCS] != 1) return Error(playerid, "Character story anda sudah di approve!");
 	SendStaffMessage(COLOR_RED, "AdmCmd: %s has un approved CS %s (ID: %d).", pData[playerid][pAdminname], pData[otherid][pName], otherid);

 	pData[otherid][pCS] = 0;
 	return 1;
}

CMD:unverif(playerid, params[])
{
    if(pData[playerid][pAdmin] < 1)
        return PermissionError(playerid);
    new name[24], PlayerName[24];
 	if(sscanf(params, "s[24]", name))
	{
	    Usage(playerid, "/unverif <player name>");
 		return 1;
 	}

 	foreach(new ii : Player)
	{
		GetPlayerName(ii, PlayerName, MAX_PLAYER_NAME);

		if(!strcmp(PlayerName, name, true))
		{
			Error(playerid, "Player is online, you can use /unverif on them.");
	  		return 1;
	  	}
	}
    new query[512];
	mysql_format(g_SQL, query, sizeof(query), "SELECT reg_id FROM players WHERE username='%e'", name);
	mysql_tquery(g_SQL, query, "Unverifplayer", "is", playerid, name);
 	return true;
}

CMD:osetcs(playerid, params[])
{
    if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);
    new name[24], PlayerName[24];
 	if(sscanf(params, "s[24]", name))
	{
	    Usage(playerid, "/osetcs <player name>");
 		return 1;
 	}

 	foreach(new ii : Player)
	{
		GetPlayerName(ii, PlayerName, MAX_PLAYER_NAME);

		if(!strcmp(PlayerName, name, true))
		{
			Error(playerid, "Player is online, you can use /setcs on them.");
	  		return 1;
	  	}
	}
    new query[512];
	mysql_format(g_SQL, query, sizeof(query), "SELECT reg_id FROM players WHERE username='%e'", name);
	mysql_tquery(g_SQL, query, "SetCSPlayer", "is", playerid, name);
 	return true;
}

CMD:ounsetcs(playerid, params[])
{
    if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);
    new name[24], PlayerName[24];
 	if(sscanf(params, "s[24]", name))
	{
	    Usage(playerid, "/ounsetcs <player name>");
 		return 1;
 	}

 	foreach(new ii : Player)
	{
		GetPlayerName(ii, PlayerName, MAX_PLAYER_NAME);

		if(!strcmp(PlayerName, name, true))
		{
			Error(playerid, "Player is online, you can use /setcs on them.");
	  		return 1;
	  	}
	}
    new query[512];
	mysql_format(g_SQL, query, sizeof(query), "SELECT reg_id FROM players WHERE username='%e'", name);
	mysql_tquery(g_SQL, query, "UnsetCSPlayer", "is", playerid, name);
 	return true;
}

CMD:togooc(playerid, params[])
{
    if(pData[playerid][pAdmin] < 1)
        return PermissionError(playerid);

    if(TogOOC == 0)
    {
        SendClientMessageToAllEx(TOMATO, "AdmCmd: [%s] mematikan chat global ooc.", pData[playerid][pAdminname]);
        TogOOC = 1;
    }
    else
    {
        SendClientMessageToAllEx(TOMATO, "AdmCmd: [%s] menghidupkan chat ooc global (DON'T SPAM).", pData[playerid][pAdminname]);
        TogOOC = 0;
    }
    return 1;
}

CMD:o(playerid, params[])
{
    if(TogOOC == 1 && pData[playerid][pAdmin] < 1 && pData[playerid][pHelper] < 1)
            return Error(playerid, "Administrator telah menonaktifkan chat OOC global.");

    if(isnull(params))
        return Usage(playerid, "/o [global OOC]");

    /*if(pData[playerid][pDisableOOC])
        return Error(playerid, "You must enable OOC chat first.");*/

    if(strlen(params) < 90)
    {
        foreach (new i : Player) if(pData[i][IsLoggedIn] == true && pData[i][pSpawned] == 1)
        {
            if(pData[playerid][pAdmin] > 1)
			{
                SendClientMessageEx(i, COLOR_WHITE, ""RED_E"%s{FFFFFF}: %s {FFFFFF}", pData[playerid][pAdminname], ColouredText(params));
			}
			else if(pData[playerid][pHelper] > 0 && pData[playerid][pAdmin] == 0)
			{
				SendClientMessageEx(i, COLOR_WHITE, ""RED_E"%s{FFFFFF}: %s {FFFFFF}", pData[playerid][pAdminname], ColouredText(params));
			}
            else
            {
                SendClientMessageEx(i, COLOR_WHITE, "{33FFCC}Player %s{FFFFFF} [%d]: %s ", pData[playerid][pName], playerid, params);
            }
        }
    }
    else
        return Error(playerid, "Teks tidak boleh panjang, karakter maksimum adalah 90");

    return 1;
}

CMD:id(playerid, params[])
{
	new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/id [playerid/PartOfName]");

	if(!IsPlayerConnected(otherid))
		return Error(playerid, "No player online or name is not found!");

	new hour, minutes;
	GetPlayerTime(otherid, hour, minutes);
    new
        string[24];
    GetPlayerVersion(otherid, string, sizeof(string));
	SendClientMessageEx(playerid, COLOR_ARWIN, "[ID:%d] "WHITE_E"%s (level %d), Ping: %d, Online time: %d:%d, Client: %s, Packets lost: %.2f", otherid, pData[otherid][pName], pData[otherid][pLevel], GetPlayerPing(otherid), hour, minutes, string, NetStats_PacketLossPercent(otherid));
	return 1;
}

CMD:goto(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);

	new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/goto [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	SendPlayerToPlayer(playerid, otherid);
	SendClientMessageEx(playerid, COLOR_GRAD1, "{B0C4DE}TELEPORT: {FFFFFF}You have been teleported!");
	SendClientMessageEx(otherid, COLOR_GRAD1, "{B0C4DE}TELEPORT: {FFFFFF}Admin {00FFFF}%s {FFFFFF}has teleported to you", pData[playerid][pAdminname]);
	return 1;
}

CMD:sendto(playerid, params[])
{
    static
        type[24],
		otherid;

    if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);

    if(sscanf(params, "us[32]", otherid, type))
    {
        Usage(playerid, "/send [player] [name]");
        Info(playerid, "[NAMES]:{FFFFFF} ls, lv, sf");
        return 1;
    }

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	if(!strcmp(type,"ls"))
	{
        if(GetPlayerState(otherid) == PLAYER_STATE_DRIVER)
		{
            SetVehiclePos(GetPlayerVehicleID(otherid),1482.0356,-1724.5726,13.5469);
        }
        else
		{
            SetPlayerPosition(otherid,1482.0356,-1724.5726,13.5469,750);
        }
        SetPlayerFacingAngle(otherid,179.4088);
        SetPlayerInterior(otherid, 0);
        SetPlayerVirtualWorld(otherid, 0);
		Servers(playerid, "AdmCmd: Player %s telah berhasil di teleport", pData[otherid][pName]);
		Servers(otherid, "Admin %s telah mengirim anda ke teleport spawn", pData[playerid][pAdminname]);
		pData[otherid][pInDoor] = -1;
		pData[otherid][pInHouse] = -1;
		pData[otherid][pInBiz] = -1;
    }
    else if(!strcmp(type,"sf"))
	{
        if(GetPlayerState(otherid) == PLAYER_STATE_DRIVER)
		{
            SetVehiclePos(GetPlayerVehicleID(otherid),-1425.8307,-292.4445,14.1484);
        }
        else
		{
            SetPlayerPosition(otherid,-1425.8307,-292.4445,14.1484,750);
        }
        SetPlayerFacingAngle(otherid,179.4088);
        SetPlayerInterior(otherid, 0);
        SetPlayerVirtualWorld(otherid, 0);
		Servers(playerid, "AdmCmd: Player %s telah berhasil di teleport", pData[otherid][pName]);
		Servers(otherid, "Admin %s telah mengirim anda ke teleport spawn", pData[playerid][pAdminname]);
		pData[otherid][pInDoor] = -1;
		pData[otherid][pInHouse] = -1;
		pData[otherid][pInBiz] = -1;
    }
    else if(!strcmp(type,"lv"))
	{
        if(GetPlayerState(otherid) == PLAYER_STATE_DRIVER)
		{
            SetVehiclePos(GetPlayerVehicleID(otherid),1686.0118,1448.9471,10.7695);
        }
        else
		{
            SetPlayerPosition(otherid,1686.0118,1448.9471,10.7695,750);
        }
        SetPlayerFacingAngle(otherid,179.4088);
        SetPlayerInterior(otherid, 0);
        SetPlayerVirtualWorld(otherid, 0);
		Servers(playerid, "AdmCmd: Player %s telah berhasil di teleport", pData[otherid][pName]);
		Servers(otherid, "Admin %s telah mengirim anda ke teleport spawn", pData[playerid][pAdminname]);
		pData[otherid][pInDoor] = -1;
		pData[otherid][pInHouse] = -1;
		pData[otherid][pInBiz] = -1;
    }
    return 1;
}

CMD:gethere(playerid, params[])
{
    new otherid;

	if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);

    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/gethere [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "The specified user(s) are not connected.");

	if(pData[playerid][pSpawned] == 0 || pData[otherid][pSpawned] == 0)
		return Error(playerid, "Player/Target sedang tidak spawn!");

	if(pData[playerid][pJail] > 0 || pData[otherid][pJail] > 0)
		return Error(playerid, "Player/Target sedang di jail");

	if(pData[playerid][pArrest] > 0 || pData[otherid][pArrest] > 0)
		return Error(playerid, "Player/Target sedang di arrest");

    SendPlayerToPlayer(otherid, playerid);

    Servers(playerid, "You have get %s.", pData[otherid][pName]);
	SendClientMessageEx(otherid, COLOR_ARWIN, "{B0C4DE}TELEPORT: {FFFFFF}You have been teleported!");
    return 1;
}

CMD:freeze(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);

	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/freeze [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

    pData[playerid][pFreeze] = 1;

    TogglePlayerControllable(otherid, 0);
    Servers(playerid, "Anda telah membuat pemain %s Freeze.", ReturnName(otherid));
	Servers(otherid, "Anda telah di buat freeze oleh admin %s.", pData[playerid][pAdminname]);
    return 1;
}

CMD:unfreeze(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);

	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/unfreeze [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

    pData[playerid][pFreeze] = 0;

    TogglePlayerControllable(otherid, 1);
    Servers(playerid, "You have unfrozen %s's movements.", ReturnName(otherid));
	Servers(otherid, "You have been unfrozen movements by admin %s.", pData[playerid][pAdminname]);
    return 1;
}

CMD:revive(playerid, params[])
{

    if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 2)
     		return PermissionError(playerid);

	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/revive [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

    SetPlayerHealthEx(otherid, 100.0);
    pData[otherid][pInjured] = 0;
	pData[otherid][pHospital] = 0;
	pData[otherid][pSick] = 0;
    ClearAnimations(otherid);
    ClearAnimations(otherid);
    TogglePlayerControllable(otherid, 1);

	SendClientMessageEx(playerid, COLOR_WHITE, "{33CCFF}HEAL: {33CCFF}You have forced %s to death.", ReturnName(otherid));
	SendClientMessageEx(otherid, COLOR_WHITE, "{33CCFF}HEAL: {33CCFF}You have ben healed By: "RED_E"%s", pData[playerid][pAdminname]);
    return 1;
}

CMD:spec(playerid, params[])
{
    if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 2)
			return PermissionError(playerid);

    if(!isnull(params) && !strcmp(params, "off", true))
    {
        if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
            return Error(playerid, "You are not spectating any player.");

		pData[pData[playerid][pSpec]][playerSpectated]--;
        PlayerSpectatePlayer(playerid, INVALID_PLAYER_ID);
        PlayerSpectateVehicle(playerid, INVALID_VEHICLE_ID);

        SetSpawnInfo(playerid, 0, pData[playerid][pSkin], pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ], pData[playerid][pPosA], 0, 0, 0, 0, 0, 0);
        TogglePlayerSpectating(playerid, false);
		pData[playerid][pSpec] = -1;

        return Servers(playerid, "You are no longer in spectator mode.");
    }
	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/spectate [playerid/PartOfName] - Type '/spec off' to stop spectating.");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	if(otherid == playerid)
		return Error(playerid, "You can't spectate yourself bro..");

    if(pData[playerid][pAdmin] < pData[otherid][pAdmin])
        return Error(playerid, "You can't spectate admin higher than you.");

	if(pData[otherid][pSpawned] == 0)
	{
	    Error(playerid, "%s(%i) isn't spawned!", pData[otherid][pName], otherid);
	    return true;
	}

    if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
    {
        GetPlayerPos(playerid, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]);
        GetPlayerFacingAngle(playerid, pData[playerid][pPosA]);

        pData[playerid][pInt] = GetPlayerInterior(playerid);
        pData[playerid][pWorld] = GetPlayerVirtualWorld(playerid);
    }
    SetPlayerInterior(playerid, GetPlayerInterior(otherid));
    SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(otherid));

    TogglePlayerSpectating(playerid, true);

    if(IsPlayerInAnyVehicle(otherid))
	{
		new vID = GetPlayerVehicleID(otherid);
        PlayerSpectateVehicle(playerid, GetPlayerVehicleID(otherid));
		if(GetPlayerState(otherid) == PLAYER_STATE_DRIVER)
	    {
	    	Servers(playerid, "You are now spectating %s(%i) who is driving a %s(%d).", pData[otherid][pName], otherid, GetVehicleModelName(GetVehicleModel(vID)), vID);
		}
		else
		{
		    Servers(playerid, "You are now spectating %s(%i) who is a passenger in %s(%d).", pData[otherid][pName], otherid, GetVehicleModelName(GetVehicleModel(vID)), vID);
		}
	}
    else
	{
        PlayerSpectatePlayer(playerid, otherid);
	}
	pData[otherid][playerSpectated]++;
    SendStaffMessage(COLOR_RED, "AdmCmd: %s now spectating %s (ID: %d).", pData[playerid][pAdminname], pData[otherid][pName], otherid);
    Servers(playerid, "You are now spectating %s (ID: %d).", pData[otherid][pName], otherid);
    pData[playerid][pSpec] = otherid;
    return 1;
}

CMD:setint(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] == 0)
			return PermissionError(playerid);

	new otherid, intid;
	if(sscanf(params, "ui", otherid, intid))
	{
	    Usage(playerid, "/setint <ID> <INT ID>");
	    return true;
	}

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	SendStaffMessage(COLOR_RED, "AdmCmd: %s telah meng-set player %s interior id menjadi %d", pData[playerid][pAdminname], pData[otherid][pName], intid);

	SetPlayerInterior(otherid, intid);
	return 1;
}

CMD:setskillfish(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
			return PermissionError(playerid);

	new otherid, intid;
	if(sscanf(params, "ui", otherid, intid))
	{
	    Usage(playerid, "/setskillfish <id> <skill>");
	    return true;
	}

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	pData[otherid][LevelFishing] = intid;
	return 1;
}

CMD:setfg(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] == 0)
			return PermissionError(playerid);

	new otherid, intid;
	if(sscanf(params, "ui", otherid, intid))
	{
	    Usage(playerid, "/setfg <ID> <FIGHT ID>");
	    SendClientMessageEx(playerid, COLOR_GRAD2, "Available fighting styles: 4, 5, 6, 7, 15, 16.");
	    return true;
	}

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	SendStaffMessage(COLOR_RED, "AdmCmd: %s telah meng-set fight %s", pData[playerid][pAdminname], pData[otherid][pName]);

	SetPlayerFightingStyle(playerid, intid);
	pData[otherid][FightStyle] = intid;
	return 1;
}

CMD:setvw(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] == 0)
			return PermissionError(playerid);

	new otherid, vwid;
	if(sscanf(params, "ui", otherid, vwid))
	{
	    Usage(playerid, "/setvw <ID> <VW ID>");
	    return true;
	}

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	SendStaffMessage(COLOR_RED, "AdmCmd: %s telah meng-set player %s virtual world menjadi %d", pData[playerid][pAdminname], pData[otherid][pName], vwid);

	SetPlayerVirtualWorld(otherid, vwid);
	return 1;
}
CMD:slap(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] == 0)
			return PermissionError(playerid);

	new Float:POS[3], otherid;
	if(sscanf(params, "u", otherid))
	{
	    Usage(playerid, "/slap <ID>");
	    return true;
	}

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	GetPlayerPos(otherid, POS[0], POS[1], POS[2]);
	SetPlayerPos(otherid, POS[0], POS[1], POS[2] + 9.0);
	if(IsPlayerInAnyVehicle(otherid))
	{
		RemovePlayerFromVehicle(otherid);
		//OnPlayerExitVehicle(otherid, GetPlayerVehicleID(otherid));
	}
	SendStaffMessage(COLOR_RED, "AdmCmd: %s telah men-slap player %s", pData[playerid][pAdminname], pData[otherid][pName]);

	PlayerPlaySound(otherid, 1130, 0.0, 0.0, 0.0);
	return 1;
}

CMD:caps(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] == 0)
			return PermissionError(playerid);

	new otherid;
 	if(sscanf(params, "u", otherid))
	{
	    Usage(playerid, "/caps <ID>");
	    Info(playerid, "Function: Will disable caps for the player, type again to enable caps.");
	    return 1;
	}
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	if(!GetPVarType(otherid, "Caps"))
	{
	    // Disable Caps
	    SetPVarInt(otherid, "Caps", 1);
		SendClientMessageToAllEx(TOMATO, "Admcmd: Admin %s telah menon-aktifkan anti caps kepada player %s", pData[playerid][pAdminname], pData[playerid][pName]);
	}
	else
	{
	    // Enable Caps
		DeletePVar(otherid, "Caps");
		SendClientMessageToAllEx(TOMATO, "Admcmd: Admin %s telah meng-aktifkan anti caps kepada player %s", pData[playerid][pAdminname], pData[playerid][pName]);
	}
	return 1;
}

CMD:peject(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 2)
			return PermissionError(playerid);
	new otherid;
	if(sscanf(params, "u", otherid))
	{
	    Usage(playerid, "/peject <ID>");
	    return 1;
	}

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	if(!IsPlayerInAnyVehicle(otherid))
	{
		Error(playerid, "Player tersebut tidak berada dalam kendaraan!");
		return 1;
	}

	new vv = GetVehicleModel(GetPlayerVehicleID(otherid));
	Servers(playerid, "You have successfully ejected %s(%i) from their %s.", pData[otherid][pName], otherid, GetVehicleModelName(vv - 400));
	Servers(otherid, "%s(%i) has ejected you from your %s.", pData[playerid][pName], playerid, GetVehicleModelName(vv));
	RemovePlayerFromVehicle(otherid);
	return 1;
}

CMD:aitems(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 2)
			return PermissionError(playerid);

	new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/aitems [playerid/PartOfName]");

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	if(pData[otherid][IsLoggedIn] == false)
        return Error(playerid, "That player is not logged in yet.");

	DisplayItems(playerid, otherid);
	return 1;
}

CMD:astats(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 2)
			return PermissionError(playerid);
	new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/check [playerid/PartOfName]");

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	if(pData[otherid][IsLoggedIn] == false)
        return Error(playerid, "That player is not logged in yet.");

	DisplayStats(playerid, otherid);
	return 1;
}

CMD:ostats(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 2)
			return PermissionError(playerid);

	new name[24], PlayerName[24];
	if(sscanf(params, "s[24]", name))
	{
	    Usage(playerid, "/ostats <player name>");
 		return 1;
 	}

 	foreach(new ii : Player)
	{
		GetPlayerName(ii, PlayerName, MAX_PLAYER_NAME);

		if(!strcmp(PlayerName, name, true))
		{
			Error(playerid, "Player is online, you can use /stats on them.");
	  		return 1;
	  	}
	}

	// Load User Data
    new cVar[500];
    new cQuery[600];

	strcat(cVar, "email,admin,helper,level,levelup,vip,vip_time,gold,reg_date,last_login,money,bmoney,brek,hours,minutes,seconds,");
	strcat(cVar, "gender,age,faction,family,warn,job,job2,interior,world");

	mysql_format(g_SQL, cQuery, sizeof(cQuery), "SELECT %s FROM players WHERE username='%e' LIMIT 1", cVar, name);
	mysql_tquery(g_SQL, cQuery, "LoadStats", "is", playerid, name);
	return true;
}

CMD:acuff(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);

	new otherid, mstr[128];
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/acuff [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

    //if(otherid == playerid)
        //return Error(playerid, "You cannot handcuff yourself.");

    if(!NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "You must be near this player.");

    if(GetPlayerState(otherid) != PLAYER_STATE_ONFOOT)
        return Error(playerid, "The player must be onfoot before you can cuff them.");

    if(pData[otherid][pCuffed])
        return Error(playerid, "The player is already cuffed at the moment.");

    pData[otherid][pCuffed] = 1;
	SetPlayerSpecialAction(otherid, SPECIAL_ACTION_CUFFED);

    format(mstr, sizeof(mstr), "You've been ~r~cuffed~w~ by %s.", pData[playerid][pName]);
    InfoTD_MSG(otherid, 3500, mstr);

    Servers(playerid, "Player %s telah berhasil di cuffed.", pData[otherid][pName]);
    Servers(otherid, "Admin %s telah mengcuffed anda.", pData[playerid][pName]);
    return 1;
}

CMD:auncuff(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);

	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/auncuff [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

    //if(otherid == playerid)
        //return Error(playerid, "You cannot uncuff yourself.");

    if(!NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "You must be near this player.");

    if(!pData[otherid][pCuffed])
        return Error(playerid, "The player is not cuffed at the moment.");

    static
        string[64];

    pData[otherid][pCuffed] = 0;
    SetPlayerSpecialAction(otherid, SPECIAL_ACTION_NONE);

    format(string, sizeof(string), "You've been ~g~uncuffed~w~ by %s.", pData[playerid][pName]);
    InfoTD_MSG(otherid, 3500, string);
	Servers(playerid, "Player %s telah berhasil uncuffed.", pData[otherid][pName]);
    Servers(otherid, "Admin %s telah uncuffed tangan anda.", pData[playerid][pName]);
    return 1;
}

CMD:jetpack(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] < 2)
     		return PermissionError(playerid);

	new otherid;
    if(sscanf(params, "u", otherid))
    {
        //pData[playerid][pJetpack] = 1;
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
    }
    else
    {
        //pData[playerid][pJetpack] = 1;
        SetPlayerSpecialAction(otherid, SPECIAL_ACTION_USEJETPACK);
        Servers(playerid, "You have spawned a jetpack for %s.", pData[otherid][pName]);
    }
    return 1;
}

CMD:getip(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
     	return PermissionError(playerid);

	new otherid, PlayerIP[16], giveplayer[24];
	if(sscanf(params, "u", otherid))
 	{
  		Usage(playerid, "/getip <ID>");
		return 1;
	}

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	if(pData[otherid][pAdmin] == 5)
 	{
  		Error(playerid, "You can't get the server owners ip!");
  		Servers(otherid, "%s(%i) tried to get your IP!", pData[playerid][pName], playerid);
  		return 1;
    }
	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));
	GetPlayerIp(otherid, PlayerIP, sizeof(PlayerIP));

	Servers(playerid, "%s(%i)'s IP: %s", giveplayer, otherid, PlayerIP);
	return 1;
}

CMD:aka(playerid, params[])
{
    static
        userid[MAX_PLAYER_NAME],
        Cache: ipcheck,
        query[128];

    if(pData[playerid][pAdmin] < 1)
     	return PermissionError(playerid);

    if(sscanf(params, "s[32]", userid))
        return Usage(playerid, "/aka [username]");

    format(query, sizeof(query), "SELECT `ip` FROM `players` WHERE `username`='%s'", userid);
    ipcheck = mysql_query(g_SQL, query);

    new rows = cache_num_rows();

    if(rows)
    {
        new ip[32];
        cache_get_value_name(0, "IP", ip, 32);
        Servers(playerid, "Offline ip check from username/accounts %s: %s", userid, ip);
    }
    else
        Error(playerid, "%s isn't registered.", userid);

    cache_delete(ipcheck);
    return 1;
}
Dialog:ShowOnly(playerid, response, listitem, inputtext[]) {
    playerid = INVALID_PLAYER_ID;
    response = 0;
    listitem = 0;
    inputtext[0] = '\0';
}
CMD:akaip(playerid, params[])
{
    static
        ip[MAX_PLAYER_NAME],
        Cache: ipcheck,
        query[128],
		username[1024],
		str[4096];

    if(pData[playerid][pAdmin] < 1)
     	return PermissionError(playerid);

    if(sscanf(params, "s[32]", ip))
        return Usage(playerid, "/akaip [ip]");

    format(query, sizeof(query), "SELECT `username` FROM `players` WHERE `ip`='%s'", ip);
    ipcheck = mysql_query(g_SQL, query);

    new rows = cache_num_rows();

	if(rows) {
		for(new i=0; i < rows; i++) {
			new cacheString[255];
			cache_get_value_name(i, "username", username, 32);
			format(cacheString, sizeof(cacheString), "%s\n", username);
			strcat(str, cacheString);
		}
	} else {
		Error(playerid, "No username found with this ip %s", ip);
	}

	Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_LIST, "Registered Username", str, "Close", "");
    
	cache_delete(ipcheck);
    return 1;
}

CMD:vmodels(playerid, params[])
{
    new string[500];

    if(pData[playerid][pAdmin] < 1)
     	return PermissionError(playerid);

    for (new i = 0; i < sizeof(g_arrVehicleNames); i ++)
    {
        format(string,sizeof(string), "%s%d - %s\n", string, i+400, g_arrVehicleNames[i]);
    }
    ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_LIST, "Vehicle Models", string, "Close", "");
    return 1;
}

CMD:vehname(playerid, params[]) {

	if(pData[playerid][pAdmin] >= 1)
	{
		SendClientMessageEx(playerid, COLOR_YELLOW, "--------------------------------------------------------------------------------------------------------------------------------");
		SendClientMessageEx(playerid, COLOR_WHITE, "Vehicle Search:");

		new
			string[128];

		if(isnull(params)) return Error(playerid, "No keyword specified.");
		if(!params[2]) return Error(playerid, "Search keyword too short.");

		for(new v; v < sizeof(g_arrVehicleNames); v++)
		{
			if(strfind(g_arrVehicleNames[v], params, true) != -1) {

				if(isnull(string)) format(string, sizeof(string), "%s (ID %d)", g_arrVehicleNames[v], v+400);
				else format(string, sizeof(string), "%s | %s (ID %d)", string, g_arrVehicleNames[v], v+400);
			}
		}

		if(!string[0]) Error(playerid, "No results found.");
		else if(string[127]) Error(playerid, "Too many results found.");
		else SendClientMessageEx(playerid, COLOR_WHITE, string);

		SendClientMessageEx(playerid, COLOR_YELLOW, "--------------------------------------------------------------------------------------------------------------------------------");
	}
	else
	{
		PermissionError(playerid);
	}
	return 1;
}

CMD:owarn(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
	    return PermissionError(playerid);

	new player[24], tmp[50], PlayerName[MAX_PLAYER_NAME];
	if(sscanf(params, "s[24]s[50]", player, tmp))
		return Usage(playerid, "/owarn <name> <reason>");

	if(strlen(tmp) > 50) return Error(playerid, "Reason must be shorter than 50 characters.");

	foreach(new ii : Player)
	{
		GetPlayerName(ii, PlayerName, MAX_PLAYER_NAME);

	    if(strfind(PlayerName, player, true) != -1)
		{
			Error(playerid, "Player is online, you can use /warn on him.");
	  		return 1;
	  	}
	}
	new query[512];
	mysql_format(g_SQL, query, sizeof(query), "SELECT reg_id,warn FROM players WHERE username='%e'", player);
	mysql_tquery(g_SQL, query, "OWarnPlayer", "iss", playerid, player, tmp);
	return 1;
}

CMD:cekmask(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
	    return PermissionError(playerid);

	new player;
	if(sscanf(params, "d", player))
		return Usage(playerid, "/cekmask <maskid>");

	new query[512];
	mysql_format(g_SQL, query, sizeof(query), "SELECT reg_id,username FROM players WHERE maskid='%d'", player);
	mysql_tquery(g_SQL, query, "OfflineMask", "ii", playerid, player);
	return 1;
}

CMD:ojail(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
	    return PermissionError(playerid);

	new player[24], datez, tmp[50], PlayerName[MAX_PLAYER_NAME];
	if(sscanf(params, "s[24]ds[50]", player, datez, tmp))
		return Usage(playerid, "/ojail <name> <time in minutes)> <reason>");

	if(strlen(tmp) > 50) return Error(playerid, "Reason must be shorter than 50 characters.");
	if(datez < 1 || datez > 60)
	{
 		if(pData[playerid][pAdmin] < 5)
   		{
			Error(playerid, "Jail time must remain between 1 and 60 minutes");
  			return 1;
   		}
	}
	foreach(new ii : Player)
	{
		GetPlayerName(ii, PlayerName, MAX_PLAYER_NAME);

	    if(strfind(PlayerName, player, true) != -1)
		{
			Error(playerid, "Player is online, you can use /jail on him.");
	  		return 1;
	  	}
	}
	new query[512];
	mysql_format(g_SQL, query, sizeof(query), "SELECT reg_id FROM players WHERE username='%e'", player);
	mysql_tquery(g_SQL, query, "OJailPlayer", "issi", playerid, player, tmp, datez);
	return 1;
}


CMD:jail(playerid, params[])
{
   	if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] < 2)
     		return PermissionError(playerid);

	new reason[60], timeSec, otherid;
	if(sscanf(params, "uD(15)S(*)[60]", otherid, timeSec, reason))
	{
	    Usage(playerid, "/jail <ID/Name> <time in minutes> <reason>)");
	    return true;
	}

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	if(pData[otherid][pJail] > 0)
	{
	    Servers(playerid, "%s(%i) is already jailed (gets out in %d minutes)", pData[otherid][pName], otherid, pData[otherid][pJailTime]);
	    Info(playerid, "/unjail <ID/Name> to unjail.");
	    return true;
	}
	if(pData[otherid][pSpawned] == 0)
	{
	    Error(playerid, "%s(%i) isn't spawned!", pData[otherid][pName], otherid);
	    return true;
	}
	if(reason[0] != '*' && strlen(reason) > 60)
	{
	 	Error(playerid, "Reason too long! Must be smaller than 60 characters!");
	   	return true;
	}
	if(timeSec < 1 || timeSec > 60)
	{
	    if(pData[playerid][pAdmin] < 5)
	 	{
			Error(playerid, "Jail time must remain between 1 and 60 minutes");
	    	return 1;
	  	}
	}
	pData[otherid][pJail] = 1;
	pData[otherid][pJailTime] = timeSec * 60;
	JailPlayer(otherid);
	if(reason[0] == '*')
	{
		SendClientMessageToAllEx(TOMATO, "AdmCmd: Admin %s telah menjail player %s selama %d menit.", pData[playerid][pAdminname], pData[otherid][pName], timeSec);
	}
	else
	{
		SendClientMessageToAllEx(TOMATO, "AdmCmd: Admin %s telah menjail player %s selama %d menit", pData[playerid][pAdminname], pData[otherid][pName], timeSec);
		SendClientMessageToAllEx(TOMATO, "AdmCmd: Reason: %s", reason);
	}
	return 1;
}


CMD:unjail(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] < 2)
     		return PermissionError(playerid);

	new otherid, reason[128];
	if(sscanf(params, "us[128]", otherid, reason))
	{
	    Usage(playerid, "/unjail <ID/Name> [reason unjail]");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	if(pData[otherid][pJail] == 0)
	    return Error(playerid, "The player isn't in jail!");

	pData[otherid][pJail] = 0;
	pData[otherid][pJailTime] = 0;
	SetPlayerInterior(otherid, 0);
	SetPlayerVirtualWorld(otherid, 0);
	SetPlayerPos(otherid, 1529.6,-1691.2,13.3);
	SetPlayerSpecialAction(otherid, SPECIAL_ACTION_NONE);

	SendClientMessageToAllEx(TOMATO, "AdmCmd: Admin %s telah unjailed %s", pData[playerid][pAdminname], pData[otherid][pName]);
    SendClientMessageToAllEx(TOMATO, "AdmCmd: Reason: %s", reason);
	return true;
}

CMD:kick(playerid, params[])
{
    static
        reason[128];

	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] == 0)
			return PermissionError(playerid);

	new otherid;
    if(sscanf(params, "us[128]", otherid, reason))
        return Usage(playerid, "/kick [playerid/PartOfName] [reason]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

    if(pData[otherid][pAdmin] > pData[playerid][pAdmin])
        return Error(playerid, "The specified player has higher authority.");

    SendClientMessageToAllEx(TOMATO, "AdmCmd: %s has been kicked by admin %s", pData[otherid][pName], pData[playerid][pAdminname]);
    SendClientMessageToAllEx(TOMATO, "AdmCmd: Reason: %s", reason);
	KickEx(otherid);

    return 1;
}

CMD:ban(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
			return PermissionError(playerid);

	new targetid, reason[128];
	if(sscanf(params, "us[128]", targetid, reason))
	{
	    Usage(playerid, "/ban [Playerid/Targetid] [Alasan membanned]");
	    return true;
	}
	if(!IsPlayerConnected(targetid))
        return Error(playerid, "Player tidak on!");
    SendClientMessageToAllEx(TOMATO, "Admcmd: Admin %s telah mem-banned player %s", pData[playerid][pAdminname], pData[targetid][pName]);
    SendClientMessageToAllEx(TOMATO, "Admcmd: Reason: %s", reason);
    format(pData[targetid][pBanBy], 128, "%s", pData[playerid][pAdminname]);
    format(pData[targetid][pBanReason], 128, "%s", reason);
	pData[targetid][pBanned] = 1;
	KickEx(targetid);
	return true;
}

CMD:oban(playerid, params[])
{
   	if(pData[playerid][pAdmin] < 1)
			return PermissionError(playerid);

	new tmp[24], reasonoban[128];
	if(sscanf(params, "s[24]s[128]", tmp, reasonoban))
	{
	    Usage(playerid, "/oban <ban name> <reason banned>");
	    return true;
	}
	new query[512];
	SendClientMessageToAllEx(TOMATO, "Admcmd: Admin %s telah mem-banned player %s", pData[playerid][pAdminname], tmp);
    SendClientMessageToAllEx(TOMATO, "Admcmd: Reason: %s", reasonoban);
	mysql_format(g_SQL, query, sizeof(query), "SELECT reg_id FROM players WHERE username='%e'", tmp);
	mysql_tquery(g_SQL, query, "ObanByIrwan", "iss", playerid, tmp, reasonoban);
	return 1;
}
CMD:verif(playerid, params[])
{
   	if(pData[playerid][pAdmin] < 1)
			return PermissionError(playerid);

	new tmp[24];
	if(sscanf(params, "s[24]s[128]", tmp))
	{
	    Usage(playerid, "/verif <name account>");
	    return true;
	}
	new query[512];
	SendStaffMessage(COLOR_RED, "AdmCmd: Admin %s telah mem verif account %s", pData[playerid][pAdminname], tmp);

	mysql_format(g_SQL, query, sizeof(query), "SELECT reg_id FROM players WHERE username='%e'", tmp);
	mysql_tquery(g_SQL, query, "VerifAccount", "is", playerid, tmp);
	return 1;
}
CMD:unban(playerid, params[])
{
   	if(pData[playerid][pAdmin] < 1)
			return PermissionError(playerid);

	new tmp[24], reasonunban[128];
	if(sscanf(params, "s[24]s[128]", tmp, reasonunban))
	{
	    Usage(playerid, "/unban <ban name> <reason unbanned>");
	    return true;
	}
	new query[512];
	mysql_format(g_SQL, query, sizeof(query), "SELECT reg_id FROM players WHERE username='%e'", tmp);
	mysql_tquery(g_SQL, query, "UnbanByIrwan", "iss", playerid, tmp, reasonunban);
	return 1;
}
CMD:warn(playerid, params[])
{
    static
        reason[32];

    if(pData[playerid][pAdmin] < 1)
        if(pData[playerid][pHelper] < 3)
			return PermissionError(playerid);
	new otherid;
    if(sscanf(params, "us[32]", otherid, reason))
        return Usage(playerid, "/warn [playerid/PartOfName] [reason]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

    if(pData[otherid][pAdmin] > pData[playerid][pAdmin])
        return Error(playerid, "The specified player has higher authority.");

	pData[otherid][pWarn]++;
	SendClientMessageToAllEx(TOMATO, "AdmCmd: Admin %s telah memberikan warning kepada player %s", pData[playerid][pAdminname], pData[otherid][pName]);
    SendClientMessageToAllEx(TOMATO, "AdmCmd: Reason : %s [Total Warning: %d/20]", reason, pData[otherid][pWarn]);
	return 1;
}

CMD:unwarn(playerid, params[])
{
    if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 3)
			return PermissionError(playerid);
	new otherid, reason[128];
    if(sscanf(params, "us[128]", otherid, reason))
        return Usage(playerid, "/unwarn [playerid/PartOfName] [reason unwarn]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

    pData[otherid][pWarn] -= 1;
    SendClientMessageToAllEx(TOMATO, "AdmCmd: Admin %s telah meng-unwarning kepada player %s", pData[playerid][pAdminname], pData[otherid][pName]);
    SendClientMessageToAllEx(TOMATO, "AdmCmd: Reason : %s [Total Warning: %d/20]", reason, pData[otherid][pWarn]);
    return 1;
}

CMD:respawnsapd(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 3)
			return PermissionError(playerid);

	for(new x;x<MAX_SAPD_VEHICLES; x++)
	{
		if(IsVehicleEmpty(LSPDVehicles[x]))
		{
			SetVehicleToRespawn(LSPDVehicles[x]);
			SetValidVehicleHealth(LSPDVehicles[x], 2000);
			SetVehicleFuel(LSPDVehicles[x], 1000);
			SwitchVehicleDoors(LSPDVehicles[x], false);
		}
	}
	SendStaffMessage(COLOR_RED, "AdmCmd: "YELLOW_E"%s "WHITE_E"has respawned SAPD vehicles.", pData[playerid][pAdminname]);
	return 1;
}

CMD:respawnsamd(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 3)
			return PermissionError(playerid);

	for(new x;x<MAX_SAMD_VEHICLES; x++)
	{
		if(IsVehicleEmpty(SAMDVehicles[x]))
		{
			SetVehicleToRespawn(SAMDVehicles[x]);
			SetValidVehicleHealth(SAMDVehicles[x], 2000);
			SetVehicleFuel(SAMDVehicles[x], 1000);
			SwitchVehicleDoors(SAMDVehicles[x], false);
		}
	}
	SendStaffMessage(COLOR_RED, "AdmCmd: "YELLOW_E"%s "WHITE_E"has respawned SAMD vehicles.", pData[playerid][pAdminname]);
	return 1;
}

CMD:respawnsana(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 3)
			return PermissionError(playerid);

	for(new x;x<MAX_SANA_VEHICLES; x++)
	{
		if(IsVehicleEmpty(SANAVehicles[x]))
		{
			SetVehicleToRespawn(SANAVehicles[x]);
			SetValidVehicleHealth(SANAVehicles[x], 2000);
			SetVehicleFuel(SANAVehicles[x], 1000);
			SwitchVehicleDoors(SANAVehicles[x], false);
		}
	}
	SendStaffMessage(COLOR_RED, "AdmCmd: Admin "YELLOW_E"%s "WHITE_E"has respawned SANA vehicles.", pData[playerid][pAdminname]);
	return 1;
}

CMD:respawnjobs(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 3)
			return PermissionError(playerid);

	for(new x;x<MAX_SWEEPER_VEHICLES; x++)
	{
		if(IsVehicleEmpty(SweepVeh[x]))
		{
			SetVehicleToRespawn(SweepVeh[x]);
			SetValidVehicleHealth(SweepVeh[x], 2000);
			SetVehicleFuel(SweepVeh[x], 1000);
			SwitchVehicleDoors(SweepVeh[x], false);
		}
	}
	for(new xx;xx<MAX_BUS_VEHICLES;xx++)
	{
		if(IsVehicleEmpty(BusABVeh[xx]))
		{
			SetVehicleToRespawn(BusABVeh[xx]);
			SetValidVehicleHealth(BusABVeh[xx], 2000);
			SetVehicleFuel(BusABVeh[xx], 1000);
			SwitchVehicleDoors(BusABVeh[xx], false);
		}
	}
	for(new xx;xx<MAX_BUS_VEHICLES;xx++)
	{
		if(IsVehicleEmpty(BusCDVeh[xx]))
		{
			SetVehicleToRespawn(BusCDVeh[xx]);
			SetValidVehicleHealth(BusCDVeh[xx], 2000);
			SetVehicleFuel(BusCDVeh[xx], 1000);
			SwitchVehicleDoors(BusCDVeh[xx], false);
		}
	}
	for(new xx;xx<MAX_FORKLIFT_VEHICLES; xx++)
	{
		if(IsVehicleEmpty(ForkliftVeh[xx]))
		{
			SetVehicleToRespawn(ForkliftVeh[xx]);
			SetValidVehicleHealth(ForkliftVeh[xx], 2000);
			SetVehicleFuel(ForkliftVeh[xx], 1000);
			SwitchVehicleDoors(ForkliftVeh[xx], false);
		}
	}
	SendStaffMessage(COLOR_RED, "AdmCmd: Admin "YELLOW_E"%s "WHITE_E"has respawned Jobs vehicles.", pData[playerid][pAdminname]);
	return 1;
}

RespawnNearbyVehicles(playerid, Float:radi)
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    for(new i=1; i<MAX_VEHICLES; i++)
    {
        if(GetVehicleModel(i))
        {
            new Float:posx, Float:posy, Float:posz;
            new Float:tempposx, Float:tempposy, Float:tempposz;
            GetVehiclePos(i, posx, posy, posz);
            tempposx = (posx - x);
            tempposy = (posy - y);
            tempposz = (posz - z);
            if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
            {
				if(IsVehicleEmpty(i))
				{
					SetTimerEx("RespawnPV", 3000, false, "d", i);
					SendClientMessageToAllEx(TOMATO, "AdmCmd: %s telah merespawn kendaraan disekitar dengan radius %d.", pData[playerid][pAdminname], radi);
				}
			}
        }
    }
}

CMD:respawnrad(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		return PermissionError(playerid);

	new rad;
	if(sscanf(params, "d", rad)) return Usage(playerid, "/respawnrad [radius] | respawn vehicle nearest");

	if(rad > 25000) return Error(playerid, "Maximal 25.000 radius");
	RespawnNearbyVehicles(playerid, rad);
	return 1;
}

//----------------------------[ Admin Level 2 ]-----------------------
CMD:sethp(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);

	new jumlah, otherid;
	if(sscanf(params, "ud", otherid, jumlah))
        return Usage(playerid, "/sethp [playerid id/name] <jumlah>");

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	SetPlayerHealthEx(otherid, jumlah);
	SendStaffMessage(COLOR_RED, "AdmCmd: %s telah men set jumlah hp player %s", pData[playerid][pAdminname], pData[otherid][pName]);
	Servers(otherid, "Admin %s telah men set hp anda", pData[playerid][pAdminname]);
	return 1;
}

CMD:aheal(playerid, params[])
{
    if(pData[playerid][pAdmin] < 5)
        return PermissionError(playerid);
    new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/aheal [playerid id/name]");
    SetPlayerHealthEx(otherid, 115);
    SendClientMessageEx(playerid, COLOR_ARWIN, "HEAL: "WHITE_E"kamu telah berhasil meng-aheal player tersebut");
    SendClientMessageEx(otherid, COLOR_ARWIN, "HEAL: "WHITE_E"kamu telah di-aheal oleh admin");
    return 1;
}

CMD:aarmor(playerid, params[])
{
    if(pData[playerid][pAdmin] < 5)
        return PermissionError(playerid);
    new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/aarmor [playerid id/name]");
    SetPlayerArmourEx(otherid, 115);
    SendClientMessageEx(playerid, COLOR_ARWIN, "ARMOR: "WHITE_E"kamu telah berhasil meng-refill armour player tersebut");
    SendClientMessageEx(otherid, COLOR_ARWIN, "ARMOR: "WHITE_E"armour kamu telah berhasil di set oleh admin");
    return 1;
}

CMD:setam(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);

	new jumlah, otherid;
	if(sscanf(params, "ud", otherid, jumlah))
        return Usage(playerid, "/setam [playerid id/name] <jumlah>");

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	if(jumlah > 95)
	{
		SetPlayerArmourEx(otherid, 98);
	}
	else
	{
		SetPlayerArmourEx(otherid, jumlah);
	}
	SendStaffMessage(COLOR_RED, "AdmCmd: %s telah men set jumlah armor player %s", pData[playerid][pAdminname], pData[otherid][pName]);
	Servers(otherid, "Admin %s telah men set armor anda", pData[playerid][pAdminname]);
	return 1;
}

CMD:afix(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
     		return PermissionError(playerid);

    if(IsPlayerInAnyVehicle(playerid))
	{
        SetValidVehicleHealth(GetPlayerVehicleID(playerid), 1000);
		SetVehicleFuel(GetPlayerVehicleID(playerid), 1000);
		ValidRepairVehicle(GetPlayerVehicleID(playerid));
        Servers(playerid, "Vehicle Fixed!");
    }
	else
	{
		Error(playerid, "Kamu tidak berada didalam kendaraan apapun!");
	}
	return 1;
}

CMD:setjob1(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);

	new
        jobid,
		otherid;

	if(sscanf(params, "ud", otherid, jobid))
        return Usage(playerid, "/setjob1 [playerid/PartOfName] [jobid]");

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	if(jobid < 0 || jobid > 12)
        return Error(playerid, "Invalid ID. 0 - 11.");

	pData[otherid][pJob] = jobid;
	pData[otherid][pExitJob] = 0;

	Servers(playerid, "Anda telah menset job1 player %s(%d) menjadi %s(%d).", pData[otherid][pName], otherid, GetJobName(jobid), jobid);
	Servers(otherid, "Admin %s telah menset job1 anda menjadi %s(%d)", pData[playerid][pAdminname], GetJobName(jobid), jobid);
	return 1;
}

CMD:setjob2(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);

	new
        jobid,
		otherid;

	if(sscanf(params, "ud", otherid, jobid))
        return Usage(playerid, "/setjob2 [playerid/PartOfName] [jobid]");

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	if(jobid < 0 || jobid > 12)
        return Error(playerid, "Invalid ID. 0 - 11.");

	pData[otherid][pJob2] = jobid;
	pData[otherid][pExitJob] = 0;

	Servers(playerid, "Anda telah menset job2 player %s(%d) menjadi %s(%d).", pData[otherid][pName], otherid, GetJobName(jobid), jobid);
	Servers(otherid, "Admin %s telah menset job2 anda menjadi %s(%d)", pData[playerid][pAdminname], GetJobName(jobid), jobid);
	return 1;
}

CMD:setskin(playerid, params[])
{
    new
        skinid,
		otherid;

    if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);

    if(sscanf(params, "ud", otherid, skinid))
        return Usage(playerid, "/skin [playerid/PartOfName] [skin id]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

    if(skinid < 0 || skinid > 299)
        return Error(playerid, "Invalid skin ID. Skins range from 0 to 299.");

    SetPlayerSkin(otherid, skinid);
	pData[otherid][pSkin] = skinid;

    Servers(playerid, "You have set %s's skin to ID: %d.", ReturnName(otherid), skinid);
    Servers(otherid, "%s has set your skin to ID: %d.", ReturnName(playerid), skinid);
    return 1;
}

CMD:akill(playerid, params[])
{
    if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);
	new reason[60], otherid;
	if(sscanf(params, "uS(*)[60]", otherid, reason))
	{
	    Usage(playerid, "/akill <ID/Name> <optional: reason>");
	    return 1;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	SetPlayerHealth(otherid, 0.0);

	if(reason[0] != '*')
	{
		SendClientMessageToAllEx(TOMATO, "AdmCmd: Admin %s has killed %s [Reason: %s]", pData[playerid][pAdminname], pData[otherid][pName], reason);
	}
	else
	{
		SendClientMessageToAllEx(TOMATO, "AdmCmd: Admin %s has killed %s.", pData[playerid][pAdminname], pData[otherid][pName]);
	}
	return 1;
}

CMD:ann(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);

 	if(isnull(params))
    {
	    Usage(playerid, "/announce <msg>");
	    return 1;
	}
	// Check for special trouble-making input
   	if(strfind(params, "~x~", true) != -1)
		return Error(playerid, "~x~ is not allowed in announce.");
	if(strfind(params, "#k~", true) != -1)
		return Error(playerid, "The constant key is not allowed in announce.");
	if(strfind(params, "/q", true) != -1)
		return Error(playerid, "You are not allowed to type /q in announcement!");

	// Count tildes (uneven number = faulty input)
	new iTemp = 0;
	for(new i = (strlen(params)-1); i != -1; i--)
	{
		if(params[i] == '~')
			iTemp ++;
	}
	if(iTemp % 2 == 1)
		return Error(playerid, "You either have an extra ~ or one is missing in the announcement!");

	new str[512];
	format(str, sizeof(str), "~w~%s", params);
	GameTextForAll(str, 6500, 3);
	return true;
}

CMD:settime(playerid, params[])
{
    if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);

	new time, mstr[128];
	if(sscanf(params, "d", time))
	{
		Usage(playerid, "/time <time ID>");
		return true;
	}

	SendClientMessageToAllEx(TOMATO, "AdmCmd: Admin %s(%i) has changed the time to: %d", pData[playerid][pAdminname], playerid, time);

	format(mstr, sizeof(mstr), "~r~Time changed: ~b~%d", time);
	GameTextForAll(mstr, 3000, 5);

	SetWorldTime(time);
	WorldTime = time;
	foreach(new ii : Player)
	{
		SetPlayerTime(ii, time, 0);
	}
	return 1;
}

CMD:setweather(playerid, params[])
{
    new weatherid;

    if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);

    if(sscanf(params, "d", weatherid))
        return Usage(playerid, "/setweather [weather ID]");

    SetWeather(weatherid);
	WorldWeather = weatherid;
	foreach(new ii : Player)
	{
		SetPlayerWeather(ii, weatherid);
	}
    SetGVarInt("g_Weather", weatherid);
    SendClientMessageToAllEx(TOMATO,"AdmCmd: %s have changed the weather ID", pData[playerid][pAdminname]);
    Servers(playerid, "You have changed the weather to ID: %d.", weatherid);
    return 1;
}

CMD:gotoco(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
		return PermissionError(playerid);

	new Float: pos[3], int;
	if(sscanf(params, "fffd", pos[0], pos[1], pos[2], int)) return Usage(playerid, "/gotoco [x coordinate] [y coordinate] [z coordinate] [interior]");

	Servers(playerid, "You have been teleported to the coordinates specified.");
	SetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	SetPlayerInterior(playerid, int);
	return 1;
}

CMD:cd(playerid)
{
	if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);

	if(Count != -1) return Error(playerid, "There is already a countdown in progress, wait for it to end!");

	Count = 6;
	countTimer = SetTimer("pCountDown", 1000, 1);

	foreach(new ii : Player)
	{
		showCD[ii] = 1;
	}
	SendClientMessageToAllEx(TOMATO, "AdmCmd: Admin %s has started a global countdown!", pData[playerid][pAdminname]);
	return 1;
}

CMD:banip(playerid, params[])
{
    if(pData[playerid][pAdmin] < 3)
     	return PermissionError(playerid);

	if(isnull(params))
	{
	    Usage(playerid, "/banip <IP Address>");
		return true;
	}
	if(strfind(params, "*", true) != -1 && pData[playerid][pAdmin] != 5)
	{
		Error(playerid, "You are not authorized to ban ranges.");
  		return true;
  	}

	SendClientMessageToAllEx(TOMATO, "AdmCmd: Admin %s(%d) IP banned address %s.", pData[playerid][pAdminname], playerid, params);

	new tstr[128];
	format(tstr, sizeof(tstr), "banip %s", params);
	SendRconCommand(tstr);
	return 1;
}

CMD:unbanip(playerid, params[])
{
    if(pData[playerid][pAdmin] < 3)
     	return PermissionError(playerid);

	if(isnull(params))
	{
	    Usage(playerid, "/unbanip <IP Address>");
		return true;
	}
	new mstr[128];
	format(mstr, sizeof(mstr), "unbanip %s", params);
	SendRconCommand(mstr);
	format(mstr, sizeof(mstr), "reloadbans");
	SendRconCommand(mstr);
	Servers(playerid, "You have unbanned IP address %s.", params);
	return 1;
}

CMD:reloadweap(playerid, params[])
{
    if(pData[playerid][pAdmin] < 3)
        return PermissionError(playerid);
	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/reloadweps [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

    SetWeapons(otherid);
    Servers(playerid, "You have reload %s's weapons.", pData[otherid][pName]);
    Servers(otherid, "Admin %s have reload your weapons.", pData[playerid][pAdminname]);
    return 1;
}

CMD:resetweap(playerid, params[])
{
    if(pData[playerid][pAdmin] < 3)
        return PermissionError(playerid);
	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/resetweps [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");
    ResetPlayerWeaponsEx(otherid);		
    Servers(playerid, "You have reset %s's weapons.", pData[otherid][pName]);
    Servers(otherid, "Admin %s have reset your weapons.", pData[playerid][pAdminname]);
    return 1;
}

CMD:sethbe(playerid, params[])
{
	if(pData[playerid][pAdmin] < 3)
        return PermissionError(playerid);

	new jumlah, otherid;
	if(sscanf(params, "ud", otherid, jumlah))
        return Usage(playerid, "/sethbe [playerid id/name] <jumlah>");

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	pData[otherid][pHunger] = jumlah;
	pData[otherid][pEnergy] = jumlah;
	//pData[otherid][pBladder] = jumlah;
	pData[otherid][pSick] = 0;
	SetPlayerDrunkLevel(playerid, 0);
	SendStaffMessage(COLOR_RED, "AdmCmd: %s telah men set jumlah hbe player %s", pData[playerid][pAdminname], pData[otherid][pName]);
	Servers(otherid, "Admin %s telah men set HBE anda", pData[playerid][pAdminname]);
	return 1;
}

//----------------------------[ Admin Level 4 ]---------------
CMD:setname(playerid, params[])
{
	if(pData[playerid][pAdmin] < 4)
		return PermissionError(playerid);
	new otherid, tmp[20];
	if(sscanf(params, "is[20]", otherid, tmp))
	{
	   	Usage(playerid, "/setname <ID/Name> <newname>");
	    return 1;
	}
	if(!IsPlayerConnected(otherid)) return Error(playerid, "Player tidak on!");
	if(pData[otherid][IsLoggedIn] == false)	return Error(playerid, "That player is not logged in.");

	if(strlen(tmp) < 4) return Error(playerid, "New name can't be shorter than 4 characters!");
	if(strlen(tmp) > 20) return Error(playerid, "New name can't be longer than 20 characters!");

	if(!IsValidName(tmp)) return Error(playerid, "Name contains invalid characters, please doublecheck!");
	new query[248];
	mysql_format(g_SQL, query, sizeof(query), "SELECT username FROM players WHERE username='%s'", tmp);
	mysql_tquery(g_SQL, query, "SetName", "iis", otherid, playerid, tmp);
	return 1;
}

CMD:setgender(playerid, params[])
{
	if(pData[playerid][pAdmin] < 4)
		return PermissionError(playerid);	

	new gender, otherid;
	if(sscanf(params, "udd", otherid, gender))
	{
	    Usage(playerid, "/setgender <ID> <1 = Laki Laki || 0 = Perempuan>");
	    return true;
	}
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");
	if(gender > 2)
		return Error(playerid, "Level can't be higher than 2!");
	if(gender < 0)
		return Error(playerid, "Level can't be lower than 0!");
	pData[otherid][pGender] = gender;	
	SendClientMessageEx(otherid, COLOR_ARWIN, "GENDER: "WHITE_E"Gender anda telah di ubah oleh Adm "YELLOW_E"%s", pData[playerid][pAdminname]);
	SendClientMessageEx(playerid, COLOR_ARWIN, "GENDER: "WHITE_E"Anda telah mengubah gender pemain "YELLOW_E"%s", pData[otherid][pName]);
	return 1;
}

// SetName Callback
CMD:setvip(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);

	new alevel, dayz, otherid, tmp[64];
	if(sscanf(params, "udd", otherid, alevel, dayz))
	{
	    Usage(playerid, "/setvip <ID/Name> <level 0 - 4> <time (in days) 0 for permanent>");
		Info(playerid, "1.Basic Donatur 2.Advance Donatur 3.Professional Donatur 4.Lifetime Donatur");
	    return true;
	}
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");
	if(alevel > 4)
		return Error(playerid, "Level can't be higher than 3!");
	if(alevel < 0)
		return Error(playerid, "Level can't be lower than 0!");
	if(dayz < 0)
		return Error(playerid, "Time can't be lower than 0!");

	if(pData[otherid][IsLoggedIn] == false)
	{
		Error(playerid, "Player %s(%i) isn't logged in!", pData[otherid][pName], otherid);
		return true;
	}

	if(pData[playerid][pAdmin] < 5 && dayz > 7)
		return Error(playerid, "Anda hanya bisa menset 1 - 7 hari!");

	pData[otherid][pVip] = alevel;
	if(dayz == 0)
	{
		pData[otherid][pVipTime] = 0;
		SendClientMessageToAllEx(TOMATO, "Admcmd: Admin %s(%d) telah menset VIP kepada %s(%d) ke level %s permanent time!", pData[playerid][pAdminname], playerid, pData[otherid][pName], otherid, GetVipRank(otherid));
	}
	else
	{
		pData[otherid][pVipTime] = gettime() + (dayz * 86400);
		SendClientMessageToAllEx(TOMATO, "Admcmd: Admin %s(%d) telah menset VIP kepada %s(%d) selama %d hari ke level %s!", pData[playerid][pAdminname], playerid, pData[otherid][pName], otherid, dayz, GetVipRank(otherid));
	}

	format(tmp, sizeof(tmp), "%d(%d days)", alevel, dayz);
	StaffCommandLog("SETVIP", playerid, otherid, tmp);
	return 1;
}

CMD:giveweap(playerid, params[])
{
    static
        weaponid,
        ammo;

	new otherid;
    if(pData[playerid][pAdmin] < 4)
        return PermissionError(playerid);

    if(sscanf(params, "udI(250)", otherid, weaponid, ammo))
        return Usage(playerid, "/givewep [playerid/PartOfName] [weaponid] [ammo]");

    if(otherid == INVALID_PLAYER_ID)
        return Error(playerid, "You cannot give weapons to disconnected players.");


    if(weaponid <= 0 || weaponid > 46 || (weaponid >= 19 && weaponid <= 21))
        return Error(playerid, "You have specified an invalid weapon.");

    if(ammo < 1 || ammo > 500)
        return Error(playerid, "You have specified an invalid weapon ammo, 1 - 500");

    GivePlayerWeaponEx(otherid, weaponid, ammo);
    Servers(playerid, "You have give %s a %s with %d ammo.", pData[otherid][pName], ReturnWeaponName(weaponid), ammo);

    return 1;
}

CMD:setfaction(playerid, params[])
{
	new fid, rank, otherid, tmp[64];
    if(pData[playerid][pAdmin] < 4)
        return PermissionError(playerid);

    if(sscanf(params, "udd", otherid, fid, rank))
        return Usage(playerid, "/setfaction [playerid/PartOfName] [1.SAPD, 2.SAGS, 3.SAMD, 4.SANEW] [rank 1-6]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	if(pData[otherid][pFamily] != -1)
		return Error(playerid, "Player tersebut sudah bergabung family");

    if(fid < 0 || fid > 4)
        return Error(playerid, "You have specified an invalid faction ID 0 - 4.");

	if(rank < 1 || rank > 6)
        return Error(playerid, "You have specified an invalid rank 1 - 6.");

	if(fid == 0)
	{
		pData[otherid][pFaction] = 0;
		pData[otherid][pFactionRank] = 0;
		Servers(playerid, "You have removed %s's from faction.", pData[otherid][pName]);
		Servers(otherid, "%s has removed your faction.", pData[playerid][pName]);
	}
	else
	{
		pData[otherid][pFaction] = fid;
		pData[otherid][pFactionRank] = rank;
		Servers(playerid, "You have set %s's faction ID %d with rank %d.", pData[otherid][pName], fid, rank);
		Servers(otherid, "%s has set your faction ID to %d with rank %d.", pData[playerid][pName], fid, rank);
	}

	format(tmp, sizeof(tmp), "%d(%d rank)", fid, rank);
	StaffCommandLog("SETFACTION", playerid, otherid, tmp);
    return 1;
}

CMD:setleader(playerid, params[])
{
	new fid, otherid, tmp[64];
    if(pData[playerid][pAdmin] < 4)
        return PermissionError(playerid);

    if(sscanf(params, "ud", otherid, fid))
        return Usage(playerid, "/setleader [playerid/PartOfName] [0.None, 1.SAPD, 2.SAGS, 3.SAMD, 4.SANEW]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	if(pData[otherid][pFamily] != -1)
		return Error(playerid, "Player tersebut sudah bergabung family");

    if(fid < 0 || fid > 4)
        return Error(playerid, "You have specified an invalid faction ID 0 - 4.");

	if(fid == 0)
	{
		pData[otherid][pFaction] = 0;
		pData[otherid][pFactionLead] = 0;
		pData[otherid][pFactionRank] = 0;
		Servers(playerid, "You have removed %s's from faction leader.", pData[otherid][pName]);
		Servers(otherid, "%s has removed your faction leader.", pData[playerid][pName]);
	}
	else
	{
		pData[otherid][pFaction] = fid;
		pData[otherid][pFactionLead] = fid;
		pData[otherid][pFactionRank] = 6;
		Servers(playerid, "You have set %s's faction ID %d with leader.", pData[otherid][pName], fid);
		Servers(otherid, "%s has set your faction ID to %d with leader.", pData[playerid][pName], fid);
	}

	format(tmp, sizeof(tmp), "%d", fid);
	StaffCommandLog("SETLEADER", playerid, otherid, tmp);
    return 1;
}

CMD:takemoney(playerid, params[])
{
	if(pData[playerid][pAdmin] < 4)
		return PermissionError(playerid);

	new money, otherid;
	if(sscanf(params, "ud", otherid, money))
	{
	    Usage(playerid, "/takemoney <ID/Name> <amount>");
	    return true;
	}

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

 	if(money > pData[otherid][pMoney])
		return Error(playerid, "Player doesn't have enough money to deduct from!");

	GivePlayerMoneyEx(otherid, -money);
	SendClientMessageToAllEx(TOMATO, "Admcmd: Admin %s(%i) has taken away money $%s from $%s", pData[playerid][pAdminname], FormatMoney(money), pData[otherid][pName]);
	return true;
}

CMD:takegold(playerid, params[])
{
	if(pData[playerid][pAdmin] < 4)
		return PermissionError(playerid);

	new gold, otherid;
	if(sscanf(params, "ud", otherid, gold))
	{
	    Usage(playerid, "/takegold <ID/Name> <amount>");
	    return true;
	}

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

 	if(gold > pData[otherid][pGold])
		return Error(playerid, "Player doesn't have enough gold to deduct from!");

	pData[otherid][pGold] -= gold;
	SendClientMessageToAllEx(TOMATO, "Admcmd: Admin %s(%i) has taken away gold %d from %s", pData[playerid][pAdminname], playerid, gold, pData[otherid][pName]);
	return 1;
}

CMD:veh(playerid, params[])
{
    static
        model[32],
        color1,
        color2;

    if(pData[playerid][pAdmin] < 4)
        return PermissionError(playerid);

    if(sscanf(params, "s[32]I(0)I(0)", model, color1, color2))
        return Usage(playerid, "/veh [model id/name] <color 1> <color 2>");

    if((model[0] = GetVehicleModelByName(model)) == 0)
        return Error(playerid, "Invalid model ID.");

    static
        Float:x,
        Float:y,
        Float:z,
        Float:a,
        vehicleid;

    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);

    vehicleid = CreateVehicle(model[0], x, y, z, a, color1, color2, 0);

    if(GetPlayerInterior(playerid) != 0)
        LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));

    if(GetPlayerVirtualWorld(playerid) != 0)
        SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));

    PutPlayerInVehicle(playerid, vehicleid, 0);

    SetVehicleNumberPlate(vehicleid, "STATIC");
	pData[playerid][pKeyVehicle] = vehicleid;
    Servers(playerid, "You have spawned a %s (%d, %d).", GetVehicleModelName(model[0]), color1, color2);
    return 1;
}


//-----------------------------[ Admin Level 5 ]------------------
CMD:sethelperlevel(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);

	new alevel, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, alevel))
	{
	    Usage(playerid, "/sethelperlevel <ID/Name> <level 0 - 3>");
	    return true;
	}
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");
	if(alevel > 3)
		return Error(playerid, "Level can't be higher than 3!");
	if(alevel < 0)
		return Error(playerid, "Level can't be lower than 0!");

	if(pData[otherid][IsLoggedIn] == false)
	{
		Error(playerid, "Player %s(%i) isn't logged in!", pData[otherid][pName], otherid);
		return true;
	}
	pData[otherid][pHelper] = alevel;
	Servers(playerid, "You has set helper level %s(%d) to level %d", pData[otherid][pName], otherid, alevel);
	Servers(otherid, "%s(%d) has set your helper level to %d", pData[otherid][pName], playerid, alevel);
	SendStaffMessage(COLOR_RED, "AdmWarn: Admin %s telah menset %s(%d) sebagai staff helper level %s(%d)",  pData[playerid][pAdminname], pData[otherid][pName], otherid, GetStaffRank(playerid), alevel);

	format(tmp, sizeof(tmp), "%d", alevel);
	StaffCommandLog("SETHELPERLEVEL", playerid, otherid, tmp);
	return 1;
}

CMD:setadminname(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	new aname[128], otherid, query[128];
	if(sscanf(params, "us[128]", otherid, aname))
	{
	    Usage(playerid, "/setadminname <ID/Name> <admin name>");
	    return true;
	}

	mysql_format(g_SQL, query, sizeof(query), "SELECT adminname FROM players WHERE adminname='%s'", aname);
	mysql_tquery(g_SQL, query, "a_ChangeAdminName", "iis", otherid, playerid, aname);
	return 1;
}

CMD:setmoney(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);

	new money, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, money))
	{
	    Usage(playerid, "/setmoney <ID/Name> <money>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	ResetPlayerMoneyEx(otherid);
	GivePlayerMoneyEx(otherid, money);

	Servers(playerid, "Kamu telah mengset uang %s(%d) menjadi $%s!", pData[otherid][pName], otherid, FormatMoney(money));
	Servers(otherid, "Admin %s telah mengset uang anda menjadi $%s!",pData[playerid][pAdminname], FormatMoney(money));

	format(tmp, sizeof(tmp), "%d", money);
	StaffCommandLog("SETMONEY", playerid, otherid, tmp);
	return 1;
}

CMD:setbankmoney(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);

	new money, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, money))
	{
	    Usage(playerid, "/setbankmoney <ID/Name> <money>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	pData[otherid][pBankMoney] = money;

	Servers(playerid, "Kamu telah mengset uang rekening banki %s(%d) menjadi $%s!", pData[otherid][pName], otherid, FormatMoney(money));
	Servers(otherid, "Admin %s telah mengset uang rekening bank anda menjadi $%s!",pData[playerid][pAdminname], FormatMoney(money));

	format(tmp, sizeof(tmp), "%d", money);
	StaffCommandLog("SETBANKMONEY", playerid, otherid, tmp);
	return 1;
}

CMD:setmaterial(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	new money, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, money))
	{
	    Usage(playerid, "/setmaterial <ID/Name> <amount>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	pData[otherid][pMaterial] = money;

	Servers(playerid, "Kamu telah menset material %s(%d) dengan jumlah %d!", pData[otherid][pName], otherid, money);
	Servers(otherid, "Admin %s telah menset material kepada anda dengan jumlah %d!", pData[playerid][pAdminname], money);

	format(tmp, sizeof(tmp), "%d", money);
	StaffCommandLog("SETMATERIAL", playerid, otherid, tmp);
	return 1;
}

CMD:setcomponent(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	new money, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, money))
	{
	    Usage(playerid, "/setcomponent <ID/Name> <amount>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	pData[otherid][pComponent] = money;

	Servers(playerid, "Kamu telah menset component %s(%d) dengan jumlah %d!", pData[otherid][pName], otherid, money);
	Servers(otherid, "Admin %s telah menset component kepada anda dengan jumlah %d!", pData[playerid][pAdminname], money);

	format(tmp, sizeof(tmp), "%d", money);
	StaffCommandLog("SETCOMPONENT", playerid, otherid, tmp);
	return 1;
}

CMD:setcgun(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	new money, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, money))
	{
	    Usage(playerid, "/setcgun <ID/Name> <amount>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	pData[otherid][pCgun] = money;

	Servers(playerid, "Kamu telah menset cgun %s(%d) dengan jumlah %d!", pData[otherid][pName], otherid, money);
	Servers(otherid, "Admin %s telah menset cgun kepada anda dengan jumlah %d!", pData[playerid][pAdminname], money);

	format(tmp, sizeof(tmp), "%d", money);
	StaffCommandLog("SETCGUN", playerid, otherid, tmp);
	return 1;
}

CMD:explode(playerid, params[])
{
    if(pData[playerid][pAdmin] < 5)
        return PermissionError(playerid);
	new Float:POS[3], otherid, giveplayer[24];
	if(sscanf(params, "u", otherid))
	{
		Usage(playerid, "/explode <ID/Name>");
		return true;
	}

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));

	Servers(playerid, "You have exploded %s(%i).", giveplayer, otherid);
	GetPlayerPos(otherid, POS[0], POS[1], POS[2]);
	CreateExplosion(POS[0], POS[1], POS[2], 7, 5.0);
	return true;
}

//--------------------------[ Admin Level 6 ]-------------------
CMD:setadminlevel(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);

	new alevel, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, alevel))
	{
	    Usage(playerid, "/setadminlevel <ID/Name> <level 0 - 4>");
	    return true;
	}
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");
	if(alevel > 6)
		return Error(playerid, "Level can't be higher than 6!");
	if(alevel < 0)
		return Error(playerid, "Level can't be lower than 0!");

	if(pData[otherid][IsLoggedIn] == false)
	{
		Error(playerid, "Player %s(%i) isn't logged in!", pData[otherid][pName], otherid);
		return true;
	}
	pData[otherid][pAdmin] = alevel;
	Servers(playerid, "You has set admin level %s(%d) to level %d", pData[otherid][pName], otherid, alevel);
	Servers(otherid, "%s(%d) has set your admin level to %d", pData[otherid][pName], playerid, alevel);

	format(tmp, sizeof(tmp), "%d", alevel);
	StaffCommandLog("SETADMINLEVEL", playerid, otherid, tmp);
	return 1;
}

CMD:setgold(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);

	new gold, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, gold))
	{
	    Usage(playerid, "/setgold <ID/Name> <gold>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	pData[otherid][pGold] = gold;

	Servers(playerid, "Kamu telah menset gold %s(%d) dengan jumlah %d!", pData[otherid][pName], otherid, gold);
	Servers(otherid, "Admin %s telah menset gold kepada anda dengan jumlah %d!", pData[playerid][pAdminname], gold);

	format(tmp, sizeof(tmp), "%d", gold);
	StaffCommandLog("SETGOLD", playerid, otherid, tmp);
	return 1;
}

CMD:givegold(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);

	new gold, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, gold))
	{
	    Usage(playerid, "/givegold <ID/Name> <gold>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	pData[otherid][pGold] += gold;

	Servers(playerid, "Kamu telah memberikan gold %s(%d) dengan jumlah %d!", pData[otherid][pName], otherid, gold);
	Servers(otherid, "Admin %s telah memberikan gold kepada anda dengan jumlah %d!", pData[playerid][pAdminname], gold);

	format(tmp, sizeof(tmp), "%d", gold);
	StaffCommandLog("GIVEGOLD", playerid, otherid, tmp);
	return 1;
}

CMD:setstock(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6)
        return PermissionError(playerid);

	new name[64], string[128];
	if(sscanf(params, "s[64]S()[128]", name, string))
    {
        Usage(playerid, "/setstock [name] [stock]");
        SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} [material], [component], [fish]");
        return 1;
    }
	if(!strcmp(name, "material", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return Usage(playerid, "/setstok [material] [stok]");

        if(stok < 0 || stok > 1000000)
            return Error(playerid, "You must specify at least 0 or 1.000.000");

        StockMaterial = stok;
		Server_Save();
        SendAdminMessage(COLOR_RED, "AdmWarn: %s set material to %d.", pData[playerid][pAdminname], stok);
    }
    else if(!strcmp(name, "marijuana", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return Usage(playerid, "/setstok [marijuana] [stok]");

        if(stok < 0 || stok > 1000000)
            return Error(playerid, "You must specify at least 0 or 1.000.000.");

        StockMarijuana = stok;
		Server_Save();
		//Info(playerid, "Kamu telah menset stock marijuana menjadi %d", stok);
		SendAdminMessage(COLOR_RED, "AdmWarn: %s set skill mechanic player %s.", pData[playerid][pAdminname], stok);
    }
	else if(!strcmp(name, "component", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return Usage(playerid, "/setstok [component] [stok]");

        if(stok < 0 || stok > 1000000)
            return Error(playerid, "You must specify at least 0 or 1.000.000.");

        StockComponent = stok;
		Server_Save();
        SendAdminMessage(COLOR_RED, "AdmWarn: %s set component to %d.", pData[playerid][pAdminname], stok);
    }
	else if(!strcmp(name, "fish", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return Usage(playerid, "/setstok [food] [stok]");

        if(stok < 0 || stok > 1000000)
            return Error(playerid, "You must specify at least 0 or 1.000.000.");

        StockFish = stok;
		Server_Save();
        SendAdminMessage(COLOR_RED, "AdmWarn: %s set fish stok to %d.", pData[playerid][pAdminname], stok);
    }
	return 1;
}

CMD:kickall(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);

	foreach(new pid : Player)
	{
		if(pid != playerid)
		{
			UpdateWeapons(pid);
			UpdatePlayerData(pid);
			Servers(pid, "Sorry, server will be maintenance and your data have been saved.");
			KickEx(pid);
		}
	}
	return 1;
}

CMD:setpassword(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	new cname[21], query[128], pass[65], tmp[64];
	if(sscanf(params, "s[21]s[20]", cname, pass))
	{
	    Usage(playerid, "/setpassword <ucp> <new password>");
	    Info(playerid, "Make sure you enter the ucp name and not ID!");
	   	return 1;
	}

	mysql_format(g_SQL, query, sizeof(query), "SELECT password FROM players WHERE username='%s'", cname);
	mysql_tquery(g_SQL, query, "ChangePlayerPassword", "iss", playerid, cname, pass);

	format(tmp, sizeof(tmp), "%s", pass);
	StaffCommandLog("SETPASSWORD", playerid, INVALID_PLAYER_ID, tmp);
	return 1;
}

CMD:mutewt(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
		return PermissionError(playerid);

	new gold, otherid;
	if(sscanf(params, "ud", otherid, gold))
	{
	    Usage(playerid, "/mutewt <name> <minute>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	pData[otherid][pMuteWt] = gold;
	SendStaffMessage(TOMATO, "AdmCmd: Admin %s telah mute walkie talkie player %s selama %d menit.", pData[playerid][pAdminname], pData[otherid][pName], pData[otherid][pMuteWt]);
	Info(otherid, ""GREY2_E"Admin %s telah mute walkie talkie anda selama %d menit", pData[playerid][pAdminname], pData[otherid][pMuteWt]);
	return 1;
}

CMD:unmuteewt(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
		return PermissionError(playerid);

	new otherid;
	if(sscanf(params, "u", otherid))
	{
	    Usage(playerid, "/unmuteewt <name>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	pData[otherid][pMuteWt] = 0;
	SendStaffMessage(TOMATO, "AdmCmd: Admin %s telah unmute walkie talkie player %s", pData[playerid][pAdminname], pData[otherid][pName]);
	Info(otherid, ""GREY2_E"Admin %s telah unmute walkie talkie anda", pData[playerid][pAdminname]);	
	return 1;
}

CMD:eo(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
	SelectObject(playerid);
	pData[playerid][pEditSelect] = 4;
	return 1;
}

CMD:offlamp(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
	foreach(new i : Player)
	{
		PlayerTextDrawHide(i, OffLamp[i]);
	}
	Info(playerid, "Textdraw hide");
	return 1;
}

CMD:onlamp(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
	foreach(new i : Player)
	{
		PlayerTextDrawShow(i, OffLamp[i]);
	}
	Info(playerid, "Textdraw Show");
	return 1;
}

CMD:setskill(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6)
        return PermissionError(playerid);

	new name[64], string[128], otherid;
	if(sscanf(params, "ds[64]S()[128]",otherid, name, string))
    {
        Usage(playerid, "/setskill [playerid] [name] [score]");
        SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} [mechanic], [builder], [fishing], [trucker]");
        return 1;
    }
	if(!strcmp(name, "mechanic", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return Usage(playerid, "/setskill [playerid] [mechanic] [stok]");

        if(stok < 0 || stok > 1000000)
            return Error(playerid, "You must specify at least 0 or 1.000.000");

        pData[otherid][pSkillMecha] = stok;
		Info(otherid, "Skill Mechanic Anda Telah di set oleh admin %s", pData[playerid][pAdminname]);
        SendAdminMessage(COLOR_RED, "AdmWarn: %s set skill mechanic player %s.", pData[playerid][pAdminname], pData[otherid][pName]);
    }
    else if(!strcmp(name, "builder", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return Usage(playerid, "/setskill [playerid] [builder] [stok]");

        if(stok < 0 || stok > 1000000)
            return Error(playerid, "You must specify at least 0 or 1.000.000.");

		pData[otherid][pSkillBuilder] = stok;
		Info(otherid, "Skill Builder Anda Telah di set oleh admin %s", pData[playerid][pAdminname]);
		SendAdminMessage(COLOR_RED, "AdmWarn: %s set skill Builder player %s.", pData[playerid][pAdminname], pData[otherid][pName]);
    }
	else if(!strcmp(name, "fishing", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return Usage(playerid, "/setskill [playerid] [fishing] [stok]");

        if(stok < 0 || stok > 1000000)
            return Error(playerid, "You must specify at least 0 or 1.000.000.");

		pData[otherid][LevelFishing] = stok;
		Info(otherid, "Skill Fishing Anda Telah di set oleh admin %s", pData[playerid][pAdminname]);
        SendAdminMessage(COLOR_RED, "AdmWarn: %s set skill Fishing player %s.", pData[playerid][pAdminname], pData[otherid][pName]);
    }
	else if(!strcmp(name, "trucker", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return Usage(playerid, "/setskill [playerid] [trucker] [stok]");

        if(stok < 0 || stok > 1000000)
            return Error(playerid, "You must specify at least 0 or 1.000.000.");

		pData[otherid][LevelTrucker] = stok;
		Info(otherid, "Skill Trucker Anda Telah di set oleh admin %s", pData[playerid][pAdminname]);
        SendAdminMessage(COLOR_RED, "AdmWarn: %s set skill Trucker player %s.", pData[playerid][pAdminname], pData[otherid][pName]);
    }
	return 1;
}

CMD:getucp(playerid, params[])
{
    if(pData[playerid][pAdmin] < 2) return PermissionError(playerid);
    {
        new name;
		if(sscanf(params, "u", name)) return Usage(playerid, "/getucp [playerid]");
		{
			if(IsPlayerConnected(name))
			{
				SendClientMessageEx(playerid, COLOR_ARWIN, "UCP: "YELLOW_E"Character: {00FFFF}%s(pid: %d) "YELLOW_E"UCP: {00FFFF}%s(pid: %d)", pData[name][pName], pData[name][pID], charData[name][cName], charData[name][cID]);
			}
		}
	}
	return 1;
}

CMD:ogetucp(playerid, params[])
{
   	if(pData[playerid][pAdmin] < 1)
			return PermissionError(playerid);

	new tmp[24];
	if(sscanf(params, "s[24]", tmp))
	{
	    Usage(playerid, "/ogetucp <name player>");
	    return true;
	}
	new query[103];
	mysql_format(g_SQL, query, sizeof query, "SELECT * FROM `players` WHERE `username` = '%e' LIMIT 1", tmp);
	mysql_pquery(g_SQL, query, "GetNameUCP", "is", playerid, tmp);
	return 1;
}

function GetNameUCP(playerid, name[])
{
	new nameucp[32], id;
	if(cache_num_rows() > 0)
	{
		cache_get_value_name(0, "ucpname", nameucp);
		cache_get_value_name_int(0, "reg_id", id);	
		SendClientMessageEx(playerid, COLOR_ARWIN, "UCP: "YELLOW_E"Character: {00FFFF}%s(pid: %d) "YELLOW_E"UCP: {00FFFF}%s", name, id, nameucp);
	}
	return 1;
}

CMD:getchar(playerid, params[])
{
   	if(pData[playerid][pAdmin] < 1)
			return PermissionError(playerid);

	new tmp[24];
	if(sscanf(params, "s[24]", tmp))
	{
	    Usage(playerid, "/getchar <UCP Name>");
	    return true;
	}
	new query[103];
	mysql_format(g_SQL, query, sizeof query, "SELECT * FROM `ucp` WHERE `username` = '%e' LIMIT 1", tmp);
	mysql_pquery(g_SQL, query, "GetNameUCP12", "is", playerid, tmp);
	return 1;
}

CMD:unbanucp(playerid, params[])
{
   	if(pData[playerid][pAdmin] < 1)
			return PermissionError(playerid);

	new tmp[24];
	if(sscanf(params, "s[24]", tmp))
	{
	    Usage(playerid, "/unbanucp <Name UCP>");
	    return true;
	}
	new query[512];
	mysql_format(g_SQL, query, sizeof(query), "SELECT reg_id FROM ucp WHERE username='%e'", tmp);
	mysql_tquery(g_SQL, query, "oUnBanUCP", "is", playerid, tmp);
	return 1;
}

CMD:banucp(playerid, params[])
{
   	if(pData[playerid][pAdmin] < 1)
			return PermissionError(playerid);

	new tmp[24], reasonoban[128];
	if(sscanf(params, "s[24]s[128]", tmp, reasonoban))
	{
	    Usage(playerid, "/obanucp <Name UCP> <reason>");
	    return true;
	}
	new query[512];
	mysql_format(g_SQL, query, sizeof(query), "SELECT reg_id FROM ucp WHERE username='%e'", tmp);
	mysql_tquery(g_SQL, query, "oBanUCP", "iss", playerid, tmp, reasonoban);
	return 1;
}

function oUnBanUCP(adminid, NamaUntukDiOban[])
{
	if(cache_num_rows() < 1)
	{
		return Error(adminid, "Account "GREY2_E"'%s' "WHITE_E"does not exist.", NamaUntukDiOban);
	}
	else
	{
	    new RegID;
	    new obannedbyirwan = 0;
		new reason[511];
		reason = "";
		cache_get_value_index_int(0, 0, RegID);
		new query[512];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE ucp SET banned=%d, bannedreason='%s' WHERE reg_id=%d", obannedbyirwan, reason, RegID);
		mysql_tquery(g_SQL, query);
		SendClientMessageToAllEx(TOMATO, "AdmCmd: %s has been unblocked UCP account %s", pData[adminid][pAdminname], NamaUntukDiOban);
	}
	return 1;
}

function oBanUCP(adminid, NamaUntukDiOban[], OBanReason[])
{
	if(cache_num_rows() < 1)
	{
		return Error(adminid, "Account "GREY2_E"'%s' "WHITE_E"does not exist.", NamaUntukDiOban);
	}
	else
	{
	    new RegID;
	    new obannedbyirwan = 1;
		new reason[511];
		cache_get_value_index_int(0, 0, RegID);
		format(reason, 128, "%s [%s]", OBanReason, pData[adminid][pAdminname]);
		new query[512];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE ucp SET banned=%d, bannedreason='%s' WHERE reg_id=%d", obannedbyirwan, reason, RegID);
		mysql_tquery(g_SQL, query);
		SendClientMessageToAllEx(TOMATO, "AdmCmd: UCP %s has been blocked by %s", NamaUntukDiOban, pData[adminid][pAdminname]);
    	SendClientMessageToAllEx(TOMATO, "AdmCmd: Reason: %s", OBanReason);
	}
	return 1;
}

function GetNameUCP12(playerid, nameucp[])
{
	new name1, name2, name3;
	if(cache_num_rows() > 0)
	{
		cache_get_value_name_int(0, "CharName", name1);	
		cache_get_value_name_int(0, "CharName2", name2);	
		cache_get_value_name_int(0, "CharName3", name3);	
		new query[128];
		format(query,sizeof(query),"SELECT * FROM `players` WHERE `reg_id` = '%d'",name1);
		mysql_tquery(g_SQL,query, "CNUCP1", "i", playerid);
		
		format(query,sizeof(query),"SELECT * FROM `players` WHERE `reg_id` = '%d'",name2);
		mysql_tquery(g_SQL,query, "CNUCP2", "i", playerid);

		format(query,sizeof(query),"SELECT * FROM `players` WHERE `reg_id` = '%d'",name3);
		mysql_tquery(g_SQL,query, "CNUCP3", "i", playerid);
		format(NameUCP[playerid], MAX_PLAYER_NAME, "%s", nameucp);
	}
	return 1;
}

function CNUCP1(playerid)
{
	new name1[MAX_PLAYER_NAME];
 	if(cache_num_rows() > 0)
 	{
	    cache_get_value_name(0, "username", name1);
		format(CharNameUCP1[playerid], MAX_PLAYER_NAME, "%s", name1);
 	}
	return 1;
}

function CNUCP2(playerid)
{
	new name2[MAX_PLAYER_NAME];
 	if(cache_num_rows() > 0)
 	{
	    cache_get_value_name(0, "username", name2);
		format(CharNameUCP2[playerid], MAX_PLAYER_NAME, "%s", name2);
 	}
	return 1;
}

function CNUCP3(playerid)
{
	new name3[MAX_PLAYER_NAME];
 	if(cache_num_rows() > 0)
 	{
	    cache_get_value_name(0, "username", name3);
		format(CharNameUCP3[playerid], MAX_PLAYER_NAME, "%s", name3);
 	}
	EndLoadCharName(playerid);
	return 1;
}

function EndLoadCharName(playerid)
{
	SendClientMessageEx(playerid, COLOR_ARWIN, ""YELLOW_E"UCP: {00FFFF}%s "YELLOW_E"Character: {00FFFF}%s "YELLOW_E"Character: {00FFFF}%s "YELLOW_E"Character: {00FFFF}%s", NameUCP[playerid], CharNameUCP1[playerid], CharNameUCP2[playerid], CharNameUCP3[playerid]);
	return 1;
}
