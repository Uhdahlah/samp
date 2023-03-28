task UpdateStockServer[60000]()
{
	new timber[212], compo[212];

	format(timber, sizeof(timber), "== [Timber Storage] ==\n"YELLOW_E"/lumber unload - "WHITE_E"untuk menjual semua kayu\n"GREEN_E"%d", StockTimber);
	UpdateDynamic3DTextLabelText(Timber, COLOR_ARWIN, timber);

	format(compo, sizeof(compo), "{00FFFF}Component Factory\n"WHITE_E"Price: "GREEN_E"$0.50 "WHITE_E"/ unit\n"WHITE_E"Stock: "GREEN_E"%d "YELLOW_E"/ 50000\n"WHITE_E"Use '"YELLOW_E"/buycomponent"WHITE_E"' to buy components", StockComponent);
	UpdateDynamic3DTextLabelText(Compo2, COLOR_ARWIN, compo);
}

task HouseUpdate[1000]()
{
	foreach (new house : Houses) if (hData[house][houseBuilderTime]) {
        if (gettime() >= hData[house][houseBuilderTime]) {
            hData[house][houseBuilderTime] = 0;
            hData[house][houseBuilder] = 0;
        }
    }
}

task UpdateCrateFish[1000]()
{
	new fish[212];
	if(StockCrateFish < 40)
	{
		if(TimerCrateFish > 0)
		{
			TimerCrateFish--;
			if(TimerCrateFish == 0)
			{
				TimerCrateFish = 10;
				StockCrateFish++;
				format(fish, sizeof(fish), "{00FFFF}Canned Fish Crates\nAvailable crates: "GREEN_E"%d "YELLOW_E"/ 40\n"WHITE_E"Use "YELLOW_E"'/getcrate' "WHITE_E"to pickup a crate", StockCrateFish);
				UpdateDynamic3DTextLabelText(Fish2, COLOR_ARWIN, fish);
			}
		}
	}	
}

task UpdatePricePlant[2400000]()
{
	if(ammountsellwheat < 30) { HargaAnggur = Random(10,75); } else if(ammountsellwheat < 60) { HargaAnggur = Random(10,45); } else if(ammountsellwheat < 100) { HargaAnggur = Random(10,25); }
	if(ammountsellonion < 30) { HargaBlueberry = Random(10,75); } else if(ammountsellonion < 60) { HargaBlueberry = Random(10,45); } else if(ammountsellonion < 100) { HargaBlueberry = Random(10,25); }
	if(ammountsellcarrot < 30) { HargaStrawberry = Random(10,75); } else if(ammountsellcarrot < 60) { HargaStrawberry = Random(10,45); } else if(ammountsellcarrot < 100) { HargaStrawberry = Random(10,25); }
	if(ammountsellpotato < 30) { HargaGandum = Random(10,75); } else if(ammountsellpotato < 60) { HargaGandum = Random(10,45); } else if(ammountsellpotato < 100) { HargaGandum = Random(10,25); }
	if(ammountsellcorn < 30) { HargaTomat = Random(10,75); } else if(ammountsellcorn < 60) { HargaTomat = Random(10,45); } else if(ammountsellcorn < 100) { HargaTomat = Random(10,25); }
	//Farm
	new String2[212];
	format(String2,sizeof(String2),""PURPLE_E2"Plant Price\n{FFFFFF}Wheat: "GREEN_E"$0.%s"WHITE_E"\nOnion: "GREEN_E"$0.%s"WHITE_E"\nCarrot: "GREEN_E"$0.%s"WHITE_E"\nPotato: "GREEN_E"$0.%s"WHITE_E"\nCorn: "GREEN_E"$0.%s"WHITE_E"", FormatMoney(HargaAnggur), FormatMoney(HargaBlueberry), FormatMoney(HargaStrawberry), FormatMoney(HargaGandum), FormatMoney(HargaTomat));
	SetDynamicObjectMaterialText(SELLFARM2, 0, String2, 130, "Arial", 30, 1, 0xFFFFFFFF, 0xFF000000, 1);
}

task UpdatePriceFish[1000]()
{
	new
		detik,
		menit
	;	
	detik ++;
	if(detik == 60)
	{
	    detik = 0, menit ++;
	    if(menit == 60)
	    {
	        menit = 0;
			if(ammountsellfish < 30)
			{
				FishPrice = Random(20,60);
			}
			else if(ammountsellfish < 60)
			{
				FishPrice = Random(20,45);
			}
			else if(ammountsellfish < 100)
			{
				FishPrice = Random(10,25);
			}
		}
	}		
	new String3[212];
	format(String3,sizeof(String3),"{FFFFFF}Fish Price: \n"GREEN_E"$0.%s"WHITE_E"/lb", FormatMoney(FishPrice));
	SetDynamicObjectMaterialText(SELLFISH, 0, String3, 130, "Arial", 40, 1, 0xFFFFFFFF, 0xFF000000, 1);
}

task PriceUpdate[2400000]()
{
	HargaBensin = Random(100,200);
	
	StockMaterial += 10000;
	StockCrack += 2500;
}

task SmuglerOn[1000]()
{
	new
		detik,
		menit
	;	
	detik ++;
	if(detik == 60)
	{
	    detik = 0, menit ++;
	    if(menit == 60)
	    {
	        menit = 0;
			foreach(new i : Player) if(pData[i][pJob] == 11)
			{
				if(pData[i][pDelayNotifSmuggle] < 1)
				{
					pData[i][pJobsSmuggleOn] = 1;
					SendClientMessageEx(i, COLOR_ARWIN, "JOB: "WHITE_E"Smuggling job is currently active!, use "YELLOW_E"'/findpacket' "WHITE_E"to trace the package");
					pData[i][pDelayNotifSmuggle] = 600;
				}
			}
		}
	}		
}

task OnlineTimer[1000]()
{
	//Date and Time Textdraw
	new hours,
	minutes,
	days,
	months,
	years;
	getdate(years, months, days);
 	gettime(hours, minutes);

	// Increase server uptime
	up_seconds ++;
	if(up_seconds == 60)
	{
	    up_seconds = 0, up_minutes ++;
	    if(up_minutes == 60)
	    {
	        up_minutes = 0, up_hours ++;
	        if(up_hours == 24) up_hours = 0, up_days ++;
			new tstr[128], rand = RandomEx(0, 20);
			format(tstr, sizeof(tstr), "UPTIME: "WHITE_E"The server has been online for %s.", Uptime());
			SendClientMessageToAll(COLOR_ARWIN, tstr);
			if(hours > 18)
			{
				SetWorldTime(0);
				WorldTime = 0;
			}
			else
			{
				SetWorldTime(hours);
				WorldTime = hours;
			}
			SetWeather(rand);
			WorldWeather = rand;
			//Sapd Vehicle Respawn
			for(new x;x<MAX_SAPD_VEHICLES; x++)
			{
				if(IsVehicleEmpty(LSPDVehicles[x]))
				{
					SetVehicleToRespawn(LSPDVehicles[x]);
					SetValidVehicleHealth(LSPDVehicles[x], 2000);
					SetVehicleFuel(LSPDVehicles[x], 1000);
					SwitchVehicleDoors(LSPDVehicles[x], false);
				}
			}
			//Samd Vehicle Respawn
			for(new x;x<MAX_SAMD_VEHICLES; x++)
			{
				if(IsVehicleEmpty(SAMDVehicles[x]))
				{
					SetVehicleToRespawn(SAMDVehicles[x]);
					SetValidVehicleHealth(SAMDVehicles[x], 2000);
					SetVehicleFuel(SAMDVehicles[x], 1000);
					SwitchVehicleDoors(SAMDVehicles[x], false);
				}
			}
			//Sana Vehicle Respawn
			for(new x;x<MAX_SANA_VEHICLES; x++)
			{
				if(IsVehicleEmpty(SANAVehicles[x]))
				{
					SetVehicleToRespawn(SANAVehicles[x]);
					SetValidVehicleHealth(SANAVehicles[x], 2000);
					SetVehicleFuel(SANAVehicles[x], 1000);
					SwitchVehicleDoors(SANAVehicles[x], false);
				}
			}
			//Jobs Vehicle Respawn
			for(new x;x<MAX_SWEEPER_VEHICLES; x++)
			{
				if(IsVehicleEmpty(SweepVeh[x]))
				{
					SetVehicleToRespawn(SweepVeh[x]);
					SetValidVehicleHealth(SweepVeh[x], 2000);
					SetVehicleFuel(SweepVeh[x], 1000);
					SwitchVehicleDoors(SweepVeh[x], false);
				}
			}
			for(new xx;xx<MAX_BUS_VEHICLES;xx++)
			{
				if(IsVehicleEmpty(BusABVeh[xx]))
				{
					SetVehicleToRespawn(BusABVeh[xx]);
					SetValidVehicleHealth(BusABVeh[xx], 2000);
					SetVehicleFuel(BusABVeh[xx], 1000);
					SwitchVehicleDoors(BusABVeh[xx], false);
				}
				if(IsVehicleEmpty(BusCDVeh[xx]))
				{
					SetVehicleToRespawn(BusCDVeh[xx]);
					SetValidVehicleHealth(BusCDVeh[xx], 2000);
					SetVehicleFuel(BusCDVeh[xx], 1000);
					SwitchVehicleDoors(BusCDVeh[xx], false);
				}
			}
			for(new xx;xx<MAX_TRASH_VEHICLES;xx++)
			{
				if(IsVehicleEmpty(TrashVeh[xx]))
				{
					SetVehicleToRespawn(TrashVeh[xx]);
					SetValidVehicleHealth(TrashVeh[xx], 2000);
					SetVehicleFuel(TrashVeh[xx], 1000);
					SwitchVehicleDoors(TrashVeh[xx], false);
				}
				if(IsVehicleEmpty(TrashVeh[xx]))
				{
					SetVehicleToRespawn(TrashVeh[xx]);
					SetValidVehicleHealth(TrashVeh[xx], 2000);
					SetVehicleFuel(TrashVeh[xx], 1000);
					SwitchVehicleDoors(TrashVeh[xx], false);
				}
			}
			for(new xx;xx<MAX_FORKLIFT_VEHICLES; xx++)
			{
				if(IsVehicleEmpty(ForkliftVeh[xx]))
				{
					SetVehicleToRespawn(ForkliftVeh[xx]);
					SetValidVehicleHealth(ForkliftVeh[xx], 2000);
					SetVehicleFuel(ForkliftVeh[xx], 1000);
					SwitchVehicleDoors(ForkliftVeh[xx], false);
				}
			}
			// Sync Server
			mysql_tquery(g_SQL, "OPTIMIZE TABLE `bisnis`,`houses`,`toys`,`vehicle`");
		}
	}	
	return 1;
}

ptask Player_ArrestTimer[1000](playerid)
{
	if(!pData[playerid][IsLoggedIn]) return 0;
	//Arreset Player
	if(pData[playerid][pArrest] > 0)
	{
		if(pData[playerid][pArrestTime] > 0)
		{
			pData[playerid][pArrestTime]--;
			new mstr[128];
			format(mstr, sizeof(mstr), "~b~~h~You will be released in ~w~%d ~b~~h~seconds.", pData[playerid][pArrestTime]);
			InfoTD_MSG(playerid, 1000, mstr);
		}
		else
		{
			pData[playerid][pArrest] = 0;
			pData[playerid][pArrestTime] = 0;
			SetPlayerPositionEx(playerid, 1526.69, -1678.05, 5.89, 267.76, 2000);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			Info(playerid, "You have been auto release. (times up)");
		}
	}
	return 1;
}

ptask PlayerEnterToll[1000](playerid)
{		
	if(IsPlayerInRangeOfPoint(playerid, 2.8, 44.9685,-1537.8425,4.7510)) // toll flint
	{
		GameTextForPlayer(playerid, "~p~TOLL GATE~n~~w~USE ~R~/PAYTOLL~w~ OR PRESS~n~~r~H~n~~w~TO PAY TOLL FEE", 3000, 4);
	}
	if(IsPlayerInRangeOfPoint(playerid, 2.8, 63.6337,-1526.3768,4.4771)) // toll flint
	{
		GameTextForPlayer(playerid, "~p~TOLL GATE~n~~w~USE ~R~/PAYTOLL~w~ OR PRESS~n~~r~H~n~~w~TO PAY TOLL FEE", 3000, 4);
	}
	if(IsPlayerInRangeOfPoint(playerid, 2.8, 600.4211,363.5247,18.4975)) // tol red county
	{
		GameTextForPlayer(playerid, "~p~TOLL GATE~n~~w~USE ~R~/PAYTOLL~w~ OR PRESS~n~~r~H~n~~w~TO PAY TOLL FEE", 3000, 4);
	}
	if(IsPlayerInRangeOfPoint(playerid, 2.8, 587.2990,372.2814,18.4975)) // tol red county
	{
		GameTextForPlayer(playerid, "~p~TOLL GATE~n~~w~USE ~R~/PAYTOLL~w~ OR PRESS~n~~r~H~n~~w~TO PAY TOLL FEE", 3000, 4);
	}
	if(IsPlayerInRangeOfPoint(playerid, 2.8, 630.5258,-1192.0107,18.1900)) // tol Deket News
	{
		GameTextForPlayer(playerid, "~p~TOLL GATE~n~~w~USE ~R~/PAYTOLL~w~ OR PRESS~n~~r~H~n~~w~TO PAY TOLL FEE", 3000, 4);
	}
	if(IsPlayerInRangeOfPoint(playerid, 2.8, 37.2685,-1328.6715,10.6704)) // tol Deket News
	{
		GameTextForPlayer(playerid, "~p~TOLL GATE~n~~w~USE ~R~/PAYTOLL~w~ OR PRESS~n~~r~H~n~~w~TO PAY TOLL FEE", 3000, 4);
	}
	if(IsPlayerInRangeOfPoint(playerid, 2.8, -184.7826,290.6765,12.0781)) // tol Deket Farm
	{
		GameTextForPlayer(playerid, "~p~TOLL GATE~n~~w~USE ~R~/PAYTOLL~w~ OR PRESS~n~~r~H~n~~w~TO PAY TOLL FEE", 3000, 4);
	}
	if(IsPlayerInRangeOfPoint(playerid, 2.8, -186.0296,311.2046,12.0781)) // tol Deket Farm
	{
		GameTextForPlayer(playerid, "~p~TOLL GATE~n~~w~USE ~R~/PAYTOLL~w~ OR PRESS~n~~r~H~n~~w~TO PAY TOLL FEE", 3000, 4);
	}
	return 1;
}

ptask Vehicle_AntiCheat[1000](playerid)
{
	if(IsPlayerInAnyVehicle(playerid)) 
	{
		for(new v, j = GetVehiclePoolSize(); v <= j; v++) if(GetVehicleModel(v))
		{
			new Float:health;
			GetVehicleHealth(v, health);
			if((health > VehicleHealthSecurityData[v]) && VehicleHealthSecurity[v] == false)
			{
				if(GetPlayerVehicleID(playerid) == v)
				{
					new playerState = GetPlayerState(playerid);
					if(playerState == PLAYER_STATE_DRIVER)
					{
						SetValidVehicleHealth(v, VehicleHealthSecurityData[v]);
						SendClientMessageToAllEx(TOMATO, "BotCmd: "GREY2_E"%s telah ditendang secara otomatis [health vehicle hack]!", pData[playerid][pName]);
						KickEx(playerid);
					}
				}
			}
			if(VehicleHealthSecurity[v] == true)
			{
				VehicleHealthSecurity[v] = false;
			}
			VehicleHealthSecurityData[v] = health;
		}
	}
	return 1;
}

ptask PlayerFarm_Cheker[1000](playerid)
{
	new pid = GetClosestPlant(playerid);
	if(pid != -1)
	{
		if(IsPlayerInDynamicCP(playerid, PlantData[pid][PlantCP]) && pid != -1)
		{
			new type[24], mstr[128];
			if(PlantData[pid][PlantType] == 1)
			{
				type = "Wheat";
			}
			else if(PlantData[pid][PlantType] == 2)
			{
				type = "Onion";
			}
			else if(PlantData[pid][PlantType] == 3)
			{
				type = "Carrot";
			}
			else if(PlantData[pid][PlantType] == 4)
			{
				type = "Potato";
			}
			else if(PlantData[pid][PlantType] == 5)
			{
				type = "Corn";
			}
			if(PlantData[pid][PlantTime] > 1)
			{
				format(mstr, sizeof(mstr), "~y~Plant Type: ~w~%s ~n~~y~Plant Time: ~r~%d minutes", type, PlantData[pid][PlantTime]/10);
				GameTextForPlayer(playerid, mstr, 1000, 6);
			}
			else
			{
				format(mstr, sizeof(mstr), "~y~Plant Type: ~w~%s ~n~~y~Plant Time: ~g~Now", type);
				GameTextForPlayer(playerid, mstr, 1000, 6);
			}
		}
	}
	//Farmer
	if(pData[playerid][pPlant] >= 20)
	{
		pData[playerid][pPlant] = 0;
		pData[playerid][pPlantTime] = 600;
	}
	if(pData[playerid][pPlantTime] > 0)
	{
		pData[playerid][pPlantTime]--;
		if(pData[playerid][pPlantTime] < 1)
		{
			pData[playerid][pPlantTime] = 0;
			pData[playerid][pPlant] = 0;
		}
	}
	return 1;
}

ptask PlayerHideIDCard[1000](playerid)
{
	if(pData[playerid][pDelayShowIDCard] > 0)
	{
		pData[playerid][pDelayShowIDCard]--;
		if(pData[playerid][pDelayShowIDCard] < 1)
		{
			for(new tdid = 0; tdid < 10; tdid++) 
			{
				TextDrawHideForPlayer(playerid, TDIDCard[tdid]);
				TextDrawHideForPlayer(playerid, TDIDCardName);
				TextDrawHideForPlayer(playerid, TDIDCardRegisterNo);
				TextDrawHideForPlayer(playerid, TDIDCardBirddate);
				TextDrawHideForPlayer(playerid, TDIDCardGender);
				TextDrawHideForPlayer(playerid, TDIDCardOrigin);
			}
		}
	}
}

ptask CharData_Update[1000](playerid)
{
	if(pData[playerid][IsLoggedIn] == true /*&& cAFK[playerid] == 0*/)
	{
		//pData[playerid][pPaycheck] --;
		pData[playerid][pSeconds] ++, pData[playerid][pCurrSeconds] ++;
		if(pData[playerid][pOnDuty] >= 1)
		{
			pData[playerid][pOnDutyTime]++;
		}
		if(pData[playerid][pTaxiDuty] >= 1)
		{
			pData[playerid][pTaxiTime]++;
		}
		if(pData[playerid][pSeconds] == 60)
		{
	    	pData[playerid][pMinutes]++, pData[playerid][pCurrMinutes] ++;
	    	pData[playerid][pSeconds] = 0, pData[playerid][pCurrSeconds] = 0;
			
			new scoremath = ((pData[playerid][pLevel])*8);
			
			switch(pData[playerid][pMinutes])
			{
				case 60:
				{
					pData[playerid][pHours] ++;
					pData[playerid][pLevelUp] ++;
					pData[playerid][pMinutes] = 0;
					UpdatePlayerData(playerid);
					if(pData[playerid][pLevelUp] >= scoremath)
					{
						new mstr[128];
						pData[playerid][pLevelUp]= 0;
						pData[playerid][pLevel] ++;
						SetPlayerScore(playerid, pData[playerid][pLevel]);
						format(mstr,sizeof(mstr),"~g~New level unlocked~n~~w~Now you're level ~r~%d", pData[playerid][pLevel]);
						GameTextForPlayer(playerid, mstr, 6000, 1);
					}
				}
			}
			if(pData[playerid][pCurrMinutes] == 60)
			{
			    pData[playerid][pCurrMinutes] = 0;
			    pData[playerid][pCurrHours] ++;
			}
		}
	}
	return 1;
}

ptask PlayerData_Minus[1000](playerid)
{	
	if(pData[playerid][pVip] > 0)
	{
		if(pData[playerid][pVipTime] != 0 && pData[playerid][pVipTime] <= gettime())
		{
			SendClientMessageEx(playerid, COLOR_ARWIN, "VIP: "WHITE_E"Maaf, Level VIP player anda sudah habis! sekarang anda adalah player biasa!");
			pData[playerid][pVip] = 0;
			pData[playerid][pVipTime] = 0;
		}
	}
	if(pData[playerid][pExitJob] != 0 && pData[playerid][pExitJob] <= gettime())
	{
		SendClientMessageEx(playerid, COLOR_ARWIN, "JOB: "WHITE_E"Now you can exit from your current job!");
		pData[playerid][pExitJob] = 0;
	}
	if(pData[playerid][pDriveLic] > 0)
	{
		if(pData[playerid][pDriveLicTime] != 0 && pData[playerid][pDriveLicTime] <= gettime())
		{
			SendClientMessageEx(playerid, COLOR_ARWIN, "LISENCE: "WHITE_E"The validity period of your vehicle license has expired!");
			pData[playerid][pDriveLic] = 2;
			pData[playerid][pDriveLicTime] = 0;
		}
	}
	if(pData[playerid][pTruckerLic] > 0)
	{
		if(pData[playerid][pTruckerLicTime] != 0 && pData[playerid][pTruckerLicTime] <= gettime())
		{
			SendClientMessageEx(playerid, COLOR_ARWIN, "LISENCE: "WHITE_E"The validity period of your trucker license has expired!");
			pData[playerid][pTruckerLic] = 2;
			pData[playerid][pTruckerLicTime] = 0;
		}
	}
	if(pData[playerid][pLumberLic] > 0)
	{
		if(pData[playerid][pLumberLicTime] != 0 && pData[playerid][pLumberLicTime] <= gettime())
		{
			SendClientMessageEx(playerid, COLOR_ARWIN, "LISENCE: "WHITE_E"The validity period of your lumberjack license has expired!");
			pData[playerid][pLumberLic] = 2;
			pData[playerid][pLumberLicTime] = 0;
		}
	}
	if(pData[playerid][pGunLic] > 0)
	{
		if(pData[playerid][pGunLicTime] != 0 && pData[playerid][pGunLicTime] <= gettime())
		{
			SendClientMessageEx(playerid, COLOR_ARWIN, "LISENCE: "WHITE_E"The validity period of your weapon license has expired!");
			pData[playerid][pGunLic] = 2;
			pData[playerid][pGunLicTime] = 0;
		}
	}
	if(pData[playerid][pFlyLic] > 0)
	{
		if(pData[playerid][pFlyLicTime] != 0 && pData[playerid][pFlyLicTime] <= gettime())
		{
			SendClientMessageEx(playerid, COLOR_ARWIN, "LISENCE: "WHITE_E"The validity period of your flying license has expired!");
			pData[playerid][pFlyLic] = 2;
			pData[playerid][pFlyLicTime] = 0;
		}
	}
	if(pData[playerid][pBoatLic] > 0)
	{
		if(pData[playerid][pBoatLicTime] != 0 && pData[playerid][pBoatLicTime] <= gettime())
		{
			SendClientMessageEx(playerid, COLOR_ARWIN, "LISENCE: "WHITE_E"The validity period of your boating license has expired!");
			pData[playerid][pBoatLic] = 2;
			pData[playerid][pBoatLicTime] = 0;
		}
	}
	//Player JobTime Delay
	if(pData[playerid][pPaycheck] > 0)
	{
		pData[playerid][pPaycheck]--;
        if(pData[playerid][pPaycheck] <= 1)
        {
            SendClientMessageEx(playerid,COLOR_YELLOW,"PAYCHECK: "WHITE_E"Pergilah ke bank lalu /signcheck untuk mendapat kan paycheck anda.");
            pData[playerid][pPaycheck] = 0;
        }						
	}
	if(pData[playerid][pJobTime] > 0)
	{
		pData[playerid][pJobTime]--;
        if(pData[playerid][pJobTime] <= 1)
        {
            SendClientMessage(playerid, COLOR_ARWIN, "JOB: "WHITE_E"Sekarang, anda sudah bisa bekerja "YELLOW_E"Job "WHITE_E"kembali!");
            pData[playerid][pJobTime] = 0;
        }			
	}
	if(pData[playerid][pSideJobTime] > 0)
	{
		pData[playerid][pSideJobTime]--;
        if(pData[playerid][pSideJobTime] <= 1)
        {
            SendClientMessage(playerid, COLOR_ARWIN, "JOB: "WHITE_E"Sekarang, anda sudah bisa bekerja "YELLOW_E"SideJob "WHITE_E"kembali!");
            pData[playerid][pSideJobTime] = 0;
        }				
	}
	if(pData[playerid][pSideJobTimeBus] > 0)
	{
		pData[playerid][pSideJobTimeBus]--;
        if(pData[playerid][pSideJobTimeBus] <= 1)
        {
            SendClientMessage(playerid, COLOR_ARWIN, "JOB: "WHITE_E"Sekarang, anda sudah bisa bekerja SideJob "YELLOW_E"Bus "WHITE_E"kembali!");
            pData[playerid][pSideJobTimeBus] = 0;
        }						
	}
	if(pData[playerid][pSideJobTimeSweap] > 0)
	{
		pData[playerid][pSideJobTimeSweap]--;
        if(pData[playerid][pSideJobTimeSweap] <= 1)
        {
            SendClientMessage(playerid, COLOR_ARWIN, "JOB: "WHITE_E"Sekarang, anda sudah bisa bekerja SideJob "YELLOW_E"Sweeper "WHITE_E"kembali!");
            pData[playerid][pSideJobTimeSweap] = 0;
        }					
	}
	if(pData[playerid][pDelayClaimInsu] > 0)
	{
		pData[playerid][pDelayClaimInsu]--;
	}
	if(pData[playerid][pTollDelays] > 0)
	{
		pData[playerid][pTollDelays]--;
	}
	if(pData[playerid][pDelayCrate] > 0)
	{
		pData[playerid][pDelayCrate]--;
	}
	if(pData[playerid][pTaxiCall] > 0)
	{
		pData[playerid][pTaxiCall]--;
	}
	if(pData[playerid][pMechaCall] > 0)
	{
		pData[playerid][pMechaCall]--;
	}
	if(pData[playerid][pHaulingTime] > 0)
	{
		pData[playerid][pHaulingTime]--;
        if(pData[playerid][pHaulingTime] <= 1)
        {
            SendClientMessageEx(playerid ,COLOR_ARWIN,"JOB: {FFFFFF}Sekarang anda bisa melakukan "YELLOW_E"Trucking Mission "WHITE_E"kembali.");
            pData[playerid][pHaulingTime] = 0;
        }				
	}
	if(pData[playerid][pSideJobsTrash] > 0)
	{
		pData[playerid][pSideJobsTrash]--;
        if(pData[playerid][pSideJobsTrash] <= 1)
        {
            SendClientMessage(playerid, COLOR_ARWIN, "JOB: "WHITE_E"Sekarang, anda sudah bisa bekerja SideJob "YELLOW_E"TrashMaster "WHITE_E"kembali!");
            pData[playerid][pSideJobsTrash] = 0;
        }				
	}
	if(pData[playerid][pSideJobsForklift] > 0)
	{
		pData[playerid][pSideJobsForklift]--;
        if(pData[playerid][pSideJobsForklift] <= 1)
        {
            SendClientMessage(playerid, COLOR_ARWIN, "JOB: "WHITE_E"Sekarang, anda sudah bisa bekerja SideJob "YELLOW_E"Forklift "WHITE_E"kembali!");
            pData[playerid][pSideJobsForklift] = 0;
        }				
	}
	if(pData[playerid][pPizzaTime] > 0)
	{
		pData[playerid][pPizzaTime]--;
        if(pData[playerid][pPizzaTime] <= 1)
        {
            SendClientMessage(playerid, COLOR_ARWIN, "JOB: "WHITE_E"Sekarang, anda sudah bisa bekerja SideJob "YELLOW_E"Pizza "WHITE_E"kembali!");
            pData[playerid][pPizzaTime] = 0;
        }				
	}
	if(pData[playerid][pJobSmugglerTime] > 0)
	{
		pData[playerid][pJobSmugglerTime]--;
        if(pData[playerid][pJobSmugglerTime] <= 1)
        {
            SendClientMessage(playerid, COLOR_ARWIN, "JOB: "WHITE_E"Sekarang, anda sudah bisa bekerja "YELLOW_E"Smuggler "WHITE_E"kembali!");
            pData[playerid][pJobSmugglerTime] = 0;
        }	
	}
	//Player JobTime Delay
	if(pData[playerid][pDelayTruckerDeli] > 0)
	{
		pData[playerid][pDelayTruckerDeli]--;
        if(pData[playerid][pDelayTruckerDeli] <= 1)
        {
            SendClientMessage(playerid, COLOR_ARWIN, "JOB: "WHITE_E"Sekarang, anda sudah bisa bekerja "YELLOW_E"truck crate "WHITE_E"kembali!");
            pData[playerid][pDelayTruckerDeli] = 0;
        }			
	}
	//Player JobTime Delay
	if(pData[playerid][pDelayFishing] > 0)
	{
		pData[playerid][pDelayFishing]--;
        if(pData[playerid][pDelayFishing] <= 1)
        {
            SendClientMessage(playerid, COLOR_ARWIN, "JOB: "WHITE_E"Sekarang, anda sudah bisa bekerja "YELLOW_E"Fishing "WHITE_E"kembali!");
            pData[playerid][pDelayFishing] = 0;
        }			
	}
	//Player Ads Delay
	if(pData[playerid][pAdsTime] > 0)
	{
		pData[playerid][pAdsTime]--;
        if(pData[playerid][pAdsTime] <= 1)
        {
            SendClientMessage(playerid, COLOR_ARWIN, "ADS: "WHITE_E"Sekarang, anda sudah bisa memasang iklan kembali");
            pData[playerid][pAdsTime] = 0;
        }			
	}
	if(pData[playerid][pDelayNotifSmuggle] > 0)
	{
		pData[playerid][pDelayNotifSmuggle]--;
        if(pData[playerid][pDelayNotifSmuggle] <= 1)
        {
            pData[playerid][pDelayNotifSmuggle] = 0;
        }				
	}
	if(pData[playerid][pMuteWt] > 0)
	{
		pData[playerid][pMuteWt]--;
        if(pData[playerid][pMuteWt] <= 1)
        {
            pData[playerid][pMuteWt] = 0;
        }				
	}
	return 1;
}

ptask AntiCheat_Checker[1000](playerid)
{	
	if(pData[playerid][IsLoggedIn])
	{
		if(GetPlayerMoney(playerid) > pData[playerid][pMoney])
		{
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid, pData[playerid][pMoney]);
		}
		new vehid = GetPlayerVehicleID(playerid);
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && GetPVarInt(playerid, "CarID") != vehid && TempCarID[playerid] != vehid)
		{
			SendAdminMessage(COLOR_RED, "%s[%d] detected using car troll cheat", pData[playerid][pName], playerid);
			SendClientMessageEx(playerid, COLOR_ARWIN, "AdmCmd: %s was autokicked by BotCmd, reason: car troll", pData[playerid][pName]);
			KickEx(playerid);
		}
		new surfingvehicle = GetPlayerSurfingVehicleID(playerid);
		new Float:svx, Float:svy, Float:svz, Float:npx, Float:npy, Float:npz;
		GetVehiclePos(surfingvehicle, svx, svy, svz);
		GetPlayerPos(playerid, npx, npy, npz);
		new Float:surfing = (svy + svx + svz) - (npx + npy + npz);
		if((surfingvehicle != 65535) && (surfing  < -30 || surfing > 30))
		{
		SendAdminMessage(COLOR_RED, "%s[%d] detected using surfing invisible cheat", pData[playerid][pName], playerid);
		SendClientMessageEx(playerid, COLOR_ARWIN, "AdmCmd: %s was autokicked by BotCmd, reason: surfing invisible", pData[playerid][pName]);
		KickEx(playerid);
		}
		new SurfingObject = GetPlayerSurfingObjectID(playerid);
		new Float:XObject, Float:YObject, Float:ZObject;
		GetObjectPos(SurfingObject, XObject, YObject, ZObject);
		new Float:surfing2 = (XObject + YObject + ZObject) - (npx + npy + npz);
		if((SurfingObject != 65535) && (surfing2  < -30 || surfing2 > 30))
		{
			SendAdminMessage(COLOR_RED, "%s[%d] detected using surfing invisible cheat", pData[playerid][pName], playerid);
			SendClientMessageEx(playerid, COLOR_ARWIN, "AdmCmd: %s was autokicked by BotCmd, reason: surfing invisible", pData[playerid][pName]);
			KickEx(playerid);
		}
		if (GetPlayerAnimationIndex(playerid) == 44 && PlayerSpeed(playerid) >= 5)
		{
			SendAdminMessage(COLOR_RED, "%s[%d] detected using fly hack cheat", pData[playerid][pName], playerid);
			SendClientMessageEx(playerid, COLOR_ARWIN, "AdmCmd: %s was autokicked by BotCmd, reason: fly hack", pData[playerid][pName]);
			KickEx(playerid);
		}
		AnticheatCheck(playerid);
	}	
	return 1;
}

ptask PlayerHospital_Update[1000](playerid)
{
	if(!pData[playerid][IsLoggedIn]) return 0;
	if(pData[playerid][pInjured] == 1 && pData[playerid][pHospital] != 1)
    {	
    	TogglePlayerControllable(playerid, 0);
		
		if(GetPVarInt(playerid, "GiveUptime") == -1)
		{
			SetPVarInt(playerid, "GiveUptime", gettime());
		}
		
		if(GetPVarInt(playerid,"GiveUptime"))
        {
            if((gettime()-GetPVarInt(playerid, "GiveUptime")) > 100)
            {
                SamdInfo(playerid, "Now you can spawn, type "YELLOW_E"'/death' "WHITE_E"for spawn to hospital.");
                SetPVarInt(playerid, "GiveUptime", 0);
            }
        }
        ApplyAnimation(playerid, "PED","FLOOR_hit_f", 4.1, 0, 1, 1, 1, 1, 1);
        SetPlayerHealthEx(playerid, 99999);
    }
	return 1;
}

ptask CharacterStats_Update[1000](playerid)
{
	if(!pData[playerid][IsLoggedIn]) return 0;
	if(pData[playerid][pInjured] == 0 && pData[playerid][pGender] != 0 && pData[playerid][pAdminDuty] == 0 && pData[playerid][pJail] == 0) //Pengurangan Data
	{
		if(++ pData[playerid][pHungerTime] >= 150)
        {
            if(pData[playerid][pHunger] > 0)
            {
                pData[playerid][pHunger]--;
            }
            else if(pData[playerid][pHunger] <= 0)
            {
          		pData[playerid][pSick] = 1;
            }
            pData[playerid][pHungerTime] = 0;
        }
        if(++ pData[playerid][pEnergyTime] >= 120)
        {
            if(pData[playerid][pEnergy] > 0)
            {
                pData[playerid][pEnergy]--;
            }
            else if(pData[playerid][pEnergy] <= 0)
            {
          		pData[playerid][pSick] = 1;
            }
            pData[playerid][pEnergyTime] = 0;
        }
		if(pData[playerid][pSick] == 1)
		{
			if(++ pData[playerid][pSickTime] >= 200)
			{
				if(pData[playerid][pSick] >= 1)
				{
					new Float:hp;
					GetPlayerHealth(playerid, hp);
					SetPlayerDrunkLevel(playerid, 8000);
					ApplyAnimation(playerid, "PED","FLOOR_hit_f", 4.1, 0, 1, 1, 1, 1, 1);
					SamdInfo(playerid, "Sepertinya anda sakit, segeralah pergi ke dokter.");
					SetPlayerHealth(playerid, hp - 3);
					pData[playerid][pSickTime] = 0;
				}
			}
		}
	}
	return 1;
}

ptask Player_JailTimer[1000](playerid)
{
	if(!pData[playerid][IsLoggedIn]) return 0;
	//Jail Player
	if(pData[playerid][pJail] > 0)
	{
		if(pData[playerid][pJailTime] > 0)
		{
			pData[playerid][pJailTime]--;
			new mstr[128];
			format(mstr, sizeof(mstr), "~b~~h~You will be unjail in ~w~%d ~b~~h~seconds.", pData[playerid][pJailTime]);
			InfoTD_MSG(playerid, 1000, mstr);
		}
		else
		{
			pData[playerid][pJail] = 0;
			pData[playerid][pJailTime] = 0;
			SetPlayerPositionEx(playerid, 1482.0356,-1724.5726,13.5469,750, 2000);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			Info(playerid, ""GREY2_E" %s(%d) have been un-jailed by the server. (times up)", pData[playerid][pName], playerid);
		}
	}
	if(pData[playerid][pJail] <= 0)
	{
		if(pData[playerid][pHunger] > 100)
		{
			pData[playerid][pHunger] = 100;
		}
		if(pData[playerid][pHunger] < 0)
		{
			pData[playerid][pHunger] = 0;
		}
		if(pData[playerid][pEnergy] > 100)
		{
			pData[playerid][pEnergy] = 100;
		}
		if(pData[playerid][pEnergy] < 0)
		{
			pData[playerid][pEnergy] = 0;
		}
	}
	return 1;
}

task VehicleUpdate[40000]()
{
	for (new i = 1; i != MAX_VEHICLES; i ++) if(IsEngineVehicle(i) && GetEngineStatus(i))
    {
        if(GetVehicleFuel(i) > 0)
        {
			new fuel = GetVehicleFuel(i);
            SetVehicleFuel(i, fuel - 2);

            if(GetVehicleFuel(i) >= 1 && GetVehicleFuel(i) <= 200)
            {
               SendClientMessageEx(GetVehicleDriver(i), COLOR_ARWIN,"VEHICLE: "WHITE_E"This vehicle is low on fuel. You must visit a fuel station!");
            }
        }
        if(GetVehicleFuel(i) <= 0)
        {
            SetVehicleFuel(i, 0);
            SwitchVehicleEngine(i, false);
        }
    }
	foreach(new ii : PVehicles)
	{
		if(IsValidVehicle(pvData[ii][cVeh]))
		{
			if(pvData[ii][cPlateTime] != 0 && pvData[ii][cPlateTime] <= gettime())
			{
				format(pvData[ii][cPlate], 32, "No Have");
				SetVehicleNumberPlate(pvData[ii][cVeh], pvData[ii][cPlate]);
				pvData[ii][cPlateTime] = 0;
			}
			if(pvData[ii][cRent] != 0 && pvData[ii][cRent] <= gettime())
			{
				foreach(new pid : Player) 
				{
					if (pvData[ii][cOwner] == pData[pid][pID])
					{
						pData[pid][pRents] = -1;
					}
				}
				pvData[ii][cRent] = 0;
				new query[128];
				mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehicle WHERE id = '%d'", pvData[ii][cID]);
				mysql_tquery(g_SQL, query);
				if(IsValidVehicle(pvData[ii][cVeh])) DestroyVehicle(pvData[ii][cVeh]);
				Iter_SafeRemove(PVehicles, ii, ii);
			}
			if(pvData[ii][cTicketTime] > 1 && pvData[ii][cTicket] > 1)
			{
				pvData[ii][cTicketTime]--;
				if(pvData[ii][cTicketTime] == 0)
				{
					pvData[ii][cImpound] = 1;
					new rand = RandomEx(111111, 999999);
					SetVehicleVirtualWorld(pvData[ii][cVeh], rand);
				}
			}
			if(pvData[ii][cTicketTime] > 1 && pvData[ii][cImpound] == 2)
			{
				pvData[ii][cTicketTime]--;
				if(pvData[ii][cTicketTime] == 0)
				{
					pvData[ii][cImpound] = 1;
					new rand = RandomEx(111111, 999999);
					SetVehicleVirtualWorld(pvData[ii][cVeh], rand);
				}
			}
		}
		if(pvData[ii][cClaimTime] != 0 && pvData[ii][cClaimTime] <= gettime())
		{
			pvData[ii][cClaimTime] = 0;
		}
	}
}

ptask PlayerVehicleUpdate[200](playerid)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(IsValidVehicle(vehicleid))
	{
		if(!GetEngineStatus(vehicleid) && IsEngineVehicle(vehicleid))
		{	
			SwitchVehicleEngine(vehicleid, false);
		}
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			new Float:fHealth;
			GetVehicleHealth(vehicleid, fHealth);
			if(IsValidVehicle(vehicleid) && fHealth <= 350.0)
			{
				SetValidVehicleHealth(vehicleid, 300.0);
				SwitchVehicleEngine(vehicleid, false);
				GameTextForPlayer(playerid, "~r~Totalled!", 2500, 3);
				if(IsABusABVeh(vehicleid))
				{
					for(new i = 0; i < 3; i++) 
					{
						if(DialogBus[i] == true) 
						{
							DialogBus[i] = false; // Jadi ga ada yang punya nih dialog
						}
					}
					KerjaBus[playerid] = 0;
					SetVehicleToRespawn(vehicleid);
				}
				if(IsABusCDVeh(vehicleid))
				{
					for(new i = 0; i < 3; i++) 
					{
						if(DialogBus[i] == true) 
						{
							DialogBus[i] = false; // Jadi ga ada yang punya nih dialog
						}
					}
					KerjaBus[playerid] = 0;
					SetVehicleToRespawn(vehicleid);
				}
				if(IsASweeperVeh(vehicleid))
				{
					for(new i = 0; i < 3; i++) 
					{
						if(DialogSweeper[i] == true) 
						{
							DialogSweeper[i] = false; // Jadi ga ada yang punya nih dialog
						}
					}
					KerjaSweeper[playerid] = 0;
					SetVehicleToRespawn(vehicleid);
				}
				if(IsAForkliftVeh(vehicleid))
				{
					SetVehicleToRespawn(vehicleid);
					DisablePlayerCheckpoint(playerid);
				}
			}
		}	
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			if(pData[playerid][pHBEMode] == 1)
			{
			    new Float:fDamage, fFuel;

				GetVehicleHealth(vehicleid, fDamage);

				if(fDamage <= 350.0) fDamage = 0.0;
				else if(fDamage > 1000.0) fDamage = 1000.0;

				fFuel = GetVehicleFuel(vehicleid);

				if(fFuel < 0) fFuel = 0;
				else if(fFuel > 1000) fFuel = 1000;

				/*if(fDamage < 600.0)
				{
					// Hijau
					PlayerTextDrawColor(playerid, SIMPLEDAMAGE[playerid], -2686721);
				}*/
				new str[10];
				if(!GetEngineStatus(vehicleid))
				{
               		PlayerTextDrawSetString(playerid, SIMPLEDAMAGE[playerid], "~r~OFF");
				}
				else
				{
					format(str, sizeof(str), "%.0f%", fDamage / 10);
               		PlayerTextDrawSetString(playerid, SIMPLEDAMAGE[playerid], str);
				}

				/*if(fFuel > 60)
				{
					// Hijau
					PlayerTextDrawColor(playerid, SIMPLEFUEL[playerid], 9109759);
				}
				else
				{
					// kuning
					PlayerTextDrawColor(playerid, SIMPLEFUEL[playerid], -2686721);
				}*/
				format(str, sizeof(str), "%d%", fFuel / 10);
               	PlayerTextDrawSetString(playerid, SIMPLEFUEL[playerid], str);

                format(str, sizeof(str), "%.0f", GetVehicleSpeed(vehicleid) / 2);
                PlayerTextDrawSetString(playerid, SIMPLESPEED[playerid], str);
			}
			else if(pData[playerid][pHBEMode] == 2)
			{
				new Float:fDamage, fFuel;
				new fuelstr[64], damagestr[62], speedstr[62], vehh[20], veh[20];

				GetVehicleHealth(vehicleid, fDamage);

				if(fDamage <= 350.0) fDamage = 0.0;
				else if(fDamage > 1000.0) fDamage = 1000.0;

				if(fDamage <= 600) vehh = "~r~";
				else if(fDamage <= 1000) vehh = "~g~";
				else if(fDamage <= 800) vehh = "~y~";

				fFuel = GetVehicleFuel(vehicleid);

				if(fFuel < 0) fFuel = 0;
				else if(fFuel > 1000) fFuel = 1000;

				if(fFuel <= 1000) veh = "~g~";
				else if(fFuel <= 700) veh = "~y~";
				else if(fFuel <= 450) veh = "~r~";

				format(speedstr, sizeof(speedstr), "%.0f", GetVehicleSpeed(vehicleid) / 2);
				PlayerTextDrawSetString(playerid, PlayerVehSpeed[playerid], speedstr);

				format(fuelstr, sizeof(fuelstr), "%s%d ~w~Fuel", veh, fFuel / 10);
				PlayerTextDrawSetString(playerid, PlayerVehFuel[playerid], fuelstr);

				format(damagestr, sizeof(damagestr), "%s%.0f ~w~Damage", veh, fDamage / 10);
				PlayerTextDrawSetString(playerid, PlayerVehDamage[playerid], damagestr);

			}
		}
	}
}

ptask PlayerTD_Update[1000](playerid)
{
	if(!pData[playerid][IsLoggedIn]) return 0;

	if(pData[playerid][pHBEMode] == 1)
	{
		new str[10];

		/*if(pData[playerid][pEnergy] < 60)
		{
			PlayerTextDrawColor(playerid, DIGIENERGY[playerid], -2686721);
		}
		else if(pData[playerid][pEnergy] > 60)
		{
			PlayerTextDrawColor(playerid, DIGIENERGY[playerid], 9109759);
		}

		if(pData[playerid][pHunger] < 60)
		{
			PlayerTextDrawColor(playerid, DIGIHUNGER[playerid], -2686721);
		}
		else if(pData[playerid][pHunger] > 60)
		{
			PlayerTextDrawColor(playerid, DIGIHUNGER[playerid], 9109759);
		}*/
		format(str,sizeof(str),"%i%", pData[playerid][pHunger]);
		PlayerTextDrawSetString(playerid, DIGIENERGY[playerid],str);str="";

		format(str,sizeof(str),"%i%", pData[playerid][pEnergy]);
		PlayerTextDrawSetString(playerid, DIGIHUNGER[playerid],str);str="";
	}

	if(pData[playerid][pHBEMode] == 2)
	{
		new Float:size[4], str[32];

		size[0] = pData[playerid][pHunger] * -17.0/100;
		size[1] = pData[playerid][pEnergy] * -17.0/100;
		size[2] = GetHealth(playerid) * 30.0/100;
		size[3] = GetArmor(playerid) * 30.0/100;

		PlayerTextDrawTextSize(playerid, BARTD[playerid][2], 20.0, size[0]);
		PlayerTextDrawTextSize(playerid, BARTD[playerid][3], 20.0, size[1]);
		PlayerTextDrawTextSize(playerid, BARTD[playerid][0], size[2], 17.0);
		PlayerTextDrawTextSize(playerid, BARTD[playerid][1], size[3], 17.0);
	    PlayerTextDrawColor(playerid, BARTD[playerid][1], COLOR_GREY);
	    PlayerTextDrawColor(playerid, BARTD[playerid][2], COLOR_YELLOW);
	    PlayerTextDrawColor(playerid, BARTD[playerid][3], COLOR_BLUE);
		PlayerTextDrawShow(playerid, BARTD[playerid][0]);
		PlayerTextDrawShow(playerid, BARTD[playerid][1]);
		PlayerTextDrawShow(playerid, BARTD[playerid][2]);
		PlayerTextDrawShow(playerid, BARTD[playerid][3]);

		format(str, sizeof(str), "%i", playerid);
		PlayerTextDrawSetString(playerid, BARTD[playerid][26], str);
	}

	return 1;
}

ptask PlayerData_WeaponAttach[1000](playerid)
{
	//Weapon Atth
	if(NetStats_GetConnectedTime(playerid) - WeaponTick[playerid] >= 250)
	{
		static weaponid, ammo, objectslot, count, index, tstr[123];
 
		for (new i; i < 13; i++)
		{
			GetPlayerWeaponData(playerid, i, weaponid, ammo);
			index = weaponid - 1;
		   
			if (weaponid && ammo && !WeaponSettings[playerid][index][Hidden] && IsWeaponWearable(weaponid) && EditingWeapon[playerid] != weaponid)
			{
				objectslot = GetWeaponObjectSlot(weaponid);
 
				if (GetPlayerWeapon(playerid) != weaponid)
				{
					SetPlayerAttachedObject(playerid, objectslot, GetWeaponModel(weaponid), WeaponSettings[playerid][index][Bone], WeaponSettings[playerid][index][Position][0], WeaponSettings[playerid][index][Position][1], WeaponSettings[playerid][index][Position][2], WeaponSettings[playerid][index][Position][3], WeaponSettings[playerid][index][Position][4], WeaponSettings[playerid][index][Position][5], 1.0, 1.0, 1.0);
					PlayerTextDrawHide(playerid, TogAmmo[playerid]);
				}
				else if(IsPlayerAttachedObjectSlotUsed(playerid, objectslot)) 
				{
					RemovePlayerAttachedObject(playerid, objectslot);
					format(tstr, sizeof(tstr), "%d", pData[playerid][pAmmo][GetWeaponSlot(weaponid)]);
					PlayerTextDrawSetString(playerid, TogAmmo[playerid], tstr);
					PlayerTextDrawShow(playerid, TogAmmo[playerid]);
				}
			}
		}
		for (new i = 4; i <= 8; i++) if (IsPlayerAttachedObjectSlotUsed(playerid, i))
		{
			count = 0;
 
			for (new j = 22; j <= 38; j++) if (PlayerHasWeapon(playerid, j) && GetWeaponObjectSlot(j) == i)
				count++;
 
			if(!count) RemovePlayerAttachedObject(playerid, i);
		}
		WeaponTick[playerid] = NetStats_GetConnectedTime(playerid);
	}
	//Weapon AC
	if(pData[playerid][pSpawned] == 1)
    {
		if(pData[playerid][pAdmin] < 1)
		{
			if(GetPlayerWeapon(playerid) != pData[playerid][pWeapon])
			{
				pData[playerid][pWeapon] = GetPlayerWeapon(playerid);
				
				if(pData[playerid][pWeapon] >= 1 && pData[playerid][pWeapon] <= 45 && pData[playerid][pWeapon] != 40 && pData[playerid][pWeapon] != 2 && pData[playerid][pGuns][g_aWeaponSlots[pData[playerid][pWeapon]]] != GetPlayerWeapon(playerid))
				{
					SendAdminMessage(COLOR_RED, "%s(%d) has possibly used weapon hacks (%s), Please to check /spec this player first!", pData[playerid][pName], playerid, ReturnWeaponName(pData[playerid][pWeapon]));
					SetWeapons(playerid); //Reload old weapons
				}
			}
		}
    }
	return 1;
}

ptask PlayerVehicleBoatFish[1000](playerid)
{
	if(IsPlayerInAnyVehicle(playerid) && IsABoat(GetPlayerVehicleID(playerid)))
    {
        for (new zone = 0; zone < FISH_ZONE; zone++) if(IsPlayerInDynamicArea(playerid, fishzone[zone])) {
            GameTextForPlayer(playerid, sprintf("~w~Boat signal~n~~r~~h~%s", zones_text[zone]), 1000, 4);
        }
    }
}

ptask PlayerData_WeaponCheck[1000](playerid)
{
	if(pData[playerid][pAdmin] == 0)
	{
		if(pData[playerid][pLevel] < 3)
		{
			if(GetPlayerWeapon(playerid) == 22 || GetPlayerWeapon(playerid) == 23 || GetPlayerWeapon(playerid) == 24 || GetPlayerWeapon(playerid) == 25 || GetPlayerWeapon(playerid) == 26 || GetPlayerWeapon(playerid) == 27 || GetPlayerWeapon(playerid) == 28 || GetPlayerWeapon(playerid) == 29 || GetPlayerWeapon(playerid) == 30
		    || GetPlayerWeapon(playerid) == 31 || GetPlayerWeapon(playerid) == 32 || GetPlayerWeapon(playerid) == 33 || GetPlayerWeapon(playerid) == 34 || GetPlayerWeapon(playerid) == 35 || GetPlayerWeapon(playerid) == 36)
			{
				KickEx(playerid);
			}
		}
	    if(GetPlayerWeapon(playerid) == 34)
		{
		    ResetPlayerWeaponsEx(playerid);
			new string[180];
			format(string,sizeof(string), "BotCmd: %s telah di banned dari server", pData[playerid][pName]);
	  		SendClientMessageToAllEx(TOMATO, "%s Reason: Weapon Hack", string);  
	  		format(pData[playerid][pBanBy], 128, "%s", "BOT");
			format(pData[playerid][pBanReason], 128, "%s", "WEAPON HACK");
			pData[playerid][pBanned] = 1;
			KickEx(playerid);
		}
	    if(GetPlayerWeapon(playerid) == 35)
		{
		    ResetPlayerWeaponsEx(playerid);
			new string[180];
			format(string,sizeof(string), "BotCmd: %s telah di banned dari server", pData[playerid][pName]);
	  		SendClientMessageToAllEx(TOMATO, "%s Reason: Weapon Hack", string);  
	  		format(pData[playerid][pBanBy], 128, "%s", "BOT");
			format(pData[playerid][pBanReason], 128, "%s", "WEAPON HACK");
			pData[playerid][pBanned] = 1;
			KickEx(playerid);
		}
		if(GetPlayerWeapon(playerid) == 36)
		{
		    ResetPlayerWeaponsEx(playerid);
			new string[180];
			format(string,sizeof(string), "BotCmd: %s telah di banned dari server", pData[playerid][pName]);
	  		SendClientMessageToAllEx(TOMATO, "%s Reason: Weapon Hack", string);  
	  		format(pData[playerid][pBanBy], 128, "%s", "BOT");
			format(pData[playerid][pBanReason], 128, "%s", "WEAPON HACK");
			pData[playerid][pBanned] = 1;
			KickEx(playerid);
		}
		if(GetPlayerWeapon(playerid) == 37)
		{
		    ResetPlayerWeaponsEx(playerid);
			new string[180];
			format(string,sizeof(string), "BotCmd: %s telah di banned dari server", pData[playerid][pName]);
	  		SendClientMessageToAllEx(TOMATO, "%s Reason: Weapon Hack", string);  
	  		format(pData[playerid][pBanBy], 128, "%s", "BOT");
			format(pData[playerid][pBanReason], 128, "%s", "WEAPON HACK");
			pData[playerid][pBanned] = 1;
			KickEx(playerid);
		}
        if(GetPlayerWeapon(playerid) == 38)
		{
		    ResetPlayerWeaponsEx(playerid);
			new string[180];
			format(string,sizeof(string), "BotCmd: %s telah di banned dari server", pData[playerid][pName]);
	  		SendClientMessageToAllEx(TOMATO, "%s Reason: Weapon Hack", string);  
	  		format(pData[playerid][pBanBy], 128, "%s", "BOT");
			format(pData[playerid][pBanReason], 128, "%s", "WEAPON HACK");
			pData[playerid][pBanned] = 1;
			KickEx(playerid);
		}
		if(GetPlayerWeapon(playerid) == 39)
		{
		    ResetPlayerWeaponsEx(playerid);
			new string[180];
			format(string,sizeof(string), "BotCmd: %s telah di banned dari server", pData[playerid][pName]);
	  		SendClientMessageToAllEx(TOMATO, "%s Reason: Weapon Hack", string);  
	  		format(pData[playerid][pBanBy], 128, "%s", "BOT");
			format(pData[playerid][pBanReason], 128, "%s", "WEAPON HACK");
			pData[playerid][pBanned] = 1;
			KickEx(playerid);
		}
		if(GetPlayerWeapon(playerid) == 40)
		{
		    ResetPlayerWeaponsEx(playerid);
			new string[180];
			format(string,sizeof(string), "BotCmd: %s telah di banned dari server", pData[playerid][pName]);
	  		SendClientMessageToAllEx(TOMATO, "%s Reason: Weapon Hack", string);  
	  		format(pData[playerid][pBanBy], 128, "%s", "BOT");
			format(pData[playerid][pBanReason], 128, "%s", "WEAPON HACK");
			pData[playerid][pBanned] = 1;
			KickEx(playerid);
		}
		if(GetPlayerWeapon(playerid) == 32)
		{
		    ResetPlayerWeaponsEx(playerid);
			new string[180];
			format(string,sizeof(string), "BotCmd: %s telah di banned dari server", pData[playerid][pName]);
	  		SendClientMessageToAllEx(TOMATO, "%s Reason: Weapon Hack", string);  
	  		format(pData[playerid][pBanBy], 128, "%s", "BOT");
			format(pData[playerid][pBanReason], 128, "%s", "WEAPON HACK");
			pData[playerid][pBanned] = 1;
			KickEx(playerid);
		}
	}
	return 1;
}

task ELMTimer[250]()
{
	//loop to process ELM.
	for(new v = 1, x = GetVehiclePoolSize(); v <= x; v++)
	{
		if(pvData[v][vELM])
		{
			new panels, doors, lights, tires, elm;
			GetVehicleDamageStatus(v, panels, doors, lights, tires);

			switch(pvData[v][vEmergencyLights])
			{
				case 1:
				{
					pvData[v][vEmergencyLights] = 0;
					elm = 1;
				}
				case 0:
				{
					elm = 2;
					pvData[v][vEmergencyLights] = 1;
				}
			}

			if(elm == 1) lights = encode_lights(0, 1, 0, 0);
			else if(elm == 2) lights = encode_lights(0, 0, 1, 0);

			UpdateVehicleDamageStatus(v, panels, doors, lights, tires);
		}
	}
}

ptask Player_BanUpdate[1000](playerid)
{
	if(pData[playerid][pWarn] >= 20)
	{
	    SendClientMessageToAllEx(TOMATO, "BotCmd: %s telah dibanned oleh BOT", pData[playerid][pName]);
		SendClientMessageToAllEx(TOMATO, "Reason: Max Point");
		format(pData[playerid][pBanBy], 128, "%s", "BOT");
		format(pData[playerid][pBanReason], 128, "%s", "20 WARNING POINT");
		pData[playerid][pBanned] = 1;
		KickEx(playerid);
	}
    if(pData[playerid][pBanned] > 0)
	{
		new String[512];
		format(String, sizeof(String), ""YELLOW_E"Your Character account is blocked\n{00FFFF}Character: %s\n{00FFFF}Reason: "WHITE_E"%s\n"YELLOW_E"Please create an unban appeal in our discrod "RED_E"Nusan"WHITE_E"tara "GREEN_E"Roleplay", pData[playerid][pName], pData[playerid][pBanReason]);
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Account Blocked", String," Ok","");
		KickEx(playerid);
	}
    return 1;
}

ptask MoneyUpCheck[1000](playerid)
{
	if(pData[playerid][IsLoggedIn] == true)
	{
		if(pData[playerid][pAdmin] < 1)
		{
			if(GetPlayerMoney(playerid) > 50000000)
			{
				ResetPlayerMoney(playerid);
				GivePlayerMoneyEx(playerid, 0);
			}
			if(pData[playerid][pBankMoney] > 100000000)
			{
				pData[playerid][pBankMoney] = 0;
			}
		}
	}	
	foreach(new hid : Houses)
	{
		if(hData[hid][hMoney] > 250000000)
		{
			hData[hid][hMoney] = 0;
			House_Save(hid);
		}
	}
	foreach(new bid : Bisnis)
	{
		if(bData[bid][bMoney] > 200000000)
		{
			bData[bid][bMoney] = 0;
			Bisnis_Save(bid);
		}
	}
}

// task AdsExperied[1000]()
// {
// 	for(new i=0;i<MAX_ADS;i++)
// 	{
// 		if(AdsData[i][BeingUsed] == 1)
// 		{
// 			if(AdsData[i][TimeToExpire] > 0)
// 			{
// 				AdsData[i][TimeToExpire]--;
// 				if(AdsData[i][TimeToExpire] == 0)
// 				{
// 					AdsData[i][BeingUsed] = 0;
// 					AdsData[i][adsFrom] = 999;
// 				}
// 			}
// 		}
// 	}	
// }

task TimeUpdate[1000]()
{
	new String[256],mtext[20],year,month,day,hours,minutes,seconds;
	getdate(year, month, day), gettime(hours, minutes, seconds);
	if(month == 1) { mtext = "Januari"; }
    else if(month == 2) { mtext = "Februari"; }
    else if(month == 3) { mtext = "Maret"; }
    else if(month == 4) { mtext = "April"; }
    else if(month == 5) { mtext = "Mei"; }
    else if(month == 6) { mtext = "Juni"; }
    else if(month == 7) { mtext = "Juli"; }
    else if(month == 8) { mtext = "Agustus"; }
    else if(month == 9) { mtext = "September"; }
    else if(month == 10) { mtext = "Oktober"; }
    else if(month == 11) { mtext = "November"; }
    else if(month == 12) { mtext = "Desember"; }
	format(String, sizeof String, "%s%d %s %s%d", ((day < 10) ? ("0") : ("")), day, mtext, (year < 10) ? ("0") : (""), year);
	TextDrawSetString(Date, String);
	format(String, sizeof String, "%s%d:%s%d:%s%d", (hours < 10) ? ("0") : (""), hours, (minutes < 10) ? ("0") : (""), minutes, (seconds < 10) ? ("0") : (""), seconds);
	TextDrawSetString(Time, String);
}

ptask UpdateTazerPlayer[1000](playerid)
{
	//SAPD Tazer/Taser
	UpdateTazer(playerid);
}

ptask UpdatePlayerInSpikePlayer[1000](playerid)
{
	//SAPD Road Spike
	CheckPlayerInSpike(playerid);
}

// ptask MechanicUpdate[1000](playerid)
// {
// 	if(!IsPlayerInRangeOfPoint(playerid, 80.0, 2200.9639,-2215.5659,13.5547) || !IsPlayerInRangeOfPoint(playerid, 80.0, 2615.8027,-2473.2822,3.1963))
// 	{
// 		if(pData[playerid][pMechDuty] == 1)
// 		{
// 			pData[playerid][pMechDuty] = 0;
// 			SetPlayerColor(playerid, COLOR_WHITE);
// 			Servers(playerid, "Anda telah off dari mech duty!");
// 		}	
// 	}
// }

ptask IsPlayerLoginAfk[1000](playerid)
{
	if(charData[playerid][cCharOn] == 1)
	{
		if(charData[playerid][cCharTime] > 0)
		{
			charData[playerid][cCharTime]--;
			if(charData[playerid][cCharTime] <= 1)
			{
				charData[playerid][cCharTime] = 0;
				Servers(playerid, "kamu telah dikick karena terlalu lama di menu login.");
				KickEx(playerid);
			}				
		}
	}
}
