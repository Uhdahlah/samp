new ListedFlat[MAX_PLAYERS][2];
new bool:DialogHauling[10];
new bool:DialogPenting[MAX_PLAYERS][10];
new TrailerHauling[MAX_PLAYERS];
new SedangHauling[MAX_PLAYERS];
new InVeh[MAX_PLAYERS], EnterVeh[MAX_PLAYERS];
//DMV 
new SedangDmv[MAX_PLAYERS];
new DmvSteps[MAX_PLAYERS];
//Sidejob Bus - ARIWIWIN14
new KerjaBus[MAX_PLAYERS];
new BusSteps[MAX_PLAYERS][4];
new BusABVeh[4];
new BusCDVeh[4];
new bool:DialogBus[4];
new bool:DialogSaya[MAX_PLAYERS][20];
new bool:DialogBusCD[4];
new BusCDSteps[MAX_PLAYERS][4];
//SIDEJOB SWEEPER
new KerjaSweeper[MAX_PLAYERS];
new SweeperSteps[MAX_PLAYERS][4];
new bool:DialogSweeper[4];
//SIDEJOB TRASH
new TrashVeh[4];
//SIDEJOB PIZZA
new SedangAnterPizza[MAX_PLAYERS];
new PizzaVeh[4];
new WatchingTV[MAX_PLAYERS];
new Spectating[MAX_PLAYERS];
new gNews[MAX_PLAYERS];
new toll[17];
new AimbotWarnings[MAX_PLAYERS];
new Jump[MAX_PLAYERS];
new Mobile[MAX_PLAYERS];
new TrashTotal[MAX_PLAYERS];
new gListedItems[MAX_PLAYERS][100];
new SAPDLobbyBtn[4],
	SAPDLobbyDoor[4];
new EditingObject[MAX_PLAYERS];
new EditingMatext[MAX_PLAYERS];
new Float:HealthDuty[MAX_PLAYERS];
new CharNameUCP1[MAX_PLAYERS][32], CharNameUCP2[MAX_PLAYERS][32], CharNameUCP3[MAX_PLAYERS][32];
new NameUCP[MAX_PLAYERS][32];
new TempCarID[MAX_PLAYERS];
new PlatePossible[][] = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};

// Anti DDOS
new addostimer;

// Countdown
new Count = -1;
new countTimer;
new showCD[MAX_PLAYERS];
new CountText[5][5] =
{
	"~r~1",
	"~g~2",
	"~y~3",
	"~g~4",
	"~b~5"
};

// Server Uptime
new up_days,
	up_hours,
	up_minutes,
	up_seconds,
	WorldTime = 10,
	WorldWeather = 24;

//Showroom and rental vehicle Checkpoint
new ShowRoomLV,
    ShowRoomLS;
	
new GaragePickup[8];

new TogOOC = 1;

new
	LumberObjects[MAX_VEHICLES];

new ObjectVehicle[MAX_VEHICLES][5];

new
	LogStorage[MAX_VEHICLES][2];

//------[ Trucker ]--------
new VehProduct[MAX_VEHICLES];
new VehGasOil[MAX_VEHICLES];


enum E_VEH_OBJECT {
    vehObjectID, // Untuk Menampung ID SQL Vehicle Acc
    vehObjectVehicleIndex, // Untuk mengampung ID SQL Vehicle
    vehObjectType, // Untuk menampung tipe object 
    vehObjectModel, // Untuk menampung model Object 
    vehObjectColor, // Untuk menampung warna object 

    vehObjectText[32], // Untuk menampung Text object
    vehObjectFont[24], // Untuk menampung font object
    vehObjectFontSize, // Untuk menampung size font dari si text 
    vehObjectFontColor, // Untuk menampung warna dari text 

    vehObject, // sebagai STREAMER ID object 
    
    bool:vehObjectExists, // Flagger untuk status object slot, true jika ada, false jika kosong

    Float:vehObjectPosX, // Coordinate dari object ketika attach ke kendaraan 
    Float:vehObjectPosY, // Coordinate dari object ketika attach ke kendaraan
    Float:vehObjectPosZ, // Coordinate dari object ketika attach ke kendaraan
    Float:vehObjectPosRX, // Coordinate dari object ketika attach ke kendaraan
    Float:vehObjectPosRY, // Coordinate dari object ketika attach ke kendaraan
    Float:vehObjectPosRZ // Coordinate dari object ketika attach ke kendaraan
};

enum E_OBJECT {
    Model,
    Name[37]
};

new 
    VehicleObjects[MAX_PRIVATE_VEHICLE][MAX_VEHICLE_OBJECT][E_VEH_OBJECT], // Sebagai variable dari enumurator veh object
    ListedVehObject[MAX_PLAYERS][MAX_VEHICLE_OBJECT], // Untuk menyimpan index id array vehicle object ke playerid
    Player_EditingObject[MAX_PLAYERS], // Sebagai flagger untuk menandakan player sedang edit object atau tidak 
    Player_EditVehicleObject[MAX_PLAYERS], // Variable Holder
    Player_EditVehicleObjectSlot[MAX_PLAYERS] // Variable Holder
; 
new color_string[3256], object_font[200];


new VehObject[][E_OBJECT] = 
{
    {19314,"BullHorns"},
    {1100,"Tengkorak"},
    {1013,"Lamp Round"},
    {1024,"Lamp Square"},
    {1028,"Exhaust Alien-1"},
    {1032,"Vent Alien-1"},
    {1033,"Vent X-Flow-1"},
    {1034,"Exhaust Alien-2"},
    {1035,"Vent Alien-2"},
    {1038,"Vent X-Flow-2"},
    {1099,"BullBars-1 Left"},
    {1042,"BullBars-1 Right"},
    {1046,"Exhaust Alien-2"},
    {1053,"Vent Alien-3"},
    {1054,"Vent X-Flow-3"},
    {1055,"Vent Alien-4"},
    {1061,"Vent X-Flow-4"},
    {1067,"Vent Alien-5"},
    {1068,"Vent X-Flow-5"},
    {1088,"Vent Alien-6"},
    {1091,"Vent X-Flow-6"},
    {1101,"BullBars Fire 1 Left"},
    {1106,"BullBars Stripes 1 Left"},
    {1109,"BullBars Lamp"},
    {1110,"BullBars Lamp Small"},
    {1111,"Accessories Metal 1"},
    {1112,"Accessories Metal 2"},
    {1121,"Accessories 3"},
    {1122,"BullBars Fire 2 Left"},
    {1123,"Accessories 4"},
    {1124,"BullBars Stripes 2 Left"},
    {1125,"BullBars Lamp 2"},
    {1128,"Hard Top"},
    {1130,"Medium Top"},
    {1131,"Soft Top"},
    {18659,"Vehicle Text"},
    {1025,"Wheels Offroad"},
    {1066,"Exhaust X-Flow"},
    {1065,"Exhaust Alien"},
    {1142,"Vets Left Oval"},
    {1143,"Vents Right Oval"},
    {1144,"Vents Left Square"},
    {1145,"Vents Right Square"},
    {1171,"Alien Front Bumper-1"},
    {1149,"Alien Rear Bumper-1"},
    {1023,"Spoiler Fury"},
    {1172,"X-Flow Front Bumper-1"},
    {1148,"X-Flow Rear Bumper-1"},
    {1000,"Pro Spoiler"},
    {1001,"Win Spoiler"},
    {1002,"Drag Spoiler"},
    {1003,"Alpha Spoiler"},
    {1004,"Champ Scoop Hood"},
    {1005,"Fury Scoop Hood"},
    {1006,"Roof Scoop"},
    {1007,"R-Sideskirt-TF"},
    {1011,"Race Scoop Hood"},
    {1012,"Worx Scoop Hood"},
    {1014,"Champ Spoiler"},
    {1015,"Race Spoiler"},
    {1016,"Worx Spoiler"},
    {1017,"L-Sideskirt-TF"},
    {1030,"L-Sideskirt-WAA-1"},
    {1031,"R-Sideskirt-WAA-1"},
    {1036,"R-Sideskirt-WAA-2"},
    {1039,"L-Sideskirt-WAA-3"},
    {1040,"L-Sideskirt-WAA-2"},
    {1041,"R-Sideskirt-WAA-3"},
    {1047,"R-Sideskirt-WAA-4"},
    {1048,"R-Sideskirt-WAA-5"},
    {1049,"Alien Spoiler-1"},
    {1050,"X-Flow Spoiler-1"},
    {1051,"L-Sideskirt-WAA-4"},
    {1052,"L-Sideskirt-WAA-5"},
    {1056,"R-Sideskirt-WAA-6"},
    {1057,"R-Sideskirt-WAA-7"},
    {1058,"Alien Spoiler-2"},
    {1060,"X-Flow Spoiler-2"},
    {1062,"L-Sideskirt-WAA-6"},
    {1063,"L-Sideskirt-WAA-7"},
    {1116,"F-Bullbars Slamin-1"},
    {1115,"F-Bullbars Chrome-1"},
    {1138,"Alien Spoiler-3"},
    {1139,"X-Flow Spoiler-3"},
    {1140,"X-Flow Rear Bumper-2"},
    {1141,"Alien Rear Bumper-2"},
    {1146,"X-Flow Spoiler-4"},
    {1147,"Alien Spoiler-4"},
    {1148,"X-Flow Rear Bumper-3"},
    {1149,"Alien Rear Bumper-3"},
    {1150,"Alien Rear Bumper-4"},
    {1151,"X-Flow Rear Bumper-4"},
    {1152,"X-Flow Front Bumper-4"},
    {1153,"Alien Front Bumper-4"},
    {1154,"Alien Rear Bumper-5"},
    {1155,"Alien Front Bumper-5"},
    {1156,"X-Flow Rear Bumper-5"},
    {1157,"X-Flow Front Bumper-5"},
    {1158,"X-Flow Spoiler-5"},
    {1159,"Alien Rear Bumper-6"},
    {1160,"Alien Front Bumper-6"},
    {1161,"X-Flow Rear Bumper-6"},
    {1162,"Alien Spoiler-5"},
    {1163,"X-Flow Spoiler-6"},
    {1164,"Alien Spoiler-6"},
    {1165,"X-Flow Front Bumper-7"},
    {1166,"Alien Front Bumper-7"},
    {1167,"X-Flow Rear Bumper-7"},
    {1168,"Alien Rear Bumper-7"},
    {1169,"Alien Front Bumper-2"},
    {1170,"X-Flow Front Bumper-2"},
    {1171,"Alien Front Bumper-3"},
    {1172,"X-Flow Front Bumper-3"},
    {1173,"X-Flow Front Bumper-6"},
    {1174,"Chrome Front Bumper-1"},
    {1175,"Slamin Front Bumper-1"},
    {1176,"Chrome Rear Bumper-1"},
    {1177,"Slamin Rear Bumper-1"},
    {1178,"Slamin Rear Bumper-2"},
    {1179,"Chrome Front Bumper-2"},
    {1185,"Slamin Front Bumper-3"},
    {1188,"Slamin Front Bumper-4"},
    {19308, "Taxi Sign"}
};

new const FontNames[][] = {
    "Arial",
    "Calibri",
    "Comic Sans MS",
    "Georgia",
    "Times New Roman",
    "Consolas",
    "Constantia",
    "Corbel",
    "Courier New",
    "Impact",
    "Lucida Console",
    "Palatino Linotype",
    "Tahoma",
    "Trebuchet MS",
    "Verdana",
    "Custom Font"
}; 

new vehName[][] =       // array for vehicle names to be displayed
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
    "SABI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
    "Boxville", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher",
    "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain",
    "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
    "Fortune", "Cadrona", "SWAT Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
    "Blade", "Streak", "Freight", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
    "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
    "Uranus", "Jester", "Sultan", "Stratium", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
    "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "LSPD Car", "SFPD Car", "LVPD Car",
    "Police Rancher", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
    "Boxville", "Tiller", "Utility Trailer"
};

new const dmvehicle1[] = {
    461,
    462,
    463,
    468,
    521,
    581,
    586
};

new const dmvehicle2[] = {
    413,
    482,
    400,
    579,
    500,
    404,
    418,
    458,
    479,
    561,
    483
};

new const dmvehicle3[] = {
    600,
    554,
    543,
    478,
    422
};

new const dmvehicle4[] = {
    412,
    534,
    535,
    536,
    567,
    575,
    576
};

new const dmvehicle5[] = {
    401,
    405,
    410,
    419,
    421,
    426,
    436,
    445,
    466,
    467,
    474,
    491,
    492,
    507,
    516,
    517,
    518,
    526,
    527,
    529,
    540,
    542,
    546,
    547,
    549,
    550,
    551,
    560,
    562,
    585
};

new const dmvehicle6[] = {
    402,
    415,
    429,
    475,
    477,
    496,
    558,
    559,
    565,
    587,
    589,
    602
};

new const transfender[] = {
    1000,
	1001,
	1002,
	1003,
	1004,
	1005,
	1006,
	1007,
	1011,
	1012,
	1013,
	1014,
	1015,
	1016,
	1017,
	1023,
	1024,
	1025,
	1142,
	1143,
	1144,
	1145
};

new const loco[] = {
    1103,
	1104,
	1105,
	1107,
	1108,
	1128,
	1182,
	1183,
	1184,
	1042,
	1043,
	1044,
	1099,
	1174,
	1175,
	1176,
	1177,
	1100,
	1101,
	1106,
	1122,
	1123,
	1124,
	1125,
	1126,
	1127,
	1178,
	1179,
	1180,
	1185,
	1102,
	1129,
	1130,
	1131,
	1132,
	1133,
	1186,
	1187,
	1188,
	1189,
	1109,
	1110,
	1111,
	1112,
	1113,
	1114,
	1115,
	1116,
	1117,
	1118,
	1119,
	1120,
	1121
};

new const waa[] = {
    1026,
	1027,
	1028,
	1029,
	1030,
	1031,
	1032,
	1033,
	1034,
	1035,
	1036,
	1037,
	1038,
	1039,
	1040,
	1141,
	1045,
	1046,
	1047,
	1048,
	1049,
	1050,
	1051,
	1052,
	1053,
	1054,
	1055,
	1056,
	1057,
	1058,
	1059,
	1060,
	1061,
	1062,
	1063,
	1064,
	1065,
	1066,
	1067,
	1068,
	1069,
	1070,
	1071,
	1072,
	1088,
	1089,
	1090,
	1091,
	1092,
	1093,
	1094,
	1095,
	1138,
	1139,
	1140,
	1141,
	1146,
	1147,
	1148,
	1149,
	1150,
	1151,
	1152,
	1153,
	1154,
	1155,
	1156,
	1157,
	1158,
	1159,
	1160,
	1161,
	1162,
	1163,
	1164,
	1165,
	1166,
	1167,
	1168,
	1169,
	1170,
	1171,
	1172,
	1173
};

new const maleSkins[] =
{
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	14,
	15,
	16,
	17,
	18,
	19,
	20,
	21,
	22,
	23,
	24,
	25,
	26,
	27,
	28,
	29,
	30,
	32,
	33,
	34,
	35,
	36,
	37,
	42,
	43,
	44,
	45,
	46,
	47,
	48,
	49,
	50,
	51,
	52,
	57,
	58,
	59,
	60,
	61,
	62,
	66,
	67,
	68,
	70,
	71,
	72,
	73,
	78,
	79,
	80,
	81,
	82,
	83,
	84,
	86,
	94,
	95,
	96,
	97,
	98,
	99,
	100,
	101,
	102,
	103,
	104,
	105,
	106,
	107,
	108,
	109,
	110,
	111,
	112,
	113,
	114,
	115,
	116,
	117,
	118,
	119,
	120,
	121,
	122,
	123,
	124,
	125,
	126,
	127,
	128,
	129,
	132,
	133,
	134,
	135,
	136,
	137,
	142,
	143,
	144,
	146,
	147,
	149,
	153,
	154,
	156,
	158,
	159,
	160,
	161,
	162,
	168,
	170,
	171,
	173,
	174,
	175,
	176,
	177,
	179,
	180,
	181,
	182,
	183,
	184,
	185,
	186,
	187,
	188,
	189,
	200,
	202,
	206,
	208,
	209,
	210,
	212,
	213,
	217,
	220,
	221,
	222,
	223,
	227,
	228,
	229,
	230,
	234,
	235,
	236,
	239,
	240,
	241,
	242,
	247,
	248,
	249,
	250,
	252,
	253,
	254,
	255,
	258,
	259,
	261,
	262,
	264,
	269,
	270,
	271,
	272,
	273,
	289,
	299
};

new const femaleSkins[] =
{
	9,
	10,
	11,
	12,
	13,
	31,
	38,
	39,
	40,
	41,
	53,
	54,
	55,
	56,
	63,
	64,
	65,
	75,
	76,
	77,
	85,
	87,
	88,
	89,
	90,
	91,
	92,
	93,
	129,
	130,
	131,
	138,
	139,
	140,
	141,
	145,
	148,
	150,
	151,
	152,
	157,
	169,
	172,
	178,
	190,
	191,
	192,
	193,
	194,
	195,
	196,
	197,
	198,
	199,
	201,
	205,
	207,
	211,
	214,
	215,
	216,
	218,
	219,
	224,
	225,
	226,
	231,
	232,
	233,
	237,
	238,
	243,
	244,
	245,
	246,
	251,
	256,
	257,
	263
};

new const sapdwar[] =
{
	121,
	285,
	286,
	287,
	117,
	118,
	165,
	166
};

new const sapdmale[] =
{
	302,
	303,
	304,
	305,
	310,
	311,
	165,
	166
};

new const sapdfemale[] =
{
	306,
	307,
	308,
	309,
	148,
	150
};

new const samdmale[] =
{
	70,
	187,
	303,
	304,
	305,
	274,
	275,
	276,
	277,
	278,
	279,
	165,
	71,
	177
};

new const samdfemale[] =
{
	308,
	76,
	141,
	148,
	150,
	169,
	172,
	194,
	219
};

new const sanewsmale[] =
{
	172,
	194,
	211,
	216,
	219,
	233,
	11,
	9
};

new const sanewsfemale[] =
{
	171,
	187,
	189,
	240,
	303,
	304,
	305,
	20,
	59
};