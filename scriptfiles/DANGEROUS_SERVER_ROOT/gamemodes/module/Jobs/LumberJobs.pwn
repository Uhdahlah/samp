

enum    E_TREE
{
	// loaded from db
	Float: treeX,
	Float: treeY,
	Float: treeZ,
	Float: treeRX,
	Float: treeRY,
	Float: treeRZ,
	// temp
	treeLumber,
	treeSeconds,
	bool: treeGettingCut,
	treeObjID,
	Text3D: treeLabel,
	treeTimer
}

new TreeData[MAX_TREES][E_TREE],
	Iterator:Trees<MAX_TREES>;
	
SetPlayerLookAt(playerid, Float:x, Float:y)
{
	// somewhere on samp forums, couldn't find the source
	new Float:Px, Float:Py, Float: Pa;
	GetPlayerPos(playerid, Px, Py, Pa);
	Pa = floatabs(atan((y-Py)/(x-Px)));
	if (x <= Px && y >= Py) Pa = floatsub(180, Pa);
	else if (x < Px && y < Py) Pa = floatadd(Pa, 180);
	else if (x >= Px && y <= Py) Pa = floatsub(360.0, Pa);
	Pa = floatsub(Pa, 90.0);
	if (Pa >= 360.0) Pa = floatsub(Pa, 360.0);
	SetPlayerFacingAngle(playerid, Pa);
}

GetClosestTree(playerid, Float: range = 3.0)
{
	new id = -1, Float: dist = range, Float: tempdist;
	foreach(new i : Trees)
	{
	    tempdist = GetPlayerDistanceFromPoint(playerid, TreeData[i][treeX], TreeData[i][treeY], TreeData[i][treeZ]);

	    if(tempdist > range) continue;
		if(tempdist <= dist)
		{
			dist = tempdist;
			id = i;
		}
	}
	return id;
}

Player_ResetCutting(playerid)
{
	if(!IsPlayerConnected(playerid) || pData[playerid][CuttingTreeID] == -1) return 0;
	new id = pData[playerid][CuttingTreeID];
	TreeData[id][treeGettingCut] = false;
	if(TreeData[id][treeSeconds] < 1) Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, TreeData[id][treeLabel], E_STREAMER_COLOR, 0x2ECC71FF);
	
	ClearAnimations(playerid);
    TogglePlayerControllable(playerid, 1);
    pData[playerid][CuttingTreeID] = -1;
    
    if(pData[playerid][pActivity] != -1)
	{
	    KillTimer(pData[playerid][pActivity]);
		pData[playerid][pActivity] = -1;
		pData[playerid][pActivityTime] = 0;
	}
	PlayerTextDrawHide(playerid, ActiveTD[playerid]);
	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
	return 1;
}

Player_DropLumber(playerid, death_drop = 0)
{
    if(!IsPlayerConnected(playerid) || !pData[playerid][CarryingLumber]) return 0;
    new id = Iter_Free(Lumbers);
    if(id != -1)
    {
        new Float: x, Float: y, Float: z, Float: a, label[128];
        GetPlayerPos(playerid, x, y, z);
        GetPlayerFacingAngle(playerid, a);
        GetPlayerName(playerid, LumberData[id][lumberDroppedBy], MAX_PLAYER_NAME);

		if(!death_drop)
		{
		    x += (1.0 * floatsin(-a, degrees));
			y += (1.0 * floatcos(-a, degrees));
			
			ApplyAnimation(playerid, "CARRY", "putdwn05", 4.1, 0, 1, 1, 0, 0, 1);
		}

		LumberData[id][lumberSeconds] = LUMBER_LIFETIME;
		LumberData[id][lumberObjID] = CreateDynamicObject(19793, x, y, z - 0.9, 0.0, 0.0, a);
		
		format(label, sizeof(label), "Lumber (%d)\n"WHITE_E"Dropped By "GREEN_E"%s\n"WHITE_E"%s\nUse /lumber pickup.", id, LumberData[id][lumberDroppedBy], ConvertToMinutes(LUMBER_LIFETIME));
		LumberData[id][lumberLabel] = CreateDynamic3DTextLabel(label, COLOR_GREEN, x, y, z - 0.7, 5.0, .testlos = 1);
		
		LumberData[id][lumberTimer] = SetTimerEx("RemoveLumber", 1000, true, "i", id);
		Iter_Add(Lumbers, id);
    }
    
    Player_RemoveLumber(playerid);
	return 1;
}

Player_RemoveLumber(playerid)
{
	if(!IsPlayerConnected(playerid) || !pData[playerid][CarryingLumber]) return 0;
	RemovePlayerAttachedObject(playerid, 9);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	pData[playerid][CarryingLumber] = false;
	return 1;
}

function RespawnTree(id)
{
	new label[96];
	if(TreeData[id][treeSeconds] > 1) 
	{
	    TreeData[id][treeSeconds]--;
	    
	    format(label, sizeof(label), "Tree (%d)\n{FFFFFF}%s", id, ConvertToMinutes(TreeData[id][treeSeconds]));
		UpdateDynamic3DTextLabelText(TreeData[id][treeLabel], COLOR_GREEN, label);
	}
	else if(TreeData[id][treeSeconds] == 1) 
	{
	    KillTimer(TreeData[id][treeTimer]);

	    TreeData[id][treeLumber] = 0;
	    TreeData[id][treeSeconds] = 0;
	    TreeData[id][treeTimer] = -1;
	    
	    SetDynamicObjectPos(TreeData[id][treeObjID], TreeData[id][treeX], TreeData[id][treeY], TreeData[id][treeZ]);
     	SetDynamicObjectRot(TreeData[id][treeObjID], TreeData[id][treeRX], TreeData[id][treeRY], TreeData[id][treeRZ]);
     	
     	format(label, sizeof(label), "Tree (%d)\n", id);
     	UpdateDynamic3DTextLabelText(TreeData[id][treeLabel], COLOR_GREEN, label);
	}
	return 1;
}
	
function LoadTrees()
{
    new tid;
	
	new rows = cache_num_rows();
 	if(rows)
  	{
		for(new i; i < rows; i++)
		{
			cache_get_value_name_int(i, "id", tid);
			cache_get_value_name_float(i, "posx", TreeData[tid][treeX]);
			cache_get_value_name_float(i, "posy", TreeData[tid][treeY]);
			cache_get_value_name_float(i, "posz", TreeData[tid][treeZ]);
			cache_get_value_name_float(i, "posrx", TreeData[tid][treeRX]);
			cache_get_value_name_float(i, "posry", TreeData[tid][treeRY]);
			cache_get_value_name_float(i, "posrz", TreeData[tid][treeRZ]);
			
			new label[64];
			format(label, sizeof(label), "Tree (%d)\n", tid);
			TreeData[tid][treeLabel] = CreateDynamic3DTextLabel(label, COLOR_GREEN, TreeData[tid][treeX], TreeData[tid][treeY], TreeData[tid][treeZ] + 1.5, 5.0);
			TreeData[tid][treeObjID] = CreateDynamicObject(657, TreeData[tid][treeX], TreeData[tid][treeY], TreeData[tid][treeZ], TreeData[tid][treeRX], TreeData[tid][treeRY], TreeData[tid][treeRZ]);
			Iter_Add(Trees, tid);
			
			TreeData[tid][treeGettingCut] = false;
			TreeData[tid][treeSeconds] = 0;
		}
		printf("*** [Database: Loaded] tree data (%d count).", rows);
	}
}

Tree_Save(tid)
{
	new cQuery[512];
	format(cQuery, sizeof(cQuery), "UPDATE trees SET posx='%f', posy='%f', posz='%f', posrx='%f', posry='%f', posrz='%f' WHERE id='%d'",
	TreeData[tid][treeX],
	TreeData[tid][treeY],
	TreeData[tid][treeZ],
	TreeData[tid][treeRX],
	TreeData[tid][treeRY],
	TreeData[tid][treeRZ],
	tid
	);
	return mysql_tquery(g_SQL, cQuery);
}

Tree_Refresh(tid)
{
    if(!Iter_Contains(Trees, tid)) return 0;
    new label[96];
    
    if(TreeData[tid][treeLumber] > 0) {
	    format(label, sizeof(label), "Tree (%d)\n"WHITE_E"Lumber: "GREEN_E"%d\n"WHITE_E"Use /lumber take.", tid, TreeData[tid][treeLumber]);
		UpdateDynamic3DTextLabelText(TreeData[tid][treeLabel], COLOR_GREEN, label);
	}else{
	    TreeData[tid][treeTimer] = SetTimerEx("RespawnTree", 1000, true, "i", tid);
	    
	    format(label, sizeof(label), "Tree (%d)\n"WHITE_E"%s", tid, ConvertToMinutes(TreeData[tid][treeSeconds]));
		UpdateDynamic3DTextLabelText(TreeData[tid][treeLabel], COLOR_GREEN, label);
	}
	
	return 1;
}

Tree_BeingEdited(tid)
{
	if(!Iter_Contains(Trees, tid)) return 0;
	foreach(new i : Player) if(pData[i][EditingTreeID] == tid) return 1;
	return 0;
}

ConvertToMinutes(time)
{
    // http://forum.sa-mp.com/showpost.php?p=3223897&postcount=11
    new string[15];//-2000000000:00 could happen, so make the string 15 chars to avoid any errors
    format(string, sizeof(string), "%02d:%02d", time / 60, time % 60);
    return string;
}

//untuk mencari pohon digps
GetAnyTree()
{
	new tmpcount;
	foreach(new id : Trees)
	{
     	tmpcount++;
	}
	return tmpcount;
}

ReturnTreeID(slot)
{
	new tmpcount;
	if(slot < 1 && slot > MAX_TREES) return -1;
	foreach(new id : Trees)
	{
        tmpcount++;
        if(tmpcount == slot)
        {
            return id;
        }
	}
	return -1;
}

//-------[ commands ]----------

CMD:createtree(playerid, params[])
{
	if(pData[playerid][pAdmin] < 4)
		return PermissionError(playerid);
	new tid = Iter_Free(Trees), query[512];
	if(tid == -1) return Error(playerid, "Can't add any more trees.");
 	new Float: x, Float: y, Float: z, Float: a;
 	GetPlayerPos(playerid, x, y, z);
 	GetPlayerFacingAngle(playerid, a);
 	x += (3.0 * floatsin(-a, degrees));
	y += (3.0 * floatcos(-a, degrees));
	z -= 1.0;
	
	TreeData[tid][treeX] = x;
	TreeData[tid][treeY] = y;
	TreeData[tid][treeZ] = z;
	TreeData[tid][treeRX] = TreeData[tid][treeRY] = TreeData[tid][treeRZ] = 0.0;
	
	new label[96];
	format(label, sizeof(label), "Tree (%d)\n", tid);
	TreeData[tid][treeLabel] = CreateDynamic3DTextLabel(label, COLOR_GREEN, TreeData[tid][treeX], TreeData[tid][treeY], TreeData[tid][treeZ] + 1.5, 5.0);
	TreeData[tid][treeObjID] = CreateDynamicObject(657, TreeData[tid][treeX], TreeData[tid][treeY], TreeData[tid][treeZ], TreeData[tid][treeRX], TreeData[tid][treeRY], TreeData[tid][treeRZ]);
	Iter_Add(Trees, tid);
	
	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO trees SET id='%d', posx='%f', posy='%f', posz='%f', posrx='%f', posry='%f', posrz='%f'", tid, TreeData[tid][treeX], TreeData[tid][treeY], TreeData[tid][treeZ], TreeData[tid][treeRX], TreeData[tid][treeRY], TreeData[tid][treeRZ]);
	mysql_tquery(g_SQL, query, "OnTreeCreated", "di", playerid, tid);
	return 1;
}

function OnTreeCreated(playerid, tid)
{
	Tree_Save(tid);
	
	pData[playerid][EditingTreeID] = tid;
	EditDynamicObject(playerid, TreeData[tid][treeObjID]);
	Servers(playerid, "Tree created.");
	Servers(playerid, "You can edit it right now, or cancel editing and edit it some other time.");
	return 1;
}

CMD:edittree(playerid, params[])
{
    if(pData[playerid][pAdmin] < 4)
		return PermissionError(playerid);
    if(pData[playerid][EditingTreeID] != -1) return Error(playerid, "You're already editing a tree.");
	new tid;
	if(sscanf(params, "i", tid)) return Usage(playerid, "/edittree [tree id]");
	if(!Iter_Contains(Trees, tid)) return Error(playerid, "Invalid ID.");
	if(TreeData[tid][treeGettingCut]) return Error(playerid, "Can't edit specified tree because its getting cut down.");
	if(!IsPlayerInRangeOfPoint(playerid, 30.0, TreeData[tid][treeX], TreeData[tid][treeY], TreeData[tid][treeZ])) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}You're not near the tree you want to edit.");
	pData[playerid][EditingTreeID] = tid;
	EditDynamicObject(playerid, TreeData[tid][treeObjID]);
	return 1;
}

CMD:removetree(playerid, params[])
{
    if(pData[playerid][pAdmin] < 4)
		return PermissionError(playerid);
		
	new tid, query[512];
	if(sscanf(params, "i", tid)) return Usage(playerid, "/removetree [tree id]");
	if(!Iter_Contains(Trees, tid)) return Error(playerid, "Invalid ID.");
	if(TreeData[tid][treeGettingCut]) return Error(playerid, "Can't remove specified tree because its getting cut down.");
	if(Tree_BeingEdited(tid)) return Error(playerid, "Can't remove specified tree because its being edited.");
	DestroyDynamicObject(TreeData[tid][treeObjID]);
	DestroyDynamic3DTextLabel(TreeData[tid][treeLabel]);
	if(TreeData[tid][treeTimer] != -1) KillTimer(TreeData[tid][treeTimer]);
	
	TreeData[tid][treeLumber] = TreeData[tid][treeSeconds] = 0;
	TreeData[tid][treeObjID] = TreeData[tid][treeTimer] = -1;
	TreeData[tid][treeLabel] = Text3D: -1;
	Iter_Remove(Trees, tid);
	
	mysql_format(g_SQL, query, sizeof(query), "DELETE FROM trees WHERE id=%d", tid);
	mysql_tquery(g_SQL, query);
	Servers(playerid, "Tree removed.");
	return 1;
}

CMD:gototree(playerid, params[])
{
	new tid;
	if(pData[playerid][pAdmin] < 4)
        return PermissionError(playerid);
		
	if(sscanf(params, "d", tid))
		return Usage(playerid, "/gototree [id]");
	if(!Iter_Contains(Trees, tid)) return Error(playerid, "The tree you specified ID of doesn't exist.");
	SetPlayerPosition(playerid, TreeData[tid][treeX], TreeData[tid][treeY], TreeData[tid][treeZ], 2.0);
	pData[playerid][pInBiz] = -1;
	pData[playerid][pInHouse] = -1;
	pData[playerid][pInDoor] = -1;
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
	Servers(playerid, "You has teleport to house id %d", tid);
	return 1;
}

CMD:buychainsaw(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, -1438.4968,-1544.1377,101.7578)) return Error(playerid, "You have to be at the lumber jack point");
	if(pData[playerid][pJob] == 3 || pData[playerid][pJob2] == 3)
	{
		GivePlayerWeaponEx(playerid, 9, 1);
		GivePlayerMoneyEx(playerid, -2500);
		SendClientMessageEx(playerid, COLOR_ARWIN, "LUMBER: "YELLOW_E"Anda telah membeli chainsaw dengan harga "GREEN_E"$25.00");
	}
	else return Error(playerid, "You are not Lumber Jack");
	return 1;
}

CMD:findtree(playerid, params[])
{
	if(pData[playerid][pJob] == 3 || pData[playerid][pJob2] == 3)
	{
		if(GetAnyTree() <= 0) return Error(playerid, "Tidak ada pohon yang terbuka.");
		new id, count = GetAnyTree(), location[4096], lstr[596];
		strcat(location,"No\tLocation\tDistance\n",sizeof(location));
		Loop(itt, (count + 1), 1)
		{
			id = ReturnTreeID(itt);
			if(itt == count)
			{
				format(lstr,sizeof(lstr), "%d\t%s\t%0.2fm\n", itt, GetLocation(TreeData[id][treeX], TreeData[id][treeY], TreeData[id][treeZ]), GetPlayerDistanceFromPoint(playerid, TreeData[id][treeX], TreeData[id][treeY], TreeData[id][treeZ]));
			}
			else format(lstr,sizeof(lstr), "%d\t%s\t%0.2fm\n", itt, GetLocation(TreeData[id][treeX], TreeData[id][treeY], TreeData[id][treeZ]), GetPlayerDistanceFromPoint(playerid, TreeData[id][treeX], TreeData[id][treeY], TreeData[id][treeZ]));
			strcat(location,lstr,sizeof(location));
		}
		ShowPlayerDialog(playerid, DIALOG_TRACKTREE, DIALOG_STYLE_TABLIST_HEADERS,"Track Tree",location,"Track","Cancel");
	}
	return 1;
}		
CMD:lumber(playerid, params[])
{
	if(pData[playerid][pJob] == 3 || pData[playerid][pJob2] == 3)
	{
		if(isnull(params)) return Usage(playerid, "/lumber [cut/take/load/pickup/sell]");
		
		if(!strcmp(params, "cut", true))
		{
			if(IsPlayerInAnyVehicle(playerid)) return Error(playerid, "Anda harus keluar dari kendaraan.");
			if(pData[playerid][CarryingLumber]) return Player_DropLumber(playerid);
				
			if(GetPlayerWeapon(playerid) == WEAPON_CHAINSAW && pData[playerid][CuttingTreeID] == -1 && !pData[playerid][CarryingLumber])
			{
				if(pData[playerid][pJobTime] > 0) return Error(playerid, "Anda harus menunggu "GREY2_E"%d "WHITE_E"menit untuk bisa bekerja kembali.", pData[playerid][pJobTime] / 10);
				
				new tid = GetClosestTree(playerid);

				if(tid != -1)
				{
					if(!Tree_BeingEdited(tid) && !TreeData[tid][treeGettingCut] && TreeData[tid][treeSeconds] < 1)
					{
						SetPlayerLookAt(playerid, TreeData[tid][treeX], TreeData[tid][treeY]);

						Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, TreeData[tid][treeLabel], E_STREAMER_COLOR, 0xE74C3CFF);
						pData[playerid][pActivity] = SetTimerEx("CutTree", 1000, true, "i", playerid);
						pData[playerid][CuttingTreeID] = tid;
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Cutting");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
						TogglePlayerControllable(playerid, 0);
						SetPlayerArmedWeapon(playerid, WEAPON_CHAINSAW);
						ApplyAnimation(playerid, "CHAINSAW", "WEAPON_csaw", 4.1, 1, 0, 0, 1, 0, 1);

						TreeData[tid][treeGettingCut] = true;
	
					}
					else return Error(playerid, "This tree is not ready.");
				}
				else return Error(playerid, "Invalid tree id");
			}
			else return Error(playerid, "You need to pickup the chainsaw.");
		}
		else if(!strcmp(params, "take", true))
		{
			if(IsPlayerInAnyVehicle(playerid)) return Error(playerid, "Anda harus keluar dari kendaraan.");
			// taking from a cut tree
			if(pData[playerid][CarryingLumber]) return Error(playerid, "You're already carrying a log.");
			new tid = GetClosestTree(playerid);
			if(tid == -1) return Error(playerid, "You're not near a tree.");
			if(TreeData[tid][treeSeconds] < 1) return Error(playerid, "This tree isn't cut.");
			if(TreeData[tid][treeLumber] < 1) return Error(playerid, "This tree doesn't have any logs.");
			TreeData[tid][treeLumber]--;
			Tree_Refresh(tid);
			
			Player_GiveLumber(playerid);
			Info(playerid, "You've taken a log from the cut tree.");
		}
		else if(!strcmp(params, "load", true))
		{
			if(IsPlayerInAnyVehicle(playerid)) return Error(playerid, "Anda harus keluar dari kendaraan.");
			// loading to a bobcat
			new carid = -1;
			if(!pData[playerid][CarryingLumber]) return Error(playerid, "You're not carrying a log.");
			new vehicleid = GetNearestVehicleToPlayer(playerid, 3.5, false);
			if(vehicleid == INVALID_VEHICLE_ID) return Error(playerid, "You not in near any vehicles.");
			if(!IsAPickup(vehicleid)) return Error(playerid, "You're not near a pickup car.");

			if(Vehicle_LumberCount(vehicleid) >= LUMBER_LIMIT) return Error(playerid, "You can't load any more logs to this vehicle.");
			if((carid = Vehicle_Nearest(playerid)) != -1)
			{
				if(IsValidVehicle(pvData[carid][cVeh]))
				{
					pvData[carid][cLumber] += 1;
					if(pvData[carid][cLumber] > 0)
					{
						if(IsValidVehicle(vehicleid))
						{
							if(IsValidDynamicObject(LumberObjects[pvData[carid][cVeh]]))
							{
								DestroyDynamicObject(LumberObjects[pvData[carid][cVeh]]);
							}

							if(GetVehicleModel(pvData[carid][cVeh]) == 422)
							{
								LumberObjects[pvData[carid][cVeh]] = CreateDynamicObject(1463,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
								AttachDynamicObjectToVehicle(LumberObjects[pvData[carid][cVeh]], pvData[carid][cVeh], 0.005, -1.440, -0.130, 0.000, 179.999, 90.899);
							}
							else if(GetVehicleModel(pvData[carid][cVeh]) == 478)
							{
								LumberObjects[pvData[carid][cVeh]] = CreateDynamicObject(1463,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
								AttachDynamicObjectToVehicle(LumberObjects[pvData[carid][cVeh]], pvData[carid][cVeh], 0.000, -1.420, 0.080, 180.000, 0.000, 90.000);
							}	
							else if(GetVehicleModel(pvData[carid][cVeh]) == 543)
							{
								LumberObjects[pvData[carid][cVeh]] = CreateDynamicObject(1463,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
								AttachDynamicObjectToVehicle(LumberObjects[pvData[carid][cVeh]], pvData[carid][cVeh], 0.000, -1.651, 0.000, 180.000, 0.000, 90.000);
							}
							else if(GetVehicleModel(pvData[carid][cVeh]) == 554)
							{
								LumberObjects[pvData[carid][cVeh]] = CreateDynamicObject(1463,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
								AttachDynamicObjectToVehicle(LumberObjects[pvData[carid][cVeh]], pvData[carid][cVeh], -0.070, -1.581, 0.100, 180.000, 0.000, 90.000);
							}
						}	
					} 
				}
			}
			
			Streamer_Update(playerid);
			Player_RemoveLumber(playerid);
		}
		else if(!strcmp(params, "sell")) 
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return Error(playerid, "You are not driver in pickup truck.");
			if(!IsValidVehicle(vehicleid)) return Error(playerid, "You're not in any vehicle.");
			if(Vehicle_LumberCount(vehicleid) < 1) return Error(playerid, "This vehicle doesn't have any logs.");
			if(IsPlayerInRangeOfPoint(playerid, 2.5, -1060.7466,-1195.4125,129.6377))
			{
				foreach(new pv : PVehicles)
				{
					if(vehicleid == pvData[pv][cVeh])
					{
						if(pvData[pv][cLumber] > 0)
						{
							new cash = pvData[pv][cLumber] * 2500;
							new list[212];
							SendClientMessage(playerid, COLOR_ARWIN, "SALARY: "WHITE_E"Your salary statement has been update, please check command "YELLOW_E"'/mysalary'");
							format(list, sizeof(list), "Sold %d timbers", pvData[pv][cLumber]);
							AddPlayerSalary(playerid, "Woody Wood Works", list, cash);
							SendClientMessageEx(playerid, COLOR_ARWIN, "LUMBER: {FFFFFF}You've unloaded "YELLOW_E"%d timber, You'il earn $%s", pvData[pv][cLumber], FormatMoney(pvData[pv][cLumber]*(2500)));
							pvData[pv][cLumber] = 0;
							if(IsValidDynamicObject(LumberObjects[pvData[pv][cVeh]]))
							{
								DestroyDynamicObject(LumberObjects[pvData[pv][cVeh]]);
							}
							TextDrawHideForPlayer(playerid, Crate[0]);
							TextDrawHideForPlayer(playerid, Crate[1]);
							PlayerTextDrawHide(playerid, PlayerCrate[playerid]);
						}
					}
				}		
				Streamer_Update(playerid);
			}		
		}
		else if(!strcmp(params, "pickup")) 
		{
			if(IsPlayerInAnyVehicle(playerid)) return Error(playerid, "Anda harus keluar dari kendaraan.");
			// taking from ground
			if(pData[playerid][CarryingLumber]) return Error(playerid, "You're already carrying a log.");
			new tid = GetClosestLumber(playerid);
			if(tid == -1) return Error(playerid, "You're not near a log.");
			LumberData[tid][lumberSeconds] = 1;
			RemoveLumber(tid);
			
			Player_GiveLumber(playerid);
			Info(playerid, "You've taken a log from ground.");
			// done
		}
	}
	else return Error(playerid, "anda bukan pekerja lumber!");
	return 1;
}

CMD:lum(playerid, params[]) return callcmd::lumber(playerid, params);

Vehicle_LumberCount(vehicleid)
{
	if(GetVehicleModel(vehicleid) == 0) return 0;
	new count = 0;
    foreach(new pv : PVehicles)
    {
        if(vehicleid == pvData[pv][cVeh])
        {
            count += pvData[pv][cLumber];
        }
    }    
	return count;
}

GetClosestLumber(playerid, Float: range = 2.0)
{
	new tid = -1, Float: dist = range, Float: tempdist, Float: pos[3];
	foreach(new i : Lumbers)
	{
		GetDynamicObjectPos(LumberData[i][lumberObjID], pos[0], pos[1], pos[2]);
	    tempdist = GetPlayerDistanceFromPoint(playerid, pos[0], pos[1], pos[2]);

	    if(tempdist > range) continue;
		if(tempdist <= dist)
		{
			dist = tempdist;
			tid = i;
		}
	}
	return tid;
}

Player_GiveLumber(playerid)
{
    if(!IsPlayerConnected(playerid)) return 0;
	pData[playerid][CarryingLumber] = true;
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
	SetPlayerAttachedObject(playerid, 9, 19793, 6, 0.077999, 0.043999, -0.170999, -13.799953, 79.70, 0.0);
	
	Info(playerid, "You can press "GREEN_E"'N' "WHITE_E"to drop your log.");
	return 1;
}

function CutTree(playerid)
{
    if(pData[playerid][CuttingTreeID] != -1)
	{
		new tid = pData[playerid][CuttingTreeID];
		
		if(pData[playerid][pActivityTime] >= 100)
		{
			TreeData[tid][treeLumber] = 5;
			TreeData[tid][treeSeconds] = TREE_RESPAWN;
			Player_ResetCutting(playerid);
			Tree_Refresh(tid);
			
			InfoTD_MSG(playerid, 8000, "Cutting tree done!");
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pActivityTime] = 0;
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pEnergy] -= 3;
			ClearAnimations(playerid);
			StopLoopingAnim(playerid);
			SetPlayerSpecialAction(playerid, 0);
			//TogglePlayerControllable(playerid, 1);
			MoveDynamicObject(TreeData[tid][treeObjID], TreeData[tid][treeX], TreeData[tid][treeY], TreeData[tid][treeZ] + 0.03, 0.025, TreeData[tid][treeRX], TreeData[tid][treeRY] - 80.0, TreeData[tid][treeRZ]);
			Streamer_Update(playerid);
			return 1;
		}
		else if(pData[playerid][pActivityTime] < 100)
		{
			pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
		}
	}

	return 1;
}

function RemoveLumber(tid)
{
	if(!Iter_Count(Lumbers, tid)) return 1;
	
	if(LumberData[tid][lumberSeconds] > 1) 
	{
	    LumberData[tid][lumberSeconds]--;

        new label[128];
	    format(label, sizeof(label), "Lumber (%d)\n"WHITE_E"Dropped By "GREEN_E"%s\n"WHITE_E"%s\nUse /lumber pickup.", tid, LumberData[tid][lumberDroppedBy], ConvertToMinutes(LumberData[tid][lumberSeconds]));
		UpdateDynamic3DTextLabelText(LumberData[tid][lumberLabel], COLOR_GREEN, label);
	}
	else if(LumberData[tid][lumberSeconds] == 1) 
	{
	    KillTimer(LumberData[tid][lumberTimer]);
	    DestroyDynamicObject(LumberData[tid][lumberObjID]);
		DestroyDynamic3DTextLabel(LumberData[tid][lumberLabel]);
		
	    LumberData[tid][lumberTimer] = -1;
        LumberData[tid][lumberObjID] = -1;
        LumberData[tid][lumberLabel] = Text3D: -1;

		Iter_Remove(Lumbers, tid);
	}
	
	return 1;
}
