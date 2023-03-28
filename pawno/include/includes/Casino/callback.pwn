#include <YSI\y_hooks>

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys & KEY_CTRL_BACK && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) //Key H
	{             
        new index;
        if((index = Casino_Nearest(playerid)) != INVALID_CASINO_ID)
        {
            SetPlayerInsideCasino(playerid, index);
        }
        else if((index = Casino_Inside(playerid)) != INVALID_CASINO_ID)
        {
            if(IsPlayerInRangeOfPoint(playerid, 5.0, CasinoData[index][cPosIntX], CasinoData[index][cPosIntY], CasinoData[index][cPosIntZ]))
                SetPlayerOutsideCasino(playerid, index);
        }
    }
}