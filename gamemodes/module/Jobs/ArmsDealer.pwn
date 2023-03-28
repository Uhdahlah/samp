//-3807.89, 1312.56, 75.82

CreateArmsPoint()
{
	//JOBS
	new strings[214], strings2[214];
	CreateDynamicPickup(1239, 23, -3807.89, 1312.56, 75.82, -1);
	format(strings, sizeof(strings), ""RED_E"Job: Arms Dealer\n"YELLOW_E"'/joinjob' "WHITE_E"to be an Arms Dealer\n"YELLOW_E"'/buypacket' "WHITE_E"to buy gun material package\nAvailable packages: "GREEN_E"%d", StockMaterial);
	Material = CreateDynamic3DTextLabel(strings, COLOR_ARWIN, -3807.89, 1312.56, 75.82, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //

	CreateDynamicPickup(1239, 23, -882.1044,1110.8616,5442.8203, -1, -1, -1, 5.0);
	format(strings2, sizeof(strings2), ""RED_E"Job: Drugs  Dealer\n"YELLOW_E"'/joinjob' "WHITE_E"to be an Drug Dealer\n"YELLOW_E"'/buypacket' "WHITE_E"to buy drugs package\nAvailable packages: "GREEN_E"%d", StockCrack);
	Crack = CreateDynamic3DTextLabel(strings2, COLOR_ARWIN, -882.1044,1110.8616,5442.8203, 5.0); // product
}

CMD:buypacket(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 3.5, -3807.89, 1312.56, 75.82))
	{
		ShowPlayerDialog(playerid, DIALOG_PACKETCGUN, DIALOG_STYLE_MSGBOX, "Buying Material","Price per packet: "GREEN_E"$2,003.68\nAmmount: "YELLOW_E"2500 units\nConfirm purchase?", "Yes", "No" );
	}
	else if(IsPlayerInRangeOfPoint(playerid, 3.5, -882.1044,1110.8616,5442.8203))
	{
		if(pData[playerid][pJob] == 7 || pData[playerid][pJob2] == 7)
		{
			if(isnull(params)) 
			{
				Usage(playerid, "/buypacket [pot/crack]");
				return 1;
			}
			if(strcmp(params,"pot",true) == 0) 
			{
				ShowPlayerDialog(playerid,DIALOG_BUYPOT,DIALOG_STYLE_MSGBOX,"Buying Drug: Pot","Price per packet: "GREEN_E"$304.36\n"GREEN_E"Weight: "YELLOW_E"100 grams\nConfirm purchase?", "Yes", "No" );
			}
			if(strcmp(params,"crack",true) == 0) 
			{
				if(pData[playerid][pFamily] == -1)
					return Error(playerid, "You are not in family!");
				ShowPlayerDialog(playerid,DIALOG_BUYCRACK,DIALOG_STYLE_MSGBOX,"Buying Drug: Crack","Price per packet: "GREEN_E"$304.36\n"GREEN_E"Weight: "YELLOW_E"50 grams\nConfirm purchase?", "Yes", "No" );
			}
		}	
	}
	return 1;	
}

CMD:createammo(playerid, params[])
{
	new String[512], weaponid = GetPlayerWeaponEx(playerid);
	if(pData[playerid][pJob] == 6 || pData[playerid][pJob2] == 6)
	{
		if(!weaponid) return SendClientMessageEx(playerid, COLOR_ARWIN, "ERROR: "WHITE_E"You are not holding a weapon.");
		format(String,sizeof(String),"Weapon: {00FFFF}%s\n"GREEN_E"Creating ammo: 250\nMaterial Cost: "GREEN_E"1000", ReturnWeaponName(weaponid));
		ShowPlayerDialog(playerid,DIALOG_MAKEAMMO,DIALOG_STYLE_MSGBOX,"Ammo Crafting",String,"Create", "Cancel");
	}
	else Error(playerid, "You are not Arms Dealer");
	return 1;
}

CMD:creategun(playerid, params[])
{
	new String[512];
	if(pData[playerid][pJob] == 6 || pData[playerid][pJob2] == 6)
	{
		if(pData[playerid][pFamily] > 0)
		{
			format(String, sizeof(String), "Weapons Name\tMaterial Cost\tRequire Schematic\n");
			format(String, sizeof(String),"%sCountry Rifle\t1000\tYes\nShotgun\t2000\tYes\nDesert Eagle\t2500\tYes\nMP5\t5000\tYes\nAK47\t7000\tYes",String);
		}
		else
		{
			format(String, sizeof(String), "Weapons Name\tMaterial Cost\tRequire Schematic\n");
			format(String, sizeof(String),"%sCountry Rifle\t1000\tYes\nShotgun\t2000\tYes",String);
		}
		ShowPlayerDialog(playerid, DIALOG_CREATEGUN, DIALOG_STYLE_TABLIST_HEADERS, "Weapon Crafting", String, "Create", "Cancel");
	}
	else Error(playerid, "You are not Arms Dealer");
	return 1;
}
