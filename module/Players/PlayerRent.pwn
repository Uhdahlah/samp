#define MAX_RENT 50

enum rentveh
{
    rID,
    Float:rX,
    Float:rY,
    Float:rZ,
    Float:rRX,
    Float:rRY,
    Float:rRZ,
    Float:rRA,
    rType,
    rPickup,
	Text3D:rLabelPoint
};
new rentData[MAX_RENT][rentveh],
    Iterator:Rents<MAX_RENT>;

/*
Type 1 = Motor 
Type 2 = Vehicle Jobs
Type 3 = Boat Vehicle
*/

forward Rent_Load();
public Rent_Load()
{
	new rows = cache_num_rows(), id;
 	if(rows)
  	{
		for(new i; i < rows; i++)
		{
            cache_get_value_name_int(i, "rID", id);
		    cache_get_value_name_float(i, "rX", rentData[id][rX]);
		    cache_get_value_name_float(i, "rY", rentData[id][rY]);
		    cache_get_value_name_float(i, "rZ", rentData[id][rZ]);
		    
		    cache_get_value_name_float(i, "rRX", rentData[id][rRX]);
		    cache_get_value_name_float(i, "rRY", rentData[id][rRY]);
		    cache_get_value_name_float(i, "rRZ", rentData[id][rRZ]);
            cache_get_value_name_float(i, "rRA", rentData[id][rRA]);
            cache_get_value_name_int(i, "rType", rentData[id][rType]);	

			Rent_Refresh(id);
		}
	}
	printf("*** [Database: Loaded] rent data (%d count).", rows);
	return 1;
}

stock Rent_Save(id)
{
	new
	    query[512];

	format(query, sizeof(query), "UPDATE `rentplayer` SET `rX` = '%f', `rY` = '%f', `rZ` = '%f', `rRX` = '%f', `rRY` = '%f', `rRZ` = '%f', `rRA` = '%f', `rType` = '%d' WHERE `rID` = '%d'",
		rentData[id][rX],
        rentData[id][rY],
        rentData[id][rZ],
        rentData[id][rRX],
        rentData[id][rRY],
        rentData[id][rRZ],
        rentData[id][rRA],
        rentData[id][rType],
        id
	);
	return mysql_tquery(g_SQL, query);
}

stock Rent_Refresh(id)
{
	if(id != -1)
	{
        if(IsValidDynamicPickup(rentData[id][rPickup]))
            DestroyDynamicPickup(rentData[id][rPickup]);

        if(IsValidDynamic3DTextLabel(rentData[id][rLabelPoint]))
            DestroyDynamic3DTextLabel(rentData[id][rLabelPoint]);

		new string[212];
        format(string, sizeof(string), "{00FFFF}Pickup Rental(%d)\n"WHITE_E"Use "YELLOW_E"'/rentveh' "WHITE_E"to rent a vehicle\n"WHITE_E"Use "YELLOW_E"'/unrentveh' "WHITE_E"to return any rented vehicle", id);
        rentData[id][rPickup] = CreateDynamicPickup(1239, 23, rentData[id][rX], rentData[id][rY], rentData[id][rZ]+0.2, 0, 0, _, 8.0);
        rentData[id][rLabelPoint] = CreateDynamic3DTextLabel(string, COLOR_ARWIN, rentData[id][rX], rentData[id][rY], rentData[id][rZ]+0.5, 2.5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0, 0);
	}
}

function RentCreate(id)
{
	Rent_Save(id);
	Rent_Refresh(id);
	return 1;
}

CMD:createrent(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	new id = Iter_Free(Rents);
	if(id == -1) return Error(playerid, "You cant create more pickup rent slot empty!");
	new name, query[128];
	if(sscanf(params, "d", name)) 
    {
        Usage(playerid, "/createrent [type]");
        Info(playerid, "type 1 Bike, Type 2 Jobs Vehicle, Type 3 Boat Vehicle");
        return 1;
    }
    if(name < 1 || name > 3) return Error(playerid, "Tidak bisa di bawah 0 atau di atas 3");
	rentData[id][rType] = name;
	GetPlayerPos(playerid, rentData[id][rX], rentData[id][rY], rentData[id][rZ]);
	rentData[id][rX] = rentData[id][rX];
	rentData[id][rY] = rentData[id][rY];
	rentData[id][rZ] = rentData[id][rZ];
    rentData[id][rRX] = 0.0;
	rentData[id][rRY] = 0.0;
	rentData[id][rRZ] = 0.0;
    rentData[id][rRA] = 0.0;

	SendStaffMessage(COLOR_RED, "AdmCmd: %s telah membuat pickup rent", pData[playerid][pAdminname]);

	Iter_Add(Rents, id);
	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO rentplayer SET rID=%d, rX='%f', rY='%f', rZ='%f', rType='%d'", id, rentData[id][rX], rentData[id][rY], rentData[id][rZ], name);
	mysql_tquery(g_SQL, query, "RentCreate", "i", id);
	return 1;
}

CMD:rentedit(playerid, params[])
{
    static
        id,
        type[24],
        string[128];

    if(pData[playerid][pAdmin] < 4)
        return PermissionError(playerid);

    if(sscanf(params, "ds[24]S()[128]", id, type, string))
    {
        Usage(playerid, "/rentedit [id] [name]");
        SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} spawn, delete");
        return 1;
    }
    if((id < 0 || id >= MAX_RENT))
        return Error(playerid, "You have specified an invalid ID.");
    if(!rentData[id][rX]) return Error(playerid, "The you specified ID of doesn't exist.");
    if(!strcmp(type, "spawn", true))
    {
		GetPlayerPos(playerid, rentData[id][rRX], rentData[id][rRY], rentData[id][rRZ]);
        GetPlayerFacingAngle(playerid, rentData[id][rRA]);
        Rent_Save(id);
        Rent_Refresh(id);
        SendStaffMessage(COLOR_LRED, "AdmCmd: %s set spawn pickup point id", pData[playerid][pAdminname], id);
    }
    else if(!strcmp(type, "delete", true))
    {
        Iter_Remove(Rents, id);

        SendStaffMessage(COLOR_LRED, "AdmCmd: %s remove pickup point id", pData[playerid][pAdminname], id);
    }		
    return 1;
}

CMD:rentveh(playerid, params[])
{
    if(pData[playerid][pRents] > 0) return Error(playerid, "Anda sudah menyewa kendaraan");
    for(new id = 0 ; id < MAX_RENT; id++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 5.0, rentData[id][rX], rentData[id][rY], rentData[id][rZ]))
        {
            if(rentData[id][rType] == 1)
            {
                pData[playerid][pRentData] = id;
                new String[212], S3MP4K[212];
                strcat(S3MP4K, "Vehicle\tRent Price\n");
                format(String, sizeof(String),"%s\t$75.00/hours\n", GetVehicleModelName(462));
                strcat(S3MP4K, String);
                format(String, sizeof(String),"%s\t$50.00/hours\n", GetVehicleModelName(481));
                strcat(S3MP4K, String);
                format(String, sizeof(String),"%s\t$50.00/hours\n", GetVehicleModelName(509));
                strcat(S3MP4K, String);
                ShowPlayerDialog(playerid, DIALOG_RENTVEH, DIALOG_STYLE_TABLIST_HEADERS, "Renting Vehicle", S3MP4K, "Select", "Cancel");
            }
            if(rentData[id][rType] == 2)
            {
                pData[playerid][pRentData] = id;
                new String[212], S3MP4K[212];
                strcat(S3MP4K, "Vehicle\tRent Price\n");
                format(String, sizeof(String),"%s\t$50.00/hours\n", GetVehicleModelName(438));
                strcat(S3MP4K, String);
                format(String, sizeof(String),"%s\t$75.00/hours\n", GetVehicleModelName(420));
                strcat(S3MP4K, String);
                format(String, sizeof(String),"%s\t$70.00/hours\n", GetVehicleModelName(422));
                strcat(S3MP4K, String);
                format(String, sizeof(String),"%s\t$70.00/hours\n", GetVehicleModelName(543));
                strcat(S3MP4K, String);
                format(String, sizeof(String),"%s\t$75.00/hours\n", GetVehicleModelName(499));
                strcat(S3MP4K, String);
                ShowPlayerDialog(playerid, DIALOG_JOBSVEH, DIALOG_STYLE_TABLIST_HEADERS, "Renting Vehicle", S3MP4K, "Select", "Cancel");
            }
            if(rentData[id][rType] == 3)
            {
                pData[playerid][pRentData] = id;
                new String[212], S3MP4K[212];
                strcat(S3MP4K, "Vehicle\tRent Price\n");
                format(String, sizeof(String),"%s\t$45.00/hours\n", GetVehicleModelName(473));
                strcat(S3MP4K, String);
                format(String, sizeof(String),"%s\t$50.00/hours\n", GetVehicleModelName(453));
                strcat(S3MP4K, String);
                ShowPlayerDialog(playerid, DIALOG_BOATVEH, DIALOG_STYLE_TABLIST_HEADERS, "Renting Vehicle", S3MP4K, "Select", "Cancel");
            }
        }
    }
    return 1;
}

CMD:unrentveh(playerid, params[])
{
	for(new id = 0 ; id < MAX_RENT; id++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 5.0, rentData[id][rX], rentData[id][rY], rentData[id][rZ]))
        {
            foreach(new i : PVehicles)			
            {
                if(pvData[i][cOwner] == pData[playerid][pID])
                {
                    if(pvData[i][cRent] != 0)
                    {
                        SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"You has unrental the vehicle id %d (database id: %d).", i, pvData[i][cID]);
                        new query[128];
                        mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehicle WHERE id = '%d'", pvData[i][cID]);
                        mysql_tquery(g_SQL, query);
                        if(IsValidVehicle(pvData[i][cVeh])) DestroyVehicle(pvData[i][cVeh]);
                        Iter_SafeRemove(PVehicles, i, i);
                        pData[playerid][pRents] = -1;
                    }
                }
            }
        }
    }        
	return 1;
}
