RemoveGarage(playerid)
{
    RemoveBuildingForPlayer(playerid, 1231, 1480.030, -1832.910, 15.289, 0.250);
	RemoveBuildingForPlayer(playerid, 1372, 1468.060, -1847.790, 12.664, 0.250);
	RemoveBuildingForPlayer(playerid, 1372, 1466.949, -1847.839, 12.664, 0.250);
	RemoveBuildingForPlayer(playerid, 1265, 1465.479, -1848.250, 12.992, 0.250);
	RemoveBuildingForPlayer(playerid, 1372, 1486.209, -1848.130, 12.664, 0.250);
	RemoveBuildingForPlayer(playerid, 1357, 1487.699, -1848.109, 12.812, 0.250);
	RemoveBuildingForPlayer(playerid, 1230, 1488.920, -1848.270, 12.976, 0.250);
}
CreateGarage()
{
 	//Small Garage
	CreateDynamicObject(6387,402.2000100,-261.1000100,996.7000100,0.0000000,0.0000000,0.0000000, .interiorid = 1); //object(century03_law2) (1)
	CreateDynamicObject(16773,406.2999900,-294.0000000,996.7000100,0.0000000,0.0000000,0.0000000, .interiorid = 1); //object(door_savhangr1) (1)
	CreateDynamicObject(16773,404.7000100,-228.2000000,996.5999800,0.0000000,0.0000000,0.0000000, .interiorid = 1); //object(door_savhangr1) (2)

	//Medium Garage
	CreateDynamicObject(10784,656.7999900,-248.1000100,981.0000000,0.0000000,0.0000000,0.0000000, .interiorid = 1); //object(aircarpark_04_sfse) (1)
	CreateDynamicObject(16775,628.0000000,-279.7000100,980.7999900,0.0000000,0.0000000,90.0000000, .interiorid = 1); //object(door_savhangr2) (1)
	CreateDynamicObject(16775,672.7999900,-202.8000000,981.0999800,0.0000000,0.0000000,359.5000000, .interiorid = 1); //object(door_savhangr2) (2)

	//Big garage
	CreateDynamicObject(7244,72.6000000,-379.3999900,1183.8000000,0.0000000,0.0000000,0.0000000, .interiorid = 1); //object(vgnpolicecparkug) (2)
	CreateDynamicObject(8378,103.8000000,-350.7000100,1191.4000000,0.0000000,0.0000000,0.0000000, .interiorid = 1); //object(vgsbighngrdoor) (1)
	CreateDynamicObject(6959,121.6000000,-336.2999900,1185.4000000,0.0000000,0.0000000,0.0000000, .interiorid = 1); //object(vegasnbball1) (1)
	CreateDynamicObject(6959,122.9000000,-334.7000100,1201.6000000,270.7500000,180.0000000,92.0000000, .interiorid = 1); //object(vegasnbball1) (2)
	CreateDynamicObject(16773,123.4000000,-397.0000000,1189.4000000,0.0000000,0.0000000,270.0000000, .interiorid = 1); //object(door_savhangr1) (1)
	
	//Garasi Balkot
	tmpobjid = CreateObject(18765, 1479.707641, -1840.804809, 14.426865, 0.000000, 0.000014, 0.000000, 200.00);
	SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateObject(19861, 1484.696533, -1840.791381, 17.036874, 0.000000, 0.000000, 90.000000, 200.00);
	SetObjectMaterialText(tmpobjid, "{FFFFFF}KELUAR", 0, 120, "Quartz MS", 80, 1, 0x00000000, 0x00000000, 1);
	tmpobjid = CreateObject(640, 1487.415283, -1837.757080, 13.206884, 0.000000, 0.000000, 90.000000, 200.00);
	SetObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "tanboard1", 0xFF57432F);
	SetObjectMaterial(tmpobjid, 1, 4830, "airport2", "bevflower2", 0x00000000);
	tmpobjid = CreateObject(18766, 1478.553710, -1824.032104, 13.656879, 0.000000, 0.000000, 0.000000, 200.00);
	SetObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "tanboard1", 0xFF574307);
	tmpobjid = CreateObject(19861, 1474.717041, -1840.791381, 17.036874, 0.000000, 0.000000, 270.000000, 200.00);
	SetObjectMaterialText(tmpobjid, "{ffffff} MASUK", 0, 120, "Quartz MS", 80, 1, 0x00000000, 0x00000000, 1);
	tmpobjid = CreateObject(640, 1487.415283, -1843.797973, 13.206884, 0.000000, 0.000000, 90.000000, 200.00);
	SetObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "tanboard1", 0xFF57432F);
	SetObjectMaterial(tmpobjid, 1, 4830, "airport2", "bevflower2", 0x00000000);
	tmpobjid = CreateObject(640, 1472.104370, -1837.707031, 13.206884, 0.000007, 0.000000, 89.999977, 200.00);
	SetObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "tanboard1", 0xFF57432F);
	SetObjectMaterial(tmpobjid, 1, 4830, "airport2", "bevflower2", 0x00000000);
	tmpobjid = CreateObject(18981, 1185.144897, -2202.939697, -9.991017, 0.000000, 0.000000, 0.000000, 200.00);
	SetObjectMaterial(tmpobjid, 0, 15046, "svcunthoose", "GB_fireplace02", 0x00000000);
	tmpobjid = CreateObject(640, 1472.104370, -1843.747924, 13.206884, 0.000007, 0.000000, 89.999977, 200.00);
	SetObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "tanboard1", 0xFF57432F);
	SetObjectMaterial(tmpobjid, 1, 4830, "airport2", "bevflower2", 0x00000000);
	tmpobjid = CreateObject(18981, 1185.144897, -2178.027832, -9.991017, 0.000000, 0.000000, 0.000000, 200.00);
	SetObjectMaterial(tmpobjid, 0, 15046, "svcunthoose", "GB_fireplace02", 0x00000000);
	tmpobjid = CreateObject(18981, 1460.330322, -2480.288818, -29.620868, 0.000000, 0.000045, 0.000000, 200.00);
	SetObjectMaterial(tmpobjid, 0, 15046, "svcunthoose", "GB_fireplace02", 0x00000000);
	tmpobjid = CreateObject(18981, 1460.330322, -2455.376953, -29.620868, 0.000000, 0.000045, 0.000000, 200.00);
	SetObjectMaterial(tmpobjid, 0, 15046, "svcunthoose", "GB_fireplace02", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	tmpobjid = CreateObject(1557, 1477.007446, -1824.471801, 12.546875, 0.000000, 0.000000, 0.000000, 200.00);
	tmpobjid = CreateObject(1557, 1480.038085, -1824.481811, 12.546875, 0.000000, 0.000000, 180.000000, 200.00);
	tmpobjid = CreateObject(19861, 1474.716674, -1840.712402, 15.036885, 0.000000, 0.000000, 90.000000, 200.00);
	tmpobjid = CreateObject(19861, 1484.766601, -1840.791381, 15.006877, 0.000000, 0.000000, 90.000000, 200.00);
	tmpobjid = CreateObject(1568, 1490.397949, -1837.731811, 12.326871, 0.000000, 0.000000, 0.000000, 200.00);
	tmpobjid = CreateObject(970, 1501.420654, -1860.193603, 13.076875, 0.000000, 0.000000, 0.000000, 200.00);
	tmpobjid = CreateObject(19858, 1479.105468, -1835.813720, 13.716885, 0.000000, 0.000000, 0.000000, 200.00);
	tmpobjid = CreateObject(4032, 1171.852294, -2160.677978, -2.171330, 0.000000, 0.000000, 0.000000, 200.00);
	tmpobjid = CreateObject(1568, 1469.175659, -1837.731811, 12.326871, 0.000000, 0.000000, 0.000000, 200.00);
	tmpobjid = CreateObject(11711, 1479.896118, -1835.819702, 15.226878, 0.000000, 0.000000, 0.000000, 200.00);
	tmpobjid = CreateObject(19955, 1398.950683, -1841.838500, 12.546875, 0.000000, 0.000000, -144.899993, 200.00);
	tmpobjid = CreateObject(19425, 1418.730224, -1840.715698, 12.546875, 0.000000, 0.000000, 90.000000, 200.00);
	tmpobjid = CreateObject(19861, 1128.424194, -2127.787841, -5.551018, 0.000000, 0.000000, 90.000000, 200.00);
	tmpobjid = CreateObject(19425, 1418.730224, -1837.225585, 12.546875, 0.000000, 0.000000, 90.000000, 200.00);
	tmpobjid = CreateObject(18765, 1123.334228, -2128.641845, -6.481015, 0.000000, 0.000000, 0.000000, 200.00);
	tmpobjid = CreateObject(18765, 1123.334228, -2135.212646, -6.481017, 0.000000, 0.000000, 0.000000, 200.00);
	tmpobjid = CreateObject(19861, 1128.424194, -2136.038085, -5.551018, 0.000000, 0.000000, 90.000000, 200.00);
	tmpobjid = CreateObject(4032, 1447.037597, -2438.027099, -21.801183, 0.000000, 0.000045, 0.000000, 200.00);
	tmpobjid = CreateObject(19861, 1403.609619, -2405.136962, -25.180870, 0.000045, 0.000000, 89.999862, 200.00);
	tmpobjid = CreateObject(18765, 1398.519531, -2405.990966, -25.910856, 0.000000, 0.000045, 0.000000, 200.00);
	tmpobjid = CreateObject(19425, 1539.792114, -1840.756958, 12.546875, 0.000000, 0.000000, 90.000000, 200.00);
	tmpobjid = CreateObject(18765, 1398.519531, -2412.561767, -25.910852, 0.000000, 0.000045, 0.000000, 200.00);
	tmpobjid = CreateObject(19861, 1403.609619, -2413.387207, -25.180870, 0.000045, 0.000000, 89.999862, 200.00);
	tmpobjid = CreateObject(19425, 1539.792114, -1837.306396, 12.546875, 0.000000, 0.000000, 90.000000, 200.00);
	tmpobjid = CreateObject(19956, 1559.619262, -1842.169433, 12.546875, 0.000000, 0.000000, 155.500015, 200.00);
}
