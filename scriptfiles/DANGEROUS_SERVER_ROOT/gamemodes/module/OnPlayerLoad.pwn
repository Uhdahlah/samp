
SetPlayerSpawn(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(pData[playerid][pnewplayer] == 0)
		{
			TogglePlayerControllable(playerid,0);
			SetPlayerPos(playerid, 1761.7881,-1938.6140,13.5815);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerArmour(playerid, 0.0);
			SetCameraBehindPlayer(playerid);
			new szMiscArray[512];
			szMiscArray = "United States Of America\n\
			Singapore\n\
			Indonesia\n\
			Afganistan\n\
			Albania\n\
			Pakistan\n\
			Phillpines\n\
			Russian\n\
			Qatar\n\
			Spanish\n\
			Argentina\n\
			Arabic\n\
			Australia\n\
			Bangladesh\n\
			Brazil\n\
			Bulgaria\n\
			Canada\n\
			China\n\
			Colombia\n\
			Congo\n\
			Denmark\n\
			Italian\n\
			Germany\n\
			HongKong\n\
			India\n\
			Iran\n\
			Iraq\n\
			Jamaica\n\
			Japan\n\
			Korea\n\
			Mexico";
			ShowPlayerDialog(playerid, DIALOG_ORIGIN, DIALOG_STYLE_LIST, "Origin:", szMiscArray, "Select", "Batal");
			//ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male/Laki-Laki\n2. Female/Perempuan", "Pilih", "Batal");
		}
		else
		{
			SetPlayerColor(playerid, COLOR_WHITE);
			SetPlayerSkin(playerid, pData[playerid][pSkin]);
			if(pData[playerid][pHBEMode] == 1) //Modern
			{
				for(new i = 0; i < 34; i++)
				{
					PlayerTextDrawShow(playerid, BARTD[playerid][i]);
				}
			}
			if(pData[playerid][pOnDuty] >= 1)
			{
				SetPlayerSkin(playerid, pData[playerid][pFacSkin]);
				SetFactionColor(playerid);
			}
			if(pData[playerid][pAdminDuty] > 0)
			{
				SetPlayerColor(playerid, COLOR_RED);
			}
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid, pData[playerid][pMoney]);
			SetPlayerScore(playerid, pData[playerid][pLevel]);
			pData[playerid][pSpawned] = 1;
			TogglePlayerControllable(playerid, 1);
			SetCameraBehindPlayer(playerid);
			MySQL_LoadPlayerToys(playerid);
			SetWeapons(playerid);
			SetPlayerArmedWeapon(playerid, 0);
			SetPlayerInterior(playerid, pData[playerid][pInt]);
			SetPlayerVirtualWorld(playerid, pData[playerid][pWorld]);
			SetPlayerHealth(playerid, pData[playerid][pHealth]);
			SetPlayerArmour(playerid, pData[playerid][pArmour]);
			if(pData[playerid][pJail] > 0)
			{
				JailPlayer(playerid); 
			}
			if(pData[playerid][pArrestTime] > 0)
			{
				SetPlayerArrest(playerid, pData[playerid][pArrest]);
			}
			if(pData[playerid][pNotifSpawn] == 1)
			{
				SendClientMessageEx(playerid, COLOR_ARWIN, "[!]: "WHITE_E"Selamat datang "YELLOW_E"%s", pData[playerid][pName]);
				SendClientMessageEx(playerid, COLOR_ARWIN, "[!]: "YELLOW_E"Jika Anda mengalami bug silahkan gunakan command "RED_E"'/stuck'", pData[playerid][pLastLogin]);
				pData[playerid][pNotifSpawn] = 0;
				if(pData[playerid][pTogMask] == 1)
				{
					callcmd::togmask(playerid, "");
				}
				TextDrawHideForPlayer(playerid, Time);
				TextDrawHideForPlayer(playerid, Date);
			}
		}	
	}
}

function OnPlayerDataLoaded(playerid, race_check)
{
	new BannedReason[128], verifemail;
	if(race_check != g_MysqlRaceCheck[playerid]) return Kick(playerid);
	if(cache_num_rows() > 0)
	{
		cache_get_value_name_int(0, "reg_id", charData[playerid][cID]);
		cache_get_value_name(0, "password", charData[playerid][cPassword], 65);
		cache_get_value_name(0, "salt", charData[playerid][cSalt], 17);
		cache_get_value_name_int(0, "CharName", charData[playerid][cCharName]);
		cache_get_value_name_int(0, "CharName2", charData[playerid][cCharName2]);
		cache_get_value_name_int(0, "CharName3", charData[playerid][cCharName3]);
		cache_get_value_name_int(0, "banned", charData[playerid][cCharBan]);
		cache_get_value_name_int(0, "pin", charData[playerid][cCharPinCode]);
		cache_get_value_name(0, "bannedreason", BannedReason);
		format(charData[playerid][cCharBanReason], 128, "%s", BannedReason);
		cache_get_value_name_int(0, "verifemail", verifemail);

		SetPlayerJoinCamera(playerid);
		GetPlayerName(playerid, charData[playerid][cName], MAX_PLAYER_NAME);

		pData[playerid][IsLoggedIn] = true;
		pData[playerid][LoginAttempts] = 0;
		if(charData[playerid][cCharBan] > 0)
		{
			new String[512];
			format(String, sizeof(String), ""YELLOW_E"Your UCP account is blocked\n{00FFFF}User: %s\n{00FFFF}Reason: "WHITE_E"%s\n"YELLOW_E"Please create an unban appeal in our discrod Grelaxs Roleplay", charData[playerid][cName], BannedReason);
			ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Account Blocked", String," Ok","");
			KickEx(playerid);
		}
		else
		{
			charData[playerid][cCharOn] = 1;
			charData[playerid][cCharTime] = 60;
			new String[512];
			format(String, sizeof(String), "UCP Account: {00FFFF}%s\n"WHITE_E"Attemp: {00FFFF}%d/5\n"WHITE_E"Password: "GREEN_E"(input below)", charData[playerid][cName], pData[playerid][LoginAttempts]);
			ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login To Grelaxs Roleplay", String," Login","Exit");
		}
		if(verifemail == 0)
		{
			new String[512];
			format(String, sizeof(String), "UCP Account: {00FFFF}%s\n"WHITE_E"Attemp: {00FFFF}%d/5\n"WHITE_E"Enter the pin code sent in your discrod message!", charData[playerid][cName], pData[playerid][LoginAttempts]);
			ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "Enter the pin code", String," Enter","Exit");
		}
	}
	else
	{
		new query[103];
		mysql_format(g_SQL, query, sizeof query, "SELECT * FROM `players` WHERE `username` = '%e' LIMIT 1", charData[playerid][cName]);
		mysql_pquery(g_SQL, query, "OnPlayerDataLoaded1", "dd", playerid, g_MysqlRaceCheck[playerid]);
	}
	return 1;
}

function OnPlayerDataLoaded1(playerid, race_check)
{
	if(cache_num_rows() > 0)
	{
		cache_get_value_name(0, "ucpname", charData[playerid][cName], 52);
		new query[103];
		mysql_format(g_SQL, query, sizeof query, "SELECT * FROM `ucp` WHERE `username` = '%e' LIMIT 1", charData[playerid][cName]);
		mysql_pquery(g_SQL, query, "OnPlayerDataLoaded", "dd", playerid, g_MysqlRaceCheck[playerid]);
	}
	else
	{
		SetPlayerJoinCamera(playerid);
		new String[212];
		format(String, sizeof(String), "{FFFFFF}UCP Account: {00FFFF}%s\n"YELLOW_E"Not registered on the server", charData[playerid][cName]);
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Unregistered", String, "Ok", "");
		KickEx(playerid);
	}
	return 1;
}

function LoadPlayerChar(playerid)
{
	new query[128];
	format(query,sizeof(query),"SELECT * FROM `players` WHERE `reg_id` = '%d'",charData[playerid][cCharName]);
	mysql_tquery(g_SQL,query, "CharName", "i", playerid);
	
	format(query,sizeof(query),"SELECT * FROM `players` WHERE `reg_id` = '%d'",charData[playerid][cCharName2]);
	mysql_tquery(g_SQL,query, "CharName2", "i", playerid);

	format(query,sizeof(query),"SELECT * FROM `players` WHERE `reg_id` = '%d'",charData[playerid][cCharName3]);
	mysql_tquery(g_SQL,query, "CharName3", "i", playerid);
	charData[playerid][cCharOn] = 0;
	charData[playerid][cCharTime] = 0;
	return 1;
}

function CharName(playerid)
{
	new name[MAX_PLAYER_NAME], lastlogin[128];
 	if(cache_num_rows() > 0)
 	{
	    cache_get_value_name(0, "username", name);
		format(charData[playerid][cChar1], MAX_PLAYER_NAME, "%s", name);
		cache_get_value_name_int(0, "level", charData[playerid][cCharLevel1]);
		cache_get_value_name(0, "last_login", lastlogin);
		format(charData[playerid][cCharLastLogin1], 128, "%s", lastlogin);
 	    SetPVarInt(playerid,"Char1da",1);
 	}
	return 1;
}

function CharName2(playerid)
{
	new name[MAX_PLAYER_NAME], lastlogin[128];
 	if(cache_num_rows() > 0)
 	{
	    cache_get_value_name(0, "username", name);
		format(charData[playerid][cChar2], MAX_PLAYER_NAME, "%s", name);
		cache_get_value_name_int(0, "level", charData[playerid][cCharLevel2]);
		cache_get_value_name(0, "last_login", lastlogin);
		format(charData[playerid][cCharLastLogin2], 128, "%s", lastlogin);
 	    SetPVarInt(playerid,"Char2da",1);
 	}
	return 1;
}

function CharName3(playerid)
{
	new name[MAX_PLAYER_NAME], lastlogin[128];
 	if(cache_num_rows() > 0)
 	{
	    cache_get_value_name(0, "username", name);
		format(charData[playerid][cChar3], MAX_PLAYER_NAME, "%s", name);
		cache_get_value_name_int(0, "level", charData[playerid][cCharLevel3]);
		cache_get_value_name(0, "last_login", lastlogin);
		format(charData[playerid][cCharLastLogin3], 128, "%s", lastlogin);
 	    SetPVarInt(playerid,"Char3da",1);
 	}
	EndLoadChar(playerid);
	return 1;
}

function EndLoadChar(playerid)
{
	new String[212], S3MP4K[212],type1[128],type2[128],type3[128];
	strcat(S3MP4K, "Name\tLevel\tLast Login\n");
	if(GetPVarInt(playerid,"Char1da")==1)
	{
		format(type1, 128, charData[playerid][cChar1]);
	}
	else
	{
		format(type1, 128, "CreateChar");
	}
	if(GetPVarInt(playerid,"Char2da")==1)
	{
		format(type2, 128, charData[playerid][cChar2]);
	}
	else
	{
		format(type2, 128, "CreateChar");
	}
	if(GetPVarInt(playerid,"Char3da")==1)
	{
		format(type3, 128, charData[playerid][cChar3]);
	}
	else
	{
		format(type3, 128, "CreateChar");
	}
	format(String, sizeof(String),"%s\t%d\t%s\n", type1, charData[playerid][cCharLevel1], charData[playerid][cCharLastLogin1]);
    strcat(S3MP4K, String);
	format(String, sizeof(String),"%s\t%d\t%s\n", type2, charData[playerid][cCharLevel2], charData[playerid][cCharLastLogin2]);
    strcat(S3MP4K, String);
	format(String, sizeof(String),"%s\t%d\t%s\n", type3, charData[playerid][cCharLevel3], charData[playerid][cCharLastLogin3]);
    strcat(S3MP4K, String);
	ShowPlayerDialog(playerid,DIALOG_LOGINCHAR,DIALOG_STYLE_TABLIST_HEADERS,"Select Character",S3MP4K,"Select","Close");
}

loadPlayerChars(playerid,nummer)
{
	new query[250];
	if(nummer==1)
	{
		format(query,sizeof(query),"SELECT * FROM `players` WHERE `reg_id`='%d'", charData[playerid][cCharName]);
		mysql_tquery(g_SQL,query, "AssignPlayerData", "i", playerid);
	}
	if(nummer==2)
	{
		format(query,sizeof(query),"SELECT * FROM `players` WHERE `reg_id`='%d'", charData[playerid][cCharName2]);
		mysql_tquery(g_SQL,query, "AssignPlayerData", "i", playerid);
	}
	if(nummer==3)
	{
		format(query,sizeof(query),"SELECT * FROM `players` WHERE `reg_id`='%d'", charData[playerid][cCharName3]);
		mysql_tquery(g_SQL,query, "AssignPlayerData", "i", playerid);
	}
	return 1;
}

function AssignPlayerData(playerid)
{
	new name[MAX_PLAYER_NAME], aname[MAX_PLAYER_NAME], married[50], age[128], ip[128], regdate[50], lastlogin[50], banby[128], banreason[128];
	
	cache_get_value_name_int(0, "reg_id", pData[playerid][pID]);	
	cache_get_value_name(0, "username", name);
	format(pData[playerid][pName], MAX_PLAYER_NAME, "%s", name);
	cache_get_value_name(0, "adminname", aname);
	format(pData[playerid][pAdminname], MAX_PLAYER_NAME, "%s", aname);
	cache_get_value_name(0, "ip", ip);
	format(pData[playerid][pIP], 128, "%s", ip);
	cache_get_value_name_int(0, "admin", pData[playerid][pAdmin]);
	cache_get_value_name_int(0, "helper", pData[playerid][pHelper]);
	cache_get_value_name_int(0, "level", pData[playerid][pLevel]);
	cache_get_value_name_int(0, "levelup", pData[playerid][pLevelUp]);
	cache_get_value_name_int(0, "cschar", pData[playerid][pCS]);
	cache_get_value_name_int(0, "vip", pData[playerid][pVip]);
	cache_get_value_name_int(0, "vip_time", pData[playerid][pVipTime]);
	cache_get_value_name_int(0, "gold", pData[playerid][pGold]);
	cache_get_value_name(0, "reg_date", regdate);
	format(pData[playerid][pRegDate], 128, "%s", regdate);
	cache_get_value_name(0, "last_login", lastlogin);
	format(pData[playerid][pLastLogin], 128, "%s", lastlogin);
	cache_get_value_name_int(0, "money", pData[playerid][pMoney]);
	cache_get_value_name_int(0, "bmoney", pData[playerid][pBankMoney]);
	cache_get_value_name_int(0, "brek", pData[playerid][pBankRek]);
	cache_get_value_name_int(0, "phone", pData[playerid][pPhone]);
	cache_get_value_name_int(0, "phonecredit", pData[playerid][pPhoneCredit]);
	cache_get_value_name_int(0, "wt", pData[playerid][pWT]);
	cache_get_value_name_int(0, "hours", pData[playerid][pHours]);
	cache_get_value_name_int(0, "minutes", pData[playerid][pMinutes]);
	cache_get_value_name_int(0, "seconds", pData[playerid][pSeconds]);
	cache_get_value_name_int(0, "paycheck", pData[playerid][pPaycheck]);
	cache_get_value_name_int(0, "skin", pData[playerid][pSkin]);
	cache_get_value_name_int(0, "facskin", pData[playerid][pFacSkin]);
	cache_get_value_name_int(0, "gender", pData[playerid][pGender]);
	cache_get_value_name_int(0, "newp", pData[playerid][pnewplayer]);
	cache_get_value_name(0, "age", age);
	format(pData[playerid][pAge], 128, "%s", age);
	cache_get_value_name_int(0, "indoor", pData[playerid][pInDoor]);
	cache_get_value_name_int(0, "inhouse", pData[playerid][pInHouse]);
	cache_get_value_name_int(0, "inbiz", pData[playerid][pInBiz]);
	cache_get_value_name_float(0, "posx", pData[playerid][pPosX]);
	cache_get_value_name_float(0, "posy", pData[playerid][pPosY]);
	cache_get_value_name_float(0, "posz", pData[playerid][pPosZ]);
	cache_get_value_name_float(0, "posa", pData[playerid][pPosA]);
	cache_get_value_name_int(0, "interior", pData[playerid][pInt]);
	cache_get_value_name_int(0, "world", pData[playerid][pWorld]);
	cache_get_value_name_float(0, "health", pData[playerid][pHealth]);
	cache_get_value_name_float(0, "armour", pData[playerid][pArmour]);
	cache_get_value_name_int(0, "hunger", pData[playerid][pHunger]);
	cache_get_value_name_int(0, "energy", pData[playerid][pEnergy]);
	cache_get_value_name_int(0, "sick", pData[playerid][pSick]);
	cache_get_value_name_int(0, "hospital", pData[playerid][pHospital]);
	cache_get_value_name_int(0, "injured", pData[playerid][pInjured]);
	cache_get_value_name_int(0, "duty", pData[playerid][pOnDuty]);
	cache_get_value_name_int(0, "dutytime", pData[playerid][pOnDutyTime]);
	cache_get_value_name_int(0, "faction", pData[playerid][pFaction]);
	cache_get_value_name_int(0, "factionrank", pData[playerid][pFactionRank]);
	cache_get_value_name_int(0, "factionlead", pData[playerid][pFactionLead]);
	cache_get_value_name_int(0, "family", pData[playerid][pFamily]);
	cache_get_value_name_int(0, "familyrank", pData[playerid][pFamilyRank]);
	cache_get_value_name_int(0, "jail", pData[playerid][pJail]);
	cache_get_value_name_int(0, "jail_time", pData[playerid][pJailTime]);
	cache_get_value_name_int(0, "arrest", pData[playerid][pArrest]);
	cache_get_value_name_int(0, "arrest_time", pData[playerid][pArrestTime]);
	cache_get_value_name_int(0, "warn", pData[playerid][pWarn]);
	cache_get_value_name_int(0, "job", pData[playerid][pJob]);
	cache_get_value_name_int(0, "job2", pData[playerid][pJob2]);
	cache_get_value_name_int(0, "jobtime", pData[playerid][pJobTime]);
	cache_get_value_name_int(0, "sidejobtime", pData[playerid][pSideJobTime]);
	cache_get_value_name_int(0, "exitjob", pData[playerid][pExitJob]);
	cache_get_value_name_int(0, "taxitime", pData[playerid][pTaxiTime]);
	cache_get_value_name_int(0, "medicine", pData[playerid][pMedicine]);
	cache_get_value_name_int(0, "medkit", pData[playerid][pMedkit]);
	cache_get_value_name_int(0, "mask", pData[playerid][pMask]);
	cache_get_value_name_int(0, "helmet", pData[playerid][pHelmet]);
	cache_get_value_name_int(0, "snack", pData[playerid][pSnack]);
	cache_get_value_name_int(0, "sprunk", pData[playerid][pSprunk]);
	cache_get_value_name_int(0, "gas", pData[playerid][pGas]);
	cache_get_value_name_int(0, "bandage", pData[playerid][pBandage]);
	cache_get_value_name_int(0, "gps", pData[playerid][pGPS]);
	cache_get_value_name_int(0, "material", pData[playerid][pMaterial]);
	cache_get_value_name_int(0, "component", pData[playerid][pComponent]);
	cache_get_value_name_int(0, "food", pData[playerid][pFood]);
	cache_get_value_name_int(0, "seedwheat", pData[playerid][pSeedWheat]);
	cache_get_value_name_int(0, "seedonion", pData[playerid][pSeedOnion]);
	cache_get_value_name_int(0, "seedcarrot", pData[playerid][pSeedCarrot]);
	cache_get_value_name_int(0, "seedpotato", pData[playerid][pSeedPotato]);
	cache_get_value_name_int(0, "seedcorn", pData[playerid][pSeedCorn]);
	cache_get_value_name_int(0, "wheat", pData[playerid][pWheat]);
	cache_get_value_name_int(0, "onion", pData[playerid][pOnion]);
	cache_get_value_name_int(0, "carrot", pData[playerid][pCarrot]);
	cache_get_value_name_int(0, "potato", pData[playerid][pPotato]);
	cache_get_value_name_int(0, "corn", pData[playerid][pCorn]);
	cache_get_value_name_int(0, "price1", pData[playerid][pPrice1]);
	cache_get_value_name_int(0, "price2", pData[playerid][pPrice2]);
	cache_get_value_name_int(0, "price3", pData[playerid][pPrice3]);
	cache_get_value_name_int(0, "price4", pData[playerid][pPrice4]);
	cache_get_value_name_int(0, "crack", pData[playerid][pCrack]);
	cache_get_value_name_int(0, "pot", pData[playerid][pPot]);
	cache_get_value_name_int(0, "plant", pData[playerid][pPlant]);
	cache_get_value_name_int(0, "plant_time", pData[playerid][pPlantTime]);
	cache_get_value_name_int(0, "fishtool", pData[playerid][pFishTool]);
	cache_get_value_name_int(0, "fish", pData[playerid][pFish]);
	cache_get_value_name_int(0, "fish1", pData[playerid][pFish1]);
	cache_get_value_name_int(0, "fish2", pData[playerid][pFish2]);
	cache_get_value_name_int(0, "fish3", pData[playerid][pFish3]);
	cache_get_value_name_int(0, "fish4", pData[playerid][pFish4]);
	cache_get_value_name_int(0, "fishmax", pData[playerid][pFishMax]);
	cache_get_value_name_int(0, "worm", pData[playerid][pWorm]);
	cache_get_value_name_int(0, "drivelic", pData[playerid][pDriveLic]);
	cache_get_value_name_int(0, "drivelic_time", pData[playerid][pDriveLicTime]);
	cache_get_value_name_int(0, "flylic", pData[playerid][pFlyLic]);
	cache_get_value_name_int(0, "flylic_time", pData[playerid][pFlyLicTime]);
	cache_get_value_name_int(0, "boatlic", pData[playerid][pBoatLic]);
	cache_get_value_name_int(0, "boatlic_time", pData[playerid][pBoatLicTime]);
	cache_get_value_name_int(0, "gunlic", pData[playerid][pGunLic]);
	cache_get_value_name_int(0, "gunlic_time", pData[playerid][pGunLicTime]);
	cache_get_value_name_int(0, "trucker", pData[playerid][pTruckerLic]);
	cache_get_value_name_int(0, "trucker_time", pData[playerid][pTruckerLicTime]);
	cache_get_value_name_int(0, "lumber", pData[playerid][pLumberLic]);
	cache_get_value_name_int(0, "lumber_time", pData[playerid][pLumberLicTime]);
	cache_get_value_name_int(0, "hbemode", pData[playerid][pHBEMode]);
	cache_get_value_name_int(0, "togpm", pData[playerid][pTogPM]);
	cache_get_value_name_int(0, "togads", pData[playerid][pTogAds]);
	cache_get_value_name_int(0, "togwt", pData[playerid][pTogWT]);
	cache_get_value_name_int(0, "togradio", pData[playerid][pTogRadio]);
	cache_get_value_name_int(0, "togpaycheck", pData[playerid][pTogPaycheck]);
	cache_get_value_name_int(0, "togseatbelt", pData[playerid][pTogSealtbelt]);
	cache_get_value_name_int(0, "togchat", pData[playerid][pTogChat]);
	cache_get_value_name_int(0, "toghelmet", pData[playerid][pTogHelmet]);
	cache_get_value_name_int(0, "togmask", pData[playerid][pTogMask]);
	cache_get_value_name_int(0, "togammo", pData[playerid][pTogAmmo]);

	cache_get_value_name_int(0, "Gun1", pData[playerid][pGuns][0]);
	cache_get_value_name_int(0, "Gun2", pData[playerid][pGuns][1]);
	cache_get_value_name_int(0, "Gun3", pData[playerid][pGuns][2]);
	cache_get_value_name_int(0, "Gun4", pData[playerid][pGuns][3]);
	cache_get_value_name_int(0, "Gun5", pData[playerid][pGuns][4]);
	cache_get_value_name_int(0, "Gun6", pData[playerid][pGuns][5]);
	cache_get_value_name_int(0, "Gun7", pData[playerid][pGuns][6]);
	cache_get_value_name_int(0, "Gun8", pData[playerid][pGuns][7]);
	cache_get_value_name_int(0, "Gun9", pData[playerid][pGuns][8]);
	cache_get_value_name_int(0, "Gun10", pData[playerid][pGuns][9]);
	cache_get_value_name_int(0, "Gun11", pData[playerid][pGuns][10]);
	cache_get_value_name_int(0, "Gun12", pData[playerid][pGuns][11]);
	cache_get_value_name_int(0, "Gun13", pData[playerid][pGuns][12]);
	
	cache_get_value_name_int(0, "Ammo1", pData[playerid][pAmmo][0]);
	cache_get_value_name_int(0, "Ammo2", pData[playerid][pAmmo][1]);
	cache_get_value_name_int(0, "Ammo3", pData[playerid][pAmmo][2]);
	cache_get_value_name_int(0, "Ammo4", pData[playerid][pAmmo][3]);
	cache_get_value_name_int(0, "Ammo5", pData[playerid][pAmmo][4]);
	cache_get_value_name_int(0, "Ammo6", pData[playerid][pAmmo][5]);
	cache_get_value_name_int(0, "Ammo7", pData[playerid][pAmmo][6]);
	cache_get_value_name_int(0, "Ammo8", pData[playerid][pAmmo][7]);
	cache_get_value_name_int(0, "Ammo9", pData[playerid][pAmmo][8]);
	cache_get_value_name_int(0, "Ammo10", pData[playerid][pAmmo][9]);
	cache_get_value_name_int(0, "Ammo11", pData[playerid][pAmmo][10]);
	cache_get_value_name_int(0, "Ammo12", pData[playerid][pAmmo][11]);
	cache_get_value_name_int(0, "Ammo13", pData[playerid][pAmmo][12]);
	cache_get_value_name_int(0, "pbanned", pData[playerid][pBanned]);
    cache_get_value_name(0, "pbanreason", banreason);
	format(pData[playerid][pBanReason], 128, "%s", banreason);
	cache_get_value_name(0, "pbanby", banby);
	format(pData[playerid][pBanBy], 128, "%s", banby);
	cache_get_value_name_int(0, "workshop", pData[playerid][pWorkshop]);
	cache_get_value_name_int(0, "workshoprank", pData[playerid][pWorkshopRank]);
	cache_get_value_name_int(0, "sidejobtimesweap", pData[playerid][pSideJobTimeSweap]);
	cache_get_value_name_int(0, "sidejobtimebus", pData[playerid][pSideJobTimeBus]);
    cache_get_value_name_int(0, "haulingtime", pData[playerid][pHaulingTime]);
    cache_get_value_name_int(0, "rokok", pData[playerid][pRokok]);
    cache_get_value_name_int(0, "cgun", pData[playerid][pCgun]);
    cache_get_value_name_int(0, "trashtime", pData[playerid][pSideJobsTrash]);
    cache_get_value_name_int(0, "forklifttime", pData[playerid][pSideJobsForklift]);
    cache_get_value_name_int(0, "smugglertime", pData[playerid][pJobSmugglerTime]);
	cache_get_value_name_int(0, "fightstyle", pData[playerid][FightStyle]);
	cache_get_value_name_int(0, "leveltrucker", pData[playerid][LevelTrucker]);
	cache_get_value_name_int(0, "married", pData[playerid][pMarried]);
	cache_get_value_name(0, "marriedto", married);
	format(pData[playerid][pMarriedTo], 50, married);
	cache_get_value_name_int(0, "paytoll", pData[playerid][pPayToll]);
	cache_get_value_name_int(0, "levelfishing", pData[playerid][LevelFishing]);
	cache_get_value_name_int(0, "delaytruckdeli", pData[playerid][pDelayTruckerDeli]);
	cache_get_value_name_int(0, "delayfishing", pData[playerid][pDelayFishing]);
	cache_get_value_name_int(0, "apart", pData[playerid][pApart]);
	cache_get_value_name_int(0, "ladang", pData[playerid][pLadang]);
	cache_get_value_name_int(0, "ladangrank", pData[playerid][pLadangRank]);
	cache_get_value_name_int(0, "maskid", pData[playerid][pMaskID]);
	cache_get_value_name_int(0, "adsdelay", pData[playerid][pAdsTime]);
	cache_get_value_name_int(0, "inapart", pData[playerid][pInApart]);
	cache_get_value_name_int(0, "indoorflat", pData[playerid][pInDoorFlat]);
	cache_get_value_name_int(0, "mutewt", pData[playerid][pMuteWt]);
	cache_get_value_name_int(0, "skillbuilder", pData[playerid][pSkillBuilder]);
	cache_get_value_name_int(0, "skillmecha", pData[playerid][pSkillMecha]);
	cache_get_value_name_int(0, "rentveh", pData[playerid][pRents]);
	cache_get_value_name_int(0, "accent", pData[playerid][pAccent1]);
	cache_get_value_name_int(0, "furnstore", pData[playerid][pFurnStore]);

	SetPlayerName(playerid, name);
	for (new i; i < 17; i++)
	{
		WeaponSettings[playerid][i][Position][0] = -0.116;
		WeaponSettings[playerid][i][Position][1] = 0.189;
		WeaponSettings[playerid][i][Position][2] = 0.088;
		WeaponSettings[playerid][i][Position][3] = 0.0;
		WeaponSettings[playerid][i][Position][4] = 44.5;
		WeaponSettings[playerid][i][Position][5] = 0.0;
		WeaponSettings[playerid][i][Bone] = 1;
		WeaponSettings[playerid][i][Hidden] = false;
	}
	WeaponTick[playerid] = 0;
	EditingWeapon[playerid] = 0;
	new string[128];
	mysql_format(g_SQL, string, sizeof(string), "SELECT * FROM weaponsettings WHERE Owner = '%d'", pData[playerid][pID]);
	mysql_tquery(g_SQL, string, "OnWeaponsLoaded", "d", playerid);

    mysql_format(g_SQL, string, sizeof(string), "SELECT * FROM contacts WHERE ID = '%d'", pData[playerid][pID]);
	mysql_tquery(g_SQL, string, "OnContactsLoad", "d", playerid);	

	KillTimer(pData[playerid][LoginTimer]);
	pData[playerid][LoginTimer] = 0;
	pData[playerid][IsLoggedIn] = true;
	SetSpawnInfo(playerid, NO_TEAM, pData[playerid][pSkin], pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ], pData[playerid][pPosA], 0, 0, 0, 0, 0, 0);
	SpawnPlayer(playerid);	
	SetPlayerPos(playerid, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]);	
	LoadPlayerVehicle(playerid);
	pData[playerid][pNotifSpawn] = 1;
	if(pData[playerid][pID] < 1)
	{
		Error(playerid, "Database player not found!");
		KickEx(playerid);
		return 1;
	}
	
	return 1;
}
