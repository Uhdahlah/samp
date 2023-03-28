//======== Pizza ===========
CMD:getpizza(playerid, params[])
{
	if(pData[playerid][pSideJob] == 501)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER && !IsAPizzaVeh(vehicleid)) return Error(playerid, "Anda harus mengendarai pizzaboy.");
		if(SedangAnterPizza[playerid] == 1)
		    return Error(playerid, "Kamu sedang membawa pizza!");
		if(pData[playerid][pPizzaTime] > 0)
		{
			Error(playerid, "Anda harus menunggu "YELLOW_E"%d "WHITE_E"detik lagi.", pData[playerid][pPizzaTime]);
			return 1;
		}
		
		new houseid = random(100);
		houseid += 25;
		if(houseid > MAX_HOUSES) houseid = 10;
		SetPlayerCheckpoint(playerid, hData[houseid][hExtposX], hData[houseid][hExtposY], hData[houseid][hExtposZ], 4.0);
		SendClientMessageEx(playerid, COLOR_ARWIN,"PIZZA JOB: {FFFFFF}Pergi ke rumah no. %d (checkpoint ditandai di map)", houseid);
		SetPlayerAttachedObject(playerid, 1 , 2814, 1,0.11,0.36,0.0,0.0,90.0);
		SedangAnterPizza[playerid] = 1;
	}
	else return Error(playerid, "You're not working as pizza courier");
	return 1;
}
