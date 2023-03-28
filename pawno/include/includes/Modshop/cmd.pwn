CMD:buyvehicleacc(playerid, params[])
{
    new 
		vehid,
        models[175] = {-1, ... },
    	count
	;
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return Error(playerid, "You're not driving any vehicle!");

	vehid = Vehicle_Nearest(playerid);
    if(IsPlayerInRangeOfPoint(playerid, 4.0, 2238.6592,-2002.8824,14.2359) || IsPlayerInRangeOfPoint(playerid, 4.0, 2245.3123,-2002.9296,14.0936) || IsPlayerInRangeOfPoint(playerid, 4.0, 2252.1897,-2003.3424,14.0939) || IsPlayerInRangeOfPoint(playerid, 4.0, 2258.9844,-2003.4724,14.1051))
    {
        if(vehid != -1 && Vehicle_IsOwner(playerid, vehid)) 
        {
            for (new i; i < sizeof(VehObject); i++)
            {
                models[count++] = VehObject[i][Model];
            }
            ShowPlayerDialog(playerid, DIALOG_MODSHOP, DIALOG_STYLE_LIST, "ModShop System", "Custom Object\nCustom Text", "Okay", "Cancel");
            return 1;
        } 
        else Error(playerid, "Invalid vehicle id.");
    }    
    return 1; 
}

CMD:vehicleacc(playerid, params[])
{
    new 
		vehid,
        string[1024],
        count
	;
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return Error(playerid, "You're not driving any vehicle!");

	vehid = Vehicle_Nearest(playerid);

    if(vehid == -1)
        return Error(playerid, "Invalid vehicle id!");
    if(IsPlayerInRangeOfPoint(playerid, 4.0, 2238.6592,-2002.8824,14.2359) || IsPlayerInRangeOfPoint(playerid, 4.0, 2245.3123,-2002.9296,14.0936) || IsPlayerInRangeOfPoint(playerid, 4.0, 2252.1897,-2003.3424,14.0939) || IsPlayerInRangeOfPoint(playerid, 4.0, 2258.9844,-2003.4724,14.1051))
    {
        if(Vehicle_IsOwner(playerid, vehid))
        {
            format(string,sizeof(string),"Index\tName\n");
            for (new i = 0; i < MAX_VEHICLE_OBJECT; i++)
            {
                if(VehicleObjects[vehid][i][vehObjectExists])
                {
                    if(VehicleObjects[vehid][i][vehObjectType] == OBJECT_TYPE_BODY)
                    {
                        format(string,sizeof(string),"%s#%d\t%s\n", string, i, GetVehObjectNameByModel(VehicleObjects[vehid][i][vehObjectModel]));
                    }
                    else
                    {
                        format(string,sizeof(string),"%s#%d\t%s\n", string, i, VehicleObjects[vehid][i][vehObjectText]);
                    }

                    if (count < 5)
                    {
                        ListedVehObject[playerid][count] = i;
                        count = count + 1;
                    }
                }
            }

            if(!count) 
            {
                Error(playerid, "You don't have vehicle toys installed!");
            }
            else 
            {
                Player_EditVehicleObject[playerid] = vehid;
                Dialog_Show(playerid, EditingVehObject, DIALOG_STYLE_TABLIST_HEADERS, "Editing Vehicle Object", string, "Select","Exit");
            }
        }
    }    
    return 1;
}

CMD:addvehtext(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
        return PermissionError(playerid);
    
    static 
        vehicle;
    
    vehicle = GetPlayerVehicleID(playerid);

    if(vehicle != INVALID_VEHICLE_ID) 
    {
    	if(Vehicle_ObjectAdd(playerid, vehicle, 18661, OBJECT_TYPE_TEXT)) Info(playerid, "Sukses membuat text-object pada kendaraan id %d.", vehicle);
    	else Info(playerid, "Tidak ada slot untuk kendaraan ini lagi."); 
    	return 1;
    } 
    else Error(playerid, "Invalid vehicle id.");

    return 1;
}