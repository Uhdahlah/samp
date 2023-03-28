#if defined _SYSTEM_VEHICLE
	#endinput
#endif
#define _SYSTEM_VEHICLE

// ------------------------------------
#define GetVehicleInfo(%0,%1)		g_vehicle_info[%0][%1]
#define GetVehicleName(%0)			GetVehicleInfo(GetVehicleData(%0, V_MODELID)-400, VI_NAME)

// ------------------------------------
#define GetVehicleData(%0,%1)		g_vehicle_data[%0][%1]
#define SetVehicleData(%0,%1,%2)	g_vehicle_data[%0][%1] = %2
#define ClearVehicleData(%0)		g_vehicle_data[%0] = g_vehicle_default_values
#define IsValidVehicleID(%0)		(1 <= %0 < MAX_VEHICLES)

// ------------------------------------
#define GetVehicleParamEx(%0,%1) g_vehicle_params[%0][%1]

// ------------------------------------
#define VEHICLE_ACTION_TYPE_NONE 	-1
#define VEHICLE_ACTION_ID_NONE 		-1

// ------------------------------------
#define VEHICLE_PARAM_ON	(1)
#define VEHICLE_PARAM_OFF	(0)

// ------------------------------------
native IsValidVehicle(vehicleid);

// ------------------------------------
enum E_VEHICLE_STRUCT
{
	V_MODELID,
	Float: V_SPAWN_X,
	Float: V_SPAWN_Y,
	Float: V_SPAWN_Z,
	Float: V_SPAWN_ANGLE,
	V_COLOR_1,
	V_COLOR_2,
	V_RESPAWN_DELAY,
	V_ADDSIREN,
	// -------------
	V_ACTION_TYPE,
	V_ACTION_ID,
	// -------------
	V_DRIVER_ID,
	// -------------
	V_LIMIT,
	V_ALARM,
	Float: V_FUEL,
	Float: V_MILEAGE,
	// -------------
	Text3D: V_LABEL,
	// -------------
	Float: V_HEALTH,
	V_LAST_LOAD_TIME
};

// ------------------------------------
enum E_VEHICLE_PARAMS_STRUCT
{
	V_ENGINE, 	// двигатель
	V_LIGHTS, 	// фары
	V_ALARM,	// сигнализация
	V_LOCK, 	// закрыто ли
	V_BONNET, 	// капот
	V_BOOT, 	// багажник
	V_OBJECTIVE // отображене стрелки над автоqa
};

// ------------------------------------
enum E_VEHICE_INFO_STRUCT
{
	VI_NAME[21],				// название
	VI_PRICE,					// гос. стоимость
	VT_RENT_PRICE,				// стоимость аренды
	VI_TYPE,					// тип
	VT_LIC    					// параметр игрока который нужен для вождения транспорта
};

// ------------------------------------
new g_vehicle_data[MAX_VEHICLES][E_VEHICLE_STRUCT];
new 
	g_vehicle_default_values[E_VEHICLE_STRUCT] = 
{
	0,
	0.0,
	0.0,
	0.0,
	0.0,
	0,
	0,
	0,
	0,
	VEHICLE_ACTION_TYPE_NONE,
	VEHICLE_ACTION_ID_NONE,
	INVALID_PLAYER_ID,
	false,
	false,
	40.0,
	0.0,
	Text3D:-1,
	1000.0,
	0
};
new g_vehicle_params[MAX_VEHICLES][E_VEHICLE_PARAMS_STRUCT];

new const
	g_vehicle_info[211][E_VEHICE_INFO_STRUCT] = 
{
	{"Landstalker",				170000,		23000,	2,	2},	// 400
	{"Bravura",					50000,		500,	0,	2},	// 401
	{"Buffalo",					550000,		55000,	2,	2},	// 402
	{"Linerunner", 				0, 			0,		0,	3},	// 403
	{"Perenniel",				165000,		800,	0,	2},	// 404
	{"Sentinel",				8000000,	8000,	1,	2},	// 405
	{"Dumper", 					0, 			0,		0,	3},	// 406
	{"Firetruck", 				0,			0,		0,	3},	// 407
	{"Trashmaster", 			0,			0,		0,	3},	// 408
	{"Stretch",					13000000,	200000,	2,	2},	// 409
	{"Manana",					6000000,	7800,	1,	2},	// 410
	{"Infernus",				2000000,	20000,	0,	2},	// 411
	{"Voodoo",					230000,		23000,	0,	2},	// 412
	{"Pony",					0,			0,		0,	4},	// 413
	{"Mule", 					0,			0,		0,	3},	// 414
	{"Cheetah",					750000,		54000,	2,	2},	// 415
	{"Ambulance", 				0,			0,		0,	4},	// 416
	{"Leviathan",				0,			0,		0,	5},	// 417
	{"Moonbeam", 				640000,		6400,	0,	4},	// 418
	{"Esperanto",				750000,		5000,	1,	2},	// 419
	{"Taxi", 					0,			0,		0,	2},	// 420
	{"Washington",				220000,		8000,	2,	2},	// 421
	{"Bobcat",					320000,		1000,	0,	2},	// 422
	{"Mr Whoopee", 				0,			0,		0,	3},	// 423
	{"BF Injection",			10000,		100,	0,	2},	// 424
	{"Hunter", 					0,			0,		0,	5},	// 425
	{"Premier",					3800000,	38000,	2,	2},	// 426
	{"Enforcer", 				0,			0,		0,	3},	// 427
	{"Securicar", 				0,			0,		0,	3},	// 428
	{"Banshee", 				600000,		38600,	0,	2},	// 429
	{"Predator", 				0,			0,		0,	6},	// 430
	{"Bus", 					0,			0,		0,	4},	// 431
	{"Rhino", 					0,			0,		0,	3},	// 432
	{"Barracks", 				0,			0,		0,	3},	// 433
	{"Hotknife",				700000,		7000,	1,	2},	// 434
	{"Article Trailer", 		0,			0,		0,	1},	// 435
	{"Previon",					12300,		2000,	1,	2},	// 436
	{"Coach", 					0,			0,		0,	4},	// 437
	{"Cabbie", 					0,			0,		0,	2},	// 438
	{"Stallion",				130000,		13000,	0,	2},	// 439
	{"Rumpo", 					600000,		0,		0,	4},	// 440
	{"RC Bandit", 				0,			0,		0,	1},	// 441
	{"Romero", 					60000,		100,	0,	2},	// 442
	{"Packer", 					0,			0,		0,	3},	// 443
	{"Monster", 				0,			0,		0,	3},	// 444
	{"Admiral",					230000,		23000,	0,	2},	// 445
	{"Squalo", 					1750000,	175000,	0,	6},	// 446
	{"Seasparrow", 				2300000,	230000,	0,	5},	// 447
	{"Pizzaboy", 		0,			0,		0,	1},	// 448
	{"Tram", 					0,			0,		0,	4},	// 449
	{"Article Trailer 2", 		0,			0,		0,	1},	// 450
	{"Turismo",					950000,		54000,	2,	2},	// 451
	{"Speeder", 				1500000,	150000,	0,	6},	// 452
	{"Reefer", 					0,			0,		0,	6},	// 453
	{"Tropic", 					3500000,	350000,	0,	6},	// 454
	{"Flatbed", 				0,			0,		0,	3},	// 455
	{"Yankee", 					0,			0,		0,	3},	// 456
	{"Caddy", 					0,			0,		0,	1},	// 457
	{"Solair",			    	1100000,	2400,	0,	2},	// 458
	{"Berkley's RC", 			650000,		6500,	0,	4},	// 459
	{"Skimmer", 				0,			0,		0,	5},	// 460
	{"PCJ-600",					105000,		10500,	0,	1},	// 461
	{"Faggio",			    	3000,		300,	0,	1},	// 462
	{"Freeway",					93500,		9350,	1,	1},	// 463
	{"RC Baron", 				0,			0,		0,	1},	// 464
	{"RC Raider", 				0,			0,		0,	1},	// 465
	{"Glendale",				6000000,	28000,	2,	2},	// 466
	{"Oceanic",					115000,		350,	0,	2},	// 467
	{"Sanchez",					56000,		5600,	0,	1},	// 468
	{"Sparrow", 				2500000,	250000,	0,	5},	// 469
	{"Patriot", 				0,			0,		0,	2},	// 470
	{"Quad",					35000,		3500,	1,	1},	// 471
	{"Coastguard", 				0,			0,		0,	6},	// 472
	{"Dinghy",					25000,		25000,	0,	6},	// 473
	{"Hermes",					60000,		600,	0,	2},	// 474
	{"Sabre",	            	370000,		37000,	1,	2},	// 475
	{"Rustler", 				0,			0,		0,	5},	// 476
	{"ZR-350",					750000,		75000,	2,	2},	// 477
	{"Walton",					22000,		2200,	0,	2},	// 478
	{"Regina",					450000,		2400,	0,	2},	// 479
	{"Comet",					670000,		67000,	2,	2},	// 480
	{"BMX",		            	6000,		600,	0,	0},	// 481
	{"Burrito", 				225000,		520000,	0,	4},	// 482
	{"Camper", 					0,			0,		0,	4},	// 483
	{"Marquis", 				0,			0,		0,	6},	// 484
	{"Baggage", 				0,			0,		0,	1},	// 485
	{"Dozer", 					0,			0,		0,	3},	// 486
	{"Maverick", 				4100000,	410000,	0,	5},	// 487
	{"SAN News Maverick", 		0,			0,		0,	5},	// 488
	{"Rancher",					220000,		26000,	1,	2},	// 489
	{"FBI Rancher", 			7300000,	59000,	0,	2},	// 490
	{"Virgo",					970000,		8000,	1,	2},	// 491
	{"Greenwood",				190000,		1800,	0,	2},	// 492
	{"Jetmax", 					0,			0,		0,	6},	// 493
	{"Hotring Racer", 			4300000,	56000,	0,	2},	// 494
	{"Sandking", 				1300000,	130000,	1,	2},	// 495
	{"Blista Compact",			350000,		35000,	0,	2},	// 496
	{"Police Maverick", 		0,			0,		0,	6},	// 497
	{"Boxville", 				0,			0,		0,	3},	// 498
	{"Benson", 					0,			0,		0,	3},	// 499
	{"Mesa",					180000,		400,	0,	2},	// 500
	{"RC Goblin", 				0,			0,		0,	1}, // 501
	{"Hotring Racer A", 		13500000,	56000,	0,	2}, // 502
	{"Hotring Racer B", 		1300000,	55000,	0,	2}, // 503
	{"Bloodring Banger", 		0,			0,		0,	2}, // 504
	{"Rancher",					4800000,	42000,	2,	2},	// 505
	{"Super GT",				12400000,	29000,	2,	2},	// 506
	{"Elegant",					500000,		2400,	0,	2}, 	// 507
	{"Journey",					490000,		1000,	0,	3}, 	// 508
	{"Bike",					5000,		500,	0,	0}, 	// 509
	{"Mountain Bike",			5000,		500,	0,	0}, 	// 510
	{"Beagle", 					5000000,	500000,	0,	5}, 	// 511
	{"Cropduster", 				4000000,	400000,	0,	5}, 	// 512
	{"Stuntplane", 				3500000,	350000,	0,	5}, 	// 513
	{"Tanker",					0,			0,		0,	3}, 	// 514
	{"Roadtrain", 				0,			0,		0,	3}, 	// 515
	{"Nebula",					900000,		1800,	0,	2}, 	// 516
	{"Majestic",				12400,		2000,	0,	2}, 	// 517
	{"Buccaneer",				23000,		2300,	0,	2}, 	// 518
	{"Shamal", 					7500000,	750000,	0,	5}, 	// 519
	{"Hydra", 					0,			0,		0,	5}, 	// 520
	{"FCR-900",					110000,		11000,	0,	1}, 	// 521
	{"NRG-500", 				354000,		35400,	2,	1}, 	// 522
	{"HPV1000",					32000,		320,	0,	1}, 	// 523
	{"Cement Truck", 			0,			0,		0,	3}, 	// 524
	{"Towtruck", 				0,			0,		0,	2}, 	// 525
	{"Fortune",					14200,		2000,	0,	2}, 	// 526
	{"Cadrona",					13300,		2000,	0,	2}, 	// 527
	{"FBI Truck", 				0,			0,		0,	2},	// 528
	{"Willard",					250000,		2500,	0,	2},	// 529
	{"Forklift", 				0,			0,		0,	1}, 	// 530
	{"Tractor", 				0,			0,		0,	3}, 	// 531
	{"Combine Harvester", 		0,			0,		0,	3}, 	// 532
	{"Feltzer",					140000,		14000,	1,	2}, 	// 533
	{"Remington",			    187000,		18700,	1,	2}, 	// 534
	{"Slamvan",					210000,		21000,	1,	2}, 	// 535
	{"Blade",					200000,		20000,	1,	2}, 	// 536
	{"Freight (Train)", 		0,			0,		0,	1}, 	// 537
	{"Brownstreak (Train)", 	0,			0,		0,	1}, 	// 538
	{"Vortex", 					0,			0,		0,	1}, 	// 539
	{"Vincent",					780000,		1800,	0,	2}, 	// 540
	{"Bullet",					950000,		42000,	2,	2}, 	// 541
	{"Clover",					10500,		2000,	0,	2}, 	// 542
	{"Sadler", 					16400,		2000,	0,	2}, 	// 543
	{"Firetruck LA", 			0,			0,		0,	3}, 	// 544
	{"Hustler", 				11500, 		2000,	0,	2}, 	// 545
	{"Intruder",				15400,		2000,	0,	2}, 	// 546
	{"Primo",					13500,		2000,	0,	2}, 	// 547
	{"Cargobob", 				0, 			0,		0,	5},	// 548
	{"Tampa",					9600,		2000,	0,	2},	// 549
	{"Sunrise",					270000,		27000,	0,	2}, 	// 550
	{"Merit",			    	1300000,	110,	0,	2}, 	// 551
	{"Utility Van", 			210000,		2100,	0,	2}, 	// 552
	{"Nevada", 					0,			0,		0,	5}, 	// 553
	{"Yosemite", 				360000,		3600,	0,	2}, 	// 554
	{"Windsor",					25000,		50,		0,	2}, 	// 555
	{"Monster A", 				0,			0,		0,	3}, 	// 556
	{"Monster B", 				0,			0,		0,	3}, 	// 557
	{"Uranus",					4000000,	4500,	1,	2}, 	// 558
	{"Jester",					550000,		55000,	1,	2}, 	// 559
	{"Sultan",					500000,		18000,	1,	2}, 	// 560
	{"Stratum",					210000,		600,	0,	2},	// 561
	{"Elegy",					1000000,	10000,	2,	2}, 	// 562
	{"Raindance", 				0,			0,		0,	5}, 	// 563
	{"RC Tiger", 				0,			0,		0,	1}, 	// 564
	{"Flash",					145000,		1700,	0,	2}, 	// 565
	{"Tahoma",					270000,		27000,	0,	2}, 	// 566
	{"Savanna",					210000,		21000,	0,	2}, 	// 567
	{"Bandito",					50000,		500,	0,	2},	// 568
	{"Freight Flat Trailer", 	0,			0,		0,	1}, 	// 569
	{"Streak Trailer", 			0,			0,		0,	1}, 	// 570
	{"Kart", 					0,			0,		0,	1}, 	// 571
	{"Mower", 					0,			0,		0,	1}, 	// 572
	{"Dune", 					18000000,	20000,	0,	3}, 	// 573
	{"Sweeper", 				0,			0,		0,	1},	// 574
	{"Broadway",				60000,		600,	0,	2}, 	// 575
	{"Tornado",					50000,		600,	0,	2}, 	// 576
	{"AT400", 					0,			0,		0,	5}, 	// 577
	{"DFT-30", 					0,			0,		0,	3}, 	// 578
	{"Huntley",					340000,		34000,	0,	2},	// 579
	{"Stafford",				2000000,	15000,	0,	2}, 	// 580
	{"BF-400",					1400000,	14000,	0,	1}, 	// 581
	{"Newsvan",					0,			0,		0,	4}, 	// 582
	{"Tug", 					0,			0,		0,	1}, 	// 583
	{"Petrol Trailer", 			0,			0,		0,	1}, 	// 584
	{"Emperor",					1800000,	18000,	0,	2}, 	// 585
	{"Wayfarer",				96000,		9600,	0,	1}, 	// 586
	{"Euros",					420000,		42000,	0,	2}, 	// 587
	{"Hotdog", 					0,			0,		0,	3}, 	// 588
	{"Club",					300000,	    30000,	0,	2}, 	// 589
	{"Freight Box Trailer", 	0,			0,		0,	1}, 	// 590
	{"Article Trailer 3", 		0,			0,		0,	1}, 	// 591
	{"Andromada", 				0,			0,		0,	5}, 	// 592
	{"Dodo", 					0,			0,		0,	5}, 	// 593
	{"RC Cam", 					0,			0,		0,	1}, 	// 594
	{"Launch", 					0,			0,		0,	6}, 	// 595
	{"Police Car (LSPD)", 		0,			0,		0,	2}, 	// 596
	{"Police Car (SFPD)", 		0,			0,		0,	2}, 	// 597
	{"Police Car (LVPD)", 		0,			0,		0,	2}, 	// 598
	{"Police Ranger", 			0,			0,		0,	2}, 	// 599
	{"Picador",					50000,		800,	0,	2}, 	// 600
	{"S.W.A.T.", 				0,			0,		0,	3}, 	// 601
	{"Alpha",					3400000,	34000,	0,	2}, 	// 602
	{"Phoenix", 				550000,		55000,	0,	2}, 	// 603
	{"Glendale Shit", 			12000000,	0,		0,	2}, 	// 604
	{"Sadler Shit", 			0,			0,		0,	2},	// 605
	{"Baggage Trailer A", 		0,			0,		0,	1},	// 606
	{"Baggage Trailer B", 		0,			0,		0,	1},	// 607
	{"Tug Stairs Trailer", 		0,			0,		0,	1},	// 608
	{"Boxville", 				0,			0,		0,	3},	// 609
	{"Farm Trailer", 			0,			0,		0,	1}	// 610
};
// ------------------------------------

stock SetVehicleDataAll(vehicleid, modelid, Float:x, Float:y, Float:z, Float:angle, color1, color2, respawn_delay, addsiren=0, action_type, action_id)
{
	if(IsValidVehicleID(vehicleid))
	{
		SetVehicleData(vehicleid, V_MODELID, modelid);
		
		SetVehicleData(vehicleid, V_SPAWN_X, 		x);
		SetVehicleData(vehicleid, V_SPAWN_Y, 		y);
		SetVehicleData(vehicleid, V_SPAWN_Z, 		z);
		SetVehicleData(vehicleid, V_SPAWN_ANGLE, 	angle);
		
		SetVehicleData(vehicleid, V_COLOR_1, 	color1);
		SetVehicleData(vehicleid, V_COLOR_2, 	color2);
		
		SetVehicleData(vehicleid, V_RESPAWN_DELAY, 	respawn_delay);
		SetVehicleData(vehicleid, V_ADDSIREN, 		addsiren);
		
		SetVehicleData(vehicleid, V_ACTION_TYPE, 	action_type);
		SetVehicleData(vehicleid, V_ACTION_ID, 		action_id);
		SetVehicleData(vehicleid, V_DRIVER_ID, 		INVALID_PLAYER_ID);
		
		SetVehicleData(vehicleid, V_FUEL, 40.0);
		SetVehicleData(vehicleid, V_MILEAGE, 0.0);
		SetVehicleData(vehicleid, V_LIMIT, true);

		SetVehicleData(vehicleid, V_HEALTH, 1000.0);
	
		SetVehicleParamsEx(vehicleid, IsABike(vehicleid) ? VEHICLE_PARAM_ON : VEHICLE_PARAM_OFF, VEHICLE_PARAM_OFF, VEHICLE_PARAM_OFF, VEHICLE_PARAM_OFF, VEHICLE_PARAM_OFF, VEHICLE_PARAM_OFF, VEHICLE_PARAM_OFF);
	}
}

stock n_veh_AddStaticVehicleEx(modelid, Float:x, Float:y, Float:z, Float:angle, color1, color2, respawn_delay, addsiren=0, action_type=VEHICLE_ACTION_TYPE_NONE, action_id=VEHICLE_ACTION_ID_NONE)
{
	static n_veh_vehicleid = INVALID_VEHICLE_ID;
	
	n_veh_vehicleid = AddStaticVehicleEx(modelid, x, y, z, angle, color1, color2, respawn_delay);
	SetVehicleDataAll(n_veh_vehicleid, modelid, x, y, z, angle, color1, color2, respawn_delay, addsiren, action_type, action_id);

	return n_veh_vehicleid;
	
	// The vehicle ID of the vehicle created (1 - MAX_VEHICLES).
	// INVALID_VEHICLE_ID (65535) if vehicle was not created (vehicle limit reached or invalid vehicle model ID passed).
}
#if defined _ALS_AddStaticVehicleEx
    #undef AddStaticVehicleEx
#else
    #define _ALS_AddStaticVehicleEx
#endif
#define AddStaticVehicleEx n_veh_AddStaticVehicleEx

stock n_veh_AddStaticVehicle(modelid, Float:x, Float:y, Float:z, Float:angle, color1, color2, action_type=VEHICLE_ACTION_TYPE_NONE, action_id=VEHICLE_ACTION_ID_NONE)
{
	static n_veh_vehicleid = INVALID_VEHICLE_ID;
	
	n_veh_vehicleid = AddStaticVehicle(modelid, x, y, z, angle, color1, color2);
	SetVehicleDataAll(n_veh_vehicleid, modelid, x, y, z, angle, color1, color2, 0, 0, action_type, action_id);

	return n_veh_vehicleid;
	
	// The vehicle ID of the vehicle created (1 - MAX_VEHICLES).
	// INVALID_VEHICLE_ID (65535) if vehicle was not created (vehicle limit reached or invalid vehicle model ID passed).
}
#if defined _ALS_AddStaticVehicle
    #undef AddStaticVehicle
#else
    #define _ALS_AddStaticVehicle
#endif
#define AddStaticVehicle n_veh_AddStaticVehicle

stock n_veh_CreateVehicle(modelid, Float:x, Float:y, Float:z, Float:angle, color1, color2, respawn_delay, addsiren=0, action_type=VEHICLE_ACTION_TYPE_NONE, action_id=VEHICLE_ACTION_ID_NONE)
{
	static n_veh_vehicleid = INVALID_VEHICLE_ID;
	
	n_veh_vehicleid = CreateVehicle(modelid, x, y, z, angle, color1, color2, respawn_delay);
	SetVehicleDataAll(n_veh_vehicleid, modelid, x, y, z, angle, color1, color2, respawn_delay, addsiren, action_type, action_id);

	return n_veh_vehicleid;
	
	// The vehicle ID of the vehicle created (1 - MAX_VEHICLES).
	// INVALID_VEHICLE_ID (65535) if vehicle was not created (vehicle limit reached or invalid vehicle model ID passed).
}
#if defined _ALS_CreateVehicle
    #undef CreateVehicle
#else
    #define _ALS_CreateVehicle
#endif
#define CreateVehicle n_veh_CreateVehicle

stock n_veh_DestroyVehicle(vehicleid)
{
	if(IsValidVehicleID(vehicleid))
	{
		ClearVehicleData(vehicleid);
		DestroyVehicleLabel(vehicleid);
	}
	return DestroyVehicle(vehicleid);
}
#if defined _ALS_DestroyVehicle
    #undef DestroyVehicle
#else
    #define _ALS_DestroyVehicle
#endif
#define DestroyVehicle n_veh_DestroyVehicle

public OnGameModeInit()
{
    for(new idx = 0; idx < MAX_VEHICLES; idx ++)
	{
		ClearVehicleData(idx);
	}
	
#if defined n_veh_OnGameModeInit
    n_veh_OnGameModeInit();
#endif
    return 1;
}
#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit n_veh_OnGameModeInit
#if defined n_veh_OnGameModeInit
forward n_veh_OnGameModeInit();
#endif  

// ---------------------------------------------------
stock SetVehicleParamsInit(vehicleid)
{	
	GetVehicleParamsEx
	(
		vehicleid, 
		g_vehicle_params[vehicleid][V_ENGINE],
		g_vehicle_params[vehicleid][V_LIGHTS],
		g_vehicle_params[vehicleid][V_ALARM],
		g_vehicle_params[vehicleid][V_LOCK],
		g_vehicle_params[vehicleid][V_BONNET],
		g_vehicle_params[vehicleid][V_BOOT],
		g_vehicle_params[vehicleid][V_OBJECTIVE]
	);
}

stock GetVehicleParam(vehicleid, E_VEHICLE_PARAMS_STRUCT:paramid)
{
	SetVehicleParamsInit(vehicleid);
	return g_vehicle_params[vehicleid][paramid];
}

stock SetVehicleParam(vehicleid, E_VEHICLE_PARAMS_STRUCT:paramid, set_value)
{
	SetVehicleParamsInit(vehicleid);
	g_vehicle_params[vehicleid][paramid] = bool: set_value;
	
	SetVehicleParamsEx
	(
		vehicleid,
		g_vehicle_params[vehicleid][V_ENGINE],
		g_vehicle_params[vehicleid][V_LIGHTS],
		g_vehicle_params[vehicleid][V_ALARM],
		g_vehicle_params[vehicleid][V_LOCK],
		g_vehicle_params[vehicleid][V_BONNET],
		g_vehicle_params[vehicleid][V_BOOT],
		g_vehicle_params[vehicleid][V_OBJECTIVE]
	);
}

stock CreateVehicleLabel(vehicleid, text[], color, Float:x, Float:y, Float:z, Float:drawdistance, testlos = 0, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = STREAMER_3D_TEXT_LABEL_SD)
{
	if(IsValidVehicle(vehicleid))
	{
		SetVehicleData(vehicleid, V_LABEL, CreateDynamic3DTextLabel(text, color, x, y, z, drawdistance, INVALID_PLAYER_ID, vehicleid, testlos, worldid, interiorid, playerid, streamdistance));
	}
	return 1;
}

stock UpdateVehicleLabel(vehicleid, color, text[])
{
	if(IsValidVehicleID(vehicleid))
	{
		if(IsValidDynamic3DTextLabel(GetVehicleData(vehicleid, V_LABEL)))
		{
			UpdateDynamic3DTextLabelText(GetVehicleData(vehicleid, V_LABEL), color, text);
		}
	}
	return 1;
}

stock DestroyVehicleLabel(vehicleid)
{
	if(IsValidVehicleID(vehicleid))
	{
		if(IsValidDynamic3DTextLabel(GetVehicleData(vehicleid, V_LABEL)))
		{
			DestroyDynamic3DTextLabel(GetVehicleData(vehicleid, V_LABEL));
			SetVehicleData(vehicleid, V_LABEL, Text3D: -1);
		}
	}
	return 1;
}
