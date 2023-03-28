#include <YSI\y_hooks>

ptask PlayerBus[1000](playerid)
{
	if(pData[playerid][pBusWaiting] > 0 && GetVehicleModel(GetPlayerVehicleID(playerid)) == 431)
	{
		if(pData[playerid][pBusWaiting] > 0)
		{
			pData[playerid][pBusWaiting]--;
			new string[212];
			format(string,32,"~w~PLEASE WAIT~n~~y~%i SECOND",pData[playerid][pBusWaiting]);
			GameTextForPlayer(playerid, string, 2000, 6);
			PlayerPlaySound(playerid, 1186, 0, 0, 0);
			if(pData[playerid][pBusWaiting] == 0)
			{
				TogglePlayerControllable(playerid,1);
				if(BusSteps[playerid][0] == 4)
				{
					BusSteps[playerid][0] = 5;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, 1687.7946,-1626.7117,13.4835,1686.8270,-1785.6464,13.4834, 5.0);
					pData[playerid][pBusWaiting] = 0;
					return 1;
				}
				else if(BusSteps[playerid][0] == 7)
				{
					BusSteps[playerid][0] = 8;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, 1458.2944,-1869.8359,13.4872,1249.1691,-1849.7340,13.4877, 5.0);
					pData[playerid][pBusWaiting] = 0;
					return 1;
				}
				else if(BusSteps[playerid][0] == 10)
				{
					BusSteps[playerid][0] = 11;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, 1101.0165,-1710.1997,13.4831,1039.8864,-1591.9750,13.4778, 5.0);
					pData[playerid][pBusWaiting] = 0;
					return 1;
				}
				else if(BusSteps[playerid][0] == 15)
				{
					BusSteps[playerid][0] = 16;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, 1249.9329,-1402.9601,13.1006,1390.7616,-1409.5153,13.4878, 5.0);
					pData[playerid][pBusWaiting] = 0;
					return 1;
				}
				//BusRute2
				else if(BusSteps[playerid][1] == 5)
				{
					DisablePlayerRaceCheckpoint(playerid);
					BusSteps[playerid][1] = 6;
					SetPlayerRaceCheckpoint(playerid, 0, 1850.7994,-1755.0247,13.4829,1958.7798,-1810.5045,13.4897, 5);
					return 1;
				}
				else if(BusSteps[playerid][1] == 7)
				{
					DisablePlayerRaceCheckpoint(playerid);
					BusSteps[playerid][1] = 8;
					SetPlayerRaceCheckpoint(playerid, 0, 1959.5511,-1917.3839,13.4884,1986.5461,-2112.7036,13.4384, 5);
					return 1;
				}
				else if(BusSteps[playerid][1] == 12)
				{
					DisablePlayerRaceCheckpoint(playerid);
					BusSteps[playerid][1] = 13;
					SetPlayerRaceCheckpoint(playerid, 0, 2648.6423,-2407.7979,13.5692,2549.7451,-2501.4832,13.6051, 5);
					return 1;
				}
				else if(BusSteps[playerid][1] == 17)
				{
					DisablePlayerRaceCheckpoint(playerid);
					BusSteps[playerid][1] = 18;
					SetPlayerRaceCheckpoint(playerid, 0, 2179.6602,-2425.1328,13.4756,2160.9170,-2342.9050,13.4523, 5);
					return 1;
				}
				else if(BusSteps[playerid][1] == 23)
				{
					DisablePlayerRaceCheckpoint(playerid);
					BusSteps[playerid][1] = 24;
					SetPlayerRaceCheckpoint(playerid, 0, 1696.7385,-2164.0005,16.1921,1532.7091,-1961.6431,20.8978, 5);
					return 1;
				}
				else if(BusSteps[playerid][1] == 27)
				{
					DisablePlayerRaceCheckpoint(playerid);
					BusSteps[playerid][1] = 28;
					SetPlayerRaceCheckpoint(playerid, 0, 1580.5101,-1594.2743,13.4834,1679.8983,-1549.8424,13.4752, 5);
					return 1;
				}
				//BusRute3
				else if(BusSteps[playerid][2] == 5)
				{
					DisablePlayerRaceCheckpoint(playerid);
					BusSteps[playerid][2] = 6;
					SetPlayerRaceCheckpoint(playerid, 0, 1387.0702,-1804.8052,13.4834,1176.9617,-1850.1705,13.4996, 5);
					return 1;
				}
				else if(BusSteps[playerid][2] == 9)
				{
					DisablePlayerRaceCheckpoint(playerid);
					BusSteps[playerid][2] = 10;
					SetPlayerRaceCheckpoint(playerid, 0, 640.4097,-1619.6138,15.4023,640.2009,-1342.9097,13.4798, 5);
					return 1;
				}
				else if(BusSteps[playerid][2] == 11)
				{
					DisablePlayerRaceCheckpoint(playerid);
					BusSteps[playerid][2] = 12;
					SetPlayerRaceCheckpoint(playerid, 0, 651.9466,-1206.3330,18.2219,856.3155,-1023.5062,28.1525, 5);
					return 1;
				}
				else if(BusSteps[playerid][2] == 14)
				{
					DisablePlayerRaceCheckpoint(playerid);
					BusSteps[playerid][2] = 15;
					SetPlayerRaceCheckpoint(playerid, 0, 1089.5221,-959.5559,42.4178,1354.5989,-982.7267,30.3430, 5);
					return 1;
				}
				else if(BusSteps[playerid][2] == 17)
				{
					DisablePlayerRaceCheckpoint(playerid);
					BusSteps[playerid][2] = 18;
					SetPlayerRaceCheckpoint(playerid, 0, 1569.6729,-1101.1849,23.5551,1665.2031,-1162.5167,23.7775, 5);
					return 1;
				}
				//BusCD Route1
				if(BusCDSteps[playerid][0] == 6)
				{
					BusCDSteps[playerid][0] = 7;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, 2114.6199, -1426.2263, 23.9274, 2073.7935, -1191.7556, 23.7855, 5.0);
					pData[playerid][pBusWaiting] = 0;
					return 1;
				}
				else if(BusCDSteps[playerid][0] == 8)
				{
					DisablePlayerRaceCheckpoint(playerid);
					BusCDSteps[playerid][0] = 9;
					SetPlayerRaceCheckpoint(playerid, 0, 2072.3193, -1110.6896, 24.4992, 2122.5232, -1113.0942, 25.2557, 5);
					pData[playerid][pBusWaiting] = 0;
					return 1;
				}
				else if(BusCDSteps[playerid][0] == 11)
				{
					DisablePlayerRaceCheckpoint(playerid);
					BusCDSteps[playerid][0] = 12;
					SetPlayerRaceCheckpoint(playerid, 0, 2305.9785, -1154.4709, 26.8148, 2411.5713, -1180.1783, 32.0205, 5);
					pData[playerid][pBusWaiting] = 0;
					return 1;
				}
				else if(BusCDSteps[playerid][0] == 15)
				{
					DisablePlayerRaceCheckpoint(playerid);
					BusCDSteps[playerid][0] = 16;
					SetPlayerRaceCheckpoint(playerid, 0, 2720.1895, -1255.4587, 59.6616, 2720.8303, -1466.1239, 30.3814, 5);
					pData[playerid][pBusWaiting] = 0;
					return 1;
				}
				else if(BusCDSteps[playerid][0] == 19)
				{
					DisablePlayerRaceCheckpoint(playerid);
					BusCDSteps[playerid][0] = 20;
					SetPlayerRaceCheckpoint(playerid, 0, 2843.5227, -1697.3945, 10.9756, 2821.0723, -1944.2610, 11.0382, 5);
					pData[playerid][pBusWaiting] = 0;
					return 1;
				}
				else if(BusCDSteps[playerid][0] == 24)
				{
					DisablePlayerRaceCheckpoint(playerid);
					BusCDSteps[playerid][0] = 25;
					SetPlayerRaceCheckpoint(playerid, 0, 1997.9686, -2107.2495, 13.4439, 1964.2448, -2024.7606, 13.4777, 5);
					pData[playerid][pBusWaiting] = 0;
					return 1;
				}
				else if(BusCDSteps[playerid][0] == 26)
				{
					DisablePlayerRaceCheckpoint(playerid);
					BusCDSteps[playerid][0] = 27;
					SetPlayerRaceCheckpoint(playerid, 0, 1824.1331, -1909.9158, 13.4733, 1795.0150, -1887.2955, 13.4951, 5);
					return 1;
				}
				//BusRute2
				else if(BusCDSteps[playerid][1] == 7)
				{
					DisablePlayerRaceCheckpoint(playerid);
					BusCDSteps[playerid][1] = 8;
					SetPlayerRaceCheckpoint(playerid, 0, 2158.1733, -1754.5261, 13.4905, 2250.4578, -1734.3944, 13.4833, 5);
					return 1;
				}
				else if(BusCDSteps[playerid][1] == 10)
				{
					DisablePlayerRaceCheckpoint(playerid);
					BusCDSteps[playerid][1] = 11;
					SetPlayerRaceCheckpoint(playerid, 0, 2411.5051, -1797.7552, 13.4806, 2275.3528, -1969.5439, 13.4732, 5);
					return 1;
				}
				else if(BusCDSteps[playerid][1] == 12)
				{
					DisablePlayerRaceCheckpoint(playerid);
					BusCDSteps[playerid][1] = 13;
					SetPlayerRaceCheckpoint(playerid, 0, 2261.2886, -2062.5120, 13.4565, 2452.2588, -2252.1899, 25.1630, 5);
					return 1;
				}
				else if(BusCDSteps[playerid][1] == 16)
				{
					DisablePlayerRaceCheckpoint(playerid);
					BusCDSteps[playerid][1] = 17;
					SetPlayerRaceCheckpoint(playerid, 0, 2610.7310, -2501.4695, 13.5928, 2482.1812, -2597.3862, 13.5806, 5);
					return 1;
				}
				else if(BusCDSteps[playerid][1] == 22)
				{
					DisablePlayerRaceCheckpoint(playerid);
					BusCDSteps[playerid][1] = 24;
					SetPlayerRaceCheckpoint(playerid, 0, 2084.4524, -2107.4363, 13.4388, 1991.1692, -2107.9001, 13.4368, 5);
					return 1;
				}
				else if(BusCDSteps[playerid][1] == 23)
				{
					DisablePlayerRaceCheckpoint(playerid);
					BusCDSteps[playerid][1] = 24;
					SetPlayerRaceCheckpoint(playerid, 0, 2084.4524, -2107.4363, 13.4388, 1991.1692, -2107.9001, 13.4368, 5);
					return 1;
				}
			}	
		}
	}	
	return 1;
}
