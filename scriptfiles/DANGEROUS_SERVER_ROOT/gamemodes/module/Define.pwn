// Server Define
#define TEXT_GAMEMODE	"Versi 1.5"
#define TEXT_WEBURL	    "https://discord.com/invite/DunKkPrZ72"
#define TEXT_LANGUAGE	"Bahasa Indonesia"

#define SECONDS_TO_LOGIN 2000

// default spawn point: Las Venturas (The High Roller)
#define DEFAULT_POS_X 1744.3411
#define DEFAULT_POS_Y -1862.8655
#define DEFAULT_POS_Z 13.3983
#define DEFAULT_POS_A 270.0000

// Message
#define function%0(%1) forward %0(%1); public %0(%1)
#define SendCustomMessage(%0,%1,%2)     SendClientMessageEx(%0, COLOR_ARWIN, %1": "WHITE_E""%2)
#define Servers(%1,%2) SendClientMessageEx(%1, COLOR_ARWIN, "[!]: "WHITE_E""%2)
#define Info(%1,%2) SendClientMessageEx(%1, COLOR_ARWIN, "[!]: "WHITE_E""%2)
#define Usage(%1,%2) SendClientMessage(%1, COLOR_ARWIN, "[!]: "WHITEP_E""%2)
#define Error(%1,%2) SendClientMessageEx(%1, COLOR_ARWIN, "[!]: "WHITE_E""%2)
#define ReportInfo(%1,%2) SendClientMessageEx(%1, COLOR_ARWIN, "REPORT: "WHITE_E""%2)
#define PermissionError(%0) SendClientMessage(%0, COLOR_ARWIN, "[!]: "WHITE_E"You are not allowed to use this commands!")
#define SamdInfo(%1,%2) SendClientMessageEx(%1, COLOR_ARWIN, "SAMD: "WHITE_E""%2)

#define PRESSED(%0) \
    (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

//Converter
#define minplus(%1) \
        (((%1) < 0) ? (-(%1)) : ((%1)))

// AntiCaps
#define UpperToLower(%1) for( new ToLowerChar; ToLowerChar < strlen( %1 ); ToLowerChar ++ ) if ( %1[ ToLowerChar ]> 64 && %1[ ToLowerChar ] < 91 ) %1[ ToLowerChar ] += 32

RGBAToARGB(rgba)
    return rgba >>> 8 | rgba << 24;

#define MAX_ANIMS (1812)

//---------[ Define Faction ]-----
#define SAPD	1
#define	SAGS	2
#define SAMD	3
#define SANEW	4

//MAX MODS
#define MAX_MODS 17

//PlayerVehicle
#define MAX_PRIVATE_VEHICLE 100000
#define MAX_PLAYER_VEHICLE 2

//workshop System
#define MAX_WORKSHOP 20

//House System
#define MAX_HOUSES	500
#define LIMIT_PER_PLAYER 2
#define Loop(%0,%1,%2) for(new %0 = %2; %0 < %1; %0++)

//Gate
#define MAX_GATES 500

//Farm System
#define MAX_LADANG 20

//Contacts System
#define MAX_CONTACTS (50)

//Plant System
#define MAX_PLANT 1000

//JobsLumber
#define MAX_TREES 100
#define TREE_RESPAWN 1800

//GPS System
#define GPS_STATUS_ON	true
#define GPS_STATUS_OFF	false
#define GetPlayerGPSInfo(%0,%1) 	g_player_gps[%0][%1]
#define SetPlayerGPSInfo(%0,%1,%2) 	g_player_gps[%0][%1] = %2

// Faction Vehicle
#define VEHICLE_RESPAWN 7200

//----------[ Lumber Object Vehicle Job ]------------
#define MAX_LUMBERS 50
#define LUMBER_LIFETIME 100
#define LUMBER_LIMIT 5

//Door System By Dandy Bagus Prasetyo
#define	MAX_DOOR	500
#define	MAX_DOOR_FLAT	500

//ATM System
#define MAX_ATM 50

//Locker System
#define MAX_LOCKERS	10

//Faction Vehicle
#define MAX_SAPD_VEHICLES 37
#define MAX_SAMD_VEHICLES 8
#define MAX_SANA_VEHICLES 10
#define MAX_FORKLIFT_VEHICLES 3
#define MAX_SWEEPER_VEHICLES 3
#define MAX_TRASH_VEHICLES 4
#define MAX_BUS_VEHICLES 4

//Family System
#define MAX_FAMILY 20

//GasStation System
#define MAX_GSTATION 50

//SAPD Spike
#define MAX_SPIKESTRIPS 200
#define MAX_BARRICADES 20
//SAPD Taser
#define     TASER_BASETIME  (5)		// player will get tased for at least 3 seconds
#define     TASER_INDEX     (9)		// setplayerattachedobject index for taser object

//MapIcon
#define MAP_ICON_STREAM_DISTANCE (200.0) // menggambar ikon di peta (radius)

#define GetVehicleBoot(%0,%1,%2,%3)				GetVehicleOffset((%0),VEHICLE_OFFSET_BOOT,(%1),(%2),(%3))

#define MAX_VEHICLE_OBJECT 10
#define MAX_COLOR_OBJECT 5

#define OBJECT_TYPE_BODY 1
#define OBJECT_TYPE_TEXT 2
#define OBJECT_TYPE_LIGHT 3

#define STRUCTURE_SELECT_EDITOR         1
#define STRUCTURE_SELECT_DELETE	        2
#define STRUCTURE_SELECT_RETEXTURE	    3
#define STRUCTURE_SELECT_COPY		    4

#define FURNITURE_SELECT_MOVE						1
#define FURNITURE_SELECT_DESTROY				2
#define FURNITURE_SELECT_STORE					3

#define FLAT_HIGH_INTERIOR (32)
#define FLAT_MEDIUM_INTERIOR (33)
#define FLAT_LOW_INTERIOR (34)

#define MODEL_SELECTION_VEHOBJECT   (150)

#define MAX_MAP (500)
#define RGBAToInt(%0,%1,%2,%3)          ((16777216 * (%0)) + (65536 * (%1)) + (256 * (%2)) + (%3))
#define Loop1(%0,%1)                     for(new %0; %0 != %1; %0++)
#define MAX_MATERIALS              	 		(16)

#define FISH_ZONE                       (17)
// Model Selection

#define MODEL_SELECTION_Glasses 1
#define MODEL_SELECTION_Bandanas    2
#define MODEL_SELECTION_Hats     3
#define MODEL_SELECTION_Misc     4
#define MODEL_SELECTION_Motorcycle     5
#define MODEL_SELECTION_SUV     6
#define MODEL_SELECTION_PickupVehicles     7
#define MODEL_SELECTION_Lowriders     8
#define MODEL_SELECTION_Saloons     9
#define MODEL_SELECTION_Sport     10
#define MODEL_SELECTION_Barricade     11
#define MODEL_SELECTION_SkinMale     12
#define MODEL_SELECTION_SkinFemale     13
#define MODEL_SELECTION_Loco    14
#define MODEL_SELECTION_Waa     15
#define MODEL_SELECTION_Transfender     16
#define MODEL_SELECTION_SAPDMale     17
#define MODEL_SELECTION_SAPDFemale     18
#define MODEL_SELECTION_SAPDWar     19
#define MODEL_SELECTION_SAMDMale     20
#define MODEL_SELECTION_SAMDFemale     21
#define MODEL_SELECTION_SANEWSMale     22
#define MODEL_SELECTION_SANEWSFemale     23
#define MAX_FREQUENCY               150
#define IP_SERVER   "172.104.189.13:7775"