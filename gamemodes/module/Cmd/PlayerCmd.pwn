//-------------[ Player Commands ]-------------//
CMD:help(playerid, params[])
{
	ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_LIST, "Help Categories:", "Basic Commands\nChat\nMoney & Banking\nJob Help\nVehicle Help\nFaction Help\nFamily Help\nHouse Help\nFlat Apartments Help\nBusiness Commands\nWorkshop Help\nFarm Help\nDonator Commands\nFurnStore Commands", "Select", "Close");
	return 1;
}

CMD:credits(playerid)
{
	new line1[1200], line2[300], line3[500];
	strcat(line3, ""LB_E"Founder Server: "YELLOW_E"Hakim\n");
	strcat(line3, ""LB_E"Server Developer: "YELLOW_E"Hakim\n");
	strcat(line3, ""LB_E"Support Website: "YELLOW_E"-\n");
	format(line2, sizeof(line2), ""LB_E"Server Support: All SA-MP Team\n\n\
	"GREEN_E"Terima kasih telah bergabung dengan kami! Copyright © 2022 | sc5 community 2022");
	format(line1, sizeof(line1), "%s%s", line3, line2);
   	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Server Credits", line1, "OK", "");
	return 1;
}

CMD:email(playerid)
{
    if(pData[playerid][IsLoggedIn] == false)
		return Error(playerid, "You must be logged in to change your email address!");

	ShowPlayerDialog(playerid, DIALOG_EMAIL, DIALOG_STYLE_INPUT, ""WHITE_E"Set your email address", ""WHITE_E"Enter your email address below.\nThis will be used to reset your password incase you lose it.\n\n"RED_E"* "WHITE_E"Your e-mail is confidential and will not be displayed publicly\n"RED_E"* "WHITE_E"Emails will only be sent for a password reset or important news\n\
	"RED_E"* "WHITE_E"Be sure to double-check and enter a valid email address!", "Enter", "Exit");
	return 1;
}

CMD:changepass(playerid)
{
    if(pData[playerid][IsLoggedIn] == false)
		return Error(playerid, "You must be logged in to change your password!");

	ShowPlayerDialog(playerid, DIALOG_PASSWORD, DIALOG_STYLE_INPUT, ""WHITE_E"Change your password", "Insert your new password to change!", "Change", "Exit");
	InfoTD_MSG(playerid, 3000, "~g~~h~Insert your current password!");
	return 1;
}

CMD:savestats(playerid, params[])
{
	if(pData[playerid][IsLoggedIn] == false)
		return Error(playerid, "You are not logged in!");
		
	UpdatePlayerData(playerid);
	Servers(playerid, "Akun anda telah di save di database!");
	return 1;
}

CMD:gshop(playerid, params[])
{
	new Dstring[261];
	format(Dstring, sizeof(Dstring), "Gold Shop\tPrice\n");
	format(Dstring, sizeof(Dstring), "%sClear Warning(-1)\t50 Gold\n", Dstring);
	format(Dstring, sizeof(Dstring), "%sChange Phone Number\t150 Gold\n", Dstring);
	format(Dstring, sizeof(Dstring), "%sChange Plate Vehicle\t100 Gold\n", Dstring);
	format(Dstring, sizeof(Dstring), "%sChange Mask Number\t250 Gold\n", Dstring);
	ShowPlayerDialog(playerid, DIALOG_GOLDSHOP, DIALOG_STYLE_TABLIST_HEADERS, "Gold Shop", Dstring, "Buy", "Cancel");
	return 1;
}

CMD:mypos(playerid, params[])
{
	new int, Float:px,Float:py,Float:pz, Float:a;
	GetPlayerPos(playerid, px, py, pz);
	GetPlayerFacingAngle(playerid, a);
	int = GetPlayerInterior(playerid);
	new zone[MAX_ZONE_NAME];
	GetPlayer3DZone(playerid, zone, sizeof(zone));
	SendClientMessageEx(playerid, COLOR_WHITE, "Lokasi Anda Saat Ini: %s (%0.2f, %0.2f, %0.2f, %0.2f) Int = %d", zone, px, py, pz, a, int);
	return 1;
}

CMD:gps(playerid, params[])
{
	if(pData[playerid][pGPS] < 1) return Error(playerid, "Anda tidak memiliki GPS.");
	DisablePlayerCheckpoint(playerid);
	DisablePlayerRaceCheckpoint(playerid);
	ShowPlayerDialog(playerid, DIALOG_GPS, DIALOG_STYLE_LIST, "GPS Menu", "Public Location\nRestaurants\nElectronic Store\nSports Store\nSupermarket\nClothes Store\nGas Station\nDealership\nFurniture Store\nWorkshop\nMy Vehicle", "Select", "Close");
	return 1;
}

CMD:death(playerid, params[])
{
    if(pData[playerid][pInjured] == 0)
        return Error(playerid, "You are not injured at the moment.");
		
	if(pData[playerid][pJail] > 0)
		return Error(playerid, "You can't do this when in jail!");
		
	if(pData[playerid][pArrest] > 0)
		return Error(playerid, "You can't do this when in arrest sapd!");

    if((gettime()-GetPVarInt(playerid, "GiveUptime")) < 100)
        return SendClientMessage(playerid, COLOR_ARWIN, "DEATH: "WHITE_E"You must waiting 3 minutes for spawn to hospital");

	if(pData[playerid][pDragged] > 0)
		return Error(playerid, "You can't do this when in drag!");

    SendClientMessage(playerid, COLOR_ARWIN, "DEATH: "WHITE_E"You have given up and accepted your death");
	pData[playerid][pHospitalTime] = 0;
	pData[playerid][pHospital] = 1;
    return 1;
}

CMD:sleep(playerid, params[])
{
	if(pData[playerid][pInjured] == 1)
        return Error(playerid, "You can't use this command at the injured moment.");
	
	if(pData[playerid][pInHouse] == -1)
		return Error(playerid, "You must inside a house to sleep.");
	
	InfoTD_MSG(playerid, 10000, "Sleeping... Please wait!");
	TogglePlayerControllable(playerid, 0);
	new time = (100 - pData[playerid][pEnergy]) * (400);
    SetTimerEx("UnfreezeSleep", time, 0, "i", playerid);
	switch(random(6))
	{
		case 0: ApplyAnimation(playerid, "INT_HOUSE", "BED_In_L",4.1,0,0,0,1,1);
		case 1: ApplyAnimation(playerid, "INT_HOUSE", "BED_In_R",4.1,0,0,0,1,1);
		case 2: ApplyAnimation(playerid, "INT_HOUSE", "BED_Loop_L",4.1,1,0,0,1,1);
		case 3: ApplyAnimation(playerid, "INT_HOUSE", "BED_Loop_R",4.1,1,0,0,1,1);
		case 4: ApplyAnimation(playerid, "INT_HOUSE", "BED_Out_L",4.1,0,1,1,0,0);
		case 5: ApplyAnimation(playerid, "INT_HOUSE", "BED_Out_R",4.1,0,1,1,0,0);
	}
	return 1;
}

CMD:myproperty(playerid, params[])
{
	new msg2[1024], house[512], commercial[512], usedhslot, houseslot, usedcslot, commerslot, usedoslot, otherslot;

	if(pData[playerid][pVip] > 3) houseslot = 2, commerslot = 2;
	else houseslot = 1, commerslot = 1;

	if(pData[playerid][pVip] == 3) otherslot = 2;
	else if(pData[playerid][pVip] == 4) otherslot = 3;
	else otherslot = 1;

	// house
	if(pData[playerid][pHouseOwner1] != -1 && pData[playerid][pHouseOwner2] != -1)
	{
		usedhslot = 2;
		format(house, sizeof(house), "H%i:\t"GREEN_E"House[owner]\t"WHITE_E"%s\nH%i:\t"GREEN_E"House[owner]\t"WHITE_E"%s", pData[playerid][pHouseOwner1], hData[pData[playerid][pHouseOwner1]][hAddress], pData[playerid][pHouseOwner2], hData[pData[playerid][pHouseOwner2]][hAddress]);
	}
	else if(pData[playerid][pHouseOwner1] != -1)
	{
		usedhslot = 1;
		format(house, sizeof(house), "H%i:\t"GREEN_E"House[owner]\t"WHITE_E"%s", pData[playerid][pHouseOwner1], hData[pData[playerid][pHouseOwner1]][hAddress]);
	}
	else if(pData[playerid][pHouseOwner2] != -1)
	{
		usedhslot = 1;
		format(house, sizeof(house), "H%i:\t"GREEN_E"House[owner]\t"WHITE_E"%s", pData[playerid][pHouseOwner2], hData[pData[playerid][pHouseOwner2]][hAddress]);
	}

	// bisnis
	if(pData[playerid][pBisnisOwner1] != -1 && pData[playerid][pBisnisOwner2] != -1)
	{
		new type[128], type2[128];
		if(bData[pData[playerid][pBisnisOwner1]][bType] == 1)
		{
			type= "Fast Food";
		}
		else if(bData[pData[playerid][pBisnisOwner1]][bType] == 2)
		{
			type= "Market";
		}
		else if(bData[pData[playerid][pBisnisOwner1]][bType] == 3)
		{
			type= "Clothes";
		}
		else if(bData[pData[playerid][pBisnisOwner1]][bType] == 4)
		{
			type= "Sportshop";
		}
		else if(bData[pData[playerid][pBisnisOwner1]][bType] == 5)
		{
			type= "Electronic";
		}
		else
		{
			type= "Unknown";
		}

		// Type 2
		if(bData[pData[playerid][pBisnisOwner2]][bType] == 1)
		{
			type= "Fast Food";
		}
		else if(bData[pData[playerid][pBisnisOwner2]][bType] == 2)
		{
			type= "Market";
		}
		else if(bData[pData[playerid][pBisnisOwner2]][bType] == 3)
		{
			type= "Clothes";
		}
		else if(bData[pData[playerid][pBisnisOwner2]][bType] == 4)
		{
			type= "Sportshop";
		}
		else if(bData[pData[playerid][pBisnisOwner2]][bType] == 5)
		{
			type= "Electronic";
		}
		else
		{
			type= "Unknown";
		}

		usedcslot = 1;
		format(commercial, sizeof(commercial), "B%i:\t"BLUE_E"Business[owner]\t"WHITE_E"%s\nB%i:\t"BLUE_E"Business[owner]\t"WHITE_E"%s", pData[playerid][pBisnisOwner1], type, pData[playerid][pBisnisOwner2], type2);
	}
	else if(pData[playerid][pBisnisOwner1] != -1)
	{
		new type[128];
		if(bData[pData[playerid][pBisnisOwner1]][bType] == 1)
		{
			type= "Fast Food";
		}
		else if(bData[pData[playerid][pBisnisOwner1]][bType] == 2)
		{
			type= "Market";
		}
		else if(bData[pData[playerid][pBisnisOwner1]][bType] == 3)
		{
			type= "Clothes";
		}
		else if(bData[pData[playerid][pBisnisOwner1]][bType] == 4)
		{
			type= "Sportshop";
		}
		else if(bData[pData[playerid][pBisnisOwner1]][bType] == 5)
		{
			type= "Electronic";
		}
		else
		{
			type= "Unknown";
		}

		usedcslot = 1;
		format(commercial, sizeof(commercial), "B%i:\t"BLUE_E"Business[owner]\t"WHITE_E"%s", pData[playerid][pBisnisOwner1], type);
	}
	else if(pData[playerid][pBisnisOwner2] != -1)
	{
		new type[128];
		if(bData[pData[playerid][pBisnisOwner2]][bType] == 1)
		{
			type= "Fast Food";
		}
		else if(bData[pData[playerid][pBisnisOwner2]][bType] == 2)
		{
			type= "Market";
		}
		else if(bData[pData[playerid][pBisnisOwner2]][bType] == 3)
		{
			type= "Clothes";
		}
		else if(bData[pData[playerid][pBisnisOwner2]][bType] == 4)
		{
			type= "Sportshop";
		}
		else if(bData[pData[playerid][pBisnisOwner2]][bType] == 5)
		{
			type= "Electronic";
		}
		else
		{
			type= "Unknown";
		}

		usedcslot = 1;
		format(commercial, sizeof(commercial), "B%i:\t"BLUE_E"Business[owner]\t"WHITE_E"%s", pData[playerid][pBisnisOwner2], type);
	}

	// other
	if(pData[playerid][pOtherPropOwner1] != -1 && pData[playerid][pOtherPropOwner2] != -1 && pData[playerid][pOtherPropOwner3] != -1)
	{
		usedoslot = 3;

		/*new pengandaian1[512], pengandaian2[512], pengandaian3[512];
		// kalau slot 1 itu dealer
		if(pData[playerid][pOtherPropOwner1] == CarDealershipInfo[pData[playerid][pOtherPropOwner1]][cdID]) format(pengandaian1, sizeof(pengandaian1), "O%i:\t"BLUE_E"Car Dealership[owner]\t"WHITE_E"%s", pData[playerid][pOtherPropOwner1], CarDealershipInfo[pData[playerid][pOtherPropOwner1]][cdMessage]);
		// kalau slot 1 itu furn
		else format(pengandaian1, sizeof(pengandaian1), "O%i:\t"BLUE_E"Furniture Store[owner]\t"WHITE_E"%s", pData[playerid][pOtherPropOwner1], storeData[pData[playerid][pOtherPropOwner1]][storeName]);

		// kalau slot 2 itu dealer
		if(pData[playerid][pOtherPropOwner2] == CarDealershipInfo[pData[playerid][pOtherPropOwner2]][cdID]) format(pengandaian2, sizeof(pengandaian2), "O%i:\t"BLUE_E"Car Dealership[owner]\t"WHITE_E"%s", pData[playerid][pOtherPropOwner2], CarDealershipInfo[pData[playerid][pOtherPropOwner2]][cdMessage]);
		// kalau slot 2 itu furn
		else format(pengandaian2, sizeof(pengandaian2), "O%i:\t"BLUE_E"Furniture Store[owner]\t"WHITE_E"%s", pData[playerid][pOtherPropOwner2], storeData[pData[playerid][pOtherPropOwner2]][storeName]);

		// kalau slot 3 itu dealer
		if(pData[playerid][pOtherPropOwner3] == CarDealershipInfo[pData[playerid][pOtherPropOwner3]][cdID]) format(pengandaian3, sizeof(pengandaian3), "O%i:\t"BLUE_E"Car Dealership[owner]\t"WHITE_E"%s", pData[playerid][pOtherPropOwner3], CarDealershipInfo[pData[playerid][pOtherPropOwner3]][cdMessage]);
		// kalau slot 3 itu furn
		else format(pengandaian3, sizeof(pengandaian3), "O%i:\t"BLUE_E"Furniture Store[owner]\t"WHITE_E"%s", pData[playerid][pOtherPropOwner3], storeData[pData[playerid][pOtherPropOwner3]][storeName]);

		format(otherprop, sizeof(otherprop), "%s\n%s\n%s", pengandaian1, pengandaian2, pengandaian3);*/
	}
	else if (pData[playerid][pOtherPropOwner1] != -1 && pData[playerid][pOtherPropOwner2] != -1 || pData[playerid][pOtherPropOwner2] != -1 && pData[playerid][pOtherPropOwner3] != -1 || pData[playerid][pOtherPropOwner1] != -1 && pData[playerid][pOtherPropOwner3] != -1)
	{
		usedoslot = 2;
		
		/*new pengandaian1[512], pengandaian2[512], pengandaian3[512], combpengadaian[1024];
		// kalau slot 1 itu dealer
		if(pData[playerid][pOtherPropOwner1] != -1 && pData[playerid][pOtherPropOwner1] == CarDealershipInfo[pData[playerid][pOtherPropOwner1]][cdID]) format(pengandaian1, sizeof(pengandaian1), "O%i:\t"BLUE_E"Car Dealership[owner]\t"WHITE_E"%s", pData[playerid][pOtherPropOwner1], CarDealershipInfo[pData[playerid][pOtherPropOwner1]][cdMessage]);
		else if(pData[playerid][pOtherPropOwner1] != -1 && pData[playerid][pOtherPropOwner1] == storeData[pData[playerid][pOtherPropOwner1]][storeID]) format(pengandaian1, sizeof(pengandaian1), "O%i:\t"BLUE_E"Furniture Store[owner]\t"WHITE_E"%s", pData[playerid][pOtherPropOwner1], storeData[pData[playerid][pOtherPropOwner1]][storeName]);

		// kalau slot 2 itu dealer
		if(pData[playerid][pOtherPropOwner2] != -1 && pData[playerid][pOtherPropOwner2] == CarDealershipInfo[pData[playerid][pOtherPropOwner2]][cdID]) format(pengandaian2, sizeof(pengandaian2), "O%i:\t"BLUE_E"Car Dealership[owner]\t"WHITE_E"%s", pData[playerid][pOtherPropOwner2], CarDealershipInfo[pData[playerid][pOtherPropOwner2]][cdMessage]);
		else if(pData[playerid][pOtherPropOwner2] != -1 && pData[playerid][pOtherPropOwner2] == storeData[pData[playerid][pOtherPropOwner2]][storeID]) format(pengandaian2, sizeof(pengandaian2), "O%i:\t"BLUE_E"Furniture Store[owner]\t"WHITE_E"%s", pData[playerid][pOtherPropOwner2], storeData[pData[playerid][pOtherPropOwner2]][storeName]);

		// kalau slot 3 itu dealer
		if(pData[playerid][pOtherPropOwner3] != -1 && pData[playerid][pOtherPropOwner3] == CarDealershipInfo[pData[playerid][pOtherPropOwner3]][cdID]) format(pengandaian3, sizeof(pengandaian3), "O%i:\t"BLUE_E"Car Dealership[owner]\t"WHITE_E"%s", pData[playerid][pOtherPropOwner3], CarDealershipInfo[pData[playerid][pOtherPropOwner3]][cdMessage]);
		else if(pData[playerid][pOtherPropOwner3] != -1 && pData[playerid][pOtherPropOwner3] == storeData[pData[playerid][pOtherPropOwner3]][storeID]) format(pengandaian3, sizeof(pengandaian3), "O%i:\t"BLUE_E"Furniture Store[owner]\t"WHITE_E"%s", pData[playerid][pOtherPropOwner3], storeData[pData[playerid][pOtherPropOwner3]][storeName]);

		// 1 & 2
		if(pData[playerid][pOtherPropOwner1] != -1 && pData[playerid][pOtherPropOwner2] != -1) format(combpengadaian, sizeof(combpengadaian), "%s\n%s", pengandaian1, pengandaian2);
		else if(pData[playerid][pOtherPropOwner2] != -1 && pData[playerid][pOtherPropOwner3] != -1) format(combpengadaian, sizeof(combpengadaian), "%s\n%s", pengandaian2, pengandaian3);
		else if(pData[playerid][pOtherPropOwner1] != -1 && pData[playerid][pOtherPropOwner3] != -1) format(combpengadaian, sizeof(combpengadaian), "%s\n%s", pengandaian1, pengandaian3);*/

		// check pOtherPropOwner1 and pOtherPropOwner2
		/*if(pData[playerid][pOtherPropOwner1] != -1 && pData[playerid][pOtherPropOwner2] != -1)
		{
    		if(pData[playerid][pOtherPropOwner1] == CarDealershipInfo[pData[playerid][pOtherPropOwner1]][cdID]) 
    	    format(otherprop, sizeof(otherprop), "O%i:\t"BLUE_E"Car Dealership[owner]\t"WHITE_E"%s\nO%i:\t"BLUE_E"Furniture Store[owner]\t"WHITE_E"%s", pData[playerid][pOtherPropOwner1], CarDealershipInfo[pData[playerid][pOtherPropOwner1]][cdMessage], pData[playerid][pOtherPropOwner2], storeData[pData[playerid][pOtherPropOwner2]][storeName]);
    		else if(pData[playerid][pOtherPropOwner1] == storeData[pData[playerid][pOtherPropOwner1]][storeID]) 
    	    format(otherprop, sizeof(otherprop), "O%i:\t"BLUE_E"Furniture Store[owner]\t"WHITE_E"%s\nO%i:\t"BLUE_E"Car Dealership[owner]\t"WHITE_E"%s", pData[playerid][pOtherPropOwner1], storeData[pData[playerid][pOtherPropOwner1]][storeName], pData[playerid][pOtherPropOwner2], CarDealershipInfo[pData[playerid][pOtherPropOwner2]][cdMessage]);
		}

		// check pOtherPropOwner2 and pOtherPropOwner3
		if(pData[playerid][pOtherPropOwner2] != -1 && pData[playerid][pOtherPropOwner3] != -1)
		{
    		if(pData[playerid][pOtherPropOwner2] == CarDealershipInfo[pData[playerid][pOtherPropOwner2]][cdID]) 
    	    format(otherprop, sizeof(otherprop), "O%i:\t"BLUE_E"Car Dealership[owner]\t"WHITE_E"%s\nO%i:\t"BLUE_E"Furniture Store[owner]\t"WHITE_E"%s", pData[playerid][pOtherPropOwner2], CarDealershipInfo[pData[playerid][pOtherPropOwner2]][cdMessage], pData[playerid][pOtherPropOwner3], storeData[pData[playerid][pOtherPropOwner3]][storeName]);
    		else if(pData[playerid][pOtherPropOwner2] == storeData[pData[playerid][pOtherPropOwner2]][storeID]) 
    	    format(otherprop, sizeof(otherprop), "O%i:\t"BLUE_E"Furniture Store[owner]\t"WHITE_E"%s\nO%i:\t"BLUE_E"Car Dealership[owner]\t"WHITE_E"%s", pData[playerid][pOtherPropOwner2], storeData[pData[playerid][pOtherPropOwner2]][storeName], pData[playerid][pOtherPropOwner3], CarDealershipInfo[pData[playerid][pOtherPropOwner3]][cdMessage]);
		}
		
		// check pOtherPropOwner1 and pOtherPropOwner3
		if(pData[playerid][pOtherPropOwner1] != -1 && pData[playerid][pOtherPropOwner3] != -1)
		{
    		if(pData[playerid][pOtherPropOwner1] == CarDealershipInfo[pData[playerid][pOtherPropOwner1]][cdID]) 
    	    format(otherprop, sizeof(otherprop), "O%i:\t"BLUE_E"Car Dealership[owner]\t"WHITE_E"%s\nO%i:\t"BLUE_E"Furniture Store[owner]\t"WHITE_E"%s", pData[playerid][pOtherPropOwner1], CarDealershipInfo[pData[playerid][pOtherPropOwner1]][cdMessage], pData[playerid][pOtherPropOwner3], storeData[pData[playerid][pOtherPropOwner3]][storeName]);
    		else if(pData[playerid][pOtherPropOwner1] == storeData[pData[playerid][pOtherPropOwner1]][storeID]) 
    	    format(otherprop, sizeof(otherprop), "O%i:\t"BLUE_E"Furniture Store[owner]\t"WHITE_E"%s\nO%i:\t"BLUE_E"Car Dealership[owner]\t"WHITE_E"%s", pData[playerid][pOtherPropOwner1], storeData[pData[playerid][pOtherPropOwner1]][storeName], pData[playerid][pOtherPropOwner3], CarDealershipInfo[pData[playerid][pOtherPropOwner3]][cdMessage]);
		}*/
	}
	else if(pData[playerid][pOtherPropOwner1] != -1)
	{
		usedoslot = 1;
		/*if(pData[playerid][pOtherPropOwner1] == CarDealershipInfo[pData[playerid][pOtherPropOwner1]][cdID])
		{
			format(otherprop, sizeof(otherprop), "O%i:\t"BLUE_E"Car Dealership[owner]\t"WHITE_E"%s", pData[playerid][pOtherPropOwner1], CarDealershipInfo[pData[playerid][pOtherPropOwner1]][cdMessage]);
		}
		else
		{
			format(otherprop, sizeof(otherprop), "O%i:\t"BLUE_E"Furniture Store[owner]\t"WHITE_E"%s", pData[playerid][pOtherPropOwner1], storeData[pData[playerid][pOtherPropOwner1]][storeName]);
		}*/
	}
	else if(pData[playerid][pOtherPropOwner2] != -1)
	{
		usedoslot = 1;
		/*if(pData[playerid][pOtherPropOwner2] == CarDealershipInfo[pData[playerid][pOtherPropOwner2]][cdID])
		{
			format(otherprop, sizeof(otherprop), "O%i:\t"BLUE_E"Car Dealership[owner]\t"WHITE_E"%s", pData[playerid][pOtherPropOwner2], CarDealershipInfo[pData[playerid][pOtherPropOwner2]][cdMessage]);
		}
		else
		{
			format(otherprop, sizeof(otherprop), "O%i:\t"BLUE_E"Furniture Store[owner]\t"WHITE_E"%s", pData[playerid][pOtherPropOwner2], storeData[pData[playerid][pOtherPropOwner2]][storeName]);
		}*/
	}
	else if(pData[playerid][pOtherPropOwner3] != -1)
	{
		usedoslot = 1;
		/*if(pData[playerid][pOtherPropOwner3] == CarDealershipInfo[pData[playerid][pOtherPropOwner3]][cdID])
		{
			format(otherprop, sizeof(otherprop), "O%i:\t"BLUE_E"Car Dealership[owner]\t"WHITE_E"%s", pData[playerid][pOtherPropOwner3], CarDealershipInfo[pData[playerid][pOtherPropOwner3]][cdMessage]);
		}
		else
		{
			format(otherprop, sizeof(otherprop), "O%i:\t"BLUE_E"Furniture Store[owner]\t"WHITE_E"%s", pData[playerid][pOtherPropOwner3], storeData[pData[playerid][pOtherPropOwner3]][storeName]);
		}*/
	}

	//format(msg2, sizeof(msg2), "1.\t(%d/%d)\tResidential Properties:\n%s", msg2, usedhslot, houseslot, house);
	//format(msg2, sizeof(msg2), "2.\t(%d/%d)\tCommercial Properties:\n%s", msg2, usedcslot, commerslot, commercial);
	//format(msg2, sizeof(msg2), "3.\t(%d/%d)\tOther Properties:\n%s", msg2, usedoslot, otherslot, otherprop);
	
	format(msg2, sizeof(msg2), "1.\t(%d/%d)\tResidential Properties:\n%s\n2.\t(%d/%d)\tCommercial Properties:\n%s\n3.\t(%d/%d)\tOther Properties", 
	usedhslot, 
	houseslot, 
	house, 
	usedcslot, 
	commerslot, 
	commercial, 
	usedoslot, 
	otherslot
	);

	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_LIST, "Owned Properties", msg2, "Close", "");
}

CMD:delays(playerid)
{
	if(pData[playerid][IsLoggedIn] == false)
		return Error(playerid, "You must logged in!");
	/*new paycheck = 3600 - pData[playerid][pPaycheck];
	if(paycheck < 1)
	{
		paycheck = 0;
	}*/
	new irwan[700], string[700];
  	strcat(irwan, "Name\tMinute\n");
	if(pData[playerid][pPaycheck] > 1)
	{
		format(string, sizeof(string), "Paycheck\t%d\n", pData[playerid][pPaycheck]/60);
		strcat(irwan, string);
	}  
	else
	{
		format(string, sizeof(string), "Paycheck\t0\n", pData[playerid][pPaycheck]/60);
		strcat(irwan, string);
	}
	if(pData[playerid][pJobTime] > 1)
	{
		format(string, sizeof(string), "Job\t%d\n", pData[playerid][pJobTime]/60);
		strcat(irwan, string);
	}
	else
	{
		format(string, sizeof(string), "Job\t0\n", pData[playerid][pJobTime]/60);
		strcat(irwan, string);
	}
	if(pData[playerid][pSideJobTime] > 1)
	{
		format(string, sizeof(string), "SideJob\t%d\n", pData[playerid][pSideJobTime]/60);
		strcat(irwan, string);
	}
	else
	{
		format(string, sizeof(string), "SideJob\t0\n", pData[playerid][pSideJobTime]/60);
		strcat(irwan, string);
	}
	if(pData[playerid][pSideJobTimeBus] > 1)
	{
		format(string, sizeof(string), "Bus Driver\t%d\n", pData[playerid][pSideJobTimeBus]/60);
		strcat(irwan, string);
	}
	else
	{
		format(string, sizeof(string), "Bus Driver\t0\n", pData[playerid][pSideJobTimeBus]/60);
		strcat(irwan, string);
	}
	if(pData[playerid][pSideJobTimeSweap] > 1)
	{
		format(string, sizeof(string), "Sweeper \t%d\n", pData[playerid][pSideJobTimeSweap]/60);
		strcat(irwan, string);
	}
	else
	{
		format(string, sizeof(string), "Sweeper \t0\n", pData[playerid][pSideJobTimeSweap]/60);
		strcat(irwan, string);
	}
	if(pData[playerid][pHaulingTime] > 1)
	{
		format(string, sizeof(string), "Hauling\t%d\n", pData[playerid][pHaulingTime]/60);
		strcat(irwan, string);
	}
	else
	{
		format(string, sizeof(string), "Hauling\t0\n", pData[playerid][pHaulingTime]/60);
		strcat(irwan, string);
	}
	if(pData[playerid][pSideJobsTrash] > 1)
	{
		format(string, sizeof(string), "Trash Collector\t%d\n", pData[playerid][pSideJobsTrash]/60);
		strcat(irwan, string);
	}
	else
	{
		format(string, sizeof(string), "Trash Collector\t0\n", pData[playerid][pSideJobsTrash]/60);
		strcat(irwan, string);
	}
	if(pData[playerid][pPizzaTime] > 1)
	{
		format(string, sizeof(string), "Pizza Courier\t%d\n", pData[playerid][pPizzaTime]/60);
		strcat(irwan, string);
	}
	else
	{
		format(string, sizeof(string), "Pizza Courier\t0\n", pData[playerid][pPizzaTime]/60);
		strcat(irwan, string);
	}
	if(pData[playerid][pSideJobsForklift] > 1)
	{
		format(string, sizeof(string), "Forklift Driver\t%d\n", pData[playerid][pSideJobsForklift]/60);
		strcat(irwan, string);
	}
	else
	{
		format(string, sizeof(string), "Forklift Driver\t0\n", pData[playerid][pSideJobsForklift]/60);
		strcat(irwan, string);
	}
	if(pData[playerid][pDelayTruckerDeli] > 1)
	{
		format(string, sizeof(string), "Truck Delivery \t%d\n", pData[playerid][pDelayTruckerDeli]/60);
		strcat(irwan, string);
	}
	else
	{
		format(string, sizeof(string), "Truck Delivery \t0\n", pData[playerid][pDelayTruckerDeli]/60);
		strcat(irwan, string);
	}
	if(pData[playerid][pDelayFishing] > 1)
	{
		format(string, sizeof(string), "Fishing\t%d\n", pData[playerid][pDelayFishing]/60);
		strcat(irwan, string);
	}
	else
	{
		format(string, sizeof(string), "Fishing\t0\n", pData[playerid][pDelayFishing]/60);
		strcat(irwan, string);
	}
	if(pData[playerid][pAdsTime] > 1)
	{
		format(string, sizeof(string), "Delay Advertisement \t%d\n", pData[playerid][pAdsTime]/60);
		strcat(irwan, string);
	}
	else
	{
		format(string, sizeof(string), "Delay Advertisement \t0\n", pData[playerid][pAdsTime]/60);
		strcat(irwan, string);		
	}
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Delays Player", irwan, "Close", "");
	return 1;
}

CMD:newage(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 431.1708,2419.5818,356.2569)) return Error(playerid, "Anda harus berada di City Hall!");
	//if(pData[playerid][pIDCard] != 0) return Error(playerid, "Anda sudah memiliki ID Card!");
	if(GetPlayerMoney(playerid) < 300) return Error(playerid, "Anda butuh $3.00 untuk mengganti tgl lahir anda!");
	if(pData[playerid][IsLoggedIn] == false) return Error(playerid, "Anda harus login terlebih dahulu!");
	ShowPlayerDialog(playerid, DIALOG_CHANGEAGE, DIALOG_STYLE_INPUT, "Tanggal Lahir", "Masukan tanggal lahir (Tgl/Bulan/Tahun): 15/04/1998", "Change", "Cancel");
	return 1;
}

CMD:cv(playerid, params[])
{
	if(!pData[playerid][pVip])
        return Error(playerid, "Hanya member donatur yang dapat menggunakan perintah ini!");
	
	if(isnull(params))
		return Usage(playerid, "/cv [text]");

	if(strlen(params) > 128)
		return Error(playerid, "Text hanya dibatasi sebanyak 128 karakter!");

	foreach (new i : Player) 
	{
		if(pData[i][pVip]) 
		{
			if(pData[i][pTogVip] == 0)
			{
				SendClientMessageEx(i, COLOR_PURPLE, "* (VIP Level %d) %s: %s", pData[playerid][pVip], ReturnName(playerid), params);	
			}	
		}	
	}
	return 1;
}

CMD:newrek(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1429.3341,-985.9102,996.1050)) return Error(playerid, "Anda harus berada di Bank!");
	if(GetPlayerMoney(playerid) < 50) return Error(playerid, "Not enough money!");
	new query[128], rand = RandomEx(111111, 999999);
	new rek = rand+pData[playerid][pID];
	mysql_format(g_SQL, query, sizeof(query), "SELECT brek FROM players WHERE brek='%d'", rek);
	mysql_tquery(g_SQL, query, "BankRek", "id", playerid, rek);
	SendClientMessage(playerid, COLOR_ARWIN, "BANK: "WHITE_E"New rekening bank!");
	GivePlayerMoneyEx(playerid, -50);
	Server_AddMoney(50);
	return 1;
}

/*CMD:bank(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1429.3341,-985.9102,996.1050)) return Error(playerid, "Anda harus berada di bank point!");
	new tstr[128];
	format(tstr, sizeof(tstr), ""ORANGE_E"No Rek: "LB_E"%d", pData[playerid][pBankRek]);
	ShowPlayerDialog(playerid, DIALOG_BANK, DIALOG_STYLE_LIST, tstr, "Check Balance\nSign Paycheck", "Select", "Cancel");
	return 1;
}*/

CMD:signcheck(playerid, params[])
{
	if(pData[playerid][pVip] > 1)
	{
		if(pData[playerid][pPaycheck] == 0)
		{
			DisplayPaycheck(playerid);
		}
		else
		{
			new String[500];
			format(String, sizeof(String),"ERROR: Kamu harus menunggu %d Menit untuk melakukan signcheck", pData[playerid][pPaycheck]/60);
			SendClientMessage(playerid, COLOR_GRAD2, String);
			return 1;
		}
	}
	else if(IsPlayerInRangeOfPoint(playerid, 5.0, 1429.3341,-985.9102,996.1050))
	{
		if(pData[playerid][pPaycheck] == 0)
		{
			DisplayPaycheck(playerid);
		}
		else
		{
			new String[500];
			format(String, sizeof(String),"ERROR: Kamu harus menunggu %d Menit untuk melakukan signcheck", pData[playerid][pPaycheck]/60);
			SendClientMessage(playerid, COLOR_GRAD2, String);
			return 1;
		}
	}
	else
	{
		SendClientMessageEx(playerid, COLOR_GREY, "You should be at the bank.");
		return 1;
	}
	return 1;
}

CMD:license(playerid, params[])
{
	new giveplayerid;
	if(sscanf(params, "u", giveplayerid))
	{
		SendClientMessageEx(playerid, COLOR_ARWIN, "LICENSE: "WHITE_E"Your license");
		SendClientMessageEx(playerid, COLOR_ARWIN, "1. {00FFFF}Driver license: %s", GetLicenseDriver(playerid));
		SendClientMessageEx(playerid, COLOR_ARWIN, "2. {00FFFF}Flying license: %s", GetLicenseFly(playerid));
		SendClientMessageEx(playerid, COLOR_ARWIN, "3. {00FFFF}Boating license: %s", GetLicenseBoat(playerid));
		SendClientMessageEx(playerid, COLOR_ARWIN, "4. {00FFFF}Heavy Truck license: %s", GetLicenseTrucker(playerid));
		SendClientMessageEx(playerid, COLOR_ARWIN, "5. {00FFFF}Lumberjack license: %s", GetLicenseLumber(playerid));
		SendClientMessageEx(playerid, COLOR_ARWIN, "6. {00FFFF}Weapon license: %s", GetLicenseGun(playerid));
		return 1;
	}
	if(!IsPlayerConnected(giveplayerid) || !NearPlayer(playerid, giveplayerid, 4.0))
		return Error(playerid, "The specified player is disconnected or not near you.");

	SendClientMessageEx(giveplayerid, COLOR_ARWIN, "LICENSE: "WHITE_E"Your license");
	SendClientMessageEx(giveplayerid, COLOR_ARWIN, "1. {00FFFF}Driver license: %s", GetLicenseDriver(playerid));
	SendClientMessageEx(giveplayerid, COLOR_ARWIN, "2. {00FFFF}Flying license: %s", GetLicenseFly(playerid));
	SendClientMessageEx(giveplayerid, COLOR_ARWIN, "3. {00FFFF}Boating license: %s", GetLicenseBoat(playerid));
	SendClientMessageEx(giveplayerid, COLOR_ARWIN, "4. {00FFFF}Heavy Truck license: %s", GetLicenseTrucker(playerid));
	SendClientMessageEx(giveplayerid, COLOR_ARWIN, "5. {00FFFF}Lumberjack license: %s", GetLicenseLumber(playerid));
	SendClientMessageEx(giveplayerid, COLOR_ARWIN, "6. {00FFFF}Weapon license: %s", GetLicenseGun(playerid));
	return 1;
}

CMD:showvehlic(playerid, params[])
{
    new string[500], giveplayerid, vehid;
    if(sscanf(params, "ud", giveplayerid, vehid)) return SendClientMessageEx(playerid, COLOR_ARWIN, "KEGUNAAN: "WHITE_E"/showvehlic [playerid] [vehid]");
	if(!IsPlayerConnected(giveplayerid) || !NearPlayer(playerid, giveplayerid, 4.0))
		return Error(playerid, "The specified player is disconnected or not near you.");
	if(vehid == INVALID_VEHICLE_ID) return Error(playerid, "Invalid id");
	foreach(new i : PVehicles)
	{
		if(vehid == pvData[i][cVeh])
		{
			if(pvData[i][cOwner] == pData[playerid][pID])
			{
				SendClientMessageEx(giveplayerid, COLOR_YELLOW,"=================[Vehicle Ownership]=================\n");
				format(string, sizeof(string), "Vehicle: {FFFF00}%s\n", GetVehicleModelName(pvData[i][cModel]));
				SendClientMessage(giveplayerid, COLOR_ARWIN, string);
				format(string, sizeof(string), "Insurances: {FFFF00}%d\n", pvData[i][cInsu]);
				SendClientMessage(giveplayerid, COLOR_ARWIN, string);
				format(string, sizeof(string), "Plate: {FFFF00}%s\n", pvData[i][cPlate]);
				SendClientMessage(giveplayerid, COLOR_ARWIN, string);
			 	if(pvData[i][cMesinUpgrade] == 1)
				{
				    SendClientMessageEx(giveplayerid, COLOR_ARWIN,"Upgrades:\n");
					format(string, sizeof(string), "{FFFFFF}- {00FF00}Engine\n");
			   		SendClientMessageEx(giveplayerid, COLOR_ARWIN, string);
			 	}
			 	if(pvData[i][pvBodyUpgrade] == 1)
				{
					format(string, sizeof(string), "{FFFFFF}- {00FF00}Body");
					SendClientMessageEx(giveplayerid, COLOR_ARWIN, string);
			 	}
			}
			else return Error(playerid, "ID kendaraan ini bukan punya mu! gunakan /v my(/mypv) untuk mencari ID.");
		}
	}
	return 1;
}

CMD:pay(playerid, params[])
{
    new otherid, cash[32], mstr[128];
    new dollars, cents, totalcash[25];
    if(sscanf(params, "us[32]", otherid, cash)) return SendClientMessage(playerid, COLOR_GREY, "/pay [playerid] [Jumlah]");

	if(!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 4.0))
        return Error(playerid, "The specified player is disconnected or not near you.");

    if(strfind(cash, ".", true) != -1)
    {
		sscanf(cash, "p<.>dd", dollars, cents);
		format(totalcash, sizeof(totalcash), "%d%02d", dollars, cents);

	    if(GetPlayerMoney(playerid) >= strval(totalcash))
	    {
			if(IsPlayerConnected(otherid))
			{
				if(strval(totalcash) < 0) return SendClientMessageEx(playerid, COLOR_GREY, "Tidak bisa dibawah $0.00");
				if(strval(totalcash) > 10000) return SendClientMessageEx(playerid, COLOR_GREY, "Tidak bisa diatas $10.000.00");
			   	GivePlayerMoneyEx(otherid, strval(totalcash));
	       		GivePlayerMoneyEx(playerid, -strval(totalcash));
				format(mstr, sizeof(mstr), "PAY: "WHITE_E"You have sent %s(%i) "GREEN_E"$%s", ReturnName(otherid), otherid, FormatMoney(strval(totalcash)));
				SendClientMessage(playerid, COLOR_ARWIN, mstr);
				format(mstr, sizeof(mstr), "PAY: "WHITE_E"%s(%i) has sent you "GREEN_E"$%s", ReturnName(playerid), playerid, FormatMoney(strval(totalcash)));
				SendClientMessage(otherid, COLOR_ARWIN, mstr);
				InfoTD_MSG(playerid, 3500, "~g~~h~Money Sent!");
				InfoTD_MSG(otherid, 3500, "~g~~h~Money received!");
				ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
				ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
				new query[512];
				mysql_format(g_SQL, query, sizeof(query), "INSERT INTO logpay (player,playerid,toplayer,toplayerid,ammount,time) VALUES('%s','%d','%s','%d','%d',UNIX_TIMESTAMP())", pData[playerid][pName], pData[playerid][pID], pData[otherid][pName], pData[otherid][pID], strval(totalcash));
				mysql_tquery(g_SQL, query);															
			}
			else SendClientMessage(playerid, COLOR_GREY, "Player yang anda tuju sedang tidak online.");
		}
		else SendClientMessage(playerid, COLOR_GREY, "Anda tidak memiliki uang sebesar itu.");
	}
	else
	{
		sscanf(cash, "d", dollars);
		format(totalcash, sizeof(totalcash), "%d00", dollars);
		if(IsPlayerConnected(otherid) && otherid != playerid)
	    {
		    if(GetPlayerMoney(playerid) >= strval(totalcash))
		    {
				if(IsPlayerConnected(otherid))
				{
					if(strval(totalcash) < 0) return SendClientMessageEx(playerid, COLOR_GREY, "Tidak bisa dibawah $0.00");
					if(strval(totalcash) < 10000) return SendClientMessageEx(playerid, COLOR_GREY, "Tidak bisa diatas $100.000.00");
			       	GivePlayerMoneyEx(playerid, -strval(totalcash));
		     		GivePlayerMoneyEx(otherid, strval(totalcash));
					format(mstr, sizeof(mstr), "PAY: "WHITE_E"You have sent %s(%i) "GREEN_E"$%s", ReturnName(otherid), otherid, FormatMoney(strval(totalcash)));
					SendClientMessage(playerid, COLOR_ARWIN, mstr);
					format(mstr, sizeof(mstr), "PAY: "WHITE_E"%s(%i) has sent you "GREEN_E"$%s", ReturnName(playerid), playerid, FormatMoney(strval(totalcash)));
					SendClientMessage(otherid, COLOR_ARWIN, mstr);
					InfoTD_MSG(playerid, 3500, "~g~~h~Money Sent!");
					InfoTD_MSG(otherid, 3500, "~g~~h~Money received!");
					ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
					ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
					new query[512];
					mysql_format(g_SQL, query, sizeof(query), "INSERT INTO logpay (player,playerid,toplayer,toplayerid,ammount,time) VALUES('%s','%d','%s','%d','%d',UNIX_TIMESTAMP())", pData[playerid][pName], pData[playerid][pID], pData[otherid][pName], pData[otherid][pID], strval(totalcash));
					mysql_tquery(g_SQL, query);		
					}
				else SendClientMessage(playerid, COLOR_GREY, "Player yang anda tuju sedang tidak online.");
			}
			else SendClientMessage(playerid, COLOR_GREY, "Anda tidak memiliki uang sebesar itu.");
		}
	}
    return 1;
}

CMD:transfer(playerid, params[])
{
    new otherid, cash[32], mstr[128];
    new dollars, cents, totalcash[25];
    if(sscanf(params, "us[32]", otherid, cash)) return SendClientMessage(playerid, COLOR_GREY, "/pay [playerid] [Jumlah]");

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "The specified player is disconnected.");

    if(strfind(cash, ".", true) != -1)
    {
		sscanf(cash, "p<.>dd", dollars, cents);
		format(totalcash, sizeof(totalcash), "%d%02d", dollars, cents);

	    if(GetPlayerMoney(playerid) >= strval(totalcash))
	    {
			if(IsPlayerConnected(otherid))
			{
				if(strval(totalcash) < 0) return SendClientMessageEx(playerid, COLOR_GREY, "Tidak bisa dibawah $0.00");
				if(strval(totalcash) > 10000) return SendClientMessageEx(playerid, COLOR_GREY, "Tidak bisa diatas $10.000.00");
				GivePlayerMoneyEx(playerid,-strval(totalcash));
				pData[otherid][pBankMoney]=pData[otherid][pBankMoney]+strval(totalcash);
				
				format(mstr, sizeof(mstr), "BANK: "WHITE_E"You have sent %s(%i) "GREEN_E"$%s", ReturnName(otherid), otherid, FormatMoney(strval(totalcash)));
				SendClientMessage(playerid, COLOR_ARWIN, mstr);
				format(mstr, sizeof(mstr), "BANK: "WHITE_E"%s(%i) has sent you "GREEN_E"$%s", ReturnName(playerid), playerid, FormatMoney(strval(totalcash)));
				SendClientMessage(otherid, COLOR_ARWIN, mstr);
				InfoTD_MSG(playerid, 3500, "~g~~h~Money Sent!");
				InfoTD_MSG(otherid, 3500, "~g~~h~Money received!");
				ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
				ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
				new query[512];
				mysql_format(g_SQL, query, sizeof(query), "INSERT INTO logtransfer (player,playerid,toplayer,toplayerid,ammount,time) VALUES('%s','%d','%s','%d','%d',UNIX_TIMESTAMP())", pData[playerid][pName], pData[playerid][pID], pData[otherid][pName], pData[otherid][pID], strval(totalcash));
				mysql_tquery(g_SQL, query);															
			}
			else SendClientMessage(playerid, COLOR_GREY, "Player yang anda tuju sedang tidak online.");
		}
		else SendClientMessage(playerid, COLOR_GREY, "Anda tidak memiliki uang sebesar itu.");
	}
	else
	{
		sscanf(cash, "d", dollars);
		format(totalcash, sizeof(totalcash), "%d00", dollars);
		if(IsPlayerConnected(otherid) && otherid != playerid)
	    {
		    if(GetPlayerMoney(playerid) >= strval(totalcash))
		    {
				if(IsPlayerConnected(otherid))
				{
					if(strval(totalcash) < 0) return SendClientMessageEx(playerid, COLOR_GREY, "Tidak bisa dibawah $0.00");
					if(strval(totalcash) < 10000) return SendClientMessageEx(playerid, COLOR_GREY, "Tidak bisa diatas $100.000.00");
			       	GivePlayerMoneyEx(playerid,-strval(totalcash));
					pData[otherid][pBankMoney]=pData[otherid][pBankMoney]+strval(totalcash);
					format(mstr, sizeof(mstr), "BANK: "WHITE_E"You have sent %s(%i) "GREEN_E"$%s", ReturnName(otherid), otherid, FormatMoney(strval(totalcash)));
					SendClientMessage(playerid, COLOR_ARWIN, mstr);
					format(mstr, sizeof(mstr), "BANK: "WHITE_E"%s(%i) has sent you "GREEN_E"$%s", ReturnName(playerid), playerid, FormatMoney(strval(totalcash)));
					SendClientMessage(otherid, COLOR_ARWIN, mstr);
					InfoTD_MSG(playerid, 3500, "~g~~h~Money Sent!");
					InfoTD_MSG(otherid, 3500, "~g~~h~Money received!");
					ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
					ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
					new query[512];
					mysql_format(g_SQL, query, sizeof(query), "INSERT INTO logtransfer (player,playerid,toplayer,toplayerid,ammount,time) VALUES('%s','%d','%s','%d','%d',UNIX_TIMESTAMP())", pData[playerid][pName], pData[playerid][pID], pData[otherid][pName], pData[otherid][pID], strval(totalcash));
					mysql_tquery(g_SQL, query);		
					}
				else SendClientMessage(playerid, COLOR_GREY, "Player yang anda tuju sedang tidak online.");
			}
			else SendClientMessage(playerid, COLOR_GREY, "Anda tidak memiliki uang sebesar itu.");
		}
	}
    return 1;
}

CMD:balance(playerid)
{
	new String[500];
	format(String, sizeof(String), "BANK: {ffffff}Total cash stored in bank: {ffff00}$%s", FormatMoney(pData[playerid][pBankMoney]));
	SendClientMessageEx(playerid, COLOR_ARWIN, String);
	return 1;
}

CMD:deposit(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, 1429.3341,-985.9102,996.1050))
	{
		SendClientMessageEx(playerid, COLOR_GREY, "ERROR: You need to be at the bank to perform this command!");
		return 1;
	}
	new String[500], amount[32], dollars, cents, duit[32];
	if(sscanf(params, "s[32]", amount))
	{
		SendClientMessageEx(playerid, COLOR_WHITE, "KEGUNAAN: /deposit [amount(dollars.cents)]");
  		return 1;
	}
	if(strfind(amount, ".", true) != -1)
	{
	   	sscanf(amount, "p<.>dd", dollars, cents);
	    format(duit, sizeof(duit), "%d%02d", dollars, cents);
		if (strval(duit) > GetPlayerMoney(playerid))
		{
			SendClientMessageEx(playerid, COLOR_GREY, "Anda tidak memiliki uang sebesar itu.");
			return 1;
		}
		if(strval(duit) < 0) { SendClientMessageEx(playerid,COLOR_WHITE,"ERROR: Tidak bisa dibawah $0.00 ."); return 1; }
		GivePlayerMoneyEx(playerid,-strval(duit));
		pData[playerid][pBankMoney]=strval(duit)+pData[playerid][pBankMoney];
		new query[512];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET bmoney=%d,money=%d WHERE reg_id=%d", pData[playerid][pBankMoney], pData[playerid][pMoney], pData[playerid][pID]);
		mysql_tquery(g_SQL, query);
		format(String, sizeof(String), "BANK: {ffffff}You've stored {ffff00}$%s{ffffff} into your bank account", FormatMoney(strval(duit)));
		SendClientMessageEx(playerid, COLOR_ARWIN, String);
		format(String, sizeof(String), "BALANCE: {ffff00}$%s", FormatMoney(pData[playerid][pBankMoney]));
		SendClientMessageEx(playerid, COLOR_ARWIN, String);
	}
	else
	{
	    sscanf(amount, "d", dollars);
	    format(duit, sizeof(duit), "%d00", dollars);
		if (strval(duit) > GetPlayerMoney(playerid))
		{
			SendClientMessageEx(playerid, COLOR_GREY, "Anda tidak memiliki uang sebesar itu.");
			return 1;
		}
		if(strval(duit) < 0) { SendClientMessageEx(playerid,COLOR_WHITE,"ERROR: Tidak bisa dibawah $0.00 ."); return 1; }
		GivePlayerMoneyEx(playerid,-strval(duit));
		pData[playerid][pBankMoney]=strval(duit)+pData[playerid][pBankMoney];
		new query[512];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET bmoney=%d,money=%d WHERE reg_id=%d", pData[playerid][pBankMoney], pData[playerid][pMoney], pData[playerid][pID]);
		mysql_tquery(g_SQL, query);
		format(String, sizeof(String), "BANK: {ffffff}You've stored {ffff00}$%s{ffffff} into your bank account", FormatMoney(strval(duit)));
		SendClientMessageEx(playerid, COLOR_ARWIN, String);
		format(String, sizeof(String), "BALANCE: {ffff00}$%s", FormatMoney(pData[playerid][pBankMoney]));
		SendClientMessageEx(playerid, COLOR_ARWIN, String);
	}
	return 1;
}

CMD:withdraw(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, 1429.3341,-985.9102,996.1050))
	{
		SendClientMessageEx(playerid, COLOR_GREY, "ERROR: You need to be at the bank to perform this command!");
		return 1;
	}
	new String[500], amount[32], dollars, cents, duit[32];

	if(sscanf(params, "s[32]", amount))
	{
		SendClientMessageEx(playerid, COLOR_GRAD2, "KEGUNAAN: /withdraw [Jumlah]");
		format(String, sizeof(String), "BANK: "WHITE_E"Anda memiliki uang sebesar "GREEN_E"$%s "WHITE_E"di dalam Akun ATM Anda.", FormatMoney(pData[playerid][pBankMoney]));
		SendClientMessageEx(playerid, COLOR_ARWIN, String);
		return 1;
	}
	if(strfind(amount, ".", true) != 1)
	{
	    	sscanf(amount, "p<.>dd", dollars, cents);
	        format(duit, sizeof(duit), "%d%02d", dollars, cents);
			if(strval(duit) > pData[playerid][pBankMoney])
			{
				SendClientMessageEx(playerid, COLOR_GRAD2, "Anda tidak memiliki uang sebesar itu di dalam Akun ATM anda!");
				return 1;
			}
			if(strval(duit) < 0) return SendClientMessageEx(playerid, COLOR_GREY, "Tidak bisa dibawah $0.00");
			GivePlayerMoneyEx(playerid,strval(duit));
			pData[playerid][pBankMoney]=pData[playerid][pBankMoney]-strval(duit);
			format(String, sizeof(String), "BANK: {ffffff}You've withdrawn {ffff00}$%s{ffffff} from your bank account", FormatMoney(strval(duit)));
			SendClientMessageEx(playerid, COLOR_ARWIN, String);
			format(String, sizeof(String), "BALANCE: {ffff00}$%s",FormatMoney(pData[playerid][pBankMoney]));
			SendClientMessageEx(playerid, COLOR_ARWIN, String);
	}
	else
	{
	    	sscanf(amount, "d", dollars);
	        format(duit, sizeof(duit), "%d00", dollars);
			if(strval(duit) > pData[playerid][pBankMoney])
			{
				SendClientMessageEx(playerid, COLOR_GRAD2, "Anda tidak memiliki uang sebesar itu di dalam Akun ATM anda!");
				return 1;
			}
			if(strval(duit) < 0) return SendClientMessageEx(playerid, COLOR_GREY, "Tidak bisa dibawah $0.00");
			GivePlayerMoneyEx(playerid,strval(duit));
			pData[playerid][pBankMoney]=pData[playerid][pBankMoney]-strval(duit);
			format(String, sizeof(String), "BANK: {ffffff}You've withdrawn {ffff00}$%s{ffffff} from your bank account", FormatMoney(strval(duit)));
			SendClientMessageEx(playerid, COLOR_ARWIN, String);
			format(String, sizeof(String), "BALANCE: {ffff00}$%s",FormatMoney(pData[playerid][pBankMoney]));
			SendClientMessageEx(playerid, COLOR_ARWIN, String);
	}
	return 1;
}

CMD:stats(playerid, params[])
{
	if(pData[playerid][IsLoggedIn] == false)
	{
	    Error(playerid, "You must be logged in to check statistics!");
	    return 1;
	}
	
	DisplayStats(playerid, playerid);
	return 1;
}

CMD:togauto(playerid, params[])
{
	new paycheck[64], mask[64], chat[64], sealtbeath[64], helm[64], ammo[64];

	if(pData[playerid][pTogPaycheck] == 0)
	{
		paycheck = ""RED_E"Disable";
	}
	else
	{
		paycheck = ""LG_E"Enable";
	}
	if(pData[playerid][pTogHelmet] == 0)
	{
		helm = ""RED_E"Disable";
	}
	else
	{
		helm = ""LG_E"Enable";
	}
	if(pData[playerid][pTogChat] == 0)
	{
		chat = ""RED_E"Disable";
	}
	else
	{
		chat = ""LG_E"Enable";
	}
	if(pData[playerid][pTogMask] == 0)
	{
		mask = ""RED_E"Disable";
	}
	else
	{
		mask = ""LG_E"Enable";
	}
	if(pData[playerid][pTogSealtbelt] == 0)
	{
		sealtbeath = ""RED_E"Disable";
	}
	else
	{
		sealtbeath = ""LG_E"Enable";
	}
	if(pData[playerid][pTogAmmo] == 0)
	{
		ammo = ""RED_E"Disable";
	}
	else
	{
		ammo = ""LG_E"Enable";
	}
	new String[512], S3MP4K[512];
	strcat(S3MP4K, "Option\tSetting\n");
	format(String, sizeof(String),"Automatic Paycheck:\t%s\n", paycheck);
	strcat(S3MP4K, String);
	format(String, sizeof(String),"Automatic Sealtbelt:\t%s\n", sealtbeath);
	strcat(S3MP4K, String);
	format(String, sizeof(String),"Auto-Wear Motorcycle Helmet:\t%s\n", helm);
	strcat(S3MP4K, String);
	format(String, sizeof(String),"Auto Upper-case Chat:\t%s\n", chat);
	strcat(S3MP4K, String);
	format(String, sizeof(String),"Enable Mask on Login:\t%s\n", mask);
	strcat(S3MP4K, String);
	format(String, sizeof(String),"Toggle TD Ammo:\t%s\n", ammo);
	strcat(S3MP4K, String);
	ShowPlayerDialog(playerid, DIALOG_TOGAUTO, DIALOG_STYLE_TABLIST_HEADERS, "Toggle Auto Settings", S3MP4K, "Toggle", "Cancel");
	return 1;
}

CMD:settings(playerid)
{
	if(pData[playerid][IsLoggedIn] == false)
	{
	    Error(playerid, "You must be logged in to check statistics!");
	    return 1;
	}
	
	new str[1024], hbemode[64], togpm[64], toglog[64], togads[64], togwt[64], toguang[64], togradio[64];
	if(pData[playerid][pHBEMode] == 1)
	{
		hbemode = ""LG_E"Simple";
	}
	else if(pData[playerid][pHBEMode] == 2)
	{
		hbemode = ""LG_E"Modern";
	}
	else
	{
		hbemode = ""RED_E"Disable";
	}
	if(pData[playerid][pTogPM] == 0)
	{
		togpm = ""RED_E"Disable";
	}
	else
	{
		togpm = ""LG_E"Enable";
	}
	
	if(pData[playerid][pTogLog] == 0)
	{
		toglog = ""RED_E"Disable";
	}
	else
	{
		toglog = ""LG_E"Enable";
	}
	
	if(pData[playerid][pTogAds] == 0)
	{
		togads = ""RED_E"Disable";
	}
	else
	{
		togads = ""LG_E"Enable";
	}
	
	if(pData[playerid][pTogWT] == 0)
	{
		togwt = ""RED_E"Disable";
	}
	else
	{
		togwt = ""LG_E"Enable";
	}

	if(pData[playerid][pTogMoney] == 0)
	{
		toguang = ""RED_E"Disable";
	}
	else
	{
		toguang = ""LG_E"Enable";
	}
	if(pData[playerid][pTogRadio] == 0)
	{
		togradio = ""RED_E"Disable";
	}
	else
	{
		togradio = ""LG_E"Enable";
	}
	format(str, sizeof(str), "HBE Mode:\t%s\nToggle PM:\t%s\nToggle Log Server:\t%s\nToggle Ads:\t%s\nToggle WT:\t%s\nToggle MoneyCents:\t%s\nToggle Radio:\t%s",
	hbemode, 
	togpm,
	toglog,
	togads,
	togwt,
	toguang,
	togradio
	);
	
	ShowPlayerDialog(playerid, DIALOG_SETTINGS, DIALOG_STYLE_LIST, "Settings", str, "Set", "Close");
	return 1;
}

CMD:items(playerid, params[])
{
	if(pData[playerid][IsLoggedIn] == false)
	{
	    Error(playerid, "You must be logged in to check items!");
	    return true;
	}
	DisplayItems(playerid, playerid);
	return 1;
}

CMD:joinjob(playerid, params[])
{	
	if(pData[playerid][pVip] > 3)
	{
		if(pData[playerid][pJob] == 0 || pData[playerid][pJob2] == 0)
		{
			if(pData[playerid][pJob] == 0)
			{
				if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 1685.4528,-1464.4073,13.5469))
				{
					if(pData[playerid][pDriveLic] < 1) return Error(playerid, "You don't have a driver's license");
					pData[playerid][pGetJob] = 1;
					SendClientMessageEx(playerid, COLOR_YELLOW, "JOINJOB: {FFFFFF}Jika anda yakin bekerja menjadi Taxi Driver, {00CCFF}'/accept job'{FFFFFF}.");
				}
				else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 2330.1626,-2315.2642,13.5469))
				{
					pData[playerid][pGetJob] = 2;
					
					SendClientMessageEx(playerid, COLOR_YELLOW, "JOINJOB: {FFFFFF}Jika anda yakin bekerja menjadi Mechanic, {00CCFF}'/accept job'{FFFFFF}.");
				}
				else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -1438.4968,-1544.1377,101.7578))
				{
					pData[playerid][pGetJob] = 3;
					
					SendClientMessageEx(playerid, COLOR_YELLOW, "JOINJOB: {FFFFFF}Jika anda yakin bekerja menjadi Lumberjack, {00CCFF}'/accept job'{FFFFFF}.");
				}
				else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -77.1687,-1136.5388,1.0781))
				{
					if(pData[playerid][pDriveLic] < 1) return Error(playerid, "You don't have a driver's license");
					pData[playerid][pGetJob] = 4;
					
					SendClientMessageEx(playerid, COLOR_YELLOW, "JOINJOB: {FFFFFF}Jika anda yakin bekerja menjadi Trucker, {00CCFF}'/accept job'{FFFFFF}.");
				}
				else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -382.7033,-1438.9998,26.1691))
				{
					pData[playerid][pGetJob] = 5;
					
					SendClientMessageEx(playerid, COLOR_YELLOW, "JOINJOB: {FFFFFF}Jika anda yakin bekerja menjadi Farmer, {00CCFF}'/accept job'{FFFFFF}.");
				}
                else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -3807.89, 1312.56, 75.82))
				{
					pData[playerid][pGetJob] = 6;
					
					SendClientMessageEx(playerid, COLOR_YELLOW, "JOINJOB: {FFFFFF}Jika anda yakin bekerja menjadi Arms Dealer, {00CCFF}'/accept job'{FFFFFF}.");
				}
				else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -882.1044,1110.8616,5442.8203))
				{
					pData[playerid][pGetJob] = 7;
					
					SendClientMessageEx(playerid, COLOR_YELLOW, "JOINJOB: {FFFFFF}Jika anda yakin bekerja menjadi Drugs Dealer, {00CCFF}'/accept job'{FFFFFF}.");
				}
				else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -1290.8927,2512.9067,87.0391))
				{
					pData[playerid][pGetJob] = 8;
					
					SendClientMessageEx(playerid, COLOR_YELLOW, "JOINJOB: {FFFFFF}Jika anda yakin bekerja menjadi Smuggle, {00CCFF}'/accept job'{FFFFFF}.");
				}
				else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 1676.1809,-1462.1836,13.5538))
				{
					pData[playerid][pGetJob] = 9;
					
					SendClientMessageEx(playerid, COLOR_YELLOW, "JOINJOB: {FFFFFF}Jika anda yakin bekerja menjadi Builder, {00CCFF}'/accept job'{FFFFFF}.");
				}
				else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 1509.6610, -1060.1007, 25.0625))
				{
					pData[playerid][pGetJob] = 10;
					
					SendClientMessageEx(playerid, COLOR_YELLOW, "JOINJOB: {FFFFFF}Jika anda yakin bekerja menjadi Depositor, {00CCFF}'/accept job'{FFFFFF}.");
				}
				else return Error(playerid, "Anda sudah memiliki job atau tidak berada di dekat pendaftaran job.");
			}
			else if(pData[playerid][pJob2] == 0)
			{
				if(pData[playerid][pJob2] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 1685.4528,-1464.4073,13.5469))
				{
					if(pData[playerid][pDriveLic] < 1) return Error(playerid, "You don't have a driver's license");
					pData[playerid][pGetJob2] = 1;
					SendClientMessageEx(playerid, COLOR_YELLOW, "JOINJOB: {FFFFFF}Jika anda yakin bekerja menjadi Taxi Driver, {00CCFF}'/accept job'{FFFFFF}.");
				}
				else if(pData[playerid][pJob2] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 2330.1626,-2315.2642,13.5469))
				{
					pData[playerid][pGetJob2] = 2;
					SendClientMessageEx(playerid, COLOR_YELLOW, "JOINJOB: {FFFFFF}Jika anda yakin bekerja menjadi Mechanic, {00CCFF}'/accept job'{FFFFFF}.");
				}
				else if(pData[playerid][pJob2] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -1438.4968,-1544.1377,101.7578))
				{
					pData[playerid][pGetJob2] = 3;
					SendClientMessageEx(playerid, COLOR_YELLOW, "JOINJOB: {FFFFFF}Jika anda yakin bekerja menjadi Lumber Jack, {00CCFF}'/accept job'{FFFFFF}.");
				}
				else if(pData[playerid][pJob2] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -77.1687,-1136.5388,1.0781))
				{
					if(pData[playerid][pDriveLic] < 1) return Error(playerid, "You don't have a driver's license");
					pData[playerid][pGetJob2] = 4;
					SendClientMessageEx(playerid, COLOR_YELLOW, "JOINJOB: {FFFFFF}Jika anda yakin bekerja menjadi Trucker, {00CCFF}'/accept job'{FFFFFF}.");
				}
				else if(pData[playerid][pJob2] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -382.7033,-1438.9998,26.1691))
				{
					pData[playerid][pGetJob2] = 5;
					SendClientMessageEx(playerid, COLOR_YELLOW, "JOINJOB: {FFFFFF}Jika anda yakin bekerja menjadi Farmer, {00CCFF}'/accept job'{FFFFFF}.");
				}
                else if(pData[playerid][pJob2] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -3807.89, 1312.56, 75.82))
				{
					pData[playerid][pGetJob2] = 6;
					SendClientMessageEx(playerid, COLOR_YELLOW, "JOINJOB: {FFFFFF}Jika anda yakin bekerja menjadi Arms Dealer, {00CCFF}'/accept job'{FFFFFF}.");
				}
				else if(pData[playerid][pJob2] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -882.1044,1110.8616,5442.8203))
				{
					pData[playerid][pGetJob2] = 7;
					SendClientMessageEx(playerid, COLOR_YELLOW, "JOINJOB: {FFFFFF}Jika anda yakin bekerja menjadi Drugs Dealer, {00CCFF}'/accept job'{FFFFFF}.");
				}
				else if(pData[playerid][pJob2] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -1290.8927,2512.9067,87.0391))
				{
					pData[playerid][pGetJob2] = 8;
					SendClientMessageEx(playerid, COLOR_YELLOW, "JOINJOB: {FFFFFF}Jika anda yakin bekerja menjadi Smuggle, {00CCFF}'/accept job'{FFFFFF}.");
				}
				else if(pData[playerid][pJob2] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 1690.7848,-1530.5797,13.5469))
				{
					pData[playerid][pGetJob2] = 9;
					SendClientMessageEx(playerid, COLOR_YELLOW, "JOINJOB: {FFFFFF}Jika anda yakin bekerja menjadi Builder, {00CCFF}'/accept job'{FFFFFF}.");
				}
				else if(pData[playerid][pJob2] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 1509.6610, -1060.1007, 25.0625))
				{
					pData[playerid][pGetJob2] = 10;
					SendClientMessageEx(playerid, COLOR_YELLOW, "JOINJOB: {FFFFFF}Jika anda yakin bekerja menjadi Depositor, {00CCFF}'/accept job'{FFFFFF}.");
				}
				else return Error(playerid, "Anda sudah memiliki job atau tidak berada di dekat pendaftaran job.");
			}
			else return Error(playerid, "Anda sudah memiliki 2 pekerjaan!");
		}
		else return Error(playerid, "Anda sudah memiliki 2 pekerjaan!");
	}
	else
	{
		if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 1685.4528,-1464.4073,13.5469))
        {
            if(pData[playerid][pDriveLic] < 1) return Error(playerid, "You don't have a driver's license");
            pData[playerid][pGetJob] = 1;
            SendClientMessageEx(playerid, COLOR_YELLOW, "JOINJOB: {FFFFFF}Jika anda yakin bekerja menjadi Taxi Driver, {00CCFF}'/accept job'{FFFFFF}.");
        }
        else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 2330.1626,-2315.2642,13.5469))
        {
            pData[playerid][pGetJob] = 2;
            SendClientMessageEx(playerid, COLOR_YELLOW, "JOINJOB: {FFFFFF}Jika anda yakin bekerja menjadi Mechanic, {00CCFF}'/accept job'{FFFFFF}.");
        }
        else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -1438.4968,-1544.1377,101.7578))
        {
            pData[playerid][pGetJob] = 3;
            SendClientMessageEx(playerid, COLOR_YELLOW, "JOINJOB: {FFFFFF}Jika anda yakin bekerja menjadi Lumber Jack, {00CCFF}'/accept job'{FFFFFF}.");
        }
        else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -77.1687,-1136.5388,1.0781))
        {
            if(pData[playerid][pDriveLic] < 1) return Error(playerid, "You don't have a driver's license");
            pData[playerid][pGetJob] = 4;
            SendClientMessageEx(playerid, COLOR_YELLOW, "JOINJOB: {FFFFFF}Jika anda yakin bekerja menjadi Trucker, {00CCFF}'/accept job'{FFFFFF}.");
        }
        else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -382.7033,-1438.9998,26.1691))
        {
            pData[playerid][pGetJob] = 5;
            SendClientMessageEx(playerid, COLOR_YELLOW, "JOINJOB: {FFFFFF}Jika anda yakin bekerja menjadi Farmer, {00CCFF}'/accept job'{FFFFFF}.");
        }
        else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -3807.89, 1312.56, 75.82))
        {
            pData[playerid][pGetJob] = 6;
            SendClientMessageEx(playerid, COLOR_YELLOW, "JOINJOB: {FFFFFF}Jika anda yakin bekerja menjadi Arms Dealer, {00CCFF}'/accept job'{FFFFFF}.");
        }
        else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -882.1044,1110.8616,5442.8203))
        {
            pData[playerid][pGetJob] = 7;
            SendClientMessageEx(playerid, COLOR_YELLOW, "JOINJOB: {FFFFFF}Jika anda yakin bekerja menjadi Drugs Dealer, {00CCFF}'/accept job'{FFFFFF}.");
        }
        else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -1290.8927,2512.9067,87.0391))
        {
            pData[playerid][pGetJob] = 8;
            SendClientMessageEx(playerid, COLOR_YELLOW, "JOINJOB: {FFFFFF}Jika anda yakin bekerja menjadi Smuggle, {00CCFF}'/accept job'{FFFFFF}.");
        }
        else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 1690.7848,-1530.5797,13.5469))
		{
			pData[playerid][pGetJob] = 9;
			SendClientMessageEx(playerid, COLOR_YELLOW, "JOINJOB: {FFFFFF}Jika anda yakin bekerja menjadi Builder, {00CCFF}'/accept job'{FFFFFF}.");
		}
		else return Error(playerid, "Anda sudah memiliki job atau tidak berada di dekat pendaftaran job.");
	}
	return 1;
}

CMD:frisk(playerid, params[])
{
	new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/frisk [playerid/PartOfName]");

    if(otherid == INVALID_PLAYER_ID || !NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "The specified player is disconnected or not near you.");

    if(otherid == playerid)
        return Error(playerid, "You cannot frisk yourself.");

    pData[otherid][pFriskOffer] = playerid;

    SendClientMessageEx(otherid, COLOR_ARWIN, "FRISK: "WHITE_E"%s has offered to frisk you (type \"/accept frisk or /deny frisk\").", ReturnName(playerid));
    SendClientMessageEx(playerid, COLOR_ARWIN, "FRISK: "WHITE_E"You have offered to frisk %s.", ReturnName(otherid));
	return 1;
}

CMD:accept(playerid, params[])
{
	if(IsPlayerConnected(playerid)) 
	{
        if(isnull(params)) 
		{
            Usage(playerid, "USAGE: /accept [name]");
            Info(playerid, "Names: faction, family, workshop, drag, sharelok, frisk, job, inspect, pk, marriage, cerai");
            return 1;
        }
		if(strcmp(params,"faction",true) == 0) 
		{
            if(IsPlayerConnected(pData[playerid][pFacOffer])) 
			{
                if(pData[playerid][pFacInvite] > 0) 
				{
					if(pData[playerid][pCS] > 0)
					{
						pData[playerid][pFaction] = pData[playerid][pFacInvite];
						pData[playerid][pFactionRank] = 1;
						SendClientMessageEx(playerid, COLOR_ARWIN, "ACCEPT: "WHITE_E"Anda telah menerima invite faction dari %s", pData[pData[playerid][pFacOffer]][pName]);
						SendClientMessageEx(pData[playerid][pFacOffer], COLOR_ARWIN, "ACCEPT: "WHITE_E"%s telah menerima invite faction yang anda tawari", pData[playerid][pName]);
						pData[playerid][pFacInvite] = 0;
						pData[playerid][pFacOffer] = -1;
					}
					else return Error(playerid, "Anda tidak mempunyai CS");
				}
				else
				{
					Error(playerid, "Invalid faction id!");
					return 1;
				}
            }
            else 
			{
                Error(playerid, "Tidak ada player yang menawari anda!");
                return 1;
            }
        }
		if(strcmp(params,"family",true) == 0) 
		{
            if(IsPlayerConnected(pData[playerid][pFamOffer])) 
			{
                if(pData[playerid][pFamInvite] > -1) 
				{
					if(pData[playerid][pCS] > 0)
					{
						pData[playerid][pFamily] = pData[playerid][pFamInvite];
						pData[playerid][pFamilyRank] = 1;
						SendClientMessageEx(playerid, COLOR_ARWIN, "ACCEPT: "WHITE_E"Anda telah menerima invite family dari %s", pData[pData[playerid][pFamOffer]][pName]);
						SendClientMessageEx(pData[playerid][pFamOffer], COLOR_ARWIN, "ACCEPT: "WHITE_E"%s telah menerima invite family yang anda tawari", pData[playerid][pName]);
						pData[playerid][pFamInvite] = 0;
						pData[playerid][pFamOffer] = -1;
					}
					else return Error(playerid, "Anda tidak mempunyai CS");	
				}
				else
				{
					Error(playerid, "Invalid family id!");
					return 1;
				}
            }
            else 
			{
                Error(playerid, "Tidak ada player yang menawari anda!");
                return 1;
            }
        }
		if(strcmp(params,"workshop",true) == 0)
		{
            if(IsPlayerConnected(pData[playerid][pWorkOffer]))
			{
                if(pData[playerid][pWorkInvite] > -1)
				{
					if(pData[playerid][pCS] > 0)
					{
						pData[playerid][pWorkshop] = pData[playerid][pWorkInvite];
						pData[playerid][pWorkshopRank] = 1;
						SendClientMessageEx(playerid, COLOR_ARWIN, "ACCEPT: "WHITE_E"Anda telah menerima invite workshop dari %s", pData[pData[playerid][pWorkOffer]][pName]);
						SendClientMessageEx(pData[playerid][pWorkOffer], COLOR_ARWIN, "ACCEPT: "WHITE_E"%s telah menerima invite workshop yang anda tawari", pData[playerid][pName]);
						pData[playerid][pWorkInvite] = 0;
						pData[playerid][pWorkOffer] = -1;
					}
					else return Error(playerid, "Anda tidak mempunyai CS");	
				}
				else
				{
					Error(playerid, "Invalid workshop id!");
					return 1;
				}
            }
            else
			{
                Error(playerid, "Tidak ada player yang menawari anda!");
                return 1;
            }
        }
		if(strcmp(params,"farm",true) == 0)
		{
            if(IsPlayerConnected(pData[playerid][pLadangOffer]))
			{
                if(pData[playerid][pLadangInvite] > -1)
				{
					if(pData[playerid][pCS] > 0)
					{
						pData[playerid][pLadang] = pData[playerid][pLadangInvite];
						pData[playerid][pLadangRank] = 1;
						SendClientMessageEx(playerid, COLOR_ARWIN, "ACCEPT: "WHITE_E"Anda telah menerima invite Farm dari %s", pData[pData[playerid][pLadangOffer]][pName]);
						SendClientMessageEx(pData[playerid][pLadangOffer], COLOR_ARWIN, "ACCEPT: "WHITE_E"%s telah menerima invite Farm yang anda tawari", pData[playerid][pName]);
						pData[playerid][pLadangInvite] = 0;
						pData[playerid][pLadangOffer] = -1;
					}
					else return Error(playerid, "Anda tidak mempunyai CS");		
				}
				else
				{
					Error(playerid, "Invalid Ladang id!");
					return 1;
				}
            }
            else
			{
                Error(playerid, "Tidak ada player yang menawari anda!");
                return 1;
            }
        }
		else if(strcmp(params,"drag",true) == 0)
		{
			new dragby = GetPVarInt(playerid, "DragBy");
			if(dragby == INVALID_PLAYER_ID || dragby == playerid)
				return Error(playerid, "That player is disconnected.");
        
			if(!NearPlayer(playerid, dragby, 5.0))
				return Error(playerid, "You must be near this player.");
        
			pData[playerid][pDragged] = 1;
			pData[playerid][pDraggedBy] = dragby;

			pData[playerid][pDragTimer] = SetTimerEx("DragUpdate", 1000, true, "ii", dragby, playerid);
			SendNearbyMessage(dragby, 30.0, COLOR_PURPLE, "* %s grabs %s and starts dragging them, (/undrag).", ReturnName(dragby), ReturnName(playerid));
			return true;
		}
		else if(strcmp(params,"sharelok",true) == 0)
		{
			new sharelok = GetPVarInt(playerid, "sharelok");
			if(sharelok == INVALID_PLAYER_ID || sharelok == playerid)
				return Error(playerid, "That player is disconnected.");

			new Float: x,
				Float: y,
				Float: z;

			GetPlayerPos(sharelok, x, y, z);

			EnablePlayerGPS(playerid, x, y, z, "{66cc33}Terakhir kali seorang terlihat di tempat yang ditandai");
			SendNearbyMessage(sharelok, 30.0, COLOR_PURPLE, "* %s berhasil mensharelok ke pemain %s", ReturnName(sharelok), ReturnName(playerid));

			return true;
		}
		else if(strcmp(params,"frisk",true) == 0)
		{
			if(pData[playerid][pFriskOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pFriskOffer]))
				return Error(playerid, "That player not connected!");
			
			if(!NearPlayer(playerid, pData[playerid][pFriskOffer], 5.0))
				return Error(playerid, "You must be near this player.");
				
			DisplayItems(pData[playerid][pFriskOffer], playerid);
			Servers(playerid, "Anda telah berhasil menaccept tawaran frisk kepada %s.", ReturnName(pData[playerid][pFriskOffer]));
			pData[playerid][pFriskOffer] = INVALID_PLAYER_ID;
		}
		else if(strcmp(params,"marriage",true) == 0)
		{
			new String[500];
			if(pData[playerid][pMarriedAccept] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pMarriedAccept]))
				return Error(playerid, "That player not connected!");
			
			if(!NearPlayer(playerid, pData[playerid][pMarriedAccept], 5.0))
				return Error(playerid, "You must be near this player.");

			if(pData[playerid][pGender] == 1 && pData[pData[playerid][pMarriedAccept]][pGender] == 2)
			{
				format(String, sizeof(String), "Priest: %s and %s i pronounce you now... Husband & Wife, you may kiss the bride.", ReturnName(playerid), ReturnName(pData[playerid][pMarriedAccept]));
				SendClientMessageEx(playerid, COLOR_WHITE, String);
		   		format(String, sizeof(String), "Priest: %s and %s i pronounce you now... Husband & Wife, you may kiss the groom.", ReturnName(pData[playerid][pMarriedAccept]), ReturnName(playerid));
				SendClientMessageEx(pData[playerid][pMarriedAccept], COLOR_WHITE, String);
				format(String, sizeof(String), "Marriage News: We have a new lovely couple! {FFFF00}%s {FFFFFF}& {FFFF00}%s have been married.", ReturnName(playerid), ReturnName(pData[playerid][pMarriedAccept]));
				OOCNews(COLOR_WHITE, String);
			}
			else if(pData[playerid][pGender] == 1 && pData[pData[playerid][pMarriedAccept]][pGender] == 1)
			{
				format(String, sizeof(String), "Priest: %s and %s i pronounce you now... Husband & Husband, you may kiss the bride.", ReturnName(playerid), ReturnName(pData[playerid][pMarriedAccept]));
				SendClientMessageEx(playerid, COLOR_WHITE, String);
		   		format(String, sizeof(String), "Priest: %s and %s i pronounce you now... Husband & Husband, you may kiss the groom.", ReturnName(pData[playerid][pMarriedAccept]), ReturnName(playerid));
				SendClientMessageEx(pData[playerid][pMarriedAccept], COLOR_WHITE, String);
				format(String, sizeof(String), "Marriage News: We have a new gay couple! {FFFF00}%s {FFFFFF}& {FFFF00}%s have been married.", ReturnName(playerid), ReturnName(pData[playerid][pMarriedAccept]));
				OOCNews(COLOR_WHITE, String);
			}
			else if(pData[playerid][pGender] == 2 && pData[pData[playerid][pMarriedAccept]][pGender] == 2)
			{
				format(String, sizeof(String), "Priest: %s and %s i pronounce you now... Wife & Wife, you may kiss the Bride.", ReturnName(playerid), ReturnName(pData[playerid][pMarriedAccept]));
				SendClientMessageEx(playerid, COLOR_WHITE, String);
		   		format(String, sizeof(String), "Priest: %s and %s i pronounce you now... Wife & Wife, you may kiss the Groom.", ReturnName(pData[playerid][pMarriedAccept]), ReturnName(playerid));
				SendClientMessageEx(pData[playerid][pMarriedAccept], COLOR_WHITE, String);
				format(String, sizeof(String), "Marriage News: We have a new lesbian couple! {FFFF00}%s {FFFFFF}& {FFFF00}%s have been married.", ReturnName(playerid), ReturnName(pData[playerid][pMarriedAccept]));
				OOCNews(COLOR_WHITE, String);
			}
			format(pData[pData[playerid][pMarriedAccept]][pMarriedTo], MAX_PLAYER_NAME, "%s", pData[playerid][pName]);
			format(pData[playerid][pMarriedTo], MAX_PLAYER_NAME, "%s", pData[pData[playerid][pMarriedAccept]][pName]);
			GivePlayerMoney(pData[playerid][pMarriedAccept], -10000);
			pData[playerid][pMarried] = 1;
			pData[pData[playerid][pMarriedAccept]][pMarried] = 1;
			pData[playerid][pMarriedAccept] = INVALID_PLAYER_ID;
		}
		else if(strcmp(params,"cerai",true) == 0)
		{
			if(pData[playerid][pMarriedCancel] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pMarriedCancel]))
				return Error(playerid, "That player not connected!");
			
			if(!NearPlayer(playerid, pData[playerid][pMarriedCancel], 5.0))
				return Error(playerid, "You must be near this player.");

			if(pData[playerid][pGender] == 1)
			{
				format(pData[playerid][pMarriedTo], 50, "Duda");
			}
			else if(pData[playerid][pGender] == 2)
			{
				format(pData[playerid][pMarriedTo], 50, "Janda");
			}
			if(pData[pData[playerid][pMarriedCancel]][pGender] == 1)
			{
				format(pData[pData[playerid][pMarriedCancel]][pMarriedTo], 50, "Duda");
			}
			else if(pData[pData[playerid][pMarriedCancel]][pGender] == 2)
			{
				format(pData[pData[playerid][pMarriedCancel]][pMarriedTo], 50, "Janda");
			}
			pData[playerid][pMarried] = 0;
			pData[pData[playerid][pMarriedCancel]][pMarried] = 0;
			pData[playerid][pMarriedCancel] = INVALID_PLAYER_ID;
			SendClientMessageEx(playerid, COLOR_ARWIN, "ACCEPT: "WHITE_E"Anda telah pisah/cerai dengan %s", ReturnName(pData[playerid][pMarriedCancel]));
			SendClientMessageEx(pData[pData[playerid][pMarriedCancel]][pMarried], COLOR_ARWIN, "ACCEPT: "WHITE_E"Anda telah pisah/cerai dengan %s", ReturnName(playerid));
		}
		else if(strcmp(params,"job",true) == 0) 
		{
			if(pData[playerid][pGetJob] > 0)
			{
				pData[playerid][pJob] = pData[playerid][pGetJob];
				SendClientMessageEx(playerid, COLOR_ARWIN, "* Congratulations with your new Job, type /help to see your new command");
				pData[playerid][pGetJob] = 0;
				pData[playerid][pExitJob] = gettime() + (1 * 86400);
			}
			else if(pData[playerid][pGetJob2] > 0)
			{
				pData[playerid][pJob2] = pData[playerid][pGetJob2];
				SendClientMessageEx(playerid, COLOR_ARWIN, "* Congratulations with your new Job, type /help to see your new command");
				SendClientMessageEx(playerid, COLOR_YELLOW, "Donator: You have taken this as a secondary job.");
				pData[playerid][pGetJob2] = 0;
				pData[playerid][pExitJob] = gettime() + (1 * 86400);
			}
		}
	}
	return 1;
}

CMD:deny(playerid, params[])
{
	if(IsPlayerConnected(playerid)) 
	{
        if(isnull(params)) 
		{
            Usage(playerid, "USAGE: /deny [name]");
            Info(playerid, "Names: faction, drag, sharelok, frisk, job1, job2");
            return 1;
        }
		if(strcmp(params,"faction",true) == 0) 
		{
            if(pData[playerid][pFacOffer] > -1) 
			{
                if(pData[playerid][pFacInvite] > 0) 
				{
					SendClientMessageEx(playerid, COLOR_ARWIN, "DENY: "WHITE_E"Anda telah menolak faction dari %s", ReturnName(pData[playerid][pFacOffer]));
					Info(pData[playerid][pFacOffer], "%s telah menolak invite faction yang anda tawari", ReturnName(playerid));
					pData[playerid][pFacInvite] = 0;
					pData[playerid][pFacOffer] = -1;
				}
				else
				{
					Error(playerid, "Invalid faction id!");
					return 1;
				}
            }
            else 
			{
                Error(playerid, "Tidak ada player yang menawari anda!");
                return 1;
            }
        }
		else if(strcmp(params,"drag",true) == 0)
		{
			new dragby = GetPVarInt(playerid, "DragBy");
			if(dragby == INVALID_PLAYER_ID || dragby == playerid)
				return Error(playerid, "That player is disconnected.");

			SendClientMessageEx(playerid, COLOR_ARWIN, "DENY: "WHITE_E"Anda telah menolak drag.");
			SendClientMessageEx(dragby, COLOR_ARWIN, "DENY: "WHITE_E"Player telah menolak drag yang anda tawari.");
			
			DeletePVar(playerid, "DragBy");
			pData[playerid][pDragged] = 0;
			pData[playerid][pDraggedBy] = INVALID_PLAYER_ID;
			return 1;
		}
		else if(strcmp(params,"sharelok",true) == 0)
		{
 			new sharelok = GetPVarInt(playerid, "sharelok");
			if(sharelok == INVALID_PLAYER_ID || sharelok == playerid)
				return Error(playerid, "That player is disconnected.");

			SendClientMessageEx(playerid, COLOR_ARWIN, "DENY: "WHITE_E"Anda telah menolak sharelok.");
			SendClientMessageEx(sharelok, COLOR_ARWIN, "DENY: "WHITE_E"Player telah menolak sharelok yang anda tawari.");

			DeletePVar(playerid, "sharelok");
		//	pData[playerid][pDragged] = 0;
		//	pData[playerid][pDraggedBy] = INVALID_PLAYER_ID;
			return 1;
		}
		else if(strcmp(params,"frisk",true) == 0)
		{
			if(pData[playerid][pFriskOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pFriskOffer]))
				return Error(playerid, "That player not connected!");
			
			SendClientMessageEx(playerid, COLOR_ARWIN, "DENY: "WHITE_E"Anda telah menolak tawaran frisk kepada %s.", ReturnName(pData[playerid][pFriskOffer]));
			pData[playerid][pFriskOffer] = INVALID_PLAYER_ID;
			return 1;
		}
		else if(strcmp(params,"job1",true) == 0) 
		{
			if(pData[playerid][pJob] == 0) return Error(playerid, "Anda tidak memiliki job apapun.");
			{
				if(pData[playerid][pExitJob] != 0) return Error(playerid, "Kamu harus menunggu 1 hari setelah join job lain nya agar bisa quit job");
				{
					pData[playerid][pJob] = 0;
					SendClientMessageEx(playerid, COLOR_ARWIN, "DENY: "WHITE_E"Anda berhasil keluar dari pekerjaan anda.");
					return 1;
				}
			}
		}
		else if(strcmp(params,"job2",true) == 0) 
		{
			if(pData[playerid][pJob2] == 0) return Error(playerid, "Anda tidak memiliki job apapun.");
			{
				pData[playerid][pJob2] = 0;
				SendClientMessageEx(playerid, COLOR_ARWIN, "DENY: "WHITE_E"Anda berhasil keluar dari pekerjaan anda.");
				return 1;
			}
		}
	}
	return 1;
}

CMD:give(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		new name[24], ammount, otherid;
        if(sscanf(params, "us[24]d", otherid, name, ammount))
		{
			Usage(playerid, "/give [playerid] [name] [ammount]");
			Info(playerid, "Names: bandage, medicine, snack, sprunk, rokok, material, component, crack, pot");
			return 1;
		}
		if(otherid == INVALID_PLAYER_ID || otherid == playerid || !NearPlayer(playerid, otherid, 3.0))
			return Error(playerid, "Invalid playerid!");

		if(strcmp(name,"bandage",true) == 0)
		{
			if(ammount < 1) return SendClientMessage(playerid, 0xCECECEFF, "tidak bisa kurang dari 1");

			if(pData[playerid][pBandage] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			pData[playerid][pBandage] -= ammount;
			pData[otherid][pBandage] += ammount;
			SendClientMessageEx(playerid, COLOR_ARWIN, "GIVE: "WHITE_E"Anda telah berhasil memberikan perban kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			SendClientMessageEx(otherid, COLOR_ARWIN, "GIVE: "WHITE_E"%s telah berhasil memberikan perban kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"medicine",true) == 0)
		{
			if(ammount < 1) return SendClientMessage(playerid, 0xCECECEFF, "tidak bisa kurang dari 1");	
					
			if(pData[playerid][pMedicine] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			pData[playerid][pMedicine] -= ammount;
			pData[otherid][pMedicine] += ammount;
			SendClientMessageEx(playerid, COLOR_ARWIN, "GIVE: "WHITE_E"Anda telah berhasil memberikan medicine kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			SendClientMessageEx(otherid, COLOR_ARWIN, "GIVE: "WHITE_E"%s telah berhasil memberikan medicine kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"snack",true) == 0)
		{
			if(ammount < 1) return SendClientMessage(playerid, 0xCECECEFF, "tidak bisa kurang dari 1");

			if(pData[playerid][pSnack] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			pData[playerid][pSnack] -= ammount;
			pData[otherid][pSnack] += ammount;
			SendClientMessageEx(playerid, COLOR_ARWIN, "GIVE: "WHITE_E"Anda telah berhasil memberikan snack kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			SendClientMessageEx(otherid, COLOR_ARWIN, "GIVE: "WHITE_E"%s telah berhasil memberikan snack kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"sprunk",true) == 0)
		{
			if(ammount < 1) return SendClientMessage(playerid, 0xCECECEFF, "tidak bisa kurang dari 1");

			if(pData[playerid][pSprunk] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			pData[playerid][pSprunk] -= ammount;
			pData[otherid][pSprunk] += ammount;
			SendClientMessageEx(playerid, COLOR_ARWIN, "GIVE: "WHITE_E"Anda telah berhasil memberikan Sprunk kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			SendClientMessageEx(otherid, COLOR_ARWIN, "GIVE: "WHITE_E"%s telah berhasil memberikan Sprunk kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"rokok",true) == 0)
		{
			if(ammount < 1) return SendClientMessage(playerid, 0xCECECEFF, "tidak bisa kurang dari 1");

			if(pData[playerid][pRokok] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			pData[playerid][pRokok] -= ammount;
			pData[otherid][pRokok] += ammount;
			SendClientMessageEx(playerid, COLOR_ARWIN, "GIVE: "WHITE_E"Anda telah berhasil memberikan pRokok kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			SendClientMessageEx(otherid, COLOR_ARWIN, "GIVE: "WHITE_E"%s telah berhasil memberikan pRokok kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"material",true) == 0)
		{
			if(ammount < 1) return SendClientMessage(playerid, 0xCECECEFF, "tidak bisa kurang dari 1");

			if(pData[playerid][pMaterial] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			pData[playerid][pMaterial] -= ammount;
			pData[otherid][pMaterial] += ammount;
			SendClientMessageEx(playerid, COLOR_ARWIN, "GIVE: "WHITE_E"Anda telah berhasil memberikan Material kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			SendClientMessageEx(otherid, COLOR_ARWIN, "GIVE: "WHITE_E"%s telah berhasil memberikan Material kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"component",true) == 0)
		{
			if(ammount < 1) return SendClientMessage(playerid, 0xCECECEFF, "tidak bisa kurang dari 1");

			if(pData[playerid][pComponent] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			pData[playerid][pComponent] -= ammount;
			pData[otherid][pComponent] += ammount;
			SendClientMessageEx(playerid, COLOR_ARWIN, "GIVE: "WHITE_E"Anda telah berhasil memberikan Component kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			SendClientMessageEx(otherid, COLOR_ARWIN, "GIVE: "WHITE_E"%s telah berhasil memberikan Component kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"crack",true) == 0)
		{
			if(ammount < 1) return SendClientMessage(playerid, 0xCECECEFF, "tidak bisa kurang dari 1");

			if(pData[playerid][pCrack] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			pData[playerid][pCrack] -= ammount;
			pData[otherid][pCrack] += ammount;
			SendClientMessageEx(playerid, COLOR_ARWIN, "GIVE: "WHITE_E"Anda telah berhasil memberikan Crack kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			SendClientMessageEx(otherid, COLOR_ARWIN, "GIVE: "WHITE_E"%s telah berhasil memberikan Crack kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"pot",true) == 0)
		{
			if(ammount < 1) return SendClientMessage(playerid, 0xCECECEFF, "tidak bisa kurang dari 1");

			if(pData[playerid][pPot] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			pData[playerid][pPot] -= ammount;
			pData[otherid][pPot] += ammount;
			SendClientMessageEx(playerid, COLOR_ARWIN, "GIVE: "WHITE_E"Anda telah berhasil memberikan Pot kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			SendClientMessageEx(otherid, COLOR_ARWIN, "GIVE: "WHITE_E"%s telah berhasil memberikan Pot kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
	}
	return 1;
}

CMD:usesprunk(playerid, params[])
{
	if(IsPlayerConnected(playerid)) 
	{
		if(pData[playerid][pSprunk] < 1)
			return Error(playerid, "Anda tidak memiliki sprunk.");

		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_SPRUNK);
		pData[playerid][pSprunk]--;
	}
	return 1;
}

CMD:userokok(playerid, params[])
{
	if(IsPlayerConnected(playerid)) 
	{
		if(pData[playerid][pRokok] < 1)
			return Error(playerid, "Anda tidak memiliki rokok.");

		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_SMOKE_CIGGY);
		pData[playerid][pRokok]--;
	}
	return 1;
}
	
CMD:use(playerid, params[])
{
	if(IsPlayerConnected(playerid)) 
	{
        if(isnull(params)) 
		{
            Usage(playerid, "USAGE: /use [name]");
            Info(playerid, "Names: bandage, snack, sprunk, rokok, gas, medicine, crack, pot");
            return 1;
        }
		if(strcmp(params,"bandage",true) == 0) 
		{
			if(pData[playerid][pBandage] < 1)
				return Error(playerid, "Anda tidak memiliki perban.");
			
			new Float:darah;
			GetPlayerHealth(playerid, darah);
			if(darah+10 > 99) return Error(playerid, "You can't use bandage anymore");
			SetPlayerHealthEx(playerid, darah+10);
			
			pData[playerid][pBandage]--;
			SendClientMessageEx(playerid, COLOR_ARWIN, "USE: "WHITE_E"Anda telah berhasil menggunakan perban.");
			InfoTD_MSG(playerid, 3000, "Restore +10 Health");
		}
		else if(strcmp(params,"snack",true) == 0) 
		{
			if(pData[playerid][pSnack] < 1)
				return Error(playerid, "Anda tidak memiliki snack.");
			
			pData[playerid][pSnack]--;
			pData[playerid][pHunger] += 15;
			SendClientMessageEx(playerid, COLOR_ARWIN, "USE: "WHITE_E"Anda telah berhasil menggunakan snack.");
			InfoTD_MSG(playerid, 3000, "Restore +15 Hunger");
			ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
		}
		else if(strcmp(params,"sprunk",true) == 0) 
		{
			if(pData[playerid][pSprunk] < 1)
				return Error(playerid, "Anda tidak memiliki sprunk.");

			pData[playerid][pSprunk]--;
			pData[playerid][pEnergy] += 15;
			SendClientMessageEx(playerid, COLOR_ARWIN, "USE: "WHITE_E"Anda telah berhasil meminum sprunk.");
			InfoTD_MSG(playerid, 3000, "Restore +15 Energy");
			ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
			SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_SPRUNK);
		}
		else if(strcmp(params,"rokok",true) == 0) 
		{
			if(pData[playerid][pRokok] < 1)
				return Error(playerid, "Anda tidak memiliki rokok.");

			SendClientMessageEx(playerid, COLOR_ARWIN, "USE: "WHITE_E"Anda telah berhasil merokok.");	
			ApplyAnimation(playerid,"SMOKING","M_smklean_loop",4.1, 0, 1, 1, 1, 1, 1);
			pData[playerid][pRokok]--;

		}
		else if(strcmp(params,"gas",true) == 0) 
		{
			if(pData[playerid][pGas] < 1)
				return Error(playerid, "Anda tidak memiliki gas.");
				
			if(IsPlayerInAnyVehicle(playerid))
				return Error(playerid, "Anda harus berada diluar kendaraan!");
			
			if(pData[playerid][pActivityTime] > 5) return Error(playerid, "Anda masih memiliki activity progress!");
			
			new vehicleid = GetNearestVehicleToPlayer(playerid, 3.5, false);
			if(IsValidVehicle(vehicleid))
			{
				new fuel = GetVehicleFuel(vehicleid);
			
				if(GetEngineStatus(vehicleid))
					return Error(playerid, "Turn off vehicle engine.");
			
				if(fuel >= 999.0)
					return Error(playerid, "This vehicle gas is full.");
			
				if(!IsEngineVehicle(vehicleid))
					return Error(playerid, "This vehicle can't be refull.");

				if(!GetHoodStatus(vehicleid))
					return Error(playerid, "The hood must be opened before refull the vehicle.");

				pData[playerid][pGas]--;
				Info(playerid, "Don't move from your position or you will failed to refulling this vehicle.");
				ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
				pData[playerid][pActivity] = SetTimerEx("RefullCar", 1000, true, "id", playerid, vehicleid);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Refulling");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
				return 1;
			}
		}
		else if(strcmp(params,"medicine",true) == 0) 
		{
			if(pData[playerid][pMedicine] < 1)
				return Error(playerid, "Anda tidak memiliki medicine.");
			
			pData[playerid][pMedicine]--;
			pData[playerid][pSick] = 0;
			pData[playerid][pSickTime] = 0;
			SetPlayerDrunkLevel(playerid, 0);
			SendClientMessageEx(playerid, COLOR_ARWIN, "USE: "WHITE_E"Anda menggunakan medicine.");		
			ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
		}
        else if(strcmp(params,"medkit",true) == 0)
		{
			if(pData[playerid][pMedkit] < 1)
				return Error(playerid, "Anda tidak memiliki medicine.");

			pData[playerid][pMedkit]--;
			pData[playerid][pSick] = 0;
			pData[playerid][pSickTime] = 0;
			
			new Float:darah;
			GetPlayerHealth(playerid, darah);
			if(darah+30 > 99) return Error(playerid, "You can't use medkit anymore");
			SetPlayerHealthEx(playerid, darah+30);
			
			SendClientMessageEx(playerid, COLOR_ARWIN, "USE: "WHITE_E"Anda menggunakan medicine.");
			ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
		}
		else if(strcmp(params,"crack",true) == 0) 
		{
			if(pData[playerid][pCrack] < 1)
				return Error(playerid, "You dont have crack.");
			
			new Float:armor;
			GetPlayerArmour(playerid, armor);
			if(armor+10 > 90) return Error(playerid, "You can't use crack anymore");
			
			pData[playerid][pCrack]--;
			SetPlayerArmourEx(playerid, armor+10);
			SetPlayerDrunkLevel(playerid, 4000);
			ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
			SetTimerEx("DrugEffectGone", 60000, false, "i", playerid);
			SetPlayerWeather(playerid, -68);
		}
		else if(strcmp(params,"pot",true) == 0) 
		{
			if(pData[playerid][pPot] < 1)
				return Error(playerid, "You dont have pot.");
			
			new Float:armor;
			GetPlayerArmour(playerid, armor);
			if(armor+5 > 25) return Error(playerid, "You can't use pot anymore");
			
			pData[playerid][pPot]--;
			SetPlayerArmourEx(playerid, armor+5);
			SetPlayerDrunkLevel(playerid, 4000);
			ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
			SetTimerEx("DrugEffectGone", 60000, false, "i", playerid);
			SetPlayerWeather(playerid, -68);
		}
	}
	return 1;
}

CMD:enter(playerid, params[])
{
	if(pData[playerid][pInjured] == 0)
    {
		foreach(new did : Doors)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ]))
			{
				if(dData[did][dGarage] == 1 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsPlayerInAnyVehicle(playerid))
				{
					if(dData[did][dIntposX] == 0.0 && dData[did][dIntposY] == 0.0 && dData[did][dIntposZ] == 0.0)
						return Error(playerid, "Interior entrance masih kosong, atau tidak memiliki interior.");

					if(dData[did][dLocked])
						return Error(playerid, "This entrance is locked at the moment.");
						
					if(dData[did][dFaction] > 0)
					{
						if(dData[did][dFaction] != pData[playerid][pFaction])
							return Error(playerid, "This door only for faction.");
					}
					if(dData[did][dFamily] > 0)
					{
						if(dData[did][dFamily] != pData[playerid][pFamily])
							return Error(playerid, "This door only for family.");
					}
					
					if(dData[did][dVip] > pData[playerid][pVip])
						return Error(playerid, "Your VIP level not enough to enter this door.");
					
					if(dData[did][dAdmin] > pData[playerid][pAdmin])
						return Error(playerid, "Your admin level not enough to enter this door.");
						
					if(strlen(dData[did][dPass]))
					{
						if(sscanf(params, "s[256]", params)) return Usage(playerid, "/enter [password]");
						if(strcmp(params, dData[did][dPass])) return Error(playerid, "Invalid door password.");
						
						if(dData[did][dCustom])
						{
							SetVehiclePos(GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ]);
							SetVehicleZAngle(GetPlayerVehicleID(playerid), dData[did][dIntposA]);
						    SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), dData[did][dIntvw]);
		            		LinkVehicleToInterior(GetPlayerVehicleID(playerid), dData[did][dIntint]); 
						}
						else
						{
							SetVehiclePos(GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ]);
							SetVehicleZAngle(GetPlayerVehicleID(playerid), dData[did][dIntposA]);
						    SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), dData[did][dIntvw]);
		            		LinkVehicleToInterior(GetPlayerVehicleID(playerid), dData[did][dIntint]); 
		            	}
						pData[playerid][pInDoor] = did;
						SetPlayerInterior(playerid, dData[did][dIntint]);
						SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, 0);
					}
					else
					{
						if(dData[did][dCustom])
						{
							SetVehiclePos(GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ]);
							SetVehicleZAngle(GetPlayerVehicleID(playerid), dData[did][dIntposA]);
						    SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), dData[did][dIntvw]);
		            		LinkVehicleToInterior(GetPlayerVehicleID(playerid), dData[did][dIntint]); 
						}
						else
						{
							SetVehiclePos(GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ]);
							SetVehicleZAngle(GetPlayerVehicleID(playerid), dData[did][dIntposA]);
						    SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), dData[did][dIntvw]);
		            		LinkVehicleToInterior(GetPlayerVehicleID(playerid), dData[did][dIntint]); 
						}
						pData[playerid][pInDoor] = did;
						SetPlayerInterior(playerid, dData[did][dIntint]);
						SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, 0);
					}
				}
				else
				{
					if(dData[did][dIntposX] == 0.0 && dData[did][dIntposY] == 0.0 && dData[did][dIntposZ] == 0.0)
						return Error(playerid, "Interior entrance masih kosong, atau tidak memiliki interior.");

					if(dData[did][dLocked])
						return Error(playerid, "This entrance is locked at the moment.");
						
					if(dData[did][dFaction] > 0)
					{
						if(dData[did][dFaction] != pData[playerid][pFaction])
							return Error(playerid, "This door only for faction.");
					}
					if(dData[did][dFamily] > 0)
					{
						if(dData[did][dFamily] != pData[playerid][pFamily])
							return Error(playerid, "This door only for family.");
					}
					
					if(dData[did][dVip] > pData[playerid][pVip])
						return Error(playerid, "Your VIP level not enough to enter this door.");
					
					if(dData[did][dAdmin] > pData[playerid][pAdmin])
						return Error(playerid, "Your admin level not enough to enter this door.");

					if(strlen(dData[did][dPass]))
					{
						if(sscanf(params, "s[256]", params)) return Usage(playerid, "/enter [password]");
						if(strcmp(params, dData[did][dPass])) return Error(playerid, "Invalid door password.");
						
						if(dData[did][dCustom])
						{
							SetPlayerPositionEx(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						else
						{
							SetPlayerPositionEx(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						pData[playerid][pInDoor] = did;
						SetPlayerInterior(playerid, dData[did][dIntint]);
						SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, 0);
					}
					else
					{
						if(dData[did][dCustom])
						{
							SetPlayerPositionEx(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						else
						{
							SetPlayerPositionEx(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						pData[playerid][pInDoor] = did;
						SetPlayerInterior(playerid, dData[did][dIntint]);
						SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, 0);
					}
				}
			}
			if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ]))
			{
				if(dData[did][dGarage] == 1 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsPlayerInAnyVehicle(playerid))
				{
					if(dData[did][dFaction] > 0)
					{
						if(dData[did][dFaction] != pData[playerid][pFaction])
							return Error(playerid, "This door only for faction.");
					}
				
					if(dData[did][dCustom])
					{
						SetVehiclePos(GetPlayerVehicleID(playerid), dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ]);
						SetVehicleZAngle(GetPlayerVehicleID(playerid), dData[did][dExtposA]);
					    SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), dData[did][dExtvw]);
	            		LinkVehicleToInterior(GetPlayerVehicleID(playerid), dData[did][dExtint]);   
					}
					else
					{
						SetVehiclePos(GetPlayerVehicleID(playerid), dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ]);
						SetVehicleZAngle(GetPlayerVehicleID(playerid), dData[did][dExtposA]);
					    SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), dData[did][dExtvw]);
	            		LinkVehicleToInterior(GetPlayerVehicleID(playerid), dData[did][dExtint]);   
					}
					pData[playerid][pInDoor] = -1;
					SetPlayerInterior(playerid, dData[did][dExtint]);
					SetPlayerVirtualWorld(playerid, dData[did][dExtvw]);
					SetCameraBehindPlayer(playerid);
					SetPlayerWeather(playerid, WorldWeather);
				}
				else
				{
					if(dData[did][dFaction] > 0)
					{
						if(dData[did][dFaction] != pData[playerid][pFaction])
							return Error(playerid, "This door only for faction.");
					}
					
					if(dData[did][dCustom])
						SetPlayerPositionEx(playerid, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);

					else
						SetPlayerPositionEx(playerid, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
					
					pData[playerid][pInDoor] = -1;
					SetPlayerInterior(playerid, dData[did][dExtint]);
					SetPlayerVirtualWorld(playerid, dData[did][dExtvw]);
					SetCameraBehindPlayer(playerid);
					SetPlayerWeather(playerid, WorldWeather);
				}
			}
        }
		//Houses
		foreach(new hid : Houses)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.5, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]))
			{
				if(hData[hid][hIntposX] == 0.0 && hData[hid][hIntposY] == 0.0 && hData[hid][hIntposZ] == 0.0)
					return Error(playerid, "Interior house masih kosong, atau tidak memiliki interior.");

				if(hData[hid][hLocked])
					return Error(playerid, "This house is locked!");
				
				pData[playerid][pInHouse] = hid;
				SetPlayerPositionEx(playerid, hData[hid][hIntposX], hData[hid][hIntposY], hData[hid][hIntposZ], hData[hid][hIntposA]);

				SetPlayerInterior(playerid, hData[hid][hInt]);
				SetPlayerVirtualWorld(playerid, hid);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, 0);
				if(!hData[hid][house_Lights]) TextDrawShowForPlayer(playerid, HouseLight);
			}
        }
		new inhouseid = pData[playerid][pInHouse];
		if(pData[playerid][pInHouse] != -1 && IsPlayerInRangeOfPoint(playerid, 2.8, hData[inhouseid][hIntposX], hData[inhouseid][hIntposY], hData[inhouseid][hIntposZ]))
		{
			SetPlayerPositionEx(playerid, hData[inhouseid][hExtposX], hData[inhouseid][hExtposY], hData[inhouseid][hExtposZ], hData[inhouseid][hExtposA]);

			pData[playerid][pInHouse] = -1;
			SetPlayerInterior(playerid, hData[inhouseid][hExtInt]);
			SetPlayerVirtualWorld(playerid, hData[inhouseid][hExtVw]);
			SetCameraBehindPlayer(playerid);
			SetPlayerWeather(playerid, WorldWeather);
			TextDrawHideForPlayer(playerid, HouseLight);
			pData[playerid][pInt] = 0;
			pData[playerid][pWorld] = 0;
		}
		//Bisnis
		foreach(new bid : Bisnis)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ]))
			{
				if(bData[bid][bIntposX] == 0.0 && bData[bid][bIntposY] == 0.0 && bData[bid][bIntposZ] == 0.0)
					return Error(playerid, "Interior bisnis masih kosong, atau tidak memiliki interior.");

				if(bData[bid][bLocked])
					return Error(playerid, "This bisnis is locked!");
				if(bData[bid][bSegel] == 1) return GameTextForPlayer(playerid, "~w~Biz ini ~r~Disegel", 1000, 5);	
				pData[playerid][pInBiz] = bid;
				SetPlayerPositionEx(playerid, bData[bid][bIntposX], bData[bid][bIntposY], bData[bid][bIntposZ], bData[bid][bIntposA]);
				
				SetPlayerInterior(playerid, bData[bid][bInt]);
				SetPlayerVirtualWorld(playerid, bid);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, 0);
			}
        }
		new inbisnisid = pData[playerid][pInBiz];
		if(pData[playerid][pInBiz] != -1 && IsPlayerInRangeOfPoint(playerid, 2.8, bData[inbisnisid][bIntposX], bData[inbisnisid][bIntposY], bData[inbisnisid][bIntposZ]))
		{
			SetPlayerPositionEx(playerid, bData[inbisnisid][bExtposX], bData[inbisnisid][bExtposY], bData[inbisnisid][bExtposZ], bData[inbisnisid][bExtposA]);
			
			pData[playerid][pInBiz] = -1;
			SetPlayerInterior(playerid, bData[inbisnisid][bExtInt]);
			SetPlayerVirtualWorld(playerid, bData[inbisnisid][bExtVw]);
			SetCameraBehindPlayer(playerid);
			SetPlayerWeather(playerid, WorldWeather);
			pData[playerid][pInt] = 0;
			pData[playerid][pWorld] = 0;
		}
		//Family
		foreach(new fid : FAMILYS)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, fData[fid][fExtposX], fData[fid][fExtposY], fData[fid][fExtposZ]))
			{
				if(fData[fid][fIntposX] == 0.0 && fData[fid][fIntposY] == 0.0 && fData[fid][fIntposZ] == 0.0)
					return Error(playerid, "Interior masih kosong, atau tidak memiliki interior.");

				if(pData[playerid][pFaction] == 0)
					if(pData[playerid][pFamily] == -1)
						return Error(playerid, "You dont have registered for this door!");
					
				SetPlayerPositionEx(playerid, fData[fid][fIntposX], fData[fid][fIntposY], fData[fid][fIntposZ], fData[fid][fIntposA]);

				SetPlayerInterior(playerid, fData[fid][fInt]);
				SetPlayerVirtualWorld(playerid, fid);
				SetCameraBehindPlayer(playerid);
				//pData[playerid][pInBiz] = fid;
				SetPlayerWeather(playerid, 0);
			}
			if(IsPlayerInRangeOfPoint(playerid, 2.8, fData[fid][fIntposX], fData[fid][fIntposY], fData[fid][fIntposZ]))
			{
				SetPlayerPositionEx(playerid, fData[fid][fExtposX], fData[fid][fExtposY], fData[fid][fExtposZ], fData[fid][fExtposA]);

				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, WorldWeather);
				//pData[playerid][pInBiz] = -1;
			}
        }
	}
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 656.4168,-1326.0953,13.5521)) // masuk basemen news
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SetTimerEx("EnterExitTimer", 8000, false, "i", playerid); //2486.7585,2374.5234,6.8437,271.9420
			SetVehiclePos(GetPlayerVehicleID(playerid), 2486.7585,2374.5234,6.8437);
			SetVehicleZAngle(GetPlayerVehicleID(playerid), 271.9420);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 0);
			LinkVehicleToInterior(GetPlayerVehicleID(playerid), 5);   
			SetPlayerInterior(playerid, 5);
			SetPlayerVirtualWorld(playerid, 0);                    
		}
		else
		{
			SetTimerEx("EnterExitTimer", 8000, false, "i", playerid);
			SetPlayerPos(playerid, 2486.7585,2374.5234,6.8437);
			SetPlayerFacingAngle(playerid, 271.9420);
			SetPlayerInterior(playerid, 5);
			SetPlayerVirtualWorld(playerid, 0);
		}			
	}
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 2485.8213,2379.3203,7.0685) && GetPlayerInterior(playerid) == 5) // keluar basemen news 
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SetTimerEx("EnterExitTimer", 8000, false, "i", playerid);
			SetVehiclePos(GetPlayerVehicleID(playerid), 662.3588,-1326.5183,13.6027); //662.3588,-1326.5183,13.6027,3.4360
			SetVehicleZAngle(GetPlayerVehicleID(playerid), 3.4360);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 0);
			LinkVehicleToInterior(GetPlayerVehicleID(playerid), 0);   
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);   
		}
		else
		{
			SetTimerEx("EnterExitTimer", 8000, false, "i", playerid);
			SetPlayerPos(playerid, 662.3588,-1326.5183,13.6027);
			SetPlayerFacingAngle(playerid, 3.4360);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);	
		}    		
	}
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 1178.5835,-1308.4675,13.7781)) // masuk basemen RS
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SetTimerEx("EnterExitTimer", 8000, false, "i", playerid);
			SetVehiclePos(GetPlayerVehicleID(playerid), 2486.7585,2374.5234,6.8437);
			SetVehicleZAngle(GetPlayerVehicleID(playerid), 271.9420);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 0);
			LinkVehicleToInterior(GetPlayerVehicleID(playerid), 6);   
			SetPlayerInterior(playerid, 6);
			SetPlayerVirtualWorld(playerid, 0);                   
		}
		else
		{
			SetTimerEx("EnterExitTimer", 8000, false, "i", playerid);
			SetPlayerPos(playerid, 2486.7585,2374.5234,6.8437);
			SetPlayerFacingAngle(playerid, 271.9420);
			SetPlayerInterior(playerid, 6);
			SetPlayerVirtualWorld(playerid, 0);
		}			
	}
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 2485.8213,2379.3203,7.0685) && GetPlayerInterior(playerid) == 6) // keluar basemen news 
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SetTimerEx("EnterExitTimer", 8000, false, "i", playerid);
			SetVehiclePos(GetPlayerVehicleID(playerid), 1180.2900,-1339.0264,13.5089);
			SetVehicleZAngle(GetPlayerVehicleID(playerid), 272.5181);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 0);
			LinkVehicleToInterior(GetPlayerVehicleID(playerid), 0);   
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);   
		}
		else
		{
			SetTimerEx("EnterExitTimer", 8000, false, "i", playerid);
			SetPlayerPos(playerid, 1180.2900,-1339.0264,13.5089);
			SetPlayerFacingAngle(playerid, 272.5181);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
		}	
	}
    if(IsPlayerInRangeOfPoint(playerid, 3.0, 1470.6168,-1840.9789,13.5469)) // masuk basemen sags
	{
        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SetTimerEx("EnterExitTimer", 8000, false, "i", playerid);
            SetVehiclePos(GetPlayerVehicleID(playerid), 1132.0062,-2127.4795,-7.1010);
            SetVehicleZAngle(GetPlayerVehicleID(playerid), 83.9742);
            SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 0);
            LinkVehicleToInterior(GetPlayerVehicleID(playerid), 0);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
        }
        else
		{
			SetTimerEx("EnterExitTimer", 8000, false, "i", playerid);
            SetPlayerPos(playerid, 1132.0062,-2127.4795,-7.1010);
            SetPlayerFacingAngle(playerid, 83.9742);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
        }
	}
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 1133.8325,-2136.0264,-7.1010)) // keluar basemen sags
	{
	    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
	        SetVehiclePos(GetPlayerVehicleID(playerid), 1488.5808,-1840.8511,13.5469);
	        SetVehicleZAngle(GetPlayerVehicleID(playerid), 276.3626);
	        SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 0);
	        LinkVehicleToInterior(GetPlayerVehicleID(playerid), 0);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
	    }
	    else
		{
		    SetPlayerPos(playerid, 1488.5808,-1840.8511,13.5469);
		    SetPlayerFacingAngle(playerid, 276.3626);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
	    }
	}
    if(IsPlayerInRangeOfPoint(playerid, 3.0, 1767.5198,-1887.3687,13.5916)) // masuk basemen stasiun
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SetTimerEx("EnterExitTimer", 8000, false, "i", playerid);
			SetVehiclePos(GetPlayerVehicleID(playerid), 2486.7585,2374.5234,6.8437);
			SetVehicleZAngle(GetPlayerVehicleID(playerid), 271.9420);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 0);
			LinkVehicleToInterior(GetPlayerVehicleID(playerid), 7);   
			SetPlayerInterior(playerid, 7);
			SetPlayerVirtualWorld(playerid, 0);                   
		}
		else
		{
			SetTimerEx("EnterExitTimer", 8000, false, "i", playerid);
			SetPlayerPos(playerid, 2486.7585,2374.5234,6.8437);
			SetPlayerFacingAngle(playerid, 271.9420);
			SetPlayerInterior(playerid, 7);
			SetPlayerVirtualWorld(playerid, 0);
		}
	}
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 2485.8213,2379.3203,7.0685) && GetPlayerInterior(playerid) == 7) // keluar basemen stasiun
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SetVehiclePos(GetPlayerVehicleID(playerid), 1769.2347,-1893.7607,13.5916);
			SetVehicleZAngle(GetPlayerVehicleID(playerid), 270.3540);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 0);
			LinkVehicleToInterior(GetPlayerVehicleID(playerid), 0);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
		}
		else
		{
			SetPlayerPos(playerid, 1769.2347,-1893.7607,13.5916);
			SetPlayerFacingAngle(playerid, 270.3540);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
		}
	}  
	return 1;
}

// CMD:inspect(playerid, params[])
// {
// 	new String[500], giveplayerid;

// 	if(sscanf(params, "u", giveplayerid))
//         return Usage(playerid, "/inspect [playerid/PartOfName]");

// 	if(giveplayerid == INVALID_PLAYER_ID)
// 		return Error(playerid, "Invalid playerid!");

// 	if(!NearPlayer(playerid, giveplayerid, 5.0)) return Error(playerid, "Invalid playerid!");

//     format(String, sizeof(String), "INSPECT: {FF0000}%s {FFFFFF}ingin meng-inspect anda, {FFFF00}/accept inspect {FFFFFF}untuk memberi izin untuk meng-inspect anda", ReturnName(playerid));
//     SendClientMessageEx(giveplayerid, COLOR_ARWIN, String);
//     format(String, sizeof(String), "INSPECT: {FFFFFF}Anda telah merequest izin kepada {FF0000}%s {FFFFFF}untuk memeriksa kondisi anda", ReturnName(giveplayerid));
//     SendClientMessageEx(playerid, COLOR_ARWIN, String);
//     pData[giveplayerid][nspectOffer] = playerid;

// 	return 1;
// }

CMD:drag(playerid, params[])
{
	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/drag [playerid/PartOfName] || /undrag [playerid]");

    if(otherid == INVALID_PLAYER_ID)
        return Error(playerid, "That player is disconnected.");

    if(otherid == playerid)
        return Error(playerid, "You cannot drag yourself.");

    if(!NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "You must be near this player.");

    if(!pData[otherid][pInjured])
        return Error(playerid, "kamu tidak bisa drag orang yang tidak mati.");

    SetPVarInt(otherid, "DragBy", playerid);
    SendClientMessageEx(otherid, COLOR_ARWIN, "DRAG: "WHITE_E"%s Telah menawari drag kepada anda, /accept drag untuk menerimanya /deny drag untuk membatalkannya.", ReturnName(playerid));
	SendClientMessageEx(playerid, COLOR_ARWIN, "DRAG: "WHITE_E"Anda berhasil menawari drag kepada player %s", ReturnName(otherid));
    return 1;
}

CMD:undrag(playerid, params[])
{
	new otherid;
    if(sscanf(params, "u", otherid)) return Usage(playerid, "/undrag [playerid]");
	if(pData[otherid][pDragged])
    {
        DeletePVar(playerid, "DragBy");
        DeletePVar(otherid, "DragBy");
        pData[otherid][pDragged] = 0;
        pData[otherid][pDraggedBy] = INVALID_PLAYER_ID;

        KillTimer(pData[otherid][pDragTimer]);
        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s releases %s from their grip.", ReturnName(playerid), ReturnName(otherid));
    }
    return 1;
}

//Mask
CMD:togmask(playerid, params[]) 
{
	if(IsPlayerConnected(playerid))
	{
		if(pData[playerid][pMask] == 0)
		{
			 Error(playerid, "Anda tidak memiliki mask.");
			 return 1;
		}
		if(pData[playerid][pMaskOn] == 0)
		{
		    for(new i = 0; i < MAX_PLAYERS; i++)
			{
			    new string[128];
				pData[playerid][pMaskOn] = 1;
				format(string, sizeof(string), "Mask_%d", pData[playerid][pMaskID]);
	            SetPlayerName(playerid, string);
				SendClientMessageEx(playerid, COLOR_ARWIN, "MASKINFO: "WHITE_E"Mask {00D900}ON!");
				return 1;
			}
		}
		else if(pData[playerid][pMaskOn] == 1)
		{
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
			    pData[playerid][pMaskOn] = 0;
			    SetPlayerName(playerid, pData[playerid][pName]);
				SendClientMessageEx(playerid, COLOR_ARWIN, "MASKINFO: "WHITE_E"Mask {FF0000}OFF!");
				return 1;
			}
		}
	}
	return 1;
}

CMD:masked(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
	    return Error(playerid, "You don't have permission to use this command.");

    SendClientMessage(playerid, COLOR_GREY, "-----------------------------------------------------------");

    foreach (new i : Player) if (pData[i][pMaskOn]) 
    {

        SendClientMessageEx(playerid, COLOR_ARWIN, "MASKED: "YELLOW_E"%s "WHITE_E"(Mask %d)", pData[i][pName], pData[i][pMaskID]);
	}
	SendClientMessage(playerid, COLOR_GREY, "-----------------------------------------------------------");
	return 1;
}

//Text and Chat Commands
CMD:try(playerid, params[])
{

    if(isnull(params))
        return Usage(playerid, "/try [action]");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s %.64s ..", ReturnName(playerid), params);
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, ".. %s, %s", params[64], (random(2) == 0) ? ("and success") : ("but fail"));
    }
    else {
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s %s, %s", ReturnName(playerid), params, (random(2) == 0) ? ("and success") : ("but fail"));
    }
    return 1;
}

CMD:ado(playerid, params[])
{
    new flyingtext[164], Float:x, Float:y, Float:z;

    if(isnull(params))
	{
        Usage(playerid, "/ado [text]");
		Info(playerid, "Use /ado off to disable or delete the ado tag.");
		return 1;
	}
    if(strlen(params) > 128)
        return Error(playerid, "Max text can only maximmum 128 characters.");

    if (!strcmp(params, "off", true))
    {
        if (!pData[playerid][pAdoActive])
            return Error(playerid, "You're not actived your 'ado' text.");

        if (IsValidDynamic3DTextLabel(pData[playerid][pAdoTag]))
            DestroyDynamic3DTextLabel(pData[playerid][pAdoTag]);

        SendClientMessageEx(playerid, COLOR_ARWIN, "ADO: "WHITE_E"You're removed your ado text.");
        pData[playerid][pAdoActive] = false;
        return 1;
    }

    FixText(params);
    format(flyingtext, sizeof(flyingtext), "* %s *\n(( %s ))", ReturnName(playerid), params);

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* [ADO]: %.64s ..", params);
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, ".. %s", params[64]);
    }
    else 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* [ADO]: %s", params);
    }

    GetPlayerPos(playerid, x, y, z);
    if(pData[playerid][pAdoActive])
    {
        if (IsValidDynamic3DTextLabel(pData[playerid][pAdoTag]))
            UpdateDynamic3DTextLabelText(pData[playerid][pAdoTag], COLOR_PURPLE, flyingtext);
        else
            pData[playerid][pAdoTag] = CreateDynamic3DTextLabel(flyingtext, COLOR_PURPLE, x, y, z, 15, _, _, 1, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    }
    else
    {
        pData[playerid][pAdoActive] = true;
        pData[playerid][pAdoTag] = CreateDynamic3DTextLabel(flyingtext, COLOR_PURPLE, x, y, z, 15, _, _, 1, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    }
	printf("[ADO] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}

CMD:ame(playerid, params[])
{
    new flyingtext[164];

    if(isnull(params))
        return Usage(playerid, "/ame [action]");

    if(strlen(params) > 128)
        return Error(playerid, "Max action can only maximmum 128 characters.");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* [AME]: %.64s ..", params);
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, ".. %s", params[64]);
    }
    else 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* [AME]: %s", params);
    }
    format(flyingtext, sizeof(flyingtext), "* %s %s*", ReturnName(playerid), params);
    SetPlayerChatBubble(playerid, flyingtext, COLOR_PURPLE, 10.0, 10000);
	printf("[AME] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}

CMD:me(playerid, params[])
{

    if(isnull(params))
        return Usage(playerid, "/me [action]");
	
	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s %.64s ..", ReturnName(playerid), params);
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, ".. %s", params[64]);
    }
    else 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s %s", ReturnName(playerid), params);
    }
    return 1;
}

CMD:do(playerid, params[])
{
    if(isnull(params))
        return Usage(playerid, "/do [description]");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %.64s ..", params);
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, ".. %s (( %s ))", params[64], ReturnName(playerid));
    }
    else 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s (( %s ))", params, ReturnName(playerid));
    }
    return 1;
}

CMD:toglog(playerid)
{
	if(!pData[playerid][pTogLog])
	{
		pData[playerid][pTogLog] = 1;
		SendClientMessageEx(playerid, COLOR_ARWIN, "TOG: "WHITE_E"Anda telah menonaktifkan log server.");
	}
	else
	{
		pData[playerid][pTogLog] = 0;
		SendClientMessageEx(playerid, COLOR_ARWIN, "TOG: "WHITE_E"Anda telah mengaktifkan log server.");
	}
	return 1;
}

CMD:togpm(playerid)
{
	if(!pData[playerid][pTogPM])
	{
		pData[playerid][pTogPM] = 1;
		SendClientMessageEx(playerid, COLOR_ARWIN, "TOG: "WHITE_E"Anda telah menonaktifkan PM");
	}
	else
	{
		pData[playerid][pTogPM] = 0;
		SendClientMessageEx(playerid, COLOR_ARWIN, "TOG: "WHITE_E"Anda telah mengaktifkan PM");
	}
	return 1;
}

CMD:togvip(playerid)
{
	if(!pData[playerid][pTogVip])
	{
		pData[playerid][pTogVip] = 1;
		SendClientMessageEx(playerid, COLOR_ARWIN, "TOG: "WHITE_E"Anda telah menonaktifkan Chat VIP");
	}
	else
	{
		pData[playerid][pTogVip] = 0;
		SendClientMessageEx(playerid, COLOR_ARWIN, "TOG: "WHITE_E"Anda telah menonaktifkan Chat VIP");
	}
	return 1;
}

CMD:togads(playerid)
{
	if(!pData[playerid][pTogAds])
	{
		pData[playerid][pTogAds] = 1;
		SendClientMessageEx(playerid, COLOR_ARWIN, "TOG: "WHITE_E"Anda telah menonaktifkan Ads/Iklan.");
	}
	else
	{
		pData[playerid][pTogAds] = 0;
		SendClientMessageEx(playerid, COLOR_ARWIN, "TOG: "WHITE_E"Anda telah mengaktifkan Ads/Iklan.");
	}
	return 1;
}

CMD:togwt(playerid)
{
	if(!pData[playerid][pTogWT])
	{
		pData[playerid][pTogWT] = 1;
		SendClientMessageEx(playerid, COLOR_ARWIN, "TOG: "WHITE_E"Anda telah menonaktifkan Walkie Talkie.");
	}
	else
	{
		pData[playerid][pTogWT] = 0;
		SendClientMessageEx(playerid, COLOR_ARWIN, "TOG: "WHITE_E"Anda telah mengaktifkan Walkie Talkie.");
	}
	return 1;
}

CMD:togmoneycent(playerid)
{
	if(pData[playerid][pTogMoney] == 1)
	{
		pData[playerid][pTogMoney] = 0;
		SendClientMessageEx(playerid, COLOR_ARWIN, "TOG: "WHITE_E"Anda telah menonaktifkan Money Cents.");
		TextDrawHideForPlayer(playerid, sen);
		TextDrawHideForPlayer(playerid, koma2);
	}
	else
	{
		pData[playerid][pTogMoney] = 1;
		SendClientMessageEx(playerid, COLOR_ARWIN, "TOG: "WHITE_E"Anda telah mengaktifkan Money Cents.");
		TextDrawShowForPlayer(playerid, sen);
		TextDrawShowForPlayer(playerid, koma2);
	}
	return 1;
}

CMD:togradio(playerid)
{
	if(!pData[playerid][pTogRadio])
	{
		pData[playerid][pTogRadio] = 1;
		SendClientMessageEx(playerid, COLOR_ARWIN, "TOG: "WHITE_E"Anda telah menonaktifkan Radio.");
	}
	else
	{
		pData[playerid][pTogRadio] = 0;
		SendClientMessageEx(playerid, COLOR_ARWIN, "TOG: "WHITE_E"Anda telah mengaktifkan Radio.");
	}
	return 1;
}

CMD:pm(playerid, params[])
{
	if(!IsPlayerConnected(playerid)) return SendClientMessage(playerid,-1, "{FFFF00}[Informasi]{FFFFFF} Anda belum login!");
    static text[128], otherid;
    if(sscanf(params, "us[128]", otherid, text))
        return Usage(playerid, "/pm [playerid/PartOfName] [message]");
		
	if(otherid == INVALID_PLAYER_ID)
        return Error(playerid, "You have specified an invalid player.");

    if(otherid == playerid)
        return Error(playerid, "You can't private message yourself.");

    if(pData[otherid][pTogPM] && pData[playerid][pAdmin] < 1)
        return Error(playerid, "That player has disabled private messaging.");

    PlayerPlaySound(otherid, 1085, 0.0, 0.0, 0.0);

    SendClientMessageEx(otherid, COLOR_YELLOW, "(( PM from %s (%d): %s ))", pData[playerid][pName], playerid, text);
    SendClientMessageEx(playerid, COLOR_YELLOW, "(( PM to %s (%d): %s ))", pData[otherid][pName], otherid, text);
	Info(otherid, "/togpm for tog enable/disable PM");

    foreach(new i : Player) if((pData[i][pAdmin]) && pData[playerid][pSPY] > 0)
    {
        SendClientMessageEx(i, COLOR_LIGHTGREEN, "[SPY PM] %s (%d) to %s (%d): %s", pData[playerid][pName], playerid, pData[otherid][pName], otherid, text);
    }
    return 1;
}

CMD:whisper(playerid, params[])
{
	new text[128], otherid;
    if(sscanf(params, "us[128]", otherid, text))
        return Usage(playerid, "/(w)hisper [playerid/PartOfName] [text]");

    if(otherid == INVALID_PLAYER_ID || !NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "That player is disconnected or not near you.");

    if(otherid == playerid)
        return Error(playerid, "You can't whisper yourself.");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(text) > 64) 
	{
        SendClientMessageEx(otherid, COLOR_YELLOW, "** Whisper from %s (%d): %.64s", ReturnName(playerid), playerid, text);
        SendClientMessageEx(otherid, COLOR_YELLOW, "...%s **", text[64]);

        SendClientMessageEx(playerid, COLOR_YELLOW, "** Whisper to %s (%d): %.64s", ReturnName(otherid), otherid, text);
        SendClientMessageEx(playerid, COLOR_YELLOW, "...%s **", text[64]);
    }
    else 
	{
        SendClientMessageEx(otherid, COLOR_YELLOW, "** Whisper from %s (%d): %s **", ReturnName(playerid), playerid, text);
        SendClientMessageEx(playerid, COLOR_YELLOW, "** Whisper to %s (%d): %s **", ReturnName(otherid), otherid, text);
    }
    SendNearbyMessage(playerid, 10.0, COLOR_PURPLE, "* %s mutters something in %s's ear.", ReturnName(playerid), ReturnName(otherid));
	
	foreach(new i : Player) if((pData[i][pAdmin]) && pData[i][pSPY] > 0)
    {
        SendClientMessageEx(i, COLOR_YELLOW2, "[SPY Whisper] %s (%d) to %s (%d): %s", pData[playerid][pName], playerid, pData[otherid][pName], otherid, text);
    }
    return 1;
}

CMD:l(playerid, params[])
{
    if(isnull(params))
        return Usage(playerid, "/(l)ow [low text]");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
	if(IsPlayerInAnyVehicle(playerid))
	{
		foreach(new i : Player)
		{
			if(IsPlayerInAnyVehicle(i) && GetPlayerVehicleID(i) == GetPlayerVehicleID(playerid))
			{
				if(strlen(params) > 64) 
				{
					SendClientMessageEx(i, COLOR_WHITE, "[car] %s says: %.64s ..", ReturnName(playerid), params);
					SendClientMessageEx(i, COLOR_WHITE, "...%s", params[64]);
				}
				else 
				{
					SendClientMessageEx(i, COLOR_WHITE, "[car] %s says: %s", ReturnName(playerid), params);
				}
			}
		}
	}
	else
	{
		if(strlen(params) > 64) 
		{
			SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "[low] %s says: %.64s ..", ReturnName(playerid), params);
			SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "...%s", params[64]);
		}
		else 
		{
			SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "[low] %s says: %s", ReturnName(playerid), params);
		}
	}
    return 1;
}

CMD:s(playerid, params[])
{

    if(isnull(params))
        return Usage(playerid, "/(s)hout [shout text] /ds for in the door");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 30.0, COLOR_WHITE, "%s shouts: %.64s ..", ReturnName(playerid), params);
        SendNearbyMessage(playerid, 30.0, COLOR_WHITE, "...%s!", params[64]);
    }
    else 
	{
        SendNearbyMessage(playerid, 30.0, COLOR_WHITE, "%s shouts: %s!", ReturnName(playerid), params);
    }
	new flyingtext[128];
	format(flyingtext, sizeof(flyingtext), "%s!", params);
    return 1;
}

CMD:b(playerid, params[])
{
	if(pData[playerid][pInjured] != 0)
		return Error(playerid, "You cant do that in this time.");
    if(isnull(params))
        return Usage(playerid, "/n [local OOC]");
		
	if(pData[playerid][pAdminDuty] == 1)
    {
		if(strlen(params) > 64)
		{
			SendNearbyMessage(playerid, 20.0, COLOR_RED, "%s:"WHITE_E" (( %.64s ..", ReturnName(playerid), params);
            SendNearbyMessage(playerid, 20.0, COLOR_WHITE, ".. %s ))", params[64]);
		}
		else
        {
            SendNearbyMessage(playerid, 20.0, COLOR_RED, "%s:"WHITE_E" (( %s ))", ReturnName(playerid), params);
            return 1;
        }
	}
	else
	{
		if(strlen(params) > 64)
		{
			SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "%s: (( %.64s ..", ReturnName(playerid), params);
            SendNearbyMessage(playerid, 20.0, COLOR_WHITE, ".. %s ))", params[64]);
		}
		else
        {
            SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "%s: (( %s ))", ReturnName(playerid), params);
            return 1;
        }
	}
    return 1;
}

CMD:setfreq(playerid, params[])
{
	if(pData[playerid][pWT] == 0)
		return Error(playerid, "You dont have walkie talkie!");
		
 	if(pData[playerid][pLevel] == 1)
		return Error(playerid, "Anda harus menempuh level 3 terlebih dahulu!");
		
  	if(pData[playerid][pLevel] == 2)
		return Error(playerid, "Anda harus menempuh level 3 terlebih dahulu!");
	
	new channel;
	if(sscanf(params, "d", channel))
		return Usage(playerid, "/setfreq [channel 1 - 1000]");
	
	if(pData[playerid][pTogWT] == 1) return Error(playerid, "Your walkie talkie is turned off.");
	if(channel == pData[playerid][pWT]) return Error(playerid, "You are already in this channel.");
	
	if(channel > 0 && channel <= 1000)
	{
		foreach(new i : Player)
		{
		    if(pData[i][pWT] == channel)
		    {
				SendClientMessageEx(i, COLOR_LIME, "[WT] "WHITE_E"%s has joined in to this channel!", ReturnName(playerid));
		    }
		}
		Info(playerid, "You have set your walkie talkie channel to "LIME_E"%d", channel);
		pData[playerid][pWT] = channel;
	}
	else
	{
		Error(playerid, "Invalid channel id! 1 - 1000");
	}
	return 1;
}

CMD:wt(playerid, params[])
{
	if(pData[playerid][pInjured] == 1)
        return Error(playerid, "You injured at the moment.");

	if(pData[playerid][pMaskOn] == 1)
		return Error(playerid, "Anda melepas topeng anda terlebih dahulu!");
    
	if(pData[playerid][pWT] == 0)
		return Error(playerid, "You dont have walkie talkie!");
		
	if(pData[playerid][pTogWT] == 1)
		return Error(playerid, "Your walkie talkie is turned off!");
	
	if(pData[playerid][pMuteWt] > 1)
		return PermissionError(playerid);

	new msg[128], mstr[512];
	if(sscanf(params, "s[128]", msg)) return Usage(playerid, "/wt [message]");
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	foreach(new i : Player)
	{
	    if(pData[i][pTogWT] == 0)
	    {
	        if(pData[i][pWT] == pData[playerid][pWT])
	        {
				if(IsPlayerInRangeOfPoint(i, 220.0, x, y, z))
				{
					SendClientMessageEx(i, COLOR_YELLOW, "[WT:%d] {75AE5D}%s : %s", pData[playerid][pWT], pData[playerid][pName], msg);
					format(mstr, sizeof(mstr), "[<WT>]\n* %s *", msg);
					SetPlayerChatBubble(i, mstr, COLOR_PINK, 10.0, 3000);
				}	
	        }
	    }
	}
	return 1;
}

/*CMD:showidcard(playerid)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	foreach(new i : Player)
	{
		if(IsPlayerInRangeOfPoint(i, 5.0, x, y, z))
		{
			for(new tdid = 0; tdid < 10; tdid++) 
			{
				new registerno[128];
				format(registerno, sizeof(registerno), "(SA:%d)", pData[playerid][pID]);
				new Birdthdate[128];
				format(Birdthdate, sizeof(Birdthdate), "(%s)", pData[playerid][pAge]);
				new gender[128];
				format(gender, sizeof(gender), "(%s)", GetPlayerGender(playerid));
				new origin[128];
				format(origin, sizeof(origin), "(%s)", GetPlayerAccent(playerid));

				TextDrawSetString(TDIDCardName, pData[playerid][pName]);
				TextDrawSetString(TDIDCardRegisterNo, registerno);
				TextDrawSetString(TDIDCardBirddate, Birdthdate);
				TextDrawSetString(TDIDCardGender, gender);
				TextDrawSetString(TDIDCardOrigin, origin);
				TextDrawShowForPlayer(i, TDIDCard[tdid]);
				TextDrawShowForPlayer(i, TDIDCardName);
				TextDrawShowForPlayer(i, TDIDCardRegisterNo);
				TextDrawShowForPlayer(i, TDIDCardBirddate);
				TextDrawShowForPlayer(i, TDIDCardGender);
				TextDrawShowForPlayer(i, TDIDCardOrigin);
				pData[i][pDelayShowIDCard] = 5;
				pData[playerid][pDelayShowIDCard] = 5;
			}
		}
	}	
	return 1;
}*/

CMD:buycomponent(playerid, params[])
{
	//Component
	if(IsPlayerInRangeOfPoint(playerid, 1.5, 854.5825,-605.2015,18.4219))
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			if(pvData[vehicleid][cComponent] >= 1000) return Error(playerid, "Component too full in your inventory! Maximal 1000!");
			new mstr[128];
			format(mstr, sizeof(mstr), "Component Price: $0.50\nComponent Available: %d", StockComponent);
			ShowPlayerDialog(playerid, DIALOG_COMPONENT, DIALOG_STYLE_INPUT, "Buy Component", mstr, "Buy", "Cancel");
		}
		else
		{
			if(pData[playerid][pComponent] >= 250) return Error(playerid, "Anda sudah membawa 250 Component!");
			new mstr[128];
			format(mstr, sizeof(mstr), "Component Price: $0.50\nComponent Available: %d", StockComponent);
			ShowPlayerDialog(playerid, DIALOG_COMPONENT, DIALOG_STYLE_INPUT, "Buy Component", mstr, "Buy", "Cancel");
		}	
	}
	return 1;
}

//------------------[ Bisnis and Buy Commands ]-------
CMD:buy(playerid, params[])
{
	//Buy farm
	foreach(new ap : FARMS)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, laData[ap][laExtposX], laData[ap][laExtposY], laData[ap][laExtposZ]))
		{
			if(laData[ap][laPrice] > GetPlayerMoney(playerid)) return Error(playerid, "Not enough money, you can't afford this Farm.");
			if(strcmp(laData[ap][laOwner], "-")) return Error(playerid, "Someone already owns this Farm.");
			if(pData[playerid][pLadang] > 0)
				return Error(playerid, "Anda sudah mempunyai Farm");
			GivePlayerMoneyEx(playerid, -laData[ap][laPrice]);
			GetPlayerName(playerid, laData[ap][laOwner], MAX_PLAYER_NAME);
			pData[playerid][pLadang] = ap;
			pData[playerid][pLadangRank] = 6;
			Ladang_Refresh(ap);
			Ladang_Save(ap);
			SendClientMessageEx(playerid, COLOR_ARWIN, "FARM: "WHITE_E"Anda berhasil membeli farm dengan harga "GREEN_E"$%s", FormatMoney(laData[ap][laPrice]));
		}
	}
	//Buy Bisnis
	foreach(new bid : Bisnis)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ]))
		{
			if(bData[bid][bPrice] > GetPlayerMoney(playerid)) return Error(playerid, "Not enough money, you can't afford this bisnis.");
			if(strcmp(bData[bid][bOwner], "-")) return Error(playerid, "Someone already owns this bisnis.");
			/*if(pData[playerid][pVip] == 1)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_BisnisCount(playerid) + 1 > 2) return Error(playerid, "You can't buy any more bisnis.");
				#endif
			}
			else if(pData[playerid][pVip] == 2)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_BisnisCount(playerid) + 1 > 3) return Error(playerid, "You can't buy any more bisnis.");
				#endif
			}*/
			else if(pData[playerid][pVip] > 3)
			{
			    /*#if LIMIT_PER_PLAYER > 0
				if(Player_BisnisCount(playerid) + 1 > 4) return Error(playerid, "You can't buy any more bisnis.");
				#endif*/

				GivePlayerMoneyEx(playerid, -bData[bid][bPrice]);
				Server_AddMoney(-bData[bid][bPrice]);
				GetPlayerName(playerid, bData[bid][bOwner], MAX_PLAYER_NAME);
				bData[bid][bVisit] = gettime();
				bData[bid][bOwnerId] = bid;
				if(pData[playerid][pBisnisOwner1] == -1)
				{
					pData[playerid][pBisnisOwner1] = bid;
				}
				else
				{
				    pData[playerid][pBisnisOwner2] = bid;
				}
				
				Bisnis_Refresh(bid);
				Bisnis_Save(bid);
			}
			else
			{
				#if LIMIT_PER_PLAYER > 0
				if(Player_BisnisCount(playerid) + 1 > 1) return Error(playerid, "You can't buy any more bisnis.");
				#endif
			}
			GivePlayerMoneyEx(playerid, -bData[bid][bPrice]);
			Server_AddMoney(-bData[bid][bPrice]);
			GetPlayerName(playerid, bData[bid][bOwner], MAX_PLAYER_NAME);
			bData[bid][bVisit] = gettime();
			bData[bid][bOwnerId] = bid;
			if(pData[playerid][pBisnisOwner1] == -1)
			{
				pData[playerid][pBisnisOwner1] = bid;
			}
			else
			{
			    pData[playerid][pBisnisOwner2] = bid;
			}
			
			Bisnis_Refresh(bid);
			Bisnis_Save(bid);
		}
	}
	//Buy Bisnis menu
	if(pData[playerid][pInBiz] >= 0 && IsPlayerInRangeOfPoint(playerid, 2.5, bData[pData[playerid][pInBiz]][bPointX], bData[pData[playerid][pInBiz]][bPointY], bData[pData[playerid][pInBiz]][bPointZ]))
	{
		Bisnis_BuyMenu(playerid, pData[playerid][pInBiz]);
	}
	//Gym
	for(new a = 0; a < MAX_GYMPOINT; a++)
	if(IsPlayerInRangeOfPoint(playerid, 5.0, GymPoint[a][bbPos][0], GymPoint[a][bbPos][1], GymPoint[a][bbPos][2]))
	{
		ShowPlayerDialog(playerid, DIALOG_GMENU, DIALOG_STYLE_LIST, "Gym Menu", "Gym Membership $300.00\nEnergy Drink $5.00\nLearning Fight Style", "Select", "Back");
	}
	//Buy House
	foreach(new hid : Houses)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]))
		{
			if(hData[hid][hPrice] > GetPlayerMoney(playerid)) return Error(playerid, "Not enough money, you can't afford this houses.");
			if(strcmp(hData[hid][hOwner], "-")) return Error(playerid, "Someone already owns this house.");
			/*if(pData[playerid][pVip] == 1)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_HouseCount(playerid) + 1 > 2) return Error(playerid, "You can't buy any more houses.");
				#endif
			}
			else if(pData[playerid][pVip] == 2)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_HouseCount(playerid) + 1 > 3) return Error(playerid, "You can't buy any more houses.");
				#endif
			}*/
			if(pData[playerid][pHouseOwner1] != -1 && pData[playerid][pHouseOwner2] != -1)
			{
				#if LIMIT_PER_PLAYER > 0
				if(Player_HouseCount(playerid) + 1 > 1) return Error(playerid, "You can't buy any more houses.");
				#endif
			}
			else if(pData[playerid][pVip] > 3)
			{
			    /*#if LIMIT_PER_PLAYER > 0
				if(Player_HouseCount(playerid) + 1 > 4) return Error(playerid, "You can't buy any more houses.");
				#endif*/

				GivePlayerMoneyEx(playerid, -hData[hid][hPrice]);
				Server_AddMoney(hData[hid][hPrice]);
				GetPlayerName(playerid, hData[hid][hOwner], MAX_PLAYER_NAME);
				if(pData[playerid][pHouseOwner1] == -1)
				{
					pData[playerid][pHouseOwner1] = hid;
				}
				else
				{
				    pData[playerid][pHouseOwner2] = hid;
				}
				hData[hid][hOwnerId] = hid;
				hData[hid][hVisit] = gettime();
				pData[playerid][pHouseOwner1] = hid;
				House_Refresh(hid);
				House_Save(hid);
			}
			else
			{
				#if LIMIT_PER_PLAYER > 0
				if(Player_HouseCount(playerid) + 1 > 1) return Error(playerid, "You can't buy any more houses.");
				#endif
			}
			GivePlayerMoneyEx(playerid, -hData[hid][hPrice]);
			Server_AddMoney(hData[hid][hPrice]);
			GetPlayerName(playerid, hData[hid][hOwner], MAX_PLAYER_NAME);
			if(pData[playerid][pHouseOwner1] == -1)
			{
				pData[playerid][pHouseOwner1] = hid;
			}
			else
			{
			    pData[playerid][pHouseOwner2] = hid;
			}
			hData[hid][hOwnerId] = hid;
			hData[hid][hVisit] = gettime();
			pData[playerid][pHouseOwner1] = hid;
			House_Refresh(hid);
			House_Save(hid);
		}
	}
	//Buy Workshop
	foreach(new ap : WORKSHOPS)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, wData[ap][wExtposX], wData[ap][wExtposY], wData[ap][wExtposZ]))
		{
			if(wData[ap][wPrice] > GetPlayerMoney(playerid)) return Error(playerid, "Not enough money, you can't afford this Workshop.");
			if(strcmp(wData[ap][wOwner], "-")) return Error(playerid, "Someone already owns this Workshop.");
			if(pData[playerid][pWorkshop] > 0)
				return Error(playerid, "Anda sudah mempunyai Workshop");
			GivePlayerMoneyEx(playerid, -wData[ap][wPrice]);
			GetPlayerName(playerid, wData[ap][wOwner], MAX_PLAYER_NAME);
			pData[playerid][pWorkshop] = ap;
			pData[playerid][pWorkshopRank] = 6;
			Workshop_Refresh(ap);
			Workshop_Save(ap);
			SendClientMessageEx(playerid, COLOR_ARWIN, "WORKSHOP: "WHITE_E"Anda berhasil membeli workshop dengan harga "GREEN_E"$%s", FormatMoney(wData[ap][wPrice]));
		}
	}
	return 1;
}

CMD:accent(playerid, params[])
{
	if(pData[playerid][pLevel] < 4) 
		return Error(playerid, "Untuk menggunakan command ini anda harus level 4 ke atas");

	new length = strlen(params), idx, String[256];
	while ((idx < length) && (params[idx] <= ' '))
	{
		idx++;
	}
	new offset = idx;
	new result[16];
	while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
	{
		result[idx - offset] = params[idx];
		idx++;
	}
	result[idx - offset] = EOS;
	if(!strlen(result))
	{
		Usage(playerid, "/accent [name]");
		return 1;
	}
	format(pData[playerid][pAccent], 80, "%s", result);
	format(String, sizeof(String), "ACCENT: {ffffff}Your character's accent has been set to '{ffff00}%s{ffffff}'", pData[playerid][pAccent]);
	SendClientMessageEx(playerid,COLOR_ARWIN,String);
	SendClientMessageEx(playerid,COLOR_ARWIN,"NOTE: Jika ingin menghapus accent gunakan command "YELLOW_E"'/offaccent'");
	return 1;
}

CMD:offaccent(playerid, params[])
{
	if(pData[playerid][pLevel] ==  1) 
		return Error(playerid, "Untuk menggunakan command ini anda harus level 5 ke atas");
	if(pData[playerid][pLevel] ==  2) 
		return Error(playerid, "Untuk menggunakan command ini anda harus level 5 ke atas");
	if(pData[playerid][pLevel] ==  3) 
		return Error(playerid, "Untuk menggunakan command ini anda harus level 5 ke atas");
	if(pData[playerid][pLevel] ==  4) 
		return Error(playerid, "Untuk menggunakan command ini anda harus level 5 ke atas");
	if(pData[playerid][pTogAccent] == 1)
	{
		SendClientMessageEx(playerid, COLOR_ARWIN, "ACCENT: "WHITE_E"Accent OFF!");
		pData[playerid][pTogAccent] = 0;
	}	
	return 1;
}

CMD:cerai(playerid, params[])
{
	if(pData[playerid][pMarried] < 0)
	{
		SendClientMessageEx(playerid, COLOR_GREY, "You are already Married!");
		return 1;
	}

	new String[500], giveplayerid;
	if(sscanf(params, "u", giveplayerid)) return SendClientMessageEx(playerid, COLOR_WHITE, "KEGUNAAN: /cerai [playerid]");

	if(IsPlayerConnected(giveplayerid))
	{
		if(pData[giveplayerid][pMarried] < 0)
		{
			SendClientMessageEx(playerid, COLOR_GREY, "That player is already married!");
			return 1;
		}
		if (ProxDetectorS(8.0, playerid, giveplayerid))
		{
			if(giveplayerid == playerid) { SendClientMessageEx(playerid, COLOR_GREY, "You cannot Propose to yourself!"); return 1; }
			format(String, sizeof(String), "* Kamu mengajak cerai/pisah %s.", ReturnName(giveplayerid));
			SendClientMessageEx(playerid, COLOR_LIGHTBLUE, String);
			format(String, sizeof(String), "* %s Mengajak cerai/pisah kamu (type /accept cerai) to accept.", ReturnName(playerid));
			SendClientMessageEx(giveplayerid, COLOR_LIGHTBLUE, String);
			pData[giveplayerid][pMarriedCancel] = playerid;
		}
		else
		{
			SendClientMessageEx(playerid, COLOR_GREY, "That player isn't near you.");
			return 1;
		}

	}
	else
	{
		SendClientMessageEx(playerid, COLOR_GREY, "Invalid player specified.");
		return 1;
	}
	return 1;
}

CMD:cc(playerid, params[])
{
	return callcmd::clearchat(playerid, "");
}

CMD:clearchat(playerid, params[])
{
	for(new i=0; i<100; i++)
	{
	    SendClientMessageEx(playerid, COLOR_WHITE, "");
	}
	return 1;
}

CMD:payticket(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1320.6910,739.4119,111.3203)) return Error(playerid, "Anda harus berada di kantor SAPD!");
	
	new vehid;
	if(sscanf(params, "d", vehid))
		return Usage(playerid, "/payticket [vehid] | /v my(/mypv) - for find vehid");
		
	if(vehid == INVALID_VEHICLE_ID || !IsValidVehicle(vehid))
		return Error(playerid, "Invalid id");
		
	foreach(new i : PVehicles)
	{
		if(vehid == pvData[i][cVeh])
		{
			if(pvData[i][cOwner] == pData[playerid][pID])
			{
				new ticket = pvData[i][cTicket];
				
				if(ticket > GetPlayerMoney(playerid))
					return Error(playerid, "Not enough money! check your ticket in /v insu.");
					
				if(ticket > 0)
				{
					GivePlayerMoneyEx(playerid, -ticket);
					pvData[i][cTicket] = 0;
					pvData[i][cTicketTime] = 0;
					SendClientMessageEx(playerid, COLOR_ARWIN, "TICKET: "WHITE_E"Anda telah berhasil membayar ticket tilang kendaraan %s(id: %d) sebesar "RED_E"$%s", GetVehicleName(vehid), vehid, FormatMoney(ticket));
					return 1;
				}
			}
			else return Error(playerid, "Kendaraan ini bukan milik anda! /v my(/mypv) - for find vehid");
		}
	}
	return 1;
}

CMD:radio(playerid, params[])
{
	if(pData[playerid][pVip] < 2)
		return PermissionError(playerid);
	if(IsPlayerConnected(playerid)) 
	{
        if(isnull(params)) 
		{
            Usage(playerid, "/radio [off/set]");
            return 1;
        }
		if(strcmp(params,"off",true) == 0) 
		{
			if(GetPVarType(playerid, "BBArea"))
			{
				SendClientMessageEx(playerid, COLOR_ARWIN, "RADIO: "WHITE_E"You've turned off the radio");
				foreach(new i : Player)
				{
					if(IsPlayerInDynamicArea(i, GetPVarInt(playerid, "BBArea")))
					{
						StopStream(i);
					}
				}
				DeletePVar(playerid, "BBStation");
				PickUpBoombox(playerid);
			}
        }
		if(strcmp(params,"set",true) == 0) 
		{
			ShowPlayerDialog(playerid, DIALOG_URL_BOOMBOX, DIALOG_STYLE_INPUT, "Radio URL", "Enter music url to play music", "Play", "Cancel");
        }
	}	
	return 1;
}

CMD:jobduty(playerid, params[])
{
	if(IsPlayerConnected(playerid)) 
	{
        if(isnull(params)) 
		{
            Usage(playerid, "USAGE: /jobduty [name]");
            Info(playerid, "Names: mechanic, taxi");
            return 1;
        }
		if(strcmp(params,"mechanic",true) == 0) 
		{
			if(IsPlayerInRangeOfPoint(playerid, 30.0, 2200.9639,-2215.5659,13.5547) || IsPlayerInRangeOfPoint(playerid, 20.0, 2615.8027,-2473.2822,3.1963))
			{
				if(pData[playerid][pJob] == 2 || pData[playerid][pJob2] == 2)
				{		
					if(pData[playerid][pMechDuty] == 0)
					{
						pData[playerid][pMechDuty] = 1;
						SetPlayerColor(playerid, COLOR_GREEN);
						Servers(playerid, "Anda telah on duty mechanic!");
					}
					else
					{
						pData[playerid][pMechDuty] = 0;
						SetPlayerColor(playerid, COLOR_WHITE);
						Servers(playerid, "Anda telah off dari mech duty!");
					}
				}
				else return Error(playerid, "Anda bukan pekerja mechanic!");
			}
			else return Error(playerid, "Anda harus di mechanic city");
        }
		if(strcmp(params,"taxi",true) == 0) 
		{
			if(pData[playerid][pJob] == 1 || pData[playerid][pJob2] == 1)
			{
				new modelid = GetVehicleModel(GetPlayerVehicleID(playerid));
				
				if(modelid != 438 && modelid != 420)
					return Error(playerid, "Anda harus berada di dalam taksi.");
					
				if(pData[playerid][pTaxiDuty] == 0)
				{
					pData[playerid][pTaxiDuty] = 1;
					SetPlayerColor(playerid, COLOR_YELLOW);
					SendClientMessageEx(playerid, COLOR_ARWIN, "JOB: "WHITE_E"Anda sekarang sedang on duty taxi!");
				}
				else
				{
					pData[playerid][pTaxiDuty] = 0;
					SetPlayerColor(playerid, COLOR_WHITE);
					Servers(playerid, "Anda tidak lagi menggunakan taxi duty!");
				}
			}
			else return Error(playerid, "Anda bukan pekerja taxi driver.");
        }
	}	
	return 1;
}

CMD:buybait(playerid,params[])
{
    new String[212];
	if(!IsPlayerInRangeOfPoint(playerid,3,361.2099,-2032.1703,7.8359))
	{
	    Error(playerid, "Kamu harus di Toko Umpan untuk membeli umpan");
	    return 1;
	}
	if(pData[playerid][pWorm] > 150) return SendClientMessageEx(playerid,COLOR_RED,"Anda tidak dapat membawa umpan lagi.");
	format(String, sizeof(String), "Bait Price: $0.5");
	ShowPlayerDialog( playerid, DIALOG_BUYBAIT, DIALOG_STYLE_INPUT, "Buy Bait",String, "Buy", "Cancel" );
	return 1;
}

CMD:flashlight(playerid, params[])
{
	if(pData[playerid][pUsedFlashlight] == 0)
	{
		if(IsPlayerAttachedObjectSlotUsed(playerid,8)) RemovePlayerAttachedObject(playerid,8);
		if(IsPlayerAttachedObjectSlotUsed(playerid,9)) RemovePlayerAttachedObject(playerid,9);
		SetPlayerAttachedObject(playerid, 8, 18656, 5, 0.1, 0.038, -0.01, -90, 180, 0, 0.03, 0.1, 0.03);
		SetPlayerAttachedObject(playerid, 9, 18641, 5, 0.1, 0.02, -0.05, 0, 0, 0, 1, 1, 1);
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s takes out a flashlight and turns it on.", ReturnName(playerid));

		pData[playerid][pUsedFlashlight] =1;
	}
	else
	{
 		RemovePlayerAttachedObject(playerid,8);
		RemovePlayerAttachedObject(playerid,9);
  		pData[playerid][pUsedFlashlight] =0;
  		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s puts their flashlight back in their pocket.", ReturnName(playerid));
	}
	return 1;
}

CMD:eject(playerid, params[])
{
	new targetid;

	if(sscanf(params, "u", targetid))
	{
	    return Usage(playerid, "/eject [playerid]");
	}
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	{
	    return Error(playerid, "You are not driving any vehicle.");
	}
	if(!IsPlayerConnected(targetid) || !IsPlayerInVehicle(targetid, GetPlayerVehicleID(playerid)))
	{
	    return Error(playerid, "The player specified is disconnected, or is not in your vehicle.");
	}

	RemovePlayerFromVehicle(targetid);
	SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "**{C2A2DA} %s ejects %s from the vehicle.", ReturnName(playerid), ReturnName(targetid));
	return 1;
}

CMD:stuck(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    ShowPlayerDialog(playerid, DIALOG_BUG, DIALOG_STYLE_LIST, "Available Bug", "Freeze Bug\nBug VirtualWorld\nBug Interior\nBlueberry Bug\nBug Death", "Pilih", "Tidak");
	}
	return 1;
}

CMD:cleardelay(playerid, params[])
{
	if(pData[playerid][pAdmin] > 5)
	{
		pData[playerid][pPaycheck] = 0;
 		pData[playerid][pDelayTruckerDeli] = 0;
	    pData[playerid][pDelayFishing] = 0;
		pData[playerid][pJobSmugglerTime] = 0;
		pData[playerid][pPizzaTime] = 0;
		pData[playerid][pSideJobsForklift] = 0;
		pData[playerid][pSideJobsTrash] = 0;
		pData[playerid][pHaulingTime] = 0;
		pData[playerid][pSideJobTimeBus] = 0;
		pData[playerid][pSideJobTimeSweap] = 0;
		Info(playerid, "Succes Clear Delays time Jobs");
	}
	return 1;
}

CMD:propose(playerid, params[])
{
	if(GetPlayerMoney(playerid) < 100000)
	{
		SendClientMessageEx(playerid, COLOR_GREY, "The Marriage & Reception costs $1,000.00!");
		return 1;
	}
	if(pData[playerid][pMarried] > 0)
	{
		SendClientMessageEx(playerid, COLOR_GREY, "You are already Married!");
		return 1;
	}

	new String[512], giveplayerid;
	if(sscanf(params, "u", giveplayerid)) return SendClientMessageEx(playerid, COLOR_WHITE, "KEGUNAAN: /propose [playerid]");

	if(IsPlayerConnected(giveplayerid))
	{
		if(pData[giveplayerid][pMarried] > 0)
		{
			SendClientMessageEx(playerid, COLOR_GREY, "That player is already married!");
			return 1;
		}
		if (ProxDetectorS(8.0, playerid, giveplayerid))
		{
			if(giveplayerid == playerid) { SendClientMessageEx(playerid, COLOR_GREY, "You cannot Propose to yourself!"); return 1; }
			format(String, sizeof(String), "* You proposed to %s.", ReturnName(giveplayerid));
			SendClientMessageEx(playerid, COLOR_LIGHTBLUE, String);
			format(String, sizeof(String), "* %s just proposed to you (type /accept marriage) to accept.", ReturnName(playerid));
			SendClientMessageEx(giveplayerid, COLOR_LIGHTBLUE, String);
			pData[giveplayerid][pMarriedAccept] = playerid;
		}
		else
		{
			SendClientMessageEx(playerid, COLOR_GREY, "That player isn't near you.");
			return 1;
		}

	}
	else
	{
		SendClientMessageEx(playerid, COLOR_GREY, "Invalid player specified.");
		return 1;
	}
	return 1;
}

CMD:buyboat(playerid) //453 Reefer 452 Speeder 473 Dinghy 484 Marquis 493 Jetmax  446 Squalo 454 Tropic
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 144.52, -1886.32, 1.56)) return Error(playerid, "You're not at a boat shop.");
   	new String[1024], S3MP4K[1024];
	strcat(S3MP4K, "Model\tCost\n");
	format(String, sizeof(String),"%s\t$%s\n", GetVehicleModelName(453), FormatMoney(GetVehicleCost(453)));
	strcat(S3MP4K, String);
	format(String, sizeof(String),"%s\t$%s\n", GetVehicleModelName(452), FormatMoney(GetVehicleCost(452)));
	strcat(S3MP4K, String);
	format(String, sizeof(String),"%s\t$%s\n", GetVehicleModelName(473), FormatMoney(GetVehicleCost(473)));
	strcat(S3MP4K, String);
	format(String, sizeof(String),"%s\t$%s\n", GetVehicleModelName(484), FormatMoney(GetVehicleCost(484)));
	strcat(S3MP4K, String);
	format(String, sizeof(String),"%s\t$%s\n", GetVehicleModelName(493), FormatMoney(GetVehicleCost(493)));
	strcat(S3MP4K, String);
	format(String, sizeof(String),"%s\t$%s\n", GetVehicleModelName(446), FormatMoney(GetVehicleCost(446)));
	strcat(S3MP4K, String);
	format(String, sizeof(String),"%s\t$%s\n", GetVehicleModelName(453), FormatMoney(GetVehicleCost(453)));
	strcat(S3MP4K, String);
	ShowPlayerDialog(playerid, DIALOG_BUYPVBOAT, DIALOG_STYLE_TABLIST_HEADERS, "Boat List", S3MP4K, "Buy", "Cancel");
	return 1;
}

CMD:buyvehicle(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid,3,563.3856,-1292.2179,17.2482))
	{
	    if(pData[playerid][pVip] > 0)
		{
			new String[1024], S3MP4K[1024];
			strcat(S3MP4K, "Model\tCost\n");
			format(String, sizeof(String),"%s\t$%s\n", GetVehicleModelName(522), FormatMoney(GetVehicleCostVIP(522)));
			strcat(S3MP4K, String);
			format(String, sizeof(String),"%s\t$%s\n", GetVehicleModelName(411), FormatMoney(GetVehicleCostVIP(411)));
			strcat(S3MP4K, String);
			format(String, sizeof(String),"%s\t$%s\n", GetVehicleModelName(451), FormatMoney(GetVehicleCostVIP(451)));
			strcat(S3MP4K, String);
			format(String, sizeof(String),"%s\t$%s\n", GetVehicleModelName(494), FormatMoney(GetVehicleCostVIP(494)));
			strcat(S3MP4K, String);
			format(String, sizeof(String),"%s\t$%s\n", GetVehicleModelName(541), FormatMoney(GetVehicleCostVIP(541)));
			strcat(S3MP4K, String);
			format(String, sizeof(String),"%s\t$%s\n", GetVehicleModelName(573), FormatMoney(GetVehicleCostVIP(573)));
			strcat(S3MP4K, String);
			ShowPlayerDialog(playerid, DIALOG_BUYVEHVIP_CONFIRM, DIALOG_STYLE_TABLIST_HEADERS, "Buying Vehicle", S3MP4K, "Buy", "Cancel");
		}
		else return Error(playerid, "To access a VIP dealership you must be a donators");
	}
	else if(IsPlayerInRangeOfPoint(playerid,3,701.6057,-518.9899,16.3284))
	{
		new String[1024], S3MP4K[1024];
		strcat(S3MP4K, "Model\tCost\n");
		format(String, sizeof(String),"%s\t$%s\n", GetVehicleModelName(481), FormatMoney(GetVehicleCost(481)));
		strcat(S3MP4K, String);
		format(String, sizeof(String),"%s\t$%s\n", GetVehicleModelName(509), FormatMoney(GetVehicleCost(509)));
		strcat(S3MP4K, String);
		format(String, sizeof(String),"%s\t$%s\n", GetVehicleModelName(510), FormatMoney(GetVehicleCost(510)));
		strcat(S3MP4K, String);
		ShowPlayerDialog(playerid, DIALOG_BUYBIKE_CONFIRM, DIALOG_STYLE_TABLIST_HEADERS, "Buying Bicycle", S3MP4K, "Buy", "Cancel");
	}
	// else if(IsPlayerInRangeOfPoint(playerid,3,1848.0145,-1871.7001,13.5781))
	// {
	// 	new String[1024], S3MP4K[1024];
	// 	strcat(S3MP4K, "Model\tCost\n");
	// 	format(String, sizeof(String),"%s\t$%s\n", GetVehicleModelName(463), FormatMoney(GetVehicleCost(463)));
	// 	strcat(S3MP4K, String);
	// 	format(String, sizeof(String),"%s\t$%s\n", GetVehicleModelName(521), FormatMoney(GetVehicleCost(521)));
	// 	strcat(S3MP4K, String);
	// 	format(String, sizeof(String),"%s\t$%s\n", GetVehicleModelName(461), FormatMoney(GetVehicleCost(461)));
	// 	strcat(S3MP4K, String);
	// 	format(String, sizeof(String),"%s\t$%s\n", GetVehicleModelName(581), FormatMoney(GetVehicleCost(581)));
	// 	strcat(S3MP4K, String);
	// 	format(String, sizeof(String),"%s\t$%s\n", GetVehicleModelName(468), FormatMoney(GetVehicleCost(468)));
	// 	strcat(S3MP4K, String);
	// 	format(String, sizeof(String),"%s\t$%s\n", GetVehicleModelName(586), FormatMoney(GetVehicleCost(586)));
	// 	strcat(S3MP4K, String);
	// 	format(String, sizeof(String),"%s\t$%s\n", GetVehicleModelName(462), FormatMoney(GetVehicleCost(462)));
	// 	strcat(S3MP4K, String);
	// 	ShowPlayerDialog(playerid, DIALOG_BUYMOTOR_CONFIRM, DIALOG_STYLE_TABLIST_HEADERS, "Buying Motorcycle", S3MP4K, "Buy", "Cancel");
	// }
	// else if(IsPlayerInRangeOfPoint(playerid,3,2131.8284,-1150.4662,24.1544))
	// {
	// 	ShowPlayerDialog(playerid, DIALOG_BUYPVCP, DIALOG_STYLE_LIST, "Car Dealer", "Cars\nUnique Cars", "Select", "Cancel");
	// }
	return 1;
}

/*CMD:rq(playerid, params[])
{
    if(ToggleRadio[playerid] == 1)
    {
    	SvDetachListenerFromStream(Frequency[FrequencyConnect[playerid]], playerid);
     	new string[168];
      	format(string, sizeof(string), "{FFFF00}[RADIO]: {ffffff}%s disconnected to the frequency (%d Khz)", GetPlayerNameEx(playerid), FrequencyConnect[playerid]);
       	SendClientMessage(playerid, 0xFF0000FF, string);
   		ToggleRadio[playerid] = 0;
     	FrequencyConnect[playerid] = 0;
	}
	return 1;
}

CMD:rv(playerid, params[])
{
	new freq;
	if(sscanf(params, "d", freq))
        return SendClientMessage(playerid, -1,"USAGE: /rv [1 - 150]");
	if(freq > 150 || freq < 1)
        return SendClientMessage(playerid, 0xFF0000FF, "Invalid Frequency!");
    if(!pData[playerid][pWT])
	{
	    return SendClientMessage(playerid, COLOR_SYNTAX, "kamu tidak memiliki radio portabel.");
	}
	new string[168];
    FrequencyConnect[playerid] = freq;
	format(string, 128, "{FFFF00}[RADIO]: {ffffff}set your freq to (%d Khz)", FrequencyConnect[playerid]);
	SendClientMessage(playerid, 0x00AE00FF, string);
    ToggleRadio[playerid] = 1;
	SvAttachListenerToStream(Frequency[FrequencyConnect[playerid]], playerid);
	return 1;
}*/
