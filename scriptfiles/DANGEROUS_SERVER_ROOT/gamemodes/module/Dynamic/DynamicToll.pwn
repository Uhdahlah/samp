
CMD:paytoll(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 8, 44.9685,-1537.8425,4.7510)) // toll flint
	{
		if(pData[playerid][pTollDelays] > 0)
			return Error(playerid, "waiting for the toll gate to close");
		if(IsPlayerInAnyVehicle(playerid))
		{
           	MoveDynamicObject(toll[0], 49.294261, -1534.956420, 4.966773+0.1, 0.15, -0.899999, 0.0, 83.000007);
			SetTimer("ptoll1", 4000, 0);
			if(pData[playerid][pPayToll] > 0)
			{
				pData[playerid][pPayToll] -= 1;
				SendClientMessage(playerid,COLOR_ARWIN,"TOLL: "WHITE_E"Used "YELLOW_E" 1 toll card point "WHITE_E"to pay toll access");
			}	
			else
			{
				GivePlayerMoneyEx(playerid, -50);
				SendClientMessage(playerid,COLOR_ARWIN,"TOLL: "WHITE_E"Kamu telah membayar Toll "GREEN_E"$0.50");
			}
			pData[playerid][pTollDelays] = 5;	
		}
	}
	if(IsPlayerInRangeOfPoint(playerid, 8, 63.6337,-1526.3768,4.4771)) // toll flint
	{
		if(pData[playerid][pTollDelays] > 0)
			return Error(playerid, "waiting for the toll gate to close");
		if(IsPlayerInAnyVehicle(playerid))
		{
           	MoveDynamicObject(toll[1], 59.574924, -1529.473144, 4.721392+0.1, 0.15, 6.299998, 0.0, -98.599975);
			SetTimer("ptoll2", 4000, 0);
			if(pData[playerid][pPayToll] > 0)
			{
				pData[playerid][pPayToll] -= 1;
				SendClientMessage(playerid,COLOR_ARWIN,"TOLL: "WHITE_E"Used "YELLOW_E" 1 toll card point "WHITE_E"to pay toll access");
			}	
			else
			{
				GivePlayerMoneyEx(playerid, -50);
				SendClientMessage(playerid,COLOR_ARWIN,"TOLL: "WHITE_E"Kamu telah membayar Toll "GREEN_E"$0.50");
			}
			pData[playerid][pTollDelays] = 5;	
		}
	}
	if(IsPlayerInRangeOfPoint(playerid, 8, 600.4211,363.5247,18.4975)) // tol red county
	{
		if(pData[playerid][pTollDelays] > 0)
			return Error(playerid, "waiting for the toll gate to close");
		if(IsPlayerInAnyVehicle(playerid))
		{
            MoveDynamicObject(toll[5], 596.178710, 364.422332, 18.904657, 0.15, 0.299999, 1.899957, 32.800006);
			SetTimer("ptoll3", 4000, 0);
			if(pData[playerid][pPayToll] > 0)
			{
				pData[playerid][pPayToll] -= 1;
				SendClientMessage(playerid,COLOR_ARWIN,"TOLL: "WHITE_E"Used "YELLOW_E" 1 toll card point "WHITE_E"to pay toll access");
			}	
			else
			{
				GivePlayerMoneyEx(playerid, -50);
				SendClientMessage(playerid,COLOR_ARWIN,"TOLL: "WHITE_E"Kamu telah membayar Toll "GREEN_E"$0.50");
			}	
			pData[playerid][pTollDelays] = 5;	
		}
	}
	if(IsPlayerInRangeOfPoint(playerid, 8, 587.2990,372.2814,18.4975)) // tol red county
	{
		if(pData[playerid][pTollDelays] > 0)
			return Error(playerid, "waiting for the toll gate to close");
		if(IsPlayerInAnyVehicle(playerid))
		{
           	MoveDynamicObject(toll[6], 591.796630, 370.739685, 18.858558, 0.15, 1.000000, -0.700053, 33.000011);
			SetTimer("ptoll4", 4000, 0);
			if(pData[playerid][pPayToll] > 0)
			{
				pData[playerid][pPayToll] -= 1;
				SendClientMessage(playerid,COLOR_ARWIN,"TOLL: "WHITE_E"Used "YELLOW_E" 1 toll card point "WHITE_E"to pay toll access");
			}	
			else
			{
				GivePlayerMoneyEx(playerid, -50);
				SendClientMessage(playerid,COLOR_ARWIN,"TOLL: "WHITE_E"Kamu telah membayar Toll "GREEN_E"$0.50");
			}	
			pData[playerid][pTollDelays] = 5;	
		}
	}
	if(IsPlayerInRangeOfPoint(playerid, 8, 630.5258,-1192.0107,18.1900)) // tol Deket News
	{
		if(pData[playerid][pTollDelays] > 0)
			return Error(playerid, "waiting for the toll gate to close");
		if(IsPlayerInAnyVehicle(playerid))
		{
           	MoveDynamicObject(toll[9], 624.003112, -1188.514526, 18.519626, 0.15, 0.000000, 3.100066, 25.899995);
			SetTimer("ptoll5", 4000, 0);
			if(pData[playerid][pPayToll] > 0)
			{
				pData[playerid][pPayToll] -= 1;
				SendClientMessage(playerid,COLOR_ARWIN,"TOLL: "WHITE_E"Used "YELLOW_E" 1 toll card point "WHITE_E"to pay toll access");
			}	
			else
			{
				GivePlayerMoneyEx(playerid, -50);
				SendClientMessage(playerid,COLOR_ARWIN,"TOLL: "WHITE_E"Kamu telah membayar Toll "GREEN_E"$0.50");
			}	
			pData[playerid][pTollDelays] = 5;	
		}
	}
	if(IsPlayerInRangeOfPoint(playerid, 8, 37.2685,-1328.6715,10.6704)) // tol Deket News
	{	
		if(pData[playerid][pTollDelays] > 0)
			return Error(playerid, "waiting for the toll gate to close");
		if(IsPlayerInAnyVehicle(playerid))
		{
           	MoveDynamicObject(toll[10], 43.380283, -1328.165893, 10.601994, 0.15, 0.000000, -2.699949, -54.000000);
			SetTimer("ptoll6", 4000, 0);
			if(pData[playerid][pPayToll] > 0)
			{
				pData[playerid][pPayToll] -= 1;
				SendClientMessage(playerid,COLOR_ARWIN,"TOLL: "WHITE_E"Used "YELLOW_E" 1 toll card point "WHITE_E"to pay toll access");
			}	
			else
			{
				GivePlayerMoneyEx(playerid, -50);
				SendClientMessage(playerid,COLOR_ARWIN,"TOLL: "WHITE_E"Kamu telah membayar Toll "GREEN_E"$0.50");
			}	
			pData[playerid][pTollDelays] = 5;	
		}
	}
	if(IsPlayerInRangeOfPoint(playerid, 8, -184.7826,290.6765,12.0781)) // tol Deket Farm
	{
		if(pData[playerid][pTollDelays] > 0)
			return Error(playerid, "waiting for the toll gate to close");
		if(IsPlayerInAnyVehicle(playerid))
		{
			MoveDynamicObject(toll[13], -180.354797, 294.130126, 12.175910, 0.15, 0.000000, 1.400011, -11.499999);
			SetTimer("ptoll7", 4000, 0);
			if(pData[playerid][pPayToll] > 0)
			{
				pData[playerid][pPayToll] -= 1;
				SendClientMessage(playerid,COLOR_ARWIN,"TOLL: "WHITE_E"Used "YELLOW_E" 1 toll card point "WHITE_E"to pay toll access");
			}	
			else
			{
				GivePlayerMoneyEx(playerid, -50);
				SendClientMessage(playerid,COLOR_ARWIN,"TOLL: "WHITE_E"Kamu telah membayar Toll "GREEN_E"$0.50");
			}	
			pData[playerid][pTollDelays] = 5;	
		}
	}
	if(IsPlayerInRangeOfPoint(playerid, 8, -186.0296,311.2046,12.0781)) // tol Deket Farm
	{	
		if(pData[playerid][pTollDelays] > 0)
			return Error(playerid, "waiting for the toll gate to close");
		if(IsPlayerInAnyVehicle(playerid))
		{
           	MoveDynamicObject(toll[14], -184.029785, 306.856628, 12.024078, 0.15, 0.000000, -1.899925, -14.900000);
			SetTimer("ptoll8", 4000, 0);
			if(pData[playerid][pPayToll] > 0)
			{
				pData[playerid][pPayToll] -= 1;
				SendClientMessage(playerid,COLOR_ARWIN,"TOLL: "WHITE_E"Used "YELLOW_E" 1 toll card point "WHITE_E"to pay toll access");
			}	
			else
			{
				GivePlayerMoneyEx(playerid, -50);
				SendClientMessage(playerid,COLOR_ARWIN,"TOLL: "WHITE_E"Kamu telah membayar Toll "GREEN_E"$0.50");
			}	
			pData[playerid][pTollDelays] = 5;	
		}
	}
	return 1;
}
