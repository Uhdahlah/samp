#define trashpoint1 308.6719, -255.0938, 1.2578
#define trashpoint2 1300.0153, 220.5041, 19.5546
#define trashpoint3 1521.7073, -1016.5623, 23.9526
#define trashpoint4 1461.3623, -1488.3853, 13.5468
#define trashpoint5 1065.4986, 1997.2067, 10.8203
#define trashpoint6 2879.0771, 857.1984, 10.7500
#define trashpoint7 1880.0106, 684.8323, 10.8203
#define trashpoint8 1368.2908, 483.1417, 20.0269
#define trashpoint9 1807.4376, -1800.7867, 13.5453
#define trashpoint10 2094.4639, -2040.1442, 14.0958

CMD:loadtrash(playerid,params[])
{
	if(pData[playerid][pSideJob] == 301)
	{	
		if(IsPlayerInRangeOfPoint(playerid, 6.0,trashpoint1))
		{
			TogglePlayerControllable(playerid, 0);
			pData[playerid][pActivity] = SetTimerEx("TrashJob", 500, true, "i", playerid);
			PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Load Trash");
			PlayerTextDrawShow(playerid, ActiveTD[playerid]);
			ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
			RemovePlayerMapIcon(playerid, 1);
		} 
		if(IsPlayerInRangeOfPoint(playerid, 6.0,trashpoint2))
		{	
			TogglePlayerControllable(playerid, 0);
			pData[playerid][pActivity] = SetTimerEx("TrashJob2", 500, true, "i", playerid);
			PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Load Trash");
			PlayerTextDrawShow(playerid, ActiveTD[playerid]);
			ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
			RemovePlayerMapIcon(playerid, 2);
		}
		if(IsPlayerInRangeOfPoint(playerid, 6.0,trashpoint3))
		{
			TogglePlayerControllable(playerid, 0);
			pData[playerid][pActivity] = SetTimerEx("TrashJob3", 500, true, "i", playerid);
			PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Load Trash");
			PlayerTextDrawShow(playerid, ActiveTD[playerid]);
			ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
			RemovePlayerMapIcon(playerid, 3);
		} 
		if(IsPlayerInRangeOfPoint(playerid, 6.0,trashpoint4))
		{
			TogglePlayerControllable(playerid, 0);
			pData[playerid][pActivity] = SetTimerEx("TrashJob4", 500, true, "i", playerid);
			PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Load Trash");
			PlayerTextDrawShow(playerid, ActiveTD[playerid]);
			ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
			RemovePlayerMapIcon(playerid, 4);
		} 
		if(IsPlayerInRangeOfPoint(playerid, 6.0,trashpoint5))
		{
			TogglePlayerControllable(playerid, 0);
			pData[playerid][pActivity] = SetTimerEx("TrashJob5", 500, true, "i", playerid);
			PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Load Trash");
			PlayerTextDrawShow(playerid, ActiveTD[playerid]);
			ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
			RemovePlayerMapIcon(playerid, 5);
		} 
		if(IsPlayerInRangeOfPoint(playerid, 6.0,trashpoint6))
		{
			TogglePlayerControllable(playerid, 0);
			pData[playerid][pActivity] = SetTimerEx("TrashJob6", 500, true, "i", playerid);
			PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Load Trash");
			PlayerTextDrawShow(playerid, ActiveTD[playerid]);
			ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
			RemovePlayerMapIcon(playerid, 6);
		} 
		if(IsPlayerInRangeOfPoint(playerid, 6.0,trashpoint7))
		{
			TogglePlayerControllable(playerid, 0);
			pData[playerid][pActivity] = SetTimerEx("TrashJob7", 500, true, "i", playerid);
			PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Load Trash");
			PlayerTextDrawShow(playerid, ActiveTD[playerid]);
			ShowPlayerProgressBar(playerid, pData[playerid][activitybar]); 
			RemovePlayerMapIcon(playerid, 7);
		} 
		if(IsPlayerInRangeOfPoint(playerid, 6.0,trashpoint8))
		{
			TogglePlayerControllable(playerid, 0);
			pData[playerid][pActivity] = SetTimerEx("TrashJob8", 500, true, "i", playerid);
			PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Load Trash");
			PlayerTextDrawShow(playerid, ActiveTD[playerid]);
			ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
			RemovePlayerMapIcon(playerid, 8);
		} 
		if(IsPlayerInRangeOfPoint(playerid, 6.0,trashpoint9))
		{
			TogglePlayerControllable(playerid, 0);
			pData[playerid][pActivity] = SetTimerEx("TrashJob9", 500, true, "i", playerid);
			PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Load Trash");
			PlayerTextDrawShow(playerid, ActiveTD[playerid]);
			ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
			RemovePlayerMapIcon(playerid, 9);
		} 
	}
	else return Error(playerid, "You are not TrashMaster job.");	
	return 1;
}

CMD:unloadtrash(playerid,params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(pData[playerid][pSideJob] == 301)
	{
		if(IsPlayerInRangeOfPoint(playerid, 10.0,trashpoint10))
		{
			pData[playerid][pSideJob] = 0;
			pData[playerid][pSideJobsTrash] = 1800;
			new cash = TrashTotal[playerid] * 2500;
			new list[212];
			format(list, sizeof(list), "Throw %d garbage", TrashTotal[playerid]);
			AddPlayerSalary(playerid, "Sidejob(Trash)", list, cash);
			SendClientMessageEx(playerid, COLOR_ARWIN, "PAYCHECK: "GREEN_E"$%s "WHITE_E"telah dimasukkan ke Jobsalary mu.", FormatMoney(cash));
			RemovePlayerFromVehicle(playerid);
			SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
			for(new i = 0; i < 11; i++) 
			{
				RemovePlayerMapIcon(playerid, i);
			}
		}
		else return Error(playerid, "You are not near to unload location.");
	}
	else return Error(playerid, "You are not TrashMaster job.");	
	return 1;
}

function TrashJob(playerid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidTimer(pData[playerid][pActivity])) return 0;
    if(pData[playerid][pSideJob] == 301)
	{
		if(pData[playerid][pActivityTime] >= 100 && pData[playerid][pSideJob] == 301)
		{
			InfoTD_MSG(playerid, 8000, "Terload...!");
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pActivityTime] = 0;
			if(TrashTotal[playerid] == 9)
			{
				SetPlayerMapIcon(playerid, 10, trashpoint10, 0, 3, 0);//10
				SendClientMessageEx(playerid, COLOR_ARWIN, "TRASH: "WHITE_E"The load in the vehicle is full, please return the vehicle "YELLOW_E"use '/unloadtrash' to unload");
			}
			else
			{
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				TogglePlayerControllable(playerid, 1);
				TrashTotal[playerid]++;
				SendClientMessageEx(playerid, COLOR_ARWIN, "TRASH: "WHITE_E"Total trash in the vehicle "YELLOW_E"%d/8", TrashTotal[playerid]);
				RemovePlayerMapIcon(playerid, 20);
			}
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

function TrashJob2(playerid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidTimer(pData[playerid][pActivity])) return 0;
    if(pData[playerid][pSideJob] == 301)
	{
		if(pData[playerid][pActivityTime] >= 100 && pData[playerid][pSideJob] == 301)
		{
			InfoTD_MSG(playerid, 8000, "Terload...!");
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pActivityTime] = 0;
			if(TrashTotal[playerid] == 9)
			{
				SetPlayerMapIcon(playerid, 10, trashpoint10, 0, 3, 0);//10
				SendClientMessageEx(playerid, COLOR_ARWIN, "TRASH: "WHITE_E"The load in the vehicle is full, please return the vehicle "YELLOW_E"use '/unloadtrash' to unload");
			}
			else
			{
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				TogglePlayerControllable(playerid, 1);
				TrashTotal[playerid]++;
				SendClientMessageEx(playerid, COLOR_ARWIN, "TRASH: "WHITE_E"Total trash in the vehicle "YELLOW_E"%d/8", TrashTotal[playerid]);
				RemovePlayerMapIcon(playerid, 21);
			}
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

function TrashJob3(playerid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidTimer(pData[playerid][pActivity])) return 0;
    if(pData[playerid][pSideJob] == 301)
	{
		if(pData[playerid][pActivityTime] >= 100 && pData[playerid][pSideJob] == 301)
		{
			InfoTD_MSG(playerid, 8000, "Terload...!");
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pActivityTime] = 0;
			if(TrashTotal[playerid] == 9)
			{
				SetPlayerMapIcon(playerid, 10, trashpoint10, 0, 3, 0);//10
				SendClientMessageEx(playerid, COLOR_ARWIN, "TRASH: "WHITE_E"The load in the vehicle is full, please return the vehicle "YELLOW_E"use '/unloadtrash' to unload");
			}
			else
			{
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				TogglePlayerControllable(playerid, 1);
				TrashTotal[playerid]++;
				SendClientMessageEx(playerid, COLOR_ARWIN, "TRASH: "WHITE_E"Total trash in the vehicle "YELLOW_E"%d/8", TrashTotal[playerid]);
				RemovePlayerMapIcon(playerid, 22);
			}
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

function TrashJob4(playerid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidTimer(pData[playerid][pActivity])) return 0;
    if(pData[playerid][pSideJob] == 301)
	{
		if(pData[playerid][pActivityTime] >= 100 && pData[playerid][pSideJob] == 301)
		{
			InfoTD_MSG(playerid, 8000, "Terload...!");
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pActivityTime] = 0;
			if(TrashTotal[playerid] == 9)
			{
				SetPlayerMapIcon(playerid, 10, trashpoint10, 0, 3, 0);//10
				SendClientMessageEx(playerid, COLOR_ARWIN, "TRASH: "WHITE_E"The load in the vehicle is full, please return the vehicle "YELLOW_E"use '/unloadtrash' to unload");
			}
			else
			{
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				TogglePlayerControllable(playerid, 1);
				TrashTotal[playerid]++;
				SendClientMessageEx(playerid, COLOR_ARWIN, "TRASH: "WHITE_E"Total trash in the vehicle "YELLOW_E"%d/8", TrashTotal[playerid]);
				RemovePlayerMapIcon(playerid, 23);
			}
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

function TrashJob5(playerid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidTimer(pData[playerid][pActivity])) return 0;
    if(pData[playerid][pSideJob] == 301)
	{
		if(pData[playerid][pActivityTime] >= 100 && pData[playerid][pSideJob] == 301)
		{
			InfoTD_MSG(playerid, 8000, "Terload...!");
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pActivityTime] = 0;
			if(TrashTotal[playerid] == 9)
			{
				SetPlayerMapIcon(playerid, 10, trashpoint10, 0, 3, 0);//10
				SendClientMessageEx(playerid, COLOR_ARWIN, "TRASH: "WHITE_E"The load in the vehicle is full, please return the vehicle "YELLOW_E"use '/unloadtrash' to unload");
			}
			else
			{
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				TogglePlayerControllable(playerid, 1);
				TrashTotal[playerid]++;
				SendClientMessageEx(playerid, COLOR_ARWIN, "TRASH: "WHITE_E"Total trash in the vehicle "YELLOW_E"%d/8", TrashTotal[playerid]);
				RemovePlayerMapIcon(playerid, 24);
			}
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

function TrashJob6(playerid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidTimer(pData[playerid][pActivity])) return 0;
    if(pData[playerid][pSideJob] == 301)
	{
		if(pData[playerid][pActivityTime] >= 100 && pData[playerid][pSideJob] == 301)
		{
			InfoTD_MSG(playerid, 8000, "Terload...!");
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pActivityTime] = 0;
			if(TrashTotal[playerid] == 9)
			{
				SetPlayerMapIcon(playerid, 10, trashpoint10, 0, 3, 0);//10
				SendClientMessageEx(playerid, COLOR_ARWIN, "TRASH: "WHITE_E"The load in the vehicle is full, please return the vehicle "YELLOW_E"use '/unloadtrash' to unload");
			}
			else
			{
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				TogglePlayerControllable(playerid, 1);
				TrashTotal[playerid]++;
				SendClientMessageEx(playerid, COLOR_ARWIN, "TRASH: "WHITE_E"Total trash in the vehicle "YELLOW_E"%d/8", TrashTotal[playerid]);
				RemovePlayerMapIcon(playerid, 25);
			}
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

function TrashJob7(playerid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidTimer(pData[playerid][pActivity])) return 0;
    if(pData[playerid][pSideJob] == 301)
	{
		if(pData[playerid][pActivityTime] >= 100 && pData[playerid][pSideJob] == 301)
		{
			InfoTD_MSG(playerid, 8000, "Terload...!");
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pActivityTime] = 0;
			if(TrashTotal[playerid] == 9)
			{
				SetPlayerMapIcon(playerid, 10, trashpoint10, 0, 3, 0);//10
				SendClientMessageEx(playerid, COLOR_ARWIN, "TRASH: "WHITE_E"The load in the vehicle is full, please return the vehicle "YELLOW_E"use '/unloadtrash' to unload");
			}
			else
			{
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				TogglePlayerControllable(playerid, 1);
				TrashTotal[playerid]++;
				SendClientMessageEx(playerid, COLOR_ARWIN, "TRASH: "WHITE_E"Total trash in the vehicle "YELLOW_E"%d/8", TrashTotal[playerid]);
				RemovePlayerMapIcon(playerid, 26);
			}
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

function TrashJob8(playerid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidTimer(pData[playerid][pActivity])) return 0;
    if(pData[playerid][pSideJob] == 301)
	{
		if(pData[playerid][pActivityTime] >= 100 && pData[playerid][pSideJob] == 301)
		{
			InfoTD_MSG(playerid, 8000, "Terload...!");
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pActivityTime] = 0;
			if(TrashTotal[playerid] == 9)
			{
				SetPlayerMapIcon(playerid, 10, trashpoint10, 0, 3, 0);//10
				SendClientMessageEx(playerid, COLOR_ARWIN, "TRASH: "WHITE_E"The load in the vehicle is full, please return the vehicle "YELLOW_E"use '/unloadtrash' to unload");
			}
			else
			{
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				TogglePlayerControllable(playerid, 1);
				TrashTotal[playerid]++;
				SendClientMessageEx(playerid, COLOR_ARWIN, "TRASH: "WHITE_E"Total trash in the vehicle "YELLOW_E"%d/8", TrashTotal[playerid]);
				RemovePlayerMapIcon(playerid, 27);
			}
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

function TrashJob9(playerid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidTimer(pData[playerid][pActivity])) return 0;
    if(pData[playerid][pSideJob] == 301)
	{
		if(pData[playerid][pActivityTime] >= 100 && pData[playerid][pSideJob] == 301)
		{
			InfoTD_MSG(playerid, 8000, "Terload...!");
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pActivityTime] = 0;
			if(TrashTotal[playerid] == 9)
			{
				SetPlayerMapIcon(playerid, 10, trashpoint10, 0, 3, 0);//10
				SendClientMessageEx(playerid, COLOR_ARWIN, "TRASH: "WHITE_E"The load in the vehicle is full, please return the vehicle "YELLOW_E"use '/unloadtrash' to unload");
			}
			else
			{
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				TogglePlayerControllable(playerid, 1);
				TrashTotal[playerid]++;
				SendClientMessageEx(playerid, COLOR_ARWIN, "TRASH: "WHITE_E"Total trash in the vehicle "YELLOW_E"%d/8", TrashTotal[playerid]);
				RemovePlayerMapIcon(playerid, 28);
			}
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

