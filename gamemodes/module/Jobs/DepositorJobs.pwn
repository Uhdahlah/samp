CreateDepositorJobPoint()
{
	//JOBS
	new strings[128];
	CreateDynamicPickup(1239, 23, 1509.6610, -1060.1007, 25.0625, -1);
	format(strings, sizeof(strings), "[DEPOSITOR]\n{7fffd4}/joinjob /accept job");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 1509.6610, -1060.1007, 25.0625, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //Depositor
}

CreateLoadMoneyJobPoint()
{
	//JOBS
	new strings[128];
	CreateDynamicPickup(1239, 23, 1498.4901, -1042.2596, 23.8161, -1);
	format(strings, sizeof(strings), "[DEPOSITOR]\n{FFFFFF}/loadbankmoney to take bankmoney");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 1498.4901, -1042.2596, 23.8161, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //Depositor
}

function Depositor(playerid)
{
    if(!IsValidTimer(pData[playerid][pActivity])) return 0;
	{
	    if(pData[playerid][pActivityTime] >= 100)
	    {
	    	InfoTD_MSG(playerid, 8000, "Load BankMoney Done!");
	    	TogglePlayerControllable(playerid, 1);
	    	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pEnergy] -= 8;
			pData[playerid][pActivityTime] = 0;
		}
 		else if(pData[playerid][pActivityTime] < 100)
		{
	    	pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
	    	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
		}
	}
	return 1;
}

CMD:loadbankmoney(playerid, params[])
{
	if(pData[playerid][pJob] == 10 || pData[playerid][pJob2] == 10)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
	    if(vehicleid == 609 || vehicleid == 498) return Error(playerid, "You must be inside a boxville.");
		if(IsPlayerInRangeOfPoint(playerid, 5.0, 1498.4901, -1042.2596, 23.8161))
		{
			if(GetPVarInt(playerid, "Depositor") > gettime()) return Error(playerid, "Delays Load BankMoney, please wait.");
			if(pvData[vehicleid][cDepositor] > 5) return Error(playerid, "Bank Money is full in this vehicle.");
    		
    		if((vehicleid = Vehicle_Nearest2(playerid)) != -1)
			{
				TogglePlayerControllable(playerid, 0);
				pData[playerid][pActivity] = SetTimerEx("Depositor", 30, true, "i", playerid);
    			PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Loadbankmoney...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
				pvData[vehicleid][cDepositor] += 5;
			}
		}
		else return SendClientMessage(playerid, COLOR_GREY, "You should be in the bank");
    }
    else return Error(playerid, "You are not depositor jobs.");
    return 1;
}

CMD:takebankmoney(playerid, params[])
{
	if(pData[playerid][pJob] == 10 || pData[playerid][pJob2] == 10)
	{
		if(IsPlayerInAnyVehicle(playerid)) return Error(playerid, "Anda harus keluar dari kendaraan.");
		new carid = -1;
		new vehicleid = GetNearestVehicleToPlayer(playerid, 3.5, false);
		if(vehicleid == INVALID_VEHICLE_ID) return Error(playerid, "You not in near any vehicles.");
		if(vehicleid == 609 || vehicleid == 498) return Error(playerid, "You must be inside a boxville.");

  		if((carid = Vehicle_Nearest(playerid)) != -1)
		{
			if(IsValidVehicle(pvData[carid][cVeh]))
			{
				if(pvData[carid][cDepositor] < 1) return Error(playerid, "Kamu tidak punya uang bank di kendaraan anda");
				
				pvData[carid][cDepositor] -= 1;
				pData[playerid][pDepositor] += 1;
				SetPlayerAttachedObject(playerid, 1, 1550, 3, 0.1, 0.1, -0.1, 0.0, 270.0, 0.0, 1, 1, 1);
			}
		}
	}
	else return Error(playerid, "You are not depositor jobs.");
	return 1;
}

CMD:atmdeposit(playerid, params[])
{
    new id = -1;
	id = GetClosestATM(playerid);
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	if(pData[playerid][pJob] == 10 || pData[playerid][pJob2] == 10)
	{
		if(id > -1)
		{
		    if(pData[playerid][pDepositor] < 0) return Error(playerid, "Kamu tidak mempunyai BankMoney di tas mu!.");
			pData[playerid][pDepositor] -= 1;
			pData[playerid][pJobTime] += 380;
			Server_AddMoney(656000);
			AddPlayerSalary(playerid, "Jobs(Depositor)", "Deposit $6,560.00 to ATM", 2000);
			Info(playerid, "Kamu Telah Mendepositkan Uang Bank Sebesar "GREEN_E"$6,560.00.");
			RemovePlayerAttachedObject(playerid, 1);
		}
	}
	else return Error(playerid, "You are not depositor jobs.");
	return 1;
}
