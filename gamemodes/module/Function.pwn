// Anti DDOS
function AntiDDoS()
{
	new string[128];
	new strarr[2][20];

	new pos = strfind(string, "Invalid client connecting from ", true, 10);
	if(pos == 11)
	{
		OnDDosAttackAttempt(ATTACK_TYPE_IP, INVALID_PLAYER_ID, string[pos+31]);
	}

	pos = strfind(string, "Warning: /rcon command exploit from: ", true, 10);
	if(pos == 11){
		split(string[pos+37], strarr, ':');
		OnDDosAttackAttempt(ATTACK_TYPE_PLAYERID, strval(strarr[0]), strarr[1]);
	}

	pos = strfind(string, "Warning: PlayerDialogResponse PlayerId: ", true, 10);
	if(pos == 11){
		new idx = 0;
		new plid = strval(strtok(string[pos+39], idx));
		SetPVarInt(plid, "dialogDDosAtt", GetPVarInt(plid, "dialogDDosAtt")+1);
		print("");
		if(GetPVarInt(plid, "dialogDDosAtt") > 2)OnDDosAttackAttempt(ATTACK_TYPE_PLAYERID, plid, " ");
	}

	pos = strfind(string, "Warning: PlayerDialogResponse crash exploit from PlayerId: ", true, 10);
	if(pos == 11){
		new idx = 0;
		OnDDosAttackAttempt(ATTACK_TYPE_PLAYERID, strval(strtok(string[pos+59], idx)), " ");
	}

	pos = strfind(string, "Packet was modified, sent by id: ", true, 10);
	if(pos == 11){
	    split(string[pos+33], strarr, ',');
		OnDDosAttackAttempt(ATTACK_TYPE_PLAYERID, strval(strarr[0]), " ");
	}

	pos = strfind(string, "Remote Port Refused for Player: ", true, 10);
	if(pos == 11){
		new idx = 0;
		OnDDosAttackAttempt(ATTACK_TYPE_PLAYERID, strval(strtok(string[pos+32], idx)), " ");
	}

	if(strfind(string, " due to a 'server full' attack") != -1)
	{
		pos = strfind(string, "Blocking ", true, 10);
		if(pos == 12)
		{
			new idx = 0;
			OnDDosAttackAttempt(ATTACK_TYPE_IP, INVALID_PLAYER_ID, strtok(string[pos+9], idx));
		}
	}
}


function OnDDosAttackAttempt(type, playerid, ip[])
{
    new string[128];
	if(type == ATTACK_TYPE_PLAYERID)
	{//block a playerid
		BanEx(playerid, "DDOS protect");
		printf("Blocked attack from playerid %d", playerid);

	}else if(type == ATTACK_TYPE_IP)
	{//block an ip address
        format(string, sizeof(string), "banip %s", ip);
		SendRconCommand(string);
		printf("Blocked attack from ip: %s", ip);
	}

}

//----------[ Function Login Register]----------

function CreateChar(playerid, name[])
{
	if(cache_num_rows() > 0)
	{
		Error(playerid, "Nama tersebut sudah di gunakan player lain");
		ShowPlayerDialog(playerid, DIALOG_CREATECHARNEW1, DIALOG_STYLE_INPUT, "Username Character","Masukan Username yang mau anda gunakan","Next","Close");
	}
	else
	{
		format(pData[playerid][pName], 50, name);
		ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Tanggal Lahir", "Masukan tanggal lahir (Tgl/Bulan/Tahun): 15/04/1998", "Enter", "Batal");
	}
	print("test");
    return 1;
}

function OnPlayerRegisterChar(playerid)
{
	pData[playerid][pID] = cache_insert_id();
	if(GetPVarInt(playerid,"CreateChar1")==1)
	{
	    charData[playerid][cCharName]=pData[playerid][pID];
		new cQuery[3048];
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "UPDATE `ucp` SET ");
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`CharName` = '%d' ", cQuery, pData[playerid][pID]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%sWHERE `username` = '%s'", cQuery, charData[playerid][cName]);
		mysql_tquery(g_SQL, cQuery);
	}
	if(GetPVarInt(playerid,"CreateChar2")==1)
	{
	    charData[playerid][cCharName2]=pData[playerid][pID];
		new cQuery[3048];
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "UPDATE `ucp` SET ");
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`CharName2` = '%d' ", cQuery, pData[playerid][pID]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%sWHERE `username` = '%s'", cQuery, charData[playerid][cName]);
		mysql_tquery(g_SQL, cQuery);
	}
	if(GetPVarInt(playerid,"CreateChar3")==1)
	{
		charData[playerid][cCharName3]=pData[playerid][pID];
		new cQuery[3048];
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "UPDATE `ucp` SET ");
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`CharName3` = '%d' ", cQuery, pData[playerid][pID]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%sWHERE `username` = '%s'", cQuery, charData[playerid][cName]);
		mysql_tquery(g_SQL, cQuery);
	}
	pData[playerid][pnewplayer] = 0;
	pData[playerid][pPosX] = 1745.8828;
	pData[playerid][pPosY] = -1860.8129;
	pData[playerid][pPosZ] = 13.5783;
	pData[playerid][pPosA] = 90.0000;
	pData[playerid][pInt] = 0;
	pData[playerid][pWorld] = 0;
	
	format(pData[playerid][pAdminname], MAX_PLAYER_NAME, "None");
	pData[playerid][pHealth] = 100.0;
	pData[playerid][pArmour] = 0.0;
	pData[playerid][pLevel] = 1;
	pData[playerid][pHunger] = 100;
	pData[playerid][pEnergy] = 100;
	pData[playerid][pMoney] = 5000;
	pData[playerid][pBankMoney] = 10000;
	
	new query[128], rand = RandomEx(111111, 999999);
	new rek = rand+pData[playerid][pID];
	mysql_format(g_SQL, query, sizeof(query), "SELECT brek FROM players WHERE brek='%d'", rek);
	mysql_tquery(g_SQL, query, "BankRek", "id", playerid, rek);
	UpdatePlayerData(playerid);	
	
	SetSpawnInfo(playerid, NO_TEAM, 0, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ], pData[playerid][pPosA], 0, 0, 0, 0, 0, 0);
	SpawnPlayer(playerid);
	return 1;
}

function GiveWeapEmpty(playerid, weaponid)
{
	GivePlayerWeaponEx(playerid, weaponid, 0);
}

function KickOffPD(playerid, NamaUntukDiKick[])
{
	if(cache_num_rows() < 1)
	{
		return Error(playerid, "Account "GREY2_E"'%s' "WHITE_E"does not exist.", NamaUntukDiKick);
	}
	else
	{
	    new RegID;
		new rank = 0;
		new family = 0;
		new leader = 0;
		cache_get_value_index_int(0, 0, RegID);
		new query[512];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET faction=%d, factionrank=%d, factionlead=%d WHERE reg_id=%d", family, rank, leader, RegID);
		mysql_tquery(g_SQL, query);
	}
	return 1;
}

function KickOffWS(playerid, NamaUntukDiKick[])
{
	if(cache_num_rows() < 1)
	{
		return Error(playerid, "Account "GREY2_E"'%s' "WHITE_E"does not exist.", NamaUntukDiKick);
	}
	else
	{
	    new RegID;
		new rank = 0;
		new family = 0;
		cache_get_value_index_int(0, 0, RegID);
		new query[512];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET workshop=%d, workshoprank=%d, WHERE reg_id=%d", family, rank, RegID);
		mysql_tquery(g_SQL, query);
	}
	return 1;
}


function KickOffSAGS(playerid, NamaUntukDiKick[])
{
	if(cache_num_rows() < 1)
	{
		return Error(playerid, "Account "GREY2_E"'%s' "WHITE_E"does not exist.", NamaUntukDiKick);
	}
	else
	{
	    new RegID;
		new rank = 0;
		new family = 0;
		new leader = 0;
		cache_get_value_index_int(0, 0, RegID);
		new query[512];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET faction=%d, factionrank=%d, factionlead=%d WHERE reg_id=%d", family, rank, leader, RegID);
		mysql_tquery(g_SQL, query);
	}
	return 1;
}

function KickOffSAMD(playerid, NamaUntukDiKick[])
{
	if(cache_num_rows() < 1)
	{
		return Error(playerid, "Account "GREY2_E"'%s' "WHITE_E"does not exist.", NamaUntukDiKick);
	}
	else
	{
	    new RegID;
		new rank = 0;
		new family = 0;
		new leader = 0;
		cache_get_value_index_int(0, 0, RegID);
		new query[512];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET faction=%d, factionrank=%d, factionlead=%d WHERE reg_id=%d", family, rank, leader, RegID);
		mysql_tquery(g_SQL, query);
	}
	return 1;
}

function KickOffNEWS(playerid, NamaUntukDiKick[])
{
	if(cache_num_rows() < 1)
	{
		return Error(playerid, "Account "GREY2_E"'%s' "WHITE_E"does not exist.", NamaUntukDiKick);
	}
	else
	{
	    new RegID;
		new rank = 0;
		new family = 0;
		new leader = 0;
		cache_get_value_index_int(0, 0, RegID);
		new query[512];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET faction=%d, factionrank=%d, factionlead=%d WHERE reg_id=%d", family, rank, leader, RegID);
		mysql_tquery(g_SQL, query);
	}
	return 1;
}

function UnbanByIrwan(adminid, NamaUntukDiUnban[], ReasonUnban[])
{
	if(cache_num_rows() < 1)
	{
		return Error(adminid, "Account "GREY2_E"'%s' "WHITE_E"does not exist.", NamaUntukDiUnban);
	}
	else
	{
	    new RegID;
	    new unbannedbyirwan = 0;
		cache_get_value_index_int(0, 0, RegID);
		SendClientMessageToAllEx(COLOR_RED, "Admcmd: "GREY2_E"Admin %s telah meng-unbanned player %s", pData[adminid][pAdminname], NamaUntukDiUnban);
		SendClientMessageToAllEx(COLOR_RED, "Admcmd: "GREY2_E"Reason: %s", ReasonUnban);
		new query[512];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET pbanned=%d WHERE reg_id=%d", unbannedbyirwan, RegID);
		mysql_tquery(g_SQL, query);
	}
	return 1;
}

function SetName(otherplayer, playerid, nname[])
{
	if(!cache_num_rows())
	{
		new oldname[24], newname[24], query[248];
		GetPlayerName(otherplayer, oldname, sizeof(oldname));

		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET username='%s' WHERE reg_id=%d", nname, pData[otherplayer][pID]);
		mysql_tquery(g_SQL, query);

		Servers(otherplayer, "Admin %s telah mengganti nickname anda menjadi (%s)", pData[playerid][pAdminname], nname);
		SendClientMessageEx(otherplayer, COLOR_ARWIN, "NICKNAME: "WHITE_E"Pastikan anda mengingat dan mengganti nickname anda pada saat login kembali!");
		SendStaffMessage(COLOR_RED, "Admin %s telah mengganti nickname player %s(%d) menjadi %s", pData[playerid][pAdminname], oldname, otherplayer, nname);

		SetPlayerName(otherplayer, nname);
		GetPlayerName(otherplayer, newname, sizeof(newname));
		pData[otherplayer][pName] = newname;
		// House
		foreach(new h : Houses)
		{
			if(!strcmp(hData[h][hOwner], oldname, true))
   			{
   			    // Has House
   			    format(hData[h][hOwner], 24, "%s", newname);
          		mysql_format(g_SQL, query, sizeof(query), "UPDATE houses SET owner='%s' WHERE ID=%d", newname, h);
				mysql_tquery(g_SQL, query);
				House_Refresh(h);
				House_Save(h);
			}
		}
		// Bisnis
		foreach(new b : Bisnis)
		{
			if(!strcmp(bData[b][bOwner], oldname, true))
   			{
   			    // Has Business
   			    format(bData[b][bOwner], 24, "%s", newname);
          		mysql_format(g_SQL, query, sizeof(query), "UPDATE bisnis SET owner='%s' WHERE ID=%d", newname, b);
				mysql_tquery(g_SQL, query);
				Bisnis_Refresh(b);
				Bisnis_Save(b);
			}
		}
		if(pData[otherplayer][PurchasedToy] == true)
		{
			mysql_format(g_SQL, query, sizeof(query), "UPDATE toys SET Owner='%s' WHERE Owner='%s'", newname, oldname);
			mysql_tquery(g_SQL, query);
		}
	}
	else
	{
	    // Name Exists
		Error(playerid, "The name "DARK_E"'%s' "WHITE_E"already exists in the database, please use a different name!", nname);
	}
    return 1;
}

function PhoneNumberUpdate(playerid, phone)
{
	if(!cache_num_rows())
	{
		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET phone='%d' WHERE reg_id=%d", phone, pData[playerid][pID]);
		mysql_tquery(g_SQL, query);
		pData[playerid][pPhone] = phone;
		pData[playerid][pGold] -= 150;
		SendClientMessageEx(playerid, COLOR_ARWIN, "GOLD: "WHITE_E"No Phone anda telah di ubah menjadi "YELLOW_E"%d", phone);
	}
	else
	{
	    // Name Exists
		Error(playerid, "The Phone Number "DARK_E"'%d' "WHITE_E"already exists in the database, please use a different name!", phone);
		return 1;
	}
	return true;
}

function ChangeMask(playerid, mask)
{
	if(!cache_num_rows())
	{
		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET mask='%d' WHERE reg_id=%d", mask, pData[playerid][pID]);
		mysql_tquery(g_SQL, query);
		pData[playerid][pMaskID] = mask;
		pData[playerid][pGold] -= 250;
		SendClientMessageEx(playerid, COLOR_ARWIN, "GOLD: "WHITE_E"No Mask anda telah di ubah menjadi "YELLOW_E"%d", mask);
	}
	else
	{
	    // Name Exists
		Error(playerid, "The Mask Number "DARK_E"'%d' "WHITE_E"already exists in the database, please use a different name!", mask);
		return 1;
	}
	return true;
}

function ChangeName(playerid, nname[])
{
	if(!cache_num_rows())
	{
		if(pData[playerid][pGold] < 500) return Error(playerid, "Not enough gold!");
		pData[playerid][pGold] -= 500;

		new oldname[24], newname[24], query[248];
		GetPlayerName(playerid, oldname, sizeof(oldname));

		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET username='%s' WHERE reg_id=%d", nname, pData[playerid][pID]);
		mysql_tquery(g_SQL, query);

		Servers(playerid, "Anda telah mengganti nickname anda menjadi (%s)", nname);
		SendClientMessageEx(playerid, COLOR_ARWIN, "NICKNAME: "WHITE_E"Pastikan anda mengingat dan mengganti nickname anda pada saat login kembali!");
		SendStaffMessage(COLOR_RED, "Player %s(%d) telah mengganti nickname menjadi %s(%d)", oldname, playerid, nname, playerid);

		SetPlayerName(playerid, nname);
		GetPlayerName(playerid, newname, sizeof(newname));
		pData[playerid][pName] = newname;
		// House
		foreach(new h : Houses)
		{
			if(!strcmp(hData[h][hOwner], oldname, true))
   			{
   			    // Has House
   			    format(hData[h][hOwner], 24, "%s", newname);
          		mysql_format(g_SQL, query, sizeof(query), "UPDATE houses SET owner='%s' WHERE ID=%d", newname, h);
				mysql_tquery(g_SQL, query);
				House_Refresh(h);
				House_Save(h);
			}
		}
		// Bisnis
		foreach(new b : Bisnis)
		{
			if(!strcmp(bData[b][bOwner], oldname, true))
   			{
   			    // Has Business
   			    format(bData[b][bOwner], 24, "%s", newname);
          		mysql_format(g_SQL, query, sizeof(query), "UPDATE bisnis SET owner='%s' WHERE ID=%d", newname, b);
				mysql_tquery(g_SQL, query);
				Bisnis_Refresh(b);
				Bisnis_Save(b);
			}
		}
		if(pData[playerid][PurchasedToy] == true)
		{
			mysql_format(g_SQL, query, sizeof(query), "UPDATE toys SET Owner='%s' WHERE Owner='%s'", newname, oldname);
			mysql_tquery(g_SQL, query);
		}
	}
	else
	{
	    // Name Exists
		Error(playerid, "The name "DARK_E"'%s' "WHITE_E"already exists in the database, please use a different name!", nname);
		return 1;
	}
    return 1;
}

function ChangePlayerPassword(admin, cPlayer[], newpass[])
{
	if(cache_num_rows() > 0)
	{
		new query[512], pass[65], salt[16];
		Servers(admin, "Password for %s has been set to \"%s\"", cPlayer, newpass);

		for (new i = 0; i < 16; i++) salt[i] = random(94) + 33;
		SHA256_PassHash(newpass, salt, pass, 65);

		mysql_format(g_SQL, query, sizeof(query), "UPDATE ucp SET password='%s', salt='%e' WHERE username='%s'", pass, salt, cPlayer);
		mysql_tquery(g_SQL, query);
	}
	else
	{
	    // Name Exists
		Error(admin, "The name"DARK_E"'%s' "WHITE_E"doesn't exist in the database!", cPlayer);
	}
    return 1;
}

function OWarnPlayer(adminid, NameToWarn[], warnReason[])
{
	if(cache_num_rows() < 1)
	{
		return Error(adminid, "Account "GREY2_E"'%s' "WHITE_E"does not exist.", NameToWarn);
	}
	else
	{
	    new RegID, warn;
		cache_get_value_index_int(0, 0, RegID);
		cache_get_value_index_int(0, 1, warn);
		SendClientMessageToAllEx(COLOR_RED, "Admcmd: "GREY2_E"Admin %s telah memberi warning(offline) player %s", pData[adminid][pAdminname], NameToWarn);
        SendClientMessageToAllEx(COLOR_RED, "Admcmd: "GREY2_E"Reason: %s", warnReason);
		new query[512];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET warn=%d WHERE reg_id=%d", warn+1, RegID);
		mysql_tquery(g_SQL, query);
	}
	return 1;
}

function OfflineMask(adminid, NameToWarn)
{
	if(cache_num_rows() < 1)
	{
		return Error(adminid, "Mask "GREY2_E"'%d' "WHITE_E"does not exist.", NameToWarn);
	}
	else
	{
	    new RegID;
		cache_get_value_index_int(0, 0, RegID);
		new Cache:checkMask, query[128];
		format(query, sizeof(query), "SELECT * FROM `username` WHERE `reg_id`='%d'", RegID);
		checkMask = mysql_query(g_SQL, query);
		
		new rows = cache_num_rows(), fname[128];
		
		if(rows)
		{
			new fam[128];
			cache_get_value_name(0, "username", fam);
			format(fname, 128, fam);
		}
		SendClientMessageEx(adminid, COLOR_ARWIN,"MASK: "WHITE_E"Username "YELLOW_E"%s "WHITE_E"MaskID"YELLOW_E"%d", fname, NameToWarn);
		cache_delete(checkMask);
	}
	return 1;
}

function OJailPlayer(adminid, NameToJail[], jailReason[], jailTime)
{
	if(cache_num_rows() < 1)
	{
		return Error(adminid, "Account "GREY2_E"'%s' "WHITE_E"does not exist.", NameToJail);
	}
	else
	{
	    new fixbugjailbyirwan = 1;
	    new RegID, JailMinutes = jailTime * 60;
		cache_get_value_index_int(0, 0, RegID);

		SendClientMessageToAllEx(COLOR_RED, "AdmCmd: "GREY2_E"Admin %s telah menjail(offline) player %s selama %d menit", pData[adminid][pAdminname], NameToJail, jailTime);
		SendClientMessageToAllEx(COLOR_RED, "AdmCmd: "GREY2_E"Reason: %s", jailReason);
		new query[512];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET jail=%d, jail_time=%d WHERE reg_id=%d", fixbugjailbyirwan, JailMinutes, RegID);
		mysql_tquery(g_SQL, query);
	}
	return 1;
}

function Unverifplayer(adminid, NameToUnverif[])
{
	if(cache_num_rows() < 1)
	{
		return Error(adminid, "Account "GREY2_E"'%s' "WHITE_E"does not exist.", NameToUnverif);
	}
	else
	{
	    new unverifbyanang = 0;
	    new RegID;
		cache_get_value_index_int(0, 0, RegID);

		SendClientMessageToAllEx(COLOR_RED, "AdmCmd: "GREY2_E"Admin %s telah men unverification player %s", pData[adminid][pAdminname], NameToUnverif);
		new query[512];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET isveif=%d, WHERE reg_id=%d", unverifbyanang, RegID);
		mysql_tquery(g_SQL, query);
	}
	return 1;
}

function SetCSPlayer(adminid, NameToSetcs[])
{
	if(cache_num_rows() < 1)
	{
		return Error(adminid, "Account "GREY2_E"'%s' "WHITE_E"does not exist.", NameToSetcs);
	}
	else
	{
	    new setcsbyanang = 1;
	    new RegID;
		cache_get_value_index_int(0, 0, RegID);

		SendStaffMessage(COLOR_RED, "AdmCmd: "GREY2_E"Admin %s telah approved Char Story player %s", pData[adminid][pAdminname], NameToSetcs);
		new query[512];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET cschar=%d, WHERE reg_id=%d", setcsbyanang, RegID);
		mysql_tquery(g_SQL, query);
	}
	return 1;
}

function UnsetCSPlayer(adminid, NameToUnSetcs[])
{
	if(cache_num_rows() < 1)
	{
		return Error(adminid, "Account "GREY2_E"'%s' "WHITE_E"does not exist.", NameToUnSetcs);
	}
	else
	{
	    new unsetcsbyanang = 0;
	    new RegID;
		cache_get_value_index_int(0, 0, RegID);

		SendStaffMessage(COLOR_RED, "AdmCmd: "GREY2_E"Admin %s telah menghapus Char Story player %s", pData[adminid][pAdminname], NameToUnSetcs);
		new query[512];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET cschar=%d, WHERE reg_id=%d", unsetcsbyanang, RegID);
		mysql_tquery(g_SQL, query);
	}
	return 1;
}

function ObanByIrwan(adminid, NamaUntukDiOban[], OBanReason[])
{
	if(cache_num_rows() < 1)
	{
		return Error(adminid, "Account "GREY2_E"'%s' "WHITE_E"does not exist.", NamaUntukDiOban);
	}
	else
	{
	    new RegID;
	    new obannedbyirwan = 1;
		cache_get_value_index_int(0, 0, RegID);
		new query[512];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET pbanned=%d, pbanreason='%s', pbanby='%s' WHERE reg_id=%d", obannedbyirwan, OBanReason, pData[adminid][pAdminname], RegID);
		mysql_tquery(g_SQL, query);
	}
	return 1;
}

function BankRek(playerid, brek)
{
	if(cache_num_rows() > 0)
	{
		//Rekening Exist
		new query[128], rand = RandomEx(11111, 99999);
		new rek = rand+pData[playerid][pID];
		mysql_format(g_SQL, query, sizeof(query), "SELECT brek FROM players WHERE brek='%d'", rek);
		mysql_tquery(g_SQL, query, "BankRek", "is", playerid, rek);
		Info(playerid, "Your Bank rekening number is same with someone. We will research new.");
	}
	else
	{
		new query[128];
	    mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET brek='%d' WHERE reg_id=%d", brek, pData[playerid][pID]);
		mysql_tquery(g_SQL, query);
		pData[playerid][pBankRek] = brek;
	}
    return true;
}

function PhoneNumber(playerid, phone)
{
	if(cache_num_rows() > 0)
	{
		//Rekening Exist
		new query[128], rand = RandomEx(11111111, 99999999);
		new phones = rand+pData[playerid][pID];
		mysql_format(g_SQL, query, sizeof(query), "SELECT phone FROM players WHERE phone='%d'", phones);
		mysql_tquery(g_SQL, query, "PhoneNumber", "is", playerid, phones);
		Info(playerid, "Your Phone number is same with someone. We will research new.");
	}
	else
	{
		new query[128];
	    mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET phone='%d' WHERE reg_id=%d", phone, pData[playerid][pID]);
		mysql_tquery(g_SQL, query);
		pData[playerid][pPhone] = phone;
	}
    return true;
}

function OnLoginTimeout(playerid)
{
	pData[playerid][LoginTimer] = 0;

	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Login", "You have been kicked for taking too long to login successfully to your account.", "Okay", "");
	KickEx(playerid);
	return 1;
}


function _KickPlayerDelayed(playerid)
{
	Kick(playerid);
	return 1;
}

function SafeLogin(playerid)
{

	// Main Menu Features.
	SetPlayerVirtualWorld(playerid, 0);
	
	if(!IsValidRoleplayName(pData[playerid][pName]))
    {
        Error(playerid, "Nama tidak sesuai format untuk server mode roleplay.");
        Error(playerid, "Penggunaan nama harus mengikuti format Firstname_Lastname.");
        Error(playerid, "Sebagai contoh, Steven_Dreschler, Nick_Raymond, dll.");
        KickEx(playerid);
    }
}

// Info textdraw timer for hiding the textdraw
function InfoTD_MSG(playerid, ms_time, text[])
{
	if(GetPVarInt(playerid, "InfoTDshown") != -1)
	{
	    PlayerTextDrawHide(playerid, InfoTD[playerid]);
	    KillTimer(GetPVarInt(playerid, "InfoTDshown"));
	}

    PlayerTextDrawSetString(playerid, InfoTD[playerid], text);
    PlayerTextDrawShow(playerid, InfoTD[playerid]);
	SetPVarInt(playerid, "InfoTDshown", SetTimerEx("InfoTD_Hide", ms_time, false, "i", playerid));
}

function InfoTD_Hide(playerid)
{
	SetPVarInt(playerid, "InfoTDshown", -1);
	PlayerTextDrawHide(playerid, InfoTD[playerid]);
}

//---------[Admin Function ]----------

function a_ChangeAdminName(otherplayer, playerid, nname[])
{
	if(cache_num_rows() > 0)
	{
		// Name Exists
		Error(playerid, "The name "DARK_E"'%s' "GREY_E"already exists in the database, please use a different name!", nname);
	}
	else
	{
		new query[512];
	    format(query, sizeof(query), "UPDATE players SET adminname='%e' WHERE reg_id=%d", nname, pData[otherplayer][pID]);
		mysql_tquery(g_SQL, query);
		format(pData[otherplayer][pAdminname], MAX_PLAYER_NAME, "%s", nname);
		Servers(playerid, "You has set admin name player %s to %s", pData[otherplayer][pName], nname);
	}
    return true;
}

function LoadStats(playerid, PlayersName[])
{
	if(!cache_num_rows())
	{
		Error(playerid, "Account '%s' does not exist.", PlayersName);
	}
	else
	{
		new email[40], admin, helper, level, levelup, vip, viptime, coin, regdate[40], lastlogin[40], money, bmoney, brek,
			jam, menit, detik, gender, age[40], faction, family, warn, job, job2, int, world;
		cache_get_value_index(0, 0, email);
		cache_get_value_index_int(0, 1, admin);
		cache_get_value_index_int(0, 2, helper);
		cache_get_value_index_int(0, 3, level);
		cache_get_value_index_int(0, 4, levelup);
		cache_get_value_index_int(0, 5, vip);
		cache_get_value_index_int(0, 6, viptime);
		cache_get_value_index_int(0, 7, coin);
		cache_get_value_index(0, 8, regdate);
		cache_get_value_index(0, 9, lastlogin);
		cache_get_value_index_int(0, 10, money);
		cache_get_value_index_int(0, 11, bmoney);
		cache_get_value_index_int(0, 12, brek);
		cache_get_value_index_int(0, 13, jam);
		cache_get_value_index_int(0, 14, menit);
		cache_get_value_index_int(0, 15, detik);
		cache_get_value_index_int(0, 16, gender);
		cache_get_value_index(0, 17, age);
		cache_get_value_index_int(0, 18, faction);
		cache_get_value_index_int(0, 19, family);
		cache_get_value_index_int(0, 20, warn);
		cache_get_value_index_int(0, 21, job);
		cache_get_value_index_int(0, 22, job2);
		cache_get_value_index_int(0, 23, int);
		cache_get_value_index_int(0, 24, world);
		
		new header[248], scoremath = ((level)*8), fac[24], Cache:checkfamily, gstr[2468], query[128];
	
		if(faction == 1)
		{
			fac = "SAPD";
		}
		else if(faction == 2)
		{
			fac = "SAGS";
		}
		else if(faction == 3)
		{
			fac = "SAMD";
		}
		else if(faction == 4)
		{
			fac = "SANA";
		}
		else
		{
			fac = "None";
		}
		
		new name[40];
		if(admin == 1)
		{
			name = ""RED_E"Staff Administrator(1)";
		}
		else if(admin == 2)
		{
			name = ""RED_E"Administrator(2)";
		}
		else if(admin == 3)
		{
			name = ""RED_E"Senior Admin(3)";
		}
		else if(admin == 4)
		{
			name = ""RED_E"Lead Admin(4)";
		}
		else if(admin== 5)
		{
			name = ""RED_E"Head Admin(5)";
		}
		else if(helper >= 1 && admin == 0)
		{
			name = ""GREEN_E"Helper";
		}
		else
		{
			name = "None";
		}
		
		new name1[30];
		if(vip == 1)
		{
			name1 = ""LG_E"Regular(1)";
		}
		else if(vip == 2)
		{
			name1 = ""YELLOW_E"Premium(2)";
		}
		else if(vip == 3)
		{
			name1 = ""PURPLE_E"VIP Player(3)";
		}
		else
		{
			name1 = "None";
		}
		
		format(query, sizeof(query), "SELECT * FROM `familys` WHERE `ID`='%d'", family);
		checkfamily = mysql_query(g_SQL, query);
		
		new rows = cache_num_rows(), fname[128];
		
		if(rows)
		{
			new fam[128];
			cache_get_value_name(0, "name", fam);
			format(fname, 128, fam);
		}
		else
		{
			format(fname, 128, "None");
		}
		
		format(header,sizeof(header),"Stats:"YELLOW_E"%s"WHITE_E" ("BLUE_E"%s"WHITE_E")", PlayersName, ReturnTime());
		format(gstr,sizeof(gstr),""RED_E"In Character"WHITE_E"\n");
		format(gstr,sizeof(gstr),"%sGender: [%s] | Money: ["GREEN_E"$%s"WHITE_E"] | Bank: ["GREEN_E"$%s"WHITE_E"] | Rekening Bank: [%d] | Phone Number: [None]\n", gstr,(gender == 2) ? ("Female") : ("Male") , FormatMoney(money), FormatMoney(bmoney), brek);
		format(gstr,sizeof(gstr),"%sBirdthdate: [%s] | Job: [None] | Job2: [None] | Faction: [%s] | Family: [%s]\n\n", gstr, age, fac, fname);
		format(gstr,sizeof(gstr),"%s"RED_E"Out of Character"WHITE_E"\n",gstr);
		format(gstr,sizeof(gstr),"%sLevel score: [%d/%d] | Email: [%s] | Warning:[%d/10] | Last Login: [%s]\n", gstr, levelup, scoremath, email, warn, lastlogin);
		format(gstr,sizeof(gstr),"%sStaff: [%s"WHITE_E"] | Time Played: [%d hour(s) %d minute(s) %02d second(s)] | Gold Coin: [%d]\n", gstr, name, jam, menit, detik, coin);
		if(vip != 0)
		{
			format(gstr,sizeof(gstr),"%sInterior: [%d] | Virtual World: [%d] | Register Date: [%s] | VIP Level: [%s"WHITE_E"] | VIP Time: [%s]", gstr, int, world, regdate, name1, ReturnTimelapse(gettime(), viptime));
		}
		else
		{
			format(gstr,sizeof(gstr),"%sInterior: [%d] | Virtual World: [%d] | Register Date: [%s] | VIP Level: [%s"WHITE_E"] | VIP Time: [None]", gstr, int, world, regdate, name1);
		}
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, header, gstr, "Close", "");
		
		cache_delete(checkfamily);
	}
	return true;
}

function JailPlayer(playerid)
{
	ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
	SetPlayerPositionEx(playerid, -310.64, 1894.41, 34.05, 178.17, 2000);
	SetPlayerInterior(playerid, 10);
	SetPlayerVirtualWorld(playerid, 100);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	pData[playerid][pInBiz] = -1;
	pData[playerid][pInHouse] = -1;
	pData[playerid][pInDoor] = -1;
	pData[playerid][pCuffed] = 0;
	PlayerPlaySound(playerid, 1186, 0, 0, 0);
	return true;
}


//-------------[ Player Update Function ]----------

function DragUpdate(playerid, targetid)
{
    if(pData[targetid][pDragged] && pData[targetid][pDraggedBy] == playerid)
    {
        static
        Float:fX,
        Float:fY,
        Float:fZ,
        Float:fAngle;

        GetPlayerPos(playerid, fX, fY, fZ);
        GetPlayerFacingAngle(playerid, fAngle);

        fX -= 3.0 * floatsin(-fAngle, degrees);
        fY -= 3.0 * floatcos(-fAngle, degrees);

        SetPlayerPos(targetid, fX, fY, fZ);
        SetPlayerInterior(targetid, GetPlayerInterior(playerid));
        SetPlayerVirtualWorld(targetid, GetPlayerVirtualWorld(playerid));
		ApplyAnimation(targetid,"PED","WALK_civi",4.1,1,1,1,1,1);
    }
    return 1;
}

function UnfreezePee(playerid)
{
    TogglePlayerControllable(playerid, 1);
    ClearAnimations(playerid);
	StopLoopingAnim(playerid);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	return 1;
}

function UnfreezeSleep(playerid)
{
    TogglePlayerControllable(playerid, 1);
    pData[playerid][pEnergy] = 100;
	pData[playerid][pHunger] -= 3;
    ClearAnimations(playerid);
	StopLoopingAnim(playerid);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	InfoTD_MSG(playerid, 6000, "Sleeping Done!");
	return 1;
}

function RefullCar(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	//if(!IsValidVehicle(vehicleid)) return 0;
	if(!IsValidTimer(pData[playerid][pActivity])) return 0;
	if(GetNearestVehicleToPlayer(playerid, 3.8, false) == vehicleid)
    {
		if(pData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
		{
			new fuels = GetVehicleFuel(vehicleid);
		
			SetVehicleFuel(vehicleid, fuels+300);
			InfoTD_MSG(playerid, 8000, "Refulling done!");
			//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has successfully refulling the vehicle.", ReturnName(playerid));
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pActivityTime] = 0;
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
		}
		else if(pData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
		{
			pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
		}
		else
		{
			Error(playerid, "Refulling fail! Anda tidak berada didekat kendaraan tersebut!");
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pActivityTime] = 0;
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
		}
	}
	else
	{
		Error(playerid, "Refulling fail! Anda tidak berada didekat kendaraan tersebut!");
		KillTimer(pData[playerid][pActivity]);
		pData[playerid][pActivityTime] = 0;
		HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
		PlayerTextDrawHide(playerid, ActiveTD[playerid]);
		return 1;
	}
	return 1;
}

//Bank
function SearchRek(playerid, rek)
{
	if(!cache_num_rows())
	{
		// Rekening tidak ada
		Error(playerid, "Rekening bank "YELLOW_E"'%d' "WHITE_E"tidak terdaftar!", rek);
		pData[playerid][pTransfer] = 0;
	    
	}
	else
	{
	    // Proceed
		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "SELECT username,brek FROM players WHERE brek='%d'", rek);
		mysql_tquery(g_SQL, query, "SearchRek2", "id", playerid, rek);
	}
}

function SearchRek2(playerid, rek)
{
	if(cache_num_rows())
	{
		new name[128], brek, mstr[128];
		cache_get_value_index(0, 0, name);
		cache_get_value_index_int(0, 1, brek);
		
		//format(pData[playerid][pTransferName], 128, "%s" name);
		pData[playerid][pTransferName] = name;
		pData[playerid][pTransferRek] = brek;
		format(mstr, sizeof(mstr), ""WHITE_E"No Rek Target: "YELLOW_E"%d\n"WHITE_E"Nama Target: "YELLOW_E"%s\n"WHITE_E"Jumlah: "GREEN_E"%s\n\n"WHITE_E"Anda yakin akan melanjutkan mentransfer?", brek, name, FormatMoney(pData[playerid][pTransfer]));
		ShowPlayerDialog(playerid, DIALOG_BANKCONFIRM, DIALOG_STYLE_MSGBOX, ""LB_E"Bank", mstr, "Transfer", "Cancel");
	}
	return true;
}

//----------[ JOB FUNCTION ]-------------

//Server Timer
function pCountDown()
{
	Count--;
	if(0 >= Count)
	{
		Count = -1;
		KillTimer(countTimer);
		foreach(new ii : Player)
		{
 			if(showCD[ii] == 1)
   			{
   				GameTextForPlayer(ii, "~w~GO~r~!~g~!~b~!", 2500, 6);
   				PlayerPlaySound(ii, 1057, 0, 0, 0);
   				showCD[ii] = 0;
			}
		}
	}
	else
	{
		foreach(new ii : Player)
		{
 			if(showCD[ii] == 1)
   			{
				GameTextForPlayer(ii, CountText[Count-1], 2500, 6);
				PlayerPlaySound(ii, 1056, 0, 0, 0);
   			}
		}
	}
	return 1;
}

//----------[ Other Function ]-----------

function SetPlayerToUnfreeze(playerid, Float:x, Float:y, Float:z, Float:a)
{
    if(!IsPlayerInRangeOfPoint(playerid, 15.0, x, y, z))
        return 0;

    pData[playerid][pFreeze] = 0;
	TogglePlayerControllable(playerid, 1);
    return 1;
}

function SetVehicleToUnfreeze(playerid, vehicleid, Float:x, Float:y, Float:z, Float:a)
{
    if(!IsPlayerInRangeOfPoint(playerid, 15.0, x, y, z))
        return 0;

    pData[playerid][pFreeze] = 0;
    SetVehiclePos(vehicleid, x, y, z);
	SetVehicleZAngle(vehicleid, a);
    TogglePlayerControllable(playerid, 1);
    return 1;
}

function HideTextDrawNotif(playerid)
{
	TextDrawHideForPlayer(playerid, notifTD[0]);
	TextDrawHideForPlayer(playerid, notifTD[1]);
	return 1;
}

function ImpoundVeh(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	//if(!IsValidVehicle(vehicleid)) return 0;
	if(!IsValidTimer(pData[playerid][pActivity])) return 0;
	if(GetNearestVehicleToPlayer(playerid, 3.8, false) == vehicleid)
    {
		if(pData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
		{
			foreach(new ii : PVehicles)
			{
				new S3MP4K[212];
				if(vehicleid == pvData[ii][cVeh])
				{
					foreach(new pid : Player) if (pvData[ii][cOwner] == pData[pid][pID])
					{
						format(S3MP4K, sizeof(S3MP4K), "IMPOUND: {FFFFFF}Your {FFFF00}%s {FFFFFF}has been impounded by {00FFFF}%s.", GetVehicleName(vehicleid), ReturnName(playerid));
						SendClientMessageEx(pid, COLOR_ARWIN, S3MP4K);	
						SendFactionMessage(1, COLOR_RADIO, "HQ: %s has impounded %s's %s.", pData[playerid][pName],  pData[pid][pName], GetVehicleName(vehicleid));		
						SetVehicleVirtualWorld(vehicleid, 11);
						pvData[ii][cImpound] = 1;	
						for(new id = 0 ; id < MAX_VEHICLE_OBJECT; id++)
						{
							Vehicle_ObjectDelete(pvData[ii][cVeh], id);
						}
						for(new f = 0 ; f < MAX_MODS; f++)
						{
							RemoveVehicleComponent(pvData[ii][cVeh], GetVehicleComponentInSlot(pvData[ii][cVeh], f));
						}
						pvData[ii][pvBodyUpgrade] = 0;
						pvData[ii][cMesinUpgrade] = 0;
						Vehicle_ObjectDestroy(pvData[ii][cVeh]);
					}
				}
			}
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pActivityTime] = 0;
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
		}
		else if(pData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
		{
			pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
		}
	}
	else
	{
		Error(playerid, "Impound fail! Anda tidak berada didekat kendaraan tersebut!");
		KillTimer(pData[playerid][pActivity]);
		pData[playerid][pActivityTime] = 0;
		HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
		PlayerTextDrawHide(playerid, ActiveTD[playerid]);
		return 1;
	}
	return 1;
}

function EnterExitTimer(playerid)
{
	TogglePlayerControllable(playerid, 1);
	return 1;
}

function CigarStop(playerid)
{
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
    return 1;
}

function DrugEffectGone(playerid)
{
    new time[3];
    new pogoda;

    gettime(time[0], time[1], time[2]);
    SetPlayerTime(playerid, time[0], time[1]);
    SetPlayerWeather(playerid, pogoda);
    SetPlayerDrunkLevel(playerid, 0);
    return 1;
}

function OOCNews(color,String[])
{
	foreach(new i : Player)
	{
		if(!gNews[i])
		{
			SendClientMessageEx(i, color, String);
		}
	}
}

function SAPDLobbyDoorClose()
{
	MoveDynamicObject(SAPDLobbyDoor[0], 1327.769531, 728.931030, 110.300323, 3);
	//MoveDynamicObject(SAPDLobbyDoor[1], 253.12556, 110.49657, 1002.21460, 3);
	// MoveDynamicObject(SAPDLobbyDoor[2], 239.69435, 116.15908, 1002.21411, 3);
	// MoveDynamicObject(SAPDLobbyDoor[3], 239.64050, 119.08750, 1002.21332, 3);
	return 1;
}

function ptoll1()
{
   	MoveDynamicObject(toll[0], 49.294261, -1534.956420, 4.966773-0.1, 0.15, -0.899999, -90.099952, 83.000007);
	return 1;
}

function ptoll2()
{
   	MoveDynamicObject(toll[1], 59.574924, -1529.473144, 4.721392-0.1, 0.15, 6.299998, -89.100013, -98.599975);
	return 1;
}

function ptoll3()
{
   	MoveDynamicObject(toll[5], 596.052673, 364.341156, 18.909631, 0.15, -2.000000, 88.299919, 32.800006);
	return 1;
}

function ptoll4()
{
   	MoveDynamicObject(toll[6], 591.922363, 370.821319, 18.860389, 0.15, 1.000000, -89.900039, 33.000011);
	return 1;
}

function ptoll5()
{
   	MoveDynamicObject(toll[9], 624.003112, -1188.514526, 18.519626, 0.15, 0.000000, 89.800025, 25.899995);
	return 1;
}

function ptoll6()
{
   	MoveDynamicObject(toll[10], 43.450733, -1328.262695, 10.607647, 0.15, 0.000000, -89.099975, -54.000000);
	return 1;
}

function ptoll7()
{
   	MoveDynamicObject(toll[13], -180.217651, 294.102264, 12.172492, 0.15, 0.000000, -90.499954, -11.499999);
	return 1;
}

function ptoll8()
{
   	MoveDynamicObject(toll[14], -183.846267, 306.807891, 12.030379, 0.15, 0.000000, -90.299896, -14.900000);
	return 1;
}
