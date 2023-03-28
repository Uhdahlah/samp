
CMD:buytruck(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, -77.1687,-1136.5388,1.0781)) return Error(playerid, "You have to be at the trucker point");
	if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
	{
		new mstr[212];
		format(mstr, sizeof(mstr), ""WHITE_E"%s\t\t"LG_E"$%s\n"WHITE_E"%s\t\t"LG_E"$%s\n"WHITE_E"%s\t\t"LG_E"$%s\n"WHITE_E"%s\t\t"LG_E"$%s\n"WHITE_E"%s\t\t"LG_E"$%s\n"WHITE_E"%s\t\t"LG_E"$%s", 
		GetVehicleModelName(403), FormatMoney(GetVehicleCost(403)),
		GetVehicleModelName(514), FormatMoney(GetVehicleCost(514)),
		GetVehicleModelName(515), FormatMoney(GetVehicleCost(515)),
		GetVehicleModelName(498), FormatMoney(GetVehicleCost(498)),
		GetVehicleModelName(499), FormatMoney(GetVehicleCost(499)),
		GetVehicleModelName(455), FormatMoney(GetVehicleCost(455)), 
		GetVehicleModelName(403), FormatMoney(GetVehicleCost(403)), 
		GetVehicleModelName(516), FormatMoney(GetVehicleCost(516)), 
		GetVehicleModelName(515), FormatMoney(GetVehicleCost(516))
		);
		ShowPlayerDialog(playerid, DIALOG_BUYTRUCK, DIALOG_STYLE_LIST, "Buy Truck", mstr, "Buy", "Cancel");
	}
	else return Error(playerid, "You are not trucker driver job.");
	return 1;
}

CMD:missions(playerid,params[])
{
	if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
	{
	    new S3MP4K[512], String[512];
	    if(pData[playerid][pHaulingTime] > 0) return Error(playerid, "Tidak bisa /hauling gunakan /time untuk mengecek");
	    if(pData[playerid][LevelTrucker] < 200) return Error(playerid, "Level Trucker Kamu Masih Rendah");
		if(pData[playerid][pTruckerLic] < 1) return Error(playerid, "You don't have a trucker license");
		if(SedangHauling[playerid] >= 1) return Error(playerid, "Kamu sedang dalam pengiriman.");
 		if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 403 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 514 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 515)
		{
			strcat(S3MP4K, "Order\tPrice\n");
			format(String, sizeof(String), "Ocean Dock Imports\t%s\n", (DialogHauling[0] == true) ? ("{FF0000}Taken") : ("{33AA33}$350.00"));
			strcat(S3MP4K, String);
			format(String, sizeof(String), "Ocean Dock Imports\t%s\n", (DialogHauling[1] == true) ? ("{FF0000}Taken") : ("{33AA33}$300.00"));
			strcat(S3MP4K, String);
			format(String, sizeof(String), "Angel Pine Exports\t%s\n", (DialogHauling[2] == true) ? ("{FF0000}Taken") : ("{33AA33}$250.00"));
			strcat(S3MP4K, String);
			format(String, sizeof(String), "Angel Pine Exports\t%s\n", (DialogHauling[3] == true) ? ("{FF0000}Taken") : ("{33AA33}$270.00"));
			strcat(S3MP4K, String);
			format(String, sizeof(String), "Chilliad Deport\t%s\n", (DialogHauling[4] == true) ? ("{FF0000}Taken") : ("{33AA33}$399.00"));
			strcat(S3MP4K, String);
			format(String, sizeof(String), "Chilliad Deport\t%s\n", (DialogHauling[5] == true) ? ("{FF0000}Taken") : ("{33AA33}$200.00"));
			strcat(S3MP4K, String);
			format(String, sizeof(String), "Easter Import\t%s\n", (DialogHauling[6] == true) ? ("{FF0000}Taken") : ("{33AA33}$310.00"));
			strcat(S3MP4K, String);
			format(String, sizeof(String), "Blueberry Export\t%s\n", (DialogHauling[7] == true) ? ("{FF0000}Taken") : ("{33AA33}$333.00"));
			strcat(S3MP4K, String);
			format(String, sizeof(String), "Las Venturas Deport\t%s\n", (DialogHauling[8] == true) ? ("{FF0000}Taken") : ("{33AA33}$290.00"));
			strcat(S3MP4K, String);
			format(String, sizeof(String), "Las Venturas Fuel & Gas\t%s", (DialogHauling[9] == true) ? ("{FF0000}Taken") : ("{33AA33}$255.00"));
			strcat(S3MP4K, String);
			ShowPlayerDialog(playerid, HAULING, DIALOG_STYLE_TABLIST_HEADERS, "Hauling Missions", S3MP4K, "Select", "Cancel");
		}
		else return Error(playerid, "You are not in the Truck.");
	}
	else return Error(playerid, "You are not a trucker.");
	return 1;
}
