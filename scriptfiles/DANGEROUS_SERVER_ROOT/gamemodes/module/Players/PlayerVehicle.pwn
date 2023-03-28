
//new Float: VehicleFuel[MAX_VEHICLES] = 100.0;
new bool:VehicleHealthSecurity[MAX_VEHICLES] = false, Float:VehicleHealthSecurityData[MAX_VEHICLES] = 1000.0;
enum pvdata
{
	cID,
	cOwner,
	cModel,
	cColor1,
	cColor2,
	cPaintJob,
	cNeon,
	cTogNeon,
	cLocked,
	cInsu,
	cClaim,
	cClaimTime,
	cPlate[15],
	cPlateTime,
	cTicket,
	cPrice,
	Float:cHealth,
	cFuel,
	cMesinUpgrade,
	pvBodyUpgrade,
	cImpound,
	cTicketTime,
	Float:cPosX,
	Float:cPosY,
	Float:cPosZ,
	Float:cPosA,
	cInt,
	cVw,
	cDamage0,
	cDamage1,
	cDamage2,
	cDamage3,
	cMod[MAX_MODS],
	cLumber,
	cMetal,
	cCoal,
	cProduct,
	cGasOil,
	cRent,
	cCrack,
	cMaterial,
	cComponent,
	cCgun,
	cWeapon[10],
	cAmmo[10],
	cPark,
	cCrateComponent,
	cCrateFish,
	cWheat,
	cOnion,
	cCarrot,
	cPotato,
	cCorn,
	cVeh,
	bool:vELM,
	vEmergencyLights,
	vLights,
	vDestroyed,
	cCrate,
	Text3D:cLabelTire,
	cObject
};
new pvData[MAX_VEHICLES][pvdata],
	Iterator:PVehicles<MAX_VEHICLES + 1>;

//Private Vehicle Player System Native
new const g_arrVehicleNames[][] = 
{
        "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster",
        "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
        "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
        "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach",
        "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
        "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
        "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic",
        "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",
        "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
        "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
        "Boxville", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher",
        "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain",
        "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
        "Fortune", "Cadrona", "SWAT Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
        "Blade", "Streak", "Freight", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
        "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
        "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
        "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
        "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
        "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "LSPD Car", "SFPD Car", "LVPD Car",
        "Police Rancher", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
        "Boxville", "Tiller", "Utility Trailer"
};

GetEngineStatus(vehicleid)
{
    static
        engine,
        lights,
        alarm,
        doors,
        bonnet,
        boot,
        objective;

    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

    if(engine != 1)
        return 0;

    return 1;
}

GetLightStatus(vehicleid)
{
    static
        engine,
        lights,
        alarm,
        doors,
        bonnet,
        boot,
        objective;

    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

    if(lights != 1)
        return 0;

    return 1;
}

GetHoodStatus(vehicleid)
{
    static
        engine,
        lights,
        alarm,
        doors,
        bonnet,
        boot,
        objective;

    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

    if(bonnet != 1)
        return 0;

    return 1;
}

GetVehicleModelByName(const name[])
{
    if(IsNumeric(name) && (strval(name) >= 400 && strval(name) <= 611))
        return strval(name);

    for (new i = 0; i < sizeof(g_arrVehicleNames); i ++)
    {
        if(strfind(g_arrVehicleNames[i], name, true) != -1)
        {
                    return i + 400;
        }
    }
    return 0;
}

Vehicle_Nearest(playerid, Float:range = 3.5)
{
    static
        Float:fX,
        Float:fY,
        Float:fZ;

    foreach(new i:PVehicles)
	{
		if(Iter_Contains(PVehicles, i)) 
		{
			GetVehiclePos(pvData[i][cVeh], fX, fY, fZ);

			if(IsPlayerInRangeOfPoint(playerid, range, fX, fY, fZ)) 
			{
				return i;
			}
		}
    }
    return -1;
}

Vehicle_IsOwner(playerid, carid)
{
    if(!pData[playerid][IsLoggedIn] || pData[playerid][pID] == -1)
        return 0;

    if((Iter_Contains(PVehicles, carid) && pvData[carid][cOwner] != 0) && pvData[carid][cOwner] == pData[playerid][pID])
        return 1;

    return 0;
}

Vehicle_GetStatus(carid)
{
    GetVehicleDamageStatus(pvData[carid][cVeh], pvData[carid][cDamage0], pvData[carid][cDamage1], pvData[carid][cDamage2], pvData[carid][cDamage3]);

    GetVehicleHealth(pvData[carid][cVeh], pvData[carid][cHealth]);
	pvData[carid][cFuel] = GetVehicleFuel(pvData[carid][cVeh]);
    if(pvData[carid][cOwner])
    {
        GetVehiclePos(pvData[carid][cVeh], pvData[carid][cPosX], pvData[carid][cPosY], pvData[carid][cPosZ]);
        GetVehicleZAngle(pvData[carid][cVeh],pvData[carid][cPosA]);
    }
    return 1;
}

SetValidVehicleHealth(vehicleid, Float:health) {
    VehicleHealthSecurity[vehicleid] = true;
    SetVehicleHealth(vehicleid, health);
    return 1;
}

ValidRepairVehicle(vehicleid) {
    VehicleHealthSecurity[vehicleid] = true;
    RepairVehicle(vehicleid);
    return 1;
}

function OnPlayerVehicleRespawn(i)
{
	new carcreate = CreateVehicle(pvData[i][cModel], pvData[i][cPosX], pvData[i][cPosY], pvData[i][cPosZ], pvData[i][cPosA], pvData[i][cColor1], pvData[i][cColor2], -1);
	pvData[i][cVeh] = carcreate;
	new plate[62];
	format(plate, sizeof(plate), ""GREEN_E"%s", pvData[i][cPlate]);
	SetVehicleNumberPlate(carcreate, plate);
	SetVehicleVirtualWorld(carcreate, pvData[i][cVw]);
	LinkVehicleToInterior(carcreate, pvData[i][cInt]);
	SetVehicleFuel(carcreate, pvData[i][cFuel]);
	if(pvData[i][cHealth] < 350.0)
	{
		SetValidVehicleHealth(carcreate, 350.0);
	}
	else
	{
		SetValidVehicleHealth(carcreate, pvData[i][cHealth]);
	}
	UpdateVehicleDamageStatus(carcreate, pvData[i][cDamage0], pvData[i][cDamage1], pvData[i][cDamage2], pvData[i][cDamage3]);
	if(carcreate != INVALID_VEHICLE_ID)
    {
        if(pvData[i][cPaintJob] != -1)
        {
            ChangeVehiclePaintjob(carcreate, pvData[i][cPaintJob]);
        }
		for(new z = 0; z < MAX_MODS; z++)
		{
			if(pvData[i][cMod][z]) AddVehicleComponent(carcreate, pvData[i][cMod][z]);
		}
		if(pvData[i][cLocked] == 1)
		{
			SwitchVehicleDoors(carcreate, true);
		}
		else
		{
			SwitchVehicleDoors(carcreate, false);
		}
	}
	if(pvData[i][cImpound] == 1)
	{
		SetVehicleVirtualWorld(carcreate, 12);
	}
	else if(pvData[i][cImpound] == 2)
	{
		pvData[i][cLabelTire] = CreateDynamic3DTextLabel("Tire Lock",COLOR_BLUE,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,pvData[i][cVeh],1);
	}
	SetTimerEx("OnLoadVehicleStorage", 5000, false, "d", i);
	return 1;
}

function OnLoadVehicleStorage(i)
{
	if(IsValidVehicle(pvData[i][cVeh]))
	{
		if(IsAPickup(pvData[i][cVeh]))
		{
			if(pvData[i][cLumber] > 0)
			{
				if(!IsValidDynamicObject(LumberObjects[pvData[i][cVeh]]))
				{
					if(GetVehicleModel(pvData[i][cVeh]) == 422)
					{
						LumberObjects[pvData[i][cVeh]] = CreateDynamicObject(1463,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
						AttachDynamicObjectToVehicle(LumberObjects[pvData[i][cVeh]], pvData[i][cVeh], 0.005, -1.440, -0.130, 0.000, 179.999, 90.899);
					}
					else if(GetVehicleModel(pvData[i][cVeh]) == 478)
					{
						LumberObjects[pvData[i][cVeh]] = CreateDynamicObject(1463,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
						AttachDynamicObjectToVehicle(LumberObjects[pvData[i][cVeh]], pvData[i][cVeh], 0.000, -1.420, 0.080, 180.000, 0.000, 90.000);
					}	
					else if(GetVehicleModel(pvData[i][cVeh]) == 543)
					{
						LumberObjects[pvData[i][cVeh]] = CreateDynamicObject(1463,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
						AttachDynamicObjectToVehicle(LumberObjects[pvData[i][cVeh]], pvData[i][cVeh], 0.000, -1.651, 0.000, 180.000, 0.000, 90.000);
					}
					else if(GetVehicleModel(pvData[i][cVeh]) == 554)
					{
						LumberObjects[pvData[i][cVeh]] = CreateDynamicObject(1463,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
						AttachDynamicObjectToVehicle(LumberObjects[pvData[i][cVeh]], pvData[i][cVeh], -0.070, -1.581, 0.100, 180.000, 0.000, 90.000);
					}
				}
			}
		}
		if(pvData[i][cTogNeon] == 1)
		{
			if(pvData[i][cNeon] != 0)
			{
				SetVehicleNeonLights(pvData[i][cVeh], true, pvData[i][cNeon], 0);
			}
		}
		
		if(pvData[i][cMetal] > 0)
		{

			LogStorage[pvData[i][cVeh]][ 0 ] = pvData[i][cMetal];
		}
		else
		{
			LogStorage[pvData[i][cVeh]][ 0 ] = 0;
		}
		
		if(pvData[i][cCoal] > 0)
		{
			LogStorage[pvData[i][cVeh]][ 1 ] = pvData[i][cCoal];
		}
		else
		{
			LogStorage[pvData[i][cVeh]][ 1 ] = 0;
		}
		
		if(pvData[i][cProduct] > 0)
		{
			VehProduct[pvData[i][cVeh]] = pvData[i][cProduct];
		}
		else
		{
			VehProduct[pvData[i][cVeh]] = 0;
		}
		
		if(pvData[i][cGasOil] > 0)
		{
			VehGasOil[pvData[i][cVeh]] = pvData[i][cGasOil];
		}
		else
		{
			VehGasOil[pvData[i][cVeh]] = 0;
		}
		if(pvData[i][cComponent] > 0)
		{
			if(IsValidDynamicObject(ObjectVehicle[pvData[i][cVeh]][0]))
			{
				DestroyDynamicObject(ObjectVehicle[pvData[i][cVeh]][0]);
			}
			if(GetVehicleModel(pvData[i][cVeh]) == 422)
			{
				ObjectVehicle[pvData[i][cVeh]][0] = CreateDynamicObject(964,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
				AttachDynamicObjectToVehicle(ObjectVehicle[pvData[i][cVeh]][0], pvData[i][cVeh], 0.000, -1.370, -0.320, 0.000, 0.000, 0.000);
			}
			else if(GetVehicleModel(pvData[i][cVeh]) == 543)
			{
				ObjectVehicle[pvData[i][cVeh]][0] = CreateDynamicObject(964,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
				AttachDynamicObjectToVehicle(ObjectVehicle[pvData[i][cVeh]][0], pvData[i][cVeh], 0.000, -1.521, -0.250, 0.000, 0.000, 0.000);
			}	
			else if(GetVehicleModel(pvData[i][cVeh]) == 525)
			{
				ObjectVehicle[pvData[i][cVeh]][0] = CreateDynamicObject(964,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
				AttachDynamicObjectToVehicle(ObjectVehicle[pvData[i][cVeh]][0], pvData[i][cVeh], 0.000, -1.000, 0.190, 0.000, 0.000, 0.000);
			}
		}
		else if(pvData[i][cMaterial] > 0)
		{
			if(IsValidDynamicObject(ObjectVehicle[pvData[i][cVeh]][1]))
			{
				DestroyDynamicObject(ObjectVehicle[pvData[i][cVeh]][1]);
			}
			if(GetVehicleModel(pvData[i][cVeh]) == 422 || GetVehicleModel(pvData[i][cVeh]) == 543)
			{
				ObjectVehicle[pvData[i][cVeh]][1] = CreateDynamicObject(964,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				AttachDynamicObjectToVehicle(ObjectVehicle[pvData[i][cVeh]][1], pvData[i][cVeh], 0.000, -1.180, -0.220, 0.000, 0.000, 0.000);	
			}
		}
		else if(pvData[i][cOnion] > 0 || pvData[i][cCarrot] > 0 || pvData[i][cPotato] > 0 || pvData[i][cCorn] > 0 || pvData[i][cWheat] > 0)
		{
			if(IsValidDynamicObject(ObjectVehicle[pvData[i][cVeh]][2]))
			{
				DestroyDynamicObject(ObjectVehicle[pvData[i][cVeh]][2]);
			}
			if(GetVehicleModel(pvData[i][cVeh]) == 422)
			{
				ObjectVehicle[pvData[i][cVeh]][2] = CreateDynamicObject(1454,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
				AttachDynamicObjectToVehicle(ObjectVehicle[pvData[i][cVeh]][2], pvData[i][cVeh], 0.000, -1.382, 0.126, 90.599, 0.000, 0.000);
			}
			else if(GetVehicleModel(pvData[i][cVeh]) == 478)
			{
				ObjectVehicle[pvData[i][cVeh]][2] = CreateDynamicObject(1454,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
				AttachDynamicObjectToVehicle(ObjectVehicle[pvData[i][cVeh]][2], pvData[i][cVeh], 0.000, -1.537, 0.263, 88.999, 0.000, 0.000);
			}	
			else if(GetVehicleModel(pvData[i][cVeh]) == 543)
			{
				ObjectVehicle[pvData[i][cVeh]][2] = CreateDynamicObject(1454,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
				AttachDynamicObjectToVehicle(ObjectVehicle[pvData[i][cVeh]][2], pvData[i][cVeh], 0.000, -1.338, 0.298, 89.599, 0.000, 0.000);
			}
			else if(GetVehicleModel(pvData[i][cVeh]) == 554)
			{
				ObjectVehicle[pvData[i][cVeh]][2] = CreateDynamicObject(1454,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
				AttachDynamicObjectToVehicle(ObjectVehicle[pvData[i][cVeh]][2], pvData[i][cVeh], 0.000, -1.625, 0.209, 88.900, 0.000, 0.000);
			}
		}	
	}
}

function LoadPlayerVehicle(playerid)
{
	new query[128];
	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `vehicle` WHERE `owner` = %d", pData[playerid][pID]);
	mysql_query(g_SQL, query, true);
	new count = cache_num_rows(), tempString[56];
	if(count > 0)
	{
		for(new z = 0; z < count; z++)
		{
			new i = Iter_Free(PVehicles);
			cache_get_value_name_int(z, "id", pvData[i][cID]);
			//pvData[i][VehicleOwned] = true;
			cache_get_value_name_int(z, "owner", pvData[i][cOwner]);
			cache_get_value_name_int(z, "locked", pvData[i][cLocked]);
			cache_get_value_name_int(z, "insu", pvData[i][cInsu]);
			cache_get_value_name_int(z, "claim", pvData[i][cClaim]);
			cache_get_value_name_int(z, "claim_time", pvData[i][cClaimTime]);
			cache_get_value_name_float(z, "x", pvData[i][cPosX]);
			cache_get_value_name_float(z, "y", pvData[i][cPosY]);
			cache_get_value_name_float(z, "z", pvData[i][cPosZ]);
			cache_get_value_name_float(z, "a", pvData[i][cPosA]);
			cache_get_value_name_float(z, "health", pvData[i][cHealth]);
			cache_get_value_name_int(z, "fuel", pvData[i][cFuel]);
			cache_get_value_name_int(z, "upgrademesin", pvData[i][cMesinUpgrade]);
			cache_get_value_name_int(z, "upgradebody", pvData[i][pvBodyUpgrade]);
			cache_get_value_name_int(z, "despawn", pvData[i][cTicketTime]);
			cache_get_value_name_int(z, "impound", pvData[i][cImpound]);
			cache_get_value_name_int(z, "int", pvData[i][cInt]);
			cache_get_value_name_int(z, "vw", pvData[i][cVw]);
			cache_get_value_name_int(z, "damage0", pvData[i][cDamage0]);
			cache_get_value_name_int(z, "damage1", pvData[i][cDamage1]);
			cache_get_value_name_int(z, "damage2", pvData[i][cDamage2]);
			cache_get_value_name_int(z, "damage3", pvData[i][cDamage3]);
			cache_get_value_name_int(z, "color1", pvData[i][cColor1]);
			cache_get_value_name_int(z, "color2", pvData[i][cColor2]);
			cache_get_value_name_int(z, "paintjob", pvData[i][cPaintJob]);
			cache_get_value_name_int(z, "neon", pvData[i][cNeon]);
			pvData[i][cTogNeon] = 0;
			cache_get_value_name_int(z, "price", pvData[i][cPrice]);
			cache_get_value_name_int(z, "model", pvData[i][cModel]);
			cache_get_value_name(z, "plate", tempString);
			format(pvData[i][cPlate], 16, tempString);
			cache_get_value_name_int(z, "plate_time", pvData[i][cPlateTime]);
			cache_get_value_name_int(z, "ticket", pvData[i][cTicket]);
			
			cache_get_value_name_int(z, "mod0", pvData[i][cMod][0]);
			cache_get_value_name_int(z, "mod1", pvData[i][cMod][1]);
			cache_get_value_name_int(z, "mod2", pvData[i][cMod][2]);
			cache_get_value_name_int(z, "mod3", pvData[i][cMod][3]);
			cache_get_value_name_int(z, "mod4", pvData[i][cMod][4]);
			cache_get_value_name_int(z, "mod5", pvData[i][cMod][5]);
			cache_get_value_name_int(z, "mod6", pvData[i][cMod][6]);
			cache_get_value_name_int(z, "mod7", pvData[i][cMod][7]);
			cache_get_value_name_int(z, "mod8", pvData[i][cMod][8]);
			cache_get_value_name_int(z, "mod9", pvData[i][cMod][9]);
			cache_get_value_name_int(z, "mod10", pvData[i][cMod][10]);
			cache_get_value_name_int(z, "mod11", pvData[i][cMod][11]);
			cache_get_value_name_int(z, "mod12", pvData[i][cMod][12]);
			cache_get_value_name_int(z, "mod13", pvData[i][cMod][13]);
			cache_get_value_name_int(z, "mod14", pvData[i][cMod][14]);
			cache_get_value_name_int(z, "mod15", pvData[i][cMod][15]);
			cache_get_value_name_int(z, "mod16", pvData[i][cMod][16]);
			cache_get_value_name_int(z, "lumber", pvData[i][cLumber]);
			cache_get_value_name_int(z, "metal", pvData[i][cMetal]);
			cache_get_value_name_int(z, "coal", pvData[i][cCoal]);
			cache_get_value_name_int(z, "product", pvData[i][cProduct]);
			cache_get_value_name_int(z, "gasoil", pvData[i][cGasOil]);
			cache_get_value_name_int(z, "rental", pvData[i][cRent]);
			cache_get_value_name_int(z, "crack", pvData[i][cCrack]);
			cache_get_value_name_int(z, "material", pvData[i][cMaterial]);
			cache_get_value_name_int(z, "component", pvData[i][cComponent]);
			cache_get_value_name_int(z, "cgun", pvData[i][cCgun]);
			cache_get_value_name_int(z, "gun1", pvData[i][cWeapon][0]);
			cache_get_value_name_int(z, "gun2", pvData[i][cWeapon][1]);
			cache_get_value_name_int(z, "gun3", pvData[i][cWeapon][2]);
			cache_get_value_name_int(z, "gun4", pvData[i][cWeapon][3]);
			cache_get_value_name_int(z, "gun5", pvData[i][cWeapon][4]);
			cache_get_value_name_int(z, "gun6", pvData[i][cWeapon][5]);
			cache_get_value_name_int(z, "gun7", pvData[i][cWeapon][6]);
			cache_get_value_name_int(z, "gun8", pvData[i][cWeapon][7]);
			cache_get_value_name_int(z, "gun9", pvData[i][cWeapon][8]);
			cache_get_value_name_int(z, "gun10", pvData[i][cWeapon][9]);
			cache_get_value_name_int(z, "ammo1", pvData[i][cAmmo][0]);
			cache_get_value_name_int(z, "ammo2", pvData[i][cAmmo][1]);
			cache_get_value_name_int(z, "ammo3", pvData[i][cAmmo][2]);
			cache_get_value_name_int(z, "ammo4", pvData[i][cAmmo][3]);
			cache_get_value_name_int(z, "ammo5", pvData[i][cAmmo][4]);
			cache_get_value_name_int(z, "ammo6", pvData[i][cAmmo][5]);
			cache_get_value_name_int(z, "ammo7", pvData[i][cAmmo][6]);
			cache_get_value_name_int(z, "ammo8", pvData[i][cAmmo][7]);
			cache_get_value_name_int(z, "ammo9", pvData[i][cAmmo][8]);
			cache_get_value_name_int(z, "ammo10", pvData[i][cAmmo][9]);
			cache_get_value_name_int(z, "park", pvData[i][cPark]);
			cache_get_value_name_int(z, "cratecomponent", pvData[i][cCrateComponent]);
			cache_get_value_name_int(z, "cratefish", pvData[i][cCrateFish]);
			cache_get_value_name_int(z, "wheat", pvData[i][cWheat]);
			cache_get_value_name_int(z, "onion", pvData[i][cOnion]);
			cache_get_value_name_int(z, "carrot", pvData[i][cCarrot]);
			cache_get_value_name_int(z, "potato", pvData[i][cPotato]);
			cache_get_value_name_int(z, "corn", pvData[i][cCorn]);

			Iter_Add(PVehicles, i);
			new carcreate = CreateVehicle(pvData[i][cModel], pvData[i][cPosX], pvData[i][cPosY], pvData[i][cPosZ], pvData[i][cPosA], pvData[i][cColor1], pvData[i][cColor2], -1);
			pvData[i][cVeh] = carcreate;
			new plate[62];
			format(plate, sizeof(plate), ""GREEN_E"%s", pvData[i][cPlate]);
			SetVehicleNumberPlate(carcreate, plate);
			SetVehicleVirtualWorld(carcreate, pvData[i][cVw]);
			LinkVehicleToInterior(carcreate, pvData[i][cInt]);
			SetVehicleFuel(carcreate, pvData[i][cFuel]);
			if(pvData[i][cHealth] < 350.0)
			{
				SetValidVehicleHealth(carcreate, 350.0);
			}
			else
			{
				SetValidVehicleHealth(carcreate, pvData[i][cHealth]);
			}
			UpdateVehicleDamageStatus(carcreate, pvData[i][cDamage0], pvData[i][cDamage1], pvData[i][cDamage2], pvData[i][cDamage3]);
			if(carcreate != INVALID_VEHICLE_ID)
			{
				if(pvData[i][cPaintJob] != -1)
				{
					ChangeVehiclePaintjob(carcreate, pvData[i][cPaintJob]);
				}
				for(new mod = 0; mod < MAX_MODS; mod++)
				{
					if(pvData[i][cMod][mod]) AddVehicleComponent(carcreate, pvData[i][cMod][mod]);
				}
				if(pvData[i][cLocked] == 1)
				{
					SwitchVehicleDoors(carcreate, true);
				}
				else
				{
					SwitchVehicleDoors(carcreate, false);
				}
			}
			if(pvData[i][cImpound] == 1)
			{
				SetVehicleVirtualWorld(carcreate, 12);
			}
			else if(pvData[i][cImpound] == 4)
			{
				new rand = RandomEx(111111, 999999);
				SetVehicleVirtualWorld(carcreate, rand);
			}
			else if(pvData[i][cImpound] == 2)
			{
				pvData[i][cLabelTire] = CreateDynamic3DTextLabel("Tire Lock",COLOR_BLUE,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,pvData[i][cVeh],1);
			}
			else if(pvData[i][cClaim] == 1)
			{
				new rand = RandomEx(111111, 999999);
				SetVehicleVirtualWorld(carcreate, rand);
			}
			else if(pvData[i][cPark] > -1)
			{
				new rand = RandomEx(111111, 999999);
				SetVehicleVirtualWorld(carcreate, rand);
			}
			
			SetTimerEx("OnLoadVehicleStorage", 5000, false, "d", i);
			new string[128];
			format(string, sizeof(string), "SELECT * FROM `vehicle_object` WHERE `vehicle`=%d", pvData[i][cID]);
			mysql_tquery(g_SQL, string, "Vehicle_ObjectLoaded", "dd", i, playerid); // Coba lagi
		}
		printf("[P_VEHICLE] Loaded player vehicle from: %s(%d)", pData[playerid][pName], playerid);
	}
	return 1;
}

function EngineStatus(playerid, vehicleid)
{
	if(!GetEngineStatus(vehicleid))
    {
		foreach(new ii : PVehicles)
		{
			if(vehicleid == pvData[ii][cVeh])
			{
				if(pvData[ii][cTicket] >= 2000)
					return Error(playerid, "This vehicle has a pending ticket in SAPD Officer! /v insu - to check pending ticket");
			}
		}
		new Float: f_vHealth;
		GetVehicleHealth(vehicleid, f_vHealth);
		if(f_vHealth < 350.0) return Error(playerid, "The car won't start - it's totalled!");
		if(GetVehicleFuel(vehicleid) <= 0.0) return Error(playerid, "The car won't start - there's no fuel in the tank!");
		SwitchVehicleLight(vehicleid, true);
		SwitchVehicleEngine(vehicleid, true);
		SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"You have "GREEN_E"succesfully "WHITE_E"started the vehicle engine.");
	}
	else
	{
		SendClientMessageEx(playerid, COLOR_ARWIN, "ENGINE: "WHITE_E"Anda telah mematikan Mesin");
		SwitchVehicleEngine(vehicleid, false);
		SwitchVehicleLight(vehicleid, false);
	}
	return 1;
}

function RemovePlayerVehicle(playerid)
{
	foreach(new i : PVehicles)
	{
		Vehicle_GetStatus(i);
		if(pvData[i][cOwner] == pData[playerid][pID])
		{
			new cQuery[5248]/*, color1, color2, paintjob*/;
			pvData[i][cOwner] = -1;
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "UPDATE `vehicle` SET ");
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`x`='%f', ", cQuery, pvData[i][cPosX]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`y`='%f', ", cQuery, pvData[i][cPosY]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`z`='%f', ", cQuery, pvData[i][cPosZ]+0.1);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`a`='%f', ", cQuery, pvData[i][cPosA]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`health`='%f', ", cQuery, pvData[i][cHealth]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`fuel`=%d, ", cQuery, pvData[i][cFuel]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`upgrademesin`=%d, ", cQuery, pvData[i][cMesinUpgrade]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`upgradebody`=%d, ", cQuery, pvData[i][pvBodyUpgrade]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`despawn`=%d, ", cQuery, pvData[i][cTicketTime]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`impound`=%d, ", cQuery, pvData[i][cImpound]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`int`=%d, ", cQuery, pvData[i][cInt]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`price`=%d, ", cQuery, pvData[i][cPrice]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`vw`=%d, ", cQuery, pvData[i][cVw]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`model`=%d, ", cQuery, pvData[i][cModel]);
			if(pvData[i][cLocked] == 1)
				mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`locked`=1, ", cQuery);
			else
				mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`locked`=0, ", cQuery);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`insu`='%d', ", cQuery, pvData[i][cInsu]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`claim`='%d', ", cQuery, pvData[i][cClaim]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`claim_time`='%d', ", cQuery, pvData[i][cClaimTime]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`plate`='%e', ", cQuery, pvData[i][cPlate]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`plate_time`='%d', ", cQuery, pvData[i][cPlateTime]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`ticket`='%d', ", cQuery, pvData[i][cTicket]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`color1`=%d, ", cQuery, pvData[i][cColor1]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`color2`=%d, ", cQuery, pvData[i][cColor2]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`paintjob`=%d, ", cQuery, pvData[i][cPaintJob]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`neon`=%d, ", cQuery, pvData[i][cNeon]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`damage0`=%d, ", cQuery, pvData[i][cDamage0]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`damage1`=%d, ", cQuery, pvData[i][cDamage1]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`damage2`=%d, ", cQuery, pvData[i][cDamage2]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`damage3`=%d, ", cQuery, pvData[i][cDamage3]);
			new tempString[56];
			for(new z = 0; z < MAX_MODS; z++)
			{
				format(tempString, sizeof(tempString), "mod%d", z);
				mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`%s`=%d, ", cQuery, tempString, pvData[i][cMod][z]);
			}
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`lumber`=%d, ", cQuery, pvData[i][cLumber]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`metal`=%d, ", cQuery, pvData[i][cMetal]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`coal`=%d, ", cQuery, pvData[i][cCoal]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`product`=%d,", cQuery, pvData[i][cProduct]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`gasoil`=%d,", cQuery, pvData[i][cGasOil]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`rental`=%d, ", cQuery, pvData[i][cRent]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`crack`=%d, ", cQuery, pvData[i][cCrack]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`material`=%d, ", cQuery, pvData[i][cMaterial]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`component`=%d, ", cQuery, pvData[i][cComponent]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`cgun`=%d, ", cQuery, pvData[i][cCgun]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`gun1`=%d, ", cQuery, pvData[i][cWeapon][0]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`gun2`=%d, ", cQuery, pvData[i][cWeapon][1]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`gun3`=%d, ", cQuery, pvData[i][cWeapon][2]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`gun4`=%d,", cQuery, pvData[i][cWeapon][3]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`gun5`=%d,", cQuery, pvData[i][cWeapon][4]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`gun6`=%d, ", cQuery,pvData[i][cWeapon][5]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`gun7`=%d, ", cQuery, pvData[i][cWeapon][6]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`gun8`=%d, ", cQuery, pvData[i][cWeapon][7]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`gun9`=%d, ", cQuery, pvData[i][cWeapon][8]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`gun10`=%d, ", cQuery, pvData[i][cWeapon][9]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`ammo1`=%d, ", cQuery, pvData[i][cAmmo][0]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`ammo2`=%d, ", cQuery, pvData[i][cAmmo][1]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`ammo3`=%d, ", cQuery, pvData[i][cAmmo][2]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`ammo4`=%d,", cQuery, pvData[i][cAmmo][3]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`ammo5`=%d,", cQuery, pvData[i][cAmmo][4]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`ammo6`=%d, ", cQuery,pvData[i][cAmmo][5]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`ammo7`=%d, ", cQuery, pvData[i][cAmmo][6]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`ammo8`=%d, ", cQuery, pvData[i][cAmmo][7]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`ammo9`=%d, ", cQuery, pvData[i][cAmmo][8]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`ammo10`=%d, ", cQuery, pvData[i][cAmmo][9]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`park`=%d, ", cQuery, pvData[i][cPark]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`cratecomponent`=%d, ", cQuery, pvData[i][cCrateComponent]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`cratefish`=%d, ", cQuery, pvData[i][cCrateFish]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`wheat`=%d, ", cQuery, pvData[i][cWheat]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`onion`=%d, ", cQuery, pvData[i][cOnion]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`carrot`=%d, ", cQuery, pvData[i][cCarrot]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`potato`=%d, ", cQuery, pvData[i][cPotato]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`corn`=%d ", cQuery, pvData[i][cCorn]);

			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%sWHERE `id` = %d", cQuery, pvData[i][cID]);
			mysql_query(g_SQL, cQuery, true);
			if(pvData[i][cNeon] != 0)
			{
				SetVehicleNeonLights(pvData[i][cVeh], false, pvData[i][cNeon], 0);
			}
			Vehicle_ObjectDestroy(i);
			if(pvData[i][cVeh] != 0)
			{
				if(IsValidVehicle(pvData[i][cVeh])) DestroyVehicle(pvData[i][cVeh]);
			}
			if(pvData[i][cImpound] == 2)
			{
				DestroyDynamic3DTextLabel(pvData[i][cLabelTire]);
			}
			Iter_SafeRemove(PVehicles, i, i);
		}
	}
	return 1;
}

IsVIPVehicle(vehicleid)
{
	new vehmodel = GetVehicleModel(vehicleid);
	switch(vehmodel)
	{
		case 541,480,565,434,494,502,503,411,506,555,477,568,424,504,457,483,508,571,500,444,556,471,495,539,470,573,514,515:
		{
			return 1;
		}
		
	}
	return 0;
}

function OnVehCreated(playerid, oid, pid, model, color1, color2, Float:x, Float:y, Float:z, Float:a)
{
	new i = Iter_Free(PVehicles);
	new price = GetVehicleCost(model);
	pvData[i][cID] = cache_insert_id();
	pvData[i][cOwner] = pid;
	pvData[i][cModel] = model;
	pvData[i][cColor1] = color1;
	pvData[i][cColor2] = color2;
	pvData[i][cPaintJob] = -1;
	pvData[i][cNeon] = 0;
	pvData[i][cTogNeon] = 0;
	pvData[i][cLocked] = 0;
	pvData[i][cInsu] = 3;
	pvData[i][cClaim] = 0;
	pvData[i][cClaimTime] = 0;
	pvData[i][cTicket] = 0;
	pvData[i][cPrice] = price;
	pvData[i][cHealth] = 1000;
	pvData[i][cFuel] = 1000;
	format(pvData[i][cPlate], 16, "No Have");
	pvData[i][cPlateTime] = 0;
	pvData[i][cPosX] = x;
	pvData[i][cPosY] = y;
	pvData[i][cPosZ] = z;
	pvData[i][cPosA] = a;
	pvData[i][cInt] = 0;
	pvData[i][cVw] = 0;
	pvData[i][cLumber] = -1;
	pvData[i][cMetal] = 0;
	pvData[i][cCoal] = 0;
	pvData[i][cProduct] = 0;
	pvData[i][cGasOil] = 0;
	pvData[i][cMesinUpgrade] = 0;
	pvData[i][pvBodyUpgrade] = 0;
	pvData[i][cRent] = 0;
	pvData[i][cCrack] = 0;
	pvData[i][cMaterial] = 0;
	pvData[i][cCgun] = 0;
	pvData[i][cComponent] = 0;
	pvData[i][cPark] = -1;
	pvData[i][cCrateComponent] = 0;
	pvData[i][cCrateFish] = 0;
	for(new j = 0; j < 10; j++)
	{
		pvData[i][cWeapon][i] = 0;
		pvData[i][cAmmo][i] = 0;
	}
	for(new j = 0; j < MAX_MODS; j++)
		pvData[i][cMod][j] = 0;
	Iter_Add(PVehicles, i);
	OnPlayerVehicleRespawn(i);
	Servers(playerid, "You have made the vehicle to "YELLOW_E"%s "WHITE_E"with {00FFFF}(model=%d, color1=%d, color2=%d)", pData[oid][pName], model, color1, color2);
	return 1;
}

function OnVehBuyPV(playerid, pid, model, color1, color2, cost, Float:x, Float:y, Float:z, Float:a)
{
	new i = Iter_Free(PVehicles);
	pvData[i][cID] = cache_insert_id();
	pvData[i][cOwner] = pid;
	pvData[i][cModel] = model;
	pvData[i][cColor1] = color1;
	pvData[i][cColor2] = color2;
	pvData[i][cPaintJob] = -1;
	pvData[i][cNeon] = 0;
	pvData[i][cTogNeon] = 0;
	pvData[i][cLocked] = 0;
	pvData[i][cInsu] = 3;
	pvData[i][cClaim] = 0;
	pvData[i][cClaimTime] = 0;
	pvData[i][cTicket] = 0;
	pvData[i][cPrice] = cost;
	pvData[i][cHealth] = 2000;
	pvData[i][cFuel] = 1000;
	format(pvData[i][cPlate], 16, "No Have");
	pvData[i][cPlateTime] = 0;
	pvData[i][cPosX] = x;
	pvData[i][cPosY] = y;
	pvData[i][cPosZ] = z;
	pvData[i][cPosA] = a;
	pvData[i][cInt] = 0;
	pvData[i][cVw] = 0;
	pvData[i][cLumber] = -1;
	pvData[i][cMetal] = 0;
	pvData[i][cCoal] = 0;
	pvData[i][cProduct] = 0;
	pvData[i][cGasOil] = 0;
	pvData[i][cMesinUpgrade] = 0;
	pvData[i][pvBodyUpgrade] = 0;
	pvData[i][cImpound] = 0;
	pvData[i][cRent] = 0;
	pvData[i][cCrack] = 0;
	pvData[i][cMaterial] = 0;
	pvData[i][cCgun] = 0;
	pvData[i][cComponent] = 0;
	pvData[i][cPark] = -1;
	pvData[i][cCrateComponent] = 0;
	pvData[i][cCrateFish] = 0;
	for(new j = 0; j < 10; j++)
	{
		pvData[i][cWeapon][i] = 0;
		pvData[i][cAmmo][i] = 0;
	}
	for(new j = 0; j < MAX_MODS; j++)
		pvData[i][cMod][j] = 0;
	Iter_Add(PVehicles, i);
	OnPlayerVehicleRespawn(i);
	SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"You have purchased a vehicle for "GREEN_E"$%s "WHITE_E"with model {00FFFF}%s", FormatMoney(cost), GetVehicleModelName(model));
	PutPlayerInVehicle(playerid, pvData[i][cVeh], 0);
	TempCarID[playerid] = pvData[i][cVeh];
	SetPVarInt(playerid, "CarID", pvData[i][cVeh]);
	pData[playerid][pBuyPvModel] = 0;
	return 1;
}

function OnVehBuyPVBOAT(playerid, pid, model, color1, color2, cost, Float:x, Float:y, Float:z, Float:a)
{
	new i = Iter_Free(PVehicles);
	pvData[i][cID] = cache_insert_id();
	pvData[i][cOwner] = pid;
	pvData[i][cModel] = model;
	pvData[i][cColor1] = color1;
	pvData[i][cColor2] = color2;
	pvData[i][cPaintJob] = -1;
	pvData[i][cNeon] = 0;
	pvData[i][cTogNeon] = 0;
	pvData[i][cLocked] = 0;
	pvData[i][cInsu] = 3;
	pvData[i][cClaim] = 0;
	pvData[i][cClaimTime] = 0;
	pvData[i][cTicket] = 0;
	pvData[i][cPrice] = cost;
	pvData[i][cHealth] = 2000;
	pvData[i][cFuel] = 1000;
	format(pvData[i][cPlate], 16, "No Have");
	pvData[i][cPlateTime] = 0;
	pvData[i][cPosX] = x;
	pvData[i][cPosY] = y;
	pvData[i][cPosZ] = z;
	pvData[i][cPosA] = a;
	pvData[i][cInt] = 0;
	pvData[i][cVw] = 0;
	pvData[i][cLumber] = -1;
	pvData[i][cMetal] = 0;
	pvData[i][cCoal] = 0;
	pvData[i][cProduct] = 0;
	pvData[i][cGasOil] = 0;
	pvData[i][cMesinUpgrade] = 0;
	pvData[i][pvBodyUpgrade] = 0;
	pvData[i][cImpound] = 0;
	pvData[i][cRent] = 0;
	pvData[i][cCrack] = 0;
	pvData[i][cMaterial] = 0;
	pvData[i][cCgun] = 0;
	pvData[i][cComponent] = 0;
	pvData[i][cPark] = -1;
	pvData[i][cCrateComponent] = 0;
	pvData[i][cCrateFish] = 0;
	for(new j = 0; j < 10; j++)
	{
		pvData[i][cWeapon][i] = 0;
		pvData[i][cAmmo][i] = 0;
	}
	for(new j = 0; j < MAX_MODS; j++)
		pvData[i][cMod][j] = 0;
	Iter_Add(PVehicles, i);
	OnPlayerVehicleRespawn(i);
	SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"You have purchased a vehicle for "GREEN_E"%s "WHITE_E"with model {00FFFF}%s", FormatMoney(GetVehicleCost(model)), GetVehicleModelName(model));
	PutPlayerInVehicle(playerid, pvData[i][cVeh], 0);
	pData[playerid][pBuyPvModel] = 0;
	return 1;
}

function OnVehBuyPVLS(playerid, pid, model, color1, color2, cost, Float:x, Float:y, Float:z, Float:a)
{
	new i = Iter_Free(PVehicles);
	pvData[i][cID] = cache_insert_id();
	pvData[i][cOwner] = pid;
	pvData[i][cModel] = model;
	pvData[i][cColor1] = color1;
	pvData[i][cColor2] = color2;
	pvData[i][cPaintJob] = -1;
	pvData[i][cNeon] = 0;
	pvData[i][cTogNeon] = 0;
	pvData[i][cLocked] = 0;
	pvData[i][cInsu] = 3;
	pvData[i][cClaim] = 0;
	pvData[i][cClaimTime] = 0;
	pvData[i][cTicket] = 0;
	pvData[i][cPrice] = cost;
	pvData[i][cHealth] = 2000;
	pvData[i][cFuel] = 1000;
	format(pvData[i][cPlate], 16, "No Have");
	pvData[i][cPlateTime] = 0;
	pvData[i][cPosX] = x;
	pvData[i][cPosY] = y;
	pvData[i][cPosZ] = z;
	pvData[i][cPosA] = a;
	pvData[i][cInt] = 0;
	pvData[i][cVw] = 0;
	pvData[i][cLumber] = -1;
	pvData[i][cMetal] = 0;
	pvData[i][cCoal] = 0;
	pvData[i][cProduct] = 0;
	pvData[i][cGasOil] = 0;
	pvData[i][cMesinUpgrade] = 0;
	pvData[i][pvBodyUpgrade] = 0;
	pvData[i][cImpound] = 0;
	pvData[i][cRent] = 0;
	pvData[i][cCrack] = 0;
	pvData[i][cMaterial] = 0;
	pvData[i][cCgun] = 0;
	pvData[i][cComponent] = 0;
	pvData[i][cPark] = -1;
	pvData[i][cCrateComponent] = 0;
	pvData[i][cCrateFish] = 0;
	for(new j = 0; j < 10; j++)
	{
		pvData[i][cWeapon][i] = 0;
		pvData[i][cAmmo][i] = 0;
	}
	for(new j = 0; j < MAX_MODS; j++)
		pvData[i][cMod][j] = 0;
	Iter_Add(PVehicles, i);
	OnPlayerVehicleRespawn(i);
	SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"You have purchased a vehicle for "GREEN_E"%s "WHITE_E"with model {00FFFF}%s", FormatMoney(cost), GetVehicleModelName(model));
	PutPlayerInVehicle(playerid, pvData[i][cVeh], 0);
	pData[playerid][pBuyPvModel] = 0;
	return 1;
}

function OnVehRentPV(playerid, pid, model, color1, color2, cost, Float:x, Float:y, Float:z, Float:a, rental)
{
	new i = Iter_Free(PVehicles);
	pvData[i][cID] = cache_insert_id();
	pvData[i][cOwner] = pid;
	pvData[i][cModel] = model;
	pvData[i][cColor1] = color1;
	pvData[i][cColor2] = color2;
	pvData[i][cPaintJob] = -1;
	pvData[i][cNeon] = 0;
	pvData[i][cTogNeon] = 0;
	pvData[i][cLocked] = 0;
	pvData[i][cInsu] = 3;
	pvData[i][cClaim] = 0;
	pvData[i][cClaimTime] = 0;
	pvData[i][cTicket] = 0;
	pvData[i][cPrice] = cost;
	pvData[i][cHealth] = 2000;
	pvData[i][cFuel] = 1000;
	format(pvData[i][cPlate], 16, "RENTAL");
	pvData[i][cPlateTime] = 0;
	pvData[i][cPosX] = x;
	pvData[i][cPosY] = y;
	pvData[i][cPosZ] = z;
	pvData[i][cPosA] = a;
	pvData[i][cInt] = 0;
	pvData[i][cVw] = 0;
	pvData[i][cLumber] = -1;
	pvData[i][cMetal] = 0;
	pvData[i][cCoal] = 0;
	pvData[i][cProduct] = 0;
	pvData[i][cGasOil] = 0;
	pvData[i][cMesinUpgrade] = 0;
	pvData[i][pvBodyUpgrade] = 0;
	pvData[i][cImpound] = 0;
	pvData[i][cRent] = rental;
	pvData[i][cCrack] = 0;
	pvData[i][cMaterial] = 0;
	pvData[i][cCgun] = 0;
	pvData[i][cComponent] = 0;
	pvData[i][cPark] = -1;
	pvData[i][cCrateComponent] = 0;
	pvData[i][cCrateFish] = 0;
	for(new j = 0; j < 10; j++)
	{
		pvData[i][cWeapon][i] = 0;
		pvData[i][cAmmo][i] = 0;
	}
	for(new j = 0; j < MAX_MODS; j++)
		pvData[i][cMod][j] = 0;
	
	pData[playerid][pRents] = pvData[i][cID];
	Iter_Add(PVehicles, i);
	OnPlayerVehicleRespawn(i);
	SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"You have rented a vehicle with a {00FFFF}model %s", GetVehicleModelName(model));
	PutPlayerInVehicle(playerid, pvData[i][cVeh], 0);
	pData[playerid][pBuyPvModel] = 0;
	return 1;
}

function VehBuyVIP(playerid, pid, model, color1, color2, cost, Float:x, Float:y, Float:z, Float:a)
{
	new i = Iter_Free(PVehicles);
	pvData[i][cID] = cache_insert_id();
	pvData[i][cOwner] = pid;
	pvData[i][cModel] = model;
	pvData[i][cColor1] = color1;
	pvData[i][cColor2] = color2;
	pvData[i][cPaintJob] = -1;
	pvData[i][cNeon] = 0;
	pvData[i][cTogNeon] = 0;
	pvData[i][cLocked] = 0;
	pvData[i][cInsu] = 3;
	pvData[i][cClaim] = 0;
	pvData[i][cClaimTime] = 0;
	pvData[i][cTicket] = 0;
	pvData[i][cPrice] = cost;
	pvData[i][cHealth] = 2000;
	pvData[i][cFuel] = 1000;
	format(pvData[i][cPlate], 16, "No Have");
	pvData[i][cPlateTime] = 0;
	pvData[i][cPosX] = x;
	pvData[i][cPosY] = y;
	pvData[i][cPosZ] = z;
	pvData[i][cPosA] = a;
	pvData[i][cInt] = 0;
	pvData[i][cVw] = 0;
	pvData[i][cLumber] = -1;
	pvData[i][cMetal] = 0;
	pvData[i][cCoal] = 0;
	pvData[i][cProduct] = 0;
	pvData[i][cGasOil] = 0;
	pvData[i][cMesinUpgrade] = 0;
	pvData[i][pvBodyUpgrade] = 0;
	pvData[i][cImpound] = 0;
	pvData[i][cRent] = 0;
	pvData[i][cCrack] = 0;
	pvData[i][cMaterial] = 0;
	pvData[i][cCgun] = 0;
	pvData[i][cComponent] = 0;
	pvData[i][cPark] = -1;
	pvData[i][cCrateComponent] = 0;
	pvData[i][cCrateFish] = 0;
	for(new j = 0; j < 10; j++)
	{
		pvData[i][cWeapon][i] = 0;
		pvData[i][cAmmo][i] = 0;
	}
	for(new j = 0; j < MAX_MODS; j++)
		pvData[i][cMod][j] = 0;
	Iter_Add(PVehicles, i);
	OnPlayerVehicleRespawn(i);
	SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"You have purchased a vehicle for "GREEN_E"%s "WHITE_E"with model {00FFFF}%s", FormatMoney(GetVehicleCostVIP(model)), GetVehicleModelName(model));
	PutPlayerInVehicle(playerid, pvData[i][cVeh], 0);
	pData[playerid][pBuyPvModel] = 0;
	return 1;
}

function RespawnPV(vehicleid)
{
	SetVehicleToRespawn(vehicleid);
	SetValidVehicleHealth(vehicleid, 1000);
	SetVehicleFuel(vehicleid, 1000);
	return 1;
}

Vehicle_WeaponStorage(playerid, vehicleid)
{
    foreach(new ii : PVehicles)
	{
		if(pvData[ii][cVeh] == vehicleid)
		{

			static
				string[320];

			string[0] = 0;

			for (new i = 0; i < 5; i ++)
			{
				if(!pvData[ii][cWeapon][i])
					format(string, sizeof(string), "%sEmpty Slot\n", string);

				else
					format(string, sizeof(string), "%s%s (Ammo: %d)\n", string, ReturnWeaponName(pvData[ii][cWeapon][i]), pvData[ii][cAmmo][i]);
			}
			ShowPlayerDialog(playerid, VEHICLE_WEAPONS, DIALOG_STYLE_LIST, "Weapon Storage", string, "Select", "Cancel");
		}
	}	
	return 1;
}

Vehicle_OpenStorage(playerid, vehicleid)
{
	foreach(new ii : PVehicles)
	{
		if(pvData[ii][cVeh] == vehicleid)
		{
			new
				items[1],
				string[212];

			for (new i = 0; i < 5; i ++) if(pvData[ii][cWeapon][i])
			{
				items[0]++;
			}
			pData[playerid][pUseVehicleid] = pvData[ii][cVeh];
			format(string, sizeof(string), "Weapon Storage (%d/5)\nComponent (%d/2000)\nMaterial (%d/2000)\n"RED_E"Cgun (%d/1000)\n"RED_E"Crack (%d/1000)", items[0], pvData[ii][cComponent], pvData[ii][cMaterial], pvData[ii][cCgun], pvData[ii][cCrack]);

			ShowPlayerDialog(playerid, VEHICLE_STORAGE, DIALOG_STYLE_LIST, "Trunk Storage", string, "Select", "Cancel");
		}	
	}	
    return 1;
}

// Private Vehicle Player System Commands
CMD:createpv(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
	
	new model, color1, color2, otherid;
	if(sscanf(params, "uddd", otherid, model, color1, color2)) return Usage(playerid, "/createpv [name/playerid] [model] [color1] [color2]");
	
	if(color1 < 0 || color1 > 255) { Error(playerid, "Color Number can't be below 0 or above 255 !"); return 1; }
    if(color2 < 0 || color2 > 255) { Error(playerid, "Color Number can't be below 0 or above 255 !"); return 1; }
    if(model < 400 || model > 611) { Error(playerid, "Vehicle Number can't be below 400 or above 611 !"); return 1; }
	if(otherid == INVALID_PLAYER_ID) return Error(playerid, "Invalid player ID!");
	new count = 0, limit = MAX_PLAYER_VEHICLE + pData[otherid][pVip];
	foreach(new ii : PVehicles)
	{
		if(pvData[ii][cOwner] == pData[otherid][pID])
			count++;
	}
	if(count >= limit)
	{
		Error(playerid, "This player have too many vehicles, sell a vehicle first!");
		return 1;
	}
	new cQuery[1024];
	new Float:x,Float:y,Float:z, Float:a;
    GetPlayerPos(otherid,x,y,z);
    GetPlayerFacingAngle(otherid,a);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[otherid][pID], model, color1, color2, x, y, z, a);
	mysql_tquery(g_SQL, cQuery, "OnVehCreated", "ddddddffff", playerid, otherid, pData[otherid][pID], model, color1, color2, x, y, z, a);
	return 1;
}

CMD:deletepv(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
		
	new vehid;
	if(sscanf(params, "d", vehid)) return Usage(playerid, "/deletepv [vehid] | /apv - for find vehid");
	if(vehid == INVALID_VEHICLE_ID) return Error(playerid, "Invalid id");
	if(vehid < 2) return Error(playerid, "Tidak bisa di bawah 1");		
	foreach(new i : PVehicles)			
	{
		if(vehid == pvData[i][cVeh])
		{
			Servers(playerid, "Your deleted private vehicle id %d (database id: %d).", vehid, pvData[i][cID]);
			new query[128];
			mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehicle WHERE id = '%d'", pvData[i][cID]);
			mysql_tquery(g_SQL, query);
			if(IsValidVehicle(pvData[i][cVeh])) DestroyVehicle(pvData[i][cVeh]);
			Iter_SafeRemove(PVehicles, i, i);
		}
	}
	return 1;
}

CMD:pvlist(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		return PermissionError(playerid);
	
	new count = 0, created = 0;
	foreach(new i : PVehicles)
	{
		count++;
		if(IsValidVehicle(pvData[i][cVeh]))
		{
			created++;
		}
	}
	SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"Foreach total: %d, Created: %d", count, created);
	return 1;
}

CMD:myinsu(playerid, params[])
{	
	new bool:found = false, msg2[512];
	format(msg2, sizeof(msg2), "Model(ID)\tPlate\tClaim time\n");
	foreach(new i : PVehicles)
	{
		if(pvData[i][cOwner] == pData[playerid][pID])
		{
			if(pvData[i][cClaim] > 0 && pvData[i][cClaimTime] > 0)
			{
				format(msg2, sizeof(msg2), "%s{00FFFF}%s(%d)\t"YELLOW_E"%s\t"GREEN_E"%s\n", msg2, GetVehicleModelName(pvData[i][cModel]), pvData[i][cVeh], pvData[i][cPlate], ReturnTimelapse(gettime(), pvData[i][cClaimTime]));
				found = true;
			}
		}
	}
	if(found)
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Insurance Vehicles", msg2, "Close", "");
	else
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Vehicles", "Player tidak memeliki kendaraan", "Close", "");
	return 1;
}

CMD:apv(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		return PermissionError(playerid);
	
	new otherid;
	if(sscanf(params, "u", otherid)) return Usage(playerid, "/apv [name/playerid]");
	if(otherid == INVALID_PLAYER_ID) return Error(playerid, "Invalid playerid");
	
	new bool:found = false, msg2[512];
	format(msg2, sizeof(msg2), "ID\tModel\tPlate Time\tRental\n");
	foreach(new i : PVehicles)
	{
		if(IsValidVehicle(pvData[i][cVeh]))
		{
			if(pvData[i][cOwner] == pData[otherid][pID])
			{
				if(strcmp(pvData[i][cPlate], "No Have"))
				{
					if(pvData[i][cRent] != 0)
					{
						format(msg2, sizeof(msg2), "%s%d\t%s(id: %d)\t%s(%s)\t%s\n", msg2, pvData[i][cVeh], GetVehicleModelName(pvData[i][cModel]), pvData[i][cVeh], pvData[i][cPlate], ReturnTimelapse(gettime(), pvData[i][cPlateTime]), ReturnTimelapse(gettime(), pvData[i][cRent]));
						found = true;
					}
					else
					{
						format(msg2, sizeof(msg2), "%s%d\t%s(id: %d)\t%s(%s)\tOwned\n", msg2, pvData[i][cVeh], GetVehicleModelName(pvData[i][cModel]), pvData[i][cVeh], pvData[i][cPlate], ReturnTimelapse(gettime(), pvData[i][cPlateTime]));
						found = true;
					}
				}
				else
				{
					if(pvData[i][cRent] != 0)
					{
						format(msg2, sizeof(msg2), "%s%d\t%s(id: %d)\t%s\t%s\n", msg2, pvData[i][cVeh], GetVehicleModelName(pvData[i][cModel]), pvData[i][cVeh], pvData[i][cPlate], ReturnTimelapse(gettime(), pvData[i][cRent]));
						found = true;
					}
					else
					{
						format(msg2, sizeof(msg2), "%s%d\t%s(id: %d)\t%s\tOwned\n", msg2, pvData[i][cVeh], GetVehicleModelName(pvData[i][cModel]), pvData[i][cVeh], pvData[i][cPlate]);
						found = true;
					}
				}
			}
		}
	}
	if(found)
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Player Vehicles", msg2, "Close", "");
	else
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Vehicles", "Player ini tidak memeliki kendaraan", "Close", "");
	return 1;
}

CMD:setspeed(playerid, params[])
{
    if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER) // mengambil state driver
    {
        new Float:speed;
        if(sscanf(params, "f", speed))
            return Usage(playerid, "/setspeed [speed / 0 untuk mematikan]"); // memberikan client message jika parameter float null
        if(speed > 200)
        	return Error(playerid, "tidak bisa di atas 200!");
        
        if(speed > 1.0)
        {
            SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"SetSpeed Lock %f", speed); // Memberikan Client Message saat vehicle Limit Berhasil di Execute
            SetVehicleSpeedCap(GetPlayerVehicleID(playerid), speed); // Function ini berguna untuk membatasi Kecepatan suatu Kendaraan terhadap Speed yang sudah di Execute
        }
        else if(speed < 1.0)
        {
            SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"Kamu Mematikan SetSpeed"); // Client Message disable
            DisableVehicleSpeedCap(GetPlayerVehicleID(playerid)); // mendisable Speed Limit jika angka float dibawah angka 1
        }
    }
    return 1;
}

CMD:aveh(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		return PermissionError(playerid);
		
	new vehicleid = GetNearestVehicleToPlayer(playerid, 5.0, false);

	if(vehicleid == INVALID_VEHICLE_ID)
		return Error(playerid, "You not in near any vehicles.");
	
	SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"Vehicle ID near on you id: %d (Model: %s(%d))", vehicleid, GetVehicleName(vehicleid), GetVehicleModel(vehicleid));
	return 1;
}

CMD:putpv(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		return PermissionError(playerid);
	new vehid;
	if(sscanf(params, "d", vehid)) return Usage(playerid, "/putpv [vehid] | /v my - for find vehid");
	if(vehid == INVALID_VEHICLE_ID) return Error(playerid, "Invalid id");
	if(!IsValidVehicle(vehid)) return Error(playerid, "Invalid veh id");
	PutPlayerInVehicle(playerid, vehid, 0);
	return 1;
}

CMD:pdveh(playerid, params[])
{
	if(pData[playerid][pFaction] != 1)
        return Error(playerid, "Anda bukan petugas kepolisian.");

	new vehicleid = GetNearestVehicleToPlayer(playerid, 5.0, false);

	if(vehicleid == INVALID_VEHICLE_ID)
		return Error(playerid, "You not in near any vehicles.");

	SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"Vehicle ID near on you id: "YELLOW_E"%d (Model: %s(%d))", vehicleid, GetVehicleName(vehicleid), GetVehicleModel(vehicleid));
	return 1;
}

CMD:sendveh(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		return PermissionError(playerid);
	
	new otherid, vehid, Float:x, Float:y, Float:z;
	if(sscanf(params, "ud", otherid, vehid)) return Usage(playerid, "/sendveh [playerid/name] [vehid] | /apv - for find vehid");
	
	if(!IsPlayerConnected(otherid)) return Error(playerid, "Player id not online!");
	if(!IsValidVehicle(vehid)) return Error(playerid, "Invalid veh id");
	
	GetPlayerPos(otherid, x, y, z);
	SetVehiclePos(vehid, x, y, z+0.5);
	SetVehicleVirtualWorld(vehid, GetPlayerVirtualWorld(otherid));
	LinkVehicleToInterior(vehid, GetPlayerInterior(otherid));
	SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"Your has send vehicle id %d to player %s(%d) | Location: %s.", vehid, pData[otherid][pName], otherid, GetLocation(x, y, z));
	return 1;
}

CMD:getveh(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		return PermissionError(playerid);
		
	new vehid, Float:posisiX, Float:posisiY, Float:posisiZ;
	if(sscanf(params, "d", vehid)) return Usage(playerid, "/getveh [vehid] | /apv - for find vehid");
	if(vehid == INVALID_VEHICLE_ID) return Error(playerid, "Invalid id");
	if(!IsValidVehicle(vehid)) return Error(playerid, "Invalid veh id");
	GetPlayerPos(playerid, posisiX, posisiY, posisiZ);
	SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"Your get spawn vehicle to %s (vehicle id: %d).", GetLocation(posisiX, posisiY, posisiZ), vehid);
	SetVehiclePos(vehid, posisiX, posisiY, posisiZ+0.5);
	SetVehicleVirtualWorld(vehid, GetPlayerVirtualWorld(playerid));
	LinkVehicleToInterior(vehid, GetPlayerInterior(playerid));
	PutPlayerInVehicle(playerid, vehid, 0);
	return 1;
}

CMD:gotoveh(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		return PermissionError(playerid);
		
	new vehid, Float:posisiX, Float:posisiY, Float:posisiZ;
	if(sscanf(params, "d", vehid)) return Usage(playerid, "/gotoveh [vehid] | /apv - for find vehid");
	if(vehid == INVALID_VEHICLE_ID) return Error(playerid, "Invalid id");
	if(!IsValidVehicle(vehid)) return Error(playerid, "Invalid id");
	
	GetVehiclePos(vehid, posisiX, posisiY, posisiZ);
	Servers(playerid, "Your teleport to %s (vehicle id: %d).", GetLocation(posisiX, posisiY, posisiZ), vehid);
	SetPlayerPosition(playerid, posisiX, posisiY, posisiZ+3.0, 4.0, 0);
	return 1;
}

CMD:respawnveh(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		return PermissionError(playerid);
		
	new vehid, Float:posisiX, Float:posisiY, Float:posisiZ;
	if(sscanf(params, "d", vehid)) return Usage(playerid, "/respawnveh [vehid] | /apv - for find vehid");
	if(vehid == INVALID_VEHICLE_ID) return Error(playerid, "Invalid id");
	if(!IsValidVehicle(vehid)) return Error(playerid, "Invalid id");
	GetVehiclePos(vehid, posisiX, posisiY, posisiZ);
	if(IsVehicleEmpty(vehid))
	{
		SetTimerEx("RespawnPV", 5000, false, "d", vehid);
		Servers(playerid, "Your respawned vehicle location %s (vehicle id: %d).", GetLocation(posisiX, posisiY, posisiZ), vehid);
	}
	else Error(playerid, "This Vehicle in used by someone.");
	return 1;
}

CMD:mv(playerid, params[])
{		
	new found = false, msg2[512], tsr[512];
	new Float:VPos[3];
	GetPlayerPos(playerid, VPos[0], VPos[1], VPos[2]);
	new count = 0, limit = MAX_PLAYER_VEHICLE + pData[playerid][pVip];
	foreach(new ii : PVehicles)
	{
		if(pvData[ii][cOwner] == pData[playerid][pID] && pvData[ii][cClaim] != 1)
			count++;
	}
	format(msg2, sizeof(msg2), "Model(ID)\tStatus\tDistance\n");
	for(new i = 0; i < MAX_VEHICLES; i++)
	{
		if(pvData[i][cClaim] == 1) continue;
		if(IsValidVehicle(pvData[i][cVeh]))
		{
			if(pvData[i][cOwner] == pData[playerid][pID])
			{
				new type[128];
				if(pvData[i][cImpound] == 1)
				{
					type= ""RED_E"(impound)";
				}
				else if(pvData[i][cImpound] == 2)
				{
					type= ""RED_E"(Tire Lock)";
				}
				else if(pvData[i][cImpound] == 4 || pvData[i][cPark] > -1)
				{
					type= ""YELLOW_E"(Despawned)";
				}
				else if(pvData[i][cLocked] == 1 && pvData[i][cImpound] == 0)
				{
					type= ""RED_E"(Lock)";
				}
				else if(pvData[i][cLocked] == 0 && pvData[i][cImpound] == 0)
				{
					type= ""YELLOW_E"(unlock)";
				}
				gListedItems[playerid][found] = i;
				format(msg2, sizeof(msg2), "%s%s(%d)\t%s\t"YELLOW_E"%.1f\n", msg2, GetVehicleModelName(pvData[i][cModel]), pvData[i][cVeh], type, GetDistanceBetweenPoints(VPos[0], VPos[1], VPos[2], pvData[i][cPosX], pvData[i][cPosY], pvData[i][cPosZ]));
				found++;
			}
		}
	}
	format(tsr, sizeof(tsr), "My Vehicle (%d/%d)", count, limit);
	if(found)
		ShowPlayerDialog(playerid, DIALOG_FINDVEH1, DIALOG_STYLE_TABLIST_HEADERS, tsr, msg2, "Select", "Close");
	else
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Vehicles", "Anda tidak memeliki kendaraan", "Close", "");
	return 1;
}

CMD:light(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{	
		if(!IsEngineVehicle(vehicleid))
		return SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"You are not in any vehicle.");
		
		switch(GetLightStatus(vehicleid))
		{
			case false:
			{
				SwitchVehicleLight(vehicleid, true);
				SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"Light {00D900}ON.");
				pvData[vehicleid][vELM] = false;
				SetVehicleNeonLights(pvData[vehicleid][cVeh], true, pvData[vehicleid][cNeon], 0);
				pvData[vehicleid][cTogNeon] = 1;
				for(new slot = 0; slot < MAX_VEHICLE_OBJECT; slot++)
				{ 
					if(VehicleObjects[vehicleid][slot][vehObjectExists] == true)
					{
						if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_LIGHT)
						{
							new
								model       = VehicleObjects[vehicleid][slot][vehObjectModel],
								Float:x     = VehicleObjects[vehicleid][slot][vehObjectPosX],
								Float:y     = VehicleObjects[vehicleid][slot][vehObjectPosY],
								Float:z     = VehicleObjects[vehicleid][slot][vehObjectPosZ],
								Float:rx    = VehicleObjects[vehicleid][slot][vehObjectPosRX],
								Float:ry    = VehicleObjects[vehicleid][slot][vehObjectPosRY],
								Float:rz    = VehicleObjects[vehicleid][slot][vehObjectPosRZ],
								Float:vposx,
								Float:vposy,
								Float:vposz
							;
							if(IsValidDynamicObject(VehicleObjects[vehicleid][slot][vehObject]))
							DestroyDynamicObject(VehicleObjects[vehicleid][slot][vehObject]);

							VehicleObjects[vehicleid][slot][vehObject] = INVALID_OBJECT_ID;

							GetVehiclePos(pvData[vehicleid][cVeh], vposx, vposy, vposz);

							VehicleObjects[vehicleid][slot][vehObject] = CreateDynamicObject(model, vposx, vposy, vposz, rx, ry, rz);

							Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_DRAW_DISTANCE, 25);
							Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_STREAM_DISTANCE, 25);

							AttachDynamicObjectToVehicle(VehicleObjects[vehicleid][slot][vehObject], pvData[vehicleid][cVeh], x, y, z, rx, ry, rz);
							Vehicle_ObjectUpdate(vehicleid, slot);
						}
					}
				}		
			}
			case true:
			{
				SwitchVehicleLight(vehicleid, false);
				SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"Light {FF0000}OFF.");
				pvData[vehicleid][vELM] = false;
				SetVehicleNeonLights(pvData[vehicleid][cVeh], false, pvData[vehicleid][cNeon], 0);
				pvData[vehicleid][cTogNeon] = 0;
				for(new slot = 0; slot < MAX_VEHICLE_OBJECT; slot++)
				{ 
					if(VehicleObjects[vehicleid][slot][vehObjectExists] == true)
					{
						
						if(IsValidDynamicObject(VehicleObjects[vehicleid][slot][vehObject]))
                    			DestroyDynamicObject(VehicleObjects[vehicleid][slot][vehObject]);
					}
				}	
			}
		}
	}
	else return SendClientMessageEx(playerid, COLOR_ARWIN, "Anda harus mengendarai kendaraan!");
	return 1;
}

CMD:hood(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid)) return Error(playerid, "You must exit from the vehicle.");
			
	new vehicleid = GetNearestVehicleToPlayer(playerid, 3.5, false);

	if(vehicleid == INVALID_VEHICLE_ID)
		return SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"You not in near any vehicles.");

	switch (GetHoodStatus(vehicleid))
	{
		case false:
		{
			SwitchVehicleBonnet(vehicleid, true);
			SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"Hood {00D900}Opened.");
		}
		case true:
		{
			SwitchVehicleBonnet(vehicleid, false);
			SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"Hood {FF0000}Closed.");
		}
	}
	return 1;
}

CMD:engine(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{	
		if(!IsEngineVehicle(vehicleid))
		return SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"You are not in any vehicle.");
		
		if(GetEngineStatus(vehicleid))
		{
			EngineStatus(playerid, vehicleid);
		}
		else
		{
			SendClientMessageEx(playerid, COLOR_ARWIN, "ENGINE: "WHITE_E"Anda mencoba menghidupkan Mesin.");
			SetTimerEx("EngineStatus", 3000, false, "id", playerid, vehicleid);
		}
	}
	else return SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"Anda harus mengendarai kendaraan!");
	return 1;
}

CMD:trunk(playerid, params[])
{
	new vehicleid = GetNearestVehicleToPlayer(playerid, 3.5, false);

	if(vehicleid == INVALID_VEHICLE_ID)
		return SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"You not in near any vehicles.");
	if(!IsABoat(vehicleid) && !IsABike(vehicleid) && !IsAPlane(vehicleid) && !IsAHelicopter(vehicleid))
	{
		Vehicle_OpenStorage(playerid, vehicleid);
		SwitchVehicleBoot(vehicleid, true);
	}
	return 1;
}

CMD:lock(playerid, params[])
{		
	new found = false, msg2[512];
	format(msg2, sizeof(msg2), "Vehicle\tStatus\n");
	for(new i = 0; i < MAX_VEHICLES; i++)
	{
		if(pvData[i][cOwner] == pData[playerid][pID] && pvData[i][cClaim] == 0)
		{
			new type[128];
			if(pvData[i][cLocked] == 1)
			{
				type= ""RED_E"Locked";
			}
			else if(pvData[i][cLocked] == 0)
			{
				type= ""YELLOW_E"Unlock";
			}
			gListedItems[playerid][found] = i;
			format(msg2, sizeof(msg2), "%s{00FFFF}%s\t%s\n", msg2, GetVehicleModelName(pvData[i][cModel]), type);
			found++;
		}
	}
	if(found)
		ShowPlayerDialog(playerid, DIALOG_LOCKVEHICLE, DIALOG_STYLE_TABLIST_HEADERS, "Vehicle Locking", msg2, "Select", "Close");
	return 1;
}

CMD:sellpv(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1657.9524,-1394.4664,13.5469)) return Error(playerid, "You must be at the insurance office");
	
	new vehid;
	if(sscanf(params, "d", vehid)) return Usage(playerid, "/sellpv [vehid] | /v my(mypv) - for find vehid");
	if(vehid == INVALID_VEHICLE_ID) return Error(playerid, "Invalid id");
			
	foreach(new i : PVehicles)
	{
		if(vehid == pvData[i][cVeh])
		{
			if(pvData[i][cOwner] == pData[playerid][pID])
			{
				if(!IsValidVehicle(pvData[i][cVeh])) return Error(playerid, "Your vehicle is not spanwed!");
				if(pvData[i][cRent] != 0) return Error(playerid, "You can't sell rental vehicle!");
				new pay = pvData[i][cPrice] / 90;

				GivePlayerMoneyEx(playerid, pay);
				
				SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"Anda menjual kendaraan model %s(%d) dengan seharga "LG_E"$%s", GetVehicleName(vehid), GetVehicleModel(vehid), FormatMoney(pay));
				new query[128];
				mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehicle WHERE id = '%d'", pvData[i][cID]);
				mysql_tquery(g_SQL, query);
				if(IsValidVehicle(pvData[i][cVeh])) DestroyVehicle(pvData[i][cVeh]);
				Iter_SafeRemove(PVehicles, i, i);
			}
			else return Error(playerid, "ID kendaraan ini bukan punya mu! gunakan /v my(/mypv) untuk mencari ID.");
		}
	}
	return 1;
}

CMD:buyinsu(playerid, params[])
{		
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1657.9524,-1394.4664,13.5469)) return Error(playerid, "You must be at the insurance office");
	new found = false, msg2[512];
	new Float:VPos[3];
	GetPlayerPos(playerid, VPos[0], VPos[1], VPos[2]);
	format(msg2, sizeof(msg2), "Model(ID)\tInsurance\tPrice\n");
	for(new i = 0; i < MAX_VEHICLES; i++)
	{
		if(pvData[i][cOwner] == pData[playerid][pID] && pvData[i][cImpound] == 0 && pvData[i][cClaim] == 0)
		{
			new price = pvData[i][cPrice] / 60;
			gListedItems[playerid][found] = i;
			format(msg2, sizeof(msg2), "%s{00FFFF}%s(%d)\t"YELLOW_E"%d\t"GREEN_E"$%s\n", msg2, GetVehicleModelName(pvData[i][cModel]), pvData[i][cVeh], pvData[i][cInsu], FormatMoney(price));
			found++;
		}
	}
	if(found)
		ShowPlayerDialog(playerid, DIALOG_BUYINSU, DIALOG_STYLE_TABLIST_HEADERS, "Buy Insurance", msg2, "Buy", "Close");
	return 1;
}

CMD:buyplate(playerid, params[])
{		
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1320.6910,739.4119,111.3203)) return Error(playerid, "You must be at the sapd");
	new found = false, msg2[512];
	format(msg2, sizeof(msg2), "Model(ID)\tPlate\tFine\n");
	for(new i = 0; i < MAX_VEHICLES; i++)
	{
		if(pvData[i][cOwner] == pData[playerid][pID])
		{
			new price = pvData[i][cPrice] / 95;
			gListedItems[playerid][found] = i;
			format(msg2, sizeof(msg2), "%s{00FFFF}%s(%d)\t"YELLOW_E"%s\t"GREEN_E"$%s\n", msg2, GetVehicleModelName(pvData[i][cModel]), pvData[i][cVeh], pvData[i][cPlate], FormatMoney(price));
			found++;
		}
	}
	if(found)
		ShowPlayerDialog(playerid, DIALOG_BUYPLATE, DIALOG_STYLE_TABLIST_HEADERS, "Claim Impound", msg2, "Claim", "Close");
	else Error(playerid, "Vehicle is not ready to bey claimed");
	return 1;
}

CMD:claiminsu(playerid, params[])
{		
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1657.9524,-1394.4664,13.5469)) return Error(playerid, "You must be at the insurance office");
	new found = false, msg2[512];
	format(msg2, sizeof(msg2), "Model(ID)\tPlate\tClaim time\n");
	for(new i = 0; i < MAX_VEHICLES; i++)
	{
		if(pvData[i][cClaim] == 1 && pvData[i][cClaimTime] == 0)
		{
			if(pvData[i][cOwner] == pData[playerid][pID])
			{
				gListedItems[playerid][found] = i;
				format(msg2, sizeof(msg2), "%s{00FFFF}%s(%d)\t"YELLOW_E"%s\t"GREEN_E"Now\n", msg2, GetVehicleModelName(pvData[i][cModel]), pvData[i][cVeh], pvData[i][cPlate]);
				found++;
			}
		}	
	}
	if(found)
		ShowPlayerDialog(playerid, DIALOG_CLAIMINSU, DIALOG_STYLE_TABLIST_HEADERS, "Claim Insurance", msg2, "Claim", "Close");
	else Error(playerid, "Vehicle is not ready to bey claimed, Use /myinsu to check you vehicle");
	return 1;
}

CMD:unimpound(playerid, params[])
{		
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 2820.2354, -1475.2073, 16.2500)) return Error(playerid, "You must be at the impound center");
	new found = false, msg2[512];
	format(msg2, sizeof(msg2), "Model(ID)\tPlate\tFine\n");
	for(new i = 0; i < MAX_VEHICLES; i++)
	{
		if(pvData[i][cImpound] == 1)
		{
			if(pvData[i][cOwner] == pData[playerid][pID])
			{
				new price = pvData[i][cPrice] / 25;
				gListedItems[playerid][found] = i;
				format(msg2, sizeof(msg2), "%s{00FFFF}%s(%d)\t"YELLOW_E"%s\t"GREEN_E"$%s\n", msg2, GetVehicleModelName(pvData[i][cModel]), pvData[i][cVeh], pvData[i][cPlate], FormatMoney(price));
				found++;
			}
		}	
	}
	if(found)
		ShowPlayerDialog(playerid, DIALOG_UNIMPOUND, DIALOG_STYLE_TABLIST_HEADERS, "Claim Impound", msg2, "Claim", "Close");
	else Error(playerid, "Vehicle is not ready to bey claimed");
	return 1;
}

CMD:unlocktire(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1320.6910,739.4119,111.3203)) return Error(playerid, "Anda harus berada di kantor polisi!");
	new vehicleid;
	if(GetPlayerMoney(playerid) < 10000) return Error(playerid, "You need $100.00 to unlock your vehicle");
	if(sscanf(params, "d", vehicleid)) return Usage(playerid, "/unlocktire [vehid] | /v my(mypv) - for find vehid");
	foreach(new i : PVehicles)
	{
		if(vehicleid == pvData[i][cVeh] && pvData[i][cImpound] == 2)
		{
			if(pvData[i][cOwner] == pData[playerid][pID])
			{
				pvData[i][cImpound] = 0;
				pvData[i][cTicketTime] = 0;
				GivePlayerMoneyEx(playerid, -10000);
				DestroyDynamic3DTextLabel(pvData[i][cLabelTire]);
				Info(playerid, "You have successfully claimed your vehicle that was hit by a tire lock");
			}
			else return Error(playerid, "ID kendaraan ini bukan punya mu! gunakan /v my(/mypv) untuk mencari ID.");
		}
	}
	return 1;
}

CMD:givepv(playerid, params[])
{
	new vehid, otherid;
	
	if(pData[playerid][pLevel] < 3)
	    return Error(playerid, "Anda harus level 3 untuk bisa melalukan akses ini");
	    
	if(sscanf(params, "ud", otherid, vehid)) return Usage(playerid, "/givepv [playerid/name] [vehid] | /v my(mypv) - for find vehid");
	
	if(vehid == INVALID_VEHICLE_ID) return Error(playerid, "Invalid id");

	if(!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 4.0))
        return Error(playerid, "The specified player is disconnected or not near you.");
    
	new count = 0, limit = MAX_PLAYER_VEHICLE + pData[otherid][pVip];
	foreach(new ii : PVehicles)
	{
		if(pvData[ii][cOwner] == pData[otherid][pID])
			count++;
	}
	if(count >= limit)
	{
		Error(playerid, "This player have too many vehicles, sell a vehicle first!");
		return 1;
	}
	foreach(new i : PVehicles)
	{
		if(vehid == pvData[i][cVeh])
		{
			if(pvData[i][cOwner] == pData[playerid][pID])
			{
				if(IsVIPVehicle(vehid) && !pData[otherid][pVip])
				{
					return Error(playerid, "You can't give a VIP vehicle to a player who isn't a VIP!");
				} 

				new nearid = GetNearestVehicleToPlayer(playerid, 5.0, false);
				if(vehid == nearid)
				{
					if(pvData[i][cRent] != 0) return Error(playerid, "You can't give rental vehicle!");
					SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"Anda memberikan kendaraan %s(%d) anda kepada %s.", GetVehicleName(vehid), GetVehicleModel(vehid), ReturnName(otherid));
					SendClientMessageEx(otherid, COLOR_ARWIN, "VEHICLE: "WHITE_E"%s Telah memberikan kendaraan %s(%d) kepada anda.(/mypv)", ReturnName(playerid), GetVehicleName(vehid), GetVehicleModel(vehid));
					pvData[i][cOwner] = pData[otherid][pID];
					new query[128];
					mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicle SET owner='%d' WHERE id='%d'", pData[otherid][pID], pvData[i][cID]);
					mysql_tquery(g_SQL, query);
					return 1;
				}
				else return Error(playerid, "Anda harus berada di dekat kendaraan yang anda jual!");
			}
			else return Error(playerid, "ID kendaraan ini bukan punya mu! gunakan /v my(/mypv) untuk mencari ID.");
		}
	}
	return 1;
}

CMD:tow(playerid, params[]) 
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		new carid = GetPlayerVehicleID(playerid);
		if(IsATowTruck(carid))
		{
			new closestcar = GetClosestCar(playerid, carid);

			if(GetDistanceToCar(playerid, closestcar) <= 8 && !IsTrailerAttachedToVehicle(carid)) 
			{

				SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"You has towed the vehicle in trailer.");
				AttachTrailerToVehicle(closestcar, carid);
				return 1;
			}
		}
		else
		{
			Error(playerid, "Anda harus mengendarai Tow truck.");
			return 1;
		}
	}
	else
	{
		Error(playerid, "Anda harus mengendarai Tow truck.");
		return 1;
	}
	return 1;
}

CMD:untow(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
		{
			SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"You has untowed the vehicle trailer.");
			DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));
		}
		else
		{
			Error(playerid, "Tow penderek kosong!");
		}
	}
	else
	{
		Error(playerid, "Anda harus mengendarai Tow truck.");
		return 1;
	}
	return 1;
}

GetDistanceToCar(playerid, veh, Float: posX = 0.0, Float: posY = 0.0, Float: posZ = 0.0) {

	new
	    Float: Floats[2][3];

	if(posX == 0.0 && posY == 0.0 && posZ == 0.0) {
		if(!IsPlayerInAnyVehicle(playerid)) GetPlayerPos(playerid, Floats[0][0], Floats[0][1], Floats[0][2]);
		else GetVehiclePos(GetPlayerVehicleID(playerid), Floats[0][0], Floats[0][1], Floats[0][2]);
	}
	else {
		Floats[0][0] = posX;
		Floats[0][1] = posY;
		Floats[0][2] = posZ;
	}
	GetVehiclePos(veh, Floats[1][0], Floats[1][1], Floats[1][2]);
	return floatround(floatsqroot((Floats[1][0] - Floats[0][0]) * (Floats[1][0] - Floats[0][0]) + (Floats[1][1] - Floats[0][1]) * (Floats[1][1] - Floats[0][1]) + (Floats[1][2] - Floats[0][2]) * (Floats[1][2] - Floats[0][2])));
}

GetClosestCar(playerid, exception = INVALID_VEHICLE_ID) 
{

    new
		Float: Distance,
		target = -1,
		Float: vPos[3];

	if(!IsPlayerInAnyVehicle(playerid)) GetPlayerPos(playerid, vPos[0], vPos[1], vPos[2]);
	else GetVehiclePos(GetPlayerVehicleID(playerid), vPos[0], vPos[1], vPos[2]);

    for(new v; v < MAX_VEHICLES; v++) if(GetVehicleModel(v) >= 400) {
        if(v != exception && (target < 0 || Distance > GetDistanceToCar(playerid, v, vPos[0], vPos[1], vPos[2]))) {
            target = v;
            Distance = GetDistanceToCar(playerid, v, vPos[0], vPos[1], vPos[2]); // Before the rewrite, we'd be running GetPlayerPos 2000 times...
        }
    }
    return target;
}

stock GetPlayerVehicle(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return -1;
	if(!GetVehicleModel(vehicleid)) return -1;
    for(new v = 0; v < MAX_VEHICLES; v++)
    {
        if(pvData[v][cID] == vehicleid)
        {
            return v;
        }
    }
    return -1;
}
