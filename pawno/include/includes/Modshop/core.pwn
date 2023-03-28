/*
===========================================================
    Vehicle Accesories Script, Author : Revelt
===========================================================*/

/*===========================================================
    Pre-Definition
===========================================================*/

#define MAX_VEHICLE_OBJECT 10
#define MAX_COLOR_OBJECT 5

#define OBJECT_TYPE_BODY 1
#define OBJECT_TYPE_TEXT 2

#define MODEL_SELECTION_VEHOBJECT   (150)

/*===========================================================
    Global Vehicle Object Variable
===========================================================*/

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
new 
    VehicleObjects[MAX_PRIVATE_VEHICLE][MAX_VEHICLE_OBJECT][E_VEH_OBJECT], // Sebagai variable dari enumurator veh object
    ListedVehObject[MAX_PLAYERS][MAX_VEHICLE_OBJECT], // Untuk menyimpan index id array vehicle object ke playerid
    Player_EditingObject[MAX_PLAYERS], // Sebagai flagger untuk menandakan player sedang edit object atau tidak 
    Player_EditVehicleObject[MAX_PLAYERS], // Variable Holder
    Player_EditVehicleObjectSlot[MAX_PLAYERS] // Variable Holder
; 
new color_string[3256], object_font[200];
/*===========================================================
    Vehicle Object Array
===========================================================*/

enum E_OBJECT {
    Model,
    Name[37]
};

new VehObject[][E_OBJECT] = {
    {1000,"Generic Spoiler"},
    {1001,"Generic Spoiler"},
    {1002,"Generic Spoiler"},
    {1003,"Generic Spoiler"},
    {1004,"Bonnet Scoop"},
    {1005,"Bonnet Scoop"},
    {1006,"Generic Vehicle Roof-Scoop"},
    {1007,"Generic Vehicle Side Skirt (L)"},
    {1011,"Bonnet Scoop"},
    {1012,"Bonnet Scoop"},
    {1013,"Round Fog Lamps"},
    {1014,"Generic Spoiler"},
    {1015,"Generic Spoiler"},
    {1016,"Generic Spoiler"},
    {1017,"Generic Vehicle Side Skirt (R)"},
    {1018,"Curved Twin Cylinder Generic Exhaust"},
    {1019,"Twin Cylinder Generic Exhaust"},
    {1020,"Large Generic Exhaust"},
    {1021,"Medium Generic Exhaust"},
    {1022,"Small Generic Exhaust"},
    {1023,"Generic Spoiler"},
    {1024,"Square Fog Lamps"},
    {1026,"Sultan Side Skirt Type 1 (L)"},
    {1027,"Sultan Side Skirt Type 1 (R)"},
    {1028,"Sultan Exhaust Type 1"},
    {1029,"Sultan Exhaust Type 2"},
    {1030,"Sultan Side Skirt Type 2 (R)"},
    {1031,"Sultan Side Skirt Type 1 (L)"},
    {1032,"Sultan Roof Scoop type 1"},
    {1033,"Sultan Roof Scoop type 2"},
    {1034,"Elegy Exhaust type 1"},
    {1035,"Elegy Roof Scoop Type 1"},
    {1036,"Elegy Side Skirt type 1 (L)"},
    {1037,"Elegy Exhaust Type 2"},
    {1038,"Elegy Roof Scoop type 2"},
    {1039,"Elegy Side Skirt type 2 (L)"},
    {1040,"Elegy Side Skirt type 1 (R)"},
    {1041,"Elegy Side Skirt type 2 (R)"},
    {1042,"Broadway Side Skirt (L)"},
    {1043,"Broadway Exhaust type 2"},
    {1044,"Broadway Exhaust type 1"},
    {1045,"Flash Exhaust type 2"},
    {1046,"Flash Exhaust type 1"},
    {1047,"Flash Side Skirt type 1 (L)"},
    {1048,"Flash Side Skirt type 2 (L)"},
    {1049,"Flash Spoiler type 1"},
    {1050,"Flash Spoiler type 2"},
    {1051,"Flash Side Skirt type 1 (R)"},
    {1052,"Flash Side Skirt type 2 (R)"},
    {1053,"Flash Roof Scoop type 2"},
    {1054,"Flash Roof Scoop type 1"},
    {1055,"Stratum Roof Scoop type 1"},
    {1056,"Stratum Side Skirt type 1 (L)"},
    {1057,"Stratum Side Skirt type 2 (L)"},
    {1058,"Stratum Spoiler type 1"},
    {1059,"Stratum Exhaust type 2"},
    {1060,"Stratum Spoiler type 2"},
    {1061,"Stratum Roof Scoop type 2"},
    {1062,"Stratum Side Skirt type 1 (R)"},
    {1063,"Stratum Side Skirt type 2 (R)"},
    {1064,"Stratum Exhaust type 1"},
    {1065,"Jester Exhaust type 1"},
    {1066,"Jester Exhaust type 2"},
    {1067,"Jester Roof Scoop type 1"},
    {1068,"Jester Roof Scoop type 2"},
    {1069,"Jester Side Skirt type 1 (L)"},
    {1070,"Jester Side Skirt type 2 (L)"},
    {1071,"Jester Side Skirt type 1 (R)"},
    {1072,"Jester Side Skirt type 2 (R)"},
    {1088,"Uranus Roof Scoop 1"},
    {1089,"Uranus Exhaust Type 1"},
    {1090,"Uranus Side Skirt type 1 (L)"},
    {1091,"Uranus Roof Scoop 2"},
    {1092,"Uranus Exhaust Type 2"},
    {1093,"Uranus Side Skirt type 2 (L)"},
    {1094,"Uranus Side Skirt type 1 (R)"},
    {1095,"Uranus Side Skirt type 2 (R)"},
    {1099,"Broadway Side Skirt (R)"},
    {1100,"Remington Misc. Part 1"},
    {1101,"Remington Side Skirt type 1 (R)"},
    {1102,"Savanna Side Skirt (R)"},
    {1103,"Blade Roof type 2"},
    {1104,"Blade Exhaust type 1"},
    {1105,"Blade Exhaust type 2"},
    {1106,"Remington Side Skirt type 2 (L)"},
    {1107,"Blade Side Skirt (R)"},
    {1108,"Blade Side Skirt (L)"},
    {1109,"Slamvan Rear Bullbars type 1"},
    {1110,"Slamvan Rear Bullbars type 2"},
    {1111,"Slamvan hood ornament 1 (not used)"},
    {1112,"Slamvan hood ornament 2 (not used)"},
    {1113,"Slamvan Exhaust type 1"},
    {1114,"Slamvan Exhaust type 2"},
    {1115,"Slamvan Front Bullbars type 1"},
    {1116,"Slamvan Front Bullbars type 2"},
    {1117,"Slamvan Front Bumper"},
    {1118,"Slamvan Side Skirt type 1 (L)"},
    {1119,"Slamvan Side Skirt type 2 (L)"},
    {1120,"Slamvan Side Skirt type 1 (R)"},
    {1121,"Slamvan Side Skirt type 2 (R)"},
    {1122,"Remington Side Skirt type 1 (L)"},
    {1123,"Remington Misc. Part 2"},
    {1124,"Remington Side Skirt type 2 (R)"},
    {1125,"Remington Misc. Part 3"},
    {1126,"Remington Exhaust type 1"},
    {1127,"Remington Exhaust type 2"},
    {1128,"Blade Roof Type 1"},
    {1129,"Savanna Exhaust type 1"},
    {1130,"Savanna Roof type 1"},
    {1131,"Savanna Roof type 2"},
    {1132,"Savanna Exhaust type 2"},
    {1133,"Savanna Side Skirt (L)"},
    {1134,"Tornado Side Skirt (L)"},
    {1135,"Tornado Exhaust type 2"},
    {1136,"Tornado Exhaust type 1"},
    {1137,"Tornado Side Skirt (R)"},
    {1138,"Sultan Spoiler type 1"},
    {1139,"Sultan Spoiler type 2"},
    {1140,"Sultan Rear Bumper type 2"},
    {1141,"Sultan Rear Bumper type 1"},
    {1142,"Oval Bonnet Vents (R)"},
    {1143,"Oval Bonnet Vents (L)"},
    {1144,"Square Bonnet Vents (R)"},
    {1145,"Square Bonnet Vents (L)"},
    {1146,"Elegy Spoiler type 2"},
    {1147,"Elegy Spoiler type 1"},
    {1148,"Elegy Rear Bumper type 2"},
    {1149,"Elegy Rear Bumper type 1"},
    {1150,"Flash Rear Bumper type 1"},
    {1151,"Flash Rear Bumper type 2"},
    {1152,"Flash Front Bumper type 2"},
    {1153,"Flash Front Bumper type 1"},
    {1154,"Stratum Rear Bumper type 1"},
    {1155,"Stratum Front Bumper type 1"},
    {1156,"Stratum Rear Bumper type 2"},
    {1157,"Stratum Front Bumper type 2"},
    {1158,"Jester Spoiler type 2"},
    {1159,"Jester Rear Bumper type 1"},
    {1160,"Jester Front bumper type 1"},
    {1161,"Jester Rear bumper type2"},
    {1162,"Jester Spoiler type 1"},
    {1163,"Uranus Spoiler type 2"},
    {1164,"Uranus Spoiler type 1"},
    {1165,"Uranus Front Bumper type 2"},
    {1166,"Uranus Rear Bumper type 2"},
    {1167,"Uranus Front Bumper type 1"},
    {1168,"Uranus Rear Bumper type 1"},
    {1169,"Sultan Front Bumper type 1"},
    {1170,"Sultan Front Bumper type 2"},
    {1171,"Elegy Front Bumper type 1"},
    {1172,"Elegy Front Bumper type 2"},
    {1173,"Jester Front Bumper type 2"},
    {1174,"Broadway Front Bumper type 1"},
    {1175,"Broadway Front Bumper type 2"},
    {1176,"Broadway Rear Bumper type 1"},
    {1178,"Remington Rear Bumper type 2"},
    {1179,"Remington Front Bumper type 1"},
    {1180,"Remington Rear Bumper type 2"},
    {1181,"Blade Front Bumper type 2"},
    {1182,"Blade Front Bumper type 1"},
    {1183,"Blade Rear Bumper type 2"},
    {1184,"Blade Rear Bumper type 1"},
    {1185,"Remington Front Bumper type 2"},
    {1186,"Savanna Rear Bumper type 2"},
    {1187,"Savanna Rear Bumper type 1"},
    {1188,"Savanna Front Bumper type 2"},
    {1189,"Savanna Front Bumper type 1"},
    {1190,"Tornado Rear Bumper type 1"},
    {1191,"Tornado Rear Bumper type 2"},
    {1192,"Tornado Front Bumper type 1"},
    {1193,"Tornado Front Bumper type 2"},
    {19308, "Taxi Sign"}
};

//Color List!
stock const ColorList[] = {
    0x000000FF, 0xF5F5F5FF, 0x2A77A1FF, 0x840410FF, 0x263739FF, 0x86446EFF, 0xD78E10FF, 0x4C75B7FF, 0xBDBEC6FF, 0x5E7072FF,
    0x46597AFF, 0x656A79FF, 0x5D7E8DFF, 0x58595AFF, 0xD6DAD6FF, 0x9CA1A3FF, 0x335F3FFF, 0x730E1AFF, 0x7B0A2AFF, 0x9F9D94FF,
    0x3B4E78FF, 0x732E3EFF, 0x691E3BFF, 0x96918CFF, 0x515459FF, 0x3F3E45FF, 0xA5A9A7FF, 0x635C5AFF, 0x3D4A68FF, 0x979592FF,
    0x421F21FF, 0x5F272BFF, 0x8494ABFF, 0x767B7CFF, 0x646464FF, 0x5A5752FF, 0x252527FF, 0x2D3A35FF, 0x93A396FF, 0x6D7A88FF,
    0x221918FF, 0x6F675FFF, 0x7C1C2AFF, 0x5F0A15FF, 0x193826FF, 0x5D1B20FF, 0x9D9872FF, 0x7A7560FF, 0x989586FF, 0xADB0B0FF,
    0x848988FF, 0x304F45FF, 0x4D6268FF, 0x162248FF, 0x272F4BFF, 0x7D6256FF, 0x9EA4ABFF, 0x9C8D71FF, 0x6D1822FF, 0x4E6881FF,
    0x9C9C98FF, 0x917347FF, 0x661C26FF, 0x949D9FFF, 0xA4A7A5FF, 0x8E8C46FF, 0x341A1EFF, 0x6A7A8CFF, 0xAAAD8EFF, 0xAB988FFF,
    0x851F2EFF, 0x6F8297FF, 0x585853FF, 0x9AA790FF, 0x601A23FF, 0x20202CFF, 0xA4A096FF, 0xAA9D84FF, 0x78222BFF, 0x0E316DFF,
    0x722A3FFF, 0x7B715EFF, 0x741D28FF, 0x1E2E32FF, 0x4D322FFF, 0x7C1B44FF, 0x2E5B20FF, 0x395A83FF, 0x6D2837FF, 0xA7A28FFF,
    0xAFB1B1FF, 0x364155FF, 0x6D6C6EFF, 0x0F6A89FF, 0x204B6BFF, 0x2B3E57FF, 0x9B9F9DFF, 0x6C8495FF, 0x4D8495FF, 0xAE9B7FFF,
    0x406C8FFF, 0x1F253BFF, 0xAB9276FF, 0x134573FF, 0x96816CFF, 0x64686AFF, 0x105082FF, 0xA19983FF, 0x385694FF, 0x525661FF,
    0x7F6956FF, 0x8C929AFF, 0x596E87FF, 0x473532FF, 0x44624FFF, 0x730A27FF, 0x223457FF, 0x640D1BFF, 0xA3ADC6FF, 0x695853FF,
    0x9B8B80FF, 0x620B1CFF, 0x5B5D5EFF, 0x624428FF, 0x731827FF, 0x1B376DFF, 0xEC6AAEFF, 0x000000FF, 0x177517FF, 0x210606FF,
    0x125478FF, 0x452A0DFF, 0x571E1EFF, 0x010701FF, 0x25225AFF, 0x2C89AAFF, 0x8A4DBDFF, 0x35963AFF, 0xB7B7B7FF, 0x464C8DFF,
    0x84888CFF, 0x817867FF, 0x817A26FF, 0x6A506FFF, 0x583E6FFF, 0x8CB972FF, 0x824F78FF, 0x6D276AFF, 0x1E1D13FF, 0x1E1306FF,
    0x1F2518FF, 0x2C4531FF, 0x1E4C99FF, 0x2E5F43FF, 0x1E9948FF, 0x1E9999FF, 0x999976FF, 0x7C8499FF, 0x992E1EFF, 0x2C1E08FF,
    0x142407FF, 0x993E4DFF, 0x1E4C99FF, 0x198181FF, 0x1A292AFF, 0x16616FFF, 0x1B6687FF, 0x6C3F99FF, 0x481A0EFF, 0x7A7399FF,
    0x746D99FF, 0x53387EFF, 0x222407FF, 0x3E190CFF, 0x46210EFF, 0x991E1EFF, 0x8D4C8DFF, 0x805B80FF, 0x7B3E7EFF, 0x3C1737FF,
    0x733517FF, 0x781818FF, 0x83341AFF, 0x8E2F1CFF, 0x7E3E53FF, 0x7C6D7CFF, 0x020C02FF, 0x072407FF, 0x163012FF, 0x16301BFF,
    0x642B4FFF, 0x368452FF, 0x999590FF, 0x818D96FF, 0x99991EFF, 0x7F994CFF, 0x839292FF, 0x788222FF, 0x2B3C99FF, 0x3A3A0BFF,
    0x8A794EFF, 0x0E1F49FF, 0x15371CFF, 0x15273AFF, 0x375775FF, 0x060820FF, 0x071326FF, 0x20394BFF, 0x2C5089FF, 0x15426CFF,
    0x103250FF, 0x241663FF, 0x692015FF, 0x8C8D94FF, 0x516013FF, 0x090F02FF, 0x8C573AFF, 0x52888EFF, 0x995C52FF, 0x99581EFF,
    0x993A63FF, 0x998F4EFF, 0x99311EFF, 0x0D1842FF, 0x521E1EFF, 0x42420DFF, 0x4C991EFF, 0x082A1DFF, 0x96821DFF, 0x197F19FF,
    0x3B141FFF, 0x745217FF, 0x893F8DFF, 0x7E1A6CFF, 0x0B370BFF, 0x27450DFF, 0x071F24FF, 0x784573FF, 0x8A653AFF, 0x732617FF,
    0x319490FF, 0x56941DFF, 0x59163DFF, 0x1B8A2FFF, 0x38160BFF, 0x041804FF, 0x355D8EFF, 0x2E3F5BFF, 0x561A28FF, 0x4E0E27FF,
    0x706C67FF, 0x3B3E42FF, 0x2E2D33FF, 0x7B7E7DFF, 0x4A4442FF, 0x28344EFF
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

