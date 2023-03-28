#define MAX_FURNITURE             			(200)
#define MAX_HOUSE_STRUCTURES            (300)
enum houseinfo
{
	hID,
	hOwner[MAX_PLAYER_NAME],
    hOwnerId,
	hAddress[128],
	hPrice,
	hType,
	hLocked,
	hMoney,
	hCgun,
	hWeapon[10],
	hAmmo[10],
	hInt,
	hExtVw,
	hExtInt,
	Float:hExtposX,
	Float:hExtposY,
	Float:hExtposZ,
	Float:hExtposA,
	Float:hIntposX,
	Float:hIntposY,
	Float:hIntposZ,
	Float:hIntposA,
	hGarage,
	hVisit,
	Float:hGarageposX,
	Float:hGarageposY,
	Float:hGarageposZ,
	//Not Saved
	hPickup,
	hCP,
	hGaragePickup,
	hGarageCP,
	hGarageCP2,
	Text3D:hGarageLabel,
	Text3D:hLabel,
	bool:house_Lights,
	houseBuilder,
    houseBuilderTime
};

enum houseStructure {
    structureID,
    structureModel,
    Float:structurePos[3],
    Float:structureRot[3],
    structureMaterial,
    structureColor,
    structureType,
    structureObject
};

enum e_HouseStructure {
    e_StructureName[32],
    e_StructureModel,
    e_StructureCost
};

new HouseStructure[MAX_HOUSES][MAX_HOUSE_STRUCTURES][houseStructure],
    Iterator:HouseStruct[MAX_HOUSES]<MAX_HOUSE_STRUCTURES>;

new const g_aHouseStructure[][e_HouseStructure] = {
    {"Half wall", 19428, 25},
    {"Full wall", 19355, 50},
    {"Full wall with door", 19385, 40},
    {"Full wall with window", 19401, 40},
    {"Door", 1502, 20}
};
new hData[MAX_HOUSES][houseinfo],
	Iterator: Houses<MAX_HOUSES>;
new FurnitureData[MAX_HOUSES][MAX_FURNITURE][furnitureData],
    Iterator:HouseFurnitures[MAX_HOUSES]<MAX_FURNITURE>;

new 
	ListedFurniture[MAX_PLAYERS][MAX_FURNITURE],
	ListedHouse[MAX_PLAYERS][LIMIT_PER_PLAYER+4];
new ListedStructure[MAX_PLAYERS][MAX_HOUSE_STRUCTURES];
new SelectStructureType[MAX_PLAYERS],
    SelectFurnitureType[MAX_PLAYERS];


enum houseInteriors {
    eHouseInterior,
    Float:eHouseX,
    Float:eHouseY,
    Float:eHouseZ,
    Float:eHouseAngle
};

new const Float:arrHouseInteriors[3][houseInteriors] = {
    {3, 387.78, 634.47, 1009.67, 91.58},
    {4, 431.00, 612.65, 1000.22, 89.33},
    {5, 1384.50, 1518.17, 10.95, 270.38}
};

Furniture_GetCount(houseid) {
    return Iter_Count(HouseFurnitures[houseid]);
}

Furniture_GetMaxItems(houseid) {
    new maxItems = 0;

    switch (hData[houseid][hType]) {
        case 1: maxItems = 100; // Small house
        case 2: maxItems = 150; // Medium house
        case 3: maxItems = 200; // Big house
    }

    return maxItems;
}

Furniture_Refresh(furnitureid, houseid)
{
    if(Iter_Contains(HouseFurnitures[houseid], furnitureid))
    {
        if(!IsValidDynamicObject(FurnitureData[houseid][furnitureid][furnitureObject])) {
            if(FurnitureData[houseid][furnitureid][furnitureUnused] == 0)
            {
                FurnitureData[houseid][furnitureid][furnitureObject] = CreateDynamicObject(
                    FurnitureData[houseid][furnitureid][furnitureModel],
                    FurnitureData[houseid][furnitureid][furniturePos][0],
                    FurnitureData[houseid][furnitureid][furniturePos][1],
                    FurnitureData[houseid][furnitureid][furniturePos][2],
                    FurnitureData[houseid][furnitureid][furnitureRot][0],
                    FurnitureData[houseid][furnitureid][furnitureRot][1],
                    FurnitureData[houseid][furnitureid][furnitureRot][2],
                    houseid,
                    hData[houseid][hInt]
                );
            }
        }
        Furniture_Update(furnitureid, houseid);

        foreach(new i : Player) if(IsPlayerInRangeOfPoint(i, 5, FurnitureData[houseid][furnitureid][furniturePos][0], FurnitureData[houseid][furnitureid][furniturePos][1], FurnitureData[houseid][furnitureid][furniturePos][2])) {
			Streamer_Update(i);
		}
    }
    return 1;
}

Furniture_Update(furnitureid, houseid) {
    if(Iter_Contains(HouseFurnitures[houseid], furnitureid)) {
        if (!IsValidDynamicObject(FurnitureData[houseid][furnitureid][furnitureObject]))
            return 0;

        if (FurnitureData[houseid][furnitureid][furnitureUnused] == 1) {
            DestroyDynamicObject(FurnitureData[houseid][furnitureid][furnitureObject]);
            FurnitureData[houseid][furnitureid][furnitureObject] = INVALID_STREAMER_ID;
            
            return 1;
        }

		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnitureData[houseid][furnitureid][furnitureObject], E_STREAMER_X, FurnitureData[houseid][furnitureid][furniturePos][0]);
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnitureData[houseid][furnitureid][furnitureObject], E_STREAMER_Y,FurnitureData[houseid][furnitureid][furniturePos][1]);
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnitureData[houseid][furnitureid][furnitureObject], E_STREAMER_Z, FurnitureData[houseid][furnitureid][furniturePos][2]);

		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnitureData[houseid][furnitureid][furnitureObject], E_STREAMER_R_X, FurnitureData[houseid][furnitureid][furnitureRot][0]);
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnitureData[houseid][furnitureid][furnitureObject], E_STREAMER_R_Y, FurnitureData[houseid][furnitureid][furnitureRot][1]);
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnitureData[houseid][furnitureid][furnitureObject], E_STREAMER_R_Z, FurnitureData[houseid][furnitureid][furnitureRot][2]);

		Streamer_SetIntData(STREAMER_TYPE_OBJECT, FurnitureData[houseid][furnitureid][furnitureObject], E_STREAMER_WORLD_ID, houseid);
		Streamer_SetIntData(STREAMER_TYPE_OBJECT, FurnitureData[houseid][furnitureid][furnitureObject], E_STREAMER_INTERIOR_ID, hData[houseid][hInt]);

        for(new i = 0; i != MAX_MATERIALS; i++) if(FurnitureData[houseid][furnitureid][furnitureMaterials][i] > 0) {
            SetDynamicObjectMaterial(FurnitureData[houseid][furnitureid][furnitureObject], i, 
                GetTModel(FurnitureData[houseid][furnitureid][furnitureMaterials][i]), 
                GetTXDName(FurnitureData[houseid][furnitureid][furnitureMaterials][i]), 
                GetTextureName(FurnitureData[houseid][furnitureid][furnitureMaterials][i]), 0
            );
        }

        return 1;
    }
    return 0;
}

Furniture_Save(furnitureid, houseid)
{
    static
        string[1024];

    format(string, sizeof(string), "UPDATE `furniture` SET `ID` = '%d', `furnitureModel` = '%d', `furnitureName` = '%s', `furnitureX` = '%.4f', `furnitureY` = '%.4f', `furnitureZ` = '%.4f', `furnitureRX` = '%.4f', `furnitureRY` = '%.4f', `furnitureRZ` = '%.4f', `furnitureUnused` = '%d', `furnitureMaterials` = '%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d' WHERE `furnitureID` = '%d'",
        hData[houseid][hID],
        FurnitureData[houseid][furnitureid][furnitureModel],
        FurnitureData[houseid][furnitureid][furnitureName],
        FurnitureData[houseid][furnitureid][furniturePos][0],
        FurnitureData[houseid][furnitureid][furniturePos][1],
        FurnitureData[houseid][furnitureid][furniturePos][2],
        FurnitureData[houseid][furnitureid][furnitureRot][0],
        FurnitureData[houseid][furnitureid][furnitureRot][1],
        FurnitureData[houseid][furnitureid][furnitureRot][2],
        FurnitureData[houseid][furnitureid][furnitureUnused],
        FurnitureData[houseid][furnitureid][furnitureMaterials][0],
        FurnitureData[houseid][furnitureid][furnitureMaterials][1],
        FurnitureData[houseid][furnitureid][furnitureMaterials][2],
        FurnitureData[houseid][furnitureid][furnitureMaterials][3],
        FurnitureData[houseid][furnitureid][furnitureMaterials][4],
        FurnitureData[houseid][furnitureid][furnitureMaterials][5],
        FurnitureData[houseid][furnitureid][furnitureMaterials][6],
        FurnitureData[houseid][furnitureid][furnitureMaterials][7],
        FurnitureData[houseid][furnitureid][furnitureMaterials][8],
        FurnitureData[houseid][furnitureid][furnitureMaterials][9],
        FurnitureData[houseid][furnitureid][furnitureMaterials][10],
        FurnitureData[houseid][furnitureid][furnitureMaterials][11],
        FurnitureData[houseid][furnitureid][furnitureMaterials][12],
        FurnitureData[houseid][furnitureid][furnitureMaterials][13],
        FurnitureData[houseid][furnitureid][furnitureMaterials][14],
        FurnitureData[houseid][furnitureid][furnitureMaterials][15],
        FurnitureData[houseid][furnitureid][furnitureID]
    );
    return mysql_tquery(g_SQL, string);
}

Furniture_Add(houseid, name[], modelid, Float:x, Float:y, Float:z, Float:rx = 0.0, Float:ry = 0.0, Float:rz = 0.0, unused = 1)
{
    static
        id = cellmin;

    if(!Iter_Contains(Houses, houseid))
        return 0;

    if((id = Iter_Free(HouseFurnitures[houseid])) != cellmin)
    {
        Iter_Add(HouseFurnitures[houseid], id);

        format(FurnitureData[houseid][id][furnitureName], 32, name);
        FurnitureData[houseid][id][furnitureModel] = modelid;
        FurnitureData[houseid][id][furniturePos][0] = x;
        FurnitureData[houseid][id][furniturePos][1] = y;
        FurnitureData[houseid][id][furniturePos][2] = z;
        FurnitureData[houseid][id][furnitureRot][0] = rx;
        FurnitureData[houseid][id][furnitureRot][1] = ry;
        FurnitureData[houseid][id][furnitureRot][2] = rz;
        FurnitureData[houseid][id][furnitureUnused] = unused;

        Furniture_Refresh(id, houseid);
        mysql_tquery(g_SQL, sprintf("INSERT INTO `furniture` (`ID`) VALUES('%d')", hData[houseid][hID]), "OnFurnitureCreated", "dd", id, houseid);

        return id;
    }
    return cellmin;
}

Furniture_Delete(furnitureid, houseid)
{
    if(Iter_Contains(HouseFurnitures[houseid], furnitureid))
    {
        mysql_tquery(g_SQL, sprintf("DELETE FROM `furniture` WHERE `furnitureID` = '%d'", FurnitureData[houseid][furnitureid][furnitureID]));

        if (IsValidDynamicObject(FurnitureData[houseid][furnitureid][furnitureObject])) {
            DestroyDynamicObject(FurnitureData[houseid][furnitureid][furnitureObject]);
            FurnitureData[houseid][furnitureid][furnitureObject] = INVALID_STREAMER_ID;
        }

        Iter_Remove(HouseFurnitures[houseid], furnitureid);

        new tmp_furniture[furnitureData];
        FurnitureData[houseid][furnitureid] = tmp_furniture;
    }
    return 1;
}

function OnFurnitureCreated(furnitureid, houseid)
{
    FurnitureData[houseid][furnitureid][furnitureID] = cache_insert_id();
    Furniture_Save(furnitureid, houseid);
    return 1;
}

House_IsBuilder(playerid) {
    foreach (new i : Houses) if (hData[i][houseBuilder] == pData[playerid][pID]) {
        return 1;
    }
    return 0;
}

Player_OwnsHouse(playerid, houseid)
{
	if(houseid == -1) return 0;
	if(!IsPlayerConnected(playerid)) return 0;
	if(!strcmp(hData[houseid][hOwner], pData[playerid][pName], true)) return 1;
	return 0;
}

Player_HouseCount(playerid)
{
	#if LIMIT_PER_PLAYER != 0
    new count;
	foreach(new i : Houses)
	{
		if(Player_OwnsHouse(playerid, i)) count++;
	}

	return count;
	#else
	return 0;
	#endif
}

HouseReset(houseid)
{
    if(pData[hData[houseid][hOwnerId]][pHouseOwner1] == houseid)
	{
		pData[hData[houseid][hOwnerId]][pHouseOwner1] = -1;
	}
	else
	{
		pData[hData[houseid][hOwnerId]][pHouseOwner2] = -1;
	}

	format(hData[houseid][hOwner], MAX_PLAYER_NAME, "-");
    hData[houseid][hOwnerId] = 0;
	hData[houseid][hLocked] = 1;
    hData[houseid][hMoney] = 0;
	hData[houseid][hCgun] = 0;
	hData[houseid][hWeapon] = 0;
	hData[houseid][hAmmo] = 0;
	hData[houseid][hVisit] = 0;
	hData[houseid][hGarage] = 0;

    hData[houseid][hIntposX] = 0;
	hData[houseid][hIntposY] = 0;
	hData[houseid][hIntposZ] = 0;
	hData[houseid][hIntposA] = 0;
	hData[houseid][hInt] = 0;

    HouseStructure_DeleteAll(houseid);

	for (new i = 0; i < 10; i ++)
    {
        hData[houseid][hWeapon][i] = 0;

		hData[houseid][hAmmo][i] = 0;
    }
}

House_WeaponStorage(playerid, houseid)
{
    if(houseid == -1)
        return 0;

    static
        string[320];

    string[0] = 0;

    for (new i = 0; i < 5; i ++)
    {
        if(!hData[houseid][hWeapon][i])
            format(string, sizeof(string), "%sEmpty Slot\n", string);

        else
            format(string, sizeof(string), "%s%s (Ammo: %d)\n", string, ReturnWeaponName(hData[houseid][hWeapon][i]), hData[houseid][hAmmo][i]);
    }
    ShowPlayerDialog(playerid, HOUSE_WEAPONS, DIALOG_STYLE_LIST, "Weapon Storage", string, "Select", "Cancel");
    return 1;
}

House_OpenStorage(playerid, houseid)
{
    if(houseid == -1)
        return 0;

    new
        items[1],
        string[10 * 32];

    for (new i = 0; i < 5; i ++) if(hData[houseid][hWeapon][i])
	{
        items[0]++;
    }
    if(!Player_OwnsHouse(playerid, houseid))
        format(string, sizeof(string), "Weapon Storage (%d/5)", items[0]);

    else
        format(string, sizeof(string), "Weapon Storage (%d/5)\nMoney Safe (%s)", items[0], FormatMoney(hData[houseid][hMoney]));

    ShowPlayerDialog(playerid, HOUSE_STORAGE, DIALOG_STYLE_LIST, "House Storage", string, "Select", "Cancel");
    return 1;
}

GetOwnedHouses(playerid)
{
	new tmpcount;
	foreach(new hid : Houses)
	{
	    if(!strcmp(hData[hid][hOwner], pData[playerid][pName], true))
	    {
     		tmpcount++;
		}
	}
	return tmpcount;
}

ReturnPlayerHousesID(playerid, hslot)
{
	new tmpcount;
	if(hslot < 1 && hslot > LIMIT_PER_PLAYER) return -1;
	foreach(new hid : Houses)
	{
	    if(!strcmp(pData[playerid][pName], hData[hid][hOwner], true))
	    {
     		tmpcount++;
       		if(tmpcount == hslot)
       		{
        		return hid;
  			}
	    }
	}
	return -1;
}

House_Save(houseid)
{
	new cQuery[1536];
	format(cQuery, sizeof(cQuery), "UPDATE houses SET owner='%s', ownerid='%d', address='%s', price='%d', type='%d', locked='%d', money='%d'",
	hData[houseid][hOwner],
    hData[houseid][hOwnerId],
	hData[houseid][hAddress],
	hData[houseid][hPrice],
	hData[houseid][hType],
	hData[houseid][hLocked],
	hData[houseid][hMoney]
	);

	for (new i = 0; i < 10; i ++)
	{
        format(cQuery, sizeof(cQuery), "%s, houseWeapon%d='%d', houseAmmo%d='%d'", cQuery, i + 1, hData[houseid][hWeapon][i], i + 1, hData[houseid][hAmmo][i]);
    }

	format(cQuery, sizeof(cQuery), "%s, houseint='%d', extvw='%d', extint='%d', extposx='%f', extposy='%f', extposz='%f', extposa='%f', intposx='%f', intposy='%f', intposz='%f', intposa='%f', visit='%d', garage='%d', garageposx='%f', garageposy='%f', garageposz='%f', houseBuilder = '%d', houseBuilderTime = '%d' WHERE ID='%d'",
        cQuery,
        hData[houseid][hInt],
		hData[houseid][hExtVw],
		hData[houseid][hExtInt],
        hData[houseid][hExtposX],
        hData[houseid][hExtposY],
		hData[houseid][hExtposZ],
		hData[houseid][hExtposA],
		hData[houseid][hIntposX],
		hData[houseid][hIntposY],
		hData[houseid][hIntposZ],
		hData[houseid][hIntposA],
		hData[houseid][hVisit],
		hData[houseid][hGarage],
        hData[houseid][hGarageposX],
        hData[houseid][hGarageposY],
		hData[houseid][hGarageposZ],
        hData[houseid][houseBuilder],
        hData[houseid][houseBuilderTime],
        houseid
    );
	return mysql_tquery(g_SQL, cQuery);
}

HouseStructure_Save(id, houseid) {
    if (Iter_Contains(HouseStruct[houseid], id)) {
        static
            query[600];

        format(query, sizeof(query), "UPDATE `housestruct` SET `HouseID`='%d', `Model`='%d', `PosX`='%.4f', `PosY`='%.4f', `PosZ`='%.4f', `RotX`='%.4f', `RotY`='%.4f', `RotZ`='%.4f', `Material`='%d', `Color`='%d', `Type`='%d' WHERE `ID`='%d'",
            hData[houseid][hID],
            HouseStructure[houseid][id][structureModel],
            HouseStructure[houseid][id][structurePos][0],
            HouseStructure[houseid][id][structurePos][1],
            HouseStructure[houseid][id][structurePos][2],
            HouseStructure[houseid][id][structureRot][0],
            HouseStructure[houseid][id][structureRot][1],
            HouseStructure[houseid][id][structureRot][2],
            HouseStructure[houseid][id][structureMaterial],
            HouseStructure[houseid][id][structureColor],
            HouseStructure[houseid][id][structureType],
            HouseStructure[houseid][id][structureID]
        );
        return mysql_tquery(g_SQL, query);
    }
    return 0;
}

/*House_Type(houseid)
{
	if(hData[houseid][hType] == 1)
	{
	    switch(random(3))
		{
			case 0:
			{
				hData[houseid][hIntposX] = 845.89;
				hData[houseid][hIntposY] = -2048.00;
				hData[houseid][hIntposZ] = 1476.91;
				hData[houseid][hIntposA] = 92.60;
				hData[houseid][hInt] = 1;
			}
			case 1:
			{
				hData[houseid][hIntposX] = 337.61;
				hData[houseid][hIntposY] = 1854.10;
				hData[houseid][hIntposZ] = 1002.08;
				hData[houseid][hIntposA] = 265.14;
				hData[houseid][hInt] = 1;
			}
			case 2:
			{
				hData[houseid][hIntposX] = 338.29;
				hData[houseid][hIntposY] = 1794.87;
				hData[houseid][hIntposZ] = 1002.17;
				hData[houseid][hIntposA] = 269.09;
				hData[houseid][hInt] = 1;
			}
		}
	}
	if(hData[houseid][hType] == 2)
	{
	    switch(random(3))
		{
			case 0:
			{
				hData[houseid][hIntposX] = 736.03;
				hData[houseid][hIntposY] = 1672.08;
				hData[houseid][hIntposZ] = 501.08;
				hData[houseid][hIntposA] = 356.23;
				hData[houseid][hInt] = 1;
			}
			case 1:
			{
				hData[houseid][hIntposX] = 338.78;
				hData[houseid][hIntposY] = 1734.95;
				hData[houseid][hIntposZ] = 1002.08;
				hData[houseid][hIntposA] = 268.46;
				hData[houseid][hInt] = 1;
			}
			case 2:
			{
				hData[houseid][hIntposX] = 351.59;
				hData[houseid][hIntposY] = 1669.31;
				hData[houseid][hIntposZ] = 1002.17;
				hData[houseid][hIntposA] = 176.03;
				hData[houseid][hInt] = 1;
			}
		}
	}
	if(hData[houseid][hType] == 3)
	{
	    switch(random(4))
		{
			case 0:
			{
				hData[houseid][hIntposX] = 1855.38;
				hData[houseid][hIntposY] = -1709.12;
				hData[houseid][hIntposZ] = 1720.06;
				hData[houseid][hIntposA] = 273.58;
				hData[houseid][hInt] = 1;
			}
			case 1:
			{
				hData[houseid][hIntposX] = 4577.82;
				hData[houseid][hIntposY] = -2527.82;
				hData[houseid][hIntposZ] = 5.28;
				hData[houseid][hIntposA] = 262.63;
				hData[houseid][hInt] = 1;
			}
			case 2:
			{
				hData[houseid][hIntposX] = 1263.68;
				hData[houseid][hIntposY] = -605.30;
				hData[houseid][hIntposZ] = 1001.08;
				hData[houseid][hIntposA] = 189.50;
				hData[houseid][hInt] = 1;
			}
			case 3:
			{
				hData[houseid][hIntposX] = 1224.34;
				hData[houseid][hIntposY] = -749.22;
				hData[houseid][hIntposZ] = 1085.72;
				hData[houseid][hIntposA] = 265.59;
				hData[houseid][hInt] = 1;
			}
		}
	}
}*/

House_Refresh(houseid)
{
    if(houseid != -1)
    {
        if(IsValidDynamic3DTextLabel(hData[houseid][hLabel]))
            DestroyDynamic3DTextLabel(hData[houseid][hLabel]);

        if(IsValidDynamicPickup(hData[houseid][hPickup]))
            DestroyDynamicPickup(hData[houseid][hPickup]);
			
		if(IsValidDynamicCP(hData[houseid][hCP]))
            DestroyDynamicCP(hData[houseid][hCP]);

        if(IsValidDynamic3DTextLabel(hData[houseid][hGarageLabel]))
            DestroyDynamic3DTextLabel(hData[houseid][hGarageLabel]);

        if(IsValidDynamicPickup(hData[houseid][hGaragePickup]))
            DestroyDynamicPickup(hData[houseid][hGaragePickup]);
		
		if(IsValidDynamicCP(hData[houseid][hGarageCP]))
            DestroyDynamicCP(hData[houseid][hGarageCP]);

        static
        string[255];
		
		new type[128];
		if(hData[houseid][hType] == 1)
		{
			type= "Small";
		}
		else if(hData[houseid][hType] == 2)
		{
			type= "Medium";
		}
		else if(hData[houseid][hType] == 3)
		{
			type= "Large";
		}
		else
		{
			type= "Unknown";
		}

        if(strcmp(hData[houseid][hOwner], "-"))
		{
			format(string, sizeof(string), "{00FFFF}[id:%d]\n{00FF00}Owner: {FFFFFF}%s{00FF00}\nAddress: {FFFFFF}%s", houseid, hData[houseid][hOwner], hData[houseid][hAddress]);
			hData[houseid][hPickup] = CreateDynamicPickup(19132, 23, hData[houseid][hExtposX], hData[houseid][hExtposY], hData[houseid][hExtposZ]+0.2, 0, 0, _, 10.0);
        }
        else
        {
            format(string, sizeof(string), "{00FFFF}[id:%d]\n{00FF00}This house for sell\n{FFFFFF}Addres: {FFFF00}%s\n{FFFFFF}House Type: {FFFF00}%s\n{FFFFFF}House Price: {FFFF00}$%s\n"WHITE_E"Type /buy to purchase", houseid, hData[houseid][hAddress], type, FormatMoney(hData[houseid][hPrice]));
            hData[houseid][hPickup] = CreateDynamicPickup(19132, 23, hData[houseid][hExtposX], hData[houseid][hExtposY], hData[houseid][hExtposZ]+0.2, 0, 0, _, 10.0);
        }
        hData[houseid][hLabel] = CreateDynamic3DTextLabel(string, COLOR_GREEN, hData[houseid][hExtposX], hData[houseid][hExtposY], hData[houseid][hExtposZ]+0.5, 2.5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0, 0);
		if(hData[houseid][hGarage] > 0)
		{
			new str[212];
			format(str, sizeof(str), "{00FFFF}[id:%d]\n"WHITE_E"House Garage\nAddres: "YELLOW_E"%s", houseid, GetLocation(hData[houseid][hGarageposX], hData[houseid][hGarageposY], hData[houseid][hGarageposZ]));
			hData[houseid][hGarageLabel] = CreateDynamic3DTextLabel(str, COLOR_GREEN, hData[houseid][hGarageposX], hData[houseid][hGarageposY], hData[houseid][hGarageposZ]+0.5, 2.5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0, 0);
			hData[houseid][hGaragePickup] = CreateDynamicPickup(19130, 23, hData[houseid][hGarageposX], hData[houseid][hGarageposY], hData[houseid][hGarageposZ], -1, -1);
			hData[houseid][hGarageCP] = CreateDynamicCP(hData[houseid][hGarageposX], hData[houseid][hGarageposY], hData[houseid][hGarageposZ], 2.0, -1, -1, -1, 5.0);
	
			hData[houseid][hGarageCP2] = CreateDynamicCP(405.9015, -286.3515, 993.9493, 2.0, -1, 1, -1, 5.0);
			hData[houseid][hGaragePickup] = CreateDynamicPickup(19130, 23,405.9015, -286.3515, 993.9493, -1, 1);
			//hData[houseid][hGarageLabel] = CreateDynamic3DTextLabel(str, COLOR_GREEN, 405.9015, -286.3515, 993.9493+0.5, 2.5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0, 1);
		}
		hData[houseid][house_Lights] = false;
    }
    return 1;
}

HouseStructure_Refresh(id, houseid) {
    if (Iter_Contains(HouseStruct[houseid], id)) {
        if (!IsValidDynamicObject(HouseStructure[houseid][id][structureObject])) {
            HouseStructure[houseid][id][structureObject] = CreateDynamicObject(HouseStructure[houseid][id][structureModel], HouseStructure[houseid][id][structurePos][0], HouseStructure[houseid][id][structurePos][1], HouseStructure[houseid][id][structurePos][2], HouseStructure[houseid][id][structureRot][0], HouseStructure[houseid][id][structureRot][1], HouseStructure[houseid][id][structureRot][2], houseid, hData[houseid][hInt]);
        }
        HouseStructure_ObjectUpdate(id, houseid);

        foreach (new i : Player) if (IsPlayerInRangeOfPoint(i, 5.0, HouseStructure[houseid][id][structurePos][0], HouseStructure[houseid][id][structurePos][1], HouseStructure[houseid][id][structurePos][2])) {
            Streamer_Update(i);
        }
    }
    return 1;
}

HouseStructure_ObjectUpdate(id, houseid) {
    if (Iter_Contains(HouseStruct[houseid], id)) {
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, HouseStructure[houseid][id][structureObject], E_STREAMER_X, HouseStructure[houseid][id][structurePos][0]);
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, HouseStructure[houseid][id][structureObject], E_STREAMER_Y, HouseStructure[houseid][id][structurePos][1]);
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, HouseStructure[houseid][id][structureObject], E_STREAMER_Z, HouseStructure[houseid][id][structurePos][2]);

		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, HouseStructure[houseid][id][structureObject], E_STREAMER_R_X, HouseStructure[houseid][id][structureRot][0]);
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, HouseStructure[houseid][id][structureObject], E_STREAMER_R_Y, HouseStructure[houseid][id][structureRot][1]);
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, HouseStructure[houseid][id][structureObject], E_STREAMER_R_Z, HouseStructure[houseid][id][structureRot][2]);

		Streamer_SetIntData(STREAMER_TYPE_OBJECT, HouseStructure[houseid][id][structureObject], E_STREAMER_WORLD_ID, houseid);
		Streamer_SetIntData(STREAMER_TYPE_OBJECT, HouseStructure[houseid][id][structureObject], E_STREAMER_INTERIOR_ID, hData[houseid][hInt]);
        
        if (HouseStructure[houseid][id][structureMaterial] > 0) {
            if (HouseStructure[houseid][id][structureModel] == 1502 || HouseStructure[houseid][id][structureModel] == 14414) SetDynamicObjectMaterial(HouseStructure[houseid][id][structureObject], 1, GetTModel(HouseStructure[houseid][id][structureMaterial]), GetTXDName(HouseStructure[houseid][id][structureMaterial]), GetTextureName(HouseStructure[houseid][id][structureMaterial]), HouseStructure[houseid][id][structureColor]);
            else SetDynamicObjectMaterial(HouseStructure[houseid][id][structureObject], 0, GetTModel(HouseStructure[houseid][id][structureMaterial]), GetTXDName(HouseStructure[houseid][id][structureMaterial]), GetTextureName(HouseStructure[houseid][id][structureMaterial]), HouseStructure[houseid][id][structureColor]);
        }
		return 1;
    }
    return 0;
}

CreateHouseInterior(houseid) {
    new id = cellmin;
    for (new i = 0; i < sizeof(g_aHouseInteriors); i ++) if (g_aHouseInteriors[i][e_Type] == hData[houseid][hType]) {
        id = HouseStructure_Add(houseid, g_aHouseInteriors[i][e_ObjModel], g_aHouseInteriors[i][e_ObjPosX], g_aHouseInteriors[i][e_ObjPosY], g_aHouseInteriors[i][e_ObjPosZ], g_aHouseInteriors[i][e_ObjRotX], g_aHouseInteriors[i][e_ObjRotY], g_aHouseInteriors[i][e_ObjRotZ], 1);

        if (id == cellmin) break;
    }
    return 1;
}

HouseStructure_CopyObject(id, houseid) {
    new current = HouseStructure[houseid][id][structureObject],
        model,
        Float:curPos[3],
        Float:curRot[3],
        matModel,
        txdName[32],
        textureName[32],
        matColor,
        textureID = 0;

    model = Streamer_GetIntData(STREAMER_TYPE_OBJECT, current, E_STREAMER_MODEL_ID);
    Streamer_GetFloatData(STREAMER_TYPE_OBJECT, current, E_STREAMER_X, curPos[0]);
    Streamer_GetFloatData(STREAMER_TYPE_OBJECT, current, E_STREAMER_Y, curPos[1]);
    Streamer_GetFloatData(STREAMER_TYPE_OBJECT, current, E_STREAMER_Z, curPos[2]);
    Streamer_GetFloatData(STREAMER_TYPE_OBJECT, current, E_STREAMER_R_X, curRot[0]);
    Streamer_GetFloatData(STREAMER_TYPE_OBJECT, current, E_STREAMER_R_Y, curRot[1]);
    Streamer_GetFloatData(STREAMER_TYPE_OBJECT, current, E_STREAMER_R_Z, curRot[2]);

    if (HouseStructure[houseid][id][structureMaterial] > 0) {
        GetDynamicObjectMaterial(current, 0, matModel, txdName, textureName, matColor);
        textureID = HouseStructure[houseid][id][structureMaterial];
    }

    new copyId = HouseStructure_Add(houseid, model, curPos[0], curPos[1], curPos[2], curRot[0], curRot[1], curRot[2]);

    if (copyId == cellmin)
        return cellmin;

    if (textureID != 0) SetDynamicObjectMaterial(HouseStructure[houseid][copyId][structureObject], 0, matModel, txdName, textureName, matColor), HouseStructure[houseid][copyId][structureMaterial] = textureID, HouseStructure_Save(copyId, houseid);

    return copyId;
}

HouseStructure_GetCount(houseid) {
    new count;

    foreach (new i : HouseStruct[houseid]) if (HouseStructure[houseid][i][structureType] == 0) count++;

    return count;
}

function OnLoadHouseStructure(houseid) {
    new rows = cache_num_rows(),
        id = cellmin;

    Iter_Init(HouseStruct);
    if (rows) {
        for (new i = 0; i < rows; i ++) if ((id = Iter_Free(HouseStruct[houseid])) != cellmin) {
            Iter_Add(HouseStruct[houseid], id);

            cache_get_value_int(i, "ID", HouseStructure[houseid][id][structureID]);
            cache_get_value_int(i, "Model", HouseStructure[houseid][id][structureModel]);
            cache_get_value_float(i, "PosX", HouseStructure[houseid][id][structurePos][0]);
            cache_get_value_float(i, "PosY", HouseStructure[houseid][id][structurePos][1]);
            cache_get_value_float(i, "PosZ", HouseStructure[houseid][id][structurePos][2]);
            cache_get_value_float(i, "RotX", HouseStructure[houseid][id][structureRot][0]);
            cache_get_value_float(i, "RotY", HouseStructure[houseid][id][structureRot][1]);
            cache_get_value_float(i, "RotZ", HouseStructure[houseid][id][structureRot][2]);
            cache_get_value_int(i, "Material", HouseStructure[houseid][id][structureMaterial]);
            cache_get_value_int(i, "Color", HouseStructure[houseid][id][structureColor]);
            cache_get_value_int(i, "Type", HouseStructure[houseid][id][structureType]);

            HouseStructure_Refresh(id, houseid);
        }
    }
    return 1;
}

function OnLoadFurniture(houseid)
{
    new
        rows = cache_num_rows(),
        id = cellmin,
        str[32];

    Iter_Init(HouseFurnitures);
    if (rows) {
        for (new i = 0; i != rows; i ++) if((id = Iter_Free(HouseFurnitures[houseid])) != cellmin) {
            Iter_Add(HouseFurnitures[houseid], id);

            cache_get_value(i, "furnitureName", FurnitureData[houseid][id][furnitureName], 32);
            cache_get_value_int(i, "furnitureID", FurnitureData[houseid][id][furnitureID]);
            cache_get_value_int(i, "furnitureModel", FurnitureData[houseid][id][furnitureModel]);
            cache_get_value_int(i, "furnitureUnused", FurnitureData[houseid][id][furnitureUnused]);
            cache_get_value_float(i, "furnitureX", FurnitureData[houseid][id][furniturePos][0]);
            cache_get_value_float(i, "furnitureY", FurnitureData[houseid][id][furniturePos][1]);
            cache_get_value_float(i, "furnitureZ", FurnitureData[houseid][id][furniturePos][2]);
            cache_get_value_float(i, "furnitureRX", FurnitureData[houseid][id][furnitureRot][0]);
            cache_get_value_float(i, "furnitureRY", FurnitureData[houseid][id][furnitureRot][1]);
            cache_get_value_float(i, "furnitureRZ", FurnitureData[houseid][id][furnitureRot][2]);

            cache_get_value(i, "furnitureMaterials", str, 32);
            sscanf(str, "p<|>dddddddddddddddd", 
                FurnitureData[houseid][id][furnitureMaterials][0],
                FurnitureData[houseid][id][furnitureMaterials][1],
                FurnitureData[houseid][id][furnitureMaterials][2],
                FurnitureData[houseid][id][furnitureMaterials][3],
                FurnitureData[houseid][id][furnitureMaterials][4],
                FurnitureData[houseid][id][furnitureMaterials][5],
                FurnitureData[houseid][id][furnitureMaterials][6],
                FurnitureData[houseid][id][furnitureMaterials][7],
                FurnitureData[houseid][id][furnitureMaterials][8],
                FurnitureData[houseid][id][furnitureMaterials][9],
                FurnitureData[houseid][id][furnitureMaterials][10],
                FurnitureData[houseid][id][furnitureMaterials][11],
                FurnitureData[houseid][id][furnitureMaterials][12],
                FurnitureData[houseid][id][furnitureMaterials][13],
                FurnitureData[houseid][id][furnitureMaterials][14],
                FurnitureData[houseid][id][furnitureMaterials][15]
            );

            Furniture_Refresh(id, houseid);
        }
    }
    return 1;
}

function LoadHouses()
{
    static
        str[128],
		hid;

	new rows = cache_num_rows(), owner[128], address[128];
 	if(rows)
  	{
		for(new i; i < rows; i++)
		{
			cache_get_value_name_int(i, "ID", hid);
			cache_get_value_name(i, "owner", owner);
			format(hData[hid][hOwner], 128, owner);
			cache_get_value_name(i, "address", address);
			format(hData[hid][hAddress], 128, address);
			cache_get_value_name_int(i, "price", hData[hid][hPrice]);
			cache_get_value_name_int(i, "type", hData[hid][hType]);
			cache_get_value_name_float(i, "extposx", hData[hid][hExtposX]);
			cache_get_value_name_float(i, "extposy", hData[hid][hExtposY]);
			cache_get_value_name_float(i, "extposz", hData[hid][hExtposZ]);
			cache_get_value_name_float(i, "extposa", hData[hid][hExtposA]);
			cache_get_value_name_float(i, "intposx", hData[hid][hIntposX]);
			cache_get_value_name_float(i, "intposy", hData[hid][hIntposY]);
			cache_get_value_name_float(i, "intposz", hData[hid][hIntposZ]);
			cache_get_value_name_float(i, "intposa", hData[hid][hIntposA]);
			cache_get_value_name_int(i, "houseint", hData[hid][hInt]);
			cache_get_value_name_int(i, "extvw", hData[hid][hExtVw]);
			cache_get_value_name_int(i, "extint", hData[hid][hExtInt]);
			cache_get_value_name_int(i, "money", hData[hid][hMoney]);
			cache_get_value_name_int(i, "locked", hData[hid][hLocked]);
			cache_get_value_name_int(i, "visit", hData[hid][hVisit]);
			cache_get_value_name_int(i, "garage", hData[hid][hGarage]);
			cache_get_value_name_float(i, "garageposx", hData[hid][hGarageposX]);
			cache_get_value_name_float(i, "garageposy", hData[hid][hGarageposY]);
			cache_get_value_name_float(i, "garageposz", hData[hid][hGarageposZ]);
			cache_get_value_name_int(i, "houseBuilder", hData[hid][houseBuilder]);
			cache_get_value_name_int(i, "houseBuilderTime", hData[hid][houseBuilderTime]);

			hData[hid][hID] = hid;

			format(str, sizeof(str), "SELECT * FROM `housestruct` WHERE `HouseID` = '%d'", hData[hid][hID]);
            mysql_tquery(g_SQL, str, "OnLoadHouseStructure", "d", hid);

			format(str, sizeof(str), "SELECT * FROM `furniture` WHERE `ID` = '%d'", hData[hid][hID]);
            mysql_tquery(g_SQL, str, "OnLoadFurniture", "d", hid);

			for (new j = 0; j < 10; j ++)
			{
				format(str, 24, "houseWeapon%d", j + 1);
				cache_get_value_name_int(i, str, hData[hid][hWeapon][j]);

				format(str, 24, "houseAmmo%d", j + 1);
				cache_get_value_name_int(i, str, hData[hid][hAmmo][j]);
			}
			House_Refresh(hid);
			Iter_Add(Houses, hid);
		}
		printf("*** [Database: Loaded] house data (%d count).", rows);
	}
}

HouseStructure_Add(houseid, modelid, Float:x, Float:y, Float:z, Float:rx = 0.0, Float:ry = 0.0, Float:rz = 0.0, type = 0) {
    static
        id = cellmin;

    if(!Iter_Contains(Houses, houseid))
        return 0;

    if ((id = Iter_Free(HouseStruct[houseid])) != cellmin) {
        Iter_Add(HouseStruct[houseid], id);
        
        HouseStructure[houseid][id][structureModel] = modelid;
        HouseStructure[houseid][id][structurePos][0] = x;
        HouseStructure[houseid][id][structurePos][1] = y;
        HouseStructure[houseid][id][structurePos][2] = z;
        HouseStructure[houseid][id][structureRot][0] = rx;
        HouseStructure[houseid][id][structureRot][1] = ry;
        HouseStructure[houseid][id][structureRot][2] = rz;
        HouseStructure[houseid][id][structureMaterial] = 0;
        HouseStructure[houseid][id][structureColor] = 0;
        HouseStructure[houseid][id][structureType] = type;

        HouseStructure_Refresh(id, hData[houseid][hID]);
        mysql_tquery(g_SQL, sprintf("INSERT INTO `housestruct` (`HouseID`) VALUES ('%d')", hData[houseid][hID]), "OnHouseStructureCreated", "dd", id, hData[houseid][hID]);

        return id;
    }

    return cellmin;
}

HouseStructure_DeleteAll(houseid) {
    if (Iter_Contains(Houses, houseid)) {
        foreach (new id : HouseStruct[houseid]) if (HouseStructure[houseid][id][structureType] == 0) {
            mysql_tquery(g_SQL, sprintf("DELETE FROM `housestruct` WHERE `ID`='%d'", HouseStructure[houseid][id][structureID]));

            if (IsValidDynamicObject(HouseStructure[houseid][id][structureObject])) {
                DestroyDynamicObject(HouseStructure[houseid][id][structureObject]);
                HouseStructure[houseid][id][structureObject] = INVALID_STREAMER_ID;
            }

            new tmp_houseStructure[houseStructure];
            HouseStructure[houseid][id] = tmp_houseStructure;

            new current = id;
            Iter_SafeRemove(HouseStruct[houseid], current, id);
        }
    }
    return 1;
}

HouseStructure_Delete(id, houseid) {
    if (Iter_Contains(HouseStruct[houseid], id)) {
        mysql_tquery(g_SQL, sprintf("DELETE FROM `housestruct` WHERE `ID`='%d'", HouseStructure[houseid][id][structureID]));

        if (IsValidDynamicObject(HouseStructure[houseid][id][structureObject])) {
            DestroyDynamicObject(HouseStructure[houseid][id][structureObject]);
            HouseStructure[houseid][id][structureObject] = INVALID_STREAMER_ID;
        }

        Iter_Remove(HouseStruct[houseid], id);

        new tmp_houseStructure[houseStructure];
        HouseStructure[houseid][id] = tmp_houseStructure;
    }
    return 1;
}

function OnHouseStructureCreated(id, houseid) {
    HouseStructure[houseid][id][structureID] = cache_insert_id();
    HouseStructure_Save(id, houseid);
    return 1;
}

//----------[ House Commands ]--------
//House System
CMD:createhouse(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);

	new hid = Iter_Free(Houses), address[128];
	if(hid == -1) return Error(playerid, "You cant create more door!");    
	new price, type, query[512];
	if(sscanf(params, "dd", price, type)) return Usage(playerid, "/createhouse [price] [type, 1.small 2.medium 3.Big]");
    format(hData[hid][hOwner], 128, "-");
	GetPlayerPos(playerid, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]);
	GetPlayerFacingAngle(playerid, hData[hid][hExtposA]);
	hData[hid][hExtVw] = GetPlayerVirtualWorld(playerid);
	hData[hid][hExtInt] = GetPlayerInterior(playerid);
    hData[hid][hPrice] = price;
	hData[hid][hType] = type;
	address = GetLocation(hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]);
	format(hData[hid][hAddress], 128, address);
	hData[hid][hLocked] = 1;
	hData[hid][hMoney] = 0;
	hData[hid][hIntposX] = 0;
	hData[hid][hIntposY] = 0;
	hData[hid][hIntposZ] = 0;
	hData[hid][hIntposA] = 0;
	hData[hid][hInt] = 0;
	hData[hid][hVisit] = 0;
	/*if(type == 1)
	{
		hData[hid][hPrice] = 700000;
	}
	else if(type == 2)
	{
		hData[hid][hPrice] = 1100000;
	}
	else if(type == 3)
	{
		hData[hid][hPrice] = 2000000;
	}*/
	CreateHouseInterior(hid);

	for (new i = 0; i < 10; i ++)
	{
        hData[hid][hWeapon][i] = 0;
        hData[hid][hAmmo][i] = 0;
    }
    House_Refresh(hid);
	Iter_Add(Houses, hid);

	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO houses SET ID='%d', owner='%s', price='%d', type='%d', extposx='%f', extposy='%f', extposz='%f', extposa='%f', address='%s'", hid, hData[hid][hOwner], hData[hid][hPrice], hData[hid][hType], hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ], hData[hid][hExtposA], hData[hid][hAddress]);
	mysql_tquery(g_SQL, query, "OnHousesCreated", "i", hid);
	return 1;
}

function OnHousesCreated(hid)
{
	House_Save(hid);
	return 1;
}

CMD:gotohouse(playerid, params[])
{
	new hid;
	if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);

	if(sscanf(params, "d", hid))
		return Usage(playerid, "/gotohouse [id]");
	if(!Iter_Contains(Houses, hid)) return Error(playerid, "The doors you specified ID of doesn't exist.");
	SetPlayerPosition(playerid, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ], hData[hid][hExtposA]);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
	SendClientMessageEx(playerid, COLOR_WHITE, "You has teleport to house id %d", hid);
	pData[playerid][pInDoor] = -1;
	pData[playerid][pInHouse] = -1;
	pData[playerid][pInBiz] = -1;
	return 1;
}

CMD:edithouse(playerid, params[])
{
    static
        hid,
        type[24],
        string[128];

    if(pData[playerid][pAdmin] < 6)
        return PermissionError(playerid);

    if(sscanf(params, "ds[24]S()[128]", hid, type, string))
    {
        Usage(playerid, "/edithouse [id] [name]");
        SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} location, interior, locked, owner, price, address, type, reset, delete");
        return 1;
    }
    if((hid < 0 || hid >= MAX_HOUSES))
        return Error(playerid, "You have specified an invalid ID.");
	if(!Iter_Contains(Houses, hid)) return Error(playerid, "The doors you specified ID of doesn't exist.");

    if(!strcmp(type, "location", true))
    {
		GetPlayerPos(playerid, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]);
		GetPlayerFacingAngle(playerid, hData[hid][hExtposA]);
        House_Save(hid);
		House_Refresh(hid);

        SendAdminMessage(TOMATO, "%s has adjusted the location of house ID: %d.", pData[playerid][pAdminname], hid);
    }
	else if(!strcmp(type, "interior", true))
    {
        new typeint;

        if(sscanf(string, "d", typeint))
            return Usage(playerid, "/edithouse [id] [interior] [interior 0:Small 1:Medium 2:Big]");

        if(typeint < 0 || typeint > 2)
            return Error(playerid, "The specified interior must be between 0-2.");

        hData[hid][hIntposX] = arrHouseInteriors[typeint][eHouseX];
		hData[hid][hIntposY] = arrHouseInteriors[typeint][eHouseY];
		hData[hid][hIntposZ] = arrHouseInteriors[typeint][eHouseZ];
		hData[hid][hIntposA] = arrHouseInteriors[typeint][eHouseAngle];
		hData[hid][hInt] = arrHouseInteriors[typeint][eHouseInterior];
        hData[hid][hType] = typeint+1;

        foreach (new i : HouseStruct[hid]) {
            mysql_tquery(g_SQL, sprintf("DELETE FROM `housestruct` WHERE `ID`='%d'", HouseStructure[hid][i][structureID]));

            if (IsValidDynamicObject(HouseStructure[hid][i][structureObject])) {
                DestroyDynamicObject(HouseStructure[hid][i][structureObject]);
                HouseStructure[hid][i][structureObject] = INVALID_STREAMER_ID;
            }

            new tmp_houseStructure[houseStructure];
            HouseStructure[hid][i] = tmp_houseStructure;

            new current = i;
            Iter_SafeRemove(HouseStruct[hid], current, i);
        }

        CreateHouseInterior(hid);

        foreach (new i : Player) if(pData[i][pInHouse] == hData[hid][hID])
        {
            SetPlayerPos(i, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]);
            SetPlayerFacingAngle(i, hData[hid][hIntposA]);

            SetPlayerInterior(i, hData[hid][hInt]);
            SetCameraBehindPlayer(i);
        }
        House_Save(hid);
        SendAdminMessage(COLOR_RED, "AdmCmd: %s has adjusted the interior of house ID: %d to %d.", ReturnName(playerid), hid, typeint);
    }
    else if(!strcmp(type, "locked", true))
    {
        new locked;

        if(sscanf(string, "d", locked))
            return Usage(playerid, "/edithouse [id] [locked] [0/1]");

        if(locked < 0 || locked > 1)
            return Error(playerid, "You must specify at least 0 or 1.");

        hData[hid][hLocked] = locked;
        House_Save(hid);
		House_Refresh(hid);

        if(locked) {
            SendAdminMessage(TOMATO, "%s has locked house ID: %d.", pData[playerid][pAdminname], hid);
        }
        else {
            SendAdminMessage(TOMATO, "%s has unlocked house ID: %d.", pData[playerid][pAdminname], hid);
        }
    }
    else if(!strcmp(type, "price", true))
    {
        new price;

        if(sscanf(string, "d", price))
            return Usage(playerid, "/edithouse [id] [Price] [Amount]");

        hData[hid][hPrice] = price;

        House_Save(hid);
		House_Refresh(hid);
        SendAdminMessage(TOMATO, "%s has adjusted the price of house ID: %d to %d.", pData[playerid][pAdminname], hid, price);
    }
    else if(!strcmp(type, "address", true))
    {
        new address[128];

        if(sscanf(string, "s[128]", address))
            return Usage(playerid, "/edithouse [id] [Address] [Value]");

        format(hData[hid][hAddress], 128, address);

        House_Save(hid);
		House_Refresh(hid);
        SendAdminMessage(TOMATO, "%s has adjusted the address of house ID: %d to %s.", pData[playerid][pAdminname], hid, address);
    }
	else if(!strcmp(type, "type", true))
    {
        new htype;

        if(sscanf(string, "d", htype))
            return Usage(playerid, "/edithouse [id] [Type] [1.small 2.medium 3.Big]");

        hData[hid][hType] = htype;
        House_Save(hid);
		House_Refresh(hid);
        SendAdminMessage(TOMATO, "%s has adjusted the type of house ID: %d to %d.", pData[playerid][pAdminname], hid, htype);
    }
    else if(!strcmp(type, "owner", true))
    {
        new owners[MAX_PLAYER_NAME];

        if(sscanf(string, "s[32]", owners))
            return Usage(playerid, "/edithouse [id] [owner] [player name] (use '-' to no owner)");
        
        if(pData[hData[hid][hOwnerId]][pHouseOwner1] == hid)
	    {
	    	pData[hData[hid][hOwnerId]][pHouseOwner1] = -1;
	    }
	    else
	    {
	    	pData[hData[hid][hOwnerId]][pHouseOwner2] = -1;
	    }

        format(hData[hid][hOwner], MAX_PLAYER_NAME, owners);

        House_Save(hid);
		House_Refresh(hid);
        SendAdminMessage(TOMATO, "%s has adjusted the owner of house ID: %d to %s", pData[playerid][pAdminname], hid, owners);
    }
    else if(!strcmp(type, "reset", true))
    {
        HouseReset(hid);
		House_Save(hid);
		House_Refresh(hid);
        SendAdminMessage(TOMATO, "%s has reset house ID: %d.", pData[playerid][pAdminname], hid);
    }
	else if(!strcmp(type, "garage", true))
    {
		GetPlayerPos(playerid, hData[hid][hGarageposX], hData[hid][hGarageposY], hData[hid][hGarageposZ]);
		hData[hid][hGarage] = 1;
        House_Save(hid);
		House_Refresh(hid);

        SendAdminMessage(TOMATO, "%s has adjusted the garage of house ID: %d.", pData[playerid][pAdminname], hid);
    }
	else if(!strcmp(type, "delete", true))
	{
		HouseReset(hid);

		DestroyDynamic3DTextLabel(hData[hid][hLabel]);
        DestroyDynamicPickup(hData[hid][hPickup]);
        DestroyDynamicCP(hData[hid][hCP]);

		hData[hid][hExtposX] = 0;
		hData[hid][hExtposY] = 0;
		hData[hid][hExtposZ] = 0;
		hData[hid][hExtposA] = 0;
		hData[hid][hPrice] = 0;
		hData[hid][hInt] = 0;
		hData[hid][hIntposX] = 0;
		hData[hid][hIntposY] = 0;
		hData[hid][hIntposZ] = 0;
		hData[hid][hIntposA] = 0;
		hData[hid][hLabel] = Text3D: INVALID_3DTEXT_ID;
		hData[hid][hPickup] = -1;
        HouseStructure_DeleteAll(hid);

		Iter_Remove(Houses, hid);
		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "DELETE FROM houses WHERE ID=%d", hid);
		mysql_tquery(g_SQL, query);
        SendAdminMessage(TOMATO, "%s has delete house ID: %d.", pData[playerid][pAdminname], hid);
	}
    return 1;
}

CMD:lockhouse(playerid, params[])
{
	foreach(new hid : Houses)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]))
		{
			if(!Player_OwnsHouse(playerid, hid)) return Error(playerid, "You don't own this house.");
			if(!hData[hid][hLocked])
			{
				hData[hid][hLocked] = 1;
				House_Save(hid);

                GameTextForPlayer(playerid,"~w~house ~r~locked",1000,6);
				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
			}
			else
			{
				hData[hid][hLocked] = 0;
				House_Save(hid);

                GameTextForPlayer(playerid,"~w~vehicle ~g~unlocked",5000,6);
				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
			}
		}
	}
	return 1;
}

CMD:givehouse(playerid, params[])
{
	new hid, otherid;
	
	if(pData[playerid][pLevel] < 3)
	    return Error(playerid, "Anda harus level 3 untuk bisa melalukan akses ini");
	    
	if(sscanf(params, "ud", otherid, hid)) return Usage(playerid, "/givehouse [playerid/name] [id] | /myhouse - for show info");
	if(hid == -1) return Error(playerid, "Invalid id");
	

	if(!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 4.0))
        return Error(playerid, "The specified player is disconnected or not near you.");

	if(!Player_OwnsHouse(playerid, hid)) return Error(playerid, "You dont own this id house.");

	if(pData[otherid][pVip] == 1)
	{
		#if LIMIT_PER_PLAYER > 0
		if(Player_HouseCount(otherid) + 1 > 2) return Error(playerid, "Target player cant own any more houses.");
		#endif
	}
	else if(pData[otherid][pVip] == 2)
	{
		#if LIMIT_PER_PLAYER > 0
		if(Player_HouseCount(otherid) + 1 > 3) return Error(playerid, "Target player cant own any more houses.");
		#endif
	}
	else if(pData[otherid][pVip] == 3)
	{
		#if LIMIT_PER_PLAYER > 0
		if(Player_HouseCount(otherid) + 1 > 4) return Error(playerid, "Target player cant own any more houses.");
		#endif
	}
	else
	{
		#if LIMIT_PER_PLAYER > 0
		if(Player_HouseCount(otherid) + 1 > 1) return Error(playerid, "Target player cant own any more houses.");
		#endif
	}
	GetPlayerName(otherid, hData[hid][hOwner], MAX_PLAYER_NAME);
	hData[hid][hVisit] = gettime();

    pData[otherid][pFlatOwner] = hid;
    pData[playerid][pFlatOwner] = -1;

	House_Refresh(hid);
	House_Save(hid);
	Info(playerid, "Anda memberikan rumah id: %d kepada %s", hid, ReturnName(otherid));
	Info(otherid, "%s memberikan rumah id: %d kepada anda", hid, ReturnName(playerid));
	return 1;
}

CMD:sellhouse(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 431.1708,2419.5818,356.2569)) return Error(playerid, "Anda harus berada di City Hall!");
	if(GetOwnedHouses(playerid) == -1) return Error(playerid, "You don't have a houses.");
	//if(!Player_OwnsBusiness(playerid, id)) return Error(playerid, "You don't own this business.");
	new hid, _tmpstring[128], count = GetOwnedHouses(playerid), CMDSString[1024];
	CMDSString = "";
	new lock[128];
	Loop(itt, (count + 1), 1)
	{
	    hid = ReturnPlayerHousesID(playerid, itt);
		if(hData[hid][hLocked] == 1)
		{
			lock = "{FF0000}Locked";

		}
		else
		{
			lock = "{00FF00}Unlocked";
		}
		if(itt == count)
		{
		    format(_tmpstring, sizeof(_tmpstring), ""LB_E"%d.\t{FFFF2A}%s   (%s{FFFF2A})\n", itt, hData[hid][hAddress], lock);
		}
		else format(_tmpstring, sizeof(_tmpstring), ""LB_E"%d.\t{FFFF2A}%s  (%s{FFFF2A})\n", itt, hData[hid][hAddress], lock);
		strcat(CMDSString, _tmpstring);
	}
	ShowPlayerDialog(playerid, DIALOG_SELL_HOUSES, DIALOG_STYLE_LIST, "Sell Houses", CMDSString, "Sell", "Cancel");
	return 1;
}

CMD:myhouse(playerid)
{
	if(GetOwnedHouses(playerid) == -1) return Error(playerid, "You don't have a houses.");
	//if(!Player_OwnsBusiness(playerid, id)) return Error(playerid, "You don't own this business.");
	new hid, _tmpstring[128], count = GetOwnedHouses(playerid), CMDSString[1024];
	CMDSString = "";
	new lock[128];
	Loop(itt, (count + 1), 1)
	{
	    hid = ReturnPlayerHousesID(playerid, itt);
		if(hData[hid][hLocked] == 1)
		{
			lock = ""RED_E"Dikunci";

		}
		else
		{
			lock = ""GREEN_E"Dibuka";
		}
		if(itt == count)
		{
		    format(_tmpstring, sizeof(_tmpstring), ""LB_E"%d.\t"WHITE_E"%s   (%s"WHITE_E")\n", itt, hData[hid][hAddress], lock);
		}
		else format(_tmpstring, sizeof(_tmpstring), ""LB_E"%d.\t"WHITE_E"%s  (%s"WHITE_E")\n", itt, hData[hid][hAddress], lock);
		strcat(CMDSString, _tmpstring);
	}
	ShowPlayerDialog(playerid, DIALOG_MY_HOUSES, DIALOG_STYLE_LIST, "{0000FF}Houses", CMDSString, "Select", "Cancel");
	return 1;
}

CMD:hm(playerid, params[]) {
    static
        id = -1;

    if ((id = pData[playerid][pInHouse]) != -1) {
        if (Player_OwnsHouse(playerid, id)) {
            Dialog_Show(playerid, House_Menu, DIALOG_STYLE_LIST, "House Menu", "Toggle lock\nToggle light\nStorage\nFurniture\nStructure list\nAssign Builder\nAbandon", "Select", "Cancel");
            return 1;
        }
        Error(playerid, "You must be in your house to open house menu.");
        return 1;
    }
    Error(playerid, "You must be in a house to open house menu.");
    return 1;
}

CMD:ingarage(playerid, params[])
{
	foreach(new hid : Houses)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, hData[hid][hGarageposX], hData[hid][hGarageposY], hData[hid][hGarageposZ]))
		{
			GetPlayerPos(playerid, pData[playerid][pGarageExtX], pData[playerid][pGarageExtY], pData[playerid][pGarageExtZ]);
			GetPlayerFacingAngle(playerid, pData[playerid][pGarageExtA]);
			new vehicleid = GetPlayerVehicleID(playerid);
			if(!Player_OwnsHouse(playerid, hid)) return Error(playerid, "You don't own this garage.");
			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsPlayerInAnyVehicle(playerid))
			{
				SetVehicleZAngle(vehicleid, 358.5051);
				SetVehiclePos(vehicleid, 405.9015, -286.3515, 993.9493+2.0);
				LinkVehicleToInterior(vehicleid, hid); 
			}
			else
			{
				SetPlayerPos(playerid, 405.9015, -286.3515, 993.9493+2.0);	
				SetPlayerFacingAngle(playerid, 358.5051);
			}
			pData[playerid][pInGarageH] = 1;	
			SetPlayerInterior(playerid, hid);
		}
	}
	return 1;
}

CMD:outgarage(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 2.5, 405.9015, -286.3515, 993.9493))
	{
		if(pData[playerid][pInGarageH] == 1)
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsPlayerInAnyVehicle(playerid))
			{
				SetVehiclePos(vehicleid, pData[playerid][pGarageExtX], pData[playerid][pGarageExtY], pData[playerid][pGarageExtZ]);
				SetVehicleZAngle(vehicleid, pData[playerid][pGarageExtA]);
			}
			else
			{
				SetPlayerPos(playerid, pData[playerid][pGarageExtX], pData[playerid][pGarageExtY], pData[playerid][pGarageExtZ]);
				SetPlayerFacingAngle(playerid, pData[playerid][pGarageExtA]);
			}
			LinkVehicleToInterior(vehicleid, 0); 
			SetPlayerInterior(playerid, 0);
			pData[playerid][pInGarageH] = -1;	
		}
	}
	return 1;
}

CMD:hl(playerid, params[])
{
    new bool:house, string[128];
    for(new hid = 1; hid < MAX_HOUSES; hid++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 20, hData[hid][hIntposX], hData[hid][hIntposY], hData[hid][hIntposZ]) && GetPlayerVirtualWorld(playerid) == hid)
		{
		    switch (hData[hid][house_Lights])
			{
				case false:
				{
					format(string, sizeof(string), "* %s turned on the lights in their property.", pData[playerid][pName]);
					hData[hid][house_Lights] = true;
					foreach (new i : Player)
					{
					    if(IsPlayerInRangeOfPoint(i, 50, hData[hid][hIntposX], hData[hid][hIntposY], hData[hid][hIntposZ]) && GetPlayerVirtualWorld(playerid) == hid)
						{
						    TextDrawHideForPlayer(i, HouseLight);
						    house = true;
						}
					}
					break;
				}
				case true:
				{
					format(string, sizeof(string), "* %s turned off the lights in their property.", pData[playerid][pName]);
					hData[hid][house_Lights] = false;
					foreach (new i : Player)
					{
					    if(IsPlayerInRangeOfPoint(i, 50, hData[hid][hIntposX], hData[hid][hIntposY], hData[hid][hIntposZ]) && GetPlayerVirtualWorld(playerid) == hid)
						{
                            TextDrawShowForPlayer(i, HouseLight);
                            house = true;
						}
					}
					break;
				}
			}
		}
	}
	if (house) SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, string);
    if (!house) return Error(playerid, "You are not in inside a house!");
	return 1;
}

CMD:dyoh(playerid, params[]) {
    static
        id = -1;

    if (pData[playerid][pJob] != 9 && pData[playerid][pJob2] != 9)
        return Error(playerid, "You're not a Builder!");

    if ((id = pData[playerid][pInHouse]) != -1) {
        if (hData[id][houseBuilder] == pData[playerid][pID] || Player_OwnsHouse(playerid, id)) {
            Dialog_Show(playerid, House_Structure, DIALOG_STYLE_LIST, "House Structure", "Add structure\nMove structure\nRetexture structure\nDestroy structure\nCopy structure\nDestroy all structure\nStructure list\nMove furniture\nDestroy furniture\nStore furniture\nFurniture list", "Select", "Back");
            return 1;
        }
        Error(playerid, "You don't have any permission to access this house structures");
        return 1;
    }
    Error(playerid, "You're not in any house.");
    return 1;
}

Dialog:House_Menu(playerid, response, listitem, inputtext[]) {
    if (response) {
        new id = pData[playerid][pInHouse];
        if (id != -1) {
            switch (listitem) {
                case 0: {
                    if(!hData[id][hLocked]) {
                        hData[id][hLocked] = 0;
                        House_Save(id);

                        GameTextForPlayer(playerid,"~w~house ~r~locked",1000,6);
                        PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
                        callcmd::hm(playerid, "\0");
                    } else {
                        hData[id][hLocked] = 1;
                        House_Save(id);

                        GameTextForPlayer(playerid,"~w~house ~g~locked",1000,6);
                        PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
                        callcmd::hm(playerid, "\0");
                    }
                }
                case 1: {
                    if(hData[id][house_Lights]) {
                        foreach (new i : Player) if(pData[i][pInHouse] == id) {
                            TextDrawShowForPlayer(i, HouseLight);
                        }
                        SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s flicks the light switch off.", ReturnName(playerid));
                        hData[id][house_Lights] = false;
                        callcmd::hm(playerid, "\0");
                    } else {
                        foreach (new i : Player) if(pData[i][pInHouse] == id) {
                            TextDrawHideForPlayer(i, HouseLight);
                        }
                        SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s flicks the light switch on.", ReturnName(playerid));
                        hData[id][house_Lights] = true;
                        callcmd::hm(playerid, "\0");
                    }
                }
                case 2: House_OpenStorage(playerid, id);
                case 3: {
                    new
                        count = 0,
                        string[MAX_FURNITURE * 64];

                    if(!Furniture_GetCount(id))
                        return Error(playerid, "This house doesn't have any furniture spawned.");

                    strcat(string, "Model\tDistance\n");
                    foreach (new i : HouseFurnitures[id])
                    {
                        if(FurnitureData[id][i][furnitureUnused]) 
                            strcat(string, sprintf("%s\t(Not placed)\n", FurnitureData[id][i][furnitureName]));
                        else 
                            strcat(string, sprintf("%s\t%.2f\n", FurnitureData[id][i][furnitureName], GetPlayerDistanceFromPoint(playerid, FurnitureData[id][i][furniturePos][0], FurnitureData[id][i][furniturePos][1], FurnitureData[id][i][furniturePos][2])));

                        ListedFurniture[playerid][count++] = i;
                    }
                    Dialog_Show(playerid, ListedFurniture, DIALOG_STYLE_TABLIST_HEADERS, "House Furniture", string, "Select", "Cancel");
                }
                case 4: {
                    new
                        string[MAX_HOUSE_STRUCTURES * 128];

                    if(!HouseStructure_GetCount(id))
                        return Error(playerid, "This house doesn't have any structures.");

                    SendClientMessage(playerid, COLOR_RED, "WARNING: "YELLOW_E"This option is only show your house structure, if you want to edit structure use '/dyoh'");

                    strcat(string, "Model\tDistance\n");
                    foreach (new i : HouseStruct[id]) {
                        if (HouseStructure[id][i][structureType] > 0) strcat(string, sprintf(ORANGE_E"Static\t%.2f\n", GetPlayerDistanceFromPoint(playerid, HouseStructure[id][i][structurePos][0], HouseStructure[id][i][structurePos][1], HouseStructure[id][i][structurePos][2])));
                        else strcat(string, sprintf("%s\t%.2f\n", GetStructureNameByModel(HouseStructure[id][i][structureModel]), GetPlayerDistanceFromPoint(playerid, HouseStructure[id][i][structurePos][0], HouseStructure[id][i][structurePos][1], HouseStructure[id][i][structurePos][2])));
                    }
                    Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, "House Structure", string, "Close", "");
                }
                case 5: {
                    if (hData[id][houseBuilder]) Dialog_Show(playerid, House_FiredBuilder, DIALOG_STYLE_MSGBOX, "Fired Builder", WHITE_E"Your house is already assigned a Builder the contract will be expire on "GREEN_E"%s"WHITE_E", do you want to fired them?", "Yes", "Back", ConvertTimestamp(Time:hData[id][houseBuilderTime]));
                    else Dialog_Show(playerid, House_AssignBuilder, DIALOG_STYLE_INPUT, "House Assign Builder", "Please input the playerid or name:", "Assign", "Back");
                }
                case 6: Dialog_Show(playerid, House_Abandon, DIALOG_STYLE_MSGBOX, "House Abandon", "Are you sure want to abandon your house?", "Sure", "Back");
            }
        }
    }
    return 1;
}

House_RemoveFurniture(houseid)
{
    if(Iter_Contains(Houses, houseid))
    {
        foreach (new furnitureid : HouseFurnitures[houseid]) {
            mysql_tquery(g_SQL, sprintf("DELETE FROM `furniture` WHERE `furnitureID` = '%d'", FurnitureData[houseid][furnitureid][furnitureID]));

            if (IsValidDynamicObject(FurnitureData[houseid][furnitureid][furnitureObject])) {
                DestroyDynamicObject(FurnitureData[houseid][furnitureid][furnitureObject]);
                FurnitureData[houseid][furnitureid][furnitureObject] = INVALID_STREAMER_ID;
            }

            new tmp_furniture[furnitureData];
            FurnitureData[houseid][furnitureid] = tmp_furniture;

            new current = furnitureid;
            Iter_SafeRemove(HouseFurnitures[houseid], current, furnitureid);
        }
    }
    return 1;
}

Dialog:House_Abandon(playerid, response, listitem, inputtext[]) {
    new id = pData[playerid][pInHouse];
    if (id != -1) {
        if (response) {
            House_RemoveFurniture(id);
            HouseStructure_DeleteAll(id);
            House_Refresh(id);
            House_Save(id);

            SendCustomMessage(playerid, "HOUSE", "You have abandoned your house: %s.", hData[id][hAddress]);
        }
    } else callcmd::hm(playerid, "\0");
    return 1;
}

Dialog:House_AssignBuilder(playerid, response, listitem, inputtext[]) {
    new houseid = pData[playerid][pInHouse];

    if (houseid != -1) {
        if (response) {
            new userid;
            if (isnull(inputtext))
                return Dialog_Show(playerid, House_AssignBuilder, DIALOG_STYLE_INPUT, "House Assign Builder", "Please input the playerid or name:", "Assign", "Back"), Error(playerid, "Invalid input!");

            if (sscanf(inputtext, "u", userid))
                return Dialog_Show(playerid, House_AssignBuilder, DIALOG_STYLE_INPUT, "House Assign Builder", "Please input the playerid or name:", "Assign", "Back"), Error(playerid, "Invalid input!");

            if (!IsPlayerConnected(userid))
                return Error(playerid, "Invalid playerid or name!");

            if (userid == playerid)
                return Error(playerid, "Cannot assign yourself");

            if (pData[userid][pJob] != 9 && pData[userid][pJob2] != 9)
                return Error(playerid, "That player are not a Bulder");

            hData[houseid][houseBuilder] = pData[userid][pID];
            hData[houseid][houseBuilderTime] = (gettime()+((24*3600)*7));
            SendCustomMessage(playerid, "HOUSE", "You've been assigned "YELLOW_E"%s "WHITE_E"as your house builder, it will automatically fired for 7 days.", ReturnName(userid));
            SendCustomMessage(userid, "HOUSE", ""YELLOW_E"%s "WHITE_E"has assigned you as house builder.", ReturnName(playerid));
        }
    }
    return 1;
}

Dialog:House_FiredBuilder(playerid, response, listitem, inputtext[]) {
    if (!response)
        return callcmd::hm(playerid, "\0");
    
    new houseid = pData[playerid][pInHouse];
    if (houseid != -1) {
        hData[houseid][houseBuilder] = 0;
        hData[houseid][houseBuilderTime] = 0;
        SendCustomMessage(playerid, "HOUSE", "You've been fired your house builder.");
    }
    return 1;
}

// CMD:hm(playerid, params[])
// {
// 	House_OpenStorage(playerid, pData[playerid][pInHouse]);
//     Dialog_Show(playerid, House_Menu, DIALOG_STYLE_LIST, "House Menu", "Toggle lock\nToggle light\nStorage\nFurniture\nStructure list\nAssign Builder\nAbandon", "Select", "Cancel");
//     return 1;
// }

Dialog:ListedFurniture(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new id = pData[playerid][pInHouse];

        if(id != -1 && (Player_OwnsHouse(playerid, id) || hData[id][houseBuilder] == pData[playerid][pID]))
        {
            pData[playerid][pEditFurniture] = ListedFurniture[playerid][listitem];
            pData[playerid][pEditFurnHouse] = id;
            Dialog_Show(playerid, FurnitureList, DIALOG_STYLE_LIST, FurnitureData[id][pData[playerid][pEditFurniture]][furnitureName], "Edit Position\nMove to in front me\nDestroy Furniture\nStore Furniture", "Select", "Cancel");
        }
    }
    return 1;
}

Dialog:FurnitureList(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new id = pData[playerid][pInHouse],
            Float:x,
            Float:y,
            Float:z,
            Float:angle;

        GetPlayerPos(playerid, x, y, z);
        GetPlayerFacingAngle(playerid, angle);

        x += 1.0 * floatsin(-angle, degrees);
        y += 1.0 * floatcos(-angle, degrees);

        if(id != -1 && (Player_OwnsHouse(playerid, id) || hData[id][houseBuilder] == pData[playerid][pID]))
        {
            switch (listitem)
            {
                case 0:
                {
                    new furnitureid = pData[playerid][pEditFurniture];

                    pData[playerid][pEditingMode] = 4;

                    if(FurnitureData[id][furnitureid][furnitureUnused])
                    {
                        FurnitureData[id][furnitureid][furnitureUnused] = 0;
                        FurnitureData[id][furnitureid][furniturePos][0] = x;
                        FurnitureData[id][furnitureid][furniturePos][1] = y;
                        FurnitureData[id][furnitureid][furniturePos][2] = z;
                        FurnitureData[id][furnitureid][furnitureRot][0] = 0.0;
                        FurnitureData[id][furnitureid][furnitureRot][1] = 0.0;
                        FurnitureData[id][furnitureid][furnitureRot][2] = angle;

                        Furniture_Refresh(furnitureid, id);
                    }
                    EditDynamicObject(playerid, FurnitureData[id][furnitureid][furnitureObject]);
                    SendCustomMessage(playerid, "HOUSE", "You are now editing the position of item \"%s"WHITE_E"\".", FurnitureData[id][furnitureid][furnitureName]);
                }
                case 1:
                {
                    new furnitureid = pData[playerid][pEditFurniture];

                    if(FurnitureData[id][pData[playerid][pEditFurniture]][furnitureUnused])
                        return Error(playerid, "Attach this furniture first by select option \"Editing Position\"");

                    FurnitureData[id][furnitureid][furnitureUnused] = 0;
                    FurnitureData[id][furnitureid][furniturePos][0] = x;
                    FurnitureData[id][furnitureid][furniturePos][1] = y;
                    FurnitureData[id][furnitureid][furniturePos][2] = z;
                    FurnitureData[id][furnitureid][furnitureRot][0] = 0.0;
                    FurnitureData[id][furnitureid][furnitureRot][1] = 0.0;
                    FurnitureData[id][furnitureid][furnitureRot][2] = angle;

                    SetDynamicObjectPos(FurnitureData[id][furnitureid][furnitureObject], FurnitureData[id][furnitureid][furniturePos][0], FurnitureData[id][furnitureid][furniturePos][1], FurnitureData[id][furnitureid][furniturePos][2]);
                    SetDynamicObjectRot(FurnitureData[id][furnitureid][furnitureObject], FurnitureData[id][furnitureid][furnitureRot][0], FurnitureData[id][furnitureid][furnitureRot][1], FurnitureData[id][furnitureid][furnitureRot][2]);
                    Furniture_Refresh(furnitureid, id);
                    Furniture_Save(furnitureid, id);
                    SendCustomMessage(playerid, "HOUSE", "Now this furniture is moved to in front you.");
                }
                case 2:
                {
                    SendCustomMessage(playerid, "HOUSE", "You have destroyed furniture \"%s"WHITE_E"\".", FurnitureData[id][pData[playerid][pEditFurniture]][furnitureName]);
                    Furniture_Delete(pData[playerid][pEditFurniture], id);

                    CancelEdit(playerid);
                    pData[playerid][pEditFurniture] = -1;
                    pData[playerid][pEditFurnHouse] = -1;
                }
                case 3: {
                    new furnitureid = pData[playerid][pEditFurniture];

                    if (FurnitureData[id][furnitureid][furnitureUnused])
                        return Error(playerid, "This furniture is already stored");
                    
                    FurnitureData[id][furnitureid][furnitureUnused] = 1;
                    Furniture_Refresh(furnitureid, id);
                    Furniture_Save(furnitureid, id);
                    SendCustomMessage(playerid, "HOUSE", "You have stored furniture \"%s"WHITE_E"\" into your house.", FurnitureData[id][furnitureid][furnitureName]);
                }
            }
        }
        else {
            pData[playerid][pEditFurniture] = -1;
            pData[playerid][pEditFurnHouse] = -1;
        }
    }
    else {
        pData[playerid][pEditFurniture] = -1;
        pData[playerid][pEditFurnHouse] = -1;
    }
    return 1;
}

Dialog:ListedStructure(playerid, response, listitem, inputtext[]) {
    if (response) {
        new id = pData[playerid][pInHouse];

        if (id != -1 && (Player_OwnsHouse(playerid, id) || hData[id][houseBuilder] == pData[playerid][pID])) {
            pData[playerid][pEditStructure] = ListedStructure[playerid][listitem];
            pData[playerid][pEditHouseStructure] = id;
            Dialog_Show(playerid, StructureList, DIALOG_STYLE_LIST, "House Structure: Edit", "Move\nRetexture\nCopy\nDestroy", "Select", "Back");
        }
    } else callcmd::dyoh(playerid, "\0");
    return 1;
}

Dialog:StructureList(playerid, response, listitem, inputtext[]) {
    if (response) {
        new houseid = pData[playerid][pInHouse], id = pData[playerid][pEditStructure];

        if (houseid != -1) {
            switch (listitem) {
                case 0: {
                    if (HouseStructure[houseid][id][structureType] > 0)
                        return Error(playerid, "Cannot move static house structure.");

                    pData[playerid][pEditingMode] = 3;
                    pData[playerid][pEditHouseStructure] = houseid;
                    EditDynamicObject(playerid, HouseStructure[houseid][id][structureObject]);
                    SendCustomMessage(playerid, "HOUSE", "You're now editing %s.", GetStructureNameByModel(HouseStructure[houseid][id][structureModel]));
                }
                case 1: {
                    SetPVarInt(playerid, "structureObj", id);
                    pData[playerid][pEditHouseStructure] = houseid;
                    Dialog_Show(playerid, House_StructureRetexture, DIALOG_STYLE_INPUT, "Retexture House Structure", "Please input the texture name below:\n"YELLOW_E"[model] [txdname] [texture] [opt: alpha] [opt: red] [opt: green] [opt: blue]", "Retexture", "Cancel");
                }
                case 2: {
                    if (HouseStructure[houseid][id][structureType] > 0)
                        return Error(playerid, "Cannot copy static house structure.");
                    
                    new price;

                    for (new i = 0; i < sizeof(g_aHouseStructure); i ++) if (g_aHouseStructure[i][e_StructureModel] == HouseStructure[houseid][id][structureModel]) {
                        price = g_aHouseStructure[i][e_StructureCost];
                    }

                    if (pData[playerid][pComponent] < price)
                        return Error(playerid, "You need %d Component(s) to copy this structure.", price);

                    new copyId = HouseStructure_CopyObject(id, houseid);

                    if (copyId == cellmin)
                        return Error(playerid, "Your house has reached maximum of structure");

                    pData[playerid][pComponent] -= price;
                    pData[playerid][pEditStructure] = copyId;
                    pData[playerid][pEditingMode] = 3;
                    pData[playerid][pEditHouseStructure] = houseid;
                    EditDynamicObject(playerid, HouseStructure[houseid][copyId][structureObject]);
                    SendCustomMessage(playerid, "BUILDER", "You have copied structure for "GREEN_E"%d component(s)", price);
                    SendCustomMessage(playerid, "BUILDER", "You're now editing copied object of %s.", GetStructureNameByModel(HouseStructure[houseid][id][structureModel]));
                }
                case 3: {
                    if (HouseStructure[houseid][id][structureType] > 0)
                        return Error(playerid, "Cannot destroy static house structure.");

                    SendCustomMessage(playerid, "HOUSE", "You've been successfully deleted %s", GetStructureNameByModel(HouseStructure[houseid][id][structureModel]));
                    HouseStructure_Delete(id, houseid);
                }
            }
        }
    } else callcmd::dyoh(playerid, "\0");
    return 1;
}

Dialog:House_Structure(playerid, response, listitem, inputtext[]) {
    if (response) {
        new id = pData[playerid][pInHouse];
        if (id != -1) {
            switch (listitem) {
                case 0: {
                    new str[128];
                    strcat(str, "Type\tCost (components)\n");
                    for (new i = 0; i < sizeof(g_aHouseStructure); i ++) {
                        strcat(str, sprintf("%s\t%d\n", g_aHouseStructure[i][e_StructureName], g_aHouseStructure[i][e_StructureCost]));
                    }
                    Dialog_Show(playerid, House_StructureAdd, DIALOG_STYLE_TABLIST_HEADERS, "House Structure Modification", str, "Select", "Back");
                }
                case 1: {
                    pData[playerid][pEditHouseStructure] = id;
                    SelectStructureType[playerid] = STRUCTURE_SELECT_EDITOR;
                    SelectObject(playerid);
                    SendCustomMessage(playerid, "BUILDER", "Please select the structure, you wish to move.");
                }
                case 2: {
                    pData[playerid][pEditHouseStructure] = id;
                    SelectStructureType[playerid] = STRUCTURE_SELECT_RETEXTURE;
                    SelectObject(playerid);
                    SendCustomMessage(playerid, "BUILDER", "Please select the structure, you wish to retexture.");
                }
                case 3: {
                    pData[playerid][pEditHouseStructure] = id;
                    SelectStructureType[playerid] = STRUCTURE_SELECT_DELETE;
                    SelectObject(playerid);
                    SendCustomMessage(playerid, "BUILDER", "Please select the structure, you wish to destroy.");
                }
                case 4: {
                    pData[playerid][pEditHouseStructure] = id;
                    SelectStructureType[playerid] = STRUCTURE_SELECT_COPY;
                    SelectObject(playerid);
                    SendCustomMessage(playerid, "BUILDER", "Please select the structure, you wish to copy.");
                }
                case 5: {
                    if (!HouseStructure_GetCount(id))
                        return Error(playerid, "There are no structures in this house.");
                    
                    pData[playerid][pEditHouseStructure] = id;
                    Dialog_Show(playerid, House_StructureDestroy, DIALOG_STYLE_MSGBOX, "Destroy All Structures", RED_E"WARNING:\n"WHITE_E"Are you sure you want to destroy all structures in this house?", "Yes", "No");
                }
                case 6: {
                    pData[playerid][pEditHouseStructure] = id;
                    Dialog_Show(playerid, House_StructureType, DIALOG_STYLE_LIST, "Structure Type", "Static\nCostum", "Select", "Cancel");
                }
                case 7: {
                    pData[playerid][pEditFurnHouse] = id;
                    SelectFurnitureType[playerid] = FURNITURE_SELECT_MOVE;
                    SelectObject(playerid);
                    SendCustomMessage(playerid, "BUILDER", "Plase select the furniture, you wish to move.");
                }
                case 8: {
                    pData[playerid][pEditFurnHouse] = id;
                    SelectFurnitureType[playerid] = FURNITURE_SELECT_DESTROY;
                    SelectObject(playerid);
                    SendCustomMessage(playerid, "BUILDER", "Plase select the furniture, you wish to destroy.");
                }
                case 9: {
                    pData[playerid][pEditFurnHouse] = id;
                    SelectFurnitureType[playerid] = FURNITURE_SELECT_STORE;
                    SelectObject(playerid);
                    SendCustomMessage(playerid, "BUILDER", "Plase select the furniture, you wish to store.");
                }
                case 10: {
                    new
                        count = 0,
                        string[MAX_FURNITURE * 64];

                    if(!Furniture_GetCount(id))
                        return Error(playerid, "This house doesn't have any furniture spawned.");

                    strcat(string, "Model\tDistance\n");
                    foreach (new i : HouseFurnitures[id])
                    {
                        if(FurnitureData[id][i][furnitureUnused]) 
                            strcat(string, sprintf("%s\t(Not placed)\n", FurnitureData[id][i][furnitureName]));
                        else 
                            strcat(string, sprintf("%s\t%.2f\n", FurnitureData[id][i][furnitureName], GetPlayerDistanceFromPoint(playerid, FurnitureData[id][i][furniturePos][0], FurnitureData[id][i][furniturePos][1], FurnitureData[id][i][furniturePos][2])));

                        ListedFurniture[playerid][count++] = i;
                    }
                    Dialog_Show(playerid, ListedFurniture, DIALOG_STYLE_TABLIST_HEADERS, "House Furniture", string, "Select", "Cancel");
                }
            }
        }
    }
    return 1;
}

Dialog:House_StructureDestroy(playerid, response, listitem, inputtext[]) {
    if (!response)
        return callcmd::dyoh(playerid, "\0");
    
    new houseid = pData[playerid][pEditHouseStructure];

    if (houseid != -1 && (Player_OwnsHouse(playerid, houseid) || hData[houseid][houseBuilder] == pData[playerid][pID])) {
        HouseStructure_DeleteAll(houseid);
        SendCustomMessage(playerid, "BUILDER", "All structures in this house have been destroyed.");
    }
    return 1;
}

Dialog:House_StructureType(playerid, response, listitem, inputtext[]) {
    if (response) {
        new id = pData[playerid][pInHouse];
        if (id != -1) {
            switch (listitem) {
                case 0: {
                    new
                        count = 0,
                        string[90 * 64];

                    strcat(string, "Model\tDistance\n");
                    foreach (new i : HouseStruct[id]) if (HouseStructure[id][i][structureType] > 0) {
                        strcat(string, sprintf(ORANGE_E"Static\t%.2f\n", GetPlayerDistanceFromPoint(playerid, HouseStructure[id][i][structurePos][0], HouseStructure[id][i][structurePos][1], HouseStructure[id][i][structurePos][2])));
                        ListedStructure[playerid][count++] = i;
                    }
                    Dialog_Show(playerid, ListedStructure, DIALOG_STYLE_TABLIST_HEADERS, "Static House Structure", string, "Select", "Cancel");
                }
                case 1: {
                    new
                        count = 0,
                        string[MAX_HOUSE_STRUCTURES * 64];

                    if(!HouseStructure_GetCount(id))
                        return Error(playerid, "This house doesn't have any structures.");

                    strcat(string, "Model\tDistance\n");
                    foreach (new i : HouseStruct[id]) if (HouseStructure[id][i][structureType] == 0) {
                        strcat(string, sprintf("%s\t%.2f\n", GetStructureNameByModel(HouseStructure[id][i][structureModel]), GetPlayerDistanceFromPoint(playerid, HouseStructure[id][i][structurePos][0], HouseStructure[id][i][structurePos][1], HouseStructure[id][i][structurePos][2])));
                        ListedStructure[playerid][count++] = i;
                    }
                    Dialog_Show(playerid, ListedStructure, DIALOG_STYLE_TABLIST_HEADERS, "Custom House Structure", string, "Select", "Cancel");
                }
            }
        }
    }
    return 1;
}

Dialog:House_StructureAdd(playerid, response, listitem, inputtext[]) {
    new houseid = pData[playerid][pInHouse];
    if (houseid != -1) {
        if (response) {
            static
                Float:x,
                Float:y,
                Float:z,
                Float:angle
            ;

            GetPlayerPos(playerid, x, y, z);
            GetPlayerFacingAngle(playerid, angle);

            if (pData[playerid][pComponent] < g_aHouseStructure[listitem][e_StructureCost])
                return Error(playerid, "You need %d component to created %s structure", g_aHouseStructure[listitem][e_StructureCost], g_aHouseStructure[listitem][e_StructureName]);

            if(HouseStructure_GetCount(houseid) >= MAX_HOUSE_STRUCTURES)
                return Error(playerid, "You can only have %d structure items in your house.", MAX_HOUSE_STRUCTURES);

            new id = HouseStructure_Add(houseid, g_aHouseStructure[listitem][e_StructureModel], x+1, y, z, 0.0, 0.0, angle);

            if (id == cellmin)
                return Error(playerid, "Server has been reached maximum of house structure");

            pData[playerid][pComponent] -= g_aHouseStructure[listitem][e_StructureCost];
            pData[playerid][pEditStructure] = id;
            pData[playerid][pEditHouseStructure] = houseid;
            pData[playerid][pEditingMode] = 3;
            EditDynamicObject(playerid, HouseStructure[houseid][id][structureObject]);
            SendCustomMessage(playerid, "HOUSE", "You've been created "YELLOW_E"%s "WHITE_E"structure for "GREEN_E"%d components", g_aHouseStructure[listitem][e_StructureName], g_aHouseStructure[listitem][e_StructureCost]);
        } else callcmd::dyoh(playerid, "\0");
    }
    return 1;
}

Dialog:House_StructureRetexture(playerid, response, listitem, inputtext[]) {
    new houseid = pData[playerid][pInHouse];
    if (houseid != -1) {
        new id = GetPVarInt(playerid, "structureObj");
        if (response) {
            new model,color[4];
            new const txdname[32],texture[32];
            if (isnull(inputtext))
                return Dialog_Show(playerid, House_StructureRetexture, DIALOG_STYLE_INPUT, "Retexture House Structure", "Please input the texture name below:\n"YELLOW_E"[model] [txdname] [texture] [opt: alpha] [opt: red] [opt: green] [opt: blue]", "Retexture", "Cancel"), Error(playerid, "Invalid input!");

            if (sscanf(inputtext, "ds[32]s[32]D(0)D(0)D(0)D(0)",model,txdname,texture,color[0],color[1],color[2],color[3]))
                return Dialog_Show(playerid, House_StructureRetexture, DIALOG_STYLE_INPUT, "Retexture House Structure", "Please input the texture name below:\n"YELLOW_E"[model] [txdname] [texture] [opt: alpha] [opt: red] [opt: green] [opt: blue]", "Retexture", "Cancel"), Error(playerid, "Invalid input!");

            if (!IsValidTexture(texture))
                return Dialog_Show(playerid, House_StructureRetexture, DIALOG_STYLE_INPUT, "Retexture House Structure", "Please input the texture name below:\n"YELLOW_E"[model] [txdname] [texture] [opt: alpha] [opt: red] [opt: green] [opt: blue]", "Retexture", "Cancel"), Error(playerid, "Texture model tidak terdaftar dalam database");

            if (pData[playerid][pComponent] < 10)
                return Error(playerid, "You need 10 components to retexture the house structure");

            HouseStructure[houseid][id][structureMaterial] = GetTextureIndex(texture);
            HouseStructure[houseid][id][structureColor] = RGBAToInt(color[1], color[2], color[3], color[0]);
            HouseStructure_Refresh(id, houseid);
            HouseStructure_Save(id, houseid);

            pData[playerid][pComponent] -= 10;
            SendCustomMessage(playerid, "BUILDER", "You've been retextured the house structure with "YELLOW_E"10 components");
        } else callcmd::dyoh(playerid, "\0");
    }
    return 1;
}
