//Fishing System

//Small
new Float:zones_points_0[] = {
    710.0,-2085.0,140.0,-2085.0,140.0,-1807.0,-246.0,-1805.0,-272.0,-1879.0,-248.0,-1941.0,-228.0,-1997.0,-230.0,-2027.0,-212.0,-2061.0,-214.0,-2095.0,
    -216.0,-2135.0,-126.0,-2353.0,26.0,-2471.0,30.0,-2511.0,66.0,-2601.0,66.0,-2663.0,64.0,-2705.0,130.0,-2619.0,142.0,-2531.0,126.0,-2437.0,
    466.0,-2439.0,994.0,-2451.0,944.0,-2271.0,822.0,-2181.0,710.0,-2085.0
};

new Float:zones_points_10[] = {
    996.0,-2453.0,590.0,-2457.0,588.0,-2521.0,568.0,-2541.0,534.0,-2547.0,502.0,-2521.0,490.0,-2475.0,324.0,-2477.0,324.0,-2539.0,458.0,-2547.0,
    378.0,-2653.0,180.0,-2725.0,68.0,-2731.0,64.0,-2905.0,266.0,-2863.0,534.0,-2863.0,592.0,-2543.0,998.0,-2541.0,794.0,-2639.0,784.0,-2749.0,
    876.0,-2773.0,884.0,-2651.0,1138.0,-2737.0,996.0,-2453.0
};
new Float:zones_points_6[] = {
    266.0, -2865.0, 766.0, -2815.0 
};

new Float:zones_points_11[] = {
	319.0, -2103.0, 435.0, -2011.0 
};
new Float:zones_points_12[] = {
	1007.0,-2362.0,1119.0,-2433.0,1179.0,-2481.0,1227.0,-2503.0,1235.0,-2549.0,1235.0,-2598.0,1236.0,-2625.0,1278.0,-2723.0,1310.0,-2748.0,1335.0,-2763.0,
	1355.0,-2818.0,1356.0,-2875.0,1353.0,-2931.0,1317.0,-2960.0,1192.0,-2969.0,1086.0,-2965.0,999.0,-2959.0,1007.0,-2362.0
};
new Float:zones_points_16[] = {
	2881.0,-2215.0,2911.0,-2167.0,2941.0,-2077.0,2943.0,-1881.0,2991.0,-1881.0,2991.0,-2219.0,2881.0,-2215.0
};
//Medium
new Float:zones_points_7[] = {
    994.0,-2453.0,128.0,-2453.0,142.0,-2531.0,130.0,-2619.0,172.0,-2711.0,366.0,-2645.0,436.0,-2559.0,214.0,-2547.0,214.0,-2461.0,994.0,-2453.0
};
new Float:zones_points_8[] = {
    996.0,-2543.0,596.0,-2545.0,530.0,-2865.0,766.0,-2867.0,912.0,-2815.0,738.0,-2751.0,700.0,-2753.0,696.0,-2663.0,996.0,-2543.0
};
new Float:zones_points_9[] = {
    886.0,-2651.0,1132.0,-2735.0,998.0,-2793.0,876.0,-2767.0,886.0,-2651.0
};
new Float:zones_points_13[] = {
	1399.0,-2785.0,2083.0,-2791.0,2221.0,-2717.0,2273.0,-2719.0,2275.0,-2969.0,1397.0,-2967.0,1399.0,-2785.0
};
new Float:zones_points_15[] = {
	2869.0,-2543.0,2867.0,-2267.0,2971.0,-2267.0,2973.0,-2537.0,2869.0,-2543.0
};
//Big
new Float:zones_points_1[] = {
    258.0, -2505.0, 43.0
};
new Float:zones_points_2[] = {
    546.0, -2505.0, 43.0
};
new Float:zones_points_3[] = {
    742.0, -2707.0, 43.0
};
new Float:zones_points_4[] = {
    370.0, -2737.0, 43.0
};
new Float:zones_points_5[] = {
    990.0, -2879.0, 43.0
};
new Float:zones_points_14[] = {
	2377.0,-2721.0,2517.0,-2727.0,2579.0,-2683.0,2573.0,-2587.0,2671.0,-2591.0,2771.0,-2599.0,2965.0,-2603.0,2963.0,-2975.0,2377.0,-2973.0,2377.0,-2721.0
};

new zones_text[FISH_ZONE][64] = {
    "Small",
    "Small",
    "Small ",
    "Medium",
    "Medium",
    "Medium",
    "Big",
    "Big",
    "Big",
    "Big",
    "Big",
    "Small",
	"Small",
	"Medium",
	"Big",
	"Medium",
	"Small"
};
new fishzone[FISH_ZONE];

IsAtFishArea(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    if(IsPlayerInRangeOfPoint(playerid,1.0,403.8266,-2088.7598,7.8359) || IsPlayerInRangeOfPoint(playerid,1.0,398.7553,-2088.7490,7.8359))
		{
		    return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid,1.0,396.2197,-2088.6692,7.8359) || IsPlayerInRangeOfPoint(playerid,1.0,391.1094,-2088.7976,7.8359))
		{
		    return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid,1.0,383.4157,-2088.7849,7.8359) || IsPlayerInRangeOfPoint(playerid,1.0,374.9598,-2088.7979,7.8359))
		{
		    return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid,1.0,369.8107,-2088.7927,7.8359) || IsPlayerInRangeOfPoint(playerid,1.0,367.3637,-2088.7925,7.8359))
		{
		    return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid,1.0,362.2244,-2088.7981,7.8359) || IsPlayerInRangeOfPoint(playerid,1.0,354.5382,-2088.7979,7.8359))
		{
		    return 1;
		}
	}
	return 0;
}

IsAtFishPlace(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    for(new i = 0; i < FISH_ZONE; i++) if(IsPlayerInDynamicArea(playerid, fishzone[i]))
		{
			return 1;
		}
	}
	return 0;
}

function FishTime(playerid)
{
	if(IsPlayerConnected(playerid) && pData[playerid][pInFish] == 1)
	{
	    new rand = RandomEx(1,12);
	    new weight = Random(40,4);
	    if(rand == 1)
	    {
	        SendClientMessageEx(playerid, COLOR_ARWIN, "FISH: "WHITE_E"Anda mendapatkan sebuah sampah dan langsung membuangannya.");
	        pData[playerid][pWorm] -= 1;
	        pData[playerid][pInFish] = 0;
	        TogglePlayerControllable(playerid, 1);
	        RemovePlayerAttachedObject(playerid, 9);
	        ClearAnimations(playerid);
			return 1;
		}
		else if(rand == 2)
		{
		    SendClientMessageEx(playerid, COLOR_ARWIN, "FISH: "WHITE_E"You get fish tuna Weighing %dlb!", weight);
		    pData[playerid][pWorm] -= 1;
	        pData[playerid][pInFish] = 0;
			pData[playerid][pFishMax] += 1;
	        TogglePlayerControllable(playerid, 1);
	        RemovePlayerAttachedObject(playerid, 9);
	        ClearAnimations(playerid);
			if(pData[playerid][pFish] == 0)
			{
				pData[playerid][pFish] += weight;
			}
			else if(pData[playerid][pFish1] == 0)
			{
				pData[playerid][pFish1] += weight;
			}
			else if(pData[playerid][pFish2] == 0)
			{
				pData[playerid][pFish2] += weight;
			}
			else if(pData[playerid][pFish3] == 0)
			{
				pData[playerid][pFish3] += weight;
			}
			else if(pData[playerid][pFish4] == 0)
			{
				pData[playerid][pFish4] += weight;
			}
			return 1;
		}
		else if(rand == 3)
		{
		    SendClientMessageEx(playerid, COLOR_ARWIN, "FISH: "WHITE_E"You get fish tongkol Weighing %dlb!", weight);
		    pData[playerid][pWorm] -= 1;
	        pData[playerid][pInFish] = 0;
			pData[playerid][pFishMax] += 1;
	        TogglePlayerControllable(playerid, 1);
	        RemovePlayerAttachedObject(playerid, 9);
	        ClearAnimations(playerid);
			if(pData[playerid][pFish] == 0)
			{
				pData[playerid][pFish] += weight;
			}
			else if(pData[playerid][pFish1] == 0)
			{
				pData[playerid][pFish1] += weight;
			}
			else if(pData[playerid][pFish2] == 0)
			{
				pData[playerid][pFish2] += weight;
			}
			else if(pData[playerid][pFish3] == 0)
			{
				pData[playerid][pFish3] += weight;
			}
			else if(pData[playerid][pFish4] == 0)
			{
				pData[playerid][pFish4] += weight;
			}
			return 1;
		}
		else if(rand == 4)
		{
		    SendClientMessageEx(playerid, COLOR_ARWIN, "FISH: "WHITE_E"You get fish kakap Weighing %dlb!", weight);
		    pData[playerid][pWorm] -= 1;
	        pData[playerid][pInFish] = 0;
			pData[playerid][pFishMax] += 1;
	        TogglePlayerControllable(playerid, 1);
	        RemovePlayerAttachedObject(playerid, 9);
	        ClearAnimations(playerid);
			if(pData[playerid][pFish] == 0)
			{
				pData[playerid][pFish] += weight;
			}
			else if(pData[playerid][pFish1] == 0)
			{
				pData[playerid][pFish1] += weight;
			}
			else if(pData[playerid][pFish2] == 0)
			{
				pData[playerid][pFish2] += weight;
			}
			else if(pData[playerid][pFish3] == 0)
			{
				pData[playerid][pFish3] += weight;
			}
			else if(pData[playerid][pFish4] == 0)
			{
				pData[playerid][pFish4] += weight;
			}
			return 1;
		}
		else if(rand == 5)
		{
		    SendClientMessageEx(playerid, COLOR_ARWIN, "FISH: "WHITE_E"You get fish kembung Weighing %dlb!", weight);
		    pData[playerid][pWorm] -= 1;
	        pData[playerid][pInFish] = 0;
			pData[playerid][pFishMax] += 1;
	        TogglePlayerControllable(playerid, 1);
	        RemovePlayerAttachedObject(playerid, 9);
	        ClearAnimations(playerid);
			if(pData[playerid][pFish] == 0)
			{
				pData[playerid][pFish] += weight;
			}
			else if(pData[playerid][pFish1] == 0)
			{
				pData[playerid][pFish1] += weight;
			}
			else if(pData[playerid][pFish2] == 0)
			{
				pData[playerid][pFish2] += weight;
			}
			else if(pData[playerid][pFish3] == 0)
			{
				pData[playerid][pFish3] += weight;
			}
			else if(pData[playerid][pFish4] == 0)
			{
				pData[playerid][pFish4] += weight;
			}
			return 1;
		}
		else if(rand == 6)
		{
		    SendClientMessageEx(playerid, COLOR_ARWIN, "FISH: "WHITE_E"You get fish makarel Weighing %dlb!", weight);
		    pData[playerid][pWorm] -= 1;
	        pData[playerid][pInFish] = 0;
			pData[playerid][pFishMax] += 1;
	        TogglePlayerControllable(playerid, 1);
	        RemovePlayerAttachedObject(playerid, 9);
	        ClearAnimations(playerid);
			if(pData[playerid][pFish] == 0)
			{
				pData[playerid][pFish] += weight;
			}
			else if(pData[playerid][pFish1] == 0)
			{
				pData[playerid][pFish1] += weight;
			}
			else if(pData[playerid][pFish2] == 0)
			{
				pData[playerid][pFish2] += weight;
			}
			else if(pData[playerid][pFish3] == 0)
			{
				pData[playerid][pFish3] += weight;
			}
			else if(pData[playerid][pFish4] == 0)
			{
				pData[playerid][pFish4] += weight;
			}
			return 1;
		}
		else if(rand == 7)
		{
		    SendClientMessageEx(playerid, COLOR_ARWIN, "FISH: "WHITE_E"You get fish tenggiri Weighing %dlb!", weight);
		    pData[playerid][pWorm] -= 1;
	        pData[playerid][pInFish] = 0;
			if(pData[playerid][pFish] == 0)
			{
				pData[playerid][pFish] += weight;
			}
			else if(pData[playerid][pFish1] == 0)
			{
				pData[playerid][pFish1] += weight;
			}
			else if(pData[playerid][pFish2] == 0)
			{
				pData[playerid][pFish2] += weight;
			}
			else if(pData[playerid][pFish3] == 0)
			{
				pData[playerid][pFish3] += weight;
			}
			else if(pData[playerid][pFish4] == 0)
			{
				pData[playerid][pFish4] += weight;
			}
			pData[playerid][pFishMax] += 1;
	        TogglePlayerControllable(playerid, 1);
	        RemovePlayerAttachedObject(playerid, 9);
	        ClearAnimations(playerid);
			return 1;
		}
		else if(rand == 8)
		{
		    SendClientMessageEx(playerid, COLOR_ARWIN, "FISH: "WHITE_E"You get fish blue marlin Weighing %dlb!", weight);
		    pData[playerid][pWorm] -= 1;
	        pData[playerid][pInFish] = 0;
			if(pData[playerid][pFish] == 0)
			{
				pData[playerid][pFish] += weight;
			}
			else if(pData[playerid][pFish1] == 0)
			{
				pData[playerid][pFish1] += weight;
			}
			else if(pData[playerid][pFish2] == 0)
			{
				pData[playerid][pFish2] += weight;
			}
			else if(pData[playerid][pFish3] == 0)
			{
				pData[playerid][pFish3] += weight;
			}
			else if(pData[playerid][pFish4] == 0)
			{
				pData[playerid][pFish4] += weight;
			}
			pData[playerid][pFishMax] += 1;
	        TogglePlayerControllable(playerid, 1);
	        RemovePlayerAttachedObject(playerid, 9);
	        ClearAnimations(playerid);
			return 1;
		}
		else if(rand == 9)
		{
		    SendClientMessageEx(playerid, COLOR_ARWIN, "FISH: "WHITE_E"You get fish sail fish Weighing %dlb!", weight);
		    pData[playerid][pWorm] -= 1;
	        pData[playerid][pInFish] = 0;
			if(pData[playerid][pFish] == 0)
			{
				pData[playerid][pFish] += weight;
			}
			else if(pData[playerid][pFish1] == 0)
			{
				pData[playerid][pFish1] += weight;
			}
			else if(pData[playerid][pFish2] == 0)
			{
				pData[playerid][pFish2] += weight;
			}
			else if(pData[playerid][pFish3] == 0)
			{
				pData[playerid][pFish3] += weight;
			}
			else if(pData[playerid][pFish4] == 0)
			{
				pData[playerid][pFish4] += weight;
			}
			pData[playerid][pFishMax] += 1;
	        TogglePlayerControllable(playerid, 1);
	        RemovePlayerAttachedObject(playerid, 9);
	        ClearAnimations(playerid);
			return 1;
		}
		else if(rand == 10)
		{
		    SendClientMessageEx(playerid, COLOR_ARWIN, "FISH: "WHITE_E"Anda tidak mendapatkan apapun.");
		    pData[playerid][pWorm] -= 1;
	        pData[playerid][pInFish] = 0;
	        TogglePlayerControllable(playerid, 1);
	        RemovePlayerAttachedObject(playerid, 9);
	        ClearAnimations(playerid);
		    return 1;
		}
		else if(rand == 11)
		{
		    SendClientMessageEx(playerid, COLOR_ARWIN, "FISH: "WHITE_E"Ikan yang sangat besar! tetapi pancingan anda terputus dan rusak.");
		    pData[playerid][pWorm] -= 1;
	        pData[playerid][pInFish] = 0;
			pData[playerid][pFishTool]--;
	        TogglePlayerControllable(playerid, 1);
	        RemovePlayerAttachedObject(playerid, 9);
	        ClearAnimations(playerid);
		    return 1;
		}
		else
		{
		    SendClientMessageEx(playerid, COLOR_ARWIN, "FISH: "WHITE_E"Anda tidak mendapatkan apapun.");
	        pData[playerid][pInFish] = 0;
	        TogglePlayerControllable(playerid, 1);
	        RemovePlayerAttachedObject(playerid, 9);
	        ClearAnimations(playerid);
		    return 1;
		}
	}
	return 0;
}

function FishTime2(playerid)
{
	if(IsPlayerConnected(playerid) && pData[playerid][pInFish] == 1)
	{
	    new rand = RandomEx(1,12);
	    new weight = Random(300,0);
	    if(rand == 1)
	    {
	        SendClientMessageEx(playerid, COLOR_ARWIN, "FISH: "WHITE_E"Anda mendapatkan sebuah sampah dan langsung membuangannya.");
	        pData[playerid][pWorm] -= 1;
	        pData[playerid][pInFish] = 0;
	        TogglePlayerControllable(playerid, 1);
	        RemovePlayerAttachedObject(playerid, 9);
	        ClearAnimations(playerid);
			return 1;
		}
		else if(rand == 2)
		{
		    SendClientMessageEx(playerid, COLOR_ARWIN, "FISH: "WHITE_E"You get fish tuna Weighing %dlb!", weight);
		    pData[playerid][pWorm] -= 1;
	        pData[playerid][pInFish] = 0;
			if(pData[playerid][pFish] == 0)
			{
				pData[playerid][pFish] += weight;
			}
			else if(pData[playerid][pFish1] == 0)
			{
				pData[playerid][pFish1] += weight;
			}
			else if(pData[playerid][pFish2] == 0)
			{
				pData[playerid][pFish2] += weight;
			}
			else if(pData[playerid][pFish3] == 0)
			{
				pData[playerid][pFish3] += weight;
			}
			else if(pData[playerid][pFish4] == 0)
			{
				pData[playerid][pFish4] += weight;
			}
			pData[playerid][pFishMax] += 1;
	        TogglePlayerControllable(playerid, 1);
	        RemovePlayerAttachedObject(playerid, 9);
	        ClearAnimations(playerid);
			return 1;
		}
		else if(rand == 3)
		{
		    SendClientMessageEx(playerid, COLOR_ARWIN, "FISH: "WHITE_E"You get fish tongkol Weighing %dlb!", weight);
		    pData[playerid][pWorm] -= 1;
	        pData[playerid][pInFish] = 0;
			if(pData[playerid][pFish] == 0)
			{
				pData[playerid][pFish] += weight;
			}
			else if(pData[playerid][pFish1] == 0)
			{
				pData[playerid][pFish1] += weight;
			}
			else if(pData[playerid][pFish2] == 0)
			{
				pData[playerid][pFish2] += weight;
			}
			else if(pData[playerid][pFish3] == 0)
			{
				pData[playerid][pFish3] += weight;
			}
			else if(pData[playerid][pFish4] == 0)
			{
				pData[playerid][pFish4] += weight;
			}
			pData[playerid][pFishMax] += 1;
	        TogglePlayerControllable(playerid, 1);
	        RemovePlayerAttachedObject(playerid, 9);
	        ClearAnimations(playerid);
			return 1;
		}
		else if(rand == 4)
		{
		    SendClientMessageEx(playerid, COLOR_ARWIN, "FISH: "WHITE_E"You get fish kakap Weighing %dlb!", weight);
		    pData[playerid][pWorm] -= 1;
	        pData[playerid][pInFish] = 0;
			if(pData[playerid][pFish] == 0)
			{
				pData[playerid][pFish] += weight;
			}
			else if(pData[playerid][pFish1] == 0)
			{
				pData[playerid][pFish1] += weight;
			}
			else if(pData[playerid][pFish2] == 0)
			{
				pData[playerid][pFish2] += weight;
			}
			else if(pData[playerid][pFish3] == 0)
			{
				pData[playerid][pFish3] += weight;
			}
			else if(pData[playerid][pFish4] == 0)
			{
				pData[playerid][pFish4] += weight;
			}
			pData[playerid][pFishMax] += 1;
	        TogglePlayerControllable(playerid, 1);
	        RemovePlayerAttachedObject(playerid, 9);
	        ClearAnimations(playerid);
			return 1;
		}
		else if(rand == 5)
		{
		    SendClientMessageEx(playerid, COLOR_ARWIN, "FISH: "WHITE_E"You get fish kembung Weighing %dlb!", weight);
		    pData[playerid][pWorm] -= 1;
	        pData[playerid][pInFish] = 0;
			if(pData[playerid][pFish] == 0)
			{
				pData[playerid][pFish] += weight;
			}
			else if(pData[playerid][pFish1] == 0)
			{
				pData[playerid][pFish1] += weight;
			}
			else if(pData[playerid][pFish2] == 0)
			{
				pData[playerid][pFish2] += weight;
			}
			else if(pData[playerid][pFish3] == 0)
			{
				pData[playerid][pFish3] += weight;
			}
			else if(pData[playerid][pFish4] == 0)
			{
				pData[playerid][pFish4] += weight;
			}
			pData[playerid][pFishMax] += 1;
	        TogglePlayerControllable(playerid, 1);
	        RemovePlayerAttachedObject(playerid, 9);
	        ClearAnimations(playerid);
			return 1;
		}
		else if(rand == 6)
		{
		    SendClientMessageEx(playerid, COLOR_ARWIN, "FISH: "WHITE_E"You get fish makarel Weighing %dlb!", weight);
		    pData[playerid][pWorm] -= 1;
	        pData[playerid][pInFish] = 0;
			if(pData[playerid][pFish] == 0)
			{
				pData[playerid][pFish] += weight;
			}
			else if(pData[playerid][pFish1] == 0)
			{
				pData[playerid][pFish1] += weight;
			}
			else if(pData[playerid][pFish2] == 0)
			{
				pData[playerid][pFish2] += weight;
			}
			else if(pData[playerid][pFish3] == 0)
			{
				pData[playerid][pFish3] += weight;
			}
			else if(pData[playerid][pFish4] == 0)
			{
				pData[playerid][pFish4] += weight;
			}
			pData[playerid][pFishMax] += 1;
	        TogglePlayerControllable(playerid, 1);
	        RemovePlayerAttachedObject(playerid, 9);
	        ClearAnimations(playerid);
			return 1;
		}
		else if(rand == 7)
		{
		    SendClientMessageEx(playerid, COLOR_ARWIN, "FISH: "WHITE_E"You get fish tenggiri Weighing %dlb!", weight);
		    pData[playerid][pWorm] -= 1;
	        pData[playerid][pInFish] = 0;
			if(pData[playerid][pFish] == 0)
			{
				pData[playerid][pFish] += weight;
			}
			else if(pData[playerid][pFish1] == 0)
			{
				pData[playerid][pFish1] += weight;
			}
			else if(pData[playerid][pFish2] == 0)
			{
				pData[playerid][pFish2] += weight;
			}
			else if(pData[playerid][pFish3] == 0)
			{
				pData[playerid][pFish3] += weight;
			}
			else if(pData[playerid][pFish4] == 0)
			{
				pData[playerid][pFish4] += weight;
			}
			pData[playerid][pFishMax] += 1;
	        TogglePlayerControllable(playerid, 1);
	        RemovePlayerAttachedObject(playerid, 9);
	        ClearAnimations(playerid);
			return 1;
		}
		else if(rand == 8)
		{
		    SendClientMessageEx(playerid, COLOR_ARWIN, "FISH: "WHITE_E"You get fish blue marlin Weighing %dlb!", weight);
		    pData[playerid][pWorm] -= 1;
	        pData[playerid][pInFish] = 0;
			if(pData[playerid][pFish] == 0)
			{
				pData[playerid][pFish] += weight;
			}
			else if(pData[playerid][pFish1] == 0)
			{
				pData[playerid][pFish1] += weight;
			}
			else if(pData[playerid][pFish2] == 0)
			{
				pData[playerid][pFish2] += weight;
			}
			else if(pData[playerid][pFish3] == 0)
			{
				pData[playerid][pFish3] += weight;
			}
			else if(pData[playerid][pFish4] == 0)
			{
				pData[playerid][pFish4] += weight;
			}
			pData[playerid][pFishMax] += 1;
	        TogglePlayerControllable(playerid, 1);
	        RemovePlayerAttachedObject(playerid, 9);
	        ClearAnimations(playerid);
			return 1;
		}
		else if(rand == 9)
		{
		    SendClientMessageEx(playerid, COLOR_ARWIN, "FISH: "WHITE_E"You get fish sail fish Weighing %dlb!", weight);
		    pData[playerid][pWorm] -= 1;
	        pData[playerid][pInFish] = 0;
			if(pData[playerid][pFish] == 0)
			{
				pData[playerid][pFish] += weight;
			}
			else if(pData[playerid][pFish1] == 0)
			{
				pData[playerid][pFish1] += weight;
			}
			else if(pData[playerid][pFish2] == 0)
			{
				pData[playerid][pFish2] += weight;
			}
			else if(pData[playerid][pFish3] == 0)
			{
				pData[playerid][pFish3] += weight;
			}
			else if(pData[playerid][pFish4] == 0)
			{
				pData[playerid][pFish4] += weight;
			}
			pData[playerid][pFishMax] += 1;
	        TogglePlayerControllable(playerid, 1);
	        RemovePlayerAttachedObject(playerid, 9);
	        ClearAnimations(playerid);
			return 1;
		}
		else if(rand == 10)
		{
		    SendClientMessageEx(playerid, COLOR_ARWIN, "FISH: "WHITE_E"Anda tidak mendapatkan apapun.");
		    pData[playerid][pWorm] -= 1;
	        pData[playerid][pInFish] = 0;
	        TogglePlayerControllable(playerid, 1);
	        RemovePlayerAttachedObject(playerid, 9);
	        ClearAnimations(playerid);
		    return 1;
		}
		else if(rand == 11)
		{
		    SendClientMessageEx(playerid, COLOR_ARWIN, "FISH: "WHITE_E"Ikan yang sangat besar! tetapi pancingan anda terputus dan rusak.");
		    pData[playerid][pWorm] -= 1;
	        pData[playerid][pInFish] = 0;
			pData[playerid][pFishTool]--;
	        TogglePlayerControllable(playerid, 1);
	        RemovePlayerAttachedObject(playerid, 9);
	        ClearAnimations(playerid);
		    return 1;
		}
		else
		{
		    SendClientMessageEx(playerid, COLOR_ARWIN, "FISH: "WHITE_E"Anda tidak mendapatkan apapun.");
	        pData[playerid][pInFish] = 0;
	        TogglePlayerControllable(playerid, 1);
	        RemovePlayerAttachedObject(playerid, 9);
	        ClearAnimations(playerid);
		    return 1;
		}
	}
	return 0;
}

CMD:fish(playerid,params[])
{
	if(pData[playerid][pDelayFishing] > 0) return Error(playerid, "Tidak bisa /fish gunakan /delay untuk mengecek");
	if(pData[playerid][pFishTool] > 0)
	{
	    if(pData[playerid][pWorm] > 0)
	    {
	        if(IsAtFishArea(playerid))
	        {
				if(pData[playerid][pInFish] == 0)
				{
					if(pData[playerid][pFishMax] >= 5)
					{
						Error(playerid, "Inventory ikan anda sudah penuh, anda dapat menjualnya terlebih dahulu.");
					}
					else
					{
						new random2 = RandomEx(30000, 60000);
						pData[playerid][pInFish] = 1;
						SetTimerEx("FishTime", random2, 0, "i",playerid);
						TogglePlayerControllable(playerid, 0);
						ApplyAnimation(playerid,"SWORD","sword_block",50.0 ,0,1,0,1,1);
	    				SetPlayerAttachedObject(playerid, 9,18632,6,0.079376,0.037070,0.007706,181.482910,0.000000,0.000000,1.000000,1.000000,1.000000);
						
					}
				}
				else
				{
				    Error(playerid, "Tunggu beberapa saat lagi.");
				    return 1;
				}
			}
			else if(IsAtFishPlace(playerid))
	        {
	        	if(pData[playerid][LevelFishing] > 100)
	        	{
					if(pData[playerid][pInFish] == 0)
					{
						if(pData[playerid][pFishMax] >= 5)
						{
							Error(playerid, "Inventory ikan anda sudah penuh, anda dapat menjualnya terlebih dahulu.");
						}
						else
						{
							new random2 = RandomEx(30000, 60000);
							pData[playerid][pInFish] = 1;
							SetTimerEx("FishTime2", random2, 0, "i",playerid);
							TogglePlayerControllable(playerid, 0);
							ApplyAnimation(playerid,"SWORD","sword_block",50.0 ,0,1,0,1,1);
		    				SetPlayerAttachedObject(playerid, 9,18632,6,0.079376,0.037070,0.007706,181.482910,0.000000,0.000000,1.000000,1.000000,1.000000);
					
						}
					}
					else
					{
					    Error(playerid, "Tunggu beberapa saat lagi.");
					    return 1;
					}
	        	}
	        	else	
	        	{
	        		Error(playerid, "Skill fishing kamu harus level 2 untuk mancing di tengah laut");
	        	}	
			}
			else
			{
				Error(playerid, "Kamu tidak berada di pemancingan atau di laut");
			}	
		}
		else
		{
			Error(playerid, "Anda tidak mempunyai umpan.");
		}
	}
	else
	{
		Error(playerid, "Anda tidak mempunyai fishing tool/pancingan.");
	}
	return 1;
}

CMD:sellallfish(playerid,params[])
{
	new String[212];
	if(pData[playerid][pFish] < 1)
		return SendClientMessageEx(playerid, COLOR_ARWIN, "You dont have fish.");
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 2844.0684,-1516.6871,11.3002)) return SendClientMessageEx(playerid, COLOR_ARWIN, "You're not at a fish shop.");
    if(StockFish >= 50000) { Info(playerid, "The fish stock in the warehouse is full."); return 1; }
    new totalfish = pData[playerid][pFish] + pData[playerid][pFish1] + pData[playerid][pFish2] + pData[playerid][pFish3] + pData[playerid][pFish4];
	format(String, sizeof(String), "Apakah kamu akan menjual ikan kamu?\n Total Berat %dlb dengan harga $%s", totalfish, FormatMoney(totalfish * FishPrice/2));
	ShowPlayerDialog(playerid,DIALOG_SELLFISH,DIALOG_STYLE_MSGBOX,"Toko Ikan",String,"Sell","Cancel");
	return 1;
}
