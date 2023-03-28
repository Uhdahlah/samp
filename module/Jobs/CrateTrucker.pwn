CMD:getcrate(playerid, params[])
{
    if(pData[playerid][pDelayTruckerDeli] == 0) 
    {
        if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
        {
            if(IsPlayerInRangeOfPoint(playerid, 4.0, 323.6411, 904.5583, 21.5862))
            {
                if(StockCrateFish > 0)
                {
                    SendClientMessageEx(playerid, COLOR_ARWIN, "JOB: "WHITE_E"You've picked up "YELLOW_E"1 box component crate");    
                    pData[playerid][pCrate] = 1;
                    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_CARRY);
                    SetPlayerAttachedObject(playerid, 9, 2912, 1, 0.233, 0.359, -0.198, 1.400, 0.000, 0.000, 0.640, 0.625, 0.654);
                    pData[playerid][pCrateType] = 1;
                }
                else return Error(playerid, "wait a moment"); 
            }
            else if(IsPlayerInRangeOfPoint(playerid, 4.0, 2836.3945,-1541.1984,11.0991))
            {
                if(StockFish < 1) return Error(playerid, "Fish stock is running out");
                if(StockCrateFish > 0)
                {
                    new fish[212];
                    SendClientMessageEx(playerid, COLOR_ARWIN, "JOB: "WHITE_E"You've picked up "YELLOW_E"1 box fish crate");    
                    pData[playerid][pCrate] = 1;
                    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_CARRY);
                    SetPlayerAttachedObject(playerid, 9, 2912, 1, 0.233, 0.359, -0.198, 1.400, 0.000, 0.000, 0.640, 0.625, 0.654);
                    pData[playerid][pCrateType] = 2;
                    StockFish -= 10;
                    format(fish, sizeof(fish), "{00FFFF}Canned Fish Crates\nAvailable crates: "GREEN_E"%d "YELLOW_E"/ 40\n"WHITE_E"Use "YELLOW_E"'/getcrate' "WHITE_E"to pickup a crate", StockCrateFish);
	                UpdateDynamic3DTextLabelText(Fish2, COLOR_ARWIN, fish);
                } 
                else return Error(playerid, "wait a moment"); 
            }
        }
        else return Error(playerid, "You are not a trucker");
    }
    else 
    {
        new String[212];
        format(String, sizeof(String),"ERROR: "WHITE_E"Kamu harus menunggu "YELLOW_E"%d Menit "WHITE_E"untuk mengangkat crate lagi", pData[playerid][pDelayTruckerDeli]/60);
        SendClientMessage(playerid, COLOR_ARWIN, String);
    }    
    return 1;
}

CMD:loadcrate(playerid, params[])
{
    if(pData[playerid][pCrate] < 1) return Error(playerid, "You didn't bring the crate");
    new Float: x, Float: y, Float: z;
    new vehicleid = GetPVarInt(playerid, "LastVehicleID");
    GetVehicleBoot(GetPVarInt(playerid, "LastVehicleID"), x, y, z);
    if(GetPlayerDistanceFromPoint(playerid, x, y, z) > 3.0) return Error(playerid, "Your last vehicle is too far away.");  
    if(Vehicle_CrateComponentTotal(vehicleid) >= 10) return Error(playerid, "You can't load any more crate to this vehicle.");    
    if(Vehicle_CrateFishTotal(vehicleid) >= 10) return Error(playerid, "You can't load any more crate to this vehicle.");    
    if(!IsATruckCrate(vehicleid)) return Error(playerid, "You must use a crate type car");
    if(pData[playerid][pCrateType] == 1)
    {
        foreach(new pv : PVehicles)
        {
            if(vehicleid == pvData[pv][cVeh])
            {
                pvData[pv][cCrateComponent]++;
                pData[playerid][pCrate] = 0;
                SendClientMessage(playerid, COLOR_ARWIN, "JOB: "WHITE_E"You've loaded 1 crate");    
                SendClientMessageEx(playerid, COLOR_ARWIN, "JOB: "WHITE_E"Total crates stored "YELLOW_E"%d", pvData[pv][cCrateComponent]); 
                SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
                RemovePlayerAttachedObject(playerid, 9);
            }
        }   
    }
    else if(pData[playerid][pCrateType] == 2)
    {
        foreach(new pv : PVehicles)
        {
            if(vehicleid == pvData[pv][cVeh])
            {
                pvData[pv][cCrateFish]++;
                pData[playerid][pCrate] = 0;
                SendClientMessageEx(playerid, COLOR_ARWIN, "JOB: "WHITE_E"You've loaded 1 crate");    
                SendClientMessageEx(playerid, COLOR_ARWIN, "JOB: "WHITE_E"Total crates stored "YELLOW_E"%d", pvData[pv][cCrateFish]); 
                SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
                RemovePlayerAttachedObject(playerid, 9);
            }
        }   
    }
    return 1;
}

CMD:unloadcrate(playerid, params[])
{
    new vehicleid = GetPlayerVehicleID(playerid);
    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return Error(playerid, "You are not driver in crate truck.");
    if(!IsValidVehicle(vehicleid)) return Error(playerid, "You're not in any vehicle.");
    if(IsPlayerInRangeOfPoint(playerid, 4.0, 797.7953,-616.8799,16.3359))
    {
        foreach(new pv : PVehicles)
        {
            if(vehicleid == pvData[pv][cVeh])
            {
                if(pvData[pv][cCrateComponent] > 0)
                {
                    if(StockComponent > 50000) return Error(playerid, "Stock components in the warehouse exceed capacity");
                    new cash = pvData[pv][cCrateComponent] * 1500;
                    if(cash < 1) return Error(playerid, "This vehicle crate is empty!");
                    StockComponent += pvData[pv][cCrateComponent] + 10;
                    new list[212];
                    format(list, sizeof(list), "Delivered %d component crates", pvData[pv][cCrateComponent]);
                    AddPlayerSalary(playerid, "Trucking Co.", list, cash);
                    SendClientMessage(playerid, COLOR_ARWIN, "SALARY: "WHITE_E"Your salary statement has been update, please check command "YELLOW_E"'/mysalary'");
                    pvData[pv][cCrateComponent] = 0;
                    pData[playerid][pDelayTruckerDeli] = 600;
                    pData[playerid][LevelTrucker] += 10;
                    for(new i = 0; i < 2; i++) 
                    {
                        TextDrawHideForPlayer(playerid, Crate[i]);
                        PlayerTextDrawHide(playerid, PlayerCrate[playerid]);
                    }	
                }  
            }
        }       
          
    }
    else if(IsPlayerInRangeOfPoint(playerid, 4.0, -577.1335,-503.6530,25.5107))
    {
        foreach(new pv : PVehicles)
        {
            if(vehicleid == pvData[pv][cVeh])
            {
                if(pvData[pv][cCrateFish] > 0)
                {
                    new cash = pvData[pv][cCrateFish] * 1500;
                    if(cash < 1) return Error(playerid, "This vehicle crate is empty!");
                    StockComponent += pvData[pv][cCrateFish] + 10;
                    new list[212];
                    format(list, sizeof(list), "Delivered %d fish crates", pvData[pv][cCrateFish]);
                    AddPlayerSalary(playerid, "Trucking Co.", list, cash);
                    SendClientMessage(playerid, COLOR_ARWIN, "SALARY: "WHITE_E"Your salary statement has been update, please check command "YELLOW_E"'/mysalary'");
                    pvData[pv][cCrateFish] = 0;
                    pData[playerid][pDelayTruckerDeli] = 600;
                    pData[playerid][LevelTrucker] += 10;
                    for(new i = 0; i < 2; i++) 
                    {
                        TextDrawHideForPlayer(playerid, Crate[i]);
                        PlayerTextDrawHide(playerid, PlayerCrate[playerid]);
                    }	
                }  
            }
        }       
                
    } 
    return 1;
}

CMD:dropcrate(playerid, params[])
{
    if(pData[playerid][pCrate] > 0)
    {
        pData[playerid][pCrate] = 0;
        SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
        RemovePlayerAttachedObject(playerid, 9);
        SendClientMessageEx(playerid, COLOR_ARWIN, "JOB: "YELLOW_E"You have dropped the crate");    
    }
    return 1;
}

Vehicle_CrateComponentTotal(vehicleid)
{
	new count = 0;
    foreach(new pv : PVehicles)
    {
        if(vehicleid == pvData[pv][cVeh])
        {
            count += pvData[pv][cCrateComponent];
        }
    }        
	return count;
}

Vehicle_CrateFishTotal(vehicleid)
{
	new count = 0;
    foreach(new pv : PVehicles)
    {
        if(vehicleid == pvData[pv][cVeh])
        {
            count += pvData[pv][cCrateFish];
        }
    }    
	return count;
}
