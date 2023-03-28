
/*									__  __           ____________ _____  
						     /\   |  \/  |   /\    |___  /  ____|  __  |
    						/  \  | \  / |  /  \      / /| |__  | |  | |
   						   / /\ \ | |\/| | / /\ \    / / |  __| | |  | |
  						  / ____ \| |  | |/ ____ \  / /__| |____| |__| |
 						 /_/    \_\_|  |_/_/    \_\/_____|______|_____/													
                         				ROLEPLAY INDONESIA

                [+ ======================== Scripter ============================ +] 
                [+            == GAMEMODE SAMP PC INDONESIA ==                    +]
                [+            == Scripter: Diaz ==  	 				          +] 
                [+            == Version: v1.24 ==        						  +] 
                [+		      == GameMode Basic : Dandy				              +] 
                [+ ============================================================== +] 

Changelogs [13/08/2022]
[+] Dynamic Private Garage
[+] Dynamic Pickup
[+] Dynamic Pickup Rent
[+] Dyanmic Toll
[+] Farmer's Renew
- Seeds Wheat
- Seeds Onion
- Seeds Carrot
- Seeds Potato
- Seeds Corn
- '/loadplant [wheat,onion,carrot,potato,corn]'
- '/unloadplant [wheat,onion,carrot,potato,corn]'
[+] Salary Renew
[+] Crate Trucker Jobs Renew
[+] Information Textdraw Crate Trucker
[+] Add Object In Vehicle (Component)
[+] Add Audio URL(Music) Bisnis

ChangeLogs[17/08/2022]
[+] Renew Jobs Lumber Jack
[+] Information Textdraw Timber
[+] Fix Referrals Code

ChangeLogs[27/08/2022]
[+] Biznis
 - Fast Food Store
 - Market Store
 - Electronic Store
 - Sport Store
 [+] Fix Bug '/buytowtruck'
[+] Add Command '/findtree' 
[+] License Weapon
[+] License Heavy Trucker
[+] License Lumberjack
[+] Boat Repair
[+] Renew job Drugs Dealer
- Crack (+ Armor max 99)
- Pot (+ Armor max 25)
[+] Renew Job Arms Dealer
[+] Bus CD

ChangeLogs[03/09/2022]
Properti:
[+] Player Dealership
Player:
[+] License
- Heavy Trucker
- Boat 
- Weapon
[+] HBE Mode '/settings > HBE > Minimalist'
Jobs:
[+] Bus Driver Route C/D

ChangeLogs[17/09/2022] (LP: V1.11.1)
[+] Harga ikan berubah sesuai banyaknya yang menjual 
[+] Harga Plant(tanaman) berubah sesuai banyaknya yang menjual
[+] HBE Mode '/settings > HBE > Simple'
NOTE: Jika banyak yang menjual maka harga menurun begitu sebaliknya.


Event
LoadMap
Smuggle Jobs
Ask
Toys New
vRadio
ID Card
House Furniture
Flat Furniture 
Furniture Store
*/

#include <a_samp>
#undef  MAX_PLAYERS
#define MAX_PLAYERS 500
#define CGEN_MEMORY 60000
#include <crashdetect>
#include <gvar>
#include <a_mysql>
#include <a_actor>
#include <a_zones>
#include <progress2>
#include <Pawn.CMD>
#include <easyDialog> 
#include <TimestampToDate>
#define ENABLE_3D_TRYG_YSI_SUPPORT
#include <3DTryg>
#include <streamer>
#include <EVF2>
#include <YSI\y_timers>
#include <sscanf2> 
#include <yom_buttons>
#include <garageblock>
#include <timerfix>
#include <tp> // Anti Teleport
#include <attachments>
#include <selection> // New Selection Dialog
#include <eSelectionv2>             //by Emmet edited by Agus Syahputra
#include <discord-connector>
#include <discord-cmd>
#include <strlib>                   //by Slice
#include <editing>                  //by Pottus
#include <PreviewModelDialog>       //by Gammix
#include <CTime>                   //by Southclaws
//#include <weapon-config> // Custom Damage
#include <SKY> // Alias Custom Damage
//#include <sampvoice>

main(){}
//-----[ Modular Callback]-----
#include "./module/Server/Color.pwn"
#include "./module/mysql.pwn"
#include "./module/Define.pwn"
#include "./module/Variables.pwn"
#include "./module/Enums.pwn"
#include "./module/Textdraw.pwn"

//-----[ Modular Server ]-----
#include "./module/Server/Stock.pwn"
#include "./module/Server/FactionVehicle.pwn"
#include "./module/Server/Anims.pwn"
#include "./module/Server/Server.pwn"
#include "./module/Server/SchoolLicense.pwn"
#include "./module/Server/AllTexture.pwn"
//-----[ Modular Property]-----
#include "./module/Property/Farm.pwn"
#include "./module/Property/Family.pwn"
#include "./module/Property/House.pwn"
#include "./module/Property/Workshop.pwn"
#include "./module/Property/Bisnis.pwn"
#include "./module/Property/GasStation.pwn"
#include "./module/Property/Flat.pwn"
#include "./module/Property/FurnStore.pwn"

//-----[ Modular Dynamic]-----
#include "./module/Dynamic/DynamicDoor.pwn"
#include "./module/Dynamic/DynamicLocker.pwn"
#include "./module/Dynamic/DynamicGate.pwn"
#include "./module/Dynamic/DynamicAtm.pwn"
#include "./module/Dynamic/DynamicMapIcon.pwn"
#include "./module/Dynamic/DynamicPickup.pwn"
#include "./module/Dynamic/DynamicSpeedCam.pwn"
#include "./module/Dynamic/DynamicToll.pwn"
#include "./module/Dynamic/DyanmicActor.pwn"

//-----[ Modular Player]-----
#include "./module/Players/PlayerHelmet.pwn"
#include "./module/Players/AdsPlayer.pwn"
#include "./module/Players/Contatcs.pwn"
#include "./module/Players/SkillsPlayer.pwn"
#include "./module/Players/Voucher.pwn"
#include "./module/Players/Salary.pwn"
#include "./module/Players/Report.pwn"
#include "./module/Players/WeaponAttach.pwn"
#include "./module/Players/PlayerVehicle.pwn"
#include "./module/Players/MultiChar.pwn"
#include "./module/Players/PlayerRent.pwn"
#include "./module/Players/PlayerGarage.pwn"
#include "./module/Players/tags/core.pwn"
#include "./module/Players/Event.pwn"
#include "./module/Players/AskPlayer.pwn"
#include "./module/Players/ToysNew.pwn"
#include "./module/Players/vRadioPlayer.pwn"
#include "./module/Property/Dealership.pwn"

//-----[ Modular Jobs]-----
#include "./module/Jobs/ArmsDealer.pwn"
#include "./module/Jobs/TaxiJobs.pwn"
#include "./module/Jobs/MechaJobs.pwn"
#include "./module/Jobs/LumberJobs.pwn"
#include "./module/Jobs/TruckerJobs.pwn"
#include "./module/Jobs/FishJobs.pwn"
#include "./module/Jobs/SweeperJobs.pwn"
#include "./module/Jobs/FarmerJobs.pwn"
#include "./module/Jobs/ForkliftJobs.pwn"
#include "./module/Jobs/Cratetrucker.pwn"
#include "./module/Jobs/BusJobs.pwn"
#include "./module/Jobs/SmuggleJobs.pwn"
//-----[ Modular Command]-----
#include "./module/Cmd/AdminCmd.pwn"
#include "./module/Cmd/FactionCmd.pwn"
#include "./module/Cmd/PlayerCmd.pwn"
#include "./module/Cmd/Alias\AliasAdmin.pwn"
#include "./module/Cmd/Alias\AliasPlayers.pwn"
#include "./module/Cmd/Alias\AliasBisnis.pwn"
#include "./module/Cmd/Alias\AliasHouse.pwn"
#include "./module/Cmd/Alias\AliasPrivateVehicle.pwn"
//-----[ Modular Faction]-----
#include "./module/Faction//Taser.pwn"
#include "./module/Faction/Spike.pwn"
#include "./module/Faction/Elm.pwn"
#include "./module/Faction/RoadBlock.pwn"
// #include "./module/Faction/Gunrack.pwn"
//-----[ Modular Modshop]-----
#include "./module/Modshop/Modshop.pwn"
//-----[ Modular Server]-----
#include "./module/Server/Selection.pwn"
#include "./module/Server/Discord.pwn"
#include "./module/Server/MappingServer.pwn"
#include "./module/Server/ObjectCreator.pwn"
#include "./module/Server/Map.pwn"
#include "./module/Server/GreenZone.pwn"
//#include "./module/Server/AntiTapping.pwn"
//-----[ Modular Callback]-----
#include "./module/Function.pwn"
#include "./module/pTask.pwn"
#include "./module/Native.pwn"
#include "./module/OnPlayerLoad.pwn"
#include "./module/OnDialogResponse.pwn"

public OnGameModeInit()
{
	//mysql_log(ALL);
	new MySQLOpt: option_id = mysql_init_options();

	mysql_set_option(option_id, AUTO_RECONNECT, true);

	g_SQL = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DATABASE, option_id);
	if (g_SQL == MYSQL_INVALID_HANDLE || mysql_errno(g_SQL) != 0)
	{
		print("MySQL connection failed. Server is shutting down.");
		SendRconCommand("exit");
		return 1;
	}
	print("MySQL connection is successful.");

	mysql_tquery(g_SQL, "SELECT * FROM `server`", "LoadServer");
	mysql_tquery(g_SQL, "SELECT * FROM `doors`", "LoadDoors");
	mysql_tquery(g_SQL, "SELECT * FROM `familys`", "LoadFamilys");
	mysql_tquery(g_SQL, "SELECT * FROM `houses`", "LoadHouses");
	mysql_tquery(g_SQL, "SELECT * FROM `bisnis`", "LoadBisnis");
	mysql_tquery(g_SQL, "SELECT * FROM `lockers`", "LoadLockers");
	mysql_tquery(g_SQL, "SELECT * FROM `gstations`", "LoadGStations");
	mysql_tquery(g_SQL, "SELECT * FROM `atms`", "LoadATM");
	mysql_tquery(g_SQL, "SELECT * FROM `gates`", "LoadGates");
	mysql_tquery(g_SQL, "SELECT * FROM `trees`", "LoadTrees");
	mysql_tquery(g_SQL, "SELECT * FROM `plants`", "LoadPlants");
	mysql_tquery(g_SQL, "SELECT * FROM `workshops`", "LoadWorkshops");
	mysql_tquery(g_SQL, "SELECT * FROM `ladang`", "LoadFarm");
	mysql_tquery(g_SQL, "SELECT * FROM `cd`", "LoadcDealerships");
	mysql_tquery(g_SQL, "SELECT * FROM `rentplayer`", "Rent_Load");
	mysql_tquery(g_SQL, "SELECT * FROM `parks`", "LoadPark");
	mysql_tquery(g_SQL, "SELECT * FROM `maps`", "Maps_Load");
	mysql_tquery(g_SQL, "SELECT * FROM `objects`", "Object_Load");
	mysql_tquery(g_SQL, "SELECT * FROM `furnstore` ORDER BY `id` ASC", "FurnStore_Load");
	mysql_tquery(g_SQL, "SELECT * FROM `furnobject` ORDER BY `id` ASC", "FurnObject_Load");
	mysql_tquery(g_SQL, "SELECT * FROM `flat`", "Flat_Load");
  	mysql_tquery(g_SQL, "SELECT * FROM `flatroom`", "FlatRoom_Load");

	new gm[32];
	format(gm, sizeof(gm), "%s", TEXT_GAMEMODE);
	SetGameModeText(gm);
	format(gm, sizeof(gm), "weburl %s", TEXT_WEBURL);
	SendRconCommand(gm);

	format(gm, sizeof(gm), "language %s", TEXT_LANGUAGE);
	SendRconCommand(gm);
	SendRconCommand("mapname San Andreas");
	ManualVehicleEngineAndLights();
	EnableStuntBonusForAll(0);
	AllowInteriorWeapons(1);
	DisableInteriorEnterExits();
	LimitPlayerMarkerRadius(15.0);
	SetNameTagDrawDistance(0.0);
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_OFF);
	BlockGarages(.text="NO ENTER");
	SetWorldTime(WorldTime);
	SetWeather(WorldWeather);
	new hour;
	gettime(hour);
	SetWorldTime(hour);

	CreateTextDraw();
	CreateServerPoint();
	CreateArmsPoint();
	LoadTazerSAPD();
	CreateMapIcon();
	CreateVehicleFaction();
	AddDmvVehicle();
	MappingServer();
	DiscordOnGameMode();
	AddFurnStoreObject();
	MappingFlat();

	//DiscordAnnounOn();

	//Sapd Button
 	SAPDLobbyBtn[0] = CreateButton(1327.621704, 728.623413, 111.940315, 270.000000);
	SAPDLobbyBtn[1] = CreateButton(1327.881958, 730.843139, 111.940315, 450.000000);
	SAPDLobbyDoor[0] = CreateDynamicObject(1569, 1327.769531, 728.931030, 110.300323, 0.000000, 0.000000, 90.000000);
	// SAPDLobbyDoor[1] = CreateDynamicObject(1569, 1327.769531, 728.931030, 110.300323, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);

	// SAPDLobbyBtn[2] = CreateButton(239.82739, 116.12640, 1004.00238, 91.00000);
	// SAPDLobbyBtn[3] = CreateButton(238.75888, 116.12949, 1003.94086, 185.00000);
	// SAPDLobbyDoor[2] = CreateDynamicObject(1569, 239.69435, 116.15908, 1002.21411,   0.00000, 0.00000, 91.00000);
	// SAPDLobbyDoor[3] = CreateDynamicObject(1569, 239.64050, 119.08750, 1002.21332,   0.00000, 0.00000, 270.00000);

	fishzone[0] = CreateDynamicPolygon(zones_points_0);
    fishzone[1] = CreateDynamicCircle(zones_points_1[0], zones_points_1[1], zones_points_1[2]);
    fishzone[2] = CreateDynamicCircle(zones_points_2[0], zones_points_2[1], zones_points_2[2]);
    fishzone[3] = CreateDynamicCircle(zones_points_3[0], zones_points_3[1], zones_points_3[2]);
    fishzone[4] = CreateDynamicCircle(zones_points_4[0], zones_points_4[1], zones_points_4[2]);
    fishzone[5] = CreateDynamicCircle(zones_points_5[0], zones_points_5[1], zones_points_5[2]);
    fishzone[6] = CreateDynamicRectangle(zones_points_6[0], zones_points_6[1], zones_points_6[2], zones_points_6[3]);
    fishzone[7] = CreateDynamicPolygon(zones_points_7);
    fishzone[8] = CreateDynamicPolygon(zones_points_8);
    fishzone[9] = CreateDynamicPolygon(zones_points_9);
    fishzone[10] = CreateDynamicPolygon(zones_points_10);
    fishzone[11] = CreateDynamicRectangle(zones_points_11[0], zones_points_11[1], zones_points_11[2], zones_points_11[3]);
	fishzone[12] = CreateDynamicPolygon(zones_points_12);
	fishzone[13] = CreateDynamicPolygon(zones_points_13);
	fishzone[14] = CreateDynamicPolygon(zones_points_14);
	fishzone[15] = CreateDynamicPolygon(zones_points_15);
	fishzone[16] = CreateDynamicPolygon(zones_points_16);

	printf("[Object] Number of Dynamic objects loaded: %d", CountDynamicObjects());
	return 1;
}

public OnGameModeExit()
{
   	print("\n--------------------------------------");
	print("./SERVER DIMATIKAN / DIRESTART");
	mysql_tquery(g_SQL, "UPDATE * FROM `bisnis`", "Bisnis_Save");
	
	new count = 0, count1 = 0;
	foreach(new gsid : GStation)
	{
		if(Iter_Contains(GStation, gsid))
		{
			count++;
			GStation_Save(gsid);
		}
	}
	printf("[Gas Station] Number of Saved: %d", count);
	
	foreach(new pid : Plants)
	{
		if(Iter_Contains(Plants, pid))
		{
			count1++;
			Plant_Save(pid);
		}
	}
	printf("[Farmer Plant] Number of Saved: %d", count1);
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i++) 
	{
		if (IsPlayerConnected(i))
		{
			OnPlayerDisconnect(i, 1);
		}
	}
	UnloadTazerSAPD();
	mysql_close(g_SQL);
	//DiscordAnnounOff();
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	if(pData[playerid][IsLoggedIn]==true)return true;
	if(!pData[playerid][IsLoggedIn])
	{
		new query[103];
		mysql_format(g_SQL, query, sizeof query, "SELECT * FROM `ucp` WHERE `username` = '%e' LIMIT 1", charData[playerid][cName]);
		mysql_pquery(g_SQL, query, "OnPlayerDataLoaded", "dd", playerid, g_MysqlRaceCheck[playerid]);
    }
	return true;
}

public OnPlayerConnect(playerid)
{
	new PlayerIP[16];
	g_MysqlRaceCheck[playerid]++;
	// playeronline++;
	ResetVariables(playerid);
	CreatePlayerTextDraws(playerid);
	GetPlayerName(playerid, charData[playerid][cName], MAX_PLAYER_NAME);
	GetPlayerIp(playerid, PlayerIP, sizeof(PlayerIP));
	pData[playerid][pIP] = PlayerIP;
	SetPlayerColor(playerid, COLOR_WHITE);
	pData[playerid][activitybar] = CreatePlayerProgressBar(playerid, 268.000000, 228.000000, 116.500000, 13.500000, 1296911871, 100.000000, 0);
	RemoveMappingServer(playerid);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    KillTimer(pData[playerid][LoginTimer]);
	KillTimer(pData[playerid][pFreezeTimer]);
	KillTimer(pData[playerid][pDragTimer]);
	KillTimer(pData[playerid][pFareTimer]);
	KillTimer(pData[playerid][pActivity]);
	KillTimer(pData[playerid][pMechanic]);
	KillTimer(pData[playerid][pProducting]);
	KillTimer(pData[playerid][pCooking]);
	KillTimer(pData[playerid][pArmsDealer]);
	g_MysqlRaceCheck[playerid]++;
	// playeronline--;
	if(pData[playerid][IsLoggedIn] == true)
	{
		UpdatePlayerData(playerid);	
		RemovePlayerVehicle(playerid);
		Player_ResetCutting(playerid);
		Player_RemoveLumber(playerid);
		Player_ResetHarvest(playerid);
		Advertisement_Remove(playerid);
		if(IsValidDynamic3DTextLabel(pData[playerid][pAdoTag]))
            DestroyDynamic3DTextLabel(pData[playerid][pAdoTag]);
			
		if(IsValidDynamicObject(pData[playerid][pFlare]))
				DestroyDynamicObject(pData[playerid][pFlare]);

		if (pData[playerid][LoginTimer])
		{
			KillTimer(pData[playerid][LoginTimer]);
			pData[playerid][LoginTimer] = 0;
		}
		pData[playerid][IsLoggedIn] = false;	
		pData[playerid][pAdoActive] = false;
		ResetVariables(playerid);
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		foreach(new ii : Player)
		{
			new dc[212];
			if(IsPlayerInRangeOfPoint(ii, 40.0, x, y, z))
			{
				switch(reason)
				{
					case 0:
					{
						SendClientMessageEx(ii, COLOR_ARWIN, "SERVER: "RED_E"%s "YELLOW_E"has leave from the server.(timeout/crash)", ReturnName(playerid));
						format(dc, sizeof(dc),  "```SERVER: %s has leave from the server.(timeout/crash)```", ReturnName(playerid));
						// DCC_SendChannelMessage(LogsPlayer, dc);
					}
					case 1:
					{
						SendClientMessageEx(ii, COLOR_ARWIN, "SERVER: "RED_E"%s "YELLOW_E"has leave from the server.(leaving)", ReturnName(playerid));
						format(dc, sizeof(dc),  "```SERVER: %s has leave from the server.(leaving)```", ReturnName(playerid));
						// DCC_SendChannelMessage(LogsPlayer, dc);
					}
					case 2:
					{
						SendClientMessageEx(ii, COLOR_ARWIN, "SERVER: "RED_E"%s "YELLOW_E"has leave from the server.(kicked/banned)", ReturnName(playerid));
						format(dc, sizeof(dc),  "```SERVER: %s has leave from the server.(kicked/banned)```", ReturnName(playerid));
						// DCC_SendChannelMessage(LogsPlayer, dc);
					}
				}
			}
		}
		for (new id = 0; id != MAX_ACC; id++) if(AccData[playerid][id][accExists]) 
		{
			MySQL_SavePlayerToys(playerid, id);
		}
		KillTazerTimer(playerid);
		StopAudioStreamForPlayer(playerid);
		
		if(GetPVarType(playerid, "PlacedBB"))
		{
			DestroyDynamicObject(GetPVarInt(playerid, "PlacedBB"));
			DestroyDynamic3DTextLabel(Text3D:GetPVarInt(playerid, "BBLabel"));
			if(GetPVarType(playerid, "BBArea"))
			{
				foreach(new i : Player)
				{
					if(IsPlayerInDynamicArea(i, GetPVarInt(playerid, "BBArea")))
					{
						StopAudioStreamForPlayer(i);
						Info(playerid, "The boombox creator has disconnected from the server.");
					}
				}
			}
		}
		for(new i; i <= 11; i++) // 9 = Total Dialog , Jadi kita mau tau kalau Player Ini Apakah Ambil Dialog dari 3 tersebut apa ga !
		{
			if(DialogSaya[playerid][i] == true) // Cari apakah dia punya salah satu diantara 10 dialog tersebut
			{
				DialogSaya[playerid][i] = false; // Ubah Jadi Dia ga punya dialog lagi Kalau Udah Disconnect (Bukan dia lagi pemilik)
				DialogHauling[i] = false; // Jadi ga ada yang punya nih dialog
				DestroyVehicle(TrailerHauling[playerid]);
			}
		}
		new vehicleid = GetPlayerVehicleID(playerid);
		for(new i = 0; i < 3; i++) 
		{
			if(DialogBus[i] == true) 
			{
				DialogBus[i] = false; // Jadi ga ada yang punya nih dialog
				SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			}
		}
		for(new i = 0; i < 3; i++) 
		{
			if(DialogBusCD[i] == true) 
			{
				DialogBusCD[i] = false; // Jadi ga ada yang punya nih dialog
				SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			}
		}
		for(new i = 0; i < 3; i++) 
		{
			if(DialogSweeper[i] == true) 
			{
				DialogSweeper[i] = false; // Jadi ga ada yang punya nih dialog
				SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			}
		}
		if(IsAForkliftVeh(vehicleid))
		{
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			DisablePlayerCheckpoint(playerid);
		}
	}
 	return 1;
}

public OnPlayerSpawn(playerid)
{
	TextDrawShowForPlayer(playerid, TDServerName);
	StopAudioStreamForPlayer(playerid);
	SetPlayerInterior(playerid, pData[playerid][pInt]);
	SetPlayerVirtualWorld(playerid, pData[playerid][pWorld]);
	SetPlayerPos(playerid, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]);
	SetPlayerFacingAngle(playerid, pData[playerid][pPosA]);
	SetCameraBehindPlayer(playerid);
	TogglePlayerControllable(playerid, 0);

 	SetPlayerSpawn(playerid);
	SetPlayerSkillLevel(playerid, WEAPON_SILENCED, 1);
	SetPlayerSkillLevel(playerid, WEAPON_DEAGLE, 1);
	SetPlayerSkillLevel(playerid, WEAPON_SHOTGUN, 1);
	SetPlayerSkillLevel(playerid, WEAPON_SAWEDOFF, 1);
	SetPlayerSkillLevel(playerid, WEAPON_SHOTGSPA, 1);
	SetPlayerSkillLevel(playerid, WEAPON_UZI, 1);
	SetPlayerSkillLevel(playerid, WEAPON_MP5, 1);
	SetPlayerSkillLevel(playerid, WEAPON_AK47, 1);
	SetPlayerSkillLevel(playerid, WEAPON_M4, 1);
	SetPlayerSkillLevel(playerid, WEAPON_TEC9, 1);
	SetPlayerSkillLevel(playerid, WEAPON_RIFLE, 1);
	SetPlayerSkillLevel(playerid, WEAPON_SNIPER, 1);
	SetPlayerFightingStyle(playerid, pData[playerid][FightStyle]);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    KillTimer(pData[playerid][pArmsDealer]);
    KillTimer(pData[playerid][LoginTimer]);
	KillTimer(pData[playerid][pFreezeTimer]);
	KillTimer(pData[playerid][pDragTimer]);
	KillTimer(pData[playerid][pFareTimer]);
	KillTimer(pData[playerid][pActivity]);
	KillTimer(pData[playerid][pMechanic]);
	KillTimer(pData[playerid][pProducting]);
	KillTimer(pData[playerid][pCooking]);
	DeletePVar(playerid, "UsingSprunk");
	SetPVarInt(playerid, "GiveUptime", -1);
	pData[playerid][pSpawned] = 0;
	Player_ResetCutting(playerid);
	Player_RemoveLumber(playerid);
	Player_ResetHarvest(playerid);
	pData[playerid][CarryProduct] = 0;
	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
	PlayerTextDrawHide(playerid, ActiveTD[playerid]);
	pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
	pData[playerid][pActivityTime] = 0;
	
	pData[playerid][pMechDuty] = 0;
	pData[playerid][pTaxiDuty] = 0;
	pData[playerid][pMission] = -1;
	
	pData[playerid][pSideJob] = 0;
	DisablePlayerCheckpoint(playerid);
	DisablePlayerRaceCheckpoint(playerid);
	SetPlayerColor(playerid, COLOR_WHITE);
	RemovePlayerAttachedObject(playerid, 9);
	GetPlayerPos(playerid, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]);
	new weaponid = GetPlayerWeaponEx(playerid);
	foreach(new ii : Player)
    {
        if(pData[ii][pAdmin] > 0)
        {
            SendDeathMessageToPlayer(ii, killerid, playerid, reason);
        }
    }
 	if(pData[playerid][pJail] < 1)
    {
		if(pData[playerid][pInjured] == 0)
        {	
        	static
			Float:x,
			Float:y,
			Float:z,
			Float:angle;

			GetPlayerPos(playerid, x, y, z);
			GetPlayerFacingAngle(playerid, angle);
			x += 1 * floatsin(-angle, degrees);
			y += 1 * floatcos(-angle, degrees);
        	DropWeapon(pData[playerid][pName], GetWeaponModel(weaponid), weaponid, GetPlayerAmmo(playerid), x, y, z - 1, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
			ResetWeapon(playerid, weaponid);
            pData[playerid][pInjured] = 1;
            SetPlayerHealthEx(playerid, 100);

            pData[playerid][pInt] = GetPlayerInterior(playerid);
            pData[playerid][pWorld] = GetPlayerVirtualWorld(playerid);

            GetPlayerPos(playerid, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]);
            GetPlayerFacingAngle(playerid, pData[playerid][pPosA]);
        }
        else
        {
            pData[playerid][pHospital] = 1;
        }
	}
	SetPlayerArmedWeapon(playerid, 0);
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if(isnull(text)) return 0;
	
	printf("[CHAT] %s(%d) : %s", pData[playerid][pName], playerid, text);
	
	if(pData[playerid][pSpawned] == 0 && pData[playerid][IsLoggedIn] == false)
	{
	    Error(playerid, "You must be spawned or logged in to use chat.");
	    return 0;
	}
	if(pData[playerid][pTogChat] == 1)
	{
		text[0] = toupper(text[0]);
		if(text[0] == '@')
		{
			if(pData[playerid][pSMS] != 0)
			{
				if(pData[playerid][pPhoneCredit] < 1)
				{
					Error(playerid, "You dont have phone credits!");
					return 0;
				}
				if(pData[playerid][pInjured] != 0)
				{
					Error(playerid, "You cant do at this time.");
					return 0;
				}
				new tmp[512];
				foreach(new ii : Player)
				{
					if(text[1] == ' ')
					{
						format(tmp, sizeof(tmp), "%s", text[2]);
					}
					else
					{
						format(tmp, sizeof(tmp), "%s", text[1]);
					}
					if(pData[ii][pPhone] == pData[playerid][pSMS])
					{
						if(ii == INVALID_PLAYER_ID || !IsPlayerConnected(ii))
						{
							Error(playerid, "This number is not actived!");
							return 0;
						}
						new String[555];
						SendClientMessageEx(playerid, COLOR_ARWIN, "SMS: {FFFF00}Message sent");
						SendClientMessageEx(playerid, COLOR_WHITE, "AME: {C2A2DA}types something to his cellphone");
						format(String, sizeof(String), "types something to his cellphone");
						SetPlayerChatBubble(playerid, String, COLOR_PURPLE, 5.0, 5000);
						format(String, sizeof(String), "SMS: {ffffff}You have received one new message from '{ffff00}%d{ffffff}'", pData[playerid][pPhone]);
						SendClientMessageEx(ii, COLOR_RED, String);	
						format(String, sizeof(String), "Message: {ffff00}%s", tmp);
						SendClientMessageEx(ii, COLOR_RED, String);
						PlayerPlaySound(ii, 6003, 0,0,0);
						pData[ii][pSMS] = pData[playerid][pPhone];
						
						pData[playerid][pPhoneCredit] -= 1;
						return 0;
					}
				}
			}
		}
		if(pData[playerid][pCall] != INVALID_PLAYER_ID)
		{
			// Anti-Caps
			if(GetPVarType(playerid, "Caps"))
				UpperToLower(text);
			new lstr[1024];
			format(lstr, sizeof(lstr), "%s [phone]: %s", ReturnName(playerid), text);
			ProxDetector(10, playerid, lstr, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
			for (new i = 0; i != MAX_CONTACTS; i ++) if (ContactData[playerid][i][contactExists]) 
			{
				if(pData[pData[playerid][pCall]][pPhone] == ContactData[playerid][i][contactNumber])
				{
					SendClientMessageEx(pData[playerid][pCall], COLOR_YELLOW, "%s Caller [phone]: "WHITE_E"%s.", ContactData[playerid][i][contactName], text);	
				}
				else
				{
					new sext[40];
					if(pData[pData[playerid][pCall]][pGender] == 1) { sext = "Male"; } else { sext = "Female"; }
					SendClientMessageEx(pData[playerid][pCall], COLOR_YELLOW, "%s Caller [phone]: "WHITE_E"%s.", sext, text);	
				}
			}
		}
		if(Mobile[playerid] != INVALID_PLAYER_ID)
		{
			if(Mobile[playerid] == 914)
			{
				new String[211];
				if(!text[0])
				{
					SendClientMessageEx(playerid, COLOR_ARWIN, "Dispatch: Sorry, I don't understand?");
					return 0;
				}
				SendFactionMessage(3, COLOR_ARWIN, "{00FFFF}Emergency Services");
				format(String, sizeof(String), "{00FFFF}Crime Description: "RED_E"%s", text);
				SendFactionMessage(3, COLOR_ARWIN, String);
				format(String, sizeof(String), "{00FFFF}Dispatch Name: "WHITE_E"["YELLOW_E"%s"WHITE_E"] Ph: ["YELLOW_E"%d"WHITE_E"]", pData[playerid][pName], pData[playerid][pPhone]);
				SendFactionMessage(3, COLOR_ARWIN, String);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
				pData[playerid][pCall] = INVALID_PLAYER_ID;
				Mobile[playerid] = INVALID_PLAYER_ID;
				return 0;
			}
			if(Mobile[playerid] == 888)
			{
				new String[211];
				SendFactionMessage(2, COLOR_ARWIN, "{00FFFF}SAGS Call Center");
				format(String, sizeof(String), "{00FFFF}Crime Description: "RED_E"%s", text);
				SendFactionMessage(2, COLOR_ARWIN, String);
				format(String, sizeof(String), "{00FFFF}Dispatch Name: "WHITE_E"["YELLOW_E"%s"WHITE_E"] Ph: ["YELLOW_E"%d"WHITE_E"]", pData[playerid][pName], pData[playerid][pPhone]);
				SendFactionMessage(2, COLOR_ARWIN, String);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
				pData[playerid][pCall] = INVALID_PLAYER_ID;
				Mobile[playerid] = INVALID_PLAYER_ID;
				return 0;
			}
			if(Mobile[playerid] == 777)
			{
				new String[211];
				SendFactionMessage(3, COLOR_ARWIN, "{00FFFF}Non-Emergency Services");
				format(String, sizeof(String), "{00FFFF}Crime Description: "RED_E"%s", text);
				SendFactionMessage(3, COLOR_ARWIN, String);
				format(String, sizeof(String), "{00FFFF}Dispatch Name: "WHITE_E"["YELLOW_E"%s"WHITE_E"] Ph: ["YELLOW_E"%d"WHITE_E"]", pData[playerid][pName], pData[playerid][pPhone]);
				SendFactionMessage(3, COLOR_ARWIN, String);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
				pData[playerid][pCall] = INVALID_PLAYER_ID;
				Mobile[playerid] = INVALID_PLAYER_ID;
				return 0;
			}
			if(Mobile[playerid] == 555)
			{
				new String[211];
				SendFactionMessage(1, COLOR_ARWIN, "{00FFFF}Non-Emergency Services");
				format(String, sizeof(String), "{00FFFF}Crime Description: "RED_E"%s", text);
				SendFactionMessage(1, COLOR_ARWIN, String);
				format(String, sizeof(String), "{00FFFF}Dispatch Name: "WHITE_E"["YELLOW_E"%s"WHITE_E"] Ph: ["YELLOW_E"%d"WHITE_E"]", pData[playerid][pName], pData[playerid][pPhone]);
				SendFactionMessage(1, COLOR_ARWIN, String);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
				pData[playerid][pCall] = INVALID_PLAYER_ID;
				Mobile[playerid] = INVALID_PLAYER_ID;
				return 0;
			}
			if(Mobile[playerid] == 913)
			{
				new String[211];
				SendFactionMessage(1, COLOR_ARWIN, "{00FFFF}Emergency Services");
				format(String, sizeof(String), "{00FFFF}Crime Description: "RED_E"%s", text);
				SendFactionMessage(1, COLOR_ARWIN, String);
				format(String, sizeof(String), "{00FFFF}Dispatch Name: "WHITE_E"["YELLOW_E"%s"WHITE_E"] Ph: ["YELLOW_E"%d"WHITE_E"]", pData[playerid][pName], pData[playerid][pPhone]);
				SendFactionMessage(1, COLOR_ARWIN, String);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
				pData[playerid][pCall] = INVALID_PLAYER_ID;
				Mobile[playerid] = INVALID_PLAYER_ID;
				return 0;
			}
			if(Mobile[playerid] == 12332)
			{
				new Float:x, Float:y, Float:z;
				GetPlayerPos(playerid, x, y, z);
				foreach(new tx : Player)
				{
					if(pData[tx][pJob] == 1 || pData[tx][pJob2] == 1 && pData[tx][pTaxiDuty] == 1)
					{
						SendClientMessageEx(tx, COLOR_BLUE, "DISPATCH: "WHITE_E"Client ["YELLOW_E"(%d) {00FFFF}%s "WHITE_E"] Last Know position: ["YELLOW_E"%s"WHITE_E"]", playerid, pData[playerid][pName], GetLocation(x, y, z));
						SendClientMessageEx(tx, COLOR_ARWIN, "NOTE:  Use '/accepttaxi [playerid]' to respond to the call");
					}
					format(pData[playerid][pServiceText], 128, "%s", text);
					SendClientMessageEx(playerid, COLOR_YELLOW, "Thank you. We will alert all taxi driver on duty.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
					pData[playerid][pCall] = INVALID_PLAYER_ID;
					Mobile[playerid] = INVALID_PLAYER_ID;
					pData[playerid][pTaxiCall] = 60;
				}
				return 0;
			}
			if(Mobile[playerid] == 12333)
			{
				new Float:x, Float:y, Float:z;
				GetPlayerPos(playerid, x, y, z);
				foreach(new tx : Player)
				{
					if(pData[tx][pJob] == 2 || pData[tx][pJob2] == 2 && pData[tx][pMechDuty] == 1)
					{
						SendClientMessageEx(tx, COLOR_BLUE, "DISPATCH: "WHITE_E"Client ["YELLOW_E"(%d) {00FFFF}%s "WHITE_E"] Last Know position: ["YELLOW_E"%s"WHITE_E"]", playerid, pData[playerid][pName], GetLocation(x, y, z));
						SendClientMessageEx(tx, COLOR_ARWIN, "NOTE:  Use '/acceptmecha [playerid]' to respond to the call");
					}
					format(pData[playerid][pServiceText], 128, "%s", text);
					SendClientMessageEx(playerid, COLOR_YELLOW, "Thank you. We will alert all mechanic on duty.");	
					pData[playerid][pMechaCall] = 60;
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
					pData[playerid][pCall] = INVALID_PLAYER_ID;
					Mobile[playerid] = INVALID_PLAYER_ID;
				}	
				return 0;
			}
			if(Mobile[playerid] == 911)
			{
				if(!text[0])
				{
					SendClientMessageEx(playerid, COLOR_ARWIN, "EMERGENCY: "WHITE_E"Sorry, I don't understand - police or paramedic?");
					return 0;
				}
				else if (strcmp("police", text, true) == 0)
				{
					SendClientMessageEx(playerid, COLOR_ARWIN, "EMERGENCY: "WHITE_E"I am patching you to San Andreas Police Department headquarters, please hold...");
					Mobile[playerid] = 913;
					SendClientMessageEx(playerid, COLOR_ARWIN, "Police HQ: "WHITE_E"Please give me a short description of the crime.");
					return 0;
				}
				else if (strcmp("paramedic", text, true) == 0)
				{
					SendClientMessageEx(playerid, COLOR_ARWIN, "EMERGENCY: "WHITE_E"I am patching you to San Andreas Medical Department headquarters, please hold...");
					Mobile[playerid] = 914;
					SendClientMessageEx(playerid, COLOR_ARWIN, "Dispatch: "WHITE_E"Please give me a short description of the incident.");
					return 0;
				}
				else
				{
					SendClientMessageEx(playerid, COLOR_ARWIN, "EMERGENCY: "WHITE_E"Sorry, I don't understand - police or paramedic?");
					return 0;
				}
			}
			if(Mobile[playerid] == 111)
			{
				if(!text[0])
				{
					SendClientMessageEx(playerid, COLOR_ARWIN, "EMERGENCY: "WHITE_E"Sorry, I don't understand - taxi or mechanic?");
					return 0;
				}
				else if (strcmp("taxi", text, true) == 0)
				{
					SendClientMessageEx(playerid, COLOR_ARWIN, "TAXI: "WHITE_E"I am patching you to taxi headquarters, please hold...");
					Mobile[playerid] = 12332;
					SendClientMessageEx(playerid, COLOR_ARWIN, "TAXI: "WHITE_E"Please give me you location.");
					return 0;
				}
				else if (strcmp("mechanic", text, true) == 0)
				{
					SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"I am patching you to mechanic headquarters, please hold...");
					Mobile[playerid] = 12333;
					SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Please give me you location.");
					return 0;
				}
				else
				{
					SendClientMessageEx(playerid, COLOR_ARWIN, "EMERGENCY: "WHITE_E"Sorry, I don't understand - taxi or mechanic?");
					return 0;
				}
			}
		}
		new String[500];	
		if(pData[playerid][pMaskOn] == 1)
		{
			format(String, sizeof(String), "Mask %d says: %s", pData[playerid][pMaskID], text);
			ProxDetector(10, playerid, String, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
			return 0;
		}
		if(pData[playerid][pAdminDuty] >= 1)
		{
			format(String, sizeof(String), "{FF0000}%s: {FFFFFF}((  %s ))", pData[playerid][pAdminname], text);
			ProxDetector(10, playerid, String, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
			return 0;
		}
		if( pData[playerid][pAdminDuty] == 0)
		{
			if(pData[playerid][pMaskOn] == 1)
			{
				format(String, sizeof(String), "Mask %d says: %s",pData[playerid][pMaskID], text);
				ProxDetector(10, playerid, String, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
			}
			else
			{
				if(pData[playerid][pTogAccent] == 0)
				{
					format(String, sizeof(String), "%s says: %s", pData[playerid][pName], text);
				}
				else if(pData[playerid][pTogAccent] == 1)
				{
					format(String, sizeof(String), "%s says [%s Accent]: %s", pData[playerid][pName], pData[playerid][pAccent], text);
				}
				ProxDetector(10, playerid, String, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
			}
		}
	}
	else
	{
		text[0] = toupper(text[0]);
		if(text[0] == '@')
		{
			if(pData[playerid][pSMS] != 0)
			{
				if(pData[playerid][pPhoneCredit] < 1)
				{
					Error(playerid, "You dont have phone credits!");
					return 0;
				}
				if(pData[playerid][pInjured] != 0)
				{
					Error(playerid, "You cant do at this time.");
					return 0;
				}
				new tmp[512];
				foreach(new ii : Player)
				{
					if(text[1] == ' ')
					{
						format(tmp, sizeof(tmp), "%s", text[2]);
					}
					else
					{
						format(tmp, sizeof(tmp), "%s", text[1]);
					}
					if(pData[ii][pPhone] == pData[playerid][pSMS])
					{
						if(ii == INVALID_PLAYER_ID || !IsPlayerConnected(ii))
						{
							Error(playerid, "This number is not actived!");
							return 0;
						}
						new String[555];
						SendClientMessageEx(playerid, COLOR_ARWIN, "SMS: {FFFF00}Message sent");
						SendClientMessageEx(playerid, COLOR_WHITE, "AME: {C2A2DA}types something to his cellphone");
						format(String, sizeof(String), "types something to his cellphone");
						SetPlayerChatBubble(playerid, String, COLOR_PURPLE, 5.0, 5000);
						format(String, sizeof(String), "SMS: {ffffff}You have received one new message from '{ffff00}%d{ffffff}'", pData[playerid][pPhone]);
						SendClientMessageEx(ii, COLOR_RED, String);	
						format(String, sizeof(String), "Message: {ffff00}%s", tmp);
						SendClientMessageEx(ii, COLOR_RED, String);
						PlayerPlaySound(ii, 6003, 0,0,0);
						pData[ii][pSMS] = pData[playerid][pPhone];
						
						pData[playerid][pPhoneCredit] -= 1;
						return 0;
					}
				}
			}
		}
		if(pData[playerid][pCall] != INVALID_PLAYER_ID)
		{
			// Anti-Caps
			if(GetPVarType(playerid, "Caps"))
				UpperToLower(text);
			new lstr[1024];
			format(lstr, sizeof(lstr), "%s [phone]: %s", ReturnName(playerid), text);
			ProxDetector(10, playerid, lstr, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
			for (new i = 0; i != MAX_CONTACTS; i ++) if (ContactData[playerid][i][contactExists]) 
			{
				if(pData[pData[playerid][pCall]][pPhone] == ContactData[playerid][i][contactNumber])
				{
					SendClientMessageEx(pData[playerid][pCall], COLOR_YELLOW, "%s Caller [phone]: "WHITE_E"%s.", ContactData[playerid][i][contactName], text);	
				}
				else
				{
					new sext[40];
					if(pData[pData[playerid][pCall]][pGender] == 1) { sext = "Male"; } else { sext = "Female"; }
					SendClientMessageEx(pData[playerid][pCall], COLOR_YELLOW, "%s Caller [phone]: "WHITE_E"%s.", sext, text);	
				}
			}
		}
		if(Mobile[playerid] != INVALID_PLAYER_ID)
		{
			if(Mobile[playerid] == 914)
			{
				new String[211];
				if(!text[0])
				{
					SendClientMessageEx(playerid, COLOR_ARWIN, "Dispatch: Sorry, I don't understand?");
					return 0;
				}
				SendFactionMessage(3, COLOR_ARWIN, "{00FFFF}Emergency Services");
				format(String, sizeof(String), "{00FFFF}Crime Description: "RED_E"%s", text);
				SendFactionMessage(3, COLOR_ARWIN, String);
				format(String, sizeof(String), "{00FFFF}Dispatch Name: "WHITE_E"["YELLOW_E"%s"WHITE_E"] Ph: ["YELLOW_E"%d"WHITE_E"]", pData[playerid][pName], pData[playerid][pPhone]);
				SendFactionMessage(3, COLOR_ARWIN, String);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
				pData[playerid][pCall] = INVALID_PLAYER_ID;
				Mobile[playerid] = INVALID_PLAYER_ID;
				return 0;
			}
			if(Mobile[playerid] == 888)
			{
				new String[211];
				SendFactionMessage(2, COLOR_ARWIN, "{00FFFF}SAGS Call Center");
				format(String, sizeof(String), "{00FFFF}Crime Description: "RED_E"%s", text);
				SendFactionMessage(2, COLOR_ARWIN, String);
				format(String, sizeof(String), "{00FFFF}Dispatch Name: "WHITE_E"["YELLOW_E"%s"WHITE_E"] Ph: ["YELLOW_E"%d"WHITE_E"]", pData[playerid][pName], pData[playerid][pPhone]);
				SendFactionMessage(2, COLOR_ARWIN, String);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
				pData[playerid][pCall] = INVALID_PLAYER_ID;
				Mobile[playerid] = INVALID_PLAYER_ID;
				return 0;
			}
			if(Mobile[playerid] == 777)
			{
				new String[211];
				SendFactionMessage(3, COLOR_ARWIN, "{00FFFF}Non-Emergency Services");
				format(String, sizeof(String), "{00FFFF}Crime Description: "RED_E"%s", text);
				SendFactionMessage(3, COLOR_ARWIN, String);
				format(String, sizeof(String), "{00FFFF}Dispatch Name: "WHITE_E"["YELLOW_E"%s"WHITE_E"] Ph: ["YELLOW_E"%d"WHITE_E"]", pData[playerid][pName], pData[playerid][pPhone]);
				SendFactionMessage(3, COLOR_ARWIN, String);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
				pData[playerid][pCall] = INVALID_PLAYER_ID;
				Mobile[playerid] = INVALID_PLAYER_ID;
				return 0;
			}
			if(Mobile[playerid] == 555)
			{
				new String[211];
				SendFactionMessage(1, COLOR_ARWIN, "{00FFFF}Non-Emergency Services");
				format(String, sizeof(String), "{00FFFF}Crime Description: "RED_E"%s", text);
				SendFactionMessage(1, COLOR_ARWIN, String);
				format(String, sizeof(String), "{00FFFF}Dispatch Name: "WHITE_E"["YELLOW_E"%s"WHITE_E"] Ph: ["YELLOW_E"%d"WHITE_E"]", pData[playerid][pName], pData[playerid][pPhone]);
				SendFactionMessage(1, COLOR_ARWIN, String);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
				pData[playerid][pCall] = INVALID_PLAYER_ID;
				Mobile[playerid] = INVALID_PLAYER_ID;
				return 0;
			}
			if(Mobile[playerid] == 913)
			{
				new String[211];
				SendFactionMessage(1, COLOR_ARWIN, "{00FFFF}Emergency Services");
				format(String, sizeof(String), "{00FFFF}Crime Description: "RED_E"%s", text);
				SendFactionMessage(1, COLOR_ARWIN, String);
				format(String, sizeof(String), "{00FFFF}Dispatch Name: "WHITE_E"["YELLOW_E"%s"WHITE_E"] Ph: ["YELLOW_E"%d"WHITE_E"]", pData[playerid][pName], pData[playerid][pPhone]);
				SendFactionMessage(1, COLOR_ARWIN, String);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
				pData[playerid][pCall] = INVALID_PLAYER_ID;
				Mobile[playerid] = INVALID_PLAYER_ID;
				return 0;
			}
			if(Mobile[playerid] == 12332)
			{
				new Float:x, Float:y, Float:z;
				GetPlayerPos(playerid, x, y, z);
				foreach(new tx : Player)
				{
					if(pData[tx][pJob] == 1 || pData[tx][pJob2] == 1 && pData[tx][pTaxiDuty] == 1)
					{
						SendClientMessageEx(tx, COLOR_BLUE, "DISPATCH: "WHITE_E"Client ["YELLOW_E"(%d) {00FFFF}%s "WHITE_E"] Last Know position: ["YELLOW_E"%s"WHITE_E"]", playerid, pData[playerid][pName], GetLocation(x, y, z));
						SendClientMessageEx(tx, COLOR_ARWIN, "NOTE:  Use '/accepttaxi [playerid]' to respond to the call");
					}
					format(pData[playerid][pServiceText], 128, "%s", text);
					SendClientMessageEx(playerid, COLOR_YELLOW, "Thank you. We will alert all taxi driver on duty.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
					pData[playerid][pCall] = INVALID_PLAYER_ID;
					Mobile[playerid] = INVALID_PLAYER_ID;
					pData[playerid][pTaxiCall] = 60;
				}
				return 0;
			}
			if(Mobile[playerid] == 12333)
			{
				new Float:x, Float:y, Float:z;
				GetPlayerPos(playerid, x, y, z);
				foreach(new tx : Player)
				{
					if(pData[tx][pJob] == 2 || pData[tx][pJob2] == 2 && pData[tx][pMechDuty] == 1)
					{
						SendClientMessageEx(tx, COLOR_BLUE, "DISPATCH: "WHITE_E"Client ["YELLOW_E"(%d) {00FFFF}%s "WHITE_E"] Last Know position: ["YELLOW_E"%s"WHITE_E"]", playerid, pData[playerid][pName], GetLocation(x, y, z));
						SendClientMessageEx(tx, COLOR_ARWIN, "NOTE:  Use '/acceptmecha [playerid]' to respond to the call");
					}
					format(pData[playerid][pServiceText], 128, "%s", text);
					SendClientMessageEx(playerid, COLOR_YELLOW, "Thank you. We will alert all mechanic on duty.");	
					pData[playerid][pMechaCall] = 60;
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
					pData[playerid][pCall] = INVALID_PLAYER_ID;
					Mobile[playerid] = INVALID_PLAYER_ID;
				}	
				return 0;
			}
			if(Mobile[playerid] == 911)
			{
				if(!text[0])
				{
					SendClientMessageEx(playerid, COLOR_ARWIN, "EMERGENCY: "WHITE_E"Sorry, I don't understand - police or paramedic?");
					return 0;
				}
				else if (strcmp("police", text, true) == 0)
				{
					SendClientMessageEx(playerid, COLOR_ARWIN, "EMERGENCY: "WHITE_E"I am patching you to San Andreas Police Department headquarters, please hold...");
					Mobile[playerid] = 913;
					SendClientMessageEx(playerid, COLOR_ARWIN, "Police HQ: "WHITE_E"Please give me a short description of the crime.");
					return 0;
				}
				else if (strcmp("paramedic", text, true) == 0)
				{
					SendClientMessageEx(playerid, COLOR_ARWIN, "EMERGENCY: "WHITE_E"I am patching you to San Andreas Medical Department headquarters, please hold...");
					Mobile[playerid] = 914;
					SendClientMessageEx(playerid, COLOR_ARWIN, "Dispatch: "WHITE_E"Please give me a short description of the incident.");
					return 0;
				}
				else
				{
					SendClientMessageEx(playerid, COLOR_ARWIN, "EMERGENCY: "WHITE_E"Sorry, I don't understand - police or paramedic?");
					return 0;
				}
			}
			if(Mobile[playerid] == 111)
			{
				if(!text[0])
				{
					SendClientMessageEx(playerid, COLOR_ARWIN, "EMERGENCY: "WHITE_E"Sorry, I don't understand - taxi or mechanic?");
					return 0;
				}
				else if (strcmp("taxi", text, true) == 0)
				{
					SendClientMessageEx(playerid, COLOR_ARWIN, "TAXI: "WHITE_E"I am patching you to taxi headquarters, please hold...");
					Mobile[playerid] = 12332;
					SendClientMessageEx(playerid, COLOR_ARWIN, "TAXI: "WHITE_E"Please give me you location.");
					return 0;
				}
				else if (strcmp("mechanic", text, true) == 0)
				{
					SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"I am patching you to mechanic headquarters, please hold...");
					Mobile[playerid] = 12333;
					SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Please give me you location.");
					return 0;
				}
				else
				{
					SendClientMessageEx(playerid, COLOR_ARWIN, "EMERGENCY: "WHITE_E"Sorry, I don't understand - taxi or mechanic?");
					return 0;
				}
			}
		}
		new String[500];	
		if(pData[playerid][pMaskOn] == 1)
		{
			format(String, sizeof(String), "Mask %d says: %s", pData[playerid][pMaskID], text);
			ProxDetector(10, playerid, String, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
			return 0;
		}
		if(pData[playerid][pAdminDuty] >= 1)
		{
			format(String, sizeof(String), "{FF0000}%s: {FFFFFF}((  %s ))", pData[playerid][pAdminname], text);
			ProxDetector(10, playerid, String, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
			return 0;
		}
		if( pData[playerid][pAdminDuty] == 0)
		{
			if(pData[playerid][pMaskOn] == 1)
			{
				format(String, sizeof(String), "Mask %d says: %s",pData[playerid][pMaskID], text);
				ProxDetector(10, playerid, String, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
			}
			else
			{
				if(pData[playerid][pTogAccent] == 0)
				{
					format(String, sizeof(String), "%s says: %s", pData[playerid][pName], text);
				}
				else if(pData[playerid][pTogAccent] == 1)
				{
					format(String, sizeof(String), "%s says [%s Accent]: %s", pData[playerid][pName], pData[playerid][pAccent], text);
				}
				ProxDetector(10, playerid, String, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
			}
		}
	}
	return 0;
}

public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
    if (result == -1)
    {
        SendClientMessageEx(playerid, COLOR_ARWIN, "ERROR: "WHITE_E"Unknown command, see '/help'");
        return 0;
    }
	printf("[CMD]: %s(%d) menggunakan CMD '%s' (%s)", pData[playerid][pName], playerid, cmd, params);
    return 1;
}

public OnPlayerPressButton(playerid, buttonid)
{
	if(buttonid == SAPDLobbyBtn[0] || buttonid == SAPDLobbyBtn[1])
	{
		if(pData[playerid][pFaction] == 1)
		{
			MoveDynamicObject(SAPDLobbyDoor[0], 1327.769531, 727.460327, 110.300323, 3);
			//MoveDynamicObject(SAPDLobbyDoor[1], 253.24377, 111.94370, 1002.21460, 3);
			SetTimer("SAPDLobbyDoorClose", 5000, 0);
		}
		else
	    {
	        Error(playerid, "Access denied.");
			return 1;
		}
	}
	// if(buttonid == SAPDLobbyBtn[2] || buttonid == SAPDLobbyBtn[3])
	// {
	// 	if(pData[playerid][pFaction] == 1)
	// 	{
	// 		MoveDynamicObject(SAPDLobbyDoor[2], 239.52385, 114.75534, 1002.21411, 3);
	// 		MoveDynamicObject(SAPDLobbyDoor[3], 239.71977, 120.21591, 1002.21332, 3);
	// 		SetTimer("SAPDLobbyDoorClose", 5000, 0);
	// 	}
	// 	else
	//     {
	//         Error(playerid, "Access denied.");
	// 		return 1;
	// 	}
	// }
	return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if(pData[playerid][pAdminDuty] > 0)
	{
        new vehicleid = GetPlayerVehicleID(playerid);
        if(vehicleid > 0 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
        {
			SetVehiclePos(vehicleid, fX, fY, fZ+10);
        }
        else
        {
			SetPlayerPosFindZ(playerid, fX, fY, 999.0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerInterior(playerid, 0);
        }
	}   
	if(IsPlayerInAnyVehicle(playerid))
	{
		foreach(new i : Player)
		{
			if(GetPlayerState(i) == PLAYER_STATE_DRIVER && GetPlayerVehicleID(i) == GetPlayerVehicleID(playerid))
			{
				if(pData[i][pTaxiDuty] == 1)
				{
					SetPlayerRaceCheckpoint(i, 1, fX, fY, fZ, 0, 0, 0, 2.0);
					SendClientMessageEx(i, COLOR_ARWIN, "TAXI: "WHITE_E"Passenger has marked drop off location");
				}
			}
		}
	}
    return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_ACTION && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		new Float:POS[3];
	    if(JB_IsBicycle(vehicleid))
	    {
			GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
			SetPlayerPos(playerid, POS[0], POS[1], POS[2] + 2.0);
	        //RemovePlayerFromVehicle(playerid);
		}
	}
    if(gPlayerUsingLoopingAnim[playerid])
	{
		if(IsKeyJustDown(KEY_SPRINT,newkeys,oldkeys))
		{
			StopLoopingAnim(playerid);
			ClearAnimations(playerid);
			return 1;
		}
	}	
    if((IsACBUGWeapon(playerid) && PRESSED(KEY_FIRE)) && newkeys != KEY_FIRE && newkeys & KEY_CROUCH)
    {
        ApplyAnimation ( playerid , "PED" , "getup" , 4.1 , 0 , 0 , 0 , 0 , 0 ) ;
        PlayerPlaySound(playerid, 1149, 0.0, 0.0, 0.0);
        SendClientMessage(playerid,-1,"{FF00FF}[C-Bug]:{FFFFFF} Please Stop{00FFFF} C-BuG!");
    }

	if(newkeys && PRESSED(KEY_JUMP | KEY_SPRINT) && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		if(Jump[playerid] > gettime())
		{
			ApplyAnimation(playerid,"PED","getup_front",4.0,0,0,0,0,0);
		}
		Jump[playerid] = gettime() + 5;
 	}
	if(newkeys & KEY_FIRE && GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_SMOKE_CIGGY)
	{
		SendClientMessageEx(playerid, COLOR_ARWIN,"USE: "WHITE_E"Anda telah berhasil merokok.");
		SetTimerEx("CigarStop", 10000, 0, "i", playerid);
 	}
	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_DRINK_SPRUNK && (newkeys & KEY_FIRE))
	{
		pData[playerid][pSprunk]--;
		pData[playerid][pEnergy] += 10;
		SendClientMessageEx(playerid, COLOR_ARWIN,"USE: "WHITE_E"Anda telah berhasil menggunakan snack.");
		InfoTD_MSG(playerid, 3000, "Restore +10 Hunger");
	    SetTimerEx("CigarStop", 7000, 0, "i", playerid);
		return 1;
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && (newkeys & KEY_NO))
	{
	    if(pData[playerid][CarryingLumber])
		{
			Player_DropLumber(playerid);
		}
	}
	if((newkeys & KEY_SECONDARY_ATTACK))
    {
		foreach(new did : Doors)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ]))
			{
				if(dData[did][dIntposX] == 0.0 && dData[did][dIntposY] == 0.0 && dData[did][dIntposZ] == 0.0)
					return Error(playerid, "Interior entrance masih kosong, atau tidak memiliki interior.");

				if(dData[did][dLocked])
					return Error(playerid, "This entrance is locked at the moment.");
					
				if(dData[did][dFaction] > 0)
				{
					if(dData[did][dFaction] != pData[playerid][pFaction])
						return Error(playerid, "This door only for faction.");
				}
				if(dData[did][dFamily] > 0)
				{
					if(dData[did][dFamily] != pData[playerid][pFamily])
						return Error(playerid, "This door only for family.");
				}
				
				if(dData[did][dVip] > pData[playerid][pVip])
					return Error(playerid, "Your VIP level not enough to enter this door.");
				
				if(dData[did][dAdmin] > pData[playerid][pAdmin])
					return Error(playerid, "Your admin level not enough to enter this door.");
					
				if(strlen(dData[did][dPass]))
				{
					new params[256];
					if(sscanf(params, "s[256]", params)) return Usage(playerid, "/enter [password]");
					if(strcmp(params, dData[did][dPass])) return Error(playerid, "Invalid door password.");
					
					if(dData[did][dCustom])
					{
						SetPlayerPositionEx(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
					}
					else
					{
						SetPlayerPositionEx(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
					}
					pData[playerid][pInDoor] = did;
					SetPlayerInterior(playerid, dData[did][dIntint]);
					SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
					SetCameraBehindPlayer(playerid);
					SetPlayerWeather(playerid, 0);
				}
				else
				{
					if(dData[did][dCustom])
					{
						SetPlayerPositionEx(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
					}
					else
					{
						SetPlayerPositionEx(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
					}
					pData[playerid][pInDoor] = did;
					SetPlayerInterior(playerid, dData[did][dIntint]);
					SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
					SetCameraBehindPlayer(playerid);
					SetPlayerWeather(playerid, 0);
				}
			}
			if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ]))
			{
				if(dData[did][dFaction] > 0)
				{
					if(dData[did][dFaction] != pData[playerid][pFaction])
						return Error(playerid, "This door only for faction.");
				}
				
				if(dData[did][dCustom])
				{
					SetPlayerPositionEx(playerid, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
				}
				else
				{
					SetPlayerPositionEx(playerid, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
				}
				pData[playerid][pInDoor] = -1;
				SetPlayerInterior(playerid, dData[did][dExtint]);
				SetPlayerVirtualWorld(playerid, dData[did][dExtvw]);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, WorldWeather);
				Streamer_UpdateEx(playerid, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ]);
				pData[playerid][pInt] = 0;
				pData[playerid][pWorld] = 0;
			}
        }
		//Bisnis
		foreach(new bid : Bisnis)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ]))
			{
				if(bData[bid][bIntposX] == 0.0 && bData[bid][bIntposY] == 0.0 && bData[bid][bIntposZ] == 0.0)
					return Error(playerid, "Interior bisnis masih kosong, atau tidak memiliki interior.");

				if(bData[bid][bLocked])
					return GameTextForPlayer(playerid, "~w~Biz ~r~Terkunci!", 1000, 5);
				if(bData[bid][bSegel] == 1) return GameTextForPlayer(playerid, "~w~Biz ini ~r~Disegel", 1000, 5);
				pData[playerid][pInBiz] = bid;
				SetPlayerPositionEx(playerid, bData[bid][bIntposX], bData[bid][bIntposY], bData[bid][bIntposZ], bData[bid][bIntposA]);
				
				SetPlayerInterior(playerid, bData[bid][bInt]);
				SetPlayerVirtualWorld(playerid, bid);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, 0);
				PlayStream(playerid, bData[bid][bStream], bData[bid][bIntposX], bData[bid][bIntposY], bData[bid][bIntposZ], 30.0, 1);
			}
        }
		new inbisnisid = pData[playerid][pInBiz];
		if(pData[playerid][pInBiz] != -1 && IsPlayerInRangeOfPoint(playerid, 2.8, bData[inbisnisid][bIntposX], bData[inbisnisid][bIntposY], bData[inbisnisid][bIntposZ]))
		{
			pData[playerid][pInBiz] = -1;
			SetPlayerPositionEx(playerid, bData[inbisnisid][bExtposX], bData[inbisnisid][bExtposY], bData[inbisnisid][bExtposZ], bData[inbisnisid][bExtposA]);
			
			SetPlayerInterior(playerid, bData[inbisnisid][bExtInt]);
			SetPlayerVirtualWorld(playerid, bData[inbisnisid][bExtVw]);
			SetCameraBehindPlayer(playerid);
			SetPlayerWeather(playerid, WorldWeather);
			StopStream(playerid);
			pData[playerid][pInt] = 0;
			pData[playerid][pWorld] = 0;
		}
		//Houses
		foreach(new hid : Houses)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.5, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]))
			{
				if(hData[hid][hIntposX] == 0.0 && hData[hid][hIntposY] == 0.0 && hData[hid][hIntposZ] == 0.0)
					return Error(playerid, "Interior house masih kosong, atau tidak memiliki interior.");

				if(hData[hid][hLocked])
					return Error(playerid, "This house is locked!");
				
				pData[playerid][pInHouse] = hid;
				SetPlayerPositionEx(playerid, hData[hid][hIntposX], hData[hid][hIntposY], hData[hid][hIntposZ], hData[hid][hIntposA]);

				SetPlayerInterior(playerid, hData[hid][hInt]);
				SetPlayerVirtualWorld(playerid, hid);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, 0);
				if(!hData[hid][house_Lights]) TextDrawShowForPlayer(playerid, HouseLight);
			}
        }
		new inhouseid = pData[playerid][pInHouse];
		if(pData[playerid][pInHouse] != -1 && IsPlayerInRangeOfPoint(playerid, 2.8, hData[inhouseid][hIntposX], hData[inhouseid][hIntposY], hData[inhouseid][hIntposZ]))
		{
			pData[playerid][pInHouse] = -1;
			SetPlayerPositionEx(playerid, hData[inhouseid][hExtposX], hData[inhouseid][hExtposY], hData[inhouseid][hExtposZ], hData[inhouseid][hExtposA]);
			
			SetPlayerInterior(playerid, hData[inhouseid][hExtInt]);
			SetPlayerVirtualWorld(playerid, hData[inhouseid][hExtVw]);
			pData[playerid][pInt] = 0;
			pData[playerid][pWorld] = 0;
			SetCameraBehindPlayer(playerid);
			SetPlayerWeather(playerid, WorldWeather);
			TextDrawHideForPlayer(playerid, HouseLight);
		}
		//Family
		foreach(new fid : FAMILYS)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, fData[fid][fExtposX], fData[fid][fExtposY], fData[fid][fExtposZ]))
			{
				if(fData[fid][fIntposX] == 0.0 && fData[fid][fIntposY] == 0.0 && fData[fid][fIntposZ] == 0.0)
					return Error(playerid, "Interior masih kosong, atau tidak memiliki interior.");

				if(pData[playerid][pFaction] == 0)
					if(pData[playerid][pFamily] == -1)
						return Error(playerid, "You dont have registered for this door!");
						
				SetPlayerPositionEx(playerid, fData[fid][fIntposX], fData[fid][fIntposY], fData[fid][fIntposZ], fData[fid][fIntposA]);

				SetPlayerInterior(playerid, fData[fid][fInt]);
				SetPlayerVirtualWorld(playerid, fid);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, 0);
			}
			if(IsPlayerInRangeOfPoint(playerid, 2.8, fData[fid][fIntposX], fData[fid][fIntposY], fData[fid][fIntposZ]))
			{
				SetPlayerPositionEx(playerid, fData[fid][fExtposX], fData[fid][fExtposY], fData[fid][fExtposZ], fData[fid][fExtposA]);

				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, WorldWeather);
				pData[playerid][pInt] = 0;
				pData[playerid][pWorld] = 0;
			}
        }
	}
	//SAPD Taser/Tazer
	if(newkeys & KEY_FIRE && TaserData[playerid][TaserEnabled] && GetPlayerWeapon(playerid) == 23 && !IsPlayerInAnyVehicle(playerid) && TaserData[playerid][TaserCharged])
	{
		TaserData[playerid][TaserCharged] = true;
		new Float:X, Float:Y, Float:Z, Float:health;
		foreach(new i : Player)
		{
		    if(IsPlayerStreamedIn(i, playerid))
		    {
			    GetPlayerPos(i, X, Y, Z);
				if(IsPlayerAimingAt(playerid,X,Y,Z,1) && GetPlayerState(i) == PLAYER_STATE_ONFOOT && (GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i)))
				{
					if(!IsPlayerConnected(i)) continue;
					if(playerid == i) continue;
					if(TaserData[i][TaserCountdown] != 0) continue;
					//ClearAnimations(i, 1);
					TogglePlayerControllable(i, false);
					PlayerPlaySound(i, 6003, 0,0,0);
					PlayerPlaySound(playerid, 6003, 0,0,0);
					GetPlayerHealth(i, health);
					TaserData[i][TaserCountdown] = TASER_BASETIME + floatround((100 - health) / 12);
					SendClientMessageEx(i, COLOR_ARWIN,"TASER: "WHITE_E"You got tased for %d secounds!", TaserData[i][TaserCountdown]);
					TaserData[i][GetupTimer] = SetTimerEx("TaserGetUp", 1000, true, "i", i);
					return 1;
				}
			}
		}
	}
	//Vehicle
	if((newkeys & KEY_YES ))
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			return callcmd::engine(playerid, "");
		}
	}
	if(newkeys & KEY_CROUCH && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		foreach(new i : Parks)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.3, ppData[i][parkX], ppData[i][parkY], ppData[i][parkZ]))
			{
				return callcmd::storeveh(playerid, "");
			}
		}
	}
	if(newkeys & KEY_CTRL_BACK && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		foreach(new i : Parks)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.3, ppData[i][parkX], ppData[i][parkY], ppData[i][parkZ]))
			{
				return callcmd::takeveh(playerid, "");
			}
		}
	}
	if((newkeys & KEY_NO ))
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			if(!pvData[vehicleid][cLocked])
			{
				pvData[vehicleid][cLocked] = 1;
				GameTextForPlayer(playerid,"~w~vehicle ~r~locked",5000,6);
				SwitchVehicleDoors(pvData[vehicleid][cVeh], true);
			}
			else
			{
				pvData[vehicleid][cLocked] = 0;
				GameTextForPlayer(playerid,"~w~vehicle ~g~unlocked",5000,6);
				SwitchVehicleDoors(pvData[vehicleid][cVeh], false);
			}
		}
	}
	if(GetPVarInt(playerid, "UsingSprunk"))
	{
		if(pData[playerid][pEnergy] >= 100 )
		{
  			SendClientMessageEx(playerid, COLOR_ARWIN,"USE: "WHITE_E"Kamu terlalu banyak minum.");
	   	}
	   	else
	   	{
		    pData[playerid][pEnergy] += 5;
		}
	}
	if (IsKeyJustDown(KEY_FIRE, newkeys, oldkeys))
 	{
		if(GetPVarInt(playerid, "editingcdvehpos"))
		{
			TogglePlayerControllable(playerid, false);
		    ShowPlayerDialog(playerid,DIALOG_CDEDITPARK,DIALOG_STYLE_MSGBOX,"Warning:","Is this the new position you want?","Ok","Cancel");
		}
		if(GetPVarInt(playerid, "editingcdvehnew"))
		{
            TogglePlayerControllable(playerid, false);
	        ShowPlayerDialog(playerid,DIALOG_CDEDITPARK,DIALOG_STYLE_MSGBOX,"Warning:","Is this the new position you want?","Ok","Cancel");
		}
	}	
	if(PRESSED( KEY_FIRE ))
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsPlayerInAnyVehicle(playerid))
		{
			foreach(new did : Doors)
			{
				if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ]))
				{
					if(dData[did][dGarage] == 1)
					{
						if(dData[did][dIntposX] == 0.0 && dData[did][dIntposY] == 0.0 && dData[did][dIntposZ] == 0.0)
							return Error(playerid, "Interior entrance masih kosong, atau tidak memiliki interior.");

						if(dData[did][dLocked])
							return Error(playerid, "This entrance is locked at the moment.");
							
						if(dData[did][dFaction] > 0)
						{
							if(dData[did][dFaction] != pData[playerid][pFaction])
								return Error(playerid, "This door only for faction.");
						}
						if(dData[did][dFamily] > 0)
						{
							if(dData[did][dFamily] != pData[playerid][pFamily])
								return Error(playerid, "This door only for family.");
						}
						
						if(dData[did][dVip] > pData[playerid][pVip])
							return Error(playerid, "Your VIP level not enough to enter this door.");
						
						if(dData[did][dAdmin] > pData[playerid][pAdmin])
							return Error(playerid, "Your admin level not enough to enter this door.");
							
						if(strlen(dData[did][dPass]))
						{
							new params[256];
							if(sscanf(params, "s[256]", params)) return Usage(playerid, "/enter [password]");
							if(strcmp(params, dData[did][dPass])) return Error(playerid, "Invalid door password.");
							
							if(dData[did][dCustom])
							{
								SetVehiclePos(GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ]);
								SetVehicleZAngle(GetPlayerVehicleID(playerid), dData[did][dIntposA]);
							    SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), dData[did][dIntvw]);
		            			LinkVehicleToInterior(GetPlayerVehicleID(playerid), dData[did][dIntint]); 
							}
							else
							{
								SetVehiclePos(GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ]);
								SetVehicleZAngle(GetPlayerVehicleID(playerid), dData[did][dIntposA]);
							    SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), dData[did][dIntvw]);
		            			LinkVehicleToInterior(GetPlayerVehicleID(playerid), dData[did][dIntint]); 
							}
							pData[playerid][pInDoor] = did;
							SetPlayerInterior(playerid, dData[did][dIntint]);
							SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
							SetCameraBehindPlayer(playerid);
							SetPlayerWeather(playerid, 0);
						}
						else
						{
							if(dData[did][dCustom])
							{
								SetVehiclePos(GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ]);						
								SetVehicleZAngle(GetPlayerVehicleID(playerid), dData[did][dIntposA]);
							    SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), dData[did][dIntvw]);
		            			LinkVehicleToInterior(GetPlayerVehicleID(playerid), dData[did][dIntint]); 
							}
							else
							{
								SetVehiclePos(GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ]);
								SetVehicleZAngle(GetPlayerVehicleID(playerid), dData[did][dIntposA]);
							    SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), dData[did][dIntvw]);
		            			LinkVehicleToInterior(GetPlayerVehicleID(playerid), dData[did][dIntint]);   
							}
							pData[playerid][pInDoor] = did;
							SetCameraBehindPlayer(playerid);
							SetPlayerWeather(playerid, 0);
							SetPlayerInterior(playerid, dData[did][dIntint]);
							SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
						}
					}
				}
				if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ]))
				{
					if(dData[did][dGarage] == 1)
					{
						if(dData[did][dFaction] > 0)
						{
							if(dData[did][dFaction] != pData[playerid][pFaction])
								return Error(playerid, "This door only for faction.");
						}
					
						if(dData[did][dCustom])
						{
							SetVehiclePos(GetPlayerVehicleID(playerid), dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ]);
							SetVehicleZAngle(GetPlayerVehicleID(playerid), dData[did][dExtposA]);
						    SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), dData[did][dExtvw]);
	            			LinkVehicleToInterior(GetPlayerVehicleID(playerid), dData[did][dExtint]);   
						}
						else
						{
							SetVehiclePos(GetPlayerVehicleID(playerid), dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ]);
							SetVehicleZAngle(GetPlayerVehicleID(playerid), dData[did][dExtposA]);
						    SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), dData[did][dExtvw]);
	            			LinkVehicleToInterior(GetPlayerVehicleID(playerid), dData[did][dExtint]);   
						}
						pData[playerid][pInDoor] = -1;
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, WorldWeather);
						SetPlayerInterior(playerid, dData[did][dExtint]);
						SetPlayerVirtualWorld(playerid, dData[did][dExtvw]);
						Streamer_UpdateEx(playerid, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ]);
					}
				}
			}
		}
	}
	if(PRESSED( KEY_CTRL_BACK ))
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && pData[playerid][pCuffed] == 0)
		{
			ClearAnimations(playerid);
			StopLoopingAnim(playerid);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		}
    }
	if(IsKeyJustDown(KEY_SECONDARY_ATTACK, newkeys, oldkeys))
	{
		if(GetPVarInt(playerid, "UsingSprunk"))
		{
			DeletePVar(playerid, "UsingSprunk");
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		}
	}
 	if(IsKeyJustDown(KEY_CROUCH, newkeys, oldkeys))
	{
		callcmd::paytoll(playerid, "");
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 656.4168,-1326.0953,13.5521)) // masuk basemen news
		{
	        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
				SetTimerEx("EnterExitTimer", 8000, false, "i", playerid); //2486.7585,2374.5234,6.8437,271.9420
	            SetVehiclePos(GetPlayerVehicleID(playerid), 2486.7585,2374.5234,6.8437);
	            SetVehicleZAngle(GetPlayerVehicleID(playerid), 271.9420);
	            SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 0);
	            LinkVehicleToInterior(GetPlayerVehicleID(playerid), 5);   
				SetPlayerInterior(playerid, 5);
				SetPlayerVirtualWorld(playerid, 0);                    
	        }
	        else
			{
				SetTimerEx("EnterExitTimer", 8000, false, "i", playerid);
	            SetPlayerPos(playerid, 2486.7585,2374.5234,6.8437);
	            SetPlayerFacingAngle(playerid, 271.9420);
				SetPlayerInterior(playerid, 5);
				SetPlayerVirtualWorld(playerid, 0);
	        }			
		}
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 2485.8213,2379.3203,7.0685) && GetPlayerInterior(playerid) == 5) // keluar basemen news 
		{
		    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
				SetTimerEx("EnterExitTimer", 8000, false, "i", playerid);
		        SetVehiclePos(GetPlayerVehicleID(playerid), 662.3588,-1326.5183,13.6027); //662.3588,-1326.5183,13.6027,3.4360
		        SetVehicleZAngle(GetPlayerVehicleID(playerid), 3.4360);
		        SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 0);
		        LinkVehicleToInterior(GetPlayerVehicleID(playerid), 0);   
				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);   
		    }
		    else
			{
				SetTimerEx("EnterExitTimer", 8000, false, "i", playerid);
		        SetPlayerPos(playerid, 662.3588,-1326.5183,13.6027);
		        SetPlayerFacingAngle(playerid, 3.4360);
				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);	
		    }    		
		}
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 1178.5835,-1308.4675,13.7781)) // masuk basemen RS
		{
	        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
				SetTimerEx("EnterExitTimer", 8000, false, "i", playerid);
	            SetVehiclePos(GetPlayerVehicleID(playerid), 2486.7585,2374.5234,6.8437);
	            SetVehicleZAngle(GetPlayerVehicleID(playerid), 271.9420);
	            SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 0);
	            LinkVehicleToInterior(GetPlayerVehicleID(playerid), 6);   
				SetPlayerInterior(playerid, 6);
				SetPlayerVirtualWorld(playerid, 0);                   
	        }
	        else
			{
				SetTimerEx("EnterExitTimer", 8000, false, "i", playerid);
	            SetPlayerPos(playerid, 2486.7585,2374.5234,6.8437);
	            SetPlayerFacingAngle(playerid, 271.9420);
				SetPlayerInterior(playerid, 6);
				SetPlayerVirtualWorld(playerid, 0);
	        }			
		}
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 2485.8213,2379.3203,7.0685) && GetPlayerInterior(playerid) == 6) // keluar basemen news 
		{
		    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
				SetTimerEx("EnterExitTimer", 8000, false, "i", playerid);
		        SetVehiclePos(GetPlayerVehicleID(playerid), 1180.2900,-1339.0264,13.5089);
		        SetVehicleZAngle(GetPlayerVehicleID(playerid), 272.5181);
		        SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 0);
		        LinkVehicleToInterior(GetPlayerVehicleID(playerid), 0);   
				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);   
		    }
		    else
			{
				SetTimerEx("EnterExitTimer", 8000, false, "i", playerid);
			    SetPlayerPos(playerid, 1180.2900,-1339.0264,13.5089);
			    SetPlayerFacingAngle(playerid, 272.5181);
				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
		    }	
		}  
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 1767.5198,-1887.3687,13.5916)) // masuk basemen stasiun
		{
			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
				SetTimerEx("EnterExitTimer", 8000, false, "i", playerid);
	            SetVehiclePos(GetPlayerVehicleID(playerid), 2486.7585,2374.5234,6.8437);
	            SetVehicleZAngle(GetPlayerVehicleID(playerid), 271.9420);
	            SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 0);
	            LinkVehicleToInterior(GetPlayerVehicleID(playerid), 7);   
				SetPlayerInterior(playerid, 7);
				SetPlayerVirtualWorld(playerid, 0);                   
	        }
	        else
			{
				SetTimerEx("EnterExitTimer", 8000, false, "i", playerid);
	            SetPlayerPos(playerid, 2486.7585,2374.5234,6.8437);
	            SetPlayerFacingAngle(playerid, 271.9420);
				SetPlayerInterior(playerid, 7);
				SetPlayerVirtualWorld(playerid, 0);
	        }
		}
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 2485.8213,2379.3203,7.0685) && GetPlayerInterior(playerid) == 7) // keluar basemen stasiun
		{
			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
				SetVehiclePos(GetPlayerVehicleID(playerid), 1769.2347,-1893.7607,13.5916);
				SetVehicleZAngle(GetPlayerVehicleID(playerid), 270.3540);
				SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 0);
				LinkVehicleToInterior(GetPlayerVehicleID(playerid), 0);
				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
			}
			else
			{
				SetPlayerPos(playerid, 1769.2347,-1893.7607,13.5916);
				SetPlayerFacingAngle(playerid, 270.3540);
				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
			}
		}  
	}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	//Spec Player
	new vehicleid = GetPlayerVehicleID(playerid);
	if(newstate == PLAYER_STATE_ONFOOT)
	{
		if(pData[playerid][playerSpectated] != 0)
		{
			foreach(new ii : Player)
			{
				if(pData[ii][pSpec] == playerid)
				{
					PlayerSpectatePlayer(ii, playerid);
					Servers(ii, ,"%s(%i) is now on foot.", pData[playerid][pName], playerid);
				}
			}
		}
	}
	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
    {
		if(pData[playerid][pInjured] == 1)
        {
			RemovePlayerFromVehicle(playerid);
            SetPlayerHealthEx(playerid, 100);
        }
		foreach (new ii : Player) if(pData[ii][pSpec] == playerid) 
		{
            PlayerSpectateVehicle(ii, GetPlayerVehicleID(playerid));
        }
	}
	if(oldstate == PLAYER_STATE_PASSENGER)
	{
		TextDrawHideForPlayer(playerid, TDEditor_TD[0]);
		TextDrawHideForPlayer(playerid, DPvehfare[playerid]);
	}
	if(oldstate == PLAYER_STATE_DRIVER)
    {	
		if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CARRY || GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED)
            return RemovePlayerFromVehicle(playerid);

		
		//HBE Modern
		TextDrawHideForPlayer(playerid, PlayerVehSpeedMph);
		PlayerTextDrawHide(playerid, PlayerVehDamage[playerid]);
		PlayerTextDrawHide(playerid, PlayerVehSpeed[playerid]);
		PlayerTextDrawHide(playerid, PlayerVehFuel[playerid]);

		for(new i = 0; i < 2; i++) 
		{
			TextDrawHideForPlayer(playerid, Crate[i]);
			PlayerTextDrawHide(playerid, PlayerCrate[playerid]);
		}	
		
		for(new i = 0; i < 13; i++) 
		{
			if(DialogSaya[playerid][i] == true) // Cari apakah dia punya salah satu diantara 10 dialog tersebut
			{
				DialogSaya[playerid][i] = false; // Ubah Jadi Dia ga punya dialog lagi Kalau Udah Disconnect (Bukan dia lagi pemilik)
			}
		}
		if(IsASweeperVeh(vehicleid))
		{
			for(new i = 0; i < 3; i++) 
			{
				if(DialogSweeper[i] == true) 
				{
					DialogSweeper[i] = false; // Jadi ga ada yang punya nih dialog
				}
			}
			KerjaSweeper[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
		}
		if(IsABusABVeh(vehicleid))
		{
			for(new i = 0; i < 3; i++) 
			{
				if(DialogBus[i] == true) 
				{
					DialogBus[i] = false; // Jadi ga ada yang punya nih dialog
				}
			}
			KerjaBus[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
		}
		if(IsABusCDVeh(vehicleid))
		{
			for(new i = 0; i < 3; i++) 
			{
				if(DialogBusCD[i] == true) 
				{
					DialogBusCD[i] = false; // Jadi ga ada yang punya nih dialog
				}
			}
			KerjaBus[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
		}
		if(IsAForkliftVeh(vehicleid))
		{
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			DisablePlayerCheckpoint(playerid);
		}
		if(pData[playerid][pTaxiDuty] == 1)
		{
			pData[playerid][pTaxiDuty] = 0;
			SetPlayerColor(playerid, COLOR_WHITE);
			Servers(playerid, "You are no longer on taxi duty!");
		}
		if(pData[playerid][pFare] == 1)
		{
			KillTimer(pData[playerid][pFareTimer]);
			SendClientMessageEx(playerid, COLOR_ARWIN,"JOB: "WHITE_E"Anda telah menonaktifkan taxi fare pada total: {00FF00}$%s", FormatMoney(pData[playerid][pTotalFare]));
			pData[playerid][pFare] = 0;
			pData[playerid][pTotalFare] = 0;
		}
	}
	else if(newstate == PLAYER_STATE_DRIVER)
    {
		foreach(new pv : PVehicles)
		{
			if(vehicleid == pvData[pv][cVeh])
			{
				if(pvData[pv][cComponent] > 0)
				{
					TextDrawShowForPlayer(playerid, Crate[0]);
					TextDrawShowForPlayer(playerid, Crate[1]);
					PlayerTextDrawShow(playerid, PlayerCrate[playerid]);
					new String2[212];
					format(String2,sizeof(String2),"Component %d units", pvData[pv][cComponent]);
					PlayerTextDrawSetString(playerid, PlayerCrate[playerid], String2);
				}
				else if(pvData[pv][cCrateComponent] > 0)
				{
					TextDrawShowForPlayer(playerid, Crate[0]);
					TextDrawShowForPlayer(playerid, Crate[1]);
					PlayerTextDrawShow(playerid, PlayerCrate[playerid]);
					new String2[212];
					format(String2,sizeof(String2),"Crate (Component) %d units", pvData[pv][cCrateComponent]);
					PlayerTextDrawSetString(playerid, PlayerCrate[playerid], String2);
				}
				else if(pvData[pv][cCrateFish] > 0)
				{
					TextDrawShowForPlayer(playerid, Crate[0]);
					TextDrawShowForPlayer(playerid, Crate[1]);
					PlayerTextDrawShow(playerid, PlayerCrate[playerid]);
					new String2[212];
					format(String2,sizeof(String2),"Crate (Fish) %d units", pvData[pv][cCrateFish]);
					PlayerTextDrawSetString(playerid, PlayerCrate[playerid], String2);
				}
				else if(pvData[pv][cWheat] > 0)
				{
					TextDrawShowForPlayer(playerid, Crate[0]);
					TextDrawShowForPlayer(playerid, Crate[1]);
					PlayerTextDrawShow(playerid, PlayerCrate[playerid]);
					new String2[212];
					format(String2,sizeof(String2),"plant (wheat) %d units", pvData[pv][cWheat]);
					PlayerTextDrawSetString(playerid, PlayerCrate[playerid], String2);
				}
				else if(pvData[pv][cOnion] > 0)
				{
					TextDrawShowForPlayer(playerid, Crate[0]);
					TextDrawShowForPlayer(playerid, Crate[1]);
					PlayerTextDrawShow(playerid, PlayerCrate[playerid]);
					new String2[212];
					format(String2,sizeof(String2),"plant (Onion) %d units", pvData[pv][cOnion]);
					PlayerTextDrawSetString(playerid, PlayerCrate[playerid], String2);
				}
				else if(pvData[pv][cCarrot] > 0)
				{
					TextDrawShowForPlayer(playerid, Crate[0]);
					TextDrawShowForPlayer(playerid, Crate[1]);
					PlayerTextDrawShow(playerid, PlayerCrate[playerid]);
					new String2[212];
					format(String2,sizeof(String2),"plant (Carrot) %d units", pvData[pv][cCarrot]);
					PlayerTextDrawSetString(playerid, PlayerCrate[playerid], String2);
				}
				else if(pvData[pv][cPotato] > 0)
				{
					TextDrawShowForPlayer(playerid, Crate[0]);
					TextDrawShowForPlayer(playerid, Crate[1]);
					PlayerTextDrawShow(playerid, PlayerCrate[playerid]);
					new String2[212];
					format(String2,sizeof(String2),"plant (Potato) %d units", pvData[pv][cPotato]);
					PlayerTextDrawSetString(playerid, PlayerCrate[playerid], String2);
				}
				else if(pvData[pv][cCorn] > 0)
				{
					TextDrawShowForPlayer(playerid, Crate[0]);
					TextDrawShowForPlayer(playerid, Crate[1]);
					PlayerTextDrawShow(playerid, PlayerCrate[playerid]);
					new String2[212];
					format(String2,sizeof(String2),"plant (Corn) %d units", pvData[pv][cCorn]);
					PlayerTextDrawSetString(playerid, PlayerCrate[playerid], String2);
				}
				else if(pvData[pv][cLumber] > 0)
				{
					TextDrawShowForPlayer(playerid, Crate[0]);
					TextDrawShowForPlayer(playerid, Crate[1]);
					PlayerTextDrawShow(playerid, PlayerCrate[playerid]);
					new String2[212];
					format(String2,sizeof(String2),"Timber %d units", pvData[pv][cLumber]);
					PlayerTextDrawSetString(playerid, PlayerCrate[playerid], String2);
				}
				if(pvData[pv][cImpound] == 2)
				{
					RemovePlayerFromVehicle(playerid);
					Error(playerid, "The tires of this vehicle have been locked");
				}
				if(IsABike(vehicleid) || GetVehicleModel(vehicleid) == 424)
				{
					if(pvData[pv][cLocked] == 1)
					{
						RemovePlayerFromVehicle(playerid);
						Error(playerid, "This bike is locked by owner.");
						return 1;
					}
				}
			}
		}
		if(IsSAPDCar(vehicleid))
		{
		    if(pData[playerid][pFaction] != 1)
			{
			    RemovePlayerFromVehicle(playerid);
			    new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
			    Error(playerid, "You are not SAPD!");
			}
		}
		
		if(IsSAMDCar(vehicleid))
		{
		    if(pData[playerid][pFaction] != 3)
			{
			    RemovePlayerFromVehicle(playerid);
			    new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
			    Error(playerid, "You are not SAMD!");
			}
		}
		if(IsSANACar(vehicleid))
		{
		    if(pData[playerid][pFaction] != 4)
			{
			    RemovePlayerFromVehicle(playerid);
			    new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
			    Error(playerid, "You are not SANEW!");
			}
		}
		if(GetVehicleModel(vehicleid) == 548 || GetVehicleModel(vehicleid) == 417 || GetVehicleModel(vehicleid) == 487 || GetVehicleModel(vehicleid) == 488 ||
		GetVehicleModel(vehicleid) == 497 || GetVehicleModel(vehicleid) == 563 || GetVehicleModel(vehicleid) == 469)
		{
			if(pData[playerid][pLevel] < 5)
			{
				RemovePlayerFromVehicle(playerid);
			    new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
				Error(playerid, "Anda tidak memiliki izin!");
			}
		}
		if(IsADmvVeh(vehicleid))
		{
			if(pData[playerid][pSedangCarDmv] == 1)
			{
			    SedangDmv[playerid] = 1;
			    DmvSteps[playerid] = 2;
			    SetPlayerRaceCheckpoint(playerid, 0, 2047.1849,-1930.2665,13.0876,1968.0247,-1930.1829,13.0882, 5.0);
			    InfoTD_MSG(playerid, 3000, "Ikuti Checkpoint!");
			}
			else
			{
				RemovePlayerFromVehicle(playerid);
			    new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
				SetVehicleToRespawn(GetPlayerVehicleID(playerid));
				Error(playerid, "Anda tidak memiliki izin!");
			}
		}
		if(IsASweeperVeh(vehicleid))
		{
			new String[212], S3MP4K[212];
		    if(pData[playerid][pSideJobTimeSweap] == 0)
			{
		    	strcat(S3MP4K, "Route\tPrice\n");
				format(String, sizeof(String), "Sweeper Route A\t%s\n", (DialogSweeper[0] == true) ? ("{FF0000}Taken") : ("{33AA33}$50.00"));
				strcat(S3MP4K, String);
				format(String, sizeof(String), "Sweeper Route B\t%s\n", (DialogSweeper[1] == true) ? ("{FF0000}Taken") : ("{33AA33}$55.00"));
				strcat(S3MP4K, String);
				format(String, sizeof(String), "Sweeper Route C\t%s\n", (DialogSweeper[2] == true) ? ("{FF0000}Taken") : ("{33AA33}$75.00"));
				strcat(S3MP4K, String);
				ShowPlayerDialog(playerid, SWEEPERJOB, DIALOG_STYLE_TABLIST_HEADERS, "Sweeper Sidejob", S3MP4K, "Select", "Cancel");
			}
			else
			{
			    format(String, sizeof(String),"ERROR: Kamu harus menunggu %d Menit untuk menjadi Street Cleaner", pData[playerid][pSideJobTimeSweap]/60);
			    SendClientMessage(playerid, COLOR_GRAD2, String);
				RemovePlayerFromVehicle(playerid);
				SetVehicleToRespawn(GetPlayerVehicleID(playerid));
		 	}
		}
		if(IsABusCDVeh(vehicleid))
		{
		    new String[500], S3MP4K[500];
		    if(pData[playerid][pSideJobTimeBus] == 0)
			{
		    	strcat(S3MP4K, "Route\tPayout\n");
				format(String, sizeof(String), "{00FFFF}Route C: Fish Factory - Mechanic Center\t%s\n", (DialogBusCD[0] == true) ? ("{FF0000}Taken") : ("{33AA33}$175.00"));
				strcat(S3MP4K, String);
				format(String, sizeof(String), "{00FFFF}Route D: Ganton - Ocean Dock\t%s\n", (DialogBusCD[1] == true) ? ("{FF0000}Taken") : ("{33AA33}$225.00"));
				strcat(S3MP4K, String);
				ShowPlayerDialog(playerid, BUSJOBCD, DIALOG_STYLE_TABLIST_HEADERS, "Sidejob: Bus Driver", S3MP4K, "Select", "Cancel");
			}
			else
			{
			    format(String, sizeof(String),"ERROR: Kamu harus menunggu %d Menit untuk menjadi Bus Driver", pData[playerid][pSideJobTimeBus]/60);
			    SendClientMessage(playerid, COLOR_GRAD2, String);
				RemovePlayerFromVehicle(playerid);
				SetVehicleToRespawn(GetPlayerVehicleID(playerid));			
		 	}
		}
		if(IsABusABVeh(vehicleid))
		{
		    new String[500], S3MP4K[500];
		    if(pData[playerid][pSideJobTimeBus] == 0)
			{
		    	strcat(S3MP4K, "Route\tPayout\n");
				format(String, sizeof(String), "{00FFFF}Route A: Market\t%s\n", (DialogBus[0] == true) ? ("{FF0000}Taken") : ("{33AA33}$150.00"));
				strcat(S3MP4K, String);
				format(String, sizeof(String), "{00FFFF}Route B: Ocean Dock\t%s\n", (DialogBus[1] == true) ? ("{FF0000}Taken") : ("{33AA33}$185.00"));
				strcat(S3MP4K, String);
				format(String, sizeof(String), "{00FFFF}Route C: Jefferson\t%s\n", (DialogBus[2] == true) ? ("{FF0000}Taken") : ("{33AA33}$210.00"));
				strcat(S3MP4K, String);
				ShowPlayerDialog(playerid, BUSJOB, DIALOG_STYLE_TABLIST_HEADERS, "Sidejob: Bus Driver", S3MP4K, "Select", "Cancel");
			}
			else
			{
			    format(String, sizeof(String),"ERROR: Kamu harus menunggu %d Menit untuk menjadi Bus Driver", pData[playerid][pSideJobTimeBus]/60);
			    SendClientMessage(playerid, COLOR_GRAD2, String);
				RemovePlayerFromVehicle(playerid);
				SetVehicleToRespawn(GetPlayerVehicleID(playerid));			
		 	}
		}
		if(IsAVehicleDealerVeh(vehicleid, playerid))
		{
			new string[212];
			format(string, sizeof(string),"Would you like to buy this {00FFFF}%s?\n\n"WHITE_E"This vehicle costs {00FF00}$%s.", GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[GetCarDealershipId(vehicleid)][cdVehicleCost][GetCarDealershipVehicleId(vehicleid)]));
		    ShowPlayerDialog(playerid,DIALOG_CDBUY,DIALOG_STYLE_MSGBOX,"Buying Vehicle:",string,"Buy","Cancel");
		    TogglePlayerControllable(playerid, false);
        }
		if(IsAForkliftVeh(vehicleid))
		{
			ShowPlayerDialog(playerid, DIALOG_FORKLIFT, DIALOG_STYLE_MSGBOX, "Side Job - Forklift", "Anda akan bekerja sebagai forklift?", "Start Job", "Close");
		}
		if(!IsEngineVehicle(vehicleid))
        {
            SwitchVehicleEngine(vehicleid, true);
        }
		if(IsEngineVehicle(vehicleid) && pData[playerid][pDriveLic] <= 0)
        {
            SendClientMessageEx(playerid, COLOR_RED,"WARNING: "YELLOW_E"You do have a Driver License or your Driver License is expired.");
        }
		if(IsEngineVehicle(vehicleid) && !GetEngineStatus(vehicleid))
		{
			SendClientMessageEx(playerid, COLOR_ARWIN,"ENGINE: Mesin masih mati, ketik /engine untuk menghidupkannya.");
		}
		if(!IsABike(vehicleid))
		{
			if(pData[playerid][pTogSealtbelt] == 1)
			{
				if(pData[playerid][pSeatBelt] == 0)
				{
					pData[playerid][pSeatBelt] = 1;
					SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"Seatbelts "GREEN_E"ON");
				}
			}
		}
		else
		{
			if(pData[playerid][pTogHelmet] == 1)
			{
				if(pData[playerid][pHelmetOn] == 0)
				{
					pData[playerid][pHelmetOn] = 1;
					SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"Helmet "GREEN_E"ON");
					GivePlayerHelmet(playerid);
				}
			}
		}
		
		if(pData[playerid][pHBEMode] == 1)
		{
			if(!JB_IsBicycle(vehicleid))
			{
				TextDrawShowForPlayer(playerid, PlayerVehSpeedMph);
				PlayerTextDrawShow(playerid, PlayerVehDamage[playerid]);
				PlayerTextDrawShow(playerid, PlayerVehSpeed[playerid]);
				PlayerTextDrawShow(playerid, PlayerVehFuel[playerid]);
			}
			else
			{
				TextDrawShowForPlayer(playerid, PlayerVehSpeedMph);
				PlayerTextDrawShow(playerid, PlayerVehDamage[playerid]);
				PlayerTextDrawShow(playerid, PlayerVehSpeed[playerid]);
				PlayerTextDrawShow(playerid, PlayerVehFuel[playerid]);
			}
		}
		new Float:health;
        GetVehicleHealth(GetPlayerVehicleID(playerid), health);
        VehicleHealthSecurityData[GetPlayerVehicleID(playerid)] = health;
        VehicleHealthSecurity[GetPlayerVehicleID(playerid)] = true;

		if(pData[playerid][playerSpectated] != 0)
  		{
			foreach(new ii : Player)
			{
    			if(pData[ii][pSpec] == playerid)
			    {
        			PlayerSpectateVehicle(ii, vehicleid);
				    Servers(ii, "%s(%i) is now driving a %s(%d).", pData[playerid][pName], playerid, GetVehicleModelName(GetVehicleModel(vehicleid)), vehicleid);
				}
			}
		}
		SetPVarInt(playerid, "LastVehicleID", vehicleid);
		SetPVarInt(playerid, "CarID", vehicleid);
	}
	if(newstate == PLAYER_STATE_PASSENGER)
	{
		foreach(new i : Player)
		{
		    if(GetPlayerState(i) == PLAYER_STATE_DRIVER && GetPlayerVehicleID(i) == GetPlayerVehicleID(playerid))
		    {
		        if(pData[i][pTaxiDuty] == 1)
		        {
		            SendClientMessageEx(playerid, COLOR_ARWIN, "TAXI: "WHITE_E"Please Mark your destination on maps");
				}
			}
		}
	}
	return 1;
}

public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ,Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
	new weaponid = EditingWeapon[playerid];
    if(weaponid)
    {
        if(response == 1)
        {
            new enum_index = weaponid - 1, weaponname[18], string[340];
 
            GetWeaponName(weaponid, weaponname, sizeof(weaponname));
           
            WeaponSettings[playerid][enum_index][Position][0] = fOffsetX;
            WeaponSettings[playerid][enum_index][Position][1] = fOffsetY;
            WeaponSettings[playerid][enum_index][Position][2] = fOffsetZ;
            WeaponSettings[playerid][enum_index][Position][3] = fRotX;
            WeaponSettings[playerid][enum_index][Position][4] = fRotY;
            WeaponSettings[playerid][enum_index][Position][5] = fRotZ;
 
            RemovePlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid));
            SetPlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid), GetWeaponModel(weaponid), WeaponSettings[playerid][enum_index][Bone], fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, 1.0, 1.0, 1.0);
 
            SendClientMessageEx(playerid, COLOR_ARWIN, "WEAPONINFO: "WHITE_E"You have successfully adjusted the position of your %s.", weaponname);
           
            mysql_format(g_SQL, string, sizeof(string), "INSERT INTO weaponsettings (Owner, WeaponID, PosX, PosY, PosZ, RotX, RotY, RotZ) VALUES ('%d', %d, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f) ON DUPLICATE KEY UPDATE PosX = VALUES(PosX), PosY = VALUES(PosY), PosZ = VALUES(PosZ), RotX = VALUES(RotX), RotY = VALUES(RotY), RotZ = VALUES(RotZ)", pData[playerid][pID], weaponid, fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ);
            mysql_tquery(g_SQL, string);
        }
		else if(response == 0)
		{
			new enum_index = weaponid - 1;
			SetPlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid), GetWeaponModel(weaponid), WeaponSettings[playerid][enum_index][Bone], fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, 1.0, 1.0, 1.0);
		}
        EditingWeapon[playerid] = 0;
		return 1;
    }
	if(pData[playerid][pAksesoris] != -1 && !EditingWeapon[playerid])
    {
        if(response)
        {
            new id = pData[playerid][pAksesoris];
            AccData[playerid][id][accOffset][0] = fOffsetX;
            AccData[playerid][id][accOffset][1] = fOffsetY;
            AccData[playerid][id][accOffset][2] = fOffsetZ;
            AccData[playerid][id][accRot][0] = fRotX;
            AccData[playerid][id][accRot][1] = fRotY;
            AccData[playerid][id][accRot][2] = fRotZ;
            AccData[playerid][id][accScale][0] = (fScaleX > 3.0) ? (3.0) : (fScaleX);
            AccData[playerid][id][accScale][1] = (fScaleY > 3.0) ? (3.0) : (fScaleY);
            AccData[playerid][id][accScale][2] = (fScaleZ > 3.0) ? (3.0) : (fScaleZ);
            Aksesoris_Attach(playerid, id);
            pData[playerid][pAksesoris] = -1;  
            SendCustomMessage(playerid, "ACCESORY","Accessory saved!.");
        }
        else
        {
            if(pData[playerid][pAksesoris] != -1)
            {
                Aksesoris_Attach(playerid, pData[playerid][pAksesoris]);
                pData[playerid][pAksesoris] = -1;
            }
        }
        return 1;
    }
	return 1;
}

public OnPlayerEnterDynamicArea(playerid, areaid)
{
    #if defined DEBUG_MODE
        printf("[Callback: OnPlayerEnterDynamicArea]: Player ID: %d, Area ID: %d", playerid, areaid);
    #endif

    if(areaid == production && startProduce[playerid] && GetPVarInt(playerid, "lagiedit") == 0)
	{
		Info(playerid, "Posisikan furniture pada area kerja");

		PlayerEditPoint(playerid, 1489.54, 1789.14, 10.90, 0.0, 0.0, 0.0, "editLokasiFurn", produceObject[playerid]);
		SetPVarInt(playerid, "lagiedit", 1);
	}
    return 1;
}

public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	if(checkpointid == ShowRoomLV)
	{
		ShowPlayerDialog(playerid, DIALOG_BUYPVCP, DIALOG_STYLE_LIST, "Showroom LV", "Bikes\nCars\nUnique Cars\nJob Cars", "Select", "Cancel");
	}
	if(checkpointid == ShowRoomLS)
	{
		ShowPlayerDialog(playerid, DIALOG_BUYPVLS, DIALOG_STYLE_LIST, "Showroom LS", "Bikes\nCars\nJob Cars", "Select", "Cancel");
	}
	if(checkpointid == GaragePickup[0])
	{
		GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER~w~ OR~n~~r~H~n~~w~TO ENTER/EXIT", 3000, 4);
	}
	if(checkpointid == GaragePickup[1])
	{
		GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER~w~ OR~n~~r~H~n~~w~TO ENTER/EXIT", 3000, 4);
	}
	if(checkpointid == GaragePickup[2])
	{
		GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER~w~ OR~n~~r~H~n~~w~TO ENTER/EXIT", 3000, 4);
	}
	if(checkpointid == GaragePickup[3])
	{
		GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER~w~ OR~n~~r~H~n~~w~TO ENTER/EXIT", 3000, 4);
	}
    if(checkpointid == GaragePickup[4])
	{
		GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER~w~ OR ~r~H~n~~w~TO ENTER/EXIT", 3000, 4);
	}
    if(checkpointid == GaragePickup[5])
	{
		GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER~w~ OR ~r~H~n~~w~TO ENTER/EXIT", 3000, 4);
	}
	if(checkpointid == GaragePickup[6])
	{
		GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER~w~ OR ~r~H~n~~w~TO ENTER/EXIT", 3000, 4);
	}
	if(checkpointid == GaragePickup[7])
	{
		GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER~w~ OR ~r~H~n~~w~TO ENTER/EXIT", 3000, 4);
	}
	foreach(new did : Doors)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ]))
		{
			if(checkpointid == dData[did][dPickupext])
			{
				GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER~w~ OR ~r~F~n~~w~TO ENTER/EXIT", 3000, 4);
			}	
		}
	}		
	foreach(new atm : ATMS)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.8, AtmData[atm][atmX], AtmData[atm][atmY], AtmData[atm][atmZ]))
		{
			if(checkpointid == AtmData[atm][atmpickup])
			{
				GameTextForPlayer(playerid, "~p~ATM MACHINE~n~~w~USE '~y~/ATM~w~' TO USE ATM", 3000, 4);
			}	
		}
	}
	foreach(new houseid : Houses)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, hData[houseid][hGarageposX], hData[houseid][hGarageposY], hData[houseid][hGarageposZ]))
		{
			if(checkpointid == hData[houseid][hGarageCP])
			{
				GameTextForPlayer(playerid, "~w~USE ~R~/INGARAGE~w~ OR ~r~/OUTGARAGE~n~~w~TO ENTER/EXIT", 3000, 4);
			}	
		}
	}
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	if(pData[playerid][pJob] == 8 || pData[playerid][pJob2] == 8)
	{
		if(IsPlayerInRangeOfPoint(playerid, 7.0, 870.1083,-25.8352,63.9148))
		{
			pData[playerid][pSideJob] = 0;
			DisablePlayerRaceCheckpoint(playerid);
			pData[playerid][pCgun] += 2000;
			StockMarijuana += 1000;
			RemovePlayerAttachedObject(playerid, 9);
			pData[playerid][pJobSmugglerTime] = 5400;
			Server_Save();
		}
	}
	if(pData[playerid][pJobsSmuggleOn] == 1)
	{
		GameTextForPlayer(playerid, "~p~SMUGGLER PACKET~n~~w~USE ~R~/TAKEPACKET~w~ TO PICKUP PACKET", 3000, 4);
	}
	if(pData[playerid][pJobsSmuggleTakePacket] == 1)
	{
		if(IsPlayerInRangeOfPoint(playerid, 4.0, 1544.3517,16.3697,24.1406))
		{
			foreach(new i : Player) if(pData[i][pJob] == 11)
			{
				pData[i][pJobsSmuggleOn] = 0;
				pData[i][pJobsSmugglePacket] = 0;
				pData[i][pJobsSmuggleTakePacket] = 0;				
			}
			SendClientMessageEx(playerid, COLOR_ARWIN, "JOB: "WHITE_E"You've delivered the package and recieved the payment of "GREEN_E"$250.00");
			GivePlayerMoneyEx(playerid, 35000);
			DisablePlayerRaceCheckpoint(playerid);
			StockMaterial += 1000;
			Server_Save();
		}
	}
    if(SedangHauling[playerid] > 0)
	{
 		if(SedangHauling[playerid] == 1)
	    {
     		DisablePlayerRaceCheckpoint(playerid);
     		SendClientMessageEx(playerid, COLOR_ARWIN,"TRUCKING: {FFFFFF}Attach the trailer to your vehicle to order Location "YELLOW_E"%s", GetLocation(-2471.2942, 783.0248, 35.1719));
  			SedangHauling[playerid] = 2;
     		SetPlayerRaceCheckpoint(playerid, 1, -2471.2942, 783.0248, 35.1719, -2471.2942, 783.0248, 35.1719, 10.0);
       		return 1;
		}
		else if(SedangHauling[playerid] == 2)
		{
			if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
			{
			    DisablePlayerRaceCheckpoint(playerid);
                SedangHauling[playerid] = 0;
				AddPlayerSalary(playerid, "Ocean Dock Imports", "Delivered cargo", 35000);												
                pData[playerid][pHaulingTime] += 30*60;
                DialogHauling[0] = false;
                DialogSaya[playerid][0] = false;
                DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
				SendClientMessage(playerid, COLOR_ARWIN, "SALARY: "WHITE_E"Your salary statement has been update, please check command "YELLOW_E"'/mysalary'");
                return 1;
			}
		}
		else if(SedangHauling[playerid] == 3)
	    {
     		DisablePlayerRaceCheckpoint(playerid);
     		SendClientMessageEx(playerid, COLOR_ARWIN,"TRUCKING: {FFFFFF}Attach the trailer to your vehicle to order Location "YELLOW_E"%s", GetLocation(-576.2687, 2569.0842, 53.5156));
  			SedangHauling[playerid] = 4;
     		SetPlayerRaceCheckpoint(playerid, 1, -576.2687, 2569.0842, 53.5156, 576.2687, 2569.0842, 53.5156, 10.0);
       		return 1;
		}
		else if(SedangHauling[playerid] == 4)
		{
			if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
			{
			    DisablePlayerRaceCheckpoint(playerid);
                SedangHauling[playerid] = 0;
				AddPlayerSalary(playerid, "Ocean Dock Imports", "Delivered cargo", 30000);		
                pData[playerid][pHaulingTime] += 30*60;
                DialogHauling[1] = false;
                DialogSaya[playerid][1] = false;
                DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
                SendClientMessage(playerid, COLOR_ARWIN, "SALARY: "WHITE_E"Your salary statement has been update, please check command "YELLOW_E"'/mysalary'");
                return 1;
			}
		}
		else if(SedangHauling[playerid] == 5)
	    {
     		DisablePlayerRaceCheckpoint(playerid);
     		SendClientMessageEx(playerid, COLOR_ARWIN,"TRUCKING: {FFFFFF}Attach the trailer to your vehicle to order Location "YELLOW_E"%s", GetLocation(1424.8624, 2333.4939, 10.8203));
  			SedangHauling[playerid] = 6;
     		SetPlayerRaceCheckpoint(playerid, 1, 1424.8624, 2333.4939, 10.8203, 1424.8624, 2333.4939, 10.8203, 10.0);
       		return 1;
		}
		else if(SedangHauling[playerid] == 6)
		{
			if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
			{
			    DisablePlayerRaceCheckpoint(playerid);
                SedangHauling[playerid] = 0;
				AddPlayerSalary(playerid, "Angel Pine Exports", "Delivered cargo", 25000);		
                pData[playerid][pHaulingTime] += 30*60;
                DialogHauling[2] = false;
                DialogSaya[playerid][2] = false;
                DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
                SendClientMessage(playerid, COLOR_ARWIN, "SALARY: "WHITE_E"Your salary statement has been update, please check command "YELLOW_E"'/mysalary'");
                return 1;
			}
		}
		else if(SedangHauling[playerid] == 7)
	    {
     		DisablePlayerRaceCheckpoint(playerid);
     		SendClientMessageEx(playerid, COLOR_ARWIN,"TRUCKING: {FFFFFF}Attach the trailer to your vehicle to order Location "YELLOW_E"%s", GetLocation(1198.7153, 165.4331, 20.5056));
  			SedangHauling[playerid] = 8;
     		SetPlayerRaceCheckpoint(playerid, 1, 1198.7153, 165.4331, 20.5056, 1198.7153, 165.4331, 20.5056, 10.0);
       		return 1;
		}
		else if(SedangHauling[playerid] == 8)
		{
			if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
			{
			    DisablePlayerRaceCheckpoint(playerid);
                SedangHauling[playerid] = 0;
				AddPlayerSalary(playerid, "Angel Pine Exports", "Delivered cargo", 27000);		
                pData[playerid][pHaulingTime] += 30*60;
                DialogHauling[3] = false;
                DialogSaya[playerid][3] = false;
                DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
                SendClientMessage(playerid, COLOR_ARWIN, "SALARY: "WHITE_E"Your salary statement has been update, please check command "YELLOW_E"'/mysalary'");
                return 1;
			}
		}
		else if(SedangHauling[playerid] == 9)
	    {
     		DisablePlayerRaceCheckpoint(playerid);
     		SendClientMessageEx(playerid, COLOR_ARWIN,"TRUCKING: {FFFFFF}Attach the trailer to your vehicle to order Location "YELLOW_E"%s", GetLocation(1201.5385, 171.6184, 20.5035));
  			SedangHauling[playerid] = 10;
     		SetPlayerRaceCheckpoint(playerid, 1, 1201.5385, 171.6184, 20.5035, 1201.5385, 171.6184, 20.5035, 10.0);
       		return 1;
		}
		else if(SedangHauling[playerid] == 10)
		{
			if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
			{
			    DisablePlayerRaceCheckpoint(playerid);
                SedangHauling[playerid] = 0;
				AddPlayerSalary(playerid, "Chilliad Deport", "Delivered cargo", 39900);	
                pData[playerid][pHaulingTime] += 30*60;
                DialogHauling[4] = false;
                DialogSaya[playerid][4] = false;
                DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
                SendClientMessage(playerid, COLOR_ARWIN, "SALARY: "WHITE_E"Your salary statement has been update, please check command "YELLOW_E"'/mysalary'");
                return 1;
			}
		}
		else if(SedangHauling[playerid] == 11)
	    {
     		DisablePlayerRaceCheckpoint(playerid);
     		SendClientMessageEx(playerid, COLOR_ARWIN,"TRUCKING: {FFFFFF}Attach the trailer to your vehicle to order Location "YELLOW_E"%s", GetLocation(2786.8313, -2417.9558, 13.6339));
  			SedangHauling[playerid] = 12;
     		SetPlayerRaceCheckpoint(playerid, 1, 2786.8313, -2417.9558, 13.6339, 2786.8313, -2417.9558, 13.6339, 10.0);
       		return 1;
		}
		else if(SedangHauling[playerid] == 12)
		{
			if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
			{
			    DisablePlayerRaceCheckpoint(playerid);
                SedangHauling[playerid] = 0;
				AddPlayerSalary(playerid, "Chilliad Deport", "Delivered cargo", 20000);	
                pData[playerid][pHaulingTime] += 30*60;
                DialogHauling[5] = false;
                DialogSaya[playerid][5] = false;
                DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
                SendClientMessage(playerid, COLOR_ARWIN, "SALARY: "WHITE_E"Your salary statement has been update, please check command "YELLOW_E"'/mysalary'");
                return 1;
			}
		}
		else if(SedangHauling[playerid] == 13)
	    {
     		DisablePlayerRaceCheckpoint(playerid);
     		SendClientMessageEx(playerid, COLOR_ARWIN,"TRUCKING: {FFFFFF}Attach the trailer to your vehicle to order Location "YELLOW_E"%s", GetLocation(1613.7815, 2236.2046, 10.3787));
  			SedangHauling[playerid] = 14;
     		SetPlayerRaceCheckpoint(playerid, 1, 1613.7815, 2236.2046, 10.3787, 1613.7815, 2236.2046, 10.3787, 10.0);
       		return 1;
		}
		else if(SedangHauling[playerid] == 14)
		{
			if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
			{
			    DisablePlayerRaceCheckpoint(playerid);
                SedangHauling[playerid] = 0;
				AddPlayerSalary(playerid, "Easter Import", "Delivered cargo", 31000);	
                pData[playerid][pHaulingTime] += 30*60;
                DialogHauling[6] = false;
                DialogSaya[playerid][6] = false;
                DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
                SendClientMessage(playerid, COLOR_ARWIN, "SALARY: "WHITE_E"Your salary statement has been update, please check command "YELLOW_E"'/mysalary'");
                return 1;
			}
		}
		else if(SedangHauling[playerid] == 15)
	    {
     		DisablePlayerRaceCheckpoint(playerid);
     		SendClientMessageEx(playerid, COLOR_ARWIN,"TRUCKING: {FFFFFF}Attach the trailer to your vehicle to order Location "YELLOW_E"%s", GetLocation(2415.7803, -2470.1309, 13.6300));
  			SedangHauling[playerid] = 16;
     		SetPlayerRaceCheckpoint(playerid, 1, 2415.7803, -2470.1309, 13.6300, 2415.7803, -2470.1309, 13.6300, 10.0);
       		return 1;
		}
		else if(SedangHauling[playerid] == 16)
		{
			if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
			{
			    DisablePlayerRaceCheckpoint(playerid);
                SedangHauling[playerid] = 0;
				AddPlayerSalary(playerid, "Blueberry Export", "Delivered cargo", 33300);	
                pData[playerid][pHaulingTime] += 30*60;
                DialogHauling[7] = false;
                DialogSaya[playerid][7] = false;
                DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
                SendClientMessage(playerid, COLOR_ARWIN, "SALARY: "WHITE_E"Your salary statement has been update, please check command "YELLOW_E"'/mysalary'");
                return 1;
			}
		}
		else if(SedangHauling[playerid] == 17)
	    {
     		DisablePlayerRaceCheckpoint(playerid);
     		SendClientMessageEx(playerid, COLOR_ARWIN,"TRUCKING: {FFFFFF}Attach the trailer to your vehicle to order Location "YELLOW_E"%s", GetLocation(-980.1684, -713.3505, 32.0078));
  			SedangHauling[playerid] = 18;
     		SetPlayerRaceCheckpoint(playerid, 1, -980.1684, -713.3505, 32.0078, -980.1684, -713.3505, 32.0078, 10.0);
       		return 1;
		}
		else if(SedangHauling[playerid] == 18)
		{
			if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
			{
			    DisablePlayerRaceCheckpoint(playerid);
                SedangHauling[playerid] = 0;
				AddPlayerSalary(playerid, "Las Venturas Deport", "Delivered cargo", 29000);	
                pData[playerid][pHaulingTime] += 30*60;
                DialogHauling[8] = false;
                DialogSaya[playerid][8] = false;     
                DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
                SendClientMessage(playerid, COLOR_ARWIN, "SALARY: "WHITE_E"Your salary statement has been update, please check command "YELLOW_E"'/mysalary'");
                return 1;
			}
		}
		else if(SedangHauling[playerid] == 19)
	    {
     		DisablePlayerRaceCheckpoint(playerid);
     		SendClientMessageEx(playerid, COLOR_ARWIN,"TRUCKING: {FFFFFF}Attach the trailer to your vehicle to order Location "YELLOW_E"%s", GetLocation(-2226.1292, -2315.1055, 30.6045));
  			SedangHauling[playerid] = 20;
     		SetPlayerRaceCheckpoint(playerid, 1, -2226.1292, -2315.1055, 30.6045, -2226.1292, -2315.1055, 30.6045, 10.0);
       		return 1;
		}
		else if(SedangHauling[playerid] == 20)
		{
			if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
			{
			    DisablePlayerRaceCheckpoint(playerid);
                SedangHauling[playerid] = 0;
				AddPlayerSalary(playerid, "Las Venturas Fuel & Gas", "Delivered cargo", 22500);	
                pData[playerid][pHaulingTime] += 30*60;
                DialogHauling[9] = false;
                DialogSaya[playerid][9] = false;
                DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
                SendClientMessage(playerid, COLOR_ARWIN, "SALARY: "WHITE_E"Your salary statement has been update, please check command "YELLOW_E"'/mysalary'");
                return 1;
			}
		}
		return 1;
	}
	if(pData[playerid][pSedangCarDmv] == 1)
	{
	   if(DmvSteps[playerid] > 0)
		{
		 if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 426)
		    {
			 	if(IsPlayerInAnyVehicle(playerid))
				{
				    if(DmvSteps[playerid] == 2)
				    {
				        DisablePlayerRaceCheckpoint(playerid);				        
				        DmvSteps[playerid] = 3;
				        SetPlayerRaceCheckpoint(playerid, 0, 1968.0247,-1930.1829,13.0882,1824.0208,-1917.7654,13.0856, 5);
				        return 1;
				    }
				    else if(DmvSteps[playerid] == 3)
				    {
				        DisablePlayerRaceCheckpoint(playerid);				        
				        DmvSteps[playerid] = 4;
				        SetPlayerRaceCheckpoint(playerid, 0, 1824.0208,-1917.7654,13.0856,1787.3108,-1827.8440,13.0876, 5);
				        return 1;
				    }
				    else if(DmvSteps[playerid] == 4)
				    {
				        DisablePlayerRaceCheckpoint(playerid);				        
				        DmvSteps[playerid] = 5;
				        SetPlayerRaceCheckpoint(playerid, 0, 1787.3108,-1827.8440,13.0876,1688.0021,-1840.3541,13.0876, 5);
				        return 1;
				    }
				    else if(DmvSteps[playerid] == 5)
				    {
				        DisablePlayerRaceCheckpoint(playerid);				        
				        DmvSteps[playerid] = 6;
				        SetPlayerRaceCheckpoint(playerid, 0, 1688.0021,-1840.3541,13.0876,1625.1812,-1870.2305,13.0882, 5);
				        return 1;
				    }
				    else if(DmvSteps[playerid] == 6)
				    {
				        DisablePlayerRaceCheckpoint(playerid);				        
				        DmvSteps[playerid] = 7;
				        SetPlayerRaceCheckpoint(playerid, 0, 1625.1812,-1870.2305,13.0882,1571.7096,-1852.4192,13.0876, 5);
				        return 1;
				    }
					else if(DmvSteps[playerid] == 7)
				    {
				        DisablePlayerRaceCheckpoint(playerid);				        
				        DmvSteps[playerid] = 8;
				        SetPlayerRaceCheckpoint(playerid, 0, 1571.7096,-1852.4192,13.0876,1556.1931,-1730.5265,13.0875, 5);
				        return 1;
				    }
					else if(DmvSteps[playerid] == 8)
				    {
				        DisablePlayerRaceCheckpoint(playerid);				        
				        DmvSteps[playerid] = 9;
				        SetPlayerRaceCheckpoint(playerid, 0, 1556.1931,-1730.5265,13.0875,1531.9980,-1715.3065,13.0876, 5);
				        return 1;
				    }
					else if(DmvSteps[playerid] == 9)
				    {
				        DisablePlayerRaceCheckpoint(playerid);				        
				        DmvSteps[playerid] = 10;
				        SetPlayerRaceCheckpoint(playerid, 0, 1531.9980,-1715.3065,13.0876,1542.4998,-1594.5765,13.0876, 5);
				        return 1;
				    }
					else if(DmvSteps[playerid] == 10)
				    {
				        DisablePlayerRaceCheckpoint(playerid);				        
				        DmvSteps[playerid] = 11;
				        SetPlayerRaceCheckpoint(playerid, 0, 1542.4998,-1594.5765,13.0876,1680.8341,-1595.0997,13.0914, 5);
				        return 1;
				    }
					else if(DmvSteps[playerid] == 11)
				    {
				        DisablePlayerRaceCheckpoint(playerid);				        
				        DmvSteps[playerid] = 12;
				        SetPlayerRaceCheckpoint(playerid, 0, 1680.8341,-1595.0997,13.0914,1844.6248,-1614.3239,13.0882, 5);
				        return 1;
				    }
					else if(DmvSteps[playerid] == 12)
				    {
				        DisablePlayerRaceCheckpoint(playerid);				        
				        DmvSteps[playerid] = 13;
				        SetPlayerRaceCheckpoint(playerid, 0, 1844.6248,-1614.3239,13.0882,1939.3665,-1631.7688,13.0875, 5);
				        return 1;
				    }
					else if(DmvSteps[playerid] == 13)
				    {
				        DisablePlayerRaceCheckpoint(playerid);				        
				        DmvSteps[playerid] = 14;
				        SetPlayerRaceCheckpoint(playerid, 0, 1939.3665,-1631.7688,13.0875,1958.7997,-1769.8575,13.0876, 5);
				        return 1;
				    }
					else if(DmvSteps[playerid] == 14)
				    {
				        DisablePlayerRaceCheckpoint(playerid);				        
				        DmvSteps[playerid] = 15;
				        SetPlayerRaceCheckpoint(playerid, 0, 1958.7997,-1769.8575,13.0876,1980.0818,-1814.7788,13.0877, 5);
				        return 1;
				    }
					else if(DmvSteps[playerid] == 15)
				    {
				        DisablePlayerRaceCheckpoint(playerid);				        
				        DmvSteps[playerid] = 16;
				        SetPlayerRaceCheckpoint(playerid, 0, 1980.0818,-1814.7788,13.0877,2079.0569,-1824.9231,13.0873, 5);
				        return 1;
				    }
					else if(DmvSteps[playerid] == 16)
				    {
				        DisablePlayerRaceCheckpoint(playerid);				        
				        DmvSteps[playerid] = 17;
				        SetPlayerRaceCheckpoint(playerid, 0, 2079.0569,-1824.9231,13.0873,2061.8386,-1913.1362,13.2507, 5);
				        return 1;
				    }
					else if(DmvSteps[playerid] == 17)
				    {
				        DisablePlayerRaceCheckpoint(playerid);				        
				        DmvSteps[playerid] = 18;
				        SetPlayerRaceCheckpoint(playerid, 1, 2061.8386,-1913.1362,13.2507,2061.8386,-1913.1362,13.2507, 5);
				        return 1;
				    }
				    else if(DmvSteps[playerid] == 18)
				    {
				        DisablePlayerRaceCheckpoint(playerid);				        
				        DmvSteps[playerid] = 0;
				        pData[playerid][pSedangCarDmv] = 0;
				        pData[playerid][pTaketest] = 1;
				        pData[playerid][pDriveLic] = 1;
	                    pData[playerid][pDriveLicTime] = gettime() + (91 * 86400);
	                    SendClientMessageEx(playerid, COLOR_ARWIN, "LICENSE: "WHITE_E"You have successfully passed the test and received your license");     
	                    SendClientMessageEx(playerid, COLOR_ARWIN, "LICENSE: "WHITE_E"Your {00FFFF}Drive license "WHITE_E"is active for "YELLOW_E"3 months");   
						SetVehicleToRespawn(GetPlayerVehicleID(playerid));
				        return 1;
				    }
				}
			}
		}
	}
	for(new i; i <= 3; i++) // 3 = Total Dialog , Jadi kita mau tau kalau Player Ini Apakah Ambil Dialog dari 3 tersebut apa ga !
	{
		if(BusSteps[playerid][i] > 0 || BusCDSteps[playerid][i] > 0)
		{
		    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 431)
		    {
			 	if(IsPlayerInAnyVehicle(playerid))
				{
				    if(BusSteps[playerid][0] == 2)
				    {
						DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][0] = 3;
				        SetPlayerRaceCheckpoint(playerid, 0, 1655.0614,-1509.0916,13.4789,1655.5630,-1565.3380,13.4733, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 3)
				    {
						DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][0] = 4;
				        SetPlayerRaceCheckpoint(playerid, 1, 1655.5630,-1565.3380,13.4733,1687.7946,-1626.7117,13.4835, 5);
						return 1;
				    }
				    else if(BusSteps[playerid][0] == 4)
				    {
				        TogglePlayerControllable(playerid,0);
				        pData[playerid][pBusWaiting] = 15;
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 5)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][0] = 6;
				        SetPlayerRaceCheckpoint(playerid, 0, 1686.8270,-1785.6464,13.4834,1639.6644,-1867.2939,13.5545, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 6)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][0] = 7;
				        SetPlayerRaceCheckpoint(playerid, 1, 1639.6644,-1867.2939,13.5545,1458.2944,-1869.8359,13.4872, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 7)
				    {
						TogglePlayerControllable(playerid,0);
				        pData[playerid][pBusWaiting] = 15;
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 8)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][0] = 9;
				        SetPlayerRaceCheckpoint(playerid, 0, 1249.1691,-1849.7340,13.4877,1183.1147,-1734.5684,13.5010, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 9)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][0] = 10;
				        SetPlayerRaceCheckpoint(playerid, 1, 1183.1147,-1734.5684,13.5010,1101.0165,-1710.1997,13.4831, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 10)
				    {
				        TogglePlayerControllable(playerid,0);
				        pData[playerid][pBusWaiting] = 15;
				        return 1;
				    }
        			else if(BusSteps[playerid][0] == 11)
				    {
						DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][0] = 12;
				        SetPlayerRaceCheckpoint(playerid, 0, 1039.8864,-1591.9750,13.4778,1060.9194,-1363.9476,13.4898, 5);
						return 1;
				    }
				    else if(BusSteps[playerid][0] == 12)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][0] = 13;
				        SetPlayerRaceCheckpoint(playerid, 0, 1060.9194,-1363.9476,13.4898,1101.3558,-1283.3710,13.5804, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 13)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][0] = 14;
				        SetPlayerRaceCheckpoint(playerid, 0, 1101.3558,-1283.3710,13.5804,1192.5363,-1350.0110,13.5029, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 14)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][0] = 15;
				        SetPlayerRaceCheckpoint(playerid, 1, 1192.5363,-1350.0110,13.5029,1249.9329,-1402.9601,13.1006, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 15)
				    {
				        TogglePlayerControllable(playerid,0);
				        pData[playerid][pBusWaiting] = 15;
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 16)
				    {
						DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][0] = 17;
				        SetPlayerRaceCheckpoint(playerid, 0, 1390.7616,-1409.5153,13.4878,1439.2830,-1443.2465,13.4834, 5);
						return 1;
				    }
				    else if(BusSteps[playerid][0] == 17)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][0] = 18;
				        SetPlayerRaceCheckpoint(playerid, 0, 1439.2830,-1443.2465,13.4834,1586.5532,-1442.9948,13.4915, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 18)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][0] = 19;
				        SetPlayerRaceCheckpoint(playerid, 0, 1586.5532,-1442.9948,13.4915,1655.4329,-1497.7919,13.4835, 5);
				        return 1;
				    }
					else if(BusSteps[playerid][0] == 19)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][0] = 20;
				        SetPlayerRaceCheckpoint(playerid, 0, 1655.4329,-1497.7919,13.4835,1684.0498,-1549.9923,13.4808, 5);
				        return 1;
				    }
					else if(BusSteps[playerid][0] == 20)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][0] = 21;
				        SetPlayerRaceCheckpoint(playerid, 1, 1684.0498,-1549.9923,13.4808,1678.8490,-1477.8701,13.4881, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 21)
				    {
				        BusSteps[playerid][0] = 0;
				        DialogBus[0] = false; // Dialog 0 telah di pilih
			    		DialogSaya[playerid][10] = false;
						SendClientMessage(playerid, COLOR_ARWIN, "SALARY: "WHITE_E"Your salary statement has been update, please check command "YELLOW_E"'/mysalary'");
						AddPlayerSalary(playerid, "Public Service (Bus Driver)", "Unity Station - Market", 15000);	
				        pData[playerid][pSideJobTimeBus] = 1800;
				        DisablePlayerRaceCheckpoint(playerid);
				        SetVehicleToRespawn(GetPlayerVehicleID(playerid));
				        return 1;
			   		}
        			else if(BusSteps[playerid][1] == 2)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][1] = 3;
				        SetPlayerRaceCheckpoint(playerid, 0, 1655.7677,-1517.0698,13.4846,1732.2749,-1599.0669,13.4744, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 3)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][1] = 4;
				        SetPlayerRaceCheckpoint(playerid, 0, 1732.2749,-1599.0669,13.4744,1818.6465,-1689.8517,13.4830, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 4)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][1] = 5;
				        SetPlayerRaceCheckpoint(playerid, 1, 1818.6465,-1689.8517,13.4830,1850.7994,-1755.0247,13.4829, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 5)
				    {
				        TogglePlayerControllable(playerid,0);
				        pData[playerid][pBusWaiting] = 15;
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 6)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][1] = 7;
				        SetPlayerRaceCheckpoint(playerid, 1, 1958.7798,-1810.5045,13.4897,1959.5511,-1917.3839,13.4884, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 7)
				    {
				        TogglePlayerControllable(playerid,0);
				        pData[playerid][pBusWaiting] = 15;
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 8)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][1] = 9;
				        SetPlayerRaceCheckpoint(playerid, 0, 1986.5461,-2112.7036,13.4384,2244.9275,-2214.8579,13.4303, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 9)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][1] = 10;
				        SetPlayerRaceCheckpoint(playerid, 0, 2244.9275,-2214.8579,13.4303,2294.8789,-2313.8787,13.4780, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 10)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][1] = 11;
				        SetPlayerRaceCheckpoint(playerid, 0, 2294.8789,-2313.8787,13.4780,2480.7498,-2424.2581,13.5537, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 11)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][1] = 12;
				        SetPlayerRaceCheckpoint(playerid, 1, 2480.7498,-2424.2581,13.5537,2648.6423,-2407.7979,13.5692, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 12)
				    {
				        TogglePlayerControllable(playerid,0);
				        pData[playerid][pBusWaiting] = 15;
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 13)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][1] = 14;
				        SetPlayerRaceCheckpoint(playerid, 0, 2549.7451,-2501.4832,13.6051,2482.7075,-2591.8521,13.5923, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 14)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][1] = 15;
				        SetPlayerRaceCheckpoint(playerid, 0, 2482.7075,-2591.8521,13.5923,2227.5525,-2616.8210,13.5022, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 15)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][1] = 16;
				        SetPlayerRaceCheckpoint(playerid, 0, 2227.5525,-2616.8210,13.5022,2191.0950,-2493.2742,13.4921, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 16)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][1] = 17;
				        SetPlayerRaceCheckpoint(playerid, 1, 2191.0950,-2493.2742,13.4921,2179.6602,-2425.1328,13.4756, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 17)
				    {
				        TogglePlayerControllable(playerid,0);
				        pData[playerid][pBusWaiting] = 15;
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 18)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][1] = 19;
				        SetPlayerRaceCheckpoint(playerid, 0, 2160.9170,-2342.9050,13.4523,2117.3035,-2250.8020,13.4834, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 19)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][1] = 20;
				        SetPlayerRaceCheckpoint(playerid, 0, 2117.3035,-2250.8020,13.4834,2089.5332,-2175.0454,13.4804, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 20)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][1] = 21;
				        SetPlayerRaceCheckpoint(playerid, 0, 2089.5332,-2175.0454,13.4804,1919.7875,-2164.1343,13.4837, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 21)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][1] = 22;
				        SetPlayerRaceCheckpoint(playerid, 0, 1919.7875,-2164.1343,13.4837,1786.2826,-2163.9875,13.4825, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 22)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][1] = 23;
				        SetPlayerRaceCheckpoint(playerid, 1, 1786.2826,-2163.9875,13.4825,1696.7385,-2164.0005,16.1921, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 23)
				    {
				        TogglePlayerControllable(playerid,0);
				        pData[playerid][pBusWaiting] = 15;
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 24)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][1] = 25;
				        SetPlayerRaceCheckpoint(playerid, 0, 1532.7091,-1961.6431,20.8978,1572.3435,-1806.2230,13.4837, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 25)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][1] = 26;
				        SetPlayerRaceCheckpoint(playerid, 0, 1572.3435,-1806.2230,13.4837,1532.5659,-1672.6637,13.4835, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 26)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][1] = 27;
				        SetPlayerRaceCheckpoint(playerid, 1, 1532.5659,-1672.6637,13.4835,1580.5101,-1594.2743,13.483, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 27)
				    {
				        TogglePlayerControllable(playerid,0);
				        pData[playerid][pBusWaiting] = 15;
				        return 1;
				    }
					else if(BusSteps[playerid][1] == 28)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][1] = 29;
				        SetPlayerRaceCheckpoint(playerid, 1, 1679.8983,-1549.8424,13.4752,1675.9579,-1477.6978,13.4807, 5);
				        return 1;
				    }
					else if(BusSteps[playerid][1] == 29)
				    {
				        BusSteps[playerid][1] = 0;
				        DialogBus[1] = false; // Dialog 0 telah di pilih
			    		DialogSaya[playerid][11] = false;
						SendClientMessage(playerid, COLOR_ARWIN, "SALARY: "WHITE_E"Your salary statement has been update, please check command "YELLOW_E"'/mysalary'");
						AddPlayerSalary(playerid, "Public Service (Bus Driver)", "Unity Station - Ocean Dock", 18500);
				        pData[playerid][pSideJobTimeBus] = 1800;
				        DisablePlayerRaceCheckpoint(playerid);
				        SetVehicleToRespawn(GetPlayerVehicleID(playerid));
				        return 1;
				    }
                    else if(BusSteps[playerid][2] == 2)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][2] = 3;
				        SetPlayerRaceCheckpoint(playerid, 0, 1655.6171,-1553.4003,13.4852,1509.8290,-1589.5262,13.4835, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][2] == 3)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][2] = 4;
				        SetPlayerRaceCheckpoint(playerid, 0, 1509.8290,-1589.5262,13.4835,1426.9106,-1666.9474,13.4768, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][2] == 4)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][2] = 5;
				        SetPlayerRaceCheckpoint(playerid, 1, 1426.9106,-1666.9474,13.4768,1387.0702,-1804.8052,13.4834, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][2] == 5)
				    {
				        TogglePlayerControllable(playerid,0);
				        pData[playerid][pBusWaiting] = 15;
				        return 1;
				    }
				    else if(BusSteps[playerid][2] == 6)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][2] = 7;
				        SetPlayerRaceCheckpoint(playerid, 0, 1176.9617,-1850.1705,13.4996,997.9429,-1786.8276,14.1585, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][2] == 7)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][2] = 8;
				        SetPlayerRaceCheckpoint(playerid, 0, 997.9429,-1786.8276,14.1585,876.9006,-1767.8977,13.4783, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][2] == 8)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][2] = 9;
				        SetPlayerRaceCheckpoint(playerid, 1, 876.8956,-1767.8170,13.4792,640.4097,-1619.6138,15.4023, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][2] == 9)
				    {
				        TogglePlayerControllable(playerid,0);
				        pData[playerid][pBusWaiting] = 15;
				        return 1;
				    }
				    else if(BusSteps[playerid][2] == 10)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][2] = 11;
				        SetPlayerRaceCheckpoint(playerid, 1, 640.2009,-1342.9097,13.4798,651.9466,-1206.3330,18.2219, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][2] == 11)
				    {
				        TogglePlayerControllable(playerid,0);
				        pData[playerid][pBusWaiting] = 15;
				        return 1;
				    }
				    else if(BusSteps[playerid][2] == 12)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][2] = 13;
				        SetPlayerRaceCheckpoint(playerid, 0, 856.3155,-1023.5062,28.1525,926.5991,-981.5485,38.3005, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][2] == 13)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][2] = 14;
				        SetPlayerRaceCheckpoint(playerid, 1, 926.5991,-981.5485,38.3005,1089.5221,-959.5559,42.4178, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][2] == 14)
				    {
				        TogglePlayerControllable(playerid,0);
				        pData[playerid][pBusWaiting] = 15;
				        return 1;
				    }
				    else if(BusSteps[playerid][2] == 15)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][2] = 16;
				        SetPlayerRaceCheckpoint(playerid, 0, 1354.5989,-982.7267,30.3430,1462.8319,-1036.5968,23.7577, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][2] == 16)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][2] = 17;
				        SetPlayerRaceCheckpoint(playerid, 1, 1462.8319,-1036.5968,23.7577,1569.6729,-1101.1849,23.5551, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][2] == 17)
				    {
				        TogglePlayerControllable(playerid,0);
				        pData[playerid][pBusWaiting] = 15;
				        return 1;
				    }
				    else if(BusSteps[playerid][2] == 18)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][2] = 19;
				        SetPlayerRaceCheckpoint(playerid, 0, 1665.2031,-1162.5167,23.7775,1712.3635,-1279.5549,13.4799, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][2] == 19)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][2] = 20;
				        SetPlayerRaceCheckpoint(playerid, 0, 1712.3635,-1279.5549,13.4799,1712.6737,-1411.1022,13.4839, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][2] == 20)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][2] = 21;
				        SetPlayerRaceCheckpoint(playerid, 0, 1712.6737,-1411.1022,13.4839,1680.5796,-1437.9404,13.4830, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][2] == 21)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][2] = 22;
				        SetPlayerRaceCheckpoint(playerid, 0, 1680.5796,-1437.9404,13.4830,1655.8517,-1494.2107,13.4838, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][2] == 22)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][2] = 23;
				        SetPlayerRaceCheckpoint(playerid, 0, 1655.8517,-1494.2107,13.4838,1683.1459,-1549.9835,13.4845, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][2] == 23)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusSteps[playerid][2] = 24;
				        SetPlayerRaceCheckpoint(playerid, 1, 1683.1459,-1549.9835,13.4845,1683.1459,-1549.9835,13.4845, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][2] == 24)
				    {
				        BusSteps[playerid][2] = 0;
				        DialogBus[1] = false; // Dialog 0 telah di pilih
			    		DialogSaya[playerid][12] = false;
						SendClientMessage(playerid, COLOR_ARWIN, "SALARY: "WHITE_E"Your salary statement has been update, please check command "YELLOW_E"'/mysalary'");
						AddPlayerSalary(playerid, "Public Service (Bus Driver)", "Unity Station - Jefferson", 21000);
				        pData[playerid][pSideJobTimeBus] = 1800;
				        DisablePlayerRaceCheckpoint(playerid);
				        SetVehicleToRespawn(GetPlayerVehicleID(playerid));
				        return 1;
				    }
				    //BusCD Rute1
                    if(BusCDSteps[playerid][0] == 2)
				    {
						DisablePlayerRaceCheckpoint(playerid);
				        BusCDSteps[playerid][0] = 3;
				        SetPlayerRaceCheckpoint(playerid, 0, 1824.4303, -1868.5961, 13.4755, 1823.8600, -1655.5120, 13.4841, 5);
				        return 1;
				    }
				    else if(BusCDSteps[playerid][0] == 3)
				    {
						DisablePlayerRaceCheckpoint(playerid);
				        BusCDSteps[playerid][0] = 4;
				        SetPlayerRaceCheckpoint(playerid, 0, 1823.8600, -1655.5120, 13.4841, 1912.5975, -1466.1296, 13.4840, 5);
						return 1;
				    }
                    else if(BusCDSteps[playerid][0] == 4)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusCDSteps[playerid][0] = 5;
				        SetPlayerRaceCheckpoint(playerid, 0, 1912.5975, -1466.1296, 13.4840, 1993.4578, -1468.9106, 13.4893, 5);
				        return 1;
				    }
				    else if(BusCDSteps[playerid][0] == 5)
				    {
                        DisablePlayerRaceCheckpoint(playerid);
				        BusCDSteps[playerid][0] = 6;
				        SetPlayerRaceCheckpoint(playerid, 1, 1993.4578, -1468.9106, 13.4893, 2114.6199, -1426.2263, 23.9274, 5);
				        return 1;
				    }
				    else if(BusCDSteps[playerid][0] == 6)
				    {
                        TogglePlayerControllable(playerid,0);
				        pData[playerid][pBusWaiting] = 1;
				        return 1;
				    }
				    else if(BusCDSteps[playerid][0] == 7)
				    {
				        BusCDSteps[playerid][0] = 8;
						DisablePlayerRaceCheckpoint(playerid);
						SetPlayerRaceCheckpoint(playerid, 1, 2073.7935, -1191.7556, 23.7855, 2072.3193, -1110.6896, 24.4992, 5.0);
				        return 1;
				    }
				    else if(BusCDSteps[playerid][0] == 8)
				    {
						TogglePlayerControllable(playerid,0);
				        pData[playerid][pBusWaiting] = 1;
				        return 1;
				    }
				    else if(BusCDSteps[playerid][0] == 9)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusCDSteps[playerid][0] = 10;
				        SetPlayerRaceCheckpoint(playerid, 0, 2122.5232, -1113.0942, 25.2557, 2155.0342, -1119.3589, 25.4545, 5);
				        return 1;
				    }
				    else if(BusCDSteps[playerid][0] == 10)
				    {
						BusCDSteps[playerid][0] = 11;
						DisablePlayerRaceCheckpoint(playerid);
						SetPlayerRaceCheckpoint(playerid, 1, 2155.0342, -1119.3589, 25.4545, 2305.9785, -1154.4709, 26.8148, 5.0);
				        return 1;
				    }
        			else if(BusCDSteps[playerid][0] == 11)
				    {
						TogglePlayerControllable(playerid,0);
				        pData[playerid][pBusWaiting] = 1;
						return 1;
				    }
				    else if(BusCDSteps[playerid][0] == 12)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusCDSteps[playerid][0] = 13;
				        SetPlayerRaceCheckpoint(playerid, 0, 2411.5713, -1180.1783, 32.0205, 2550.6301, -1186.1709, 60.7818, 5);
				        return 1;
				    }
				    else if(BusCDSteps[playerid][0] == 13)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusCDSteps[playerid][0] = 14;
				        SetPlayerRaceCheckpoint(playerid, 0, 2550.6301, -1186.1709, 60.7818, 2701.9453, -1186.0608, 69.3436, 5);
				        return 1;
				    }
				    else if(BusCDSteps[playerid][0] == 14)
				    {
						BusCDSteps[playerid][0] = 15;
						DisablePlayerRaceCheckpoint(playerid);
						SetPlayerRaceCheckpoint(playerid, 1, 2701.9453, -1186.0608, 69.3436, 2720.1895, -1255.4587, 59.6616, 5.0);
				        return 1;
				    }
				    else if(BusCDSteps[playerid][0] == 15)
				    {
						TogglePlayerControllable(playerid,0);
				        pData[playerid][pBusWaiting] = 1;
				        return 1;
				    }
				    else if(BusCDSteps[playerid][0] == 16)
				    {
						DisablePlayerRaceCheckpoint(playerid);
				        BusCDSteps[playerid][0] = 17;
				        SetPlayerRaceCheckpoint(playerid, 0, 2720.8303, -1466.1239, 30.3814, 2779.8931, -1490.1018, 25.5573, 5);
						return 1;
				    }
				    else if(BusCDSteps[playerid][0] == 17)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusCDSteps[playerid][0] = 18;
				        SetPlayerRaceCheckpoint(playerid, 0, 2779.8931, -1490.1018, 25.5573, 2860.3831, -1534.3351, 11.0173, 5);
				        return 1;
				    }
				    else if(BusCDSteps[playerid][0] == 18)
				    {
						BusCDSteps[playerid][0] = 19;
						DisablePlayerRaceCheckpoint(playerid);
						SetPlayerRaceCheckpoint(playerid, 1, 2860.3831, -1534.3351, 11.0173, 2843.5227, -1697.3945, 10.9756, 5.0);
				        return 1;
				    }
					else if(BusCDSteps[playerid][0] == 19)
				    {
						TogglePlayerControllable(playerid,0);
				        pData[playerid][pBusWaiting] = 1;
				        return 1;
				    }
					else if(BusCDSteps[playerid][0] == 20)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusCDSteps[playerid][0] = 21;
				        SetPlayerRaceCheckpoint(playerid, 0, 2821.0723, -1944.2610, 11.0382, 2621.0239, -2153.2166, 11.7653, 5);
				        return 1;
				    }
                    else if(BusCDSteps[playerid][0] == 21)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusCDSteps[playerid][0] = 22;
				        SetPlayerRaceCheckpoint(playerid, 0, 2621.0239, -2153.2166, 11.7653, 2309.6770, -2241.1067, 13.4773, 5);
				        return 1;
				    }
                    else if(BusCDSteps[playerid][0] == 22)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusCDSteps[playerid][0] = 23;
				        SetPlayerRaceCheckpoint(playerid, 0, 2309.6770, -2241.1067, 13.4773, 2255.0603, -2217.7026, 13.4009, 5);
				        return 1;
				    }
                    else if(BusCDSteps[playerid][0] == 23)
				    {
						BusCDSteps[playerid][0] = 24;
						DisablePlayerRaceCheckpoint(playerid);
						SetPlayerRaceCheckpoint(playerid, 1, 2255.0603, -2217.7026, 13.4009, 1997.9686, -2107.2495, 13.4439, 5.0);
				        return 1;
				    }
                    else if(BusCDSteps[playerid][0] == 24)
				    {
						TogglePlayerControllable(playerid,0);
				        pData[playerid][pBusWaiting] = 1;
				        return 1;
				    }
                    else if(BusCDSteps[playerid][0] == 25)
				    {
						BusCDSteps[playerid][0] = 26;
				        DisablePlayerRaceCheckpoint(playerid);
						SetPlayerRaceCheckpoint(playerid, 1, 1964.2448, -2024.7606, 13.4777, 1922.2885, -1930.0549, 13.4843, 5.0);
				        return 1;
				    }
                    else if(BusCDSteps[playerid][0] == 26)
				    {
						TogglePlayerControllable(playerid,0);
				        pData[playerid][pBusWaiting] = 1;
				        return 1;
				    }
                    else if(BusCDSteps[playerid][0] == 27)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusCDSteps[playerid][0] = 28;
				        SetPlayerRaceCheckpoint(playerid, 0, 1795.0150, -1887.2955, 13.4951, 1778.4117, -1915.0038, 13.4859, 5);
				        return 1;
				    }
                    else if(BusCDSteps[playerid][0] == 28)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusCDSteps[playerid][0] = 29;
				        SetPlayerRaceCheckpoint(playerid, 1, 1778.4117, -1915.0038, 13.4859, 1778.4117, -1915.0038, 13.4859, 5);
				        return 1;
				    }
				    else if(BusCDSteps[playerid][0] == 29)
				    {
				        BusCDSteps[playerid][0] = 0;
				        DialogBusCD[0] = false; // Dialog 0 telah di pilih
			    		DialogSaya[playerid][10] = false;
						SendClientMessage(playerid, COLOR_ARWIN, "SALARY: "WHITE_E"Your salary statement has been update, please check command "YELLOW_E"'/mysalary'");
						AddPlayerSalary(playerid, "Public Service (Bus Driver)", "Route C: Fish Factory - Mechanic Center", 17500);	
				        pData[playerid][pSideJobTimeBus] = 1800;
				        DisablePlayerRaceCheckpoint(playerid);
				        SetVehicleToRespawn(GetPlayerVehicleID(playerid));
				        return 1;
			   		}
                    //BusCD Rute2
        			else if(BusCDSteps[playerid][1] == 2)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusCDSteps[playerid][1] = 3;
				        SetPlayerRaceCheckpoint(playerid, 0, 1819.2391, -1910.0963, 13.4926, 1853.2333, -1934.8954, 13.4815, 5);
				        return 1;
				    }
				    else if(BusCDSteps[playerid][1] == 3)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusCDSteps[playerid][1] = 4;
				        SetPlayerRaceCheckpoint(playerid, 0, 1853.2333, -1934.8954, 13.4815, 2004.6316, -1935.0634, 13.4249, 5);
				        return 1;
				    }
				    else if(BusCDSteps[playerid][1] == 4)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusCDSteps[playerid][1] = 5;
				        SetPlayerRaceCheckpoint(playerid, 0, 2004.6316, -1935.0634, 13.4249, 2083.8550, -1875.2960, 13.4445, 5);
				        return 1;
				    }
				    else if(BusCDSteps[playerid][1] == 5)
				    {
                        DisablePlayerRaceCheckpoint(playerid);
				        BusCDSteps[playerid][1] = 6;
				        SetPlayerRaceCheckpoint(playerid, 0, 2083.8550, -1875.2960, 13.4445, 2088.6733, -1777.6893, 13.4835, 5);
				        return 1;
				    }
				    else if(BusCDSteps[playerid][1] == 6)
				    {
						DisablePlayerRaceCheckpoint(playerid);
						BusCDSteps[playerid][1] = 7;
						SetPlayerRaceCheckpoint(playerid, 1, 2088.6733, -1777.6893, 13.4835, 2158.1733, -1754.5261, 13.4905, 5);
				        
				        return 1;
				    }
				    else if(BusCDSteps[playerid][1] == 7)
				    {
						TogglePlayerControllable(playerid,0);
				        pData[playerid][pBusWaiting] = 1;
				        return 1;
				    }
				    else if(BusCDSteps[playerid][1] == 8)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusCDSteps[playerid][1] = 9;
				        SetPlayerRaceCheckpoint(playerid, 0, 2250.4578, -1734.3944, 13.4833, 2362.6665, -1750.7849, 13.4832, 5);
				        return 1;
				    }
				    else if(BusCDSteps[playerid][1] == 9)
				    {
						DisablePlayerRaceCheckpoint(playerid);
						BusCDSteps[playerid][1] = 10;
						SetPlayerRaceCheckpoint(playerid, 1, 2362.6665, -1750.7849, 13.4832, 2411.5051, -1797.7552, 13.4806, 5);
				        return 1;
				    }
				    else if(BusCDSteps[playerid][1] == 10)
				    {
						TogglePlayerControllable(playerid,0);
				        pData[playerid][pBusWaiting] = 1;
				        return 1;
				    }
				    else if(BusCDSteps[playerid][1] == 11)
				    {
						DisablePlayerRaceCheckpoint(playerid);
						BusCDSteps[playerid][1] = 12;
						SetPlayerRaceCheckpoint(playerid, 1, 2275.3528, -1969.5439, 13.4732, 2261.2886, -2062.5120, 13.4565, 5);
				        return 1;
				    }
				    else if(BusCDSteps[playerid][1] == 12)
				    {
						TogglePlayerControllable(playerid,0);
				        pData[playerid][pBusWaiting] = 1;
				        
				        return 1;
				    }
				    else if(BusCDSteps[playerid][1] == 13)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusCDSteps[playerid][1] = 14;
				        SetPlayerRaceCheckpoint(playerid, 0, 2452.2588, -2252.1899, 25.1630, 2656.7935, -2407.8079, 13.5835, 5);
				        return 1;
				    }
				    else if(BusCDSteps[playerid][1] == 14)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusCDSteps[playerid][1] = 15;
				        SetPlayerRaceCheckpoint(playerid, 0, 2656.7935, -2407.8079, 13.5835, 2681.4937, -2453.7986, 13.6228, 5);
				        return 1;
				    }
				    else if(BusCDSteps[playerid][1] == 15)
				    {
						DisablePlayerRaceCheckpoint(playerid);
						BusCDSteps[playerid][1] = 16;
						SetPlayerRaceCheckpoint(playerid, 1, 2681.4937, -2453.7986, 13.6228, 2610.7310, -2501.4695, 13.5928, 5);
				        return 1;
				    }
				    else if(BusCDSteps[playerid][1] == 16)
				    {
						TogglePlayerControllable(playerid,0);
				        pData[playerid][pBusWaiting] = 1;
				        return 1;
				    }
				    else if(BusCDSteps[playerid][1] == 17)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusCDSteps[playerid][1] = 18;
				        SetPlayerRaceCheckpoint(playerid, 0, 2482.1812, -2597.3862, 13.5806, 2334.4521, -2660.9644, 13.6094, 5);
				        return 1;
				    }
				    else if(BusCDSteps[playerid][1] == 18)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusCDSteps[playerid][1] = 19;
				        SetPlayerRaceCheckpoint(playerid, 0, 2334.4521, -2660.9644, 13.6094, 2227.3550, -2547.5479, 13.5192, 5);
				        return 1;
				    }
				    else if(BusCDSteps[playerid][1] == 19)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusCDSteps[playerid][1] = 20;
				        SetPlayerRaceCheckpoint(playerid, 0, 2227.3550, -2547.5479, 13.5192, 2200.7778, -2493.1272, 13.5293, 5);
				        return 1;
				    }
				    else if(BusCDSteps[playerid][1] == 20)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusCDSteps[playerid][1] = 21;
				        SetPlayerRaceCheckpoint(playerid, 0, 2200.7778, -2493.1272, 13.5293, 2177.2256, -2462.8418, 13.4756, 5);
				        return 1;
				    }
				    else if(BusCDSteps[playerid][1] == 21)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusCDSteps[playerid][1] = 22;
				        SetPlayerRaceCheckpoint(playerid, 0, 2177.2256, -2462.8418, 13.4756, 2254.8386, -2217.3760, 13.4167, 5);
				        return 1;
				    }
				    else if(BusCDSteps[playerid][1] == 22)
				    {
						DisablePlayerRaceCheckpoint(playerid);
						BusCDSteps[playerid][1] = 23;
						SetPlayerRaceCheckpoint(playerid, 1, 2254.8386, -2217.3760, 13.4167, 2084.4524, -2107.4363, 13.4388, 5);
				        return 1;
				    }
				    else if(BusCDSteps[playerid][1] == 23)
				    {
				        TogglePlayerControllable(playerid,0);
				        pData[playerid][pBusWaiting] = 1;
				        return 1;
				    }
				    else if(BusCDSteps[playerid][1] == 24)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusCDSteps[playerid][1] = 25;
				        SetPlayerRaceCheckpoint(playerid, 0, 1991.1692, -2107.9001, 13.4368, 1963.8104, -2049.0454, 13.5204, 5);
				        return 1;
				    }
				    else if(BusCDSteps[playerid][1] == 25)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusCDSteps[playerid][1] = 26;
				        SetPlayerRaceCheckpoint(playerid, 0, 1963.8104, -2049.0454, 13.5204, 1963.8976, -1948.3651, 13.7094, 5);
				        return 1;
				    }
				    else if(BusCDSteps[playerid][1] == 26)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusCDSteps[playerid][1] = 27;
				        SetPlayerRaceCheckpoint(playerid, 0, 1963.8976, -1948.3651, 13.7094, 1878.2025, -1930.3413, 13.4841, 5);
				        return 1;
				    }
				    else if(BusCDSteps[playerid][1] == 27)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusCDSteps[playerid][1] = 28;
				        SetPlayerRaceCheckpoint(playerid, 0, 1878.2025, -1930.3413, 13.4841, 1824.0964, -1902.0518, 13.4616, 5);
				        return 1;
				    }
					else if(BusCDSteps[playerid][1] == 28)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusCDSteps[playerid][1] = 29;
				        SetPlayerRaceCheckpoint(playerid, 0, 1824.0964, -1902.0518, 13.4616, 1796.9083, -1887.5566, 13.5029, 5);
				        return 1;
				    }
                    else if(BusCDSteps[playerid][1] == 29)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusCDSteps[playerid][1] = 30;
				        SetPlayerRaceCheckpoint(playerid, 0, 1796.9083, -1887.5566, 13.5029, 1778.5126, -1914.5742, 13.4879, 5);
				        return 1;
				    }
                    else if(BusCDSteps[playerid][1] == 30)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        BusCDSteps[playerid][1] = 31;
				        SetPlayerRaceCheckpoint(playerid, 1, 1778.5126, -1914.5742, 13.4879, 1778.5126, -1914.5742, 13.4879, 5);
				        return 1;
				    }
					else if(BusCDSteps[playerid][1] == 31)
				    {
				        BusCDSteps[playerid][1] = 0;
				        DialogBusCD[1] = false; // Dialog 0 telah di pilih
			    		DialogSaya[playerid][11] = false;
						SendClientMessage(playerid, COLOR_ARWIN, "SALARY: "WHITE_E"Your salary statement has been update, please check command "YELLOW_E"'/mysalary'");
						AddPlayerSalary(playerid, "Public Service (Bus Driver)", "Route D: Ganton - Ocean Dock", 22500);
				        pData[playerid][pSideJobTimeBus] = 1800;
				        DisablePlayerRaceCheckpoint(playerid);
				        SetVehicleToRespawn(GetPlayerVehicleID(playerid));
				        return 1;
				    }
				}
			}
		}
	}
	for(new i; i <= 3; i++) // 3 = Total Dialog , Jadi kita mau tau kalau Player Ini Apakah Ambil Dialog dari 3 tersebut apa ga !
	{
		if(SweeperSteps[playerid][i] > 0)
		{
		    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 574)
		    {
			 	if(IsPlayerInAnyVehicle(playerid))
				{
				    if(SweeperSteps[playerid][0] == 2)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][0] = 3;
				        SetPlayerRaceCheckpoint(playerid, 0, 1679.4075,-1867.3059,13.1157, 1691.9288,-1832.2202,13.1079, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][0] == 3)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][0] = 4;
				        SetPlayerRaceCheckpoint(playerid, 0, 1691.9288,-1832.2202,13.1079,1692.4034,-1749.3794,13.1151, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][0] == 4)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][0] = 5;
				        SetPlayerRaceCheckpoint(playerid, 0, 1692.4034,-1749.3794,13.1151,1660.8494,-1729.7914,13.1080, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][0] == 5)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][0] = 6;
				        SetPlayerRaceCheckpoint(playerid, 0, 1660.8494,-1729.7914,13.1080,1540.9940,-1729.6190,13.1079, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][0] == 6)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][0] = 7;
				        SetPlayerRaceCheckpoint(playerid, 0, 1540.9940,-1729.6190,13.1079,1531.4606,-1704.6635,13.1080, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][0] == 7)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][0] = 8;
				        SetPlayerRaceCheckpoint(playerid, 0, 1531.4606,-1704.6635,13.1080,1531.5427,-1606.7444,13.1079, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][0] == 8)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][0] = 9;
				        SetPlayerRaceCheckpoint(playerid, 0, 1531.5427,-1606.7444,13.1079,1466.9369,-1589.1991,13.1079, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][0] == 9)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][0] = 10;
				        SetPlayerRaceCheckpoint(playerid, 0, 1466.9369,-1589.1991,13.1079,1432.4270,-1570.9565,13.0785, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][0] == 10)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][0] = 11;
				        SetPlayerRaceCheckpoint(playerid, 0, 1432.4270,-1570.9565,13.0785,1456.8425,-1454.2955,13.0915, 5);
				        return 1;
				    }
        			else if(SweeperSteps[playerid][0] == 11)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][0] = 12;
				        SetPlayerRaceCheckpoint(playerid, 0, 1456.8425,-1454.2955,13.0915, 1494.9351,-1443.1246,13.1079, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][0] == 12)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][0] = 13;
				        SetPlayerRaceCheckpoint(playerid, 0, 1494.9351,-1443.1246,13.1079,1641.8486,-1443.4198,13.1079, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][0] == 13)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][0] = 14;
				        SetPlayerRaceCheckpoint(playerid, 0, 1641.8486,-1443.4198,13.1079,1732.5580,-1443.5229,13.0907, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][0] == 14)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][0] = 15;
				        SetPlayerRaceCheckpoint(playerid, 0, 1732.5580,-1443.5229,13.0907,1833.8168,-1463.2640,13.1003, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][0] == 15)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][0] = 16;
				        SetPlayerRaceCheckpoint(playerid, 0, 1833.8168,-1463.2640,13.1003,1842.4902,-1501.7483,13.0885, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][0] == 16)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][0] = 17;
				        SetPlayerRaceCheckpoint(playerid, 0, 1842.4902,-1501.7483,13.0885,1819.2338,-1595.7828,13.0841, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][0] == 17)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][0] = 18;
				        SetPlayerRaceCheckpoint(playerid, 0, 1819.2338,-1595.7828,13.0841,1818.7572,-1715.2195,13.1079, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][0] == 18)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][0] = 19;
				        SetPlayerRaceCheckpoint(playerid, 0, 1818.7572,-1715.2195,13.1079,1784.2252,-1730.2830,13.1079, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][0] == 19)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][0] = 20;
				        SetPlayerRaceCheckpoint(playerid, 0, 1784.2252,-1730.2830,13.1079,1702.9146,-1730.3160,13.1079, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][0] == 20)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][0] = 21;
				        SetPlayerRaceCheckpoint(playerid, 0, 1702.9146,-1730.3160,13.1079,1687.1395,-1765.6285,13.1079, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][0] == 21)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][0] = 22;
				        SetPlayerRaceCheckpoint(playerid, 0, 1687.1395,-1765.6285,13.1079,1647.3860,-1868.7577,13.1079, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][0] == 22)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][0] = 23;
				        SetPlayerRaceCheckpoint(playerid, 0, 1647.3860,-1868.7577,13.1079,1623.1375,-1894.7131,13.2753, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][0] == 23)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][0] = 24;
				        SetPlayerRaceCheckpoint(playerid, 1, 1623.1375,-1894.7131,13.2753,1623.1375,-1894.7131,13.2753, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][0] == 24)
				    {
				        BusSteps[playerid][0] = 0;
				        DialogSweeper[0] = false; // Dialog 0 telah di pilih
			    		DialogSaya[playerid][13] = false;
						GivePlayerMoneyEx(playerid, 5000);
						SendClientMessageEx(playerid, COLOR_ARWIN, "SIDEJOB: "WHITE_E"You've earned "GREEN_E"$50.00 "WHITE_E"for finishing sweeper sidejob");
				        pData[playerid][pSideJobTimeSweap] = 1800;
				        DisablePlayerRaceCheckpoint(playerid);
				        SetVehicleToRespawn(GetPlayerVehicleID(playerid));
				        return 1;
			   		}
        			else if(SweeperSteps[playerid][1] == 2)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][1] = 3;
				        SetPlayerRaceCheckpoint(playerid, 0, 1543.2211,-1870.5433,13.1079,1406.1967,-1869.4572,13.1079, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][1] == 3)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][1] = 4;
				        SetPlayerRaceCheckpoint(playerid, 0, 1406.1967,-1869.4572,13.1079,1322.0150,-1848.8750,13.1079, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][1] == 4)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][1] = 5;
				        SetPlayerRaceCheckpoint(playerid, 0, 1322.0150,-1848.8750,13.1079,1314.3750,-1767.4312,13.1079, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][1] == 5)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][1] = 6;
				        SetPlayerRaceCheckpoint(playerid, 0, 1314.3750,-1767.4312,13.1079,1339.7153,-1734.7532,13.1157, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][1] == 6)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][1] = 7;
				        SetPlayerRaceCheckpoint(playerid, 0, 1339.7153,-1734.7532,13.1157,1409.3979,-1734.8229,13.1157, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][1] == 7)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][1] = 8;
				        SetPlayerRaceCheckpoint(playerid, 0, 1409.3979,-1734.8229,13.1157, 1431.8108,-1670.3778,13.1079, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][1] == 8)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][1] = 9;
				        SetPlayerRaceCheckpoint(playerid, 0, 1431.8108,-1670.3778,13.1079,1431.4230,-1607.5250,13.1079, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][1] == 9)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][1] = 10;
				        SetPlayerRaceCheckpoint(playerid, 0, 1431.4230,-1607.5250,13.1079,1504.0176,-1594.9081,13.1080, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][1] == 10)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][1] = 11;
				        SetPlayerRaceCheckpoint(playerid, 0, 1504.0176,-1594.9081,13.1080,1643.0905,-1594.6688,13.1499, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][1] == 11)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][1] = 12;
				        SetPlayerRaceCheckpoint(playerid, 0, 1643.0905,-1594.6688,13.1499,1659.6577,-1563.4302,13.1157, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][1] == 12)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][1] = 13;
				        SetPlayerRaceCheckpoint(playerid, 0, 1659.6577,-1563.4302,13.1157,1697.9161,-1549.8684,13.1079, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][1] == 13)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][1] = 14;
				        SetPlayerRaceCheckpoint(playerid, 0, 1697.9161,-1549.8684,13.1079,1703.6350,-1488.4021,13.1135, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][1] == 14)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][1] = 15;
				        SetPlayerRaceCheckpoint(playerid, 0, 1703.6350,-1488.4021,13.1135,1670.9244,-1478.6689,13.1079, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][1] == 15)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][1] = 16;
				        SetPlayerRaceCheckpoint(playerid, 0, 1670.9244,-1478.6689,13.1079,1654.8127,-1575.8204,13.1079, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][1] == 16)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][1] = 17;
				        SetPlayerRaceCheckpoint(playerid, 0, 1654.8127,-1575.8204,13.1079,1678.8986,-1594.3568,13.1110, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][1] == 17)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][1] = 18;
				        SetPlayerRaceCheckpoint(playerid, 0, 1678.8986,-1594.3568,13.1110,686.6621,-1712.4702,13.1079, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][1] == 18)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][1] = 19;
				        SetPlayerRaceCheckpoint(playerid, 0, 1686.6621,-1712.4702,13.1079,1716.0092,-1735.4749,13.1079, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][1] == 19)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][1] = 20;
				        SetPlayerRaceCheckpoint(playerid, 0, 1716.0092,-1735.4749,13.1079,1810.7306,-1734.4653,13.1157, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][1] == 20)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][1] = 21;
				        SetPlayerRaceCheckpoint(playerid, 0, 1810.7306,-1734.4653,13.1157,1819.9282,-1812.2948,13.1282, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][1] == 21)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][1] = 22;
				        SetPlayerRaceCheckpoint(playerid, 0, 1819.9282,-1812.2948,13.1282,1702.8337,-1810.1008,13.0919, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][1] == 22)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][1] = 23;
				        SetPlayerRaceCheckpoint(playerid, 0, 1702.8337,-1810.1008,13.0919,1657.6678,-1868.3313,13.1079, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][1] == 23)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][1] = 24;
				        SetPlayerRaceCheckpoint(playerid, 0,1657.6678,-1868.3313,13.1079,1619.0530,-1894.1783,13.2742, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][1] == 24)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][1] = 25;
				        SetPlayerRaceCheckpoint(playerid, 1, 1619.0530,-1894.1783,13.2742,1619.0530,-1894.1783,13.2742, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][1] == 25)
				    {
				        SweeperSteps[playerid][1] = 0;
				        DialogSweeper[1] = false; // Dialog 0 telah di pilih
			    		DialogSaya[playerid][14] = false;
						GivePlayerMoneyEx(playerid, 5500);
						SendClientMessageEx(playerid, COLOR_ARWIN, "SIDEJOB: "WHITE_E"You've earned "GREEN_E"$55.00 "WHITE_E"for finishing sweeper sidejob");
				        pData[playerid][pSideJobTimeSweap] = 1800;
				        DisablePlayerRaceCheckpoint(playerid);
				        SetVehicleToRespawn(GetPlayerVehicleID(playerid));
				        return 1;
			   		}
			   		else if(SweeperSteps[playerid][2] == 2)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][2] = 3;
				        SetPlayerRaceCheckpoint(playerid, 0, 1691.4486,-1833.3379,13.4829,1805.1152,-1834.9608,13.4886, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][2] == 3)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][2] = 4;
				        SetPlayerRaceCheckpoint(playerid, 0, 1805.1152,-1834.9608,13.4886,1819.1494,-1914.2688,13.4891, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][2] == 4)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][2] = 5;
				        SetPlayerRaceCheckpoint(playerid, 0, 1819.1494,-1914.2688,13.4891,1933.4349,-1934.3416,13.4831, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][2] == 5)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][2] = 6;
				        SetPlayerRaceCheckpoint(playerid, 0, 1933.4349,-1934.3416,13.4831,2052.3677,-1935.8784,13.4118, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][2] == 6)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][2] = 7;
				        SetPlayerRaceCheckpoint(playerid, 0, 2052.3677,-1935.8784,13.4118,2083.9021,-1837.6925,13.4855, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][2] == 7)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][2] = 8;
				        SetPlayerRaceCheckpoint(playerid, 0, 2083.9021,-1837.6925,13.4855, 2019.7606,-1810.0647,13.4873, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][2] == 8)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][2] = 9;
				        SetPlayerRaceCheckpoint(playerid, 0, 2019.7606,-1810.0647,13.4873,1965.0964,-1768.8557,13.4828, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][2] == 9)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][2] = 10;
				        SetPlayerRaceCheckpoint(playerid, 0, 1965.0964,-1768.8557,13.4828,1943.7153,-1733.3943,13.4897, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][2] == 10)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][2] = 11;
				        SetPlayerRaceCheckpoint(playerid, 0, 1943.7153,-1733.3943,13.4897,1944.3800,-1629.5052,13.4863, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][2] == 11)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][2] = 12;
				        SetPlayerRaceCheckpoint(playerid, 0, 1944.3800,-1629.5052,13.4863,1854.7311,-1609.5864,13.4915, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][2] == 12)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][2] = 13;
				        SetPlayerRaceCheckpoint(playerid, 0, 1854.7311,-1609.5864,13.4915,1763.6650,-1601.8796,13.4821, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][2] == 13)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][2] = 14;
				        SetPlayerRaceCheckpoint(playerid, 0, 1763.6650,-1601.8796,13.4821,1747.2145,-1707.9730,13.4852, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][2] == 14)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][2] = 15;
				        SetPlayerRaceCheckpoint(playerid, 0, 1747.2145,-1707.9730,13.4852,1704.5280,-1730.1855,13.4832, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][2] == 15)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][2] = 16;
				        SetPlayerRaceCheckpoint(playerid, 0, 1704.5280,-1730.1855,13.4832,1671.0392,-1867.4829,13.4894, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][2] == 16)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][2] = 17;
				        SetPlayerRaceCheckpoint(playerid, 0, 1671.0392,-1867.4829,13.4894,1627.4254,-1874.8622,13.4865, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][2] == 17)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][2] = 18;
				        SetPlayerRaceCheckpoint(playerid, 0, 1627.4254,-1874.8622,13.4865,1614.0293,-1895.2081,13.6549, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][2] == 18)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        SweeperSteps[playerid][2] = 19;
				        SetPlayerRaceCheckpoint(playerid, 1, 1614.0293,-1895.2081,13.6549,1614.0293,-1895.2081,13.6549, 5);
				        return 1;
				    }
				    else if(SweeperSteps[playerid][2] == 19)
				    {
				        SweeperSteps[playerid][2] = 0;
				        DialogSweeper[2] = false; // Dialog 0 telah di pilih
			    		DialogSaya[playerid][15] = false;
						GivePlayerMoneyEx(playerid, 7500);
						SendClientMessageEx(playerid, COLOR_ARWIN, "SIDEJOB: "WHITE_E"You've earned "GREEN_E"$75.00 "WHITE_E"for finishing sweeper sidejob");
				        pData[playerid][pSideJobTimeSweap] = 1800;
				        DisablePlayerRaceCheckpoint(playerid);
				        SetVehicleToRespawn(GetPlayerVehicleID(playerid));
				        return 1;
			   		}
				}
			}
		}
	}
	if(pData[playerid][pSideJob] == 401)
	{
		if(IsPlayerInRangeOfPoint(playerid, 6.0,Forkliftpoint1))
		{
			GameTextForPlayer(playerid, "~p~JOBS~n~~w~USE '~y~/loadcreate~w~' TO GET CRATE", 3000, 4);
			return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 6.0,Forkliftpoint3))
		{
			GameTextForPlayer(playerid, "~p~JOBS~n~~w~USE '~y~/loadcreate~w~' TO GET CRATE", 3000, 4);
			return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 6.0,Forkliftpoint5))
		{
			GameTextForPlayer(playerid, "~p~JOBS~n~~w~USE '~y~/loadcreate~w~' TO GET CRATE", 3000, 4);
			return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 6.0,Forkliftpoint7))
		{
			GameTextForPlayer(playerid, "~p~JOBS~n~~w~USE '~y~/loadcreate~w~' TO GET CRATE", 3000, 4);
			return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 6.0,Forkliftpoint9))
		{
			GameTextForPlayer(playerid, "~p~JOBS~n~~w~USE '~y~/loadcreate~w~' TO GET CRATE", 3000, 4);
			return 1;
		}
	}
	if(pData[playerid][pSideJob] == 401)
	{
		if(IsPlayerInRangeOfPoint(playerid, 6.0,Forkliftpoint2))
		{
			if(pData[playerid][pJobsForklift1] == 1)
			{
				GameTextForPlayer(playerid, "~p~JOBS~n~~w~USE '~y~/unloadcreate~w~' TO UNLOAD CRATE", 3000, 4);
				return 1;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 6.0,Forkliftpoint4))
		{
			if(pData[playerid][pJobsForklift1] == 2)
			{
				GameTextForPlayer(playerid, "~p~JOBS~n~~w~USE '~y~/unloadcreate~w~' TO UNLOAD CRATE", 3000, 4);
				return 1;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 6.0,Forkliftpoint6))
		{
			if(pData[playerid][pJobsForklift1] == 3)
			{
				GameTextForPlayer(playerid, "~p~JOBS~n~~w~USE '~y~/unloadcreate~w~' TO UNLOAD CRATE", 3000, 4);
				return 1;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 6.0,Forkliftpoint8))
		{
			if(pData[playerid][pJobsForklift1] == 4)
			{
				GameTextForPlayer(playerid, "~p~JOBS~n~~w~USE '~y~/unloadcreate~w~' TO UNLOAD CRATE", 3000, 4);
				return 1;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 6.0,Forkliftpoint10))
		{
			if(pData[playerid][pJobsForklift1] == 5)
			{
				GameTextForPlayer(playerid, "~p~JOBS~n~~w~USE '~y~/unloadcreate~w~' TO UNLOAD CRATE", 3000, 4);
				return 1;
			}
		}
	}
	if(pData[playerid][pTrackCar] == 1)
	{
		new S3MP4K[212];
	    format(S3MP4K, sizeof(S3MP4K), "HINT: {FFFFFF}Anda telah berhasil menemukan kendaraan anda.");
		SendClientMessageEx(playerid, COLOR_ARWIN, S3MP4K);			
		pData[playerid][pTrackCar] = 0;
		DisablePlayerRaceCheckpoint(playerid);
	}
	if(pData[playerid][pTrackHouse] == 1)
	{
		new S3MP4K[212];
	    format(S3MP4K, sizeof(S3MP4K), "HINT: {FFFFFF}Anda telah berhasil menemukan rumah anda.");
		SendClientMessageEx(playerid, COLOR_ARWIN, S3MP4K);		
		pData[playerid][pTrackHouse] = 0;
		DisablePlayerRaceCheckpoint(playerid);
	}
	if(pData[playerid][pTrackBisnis] == 1)
	{
		new S3MP4K[212];
	    format(S3MP4K, sizeof(S3MP4K), "HINT: {FFFFFF}Anda telah berhasil menemukan bisnis anda.");
		SendClientMessageEx(playerid, COLOR_ARWIN, S3MP4K);		
		pData[playerid][pTrackBisnis] = 0;
		DisablePlayerRaceCheckpoint(playerid);
	}
	if(pData[playerid][pMission] > -1)
	{
		DisablePlayerRaceCheckpoint(playerid);
		SendClientMessageEx(playerid, COLOR_ARWIN,"TRUCKER: "WHITE_E"/buy , /gps(My Mission) , /storeproduct.");
	}
	if(pData[playerid][pHauling] > -1)
	{
		DisablePlayerRaceCheckpoint(playerid);
		SendClientMessageEx(playerid, COLOR_ARWIN,"TRUCKER: "WHITE_E"/buy , /gps(My Hauling) , /storegas.");
	}
	DisablePlayerRaceCheckpoint(playerid);
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(pData[playerid][pGuns][GetWeaponSlot(weaponid)] == weaponid)
	{
		if(pData[playerid][pAmmo][GetWeaponSlot(weaponid)] != 0)
		{
			new tstr[123];
			pData[playerid][pAmmo][GetWeaponSlot(weaponid)]--;
			if(pData[playerid][pTogAmmo] == 1)
			{
				format(tstr, sizeof(tstr), "%d", pData[playerid][pAmmo][GetWeaponSlot(weaponid)]);
				PlayerTextDrawSetString(playerid, TogAmmo[playerid], tstr);
			}
		}
	}
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	if(pData[playerid][pAdminDuty] == 1)return 1;
	new Float:hp;
	new Float:ap;

	GetPlayerArmour(playerid, ap);
	GetPlayerHealth(playerid, hp);
	if(amount < 0.0) amount = 0.0;
	if(amount > 150.0) amount = 150.0;
	// First define our base damage.
	switch(weaponid)
	{
		case 0 .. 3, 5 .. 8, 10 .. 15, 28, 32: if(amount > 20.0) amount = 20.0;
		case 4: if(amount > 150.0) amount = 150.0;
		case 9: if(amount > 30.0) amount = 30.0;
		case 23: if(amount > 14.0) amount = 14.0;
		case 24: if(amount > 5.0) amount = 5.0;
		case 38: if(amount > 47.0) amount = 47.0;
		case 25, 26: if(amount > 50.0) amount = 50.0;
		case 27: if(amount > 40.0) amount = 40.0;
		case 22, 29: if(amount > 9.0) amount = 9.0;
		case 30, 31: if(amount > 10.0) amount = 10.0;
		case 33: if(amount > 25.0) amount = 25.0;
		case 34: if(amount > 42.0) amount = 42.0;
		case 37, 42: if(amount > 3.0) amount = 3.0;
		case 41: amount = 0.0;
		default: if(amount > 20.0) amount = 20.0; // If there is no gun defined fall onto this (Should stop hacks going out of the 32-bit range)
	}
    if(issuerid != INVALID_PLAYER_ID)
    {
		new Float:Health, Float:armor;
        GetPlayerHealth(playerid, Health);
		GetPlayerArmour(playerid, armor);
		if(pData[issuerid][pAmmo][GetWeaponSlot(weaponid)] == 0)
		{
		}
		else if(amount)
		{
			if(bodypart == 9 && GetPlayerState(playerid) != PLAYER_STATE_WASTED) 
			{
				SendNearbyMessage(issuerid, 20.0, COLOR_YELLOW, "{C2A2DA} %s ditembak kepala oleh peluru.", GetRPName(playerid));
				SendClientMessageEx(playerid, SERVER_COLOR, "Kamu telah ditembak oleh %s dikepala.", GetRPName(issuerid));
				SendClientMessageEx(issuerid, COLOR_SYNTAX, "Kamu telah menembak kepala %s dengan peluru.", GetRPName(playerid));

				SetPlayerHealth(playerid, 0.0);
			}
			if(ap > amount) SetPlayerArmour(playerid, ap - amount);
			else if(ap == amount) SetPlayerArmour(playerid, 0);
			else if(ap < amount && ap)
			{
				SetPlayerArmour(playerid, 0);
				SetPlayerHealth(playerid, (amount - ap) - hp);
			}
			else SetPlayerHealth(playerid, hp - amount);
		}
    }
    return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	if(GetPVarInt(playerid,"OnWork"))  DisablePlayerCheckpoint(playerid);

	if(GetPlayerGPSInfo(playerid, G_ENABLED) == GPS_STATUS_ON)
	{
		if(IsPlayerInRangeOfPoint(playerid, 10.0, GetPlayerGPSInfo(playerid, G_POS_X), GetPlayerGPSInfo(playerid, G_POS_Y), GetPlayerGPSInfo(playerid, G_POS_Z)))
		{
			DisablePlayerGPS(playerid);
		}
	}
	if(pData[playerid][pFindEms] != INVALID_PLAYER_ID)
	{
		pData[playerid][pFindEms] = INVALID_PLAYER_ID;
		DisablePlayerCheckpoint(playerid);
	}
 	
	if(pData[playerid][pSideJob] == 401)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(GetVehicleModel(vehicleid) == 530)
		{
			if(IsPlayerInRangeOfPoint(playerid, 7.0,Forkliftpoint11))
			{
				pData[playerid][pSideJob] = 0;
				pData[playerid][pSideJobsForklift] = 1800;
				DisablePlayerCheckpoint(playerid);
				GivePlayerMoneyEx(playerid, 15000);
				SendClientMessageEx(playerid, COLOR_ARWIN, "SIDEJOB: "WHITE_E"You've earned "GREEN_E"$150.00 "WHITE_E"for finishing forklift sidejob");
				RemovePlayerFromVehicle(playerid);
				SetVehicleToRespawn(GetPlayerVehicleID(playerid));
            	if(IsValidDynamicObject(objectforklift))
                	DestroyDynamicObject(objectforklift);
			}
		}
	}
	DisablePlayerCheckpoint(playerid);
	return 1;
}


// Player clicked a dynamic object
public OnPlayerSelectDynamicObject(playerid, objectid, modelid, Float:x, Float:y, Float:z)
{
	if (pData[playerid][pEditFurnHouse] != -1) {
        new houseid = pData[playerid][pEditFurnHouse];

        foreach (new furnitureid : HouseFurnitures[houseid]) if (objectid == FurnitureData[houseid][furnitureid][furnitureObject]) {
            switch (SelectFurnitureType[playerid]) {
                case FURNITURE_SELECT_MOVE: {
                    pData[playerid][pEditingMode] = 4;
                    pData[playerid][pEditFurniture] = furnitureid;
                    EditDynamicObject(playerid, FurnitureData[houseid][furnitureid][furnitureObject]);
                    SendCustomMessage(playerid, "HOUSE", "You are now editing the position of item \"%s\".", FurnitureData[houseid][furnitureid][furnitureName]);
                    break;
                }
                case FURNITURE_SELECT_DESTROY:
                {
                    SendCustomMessage(playerid, "HOUSE", "You have destroyed furniture \"%s\".", FurnitureData[houseid][furnitureid][furnitureName]);
                    Furniture_Delete(furnitureid, houseid);

                    CancelEdit(playerid);
                    pData[playerid][pEditFurniture] = -1;
                    pData[playerid][pEditFurnHouse] = -1;
                    break;
                }
                case FURNITURE_SELECT_STORE: {
                    if (FurnitureData[houseid][furnitureid][furnitureUnused])
                        return Error(playerid, "This furniture is already stored"), CancelEdit(playerid);
                    
                    FurnitureData[houseid][furnitureid][furnitureUnused] = 1;
                    Furniture_Refresh(furnitureid, houseid);
                    Furniture_Save(furnitureid, houseid);
                    SendCustomMessage(playerid, "HOUSE", "You have stored furniture \"%s"WHITE_E"\" into your house.", FurnitureData[houseid][furnitureid][furnitureName]);
                    break;
                }
            }
            break;
        }
    }
	if (pData[playerid][pEditHouseStructure] != -1) {
        new houseid = pData[playerid][pEditHouseStructure];

        foreach (new i : HouseStruct[houseid]) {
            if (HouseStructure[houseid][i][structureObject] == objectid) {
                switch (SelectStructureType[playerid]) {
                    case STRUCTURE_SELECT_EDITOR: {
                        if (HouseStructure[houseid][i][structureType] == 0) {
                            pData[playerid][pEditStructure] = i;
                            pData[playerid][pEditingMode] = 3;
                            EditDynamicObject(playerid, HouseStructure[houseid][i][structureObject]);
                            SendCustomMessage(playerid, "BUILDER", "You're now editing %s.", GetStructureNameByModel(HouseStructure[houseid][i][structureModel]));
                            break;
                        }
                    }
                    case STRUCTURE_SELECT_RETEXTURE: {
                        SetPVarInt(playerid, "structureObj", i);
                        CancelEdit(playerid);
                        Dialog_Show(playerid, House_StructureRetexture, DIALOG_STYLE_INPUT, "Retexture House Structure", "Please input the texture name below:\n"YELLOW_E"[model] [txdname] [texture] [opt: alpha] [opt: red] [opt: green] [opt: blue]", "Retexture", "Cancel");
                        break;
                    }
                    case STRUCTURE_SELECT_DELETE: {
                        if (HouseStructure[houseid][i][structureType] == 0) {
                            SendCustomMessage(playerid, "BUILDER", "You've been successfully deleted %s", GetStructureNameByModel(HouseStructure[houseid][i][structureModel]));
                            HouseStructure_Delete(i, houseid);
                            break;
                        }
                    }
                    case STRUCTURE_SELECT_COPY: {
                        if (HouseStructure[houseid][i][structureType] == 0) {
                            new price;

                            for (new id = 0; id < sizeof(g_aHouseStructure); id ++) if (g_aHouseStructure[id][e_StructureModel] == HouseStructure[houseid][i][structureModel]) {
                                price = g_aHouseStructure[id][e_StructureCost];
                            }

                            if (pData[playerid][pComponent] < price)
                                return Error(playerid, "You need %d Component(s) to copy this structure.", price);

                            new copyId = HouseStructure_CopyObject(i, houseid);

                            if (copyId == cellmin)
                                return Error(playerid, "Your house has reached maximum of structure");

                            pData[playerid][pComponent] -= price;
                            pData[playerid][pEditStructure] = copyId;
                            pData[playerid][pEditingMode] = 3;
                            pData[playerid][pEditHouseStructure] = houseid;
                            EditDynamicObject(playerid, HouseStructure[houseid][copyId][structureObject]);
                            SendCustomMessage(playerid, "BUILDER", "You have copied structure for "GREEN_E"%d component(s)", price);
                            SendCustomMessage(playerid, "BUILDER", "You're now editing copied object of %s.", GetStructureNameByModel(HouseStructure[houseid][i][structureModel]));
                            break;
                        }
                    }
                }
                break;
            }
        }
    }
	// if(pData[playerid][pEditSelect] == 1)
	// {
	// 	for(new i = 0 ; i < MAX_COBJECT; i++)
	// 	{
	// 		if(ObjectData[i][objCreate] == objectid)
	// 		{
	// 			EditingObject[playerid] = i;
	// 			CancelEdit(playerid);
	// 			ShowPlayerDialog(playerid, DIALOG_EDIT, DIALOG_STYLE_LIST, "Object Editing", "Edit with Move Object\nWith Coordinate\nChange Model\nRemove Object", "Select", "Cancel");
	// 		}
	// 	}
	// }
	// else if(pData[playerid][pEditSelect] == 2)
	// {
	// 	for(new i = 0 ; i < MAX_MT; i++)
	// 	{
	// 		if(MatextData[i][mtCreate] == objectid)
	// 		{
	// 			EditingMatext[playerid] = i;
	// 			CancelEdit(playerid);
	// 			ShowPlayerDialog(playerid, DIALOG_MTEDIT, DIALOG_STYLE_LIST, "Material Text", "Edit with Move Object\nWith Coordinate\nChange Text\nChange Font\nBold\nChange Size\nChange Color\nRemove Object", "Select", "Cancel");
	// 		}
	// 	}
	// }
	// else if(pData[playerid][pEditSelect] == 4)
	// {
	// 	if(pData[playerid][pAdmin] > 5)
	// 	{
	// 		for(new i = 0 ; i < MAX_MT; i++)
	// 		{
	// 			if(MatextData[i][mtCreate] == objectid)
	// 			{
	// 				EditingMatext[playerid] = i;
	// 				CancelEdit(playerid);
	// 				ShowPlayerDialog(playerid, DIALOG_MTEDIT, DIALOG_STYLE_LIST, "Material Text", "Edit with Move Object\nWith Coordinate\nChange Text\nChange Font\nBold\nChange Size\nChange Color\nRemove Object", "Select", "Cancel");
	// 			}
	// 		}
	// 		for(new i = 0 ; i < MAX_COBJECT; i++)
	// 		{
	// 			if(ObjectData[i][objCreate] == objectid)
	// 			{
	// 				EditingObject[playerid] = i;
	// 				CancelEdit(playerid);
	// 				ShowPlayerDialog(playerid, DIALOG_EDIT, DIALOG_STYLE_LIST, "Object Editing", "Edit with Move Object\nWith Coordinate\nChange Model\nRemove Object", "Select", "Cancel");
	// 			}
	// 		}
	// 	}
	// }	
	return 1;
}

public OnPlayerEditDynamicObject(playerid, STREAMER_TAG_OBJECT: objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	new idx = wsEditID[playerid], String[522];

	if(response == EDIT_RESPONSE_FINAL)
	{
		if(pData[playerid][pEditingMode] == 4) {
			if(pData[playerid][pEditFurniture] != -1)
			{
				new id = pData[playerid][pInHouse];
				if(id != -1 && (Player_OwnsHouse(playerid, id) || hData[id][houseBuilder] == pData[playerid][pID]))
				{
					if (Iter_Contains(HouseFurnitures[id], pData[playerid][pEditFurniture])) {
						FurnitureData[id][pData[playerid][pEditFurniture]][furniturePos][0] = x;
						FurnitureData[id][pData[playerid][pEditFurniture]][furniturePos][1] = y;
						FurnitureData[id][pData[playerid][pEditFurniture]][furniturePos][2] = z;
						FurnitureData[id][pData[playerid][pEditFurniture]][furnitureRot][0] = rx;
						FurnitureData[id][pData[playerid][pEditFurniture]][furnitureRot][1] = ry;
						FurnitureData[id][pData[playerid][pEditFurniture]][furnitureRot][2] = rz;
						
						SetDynamicObjectPos(objectid,x,y,z);
						SetDynamicObjectRot(objectid,rx,ry,rz);
						Furniture_Refresh(pData[playerid][pEditFurniture], id);
						Furniture_Save(pData[playerid][pEditFurniture], id);

						SendCustomMessage(playerid, "HOUSE", "You have edited the position of item \"%s\".", FurnitureData[id][pData[playerid][pEditFurniture]][furnitureName]);

						pData[playerid][pEditFurniture] = -1;
						pData[playerid][pEditFurnHouse] = -1;
					}
				}
			}
		}
		if(pData[playerid][pEditingMode] == 3) {
			if (pData[playerid][pEditStructure] != -1) {
				new houseid = pData[playerid][pInHouse], id = pData[playerid][pEditStructure];

				if (houseid != -1) {
					if (Iter_Contains(HouseStruct[houseid], id)) {
						HouseStructure[houseid][id][structurePos][0] = x;
						HouseStructure[houseid][id][structurePos][1] = y;
						HouseStructure[houseid][id][structurePos][2] = z;
						HouseStructure[houseid][id][structureRot][0] = rx;
						HouseStructure[houseid][id][structureRot][1] = ry;
						HouseStructure[houseid][id][structureRot][2] = rz;

						SetDynamicObjectPos(objectid, x, y, z);
						SetDynamicObjectRot(objectid, rx, ry, rz);
						HouseStructure_Refresh(id, houseid);
						HouseStructure_Save(id, houseid);

						SendCustomMessage(playerid, "BUILDER", "Structure position has been saved.");

						pData[playerid][pEditHouseStructure] = -1;
						pData[playerid][pEditStructure] = -1;
					}
				}
			}
		}
		if(pData[playerid][pEditingMode] == 1)
		{
			if(pData[playerid][pEditObject] != -1 && Iter_Contains(Obj, pData[playerid][pEditObject]) && pData[playerid][pEditingMode] == 1) {
				new tid = pData[playerid][pEditObject];
				ObjData[tid][oPos][0] = x;
				ObjData[tid][oPos][1] = y;
				ObjData[tid][oPos][2] = z;
				ObjData[tid][oRot][0] = rx;
				ObjData[tid][oRot][1] = ry;
				ObjData[tid][oRot][2] = rz;

				SetDynamicObjectPos(objectid,x,y,z);
				SetDynamicObjectRot(objectid,rx,ry,rz);

				Object_Refresh(tid);
				Object_Save(tid);
				SendClientMessageEx(playerid, COLOR_ARWIN, "OBJECT: "WHITE_E"You've successfully edited object id: "YELLOW_E"%d", tid);
				pData[playerid][pEditObject] = -1;
				Streamer_Update(playerid);
			}
		}
		if(pData[playerid][pEditingMode] == 2)
		{
			new index = pData[playerid][pEditRoadblock];
			BarricadeData[index][cadePos][0] = x;
			BarricadeData[index][cadePos][1] = y;
			BarricadeData[index][cadePos][2] = z;
			BarricadeData[index][cadePos][3] = rx;
			BarricadeData[index][cadePos][4] = ry;
			BarricadeData[index][cadePos][5] = rz;
			Barricade_Sync(index);
			pData[playerid][pEditRoadblock] = -1;
		}
		else if(wsEdit[playerid] == 1)
		{
		    wData[idx][wsPapanX] = x;
			wData[idx][wsPapanY] = y;
			wData[idx][wsPapanZ] = z;
			wData[idx][wsPapanRotX] = rx;
			wData[idx][wsPapanRotY] = ry;
			wData[idx][wsPapanRotZ] = rz;
			SetDynamicObjectPos(objectid,  wData[idx][wsPapanX], wData[idx][wsPapanY], wData[idx][wsPapanZ]);
			SetDynamicObjectRot(objectid, wData[idx][wsPapanRotX], wData[idx][wsPapanRotY], wData[idx][wsPapanRotZ]);
			Workshop_Save(idx);
		    wsEdit[playerid] = 0;
		    wsEditID[playerid] = 0;
			
			Streamer_UpdateEx(playerid, wData[idx][wsPapanX], wData[idx][wsPapanY], wData[idx][wsPapanZ]);
		    format(String, sizeof(String), "EDIT: "WHITE_E"Anda telah menyelesaikan Edit Posisi Papan WorkShop ID %d.", idx);
		    SendClientMessage(playerid, COLOR_ARWIN, String);
			return 1;
		}
		if(Player_EditingObject[playerid])
        {
            new
                vehicleid = Player_EditVehicleObject[playerid],
                vehid = GetPlayerVehicleID(playerid),
                slot = Player_EditVehicleObjectSlot[playerid],
                Float:vx,
                Float:vy,
                Float:vz,
                Float:va,
                Float:real_x,
                Float:real_y,
                Float:real_z,
                Float:real_a
            ;

            GetVehiclePos(vehid, vx, vy, vz);
            GetVehicleZAngle(vehid, va); // Coba lagi

            real_x = x - vx;
            real_y = y - vy;
            real_z = z - vz;
            real_a = rz - va;

            new Float:v_size[3];
            GetVehicleModelInfo(pvData[vehicleid][cModel], VEHICLE_MODEL_INFO_SIZE, v_size[0], v_size[1], v_size[2]);
            if(	(real_x >= v_size[0] || -v_size[0] >= real_x) ||
                (real_y >= v_size[1] || -v_size[1] >= real_y) ||
                (real_z >= v_size[2] || -v_size[2] >= real_z))
            {
                SendClientMessageEx(playerid, COLOR_ARWIN,"MODSHOP: "WHITE_E"Posisi object terlal jauh dari body kendaraan.");
                ResetEditing(playerid);
                return 1;
            }

            VehicleObjects[vehicleid][slot][vehObjectPosX] = real_x;
            VehicleObjects[vehicleid][slot][vehObjectPosY] = real_y;
            VehicleObjects[vehicleid][slot][vehObjectPosZ] = real_z;
            VehicleObjects[vehicleid][slot][vehObjectPosRX] = rx;
            VehicleObjects[vehicleid][slot][vehObjectPosRY] = ry;
            VehicleObjects[vehicleid][slot][vehObjectPosRZ] = real_a;
		
			Streamer_UpdateEx(playerid, VehicleObjects[vehicleid][slot][vehObjectPosX], VehicleObjects[vehicleid][slot][vehObjectPosY], VehicleObjects[vehicleid][slot][vehObjectPosZ]);
			if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_BODY)
			{
				SetDynamicObjectMaterial(VehicleObjects[vehicleid][slot][vehObject], 0, VehicleObjects[vehicleid][slot][vehObjectModel], "none", "none", RGBAToARGB(ColorList[VehicleObjects[vehicleid][slot][vehObjectColor]]));
			}
			else if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_TEXT)
			{
				SetDynamicObjectMaterialText(VehicleObjects[vehicleid][slot][vehObject], 0, VehicleObjects[vehicleid][slot][vehObjectText], 130, VehicleObjects[vehicleid][slot][vehObjectFont], VehicleObjects[vehicleid][slot][vehObjectFontSize], 1, RGBAToARGB(ColorList[VehicleObjects[vehicleid][slot][vehObjectFontColor]]), 0, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
			}
			AttachDynamicObjectToVehicle(VehicleObjects[vehicleid][slot][vehObject], pvData[vehicleid][cVeh], real_x, real_y, real_z, rx, ry, real_a);
        	Vehicle_ObjectUpdate(vehicleid, slot);
			//Vehicle_AttachObject(vehicleid, slot);
            Vehicle_ObjectSave(vehicleid, slot);
			
            if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_BODY)
            {
                Dialog_Show(playerid, VACCSE, DIALOG_STYLE_LIST, "Edit Component", "Position\nPosition (Manual)\nChange Color\nRemove Modification\nSave", "Select", "Back");
            }
            else if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_TEXT)
            {
                Dialog_Show(playerid, VACCSE1, DIALOG_STYLE_LIST, "Edit Component", "Position\nPosition (Manual)\nText Name\nText Size\nText Font\nText Color\nRemove Modification\nSave", "Select", "Back");
            }
            else if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_LIGHT)
            {
                Dialog_Show(playerid, VACCSE2, DIALOG_STYLE_LIST, "Edit Component", "Position\nPosition (Manual)\nRemove Modification\nSave", "Select", "Back");
            }
			return 1;
		}
		if(pData[playerid][EditingTreeID] != -1 && Iter_Contains(Trees, pData[playerid][EditingTreeID]))
		{
			new etid = pData[playerid][EditingTreeID];
	        TreeData[etid][treeX] = x;
	        TreeData[etid][treeY] = y;
	        TreeData[etid][treeZ] = z;
	        TreeData[etid][treeRX] = rx;
	        TreeData[etid][treeRY] = ry;
	        TreeData[etid][treeRZ] = rz;

	        SetDynamicObjectPos(objectid, TreeData[etid][treeX], TreeData[etid][treeY], TreeData[etid][treeZ]);
	        SetDynamicObjectRot(objectid, TreeData[etid][treeRX], TreeData[etid][treeRY], TreeData[etid][treeRZ]);
			Streamer_UpdateEx(playerid, TreeData[etid][treeX], TreeData[etid][treeY], TreeData[etid][treeZ]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, TreeData[etid][treeLabel], E_STREAMER_X, TreeData[etid][treeX]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, TreeData[etid][treeLabel], E_STREAMER_Y, TreeData[etid][treeY]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, TreeData[etid][treeLabel], E_STREAMER_Z, TreeData[etid][treeZ] + 1.5);

		    Tree_Save(etid);
	        pData[playerid][EditingTreeID] = -1;
			return 1;
		}
		if(pData[playerid][EditingATMID] != -1 && Iter_Contains(ATMS, pData[playerid][EditingATMID]))
		{
			new etid = pData[playerid][EditingATMID];
	        AtmData[etid][atmX] = x;
	        AtmData[etid][atmY] = y;
	        AtmData[etid][atmZ] = z;
	        AtmData[etid][atmRX] = rx;
	        AtmData[etid][atmRY] = ry;
	        AtmData[etid][atmRZ] = rz;

	        SetDynamicObjectPos(objectid, AtmData[etid][atmX], AtmData[etid][atmY], AtmData[etid][atmZ]);
	        SetDynamicObjectRot(objectid, AtmData[etid][atmRX], AtmData[etid][atmRY], AtmData[etid][atmRZ]);

			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, AtmData[etid][atmLabel], E_STREAMER_X, AtmData[etid][atmX]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, AtmData[etid][atmLabel], E_STREAMER_Y, AtmData[etid][atmY]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, AtmData[etid][atmLabel], E_STREAMER_Z, AtmData[etid][atmZ] + 0.3);

			Streamer_SetFloatData(STREAMER_TYPE_PICKUP, AtmData[etid][atmLabel], E_STREAMER_X, AtmData[etid][atmX]);
			Streamer_SetFloatData(STREAMER_TYPE_PICKUP, AtmData[etid][atmLabel], E_STREAMER_Y, AtmData[etid][atmY]+1);
			Streamer_SetFloatData(STREAMER_TYPE_PICKUP, AtmData[etid][atmLabel], E_STREAMER_Z, AtmData[etid][atmZ]);
			Streamer_UpdateEx(playerid, AtmData[etid][atmX], AtmData[etid][atmY], AtmData[etid][atmZ]);
		    Atm_Save(etid);
	        pData[playerid][EditingATMID] = -1;
			return 1;
		}
		if(pData[playerid][gEditID] != -1 && Iter_Contains(Gates, pData[playerid][gEditID]))
		{
			new id = pData[playerid][gEditID];
			if(pData[playerid][gEdit] == 1)
			{
				gData[id][gCX] = x;
				gData[id][gCY] = y;
				gData[id][gCZ] = z;
				gData[id][gCRX] = rx;
				gData[id][gCRY] = ry;
				gData[id][gCRZ] = rz;
				if(IsValidDynamic3DTextLabel(gData[id][gText])) DestroyDynamic3DTextLabel(gData[id][gText]);
				new str[64];
				format(str, sizeof(str), "Gate ID: %d", id);
				gData[id][gText] = CreateDynamic3DTextLabel(str, COLOR_WHITE, gData[id][gCX], gData[id][gCY], gData[id][gCZ], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 10.0);
				Streamer_UpdateEx(playerid, gData[id][gCX], gData[id][gCY], gData[id][gCZ]);
				pData[playerid][gEditID] = -1;
				pData[playerid][gEdit] = 0;
				Servers(playerid, " You have finished editing gate ID %d's closing position.", id);
				gData[id][gStatus] = 0;
				Gate_Save(id);
				return 1;
			}
			else if(pData[playerid][gEdit] == 2)
			{
				gData[id][gOX] = x;
				gData[id][gOY] = y;
				gData[id][gOZ] = z;
				gData[id][gORX] = rx;
				gData[id][gORY] = ry;
				gData[id][gORZ] = rz;
				
				pData[playerid][gEditID] = -1;
				pData[playerid][gEdit] = 0;
				Servers(playerid, " You have finished editing gate ID %d's opening position.", id);

				gData[id][gStatus] = 1;
				Gate_Save(id);
				return 1;
			}
		}
	}
	if(response == EDIT_RESPONSE_CANCEL)
	{
	    if(wsEditID[playerid] != 0)
	    {
		    SetDynamicObjectPos(objectid, wsPos[playerid][0], wsPos[playerid][1], wsPos[playerid][2]);
			SetDynamicObjectRot(objectid, wsRot[playerid][0], wsRot[playerid][1], wsRot[playerid][2]);
			wsPos[playerid][0] = 0; wsPos[playerid][1] = 0; wsPos[playerid][2] = 0;
			wsRot[playerid][0] = 0; wsRot[playerid][1] = 0; wsRot[playerid][2] = 0;
			format(String, sizeof(String), "EDIT: "WHITE_E"Anda membatalkan Edit Papan WorkShop ID %d.", idx);
			SendClientMessage(playerid, COLOR_ARWIN, String);
			wsEdit[playerid] = 0;
			wsEditID[playerid] = 0;
			return 1;
		}
		if (EditingObject[playerid] != -1)
		{
			EditingObject[playerid] = -1;
			Object_Refresh(EditingObject[playerid]);
			return 1;
		}
        if(Player_EditingObject[playerid])
        {
            ResetEditing(playerid);
			return 1;
        }
		if(pData[playerid][EditingTreeID] != -1 && Iter_Contains(Trees, pData[playerid][EditingTreeID]))
		{
			new etid = pData[playerid][EditingTreeID];
	        SetDynamicObjectPos(objectid, TreeData[etid][treeX], TreeData[etid][treeY], TreeData[etid][treeZ]);
	        SetDynamicObjectRot(objectid, TreeData[etid][treeRX], TreeData[etid][treeRY], TreeData[etid][treeRZ]);
	        pData[playerid][EditingTreeID] = -1;
			return 1;
		}
		if(pData[playerid][EditingATMID] != -1 && Iter_Contains(ATMS, pData[playerid][EditingATMID]))
		{
			new etid = pData[playerid][EditingATMID];
	        SetDynamicObjectPos(objectid, AtmData[etid][atmX], AtmData[etid][atmY], AtmData[etid][atmZ]);
	        SetDynamicObjectRot(objectid, AtmData[etid][atmRX], AtmData[etid][atmRY], AtmData[etid][atmRZ]);
	        pData[playerid][EditingATMID] = -1;
			return 1;
		}
		if(pData[playerid][gEditID] != -1 && Iter_Contains(Gates, pData[playerid][gEditID]))
		{
			new id = pData[playerid][gEditID];
			SetDynamicObjectPos(objectid, gPosX[playerid], gPosY[playerid], gPosZ[playerid]);
			SetDynamicObjectRot(objectid, gRotX[playerid], gRotY[playerid], gRotZ[playerid]);
			gPosX[playerid] = 0; gPosY[playerid] = 0; gPosZ[playerid] = 0;
			gRotX[playerid] = 0; gRotY[playerid] = 0; gRotZ[playerid] = 0;
			Servers(playerid, "You have canceled editing gate ID %d.", id);
			Gate_Save(id);
			return 1;
		}
		if(pData[playerid][pEditStructure] != -1) {
			
			new slot = pData[playerid][pEditStructure], houseid = pData[playerid][pEditHouseStructure];
			new Float:position[3], Float:rotation[3];
			if (houseid != -1) {
				Streamer_GetFloatData(STREAMER_TYPE_OBJECT,HouseStructure[houseid][slot][structureObject],E_STREAMER_X,position[0]);
				Streamer_GetFloatData(STREAMER_TYPE_OBJECT,HouseStructure[houseid][slot][structureObject],E_STREAMER_Y,position[1]);
				Streamer_GetFloatData(STREAMER_TYPE_OBJECT,HouseStructure[houseid][slot][structureObject],E_STREAMER_Z,position[2]);
				Streamer_GetFloatData(STREAMER_TYPE_OBJECT,HouseStructure[houseid][slot][structureObject],E_STREAMER_R_X,rotation[0]);
				Streamer_GetFloatData(STREAMER_TYPE_OBJECT,HouseStructure[houseid][slot][structureObject],E_STREAMER_R_Y,rotation[1]);
				Streamer_GetFloatData(STREAMER_TYPE_OBJECT,HouseStructure[houseid][slot][structureObject],E_STREAMER_R_Z,rotation[2]);
				SetDynamicObjectPos(objectid,position[0],position[1],position[2]);
				SetDynamicObjectRot(objectid,rotation[0],rotation[1],rotation[2]);

				pData[playerid][pEditHouseStructure] = -1;
				pData[playerid][pEditStructure] = -1;
			}
		}
		if(pData[playerid][pEditFurniture] != -1) {
			new slot = pData[playerid][pEditFurniture], houseid = pData[playerid][pInHouse];
			new Float:position[3], Float:rotation[3];
			if (houseid != -1 && Iter_Contains(HouseFurnitures[houseid], slot)) {
				Streamer_GetFloatData(STREAMER_TYPE_OBJECT,FurnitureData[houseid][slot][furnitureObject],E_STREAMER_X,position[0]);
				Streamer_GetFloatData(STREAMER_TYPE_OBJECT,FurnitureData[houseid][slot][furnitureObject],E_STREAMER_Y,position[1]);
				Streamer_GetFloatData(STREAMER_TYPE_OBJECT,FurnitureData[houseid][slot][furnitureObject],E_STREAMER_Z,position[2]);
				Streamer_GetFloatData(STREAMER_TYPE_OBJECT,FurnitureData[houseid][slot][furnitureObject],E_STREAMER_R_X,rotation[0]);
				Streamer_GetFloatData(STREAMER_TYPE_OBJECT,FurnitureData[houseid][slot][furnitureObject],E_STREAMER_R_Y,rotation[1]);
				Streamer_GetFloatData(STREAMER_TYPE_OBJECT,FurnitureData[houseid][slot][furnitureObject],E_STREAMER_R_Z,rotation[2]);
				SetDynamicObjectPos(objectid,position[0],position[1],position[2]);
				SetDynamicObjectRot(objectid,rotation[0],rotation[1],rotation[2]);
			}
		}
	}
	return 1;
}

// Player clicked a dynamic object; Fix For new streamer version
public OnPlayerSelectObject(playerid, type, objectid, modelid, Float:fX, Float:fY, Float:fZ) return 0;

public OnPlayerTeleport(playerid, Float:distance)
{
	if(pData[playerid][pAdmin] < 2)
	{
	    if(!IsPlayerInRangeOfPoint(playerid, 3.0, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]))
	    {
		    SendStaffMessage(COLOR_YELLOW, "AdmWarning: %s[%i] is possibly teleport hacking (distance: %.1f).", pData[playerid][pName], playerid, distance);
	    }
	}

	return 1;
}

public OnPlayerAirbreak(playerid)
{
	if(pData[playerid][pAdmin] < 2)
	{
	    SendStaffMessage(COLOR_YELLOW, "AdmWarning: %s[%i] is possibly using airbreak hacks.", pData[playerid][pName], playerid);
	}
	return 1;
}

public OnPlayerInteriorChange(playerid,newinteriorid,oldinteriorid)
{
	if(pData[playerid][IsLoggedIn] == true)
	{
		pData[playerid][pInt] = newinteriorid;
		if(newinteriorid != 0)
		{
			SetPlayerWeather(playerid, 0);
		}
		else
		{
			SetPlayerWeather(playerid, WorldWeather);
		}
	}
	foreach(new i : Player)
	{
		if(pData[i][pSpec] > 0 && pData[i][pSpec] == playerid) 
		{
			SetPlayerInterior(i, GetPlayerInterior(playerid));
			SetPlayerVirtualWorld(i, GetPlayerVirtualWorld(playerid));
			PlayerSpectatePlayer(i, playerid);
			if(IsPlayerInAnyVehicle(playerid)) 
				PlayerSpectateVehicle(i, GetPlayerVirtualWorld(playerid));
			else 
				PlayerSpectatePlayer(i, playerid);
		}
	}
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    if(playertextid == vRadioPlay[playerid])
    {
        foreach(new i : Player)
        {
            if(IsPlayerInAnyVehicle(i) && GetPlayerVehicleID(i) == GetPlayerVehicleID(playerid))
            {
                PlayAudioStreamForPlayer(i, pData[playerid][pRadioVehicle]);
                pData[i][pRadioVehicleOn] = 1;
            }
        }
    }
    if(playertextid == vRadioPause[playerid])
    {
        foreach(new i : Player)
        {
            if(IsPlayerInAnyVehicle(i) && GetPlayerVehicleID(i) == GetPlayerVehicleID(playerid))
            {
                StopAudioStreamForPlayer(i);
                pData[i][pRadioVehicleOn] = 0;
            }
        }
    }
    if(playertextid == vRadioLink[playerid])
    {
        Dialog_Show(playerid, vRadioDialog, DIALOG_STYLE_INPUT,"vRadio URL", "Enter music url to play music","Next","Cancel");
    }
    if(playertextid == vRadioPlayLink[playerid])
    {
        for(new i = 0; i < 9; i++) 
        {   
            TextDrawHideForPlayer(playerid, vRadio[i]);
            PlayerTextDrawHide(playerid, vRadioPlay[playerid]);
            PlayerTextDrawHide(playerid, vRadioPause[playerid]);
            PlayerTextDrawHide(playerid, vRadioLink[playerid]);
            PlayerTextDrawHide(playerid, vRadioPlayLink[playerid]);
            PlayerTextDrawHide(playerid, vRadioClose[playerid]);
        }
        CancelSelectTextDraw(playerid);
        foreach(new i : Player)
        {
            if(IsPlayerInAnyVehicle(i) && GetPlayerVehicleID(i) == GetPlayerVehicleID(playerid))
            {
                PlayAudioStreamForPlayer(i, pData[playerid][pRadioVehicle]);
                pData[i][pRadioVehicleOn] = 1;
            }
        }
    }
    if(playertextid == vRadioClose[playerid])
    {
        for(new i = 0; i < 9; i++) 
        {   
            TextDrawHideForPlayer(playerid, vRadio[i]);
            PlayerTextDrawHide(playerid, vRadioPlay[playerid]);
            PlayerTextDrawHide(playerid, vRadioPause[playerid]);
            PlayerTextDrawHide(playerid, vRadioLink[playerid]);
            PlayerTextDrawHide(playerid, vRadioPlayLink[playerid]);
            PlayerTextDrawHide(playerid, vRadioClose[playerid]);
        }
        CancelSelectTextDraw(playerid);
    }
    return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	if(pData[playerid][pRadioVehicleOn] == 1)
	{
		StopAudioStreamForPlayer(playerid);
		pData[playerid][pRadioVehicleOn] = 0;
	}
    for(new i = 0; i < 3; i++) 
	{
		if(DialogBus[i] == true) 
		{
			vehicleid = GetPlayerVehicleID(playerid);
			DisablePlayerRaceCheckpoint(playerid);
            DialogBus[i] = false; // Jadi ga ada yang punya nih dialog
		    SetVehicleToRespawn(GetPlayerVehicleID(playerid));
		}
	}
	for(new i = 0; i < 3; i++) 
	{
		if(DialogBusCD[i] == true) 
		{
			vehicleid = GetPlayerVehicleID(playerid);
			DisablePlayerRaceCheckpoint(playerid);
            DialogBusCD[i] = false; // Jadi ga ada yang punya nih dialog
		    SetVehicleToRespawn(GetPlayerVehicleID(playerid));
		}
	}
	for(new i = 0; i < 3; i++) 
	{
		if(DialogSweeper[i] == true) 
		{
		    vehicleid = GetPlayerVehicleID(playerid);
		    DisablePlayerRaceCheckpoint(playerid);
			DialogSweeper[i] = false; // Jadi ga ada yang punya nih dialog
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
		}
	}
	if(IsADmvVeh(vehicleid))
	{
	    vehicleid = GetPlayerVehicleID(playerid);
	    DisablePlayerRaceCheckpoint(playerid);
	    pData[playerid][pSedangCarDmv] = 0;
		SetVehicleToRespawn(GetPlayerVehicleID(playerid));
		SendClientMessage(playerid, COLOR_ARWIN, " TEST: {FFFFFF}Test Mengemudi gagal karena anda turun dari kendaraan");
		DisablePlayerCheckpoint(playerid);
		
	}
	if(IsAForkliftVeh(vehicleid))
	{
	    vehicleid = GetPlayerVehicleID(playerid);
		SetVehicleToRespawn(GetPlayerVehicleID(playerid));
		DisablePlayerCheckpoint(playerid);
	}
	if(!IsABike(vehicleid))
	{
		if(pData[playerid][pTogSealtbelt] == 1)
		{
			if(pData[playerid][pSeatBelt] == 1)
			{
				pData[playerid][pSeatBelt] = 0;
				SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"Seatbelts "RED_E"OFF");
			}
		}	
	}
	else
	{
		if(pData[playerid][pTogHelmet] == 1)
		{
			if(pData[playerid][pHelmetOn] == 1)
			{
				pData[playerid][pHelmetOn] = 0;
				//ApplyAnimation(playerid, "GHANDS", "gsign3LH", 4.1, 0, 1, 1, 1, 2250, 1);
				SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"Helmet "RED_E"OFF");
				RemovePlayerAttachedObject(playerid, 9);
			}
		}
	}	
	return 1;
}	

public OnVehicleDeath(vehicleid, killerid)
{
	foreach(new ii : PVehicles)
	{
		if(pvData[ii][cVeh] == vehicleid && pvData[ii][cRent] == 0)
		{
			pvData[ii][vDestroyed] = gettime() + 15;
			new S3MP4K[212];
			foreach(new pid : Player) 
			{
				if (pvData[ii][cOwner] == pData[pid][pID])
				{
					if(killerid != INVALID_PLAYER_ID)
					{
						format(S3MP4K, sizeof(S3MP4K), "VEHICLE: "WHITE_E"Your %s has been destroyed by "YELLOW_E"%s", GetVehicleName(vehicleid), pData[killerid][pName]);
					}
					else
					{
						format(S3MP4K, sizeof(S3MP4K), "VEHICLE: "WHITE_E"Your %s has been destroyed", GetVehicleName(vehicleid));
					}
					SendClientMessageEx(pid, COLOR_ARWIN, S3MP4K);
				}	
			}			
		}
	}
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	foreach(new ii : PVehicles)
	{
		new S3MP4K[212];
		if(pvData[ii][cVeh] == vehicleid && pvData[ii][cRent] == 0)
		{
			if(pvData[ii][vDestroyed] > gettime())
			{
				if(pvData[ii][cInsu] > 0)
				{
					pvData[ii][cInsu]--;
					pvData[ii][cClaim] = 1;
					pvData[ii][cClaimTime] = gettime() + (1 * 3600);
					foreach(new pid : Player) 
					{
						if (pvData[ii][cOwner] == pData[pid][pID])
						{
							format(S3MP4K, sizeof(S3MP4K), "INSURANCE: "WHITE_E"Your %s has been destroyed and will be respawned at Insurance Agency with "YELLOW_E"'/claiminsurance'", GetVehicleName(vehicleid));
							SendClientMessageEx(pid, COLOR_ARWIN, S3MP4K);
						}	
					}
					for(new f = 0 ; f < MAX_MODS; f++)
					{
						RemoveVehicleComponent(pvData[ii][cVeh], GetVehicleComponentInSlot(pvData[ii][cVeh], f));
					}
					for(new id = 0 ; id < MAX_VEHICLE_OBJECT; id++)
					{
						Vehicle_ObjectDelete(pvData[ii][cVeh], id);
					}
					pvData[ii][pvBodyUpgrade] = 0;
					pvData[ii][cMesinUpgrade] = 0;
					new rand = RandomEx(111111, 999999);
					SetVehiclePos(pvData[ii][cVeh], 0, 0, 0); // Attempted desync fix
					LinkVehicleToInterior(pvData[ii][cVeh], rand);
					SetVehicleVirtualWorld(pvData[ii][cVeh], rand);
					Vehicle_ObjectDestroy(pvData[ii][cVeh]);
					if(IsValidDynamicObject(ObjectVehicle[pvData[ii][cVeh]][0]))
					{
						DestroyDynamicObject(ObjectVehicle[pvData[ii][cVeh]][0]);
					}
					if(IsValidDynamicObject(ObjectVehicle[pvData[ii][cVeh]][1]))
					{
						DestroyDynamicObject(ObjectVehicle[pvData[ii][cVeh]][1]);
					}
					pvData[ii][cVeh] = 0;
				}
				else
				{
					foreach(new pid : Player) if (pvData[ii][cOwner] == pData[pid][pID])
					{
						if(IsValidDynamicObject(ObjectVehicle[pvData[ii][cVeh]][0]))
						{
							DestroyDynamicObject(ObjectVehicle[pvData[ii][cVeh]][0]);
						}
						if(IsValidDynamicObject(ObjectVehicle[pvData[ii][cVeh]][1]))
						{
							DestroyDynamicObject(ObjectVehicle[pvData[ii][cVeh]][1]);
						}
						Vehicle_ObjectDestroy(pvData[ii][cVeh]);
						for(new slot = 0; slot < MAX_VEHICLE_OBJECT; slot++)
        				{	
							Vehicle_ObjectDelete(vehicleid, slot);
						}	
						new query[128];
						mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehicle WHERE id = '%d'", pvData[pid][cID]);
						mysql_tquery(g_SQL, query);
						if(IsValidVehicle(pvData[ii][cVeh]))
							DestroyVehicle(pvData[ii][cVeh]);

						pvData[ii][cVeh] = INVALID_VEHICLE_ID;
						format(S3MP4K, sizeof(S3MP4K), "INSURANCE: Kendaraan anda hancur dan tidak memiliki insuransi");
						SendClientMessageEx(pid, COLOR_ARWIN, S3MP4K);
						Iter_SafeRemove(PVehicles, ii, ii);
					}
				}
			}
		}
	}
	return 1;
}

//LINE BUAT SISTEM UPGRADE BODY
public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
	new panel, doors, lights, tires, Float: HP;
	if(pvData[vehicleid][pvBodyUpgrade] == 1)
	{
		GetVehicleHealth(vehicleid, HP);
		GetVehicleDamageStatus(vehicleid, panel, doors, lights, tires);
		if(HP > 1000) UpdateVehicleDamageStatus(vehicleid, 0, 0, 0, 0);
	}
	else
	{
		GetVehicleHealth(vehicleid, HP);
		GetVehicleDamageStatus(vehicleid, panel, doors, lights, tires);
		if(HP < 1000)
		UpdateVehicleDamageStatus(vehicleid, panel, doors, lights, tires);
		pvData[vehicleid][cHealth] = HP;
	}
	return 1;
}

GetStructureNameByModel(model) {
    new name[32];

    for (new i = 0; i < sizeof(g_aHouseStructure); i ++) if (g_aHouseStructure[i][e_StructureModel] == model) {
        strcat(name, g_aHouseStructure[i][e_StructureName]);
        break;
    }
    return name;
}

ConvertTimestamp(Time:timestamp, bool:fullDate = true, bool:onlyTime = false, bool:onlyDate = false)
{
    new output[256], time[e_tm];
    localtime(timestamp, time);

    if (fullDate) strftime(output, sizeof(output), "%a %d %b %Y, %H:%M:%S", time);
    else if (onlyTime) strftime(output, sizeof(output), "%H:%M:%S", time);
    else if (onlyDate) strftime(output, sizeof(output), "%d/%m/%Y", time);

    return output;
}
