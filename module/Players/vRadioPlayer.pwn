
CMD:vradio(playerid, params[])
{
    if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER) // mengambil state driver
    {
        for(new i = 0; i < 9; i++) 
        {   
            TextDrawShowForPlayer(playerid, vRadio[i]);
            PlayerTextDrawShow(playerid, vRadioPlay[playerid]);
            PlayerTextDrawShow(playerid, vRadioPause[playerid]);
            PlayerTextDrawShow(playerid, vRadioLink[playerid]);
            PlayerTextDrawShow(playerid, vRadioPlayLink[playerid]);
            PlayerTextDrawShow(playerid, vRadioClose[playerid]);
            SelectTextDraw(playerid, COLOR_RED);
        }
    }
    return 1;
}

Dialog:vRadioDialog(playerid, response, listitem, inputtext[]) 
{
    if (response) 
    {
        if(strlen(inputtext))
		{
            strpack(pData[playerid][pRadioVehicle], inputtext, 128 char);
        }
    }
    return 1;
}
