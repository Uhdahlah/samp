//Job Taxi
CheckPassengers(vehicleid)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerInAnyVehicle(i))
		{
			if(GetPlayerVehicleID(i) == vehicleid && i != GetVehicleDriver(vehicleid))
			{

				return 1;

			}
		}
	}
	return 0;
}

CMD:buytaxi(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, 1685.4528,-1464.4073,13.5469)) return Error(playerid, "You have to be at the taxi point");
	if(pData[playerid][pJob] == 1 || pData[playerid][pJob2] == 1)
	{
		new mstr[212];
		format(mstr, sizeof(mstr), ""WHITE_E"%s\t\t"LG_E"$%s\n"WHITE_E"%s\t\t"LG_E"$%s", 
		GetVehicleModelName(420), FormatMoney(GetVehicleCost(420)),
		GetVehicleModelName(438), FormatMoney(GetVehicleCost(438))
		);
		ShowPlayerDialog(playerid, DIALOG_BUYTAXI, DIALOG_STYLE_LIST, "Buy Taxi", mstr, "Buy", "Cancel");
	}
	else return Error(playerid, "You are not Taxi Driver.");
	return 1;
}

CMD:accepttaxi(playerid, params[])
{
	static otherid, Float:x, Float:y, Float:z;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/accepttaxi [playerid/PartOfName]");
	if(pData[playerid][pJob] == 1 || pData[playerid][pJob2] == 1)
	{
		if(pData[otherid][pTaxiCall] > 0)
		{
			GetPlayerPos(otherid, x, y, z);
			SetPlayerCheckpoint(playerid, x, y, z, 5.0);
			SendClientMessageEx(playerid, COLOR_ARWIN, "SERVICE: "WHITE_E"You've accepted the taxi request from {00FFFF}%s "YELLOW_E"(%d)", pData[otherid][pName], pData[otherid][pPhone]);
			SendClientMessageEx(otherid, COLOR_ARWIN, "SERVICE: {00FFFF}%s "YELLOW_E"(%d) "WHITE_E"has accepted your taxi call. Please wait patiently until they arrive.", pData[playerid][pName], pData[playerid][pPhone]);
			SendClientMessageEx(playerid, COLOR_ARWIN, "SERVICE: Notes from client: "YELLOW_E"%s", pData[otherid][pServiceText]);
			SendClientMessageEx(playerid, COLOR_ARWIN, "GPS: Navigation set to client's current location");
			pData[otherid][pTaxiCall] = -1;
			format(pData[otherid][pServiceText], 128, "");
		}
		else
		{
			Error(playerid, "That Player does not require any taxi service");
		}
	}	
	return 1;
}

CMD:fare(playerid, params[])
{
	if(pData[playerid][pTaxiDuty] == 0)
		return Error(playerid, "Anda harus On duty taxi.");
		
	new vehicleid = GetPlayerVehicleID(playerid);
	new modelid = GetVehicleModel(vehicleid);
		
	if(modelid != 438 && modelid != 420)
		return Error(playerid, "Anda harus mengendarai taxi.");
		
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return Error(playerid, "Anda bukan driver.");
	
	
	if(pData[playerid][pFare] == 0)
	{
		if(CheckPassengers(vehicleid) != 1) return Error(playerid,"Tidak ada penumpang!");
		GetPlayerPos(playerid, Float:pData[playerid][pFareOldX], Float:pData[playerid][pFareOldY], Float:pData[playerid][pFareOldZ]);
		pData[playerid][pFareTimer] = SetTimerEx("FareUpdate", 1100, true, "ii", playerid, GetVehiclePassenger(vehicleid));
		pData[playerid][pFare] = 1;
		pData[playerid][pTotalFare] = 5;
		new formatted[128];
		format(formatted,128,"%s", FormatMoney(pData[playerid][pTotalFare]));
		TextDrawShowForPlayer(playerid, TDEditor_TD[0]);
		TextDrawShowForPlayer(playerid, DPvehfare[playerid]);
		TextDrawSetString(DPvehfare[playerid], formatted);
		Info(playerid, "Anda telah mengaktifkan taxi fare, silahkan menuju ke tempat tujuan!");
		//passanger
		TextDrawShowForPlayer(GetVehiclePassenger(vehicleid), TDEditor_TD[0]);
		TextDrawShowForPlayer(GetVehiclePassenger(vehicleid), DPvehfare[GetVehiclePassenger(vehicleid)]);
		TextDrawSetString(DPvehfare[GetVehiclePassenger(vehicleid)], formatted);
		Info(GetVehiclePassenger(vehicleid), "Taxi fare telah aktif!");
	}
	else
	{
		TextDrawHideForPlayer(playerid, TDEditor_TD[0]);
		TextDrawHideForPlayer(playerid, DPvehfare[playerid]);
		KillTimer(pData[playerid][pFareTimer]);
		Info(playerid, "Anda telah menonaktifkan taxi fare pada total: {00FF00}%s", FormatMoney(pData[playerid][pTotalFare]));
		//passanger
		Info(GetVehiclePassenger(vehicleid), "Taxi fare telah di non aktifkan pada total: {00FF00}%s", FormatMoney(pData[playerid][pTotalFare]));
		TextDrawHideForPlayer(GetVehiclePassenger(vehicleid), TDEditor_TD[0]);
		TextDrawHideForPlayer(GetVehiclePassenger(vehicleid), DPvehfare[GetVehiclePassenger(vehicleid)]);
		pData[playerid][pFare] = 0;
		pData[playerid][pTotalFare] = 0;
	}
	return 1;
}

function FareUpdate(playerid, passanger)
{	
	new formatted[128];
	GetPlayerPos(playerid,pData[playerid][pFareNewX],pData[playerid][pFareNewY],pData[playerid][pFareNewZ]);
	new Float:totdistance = GetDistanceBetweenPoints(pData[playerid][pFareOldX],pData[playerid][pFareOldY],pData[playerid][pFareOldZ], pData[playerid][pFareNewX],pData[playerid][pFareNewY],pData[playerid][pFareNewZ]);
    if(totdistance > 300.0)
    {
		new argo = RandomEx(4, 10);
	    pData[playerid][pTotalFare] = pData[playerid][pTotalFare]+argo;
		format(formatted,128,"%s", FormatMoney(pData[playerid][pTotalFare]));
		TextDrawShowForPlayer(playerid, DPvehfare[playerid]);
		TextDrawSetString(DPvehfare[playerid], formatted);
		GetPlayerPos(playerid,Float:pData[playerid][pFareOldX],Float:pData[playerid][pFareOldY],Float:pData[playerid][pFareOldZ]);
		//passanger
		TextDrawShowForPlayer(passanger, DPvehfare[passanger]);
		TextDrawSetString(DPvehfare[passanger], formatted);
	}
	return 1;
}
