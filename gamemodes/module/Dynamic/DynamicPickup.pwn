#include <YSI\y_hooks>

hook OnGameModeInit()
{
	new strings[500];
	CreateDynamicPickup(1239, 23, 431.1708,2419.5818,356.2569, -1);
	format(strings, sizeof(strings), "{00FFFF}[City Hall]\n"YELLOW_E"/newage - "WHITE_E"Change Birthday\n"YELLOW_E"/sellhouse "WHITE_E"- sell your house\n"YELLOW_E"/givehouse "WHITE_E"- give your house\n"YELLOW_E"/sellbisnis "WHITE_E"- sell your bisnis\n"YELLOW_E"/taxhouse "WHITE_E"- to pay your house tax\n"YELLOW_E"/taxapart "WHITE_E"- to pay your apart tax");
	CreateDynamic3DTextLabel(strings, COLOR_ARWIN, 431.1708,2419.5818,356.2569, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // ID Card

	CreateDynamicPickup(1239, 23, 1657.9524,-1394.4664,13.5469, -1);
	format(strings, sizeof(strings), "{00FFFF}[Insurance]\n"YELLOW_E"/buyinsu "WHITE_E"- buy insurance\n"YELLOW_E"/claiminsu - "WHITE_E"claim insurance\n"YELLOW_E"/sellpv - "WHITE_E"sell vehicle");
	CreateDynamic3DTextLabel(strings, COLOR_ARWIN, 1657.9524,-1394.4664,13.5469, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Veh insurance
	
	//DMV
	CreateDynamicPickup(1239, 23, 1491.14, 1306.33, 1093.28, -1);
	format(strings, sizeof(strings), "{00FFFF}[Car License]\n"YELLOW_E"/taketest "WHITE_E"- cost $50.00\n"YELLOW_E"/renewlic - "WHITE_E"Cost $25.00 for renew licenses");
	CreateDynamic3DTextLabel(strings, COLOR_ARWIN, 1491.14, 1306.33, 1093.28, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Veh insurance
	
	//IMPOUND
 	CreateDynamic3DTextLabel(""YELLOW_E"Impound Center\n{00FFFF}'/unimpound' "WHITE_E"untuk mengunimpound kendaraan", COLOR_WHITE, 2820.2354, -1475.2073, 16.2500, 10.0);
 	CreateDynamicPickup(1239, 23, 2820.2354, -1475.2073, 16.2500, -1); // TEMPAT UNTUK UNIMPOUND

	CreateDynamicPickup(1239, 23, 1320.6910,739.4119,111.3203, -1);
	format(strings, sizeof(strings), "{00FFFF}[Ticket]\n"YELLOW_E"/payticket - "WHITE_E"to pay ticket\n"YELLOW_E"/unlocktire - "WHITE_E"to unlock tire vehicle\n"YELLOW_E"/buyplate - "WHITE_E"to buy you plate");
	CreateDynamic3DTextLabel(strings, COLOR_ARWIN, 1320.6910,739.4119,111.3203, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Ticket
	
	CreateDynamicPickup(1247, 23, 226.8309, 114.6640, 999.0156, -1);
	format(strings, sizeof(strings), "{00FFFF}[Arrest Point]\n"YELLOW_E"/arrest - arrest wanted player");
	CreateDynamic3DTextLabel(strings, COLOR_ARWIN, 226.8309, 114.6640, 999.0156, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // arrest
	
	CreateDynamicPickup(1240, 23, 1142.38, -1330.74, 13.62, -1);
	format(strings, sizeof(strings), "{00FFFF}[Hospital]\n"YELLOW_E"/dropinjured");
	CreateDynamic3DTextLabel(strings, COLOR_ARWIN, 1142.38, -1330.74, 13.62, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // hospital

	CreateDynamicPickup(1274, 23, 1429.3341,-985.9102,996.1050, -1);
	format(strings, sizeof(strings), "{00FFFF}Bank\n"YELLOW_E"/help > Money & Banking"WHITE_E" to check all the commands");
	CreateDynamic3DTextLabel(strings, COLOR_ARWIN, 1429.3341,-985.9102,996.1050, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // bank
	
	CreateDynamicPickup(1239, 23, 1515.9568,1421.7207,489.6216, -1);
	format(strings, sizeof(strings), "{00FFFF}[Advertisement]\n"YELLOW_E"/ad "WHITE_E"- public ads");
	CreateDynamic3DTextLabel(strings, COLOR_ARWIN, 1515.9568,1421.7207,489.6216, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // iklan

	CreateDynamicPickup(1239, 23, 144.52, -1886.32, 1.56, -1);
	format(strings, sizeof(strings), "{00FFFF}[Boat Dealership]\n"YELLOW_E"/buyboat "WHITE_E"to purchase a boat");
	CreateDynamic3DTextLabel(strings, COLOR_ARWIN, 144.52, -1886.32, 1.56, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Plate

	// format(strings, sizeof(strings), "{00FFFF}[Motorcycle Dealer]\n"YELLOW_E"/buyvehicle "WHITE_E"to purchase a motorcycle");
	// CreateDynamic3DTextLabel(strings, -1,1848.0145,-1871.7001,13.5781,10.0);
	// CreateDynamicPickup(1239, 23, 1848.0145,-1871.7001,13.5781, -1);

	format(strings, sizeof(strings), "{00FFFF}[Bike Dealer]\n"YELLOW_E"/buyvehicle "WHITE_E"to purchase a bicycle");
	CreateDynamic3DTextLabel(strings, -1,701.6057,-518.9899,16.3284,10.0);
	CreateDynamicPickup(1239, 23, 701.6057,-518.9899,16.3284, -1);
	
	// format(strings, sizeof(strings), "{00FFFF}[Car Dealer]\n"YELLOW_E"/buyvehicle "WHITE_E"to purchase a vehicle");
	// CreateDynamic3DTextLabel(strings, -1,2131.8284,-1150.4662,24.1544,10.0);
	// CreateDynamicPickup(1239, 23, 2131.8284,-1150.4662,24.1544, -1);

	//ShowroomVIP
	CreateDynamicPickup(1239, 23, 563.3856,-1292.2179,17.2482, -1);
	format(strings, sizeof(strings), "{00FFFF}[VIP Dealership]\n"YELLOW_E"/buyvehicle  "WHITE_E"To purchase exclusive vehicles for donators");
	CreateDynamic3DTextLabel(strings, COLOR_ARWIN, 563.3856,-1292.2179,17.2482, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Plate

	CreateDynamicPickup(1239, 23, 758.5930,-77.6466,1000.6508, -1);
	format(strings, sizeof(strings), "{00FFFF}[Fight STyle]\n"YELLOW_E"/buyfightstyle");
	CreateDynamic3DTextLabel(strings, COLOR_ARWIN, 758.5930,-77.6466,1000.6508, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Plate

	CreateDynamicPickup(1239, 23, 1685.4528,-1464.4073,13.5469, -1);
	format(strings, sizeof(strings), "== [Taxi Driver] ==\n"YELLOW_E"/joinjob - "WHITE_E"To Join Job\n"WHITE_E"You can buy Taxi here using "YELLOW_E"/buytaxi");
	CreateDynamic3DTextLabel(strings, COLOR_ARWIN, 1685.4528,-1464.4073,13.5469, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Plate

	CreateDynamicPickup(1239, 23, 1676.1809,-1462.1836,13.5538, -1);
	format(strings, sizeof(strings), "== [Builder Jobs] ==\n"YELLOW_E"/joinjob - "WHITE_E"To Join Job");
	CreateDynamic3DTextLabel(strings, COLOR_ARWIN, 1676.1809,-1462.1836,13.5538, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // plate

	CreateDynamicPickup(1239, 23, -1438.4968,-1544.1377,101.7578, -1);
	format(strings, sizeof(strings), "== [Lumber Jack] ==\n"YELLOW_E"/joinjob - "WHITE_E"To Join Job\n"YELLOW_E"/buychainsaw - "WHITE_E"To buy chainsaw");
	CreateDynamic3DTextLabel(strings, COLOR_ARWIN, -1438.4968,-1544.1377,101.7578, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Plate

	CreateDynamicPickup(1239, 23, -77.1687,-1136.5388,1.0781, -1);
	format(strings, sizeof(strings), "== [Trucker Driver] ==\n"YELLOW_E"/joinjob - "WHITE_E"To Join Job\n"WHITE_E"You can buy Truck here using "YELLOW_E"/buytruck");
	CreateDynamic3DTextLabel(strings, COLOR_ARWIN, -77.1687,-1136.5388,1.0781, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Plate

	CreateDynamicPickup(1239, 23, -382.7033,-1438.9998,26.1691, -1);
	format(strings, sizeof(strings), "== [Farmer Jobs] ==\n"YELLOW_E"/joinjob - "WHITE_E"To Join Job");
	CreateDynamic3DTextLabel(strings, COLOR_ARWIN, -382.7033,-1438.9998,26.1691, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Plate

	CreateDynamicPickup(1239, 23, 2844.0684,-1516.6871,11.3002, -1);
	format(strings, sizeof(strings), "{00FFFF}[Fish Shop]\n"YELLOW_E"/Sellallfish "WHITE_E"- to sell fish", StockFish);
	CreateDynamic3DTextLabel(strings, COLOR_ARWIN, 2844.0684,-1516.6871,11.3002, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Plate

	//Crate Component
	CreateDynamicPickup(1271, 23, 323.6411, 904.5583, 21.5862, -1);
	format(strings, sizeof(strings), "== [Component crate] ==\n"WHITE_E"Use "YELLOW_E"'/getcrate' "WHITE_E"to pickup crate");
	CreateDynamic3DTextLabel(strings, COLOR_ARWIN, 323.6411, 904.5583, 21.5862, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Plate
	
	//Crate unload Component
	CreateDynamicPickup(1271, 23, 797.7953,-616.8799,16.3359, -1);
	format(strings, sizeof(strings), "== [Component crate] ==\n"WHITE_E"Use "YELLOW_E"'/unloadcrate' "WHITE_E"to unload crate");
	CreateDynamic3DTextLabel(strings, COLOR_ARWIN, 797.7953,-616.8799,16.3359, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Plate
	
	//Crate Unload Fish
	CreateDynamicPickup(1271, 23, -577.1335,-503.6530,25.5107, -1);
	format(strings, sizeof(strings), "== [Fish crate] ==\n"WHITE_E"Use "YELLOW_E"'/unloadcrate' "WHITE_E"to unload crate");
	CreateDynamic3DTextLabel(strings, COLOR_ARWIN, -577.1335,-503.6530,25.5107, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Plate

	//GARAGE PICKUP NEWS
	GaragePickup[0] = CreateDynamicCP(2485.8213,2379.3203,7.0685, 4.0, -1, 5, -1, 5.0); // untuk keluar
	CreateDynamicPickup(19130, 23, 2485.8213,2379.3203,7.0685, -1, 5, -1, 7);
	CreateDynamic3DTextLabel("{00FFFF}[DID: 1]\n{FFFF00}Basement News\n{FFFFFF}Press '{FF0000}ENTER{FFFFFF}' to enter/exit the door", COLOR_YELLOW, 2485.8213,2379.3203,7.0685+0.7, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, 5);
	GaragePickup[1] = CreateDynamicCP(656.4168,-1326.0953,13.5521, 4.0, -1, -1, -1, 5.0); // untuk masuk
	CreateDynamicPickup(19130, 23, 656.4168,-1326.0953,13.5521, -1, -1, -1, 7);
	CreateDynamic3DTextLabel("{00FFFF}[DID: 2]\n{FFFF00}Basement News\n{FFFFFF}Press '{FF0000}ENTER{FFFFFF}' to enter/exit the door", COLOR_YELLOW, 656.4168,-1326.0953,13.5521+0.7, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1);

	//GARAGE PICKUP RS
	GaragePickup[2] = CreateDynamicCP(2485.8213,2379.3203,7.0685, 4.0, -1, 6, -1, 5.0); // untuk keluar
	CreateDynamicPickup(19130, 23, 2485.8213,2379.3203,7.0685, -1, 6, -1, 7);
	CreateDynamic3DTextLabel("{00FFFF}[DID: 3]\n{FFFF00}Basement News\n{FFFFFF}Press '{FF0000}ENTER{FFFFFF}' to enter/exit the door", COLOR_YELLOW, 2485.8213,2379.3203,7.0685+0.7, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, 6);
	GaragePickup[3] = CreateDynamicCP(1178.5835,-1308.4675,13.7781, 4.0, -1, -1, -1, 5.0); // untuk masuk
	CreateDynamic3DTextLabel("{00FFFF}[DID: 4]\n{FFFF00}Basement Hospital\n{FFFFFF}Press '{FF0000}ENTER{FFFFFF}' to enter/exit the door", COLOR_YELLOW, 1178.5835,-1308.4675,13.7781+0.7, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1);
	CreateDynamicPickup(19130, 23, 1178.5835,-1308.4675,13.7781, -1, -1, -1, 7);
	
	//GARAGE PICKUP SAGS
	GaragePickup[4] = CreateDynamicCP(1133.8325,-2136.0264,-7.1010, 4.0, -1, -1, -1, 5.0); // untuk keluar
	CreateDynamicPickup(19130, 23, 1133.8325,-2136.0264,-7.1010, -1, -1, -1, 7);
	CreateDynamic3DTextLabel("{00FFFF}[DID: 5]\n{FFFF00}Basement SAGS\n{FFFFFF}Press '{FF0000}ENTER{FFFFFF}' to enter/exit the door", COLOR_YELLOW, 1133.8325,-2136.0264,-7.1010+0.7, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1);
	GaragePickup[5] = CreateDynamicCP(1470.6168,-1840.9789,13.5469, 4.0, -1, -1, -1, 5.0); // untuk masuk
	CreateDynamicPickup(19130, 23, 1470.6168,-1840.9789,13.5469, -1, -1, -1, 7);
	CreateDynamic3DTextLabel("{00FFFF}[DID: 6]\n{FFFF00}Basement SAGS\n{FFFFFF}Press '{FF0000}ENTER{FFFFFF}' to enter/exit the door", COLOR_YELLOW, 1470.6168,-1840.9789,13.5469+0.7, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1);
	
	//GARAGE PICKUP STASIUN
	GaragePickup[6] = CreateDynamicCP(2485.8213,2379.3203,7.0685, 4.0, -1, 7, -1, 5.0); // untuk keluar
	CreateDynamic3DTextLabel("{00FFFF}[DID: 7]\n{FFFF00}Basement Stasion\n{FFFFFF}Press '{FF0000}ENTER{FFFFFF}' to enter/exit the door", COLOR_YELLOW, 2485.8213,2379.3203,7.0685+0.7, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, 7);
	CreateDynamicPickup(19130, 23, 2485.8213,2379.3203,7.0685, -1, 7, -1, 7);
	GaragePickup[7] = CreateDynamicCP(1767.5198,-1887.3687,13.5916, 4.0, -1, -1, -1, 5.0); // untuk masuk
	CreateDynamic3DTextLabel("{00FFFF}[DID: 8]\n{FFFF00}Basement Stasion\n{FFFFFF}Press '{FF0000}ENTER{FFFFFF}' to enter/exit the door", COLOR_YELLOW, 1767.5198,-1887.3687,13.5916+0.7, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1);
	CreateDynamicPickup(19130, 23, 1767.5198,-1887.3687,13.5916, -1, -1, -1, 7);

	//FARMER
	CreateDynamicPickup(1239, 23, -372.3396, -1427.8840, 25.7266, -1); // jual BIBIT
	CreateDynamic3DTextLabel("= Farm Storage =\n"YELLOW_E"'/sellplant' "WHITE_E"Untuk menjual tanaman\n"YELLOW_E"'/sellallplant' "WHITE_E"Untuk menjual seluruh tanaman\n"YELLOW_E"'/buyseeds' "WHITE_E"Untuk membeli bibit\n", COLOR_ARWIN,-372.3396, -1427.8840, 25.7266,10.0);

	//Mechanic
	CreateDynamicPickup(1239, 23, 2330.1626,-2315.2642,13.5469, -1);
	format(strings, sizeof(strings), "{00FFFF}[Mechanic Job]\n"YELLOW_E"/joinjob - "WHITE_E"To Join Job\n"WHITE_E"You can buy Tow Truck here using "YELLOW_E"/buytowtruck");
	CreateDynamic3DTextLabel(strings, COLOR_ARWIN, 2330.1626,-2315.2642,13.5469, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Plate

	CreateDynamic3DTextLabel("[Bait Store]\n{00FFFF}'/buybait' "WHITE_E"untuk membeli Umpan ", COLOR_ARWIN,361.2099,-2032.1703,7.8359,10.0);
    CreateDynamicPickup(1239, 23, 361.2099,-2032.1703,7.8359, -1); // buybait
	return 1;
}