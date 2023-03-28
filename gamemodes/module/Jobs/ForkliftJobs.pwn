//======== Forklift ===========
#define Forkliftpoint1 2475.1362,-2566.0513,13.6484
#define Forkliftpoint2 2737.2200,-2465.9072,13.2468
#define Forkliftpoint3 2446.2175,-2501.7361,13.6484
#define Forkliftpoint4 2737.2200,-2465.9072,13.2468
#define Forkliftpoint5 2402.9636,-2563.4978,13.6495
#define Forkliftpoint6 2737.2200,-2465.9072,13.2468
#define Forkliftpoint7 2366.5349,-2314.3242,13.5469
#define Forkliftpoint8 2737.2200,-2465.9072,13.2468
#define Forkliftpoint9 2557.7595,-2408.6260,13.6342
#define Forkliftpoint10 2737.2200,-2465.9072,13.2468
#define Forkliftpoint11 2742.4250,-2420.9465,13.6463 

CMD:loadcreate(playerid,params[])
{
	if(pData[playerid][pSideJob] == 401)
	{
		if(IsPlayerInRangeOfPoint(playerid, 6.0,Forkliftpoint1))
		{
			TogglePlayerControllable(playerid, 0);
			pData[playerid][pActivity] = SetTimerEx("ForkliftJob", 1000, true, "i", playerid);
			PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Load Create");
			PlayerTextDrawShow(playerid, ActiveTD[playerid]);
			ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
			pData[playerid][pJobsForklift1] = 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 6.0,Forkliftpoint3))
		{
			TogglePlayerControllable(playerid, 0);
			pData[playerid][pActivity] = SetTimerEx("ForkliftJob3", 1000, true, "i", playerid);
			PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Load Create");
			PlayerTextDrawShow(playerid, ActiveTD[playerid]);
			ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
			pData[playerid][pJobsForklift1] = 2;
		}
		if(IsPlayerInRangeOfPoint(playerid, 6.0,Forkliftpoint5))
		{
			TogglePlayerControllable(playerid, 0);
			pData[playerid][pActivity] = SetTimerEx("ForkliftJob5", 1000, true, "i", playerid);
			PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Load Create");
			PlayerTextDrawShow(playerid, ActiveTD[playerid]);
			ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
			pData[playerid][pJobsForklift1] = 3;
		}
		if(IsPlayerInRangeOfPoint(playerid, 6.0,Forkliftpoint7))
		{
			TogglePlayerControllable(playerid, 0);
			pData[playerid][pActivity] = SetTimerEx("ForkliftJob7", 1000, true, "i", playerid);
			PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Load Create");
			PlayerTextDrawShow(playerid, ActiveTD[playerid]);
			ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
			pData[playerid][pJobsForklift1] = 4;
		}
		if(IsPlayerInRangeOfPoint(playerid, 6.0,Forkliftpoint9))
		{
			TogglePlayerControllable(playerid, 0);
			pData[playerid][pActivity] = SetTimerEx("ForkliftJob9", 1000, true, "i", playerid);
			PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Load Create");
			PlayerTextDrawShow(playerid, ActiveTD[playerid]);
			ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
			pData[playerid][pJobsForklift1] = 5;
		}
	}
	else return Error(playerid, "You are not Forklift job.");
	return 1;
}

CMD:unloadcreate(playerid,params[])
{
	if(pData[playerid][pSideJob] == 401)
	{
		if(IsPlayerInRangeOfPoint(playerid, 6.0,Forkliftpoint2))
		{
			if(pData[playerid][pJobsForklift1] == 1)
			{
				if(IsValidDynamicObject(objectforklift))
					DestroyDynamicObject(objectforklift);
				SetPlayerRaceCheckpoint(playerid, 1, Forkliftpoint3, Forkliftpoint3, 3.0);
				pData[playerid][pJobsForklift1] = -1;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 6.0,Forkliftpoint4))
		{
			if(pData[playerid][pJobsForklift1] == 2)
			{
				if(IsValidDynamicObject(objectforklift))
					DestroyDynamicObject(objectforklift);
				SetPlayerRaceCheckpoint(playerid, 1, Forkliftpoint5, Forkliftpoint5, 3.0);
				pData[playerid][pJobsForklift1] = -1;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 6.0,Forkliftpoint6))
		{
			if(pData[playerid][pJobsForklift1] == 3)
			{
				if(IsValidDynamicObject(objectforklift))
					DestroyDynamicObject(objectforklift);
				SetPlayerRaceCheckpoint(playerid, 1, Forkliftpoint7, Forkliftpoint7, 3.0);
				pData[playerid][pJobsForklift1] = -1;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 6.0,Forkliftpoint8))
		{
			if(pData[playerid][pJobsForklift1] == 4)
			{
				if(IsValidDynamicObject(objectforklift))
					DestroyDynamicObject(objectforklift);
				SetPlayerRaceCheckpoint(playerid, 1, Forkliftpoint9, Forkliftpoint9, 3.0);
				pData[playerid][pJobsForklift1] = -1;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 6.0,Forkliftpoint10))
		{
			if(pData[playerid][pJobsForklift1] == 5)
			{
				if(IsValidDynamicObject(objectforklift))
					DestroyDynamicObject(objectforklift);
				SetPlayerRaceCheckpoint(playerid, 1, Forkliftpoint11, Forkliftpoint11, 3.0);
				pData[playerid][pJobsForklift1] = -1;
			}
		}
	}
	else return Error(playerid, "You are not Forklift job.");
	return 1;
}

function ForkliftJob(playerid)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidTimer(pData[playerid][pActivity])) return 0;
    if(pData[playerid][pSideJob] == 401)
	{
		if(pData[playerid][pActivityTime] >= 100 && pData[playerid][pSideJob] == 401)
		{
		    objectforklift = CreateDynamicObject(1271,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
		    AttachDynamicObjectToVehicle(objectforklift, vehicleid, 0.000, 0.530, 0.260, 0.000, 0.000, 0.000);

			InfoTD_MSG(playerid, 8000, "Load Done");
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pActivityTime] = 0;
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			TogglePlayerControllable(playerid, 1);
			SetPlayerRaceCheckpoint(playerid, 1, Forkliftpoint2, Forkliftpoint2, 3.0);
			return 1;
		}
		else if(pData[playerid][pActivityTime] < 100)
		{
			pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
		}
	}
	return 1;
}

function ForkliftJob3(playerid)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidTimer(pData[playerid][pActivity])) return 0;
    if(pData[playerid][pSideJob] == 401)
	{
		if(pData[playerid][pActivityTime] >= 100 && pData[playerid][pSideJob] == 401)
		{
		    objectforklift = CreateDynamicObject(1271,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
		    AttachDynamicObjectToVehicle(objectforklift, vehicleid, 0.000, 0.530, 0.260, 0.000, 0.000, 0.000);

			InfoTD_MSG(playerid, 8000, "Load Done");
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pActivityTime] = 0;
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			TogglePlayerControllable(playerid, 1);
			SetPlayerRaceCheckpoint(playerid, 1, Forkliftpoint4, Forkliftpoint4, 3.0);
			return 1;
		}
		else if(pData[playerid][pActivityTime] < 100)
		{
			pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
		}
	}
	return 1;
}

function ForkliftJob5(playerid)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidTimer(pData[playerid][pActivity])) return 0;
    if(pData[playerid][pSideJob] == 401)
	{
		if(pData[playerid][pActivityTime] >= 100 && pData[playerid][pSideJob] == 401)
		{
		    objectforklift = CreateDynamicObject(1271,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
		    AttachDynamicObjectToVehicle(objectforklift, vehicleid, 0.000, 0.530, 0.260, 0.000, 0.000, 0.000);

			InfoTD_MSG(playerid, 8000, "Load Done");
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pActivityTime] = 0;
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			TogglePlayerControllable(playerid, 1);
			SetPlayerRaceCheckpoint(playerid, 1, Forkliftpoint6, Forkliftpoint6, 3.0);
			return 1;
		}
		else if(pData[playerid][pActivityTime] < 100)
		{
			pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
		}
	}
	return 1;
}

function ForkliftJob7(playerid)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidTimer(pData[playerid][pActivity])) return 0;
    if(pData[playerid][pSideJob] == 401)
	{
		if(pData[playerid][pActivityTime] >= 100 && pData[playerid][pSideJob] == 401)
		{
		    objectforklift = CreateDynamicObject(1271,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
		    AttachDynamicObjectToVehicle(objectforklift, vehicleid, 0.000, 0.530, 0.260, 0.000, 0.000, 0.000);

			InfoTD_MSG(playerid, 8000, "Load Done");
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pActivityTime] = 0;
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			TogglePlayerControllable(playerid, 1);
			SetPlayerRaceCheckpoint(playerid, 1, Forkliftpoint8, Forkliftpoint8, 3.0);
			return 1;
		}
		else if(pData[playerid][pActivityTime] < 100)
		{
			pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
		}
	}
	return 1;
}

function ForkliftJob9(playerid)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidTimer(pData[playerid][pActivity])) return 0;
    if(pData[playerid][pSideJob] == 401)
	{
		if(pData[playerid][pActivityTime] >= 100 && pData[playerid][pSideJob] == 401)
		{
		    objectforklift = CreateDynamicObject(1271,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
		    AttachDynamicObjectToVehicle(objectforklift, vehicleid, 0.000, 0.530, 0.260, 0.000, 0.000, 0.000);

			InfoTD_MSG(playerid, 8000, "Load Done");
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pActivityTime] = 0;
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			TogglePlayerControllable(playerid, 1);
			SetPlayerRaceCheckpoint(playerid, 1, Forkliftpoint10, Forkliftpoint10, 3.0);
			return 1;
		}
		else if(pData[playerid][pActivityTime] < 100)
		{
			pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
		}
	}
	return 1;
}
