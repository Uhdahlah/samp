//HARGA
new 
	HargaBensin,
	HargaAnggur, 
	HargaBlueberry, 
	HargaStrawberry, 
	HargaGandum, 
	HargaTomat, 
	FishPrice, 
	ServerMoney;

new 
	ammountsellfish,
	ammountsellwheat,
	ammountsellonion,
	ammountsellcarrot,
	ammountsellpotato,
	ammountsellcorn
;

new 
	StockMaterial,
	StockMarijuana,
	StockTimber,
	StockPlant,
	StockFish,
	StockComponent,
	StockCrack,
	StockCrateFish,
	TimerCrateFish;


new SELLFARM2, SELLFISH;	
new MoneyPickup,
	Text3D:MoneyText,
	Fish1,
	Text3D:Fish2,
	Compo1,
	Text3D:Compo2,
	Text3D:Timber,
	Text3D:Material,
	Text3D:Crack;

CreateServerPoint()
{
	FishStockRefresh();
	ComponentStockRefresh();

	FishPrice = Random(10,75);
	HargaAnggur = Random(9,15);
	HargaBlueberry = Random(9,15);
	HargaStrawberry = Random(9,15);
	HargaGandum = Random(9,15);
	HargaTomat = Random(9,15);
	HargaBensin = Random(100,200);

	if(IsValidDynamic3DTextLabel(Timber))
            DestroyDynamic3DTextLabel(Timber); 

	if(IsValidDynamic3DTextLabel(MoneyText))
            DestroyDynamic3DTextLabel(MoneyText);

	if(IsValidDynamicPickup(MoneyPickup))
		DestroyDynamicPickup(MoneyPickup);
		
	//Server Money
	new strings[1024];

	//Fish Price
	DestroyDynamicObject(SELLFISH);
	new String3[212];
	SELLFISH = CreateDynamicObject(18244, 2843.075195, -1516.672241, 16.355049, 88.599990, 89.999992, 0.000000, -1, -1, -1, 300.00, 300.00); 
	format(String3,sizeof(String3),""PURPLE_E2"Fish Factory\n"WHITE_E"Fish Price: \n"GREEN_E"$0.%s"WHITE_E"/lb", FormatMoney(FishPrice));
	SetDynamicObjectMaterialText(SELLFISH, 0, String3, 130, "Arial", 40, 1, 0xFFFFFFFF, 0xFF000000, 1);
	//Plant Farmer
	DestroyDynamicObject(SELLFARM2);
	//Tanaman
	new String2[212];
	SELLFARM2 = CreateDynamicObject(18244, -371.336853, -1427.711547, 30.534753, 93.300041, -0.499999, -90.200012);
	format(String2,sizeof(String2),""PURPLE_E2"Plant Price\n{FFFFFF}Wheat: "GREEN_E"$0.%s"WHITE_E"\nOnion: "GREEN_E"$0.%s"WHITE_E"\nCarrot: "GREEN_E"$0.%s"WHITE_E"\nPotato: "GREEN_E"$0.%s"WHITE_E"\nCorn: "GREEN_E"$0.%s"WHITE_E"", FormatMoney(HargaAnggur), FormatMoney(HargaBlueberry), FormatMoney(HargaStrawberry), FormatMoney(HargaGandum), FormatMoney(HargaTomat));
	SetDynamicObjectMaterialText(SELLFARM2, 0, String2, 100, "Arial", 25, 1, 0xFFFFFFFF, 0xFF000000, 1);

	CreateDynamicPickup(1239, 23, -1426.0400,-1526.8910,101.7479, -1);
	format(strings, sizeof(strings), "== [Timber Storage] ==\n"YELLOW_E"/lumber unload - "WHITE_E"untuk menjual semua kayu\n"GREEN_E"%d", StockTimber);
	Timber = CreateDynamic3DTextLabel(strings, COLOR_ARWIN, -1426.0400,-1526.8910,101.7479, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Plate

	ammountsellfish = 0;
	ammountsellonion = 0;
	ammountsellwheat = 0;
	ammountsellcarrot = 0;
	ammountsellpotato = 0;
	ammountsellcorn = 0;
	StockCrateFish = 10;
	TimerCrateFish = 10;
}

Server_Percent(price)
{
    return floatround((float(price) / 100) * 85);
}

Server_AddPercent(price)
{
    new money = (price - Server_Percent(price));
    ServerMoney = ServerMoney + money;
    Server_Save();
}

Server_AddMoney(amount)
{
    ServerMoney = ServerMoney + amount;
    Server_Save();
}

Server_MinMoney(amount)
{
    ServerMoney -= amount;
    Server_Save();
}

Server_Save()
{
    new str[2024];

	CreateServerPoint();
    format(str, sizeof(str), "UPDATE server SET component='%d', fishstock='%d', timber='%d', crack='%d', material='%d' WHERE id=0",
	StockComponent,
	StockFish,
	StockTimber,
	StockCrack,
	StockMaterial
	);
    return mysql_tquery(g_SQL, str);
}

function LoadServer()
{
	cache_get_value_name_int(0, "component", StockComponent);
	cache_get_value_name_int(0, "fishstock", StockFish);
	cache_get_value_name_int(0, "timber", StockTimber);
	cache_get_value_name_int(0, "crack", StockCrack);
	cache_get_value_name_int(0, "material", StockMaterial);
	CreateServerPoint();
}

FishStockRefresh()
{
	new strings[212];
	if(IsValidDynamicPickup(Fish1))
		DestroyDynamicPickup(Fish1);

	if(IsValidDynamic3DTextLabel(Fish2))
            DestroyDynamic3DTextLabel(Fish2); 
			//Crate Fish
	Fish1 = CreateDynamicPickup(1271, 23, 2836.3945,-1541.1984,11.0991, -1);
	format(strings, sizeof(strings), "{00FFFF}Canned Fish Crates\n"WHITE_E"Use "YELLOW_E"'/getcrate' "WHITE_E"to pickup crate\nFish Available: "GREEN_E"%d "YELLOW_E"/ 50000", StockFish);
	Fish2 = CreateDynamic3DTextLabel(strings, COLOR_ARWIN, 2836.3945,-1541.1984,11.0991, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Plate
}

ComponentStockRefresh()
{
	if(IsValidDynamicPickup(Compo1))
		DestroyDynamicPickup(Compo1);

	if(IsValidDynamic3DTextLabel(Compo2))
            DestroyDynamic3DTextLabel(Compo2); 
	new strings[212];
	Compo1 = CreateDynamicPickup(2969, 23, 854.5825,-605.2015,18.4219, -1);
	format(strings, sizeof(strings), "{00FFFF}Component Factory\n"WHITE_E"Price: "GREEN_E"$0.50 "WHITE_E"/ unit\n"WHITE_E"Stock: "GREEN_E"%d "YELLOW_E"/ 50000\n"WHITE_E"Use '"YELLOW_E"/buycomponent"WHITE_E"' to buy components", StockComponent);
	Compo2 = CreateDynamic3DTextLabel(strings, COLOR_WHITE, 854.5825,-605.2015,18.4219, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Plate
}
