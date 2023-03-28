#include <YSI\y_hooks>

new 
	SAMDVehicles[MAX_SAMD_VEHICLES],
	SANAVehicles[MAX_SANA_VEHICLES],
	ForkliftVeh[MAX_FORKLIFT_VEHICLES],
	objectforklift,
	SweepVeh[MAX_SWEEPER_VEHICLES]
;
//SAPD
new LSPDVehicles[ 69 ];
new Cruiser[10], Lincoln[10], Kopassus[10], LincolnHitam [10], ZeusUnit [3], TEU [7], Chief [3];

IsASweeperVeh(carid)
{
	for(new v = 0; v < MAX_SWEEPER_VEHICLES; v++) {
	    if(carid == SweepVeh[v]) return 1;
	}
	return 0;
}

IsAForkliftVeh(carid)
{
	for(new v = 0; v < MAX_FORKLIFT_VEHICLES; v++) 
	{
	    if(carid == ForkliftVeh[v]) return 1;
	}
	return 0;
}

IsABusABVeh(carid)
{
	for(new v = 0; v < MAX_BUS_VEHICLES; v++) {
	    if(carid == BusABVeh[v]) return 1;
	}
	return 0;
}

IsABusCDVeh(carid)
{
	for(new v = 0; v < MAX_BUS_VEHICLES; v++) {
	    if(carid == BusCDVeh[v]) return 1;
	}
	return 0;
}
IsATrashVeh(carid)
{
	for(new v = 0; v < MAX_TRASH_VEHICLES; v++){
		if(carid == TrashVeh[v]) return 1;
	}
	return 0;
}

IsAPizzaVeh(carid)
{
	for(new v = 0; v < sizeof(PizzaVeh); v++) {
	    if(carid == PizzaVeh[v]) return 1;
	}
	return 0;
}

IsSAMDCar(carid)
{
	for(new v = 0; v < MAX_SAMD_VEHICLES; v++)
	{
	    if(carid == SAMDVehicles[v]) return 1;
	}
	return 0;
}

IsSANACar(carid)
{
	for(new v = 0; v < MAX_SANA_VEHICLES; v++)
	{
	    if(carid == SANAVehicles[v]) return 1;
	}
	return 0;
}

IsSAPDCar(carid)
{
	for(new v = 0; v < sizeof(LSPDVehicles); v++)
	{
	    if(carid == LSPDVehicles[v]) return 1;
	}
	for(new v = 0; v < sizeof(TEU); v++)
	{
	    if(carid == TEU[v]) return 1;
	}
	for(new v = 0; v < sizeof(ZeusUnit); v++)
	{
	    if(carid == ZeusUnit[v]) return 1;
	}
	for(new v = 0; v < sizeof(LincolnHitam); v++)
	{
	    if(carid == LincolnHitam[v]) return 1;
	}
	for(new v = 0; v < sizeof(LincolnHitam); v++)
 	{
	    if(carid == LincolnHitam[v]) return 1;
	}
	for(new v = 0; v < sizeof(Kopassus); v++)
	{
	    if(carid == Kopassus[v]) return 1;
	}
	for(new v = 0; v < sizeof(Lincoln); v++)
	{
	    if(carid == Lincoln[v]) return 1;
	}
	for(new v = 0; v < sizeof(Cruiser); v++)
	{
	    if(carid == Cruiser[v]) return 1;
	}
	for(new v = 0; v < sizeof(Chief); v++)
	{
	    if(carid == Chief[v]) return 1;
	}
	return 0;
}

CreateVehicleFaction()
{
	//LSPD VEHICLES
	LincolnHitam[1] = LSPDVehicles[30] = AddStaticVehicleEx(596,1602.3312,-1684.0071,5.6185,91.2188,0,1, VEHICLE_RESPAWN); // Cruiser
	SetVehicleNumberPlate(LincolnHitam[1], ""BLACK_E"LINCON-1");
	SetVehicleHealth(LincolnHitam[1], 2000.0);
	AddVehicleComponent(LincolnHitam[1], 1080);
	LincolnHitam[2] = LSPDVehicles[31] = AddStaticVehicleEx(596,1602.5184,-1687.9525,5.6098,89.0430,0,1, VEHICLE_RESPAWN); // Cruiser
	SetVehicleNumberPlate(LincolnHitam[2], ""BLACK_E"LINCON-2");
	SetVehicleHealth(LincolnHitam[2], 2000.0);
	AddVehicleComponent(LincolnHitam[2], 1080);
	LincolnHitam[3] = LSPDVehicles[32] = AddStaticVehicleEx(596,1602.3141,-1692.2067,5.6149,89.1927,0,1, VEHICLE_RESPAWN); // Cruiser
	SetVehicleNumberPlate(LincolnHitam[3], ""BLACK_E"LINCON-3");
	SetVehicleHealth(LincolnHitam[3], 2000.0);
	AddVehicleComponent(LincolnHitam[3], 1080);
	LincolnHitam[4] = LSPDVehicles[33] = AddStaticVehicleEx(596,1602.2833,-1696.3682,5.6286,90.2932,0,1, VEHICLE_RESPAWN); // Cruiser
	SetVehicleNumberPlate(LincolnHitam[4], ""BLACK_E"LINCON-4");
	SetVehicleHealth(LincolnHitam[4], 2000.0);
	AddVehicleComponent(LincolnHitam[4], 1080);
	LincolnHitam[5] = LSPDVehicles[34] = AddStaticVehicleEx(596,1602.1863,-1700.2629,5.6161,88.2802,0,1, VEHICLE_RESPAWN); // Cruiser
	SetVehicleNumberPlate(LincolnHitam[5], ""BLACK_E"LINCON-5");
	SetVehicleHealth(LincolnHitam[5], 2000.0);
	AddVehicleComponent(LincolnHitam[5], 1080);
	LincolnHitam[6] = LSPDVehicles[35] = AddStaticVehicleEx(596,1595.1029,-1711.1693,5.6132,358.1242,0,1, VEHICLE_RESPAWN); // Cruiser
	SetVehicleNumberPlate(LincolnHitam[6], ""BLACK_E"LINCON-6");
	SetVehicleHealth(LincolnHitam[6], 2000.0);
	AddVehicleComponent(LincolnHitam[6], 1074);
	LincolnHitam[7] = LSPDVehicles[36] = AddStaticVehicleEx(596,1591.2061,-1711.1152,5.6060,357.9518,0,1, VEHICLE_RESPAWN); // Cruiser
	SetVehicleNumberPlate(LincolnHitam[7], ""BLACK_E"LINCON-7");
	SetVehicleHealth(LincolnHitam[7], 2000.0);
	AddVehicleComponent(LincolnHitam[7], 1074);
	LincolnHitam[8] = LSPDVehicles[37] = AddStaticVehicleEx(596,1587.8042,-1711.0640,5.6139,0.4377,0,1, VEHICLE_RESPAWN); // Cruiser
	SetVehicleNumberPlate(LincolnHitam[8], ""BLACK_E"LINCON-8");
	SetVehicleHealth(LincolnHitam[8], 2000.0);
	AddVehicleComponent(LincolnHitam[8], 1074);
	LincolnHitam[9] = LSPDVehicles[38] = AddStaticVehicleEx(596,1583.5166,-1710.9095,5.6262,357.2809,0,1, VEHICLE_RESPAWN); // Cruiser
	SetVehicleNumberPlate(LincolnHitam[9], ""BLACK_E"LINCON-9");
	SetVehicleHealth(LincolnHitam[9], 2000.0);
	AddVehicleComponent(LincolnHitam[9], 1074);
	//KOPASSUS
	Kopassus[0] = LSPDVehicles[9] = AddStaticVehicleEx(601,1526.5850,-1644.1801,5.6494,180.3210,1,1, VEHICLE_RESPAWN); // Splashy
	SetVehicleNumberPlate(Kopassus[0], ""GREEN_E"KING-3");
	SetVehicleHealth(Kopassus[0], 2000.0);
	Kopassus[1] = LSPDVehicles[10] = AddStaticVehicleEx(601,1530.7244,-1644.2538,5.6494,179.6148,1,1, VEHICLE_RESPAWN); // Splashy
	SetVehicleNumberPlate(Kopassus[1], ""GREEN_E"KING-4");
	SetVehicleHealth(Kopassus[0], 2000.0);
	Kopassus[2] = LSPDVehicles[11] = AddStaticVehicleEx(427,1534.8553,-1644.8682,6.0226,180.7921,0,0, VEHICLE_RESPAWN); // Enforcer
	SetVehicleNumberPlate(Kopassus[2], ""GREEN_E"KING-5");
	SetVehicleHealth(Kopassus[2], 2000.0);
	Kopassus[3] = LSPDVehicles[12] = 	AddStaticVehicleEx(427,1538.9325,-1644.9508,6.0226,179.5991,0,0, VEHICLE_RESPAWN); // Enforcer
	SetVehicleNumberPlate(Kopassus[3], ""GREEN_E"KING-6");
	SetVehicleHealth(Kopassus[3], 2000.0);
	//MAVERICK
	Kopassus[4] = LSPDVehicles[18] = AddStaticVehicleEx(497,1565.0839,-1643.2800,28.5921,89.4944,0,1, VEHICLE_RESPAWN); // Maverick
	SetVehicleNumberPlate(Kopassus[4], ""GREEN_E"CHOPPER-1");
	Kopassus[5] = LSPDVehicles[19] = AddStaticVehicleEx(497,1564.4895,-1703.4138,28.5848,87.6184,0,1, VEHICLE_RESPAWN); // Maverick
	SetVehicleNumberPlate(Kopassus[5], ""GREEN_E"CHOPPER-2");
	//RANCHER
	Kopassus[8] = LSPDVehicles[8] = AddStaticVehicleEx(490,1545.7213,-1655.0195,6.0814,90.4218,0,0, VEHICLE_RESPAWN); // Rancher
	SetVehicleNumberPlate(Kopassus[8], ""GREEN_E"KING-1");
	SetVehicleHealth(Kopassus[8], 2000.0);
	Kopassus[9] = LSPDVehicles[9] = AddStaticVehicleEx(490,1545.8069,-1651.1516,6.0790,88.2897,0,0, VEHICLE_RESPAWN); // Rancher
	SetVehicleNumberPlate(Kopassus[9], ""GREEN_E"KING-2");
	SetVehicleHealth(Kopassus[9], 2000.0);
	//Zeus Unit
	ZeusUnit[1] = LSPDVehicles[20] = AddStaticVehicleEx(525,1528.3439,-1684.0914,5.7702,269.9949,1,0, VEHICLE_RESPAWN); // Towtruck
	SetVehicleNumberPlate(ZeusUnit[1], ""GREEN_E"ZEUS-1");
	AddVehicleComponent(ZeusUnit[1], 1074);
	ZeusUnit[2] = LSPDVehicles[21] = AddStaticVehicleEx(525,1528.6476,-1688.2294,5.7698,269.9370,1,0, VEHICLE_RESPAWN); // Towtruck
	SetVehicleNumberPlate(ZeusUnit[2], ""GREEN_E"ZEUS-2");
	AddVehicleComponent(ZeusUnit[2], 1074);
	//TEU UNIT
	TEU[0] = LSPDVehicles[22] = AddStaticVehicleEx(468,1544.0415,-1708.5723,5.5538,156.7939,0,0, VEHICLE_RESPAWN, 1); // Cruiser (Front)
	SetVehicleNumberPlate(TEU[0], ""GREEN_E"TEU-1");
	SetVehicleHealth(TEU[0], 2000.0);
	TEU[1] = LSPDVehicles[23] = AddStaticVehicleEx(468,1542.7850,-1707.5076,5.5622,158.1278,0,0, VEHICLE_RESPAWN, 1); // Tow Truck
	SetVehicleNumberPlate(TEU[1], ""GREEN_E"TEU-2");
	SetVehicleHealth(TEU[1], 2000.0);
	TEU[2] = LSPDVehicles[24] = AddStaticVehicleEx(468,1542.0917,-1707.0608,5.5511,154.1654,0,0, VEHICLE_RESPAWN, 1); // Tow Truck
	SetVehicleNumberPlate(TEU[2], ""GREEN_E"TEU-3");
	SetVehicleHealth(TEU[2], 2000.0);
	TEU[3] = LSPDVehicles[25] = AddStaticVehicleEx(522,1540.4431,-1705.9148,5.4508,156.6729,0,0, VEHICLE_RESPAWN, 1); // Maverick
	SetVehicleNumberPlate(TEU[3], ""GREEN_E"TEU-4");
	SetVehicleHealth(TEU[3], 2000.0);
	TEU[4] = LSPDVehicles[26] = AddStaticVehicleEx(522,1539.9655,-1705.2487,5.4344,156.1196,0,0, VEHICLE_RESPAWN, 1); // Maverick
	SetVehicleNumberPlate(TEU[4], ""GREEN_E"TEU-5");
	SetVehicleHealth(TEU[4], 2000.0);
	TEU[5] = LSPDVehicles[27] = AddStaticVehicleEx(522,1539.1798,-1704.4395,5.4616,154.4021,0,0, VEHICLE_RESPAWN, 1); // Maverick
	SetVehicleNumberPlate(TEU[5], ""GREEN_E"TEU-6");
	SetVehicleHealth(TEU[5], 2000.0);
	//SULTAN CHIEF SAPD
    Chief[1] = LSPDVehicles[28] = AddStaticVehicleEx(560,1546.3962,-1668.0127,5.5955,89.4513,0,0, VEHICLE_RESPAWN, 1); // Rancher
	SetVehicleNumberPlate(Chief[1], ""GREEN_E"Chief SAPD");
	AddVehicleComponent(Chief[1], 1080);
	SetVehicleHealth(Chief[1], 2000.0);
	Chief[2] = LSPDVehicles[29] = AddStaticVehicleEx(560,1546.2767,-1663.0496,5.5966,90.1683,0,0, VEHICLE_RESPAWN, 1); // Rancher
	SetVehicleNumberPlate(Chief[2], ""GREEN_E"Deputy SAPD");
	AddVehicleComponent(Chief[2], 1080);
	SetVehicleHealth(Chief[2], 2000.0);
	
	new strings[212];
	// SAMD VEHICLE
	SAMDVehicles[0] = AddStaticVehicle(416, 1116.0294, -1296.6489, 13.6160, 179.4438, 1, 3);
	SAMDVehicles[1] = AddStaticVehicle(416, 1125.8785, -1296.2780, 13.6160, 179.4438, 1, 3);
	SAMDVehicles[2] = AddStaticVehicle(416, 1121.1556, -1296.4138, 13.6160, 179.4438, 1, 3);
	SAMDVehicles[3] = AddStaticVehicle(442, 1111.1719, -1296.7606, 13.4886, 185.0000, 0, 1);
	SAMDVehicles[4] = AddStaticVehicle(426, 1136.0360, -1341.2158, 13.3050, 0.0000, 0, 1);
	SAMDVehicles[5] = AddStaticVehicle(586, 1130.7795, -1330.4045, 13.3639, 0.0000, 0, 1);
	SAMDVehicles[6] = AddStaticVehicle(563, 1162.9077, -1313.8203, 32.1891, 270.6980, -1, 3);
	SAMDVehicles[7] = AddStaticVehicle(487, 1163.0469, -1297.5098, 31.5550, 269.6279, -1, 3);
	
	for(new x;x<MAX_SAMD_VEHICLES; x++)
	{
	    format(strings, sizeof(strings), ""GREEN_E"SAMD-%d", SAMDVehicles[x]);
	    SetVehicleNumberPlate(SAMDVehicles[x], strings);
	    SetVehicleToRespawn(SAMDVehicles[x]);
	}

	// SANA VEHICLE
	SANAVehicles[0] = AddStaticVehicle(582, 781.4338, -1337.5022, 13.9482, 91.0000, -1, -1);
	SANAVehicles[1] = AddStaticVehicle(582, 758.7664, -1336.1642, 13.9482, 179.0212, -1, -1);
	SANAVehicles[2] = AddStaticVehicle(582, 764.4276, -1336.1959, 13.9482, 179.0212, -1, -1);
	SANAVehicles[3] = AddStaticVehicle(582, 770.3247, -1335.9663, 13.9482, 179.0212, -1, -1);
	SANAVehicles[4] = AddStaticVehicle(418, 737.3025, -1334.3344, 14.1711, 246.6513, -1, -1);
	SANAVehicles[5] = AddStaticVehicle(413, 736.4621, -1338.6304, 13.7490, -113.0000, -1, -1);
	SANAVehicles[6] = AddStaticVehicle(405, 737.4107, -1343.0820, 13.7357, -113.0000, -1, -1);
	SANAVehicles[7] = AddStaticVehicle(461, 749.7194, -1334.2122, 13.2465, 178.0000, -1, -1);
	SANAVehicles[8] = AddStaticVehicle(461, 753.8127, -1334.2727, 13.2465, 178.0000, -1, -1);
	SANAVehicles[9] = AddStaticVehicle(488, 741.9925, -1371.2443, 25.8111, 0.0000, -1, -1);

	for(new x;x<MAX_SANA_VEHICLES; x++)
	{
	    format(strings, sizeof(strings), ""GREEN_E"SANA-%d", SANAVehicles[x]);
	    SetVehicleNumberPlate(SANAVehicles[x], strings);
	    SetVehicleToRespawn(SANAVehicles[x]);
	}
	//SIDE JOB BUS VEHICLE
    BusABVeh[0] = AddStaticVehicle(431,1704.9745,-1523.7998,13.4898,0.2287,3,3);
    BusABVeh[1] = AddStaticVehicle(431,1704.9609,-1510.5085,13.4902,0.5206,3,3);
    BusABVeh[2] = AddStaticVehicle(431,1705.0253,-1497.8011,13.4714,0.1701,3,3);
	
	for(new x;x<MAX_BUS_VEHICLES;x++)
	{
	    format(strings, sizeof(strings), ""GREEN_E"BUS(A/B)-%d", BusABVeh[x]);
	    SetVehicleNumberPlate(BusABVeh[x], strings);
	    SetVehicleToRespawn(BusABVeh[x]);
	}
	//SIDE JOB BUS VEHICLE
    BusCDVeh[0] = AddStaticVehicle(431, 1802.093,-1924.423,13.389,26.936, 6,6);
    BusCDVeh[1] = AddStaticVehicle(431, 1801.074,-1912.830,13.395,40.105, 6,6);
	
	for(new x;x<MAX_BUS_VEHICLES;x++)
	{
	    format(strings, sizeof(strings), ""GREEN_E"BUS(C/D)-%d", BusCDVeh[x]);
	    SetVehicleNumberPlate(BusCDVeh[x], strings);
	    SetVehicleToRespawn(BusCDVeh[x]);
	}

	//SIDE JOB TRASH VEHICLE
	TrashVeh[0] = AddStaticVehicle(408, 2133.1479, -2092.8505, 13.3872, 0.0000, 1, 1);
	TrashVeh[1] = AddStaticVehicle(408, 2126.5175, -2085.2412, 13.3842, 0.0000, 1, 1);
	TrashVeh[2] = AddStaticVehicle(408, 2119.3496, -2077.6713, 13.3823, 0.0000, 1, 1);

	for(new x;x<MAX_TRASH_VEHICLES;x++)
	{
		format(strings, sizeof(strings), ""GREEN_E"TRASHMASTER-%d", TrashVeh[x]);
	    SetVehicleNumberPlate(TrashVeh[x], strings);
	    SetVehicleToRespawn(TrashVeh[x]);
	}

	PizzaVeh[0] = CreateVehicle(448, 2113.4700,-1784.5083,12.9872, 355.4538, 3, 3, VEHICLE_RESPAWN);
	PizzaVeh[1] = CreateVehicle(448, 2117.5247,-1784.9316,12.9872, 1.1392, 3, 3, VEHICLE_RESPAWN);
	PizzaVeh[2] = CreateVehicle(448, 2120.4673,-1784.8541,12.9858, 358.8643,3, 3, VEHICLE_RESPAWN);
	PizzaVeh[3] = CreateVehicle(448, 2123.2676,-1784.8853,12.9871, 356.8564,-3, 3, VEHICLE_RESPAWN);

	for(new x;x<MAX_PIZZA_VEHICLES;x++)
	{
		format(strings, sizeof(strings), ""GREEN_E"PIZZA-%d", TrashVeh[x]);
	    SetVehicleNumberPlate(TrashVeh[x], strings);
	    SetVehicleToRespawn(TrashVeh[x]);
	}

	//SIDE JOB SWEEPER VEHICLE
	SweepVeh[0] = AddStaticVehicle(574, 1615.5201, -1896.2864, 13.2474, 0.0000, 1, 1);
	SweepVeh[1] = AddStaticVehicle(574, 1622.4797, -1896.2864, 13.2474, 0.0000, 1, 1);
	SweepVeh[2] = AddStaticVehicle(574, 1619.0095, -1896.2864, 13.2474, 0.0000, 1, 1);

	for(new x;x<MAX_SWEEPER_VEHICLES; x++)
	{
	    format(strings, sizeof(strings), ""GREEN_E"SWEPEER-%d", SweepVeh[x]);
	    SetVehicleNumberPlate(SweepVeh[x], strings);
	    SetVehicleToRespawn(SweepVeh[x]);
	}
	//SIDE JOB FORKLIFT VEHICLE
	ForkliftVeh[0] = AddStaticVehicle(530, 2736.0835,-2422.5706,13.3944,271.7984, 1, 1);
	ForkliftVeh[1] = AddStaticVehicle(530, 2735.9673,-2420.5259,13.3937,274.1164, 1, 1);
	ForkliftVeh[2] = AddStaticVehicle(530, 2736.0308,-2418.5725,13.3927,274.7471, 1, 1);

	for(new x;x<MAX_FORKLIFT_VEHICLES; x++)
	{
	    format(strings, sizeof(strings), ""GREEN_E"FORKLIFT-%d", ForkliftVeh[x]);
	    SetVehicleNumberPlate(ForkliftVeh[x], strings);
	    SetVehicleToRespawn(ForkliftVeh[x]);
	}	
}
