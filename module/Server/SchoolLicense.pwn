//NEW DMV SYSTEM
#define cartestcp1 2047.1849,-1930.2665,13.0876
#define cartestcp2 1968.0247,-1930.1829,13.0882
#define cartestcp3 1824.0208,-1917.7654,13.0856
#define cartestcp4 1787.3108,-1827.8440,13.0876
#define cartestcp5 1688.0021,-1840.3541,13.0876
#define cartestcp6 1625.1812,-1870.2305,13.0882
#define cartestcp7 1571.7096,-1852.4192,13.0876
#define cartestcp8 1556.1931,-1730.5265,13.0875
#define cartestcp9 1531.9980,-1715.3065,13.0876
#define cartestcp10 1542.4998,-1594.5765,13.0876
#define cartestcp11 1680.8341,-1595.0997,13.0914
#define cartestcp12 1844.6248,-1614.3239,13.0882
#define cartestcp13 1939.3665,-1631.7688,13.0875
#define cartestcp14 1958.7997,-1769.8575,13.0876
#define cartestcp15 1980.0818,-1814.7788,13.0877
#define cartestcp16 2079.0569,-1824.9231,13.0873
#define cartestcp17 2061.8386,-1913.1362,13.2507

new DmvVeh[2]; 

AddDmvVehicle()
{
	DmvVeh[0] = AddStaticVehicleEx(426, 2062.4031,-1904.4381,13.3260,179.6736, 0, 0, VEHICLE_RESPAWN);
	DmvVeh[1] = AddStaticVehicleEx(426, 2065.6091,-1904.2465,13.3271,179.3452, 0, 0, VEHICLE_RESPAWN);
}

IsADmvVeh(carid)
{
	for(new v = 0; v < sizeof(DmvVeh); v++) {
	    if(carid == DmvVeh[v]) return 1;
	}
	return 0;
}

CMD:taketest(playerid, params[])
{
    if(pData[playerid][pTaketest] > 0)
    return Error(playerid, "You haven't had the test yet");
    if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1491.14, 1306.33, 1093.28)) return Error(playerid, "Anda harus berada di DMV!");
    new cost = 5000;
    if(pData[playerid][pMoney] < cost)
    {
         Error(playerid, "Your money is not enough");
    }
    else
    {
        //pData[playerid][pTaketest] = 1;
        GivePlayerMoneyEx(playerid, -cost);
        pData[playerid][pSedangCarDmv] = 1;
        SendClientMessageEx(playerid, COLOR_ARWIN, "DMV: "WHITE_E"Silahkan menaiki mobil DMV di depan untuk mengikuti test.");
    }
    return 1;
}

CMD:renewlic(playerid, params[])
{
    if(pData[playerid][pTaketest] < 1)
    return Error(playerid, "You haven't had the test yet");
    if(pData[playerid][pDriveLic] > 0)
    return Error(playerid, "You still have an active license");
    if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1491.14, 1306.33, 1093.28)) return Error(playerid, "Anda harus berada di DMV!");
    new cost = 2500;
    if(pData[playerid][pMoney] < cost)
    {
         Error(playerid, "Your money is not enough");
    }
    else
    {
        pData[playerid][pDriveLic] = 1;
        pData[playerid][pDriveLicTime] = gettime() + (15 * 86400);
        SendClientMessageEx(playerid, COLOR_ARWIN, "LICENSE: "WHITE_E"You have renewed your driver's license");     
        GivePlayerMoneyEx(playerid, -cost);
    }
    return 1;
}