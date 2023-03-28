#define MAX_DEALERSHIPVEHICLES 10
#define MAX_CARDEALERSHIPS 8
#define DIALOG_CDCHANGETYPE 1339
#define DIALOG_CDEDIT 1329
#define DIALOG_CDTILL 1327
#define DIALOG_CDEDITCARS 1326
#define DIALOG_CDEDITPARK 1322
#define DIALOG_CDNEWVEH 1320
#define DIALOG_CDRADIUS 1319
#define DIALOG_CDNAME 1318
#define DIALOG_CDPRICE 1317
#define DIALOG_CDBUY 1316
#define DIALOG_CDWITHDRAW 1315
#define DIALOG_CDDEPOSIT 1314
#define DIALOG_CDSELL 1313
#define DIALOG_CDNEWVEHBIKE 2313
#define DIALOG_CDNEWVEHSUV 2314
#define DIALOG_CDNEWVEHPICKUP 2315
#define DIALOG_CDNEWVEHLOWRIDERS 2316
#define DIALOG_CDNEWVEHSALOONS 2317
#define DIALOG_CDNEWVEHSPORT 2318
#define COLOR_REALRED 0xFF0606FF
//DEALER
enum cdInfo
{
	cdID,
    cdOwned,
	cdOwner[MAX_PLAYER_NAME],
	cdOwnerId,
	Float: cdEntranceX,
	Float: cdEntranceY,
	Float: cdEntranceZ,
	Float: cdExitX,
	Float: cdExitY,
	Float: cdExitZ,
	cdMessage[128],
	cdTill,
	cdInterior,
	Float: cdRadius,
	cdPrice,
	cdType,
	cdPickupID,
	Text3D:cdTextLabel,
	Text3D:cdVehicleLabel[MAX_DEALERSHIPVEHICLES],
	cdVehicleDBID[MAX_DEALERSHIPVEHICLES],
	cdVehicleModel[MAX_DEALERSHIPVEHICLES],
	cdVehicleCost[MAX_DEALERSHIPVEHICLES],
	cdVehicleId[MAX_DEALERSHIPVEHICLES],
	Float: cdVehicleSpawnX[MAX_DEALERSHIPVEHICLES],
	Float: cdVehicleSpawnY[MAX_DEALERSHIPVEHICLES],
	Float: cdVehicleSpawnZ[MAX_DEALERSHIPVEHICLES],
	Float: cdVehicleSpawnAngle[MAX_DEALERSHIPVEHICLES],
	Float: cdVehicleSpawn[4],
};
new CarDealershipInfo[MAX_CARDEALERSHIPS][cdInfo];

IsVIPModel(carid)
{
	new Cars[] = { 451, 541, 411, 429, 522, 444, 556, 557 };
	for(new i = 0; i < sizeof(Cars); i++)
	{
		if(GetVehicleModel(carid) == Cars[i]) return 1;
	}
	return 0;
}

//DEALER
function LoadcDealerships()
{
	new rows = cache_num_rows(), owner[128], name[128], queryBuffer[212];
 	if(rows)
  	{
		for(new id; id < rows; id++)
		{
			cache_get_value_name_int(id, "ID", CarDealershipInfo[id][cdID]);
			cache_get_value_name(id, "owner", owner);
			format(CarDealershipInfo[id][cdOwner], 128, owner);
			cache_get_value_name(id, "name", name);
			format(CarDealershipInfo[id][cdMessage], 128, name);
			cache_get_value_name_float(id, "entrancex", CarDealershipInfo[id][cdEntranceX]);
			cache_get_value_name_float(id, "entrancey", CarDealershipInfo[id][cdEntranceY]);
			cache_get_value_name_float(id, "entrancez", CarDealershipInfo[id][cdEntranceZ]);
			cache_get_value_name_int(id, "till", CarDealershipInfo[id][cdTill]);
			cache_get_value_name_int(id, "interior", CarDealershipInfo[id][cdInterior]);
			cache_get_value_name_float(id, "vehiclespawnx", CarDealershipInfo[id][cdVehicleSpawn][0]);
			cache_get_value_name_float(id, "vehiclespawny", CarDealershipInfo[id][cdVehicleSpawn][1]);
			cache_get_value_name_float(id, "vehiclespawnz", CarDealershipInfo[id][cdVehicleSpawn][2]);
			cache_get_value_name_float(id, "vehiclespawna", CarDealershipInfo[id][cdVehicleSpawn][3]);
			cache_get_value_name_float(id, "radius", CarDealershipInfo[id][cdRadius]);
			cache_get_value_name_int(id, "price", CarDealershipInfo[id][cdPrice]);
			cache_get_value_name_int(id, "type", CarDealershipInfo[id][cdType]);
			for (new j = 0; j < 10; j ++)
			{
				format(queryBuffer, 24, "vehiclex%d", j);
				cache_get_value_name_float(id, queryBuffer, CarDealershipInfo[id][cdVehicleSpawnX][j]);

				format(queryBuffer, 24, "vehicley%d", j);
				cache_get_value_name_float(id, queryBuffer, CarDealershipInfo[id][cdVehicleSpawnY][j]);

				format(queryBuffer, 24, "vehiclez%d", j);
				cache_get_value_name_float(id, queryBuffer, CarDealershipInfo[id][cdVehicleSpawnZ][j]);

				format(queryBuffer, 24, "vehiclea%d", j);
				cache_get_value_name_float(id, queryBuffer, CarDealershipInfo[id][cdVehicleSpawnAngle][j]);

				format(queryBuffer, 24, "vehicleprice%d", j);
				cache_get_value_name_int(id, queryBuffer, CarDealershipInfo[id][cdVehicleCost][j]);

				format(queryBuffer, 24, "vehiclemodel%d", j);
				cache_get_value_name_int(id, queryBuffer, CarDealershipInfo[id][cdVehicleModel][j]);
			}
			CreateDealershipPickup(id);
			// mysql_format(g_SQL, queryBuffer, sizeof(queryBuffer), "SELECT * FROM vehicledealer WHERE IDdealership = %d", CarDealershipInfo[id][cdID]);
			// mysql_tquery(g_SQL, queryBuffer, "SQL_LoadDealerVehicle", "i", id);
		}
		printf("*** [Database: Loaded] dealership data (%d count).", rows);
	}
}

forward SQL_LoadDealerVehicle(dealershipid);
public SQL_LoadDealerVehicle(dealershipid)
{
	new String[500];
	new rows = cache_num_rows();
 	if(rows)
  	{
		for(new fv; fv < rows; fv++)
		{
			cache_get_value_name_int(fv, "id", CarDealershipInfo[dealershipid][cdVehicleDBID][fv]);
			cache_get_value_name_float(fv, "vehiclespawnx", CarDealershipInfo[dealershipid][cdVehicleSpawnX][fv]);
			cache_get_value_name_float(fv, "vehiclespawny", CarDealershipInfo[dealershipid][cdVehicleSpawnY][fv]);
			cache_get_value_name_float(fv, "vehiclespawnz", CarDealershipInfo[dealershipid][cdVehicleSpawnZ][fv]);
			cache_get_value_name_float(fv, "vehiclespawna", CarDealershipInfo[dealershipid][cdVehicleSpawnAngle][fv]);
			cache_get_value_name_int(fv, "vehiclecost", CarDealershipInfo[dealershipid][cdVehicleCost][fv]);
			cache_get_value_name_int(fv, "vehicletype", CarDealershipInfo[dealershipid][cdVehicleModel][fv]);
			new carcreated = AddStaticVehicle(CarDealershipInfo[dealershipid][cdVehicleModel][fv], CarDealershipInfo[dealershipid][cdVehicleSpawnX][fv], CarDealershipInfo[dealershipid][cdVehicleSpawnY][fv], CarDealershipInfo[dealershipid][cdVehicleSpawnZ][fv], CarDealershipInfo[dealershipid][cdVehicleSpawnAngle][fv], -1, -1);
			format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",fv, GetVehicleName(carcreated), FormatMoney(CarDealershipInfo[dealershipid][cdVehicleCost][fv]));
			CarDealershipInfo[dealershipid][cdVehicleLabel][fv] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,8.0,INVALID_PLAYER_ID,carcreated);
			CarDealershipInfo[dealershipid][cdVehicleId][fv] = carcreated;
			SetVehicleNumberPlate(carcreated,""GREEN_E"DEALER");
		}
		printf("[Vehicle Dealership] Number of Loaded: %d.", rows);
	}
	return 1;
}

// SaveCarDealership(id, fv)
// {
// 	new query[2248];
// 	printf("[system] Menyimpan Car Dealership ID %d CD %d", CarDealershipInfo[id][cdVehicleDBID][fv], CarDealershipInfo[id][cdID]);
// 	mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicledealer SET vehiclespawnx=%f, vehiclespawny=%f, vehiclespawnz=%f, vehiclespawna=%f, vehicletype=%d, vehiclecost=%d WHERE id=%d", CarDealershipInfo[id][cdVehicleSpawnX][fv], CarDealershipInfo[id][cdVehicleSpawnY][fv], CarDealershipInfo[id][cdVehicleSpawnZ][fv], CarDealershipInfo[id][cdVehicleSpawnAngle][fv], CarDealershipInfo[id][cdVehicleModel][fv], CarDealershipInfo[id][cdVehicleCost][fv], CarDealershipInfo[id][cdVehicleDBID][fv]);
// 	return mysql_tquery(g_SQL, query);	
// }

SavecDealership(id)
{
	new cQuery[5000];
	for (new i = 0; i < 10; i ++)
	{
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "UPDATE cd SET ");
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%sowner = '%s', ", cQuery, CarDealershipInfo[id][cdOwner]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%sownerid = '%s', ", cQuery, CarDealershipInfo[id][cdOwnerId]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%sname = '%s', ", cQuery, CarDealershipInfo[id][cdMessage]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%sentrancex = '%f', ", cQuery, CarDealershipInfo[id][cdEntranceX]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%sentrancey = '%f', ", cQuery, CarDealershipInfo[id][cdEntranceY]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%sentrancez = '%f', ", cQuery, CarDealershipInfo[id][cdEntranceZ]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%still = '%d', ", cQuery, CarDealershipInfo[id][cdTill]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%sinterior = '%d', ", cQuery, CarDealershipInfo[id][cdInterior]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclespawnx = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawn][0]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclespawny = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawn][1]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclespawnz = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawn][2]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclespawna = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawn][3]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%sradius = '%f', ", cQuery, CarDealershipInfo[id][cdRadius]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%sprice = '%d', ", cQuery, CarDealershipInfo[id][cdPrice]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%stype = '%d', ", cQuery, CarDealershipInfo[id][cdType]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclex0 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnX][0]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehicley0 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnY][0]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclez0 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnZ][0]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclea0 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnAngle][0]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehicleprice0 = '%d', ", cQuery, CarDealershipInfo[id][cdVehicleCost][0]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclemodel0 = '%d', ", cQuery, CarDealershipInfo[id][cdVehicleModel][0]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclex1 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnX][1]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehicley1 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnY][1]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclez1 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnZ][1]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclea1 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnAngle][1]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehicleprice1 = '%d', ", cQuery, CarDealershipInfo[id][cdVehicleCost][1]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclemodel1 = '%d', ", cQuery, CarDealershipInfo[id][cdVehicleModel][1]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclex2 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnX][2]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehicley2 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnY][2]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclez2 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnZ][2]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclea2 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnAngle][2]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehicleprice2 = '%d', ", cQuery, CarDealershipInfo[id][cdVehicleCost][2]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclemodel2 = '%d', ", cQuery, CarDealershipInfo[id][cdVehicleModel][2]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclex3 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnX][3]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehicley3 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnY][3]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclez3 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnZ][3]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclea3 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnAngle][3]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehicleprice3 = '%d', ", cQuery, CarDealershipInfo[id][cdVehicleCost][3]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclemodel3 = '%d', ", cQuery, CarDealershipInfo[id][cdVehicleModel][3]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclex4 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnX][4]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehicley4 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnY][4]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclez4 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnZ][4]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclea4 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnAngle][4]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehicleprice4 = '%d', ", cQuery, CarDealershipInfo[id][cdVehicleCost][4]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclemodel4 = '%d', ", cQuery, CarDealershipInfo[id][cdVehicleModel][4]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclex5 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnX][5]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehicley5 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnY][5]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclez5 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnZ][5]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclea5 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnAngle][5]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehicleprice5 = '%d', ", cQuery, CarDealershipInfo[id][cdVehicleCost][5]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclemodel5 = '%d', ", cQuery, CarDealershipInfo[id][cdVehicleModel][5]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclex6 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnX][6]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehicley6 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnY][6]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclez6 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnZ][6]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclea6 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnAngle][6]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehicleprice6 = '%d', ", cQuery, CarDealershipInfo[id][cdVehicleCost][6]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclemodel6 = '%d', ", cQuery, CarDealershipInfo[id][cdVehicleModel][6]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclex7 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnX][7]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehicley7 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnY][7]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclez7 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnZ][7]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclea7 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnAngle][7]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehicleprice7 = '%d', ", cQuery, CarDealershipInfo[id][cdVehicleCost][7]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclemodel7 = '%d', ", cQuery, CarDealershipInfo[id][cdVehicleModel][7]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclex8 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnX][8]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehicley8 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnY][8]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclez8 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnZ][8]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclea8 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnAngle][8]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehicleprice8 = '%d', ", cQuery, CarDealershipInfo[id][cdVehicleCost][8]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclemodel8 = '%d', ", cQuery, CarDealershipInfo[id][cdVehicleModel][8]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclex9 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnX][9]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehicley9 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnY][9]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclez9 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnZ][9]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclea9 = '%f', ", cQuery, CarDealershipInfo[id][cdVehicleSpawnAngle][9]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehicleprice9 = '%d', ", cQuery, CarDealershipInfo[id][cdVehicleCost][9]);
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%svehiclemodel9 = '%d' ", cQuery, CarDealershipInfo[id][cdVehicleModel][9]);
		
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s WHERE ID = '%d'", cQuery, CarDealershipInfo[id][cdID]);
		mysql_tquery(g_SQL, cQuery);
    }
	return mysql_tquery(g_SQL, cQuery);
}    

stock CreateCarDealership(playerid, Float: enx, Float: eny, Float: enz, Float: radius, price, type, message[])
{
	new dealershipid = GetFreeCarDealership();
	if(dealershipid == -1) return -1;
	new query_string[1000];

	format(query_string, sizeof(query_string), "INSERT INTO cd (entrancex, entrancey, entrancez, radius, price, type) VALUES (%f, %f, %f, %f, %d, %d)", enx, eny, enz, radius, price, type);
    mysql_tquery(g_SQL, query_string, "cdDealer", "ddffffdds", playerid, dealershipid, enx, eny, enz, radius, price, type, message);	
	
    return dealershipid;
}

function cdDealer(playerid, dealershipid, Float: enx, Float: eny, Float: enz, Float: radius, price, type, message[])
{
	new text_info[128];
	CarDealershipInfo[dealershipid][cdID] = cache_insert_id();
	format(CarDealershipInfo[dealershipid][cdOwner], 128, "-");
	CarDealershipInfo[dealershipid][cdEntranceX] = enx;
	CarDealershipInfo[dealershipid][cdEntranceY] = eny;
	CarDealershipInfo[dealershipid][cdEntranceZ] = enz;
	CarDealershipInfo[dealershipid][cdRadius] = radius;
	CarDealershipInfo[dealershipid][cdPrice] = price;
	CarDealershipInfo[dealershipid][cdType] = type;
	strmid(CarDealershipInfo[dealershipid][cdMessage], message, 0, strlen(message), 255);

	format(text_info, sizeof(text_info), ""YELLOW_E"You have created Dealership ID %d to your position.", dealershipid);
	SendClientMessageEx(playerid, -1, text_info);
    
	new String[525];
	CarDealershipInfo[dealershipid][cdPickupID] = CreateDynamicPickup(1239, 1, CarDealershipInfo[dealershipid][cdEntranceX], CarDealershipInfo[dealershipid][cdEntranceY], CarDealershipInfo[dealershipid][cdEntranceZ]);
	format(String, sizeof(String), "{00FFFF}[id:%d]\n"WHITE_E"This dealership for sale\n{FFFFFF}Price: "GREEN_E"$%s\n"WHITE_E"Use '"YELLOW_E"/buydealership"WHITE_E"' for purchase this dealership",dealershipid, FormatMoney(CarDealershipInfo[dealershipid][cdPrice]));
	CarDealershipInfo[dealershipid][cdTextLabel] = CreateDynamic3DTextLabel(String,COLOR_TWAQUA,CarDealershipInfo[dealershipid][cdEntranceX], CarDealershipInfo[dealershipid][cdEntranceY], CarDealershipInfo[dealershipid][cdEntranceZ]+0.75,3.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,1);
	return 1;
}

stock CreateDealershipPickup(d)
{
	DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdTextLabel]);
	DestroyDynamicPickup(CarDealershipInfo[d][cdPickupID]);
	new String[500];
	if(CarDealershipInfo[d][cdEntranceX] != 0.0 && CarDealershipInfo[d][cdEntranceY] != 0.0)
	{
		CarDealershipInfo[d][cdPickupID] = CreateDynamicPickup(1239, 1, CarDealershipInfo[d][cdEntranceX], CarDealershipInfo[d][cdEntranceY], CarDealershipInfo[d][cdEntranceZ]);
		if(strcmp(CarDealershipInfo[d][cdOwner], "-"))
		{
			format(String, sizeof(String),"{00FFFF}[id:%d]\n{FFFF00}%s\n"YELLOW_E"Owner: "WHITE_E"%s",d, CarDealershipInfo[d][cdMessage], CarDealershipInfo[d][cdOwner]);
			CarDealershipInfo[d][cdTextLabel] = CreateDynamic3DTextLabel(String,COLOR_TWAQUA,CarDealershipInfo[d][cdEntranceX], CarDealershipInfo[d][cdEntranceY], CarDealershipInfo[d][cdEntranceZ]+0.75,3.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,1);
		}
		else
		{
			format(String, sizeof(String), "{00FFFF}[id:%d]\n"WHITE_E"This dealership for sale\n{FFFFFF}Price: "GREEN_E"$%s\n"WHITE_E"Use '"YELLOW_E"/buydealership"WHITE_E"' for purchase this dealership",d, FormatMoney(CarDealershipInfo[d][cdPrice]));
			CarDealershipInfo[d][cdTextLabel] = CreateDynamic3DTextLabel(String,COLOR_TWAQUA,CarDealershipInfo[d][cdEntranceX], CarDealershipInfo[d][cdEntranceY], CarDealershipInfo[d][cdEntranceZ]+0.75,3.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,1);
		}
	}
	for(new fv = 0; fv < 10; fv++)
	{
		DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][fv]);
		DestroyVehicle(CarDealershipInfo[d][cdVehicleId][fv]);
		if(CarDealershipInfo[d][cdVehicleModel][fv] != 0 && CarDealershipInfo[d][cdVehicleSpawnX][fv] != 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][fv] != 0.0)
		{
			new carcreated = AddStaticVehicle(CarDealershipInfo[d][cdVehicleModel][fv], CarDealershipInfo[d][cdVehicleSpawnX][fv], CarDealershipInfo[d][cdVehicleSpawnY][fv], CarDealershipInfo[d][cdVehicleSpawnZ][fv], CarDealershipInfo[d][cdVehicleSpawnAngle][fv], -1, -1);
			format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",fv, GetVehicleName(carcreated), FormatMoney(CarDealershipInfo[d][cdVehicleCost][fv]));
			CarDealershipInfo[d][cdVehicleLabel][fv] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,8.0,INVALID_PLAYER_ID,carcreated);
			CarDealershipInfo[d][cdVehicleId][fv] = carcreated;
			SetVehicleNumberPlate(carcreated,""GREEN_E"DEALER");
		}
		else if(CarDealershipInfo[d][cdVehicleModel][fv] == 0 && CarDealershipInfo[d][cdVehicleSpawnX][fv] != 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][fv] != 0.0)
		{
			format(String, sizeof(String), "[slot:%d]\n"GREEN_E"No vehicle to preview\n"WHITE_E"Use '"YELLOW_E"/dm > Vehicles"WHITE_E"' to display vehicle here",fv);
			CarDealershipInfo[d][cdVehicleLabel][fv] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,CarDealershipInfo[d][cdVehicleSpawnX][fv], CarDealershipInfo[d][cdVehicleSpawnY][fv], CarDealershipInfo[d][cdVehicleSpawnZ][fv],8.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID);
		}
	}
	return 1;
}

stock DestroyDealershipVehicle(d, fv)
{
	new String[500];
	if(CarDealershipInfo[d][cdVehicleModel][fv] > 0)
	{
		DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][fv]);
		DestroyVehicle(CarDealershipInfo[d][cdVehicleId][fv]);
		new carcreated = AddStaticVehicle(CarDealershipInfo[d][cdVehicleModel][fv], CarDealershipInfo[d][cdVehicleSpawnX][fv], CarDealershipInfo[d][cdVehicleSpawnY][fv], CarDealershipInfo[d][cdVehicleSpawnZ][fv], CarDealershipInfo[d][cdVehicleSpawnAngle][fv], -1, -1);
		format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",fv, GetVehicleName(carcreated), FormatMoney(CarDealershipInfo[d][cdVehicleCost][fv]));
		CarDealershipInfo[d][cdVehicleLabel][fv] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,8.0,INVALID_PLAYER_ID,carcreated);
		CarDealershipInfo[d][cdVehicleId][fv] = carcreated;
		SetVehicleNumberPlate(carcreated,""GREEN_E"DEALER");
	}
	else if(CarDealershipInfo[d][cdVehicleModel][fv] == 0)
	{
		DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][fv]);
		DestroyVehicle(CarDealershipInfo[d][cdVehicleId][fv]);
		format(String, sizeof(String), "[slot:%d]\n"GREEN_E"No vehicle to preview\n"WHITE_E"Use '"YELLOW_E"/dm > Vehicles"WHITE_E"' to display vehicle here",fv);
		CarDealershipInfo[d][cdVehicleLabel][fv] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,CarDealershipInfo[d][cdVehicleSpawnX][fv], CarDealershipInfo[d][cdVehicleSpawnY][fv], CarDealershipInfo[d][cdVehicleSpawnZ][fv],8.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID);
	}
	return 1;
}

stock DestroyCarDealership(dealershipid)
{
	new string[30], query[128];
	CarDealershipInfo[dealershipid][cdEntranceX] = 0.0;
	CarDealershipInfo[dealershipid][cdEntranceY] = 0.0;
	CarDealershipInfo[dealershipid][cdEntranceZ] = 0.0;
	CarDealershipInfo[dealershipid][cdRadius] = 0.0;
	CarDealershipInfo[dealershipid][cdTill] = 0;
	CarDealershipInfo[dealershipid][cdOwned] = 0;
	CarDealershipInfo[dealershipid][cdPrice] = 0;
	CarDealershipInfo[dealershipid][cdType] = 0;
	format(string, sizeof(string), "-");
	strmid(CarDealershipInfo[dealershipid][cdOwner], string, 0, strlen(string), 255);
	format(string, sizeof(string), "None");
	strmid(CarDealershipInfo[dealershipid][cdMessage], string, 0, strlen(string), 255);
	DestroyDynamic3DTextLabel(CarDealershipInfo[dealershipid][cdTextLabel]);
	DestroyDynamicPickup(CarDealershipInfo[dealershipid][cdPickupID]);
	CarDealershipInfo[dealershipid][cdPickupID] = 0;
	CarDealershipInfo[dealershipid][cdTextLabel] = Text3D:INVALID_3DTEXT_ID;
	CarDealershipInfo[dealershipid][cdVehicleSpawn][0] = 0.0;
    CarDealershipInfo[dealershipid][cdVehicleSpawn][1] = 0.0;
    CarDealershipInfo[dealershipid][cdVehicleSpawn][2] = 0.0;
    CarDealershipInfo[dealershipid][cdVehicleSpawn][3] = 0.0;
	for(new v = 0; v < MAX_DEALERSHIPVEHICLES; v++)
	{
		if(CarDealershipInfo[dealershipid][cdVehicleModel][v] != 0)
		{
	        DestroyCarDealershipVehicle(dealershipid, v);
		}
	}
	mysql_format(g_SQL, query, sizeof(query), "DELETE FROM cd WHERE ID=%d", CarDealershipInfo[dealershipid][cdID]);
	mysql_tquery(g_SQL, query);
}

stock GetFreeCarDealership()
{
    new
		i = 0;
	while (i < MAX_CARDEALERSHIPS && CarDealershipInfo[i][cdEntranceX] != 0.0 && CarDealershipInfo[i][cdEntranceY] != 0.0)
	{
		i++;
	}
	if(i == MAX_CARDEALERSHIPS) return -1;
	return i;

}

stock SellCarDealership(dealershipid)
{
	CarDealershipInfo[dealershipid][cdOwned] = 0;
	CarDealershipInfo[dealershipid][cdVehicleSpawn][0] = 0.0;
	CarDealershipInfo[dealershipid][cdVehicleSpawn][1] = 0.0;
	CarDealershipInfo[dealershipid][cdVehicleSpawn][2] = 0.0;
	CarDealershipInfo[dealershipid][cdVehicleSpawn][3] = 0.0;
	strmid(CarDealershipInfo[dealershipid][cdOwner], "-", 0, MAX_PLAYER_NAME, 255);
	new String[1024];
	format(String, sizeof(String), "{00FFFF}[id:%d]\n"WHITE_E"This dealership for sale\n{FFFFFF}Price: "GREEN_E"$%s\n"WHITE_E"Use '"YELLOW_E"/buydealership"WHITE_E"' for purchase this dealership",dealershipid, FormatMoney(CarDealershipInfo[dealershipid][cdPrice]));
	UpdateDynamic3DTextLabelText(CarDealershipInfo[dealershipid][cdTextLabel], COLOR_TWAQUA, String);
	SavecDealership(dealershipid);
}

stock IsPlayerOwnerOfCD(playerid)
{
	for(new d = 0; d < MAX_CARDEALERSHIPS; d++)
    {
	    if(strcmp(CarDealershipInfo[d][cdOwner], pData[playerid][pName], true ) == 0)
	    {
			return d;
		}
	}
}
stock IsPlayerOwnerOfCDEx(playerid, id)
{
   if(!IsPlayerConnected(playerid)) return 0;
   if(id == -1) return 0;
   if(!strcmp(CarDealershipInfo[id][cdOwner], pData[playerid][pName], true)) return 1;
   return 0;
}

stock CreateCarDealershipVehicle(playerid, dealershipid, modelid, Float: x, Float: y, Float: z, Float: a, price)
{
    new cdvehicleid = GetFreeCarDealershipVehicleId(dealershipid);
    new query_string[255];
    if(cdvehicleid == -1) return -1;

	mysql_format(g_SQL, query_string, sizeof(query_string), "INSERT INTO vehicledealer (IDdealership, vehicletype, vehiclecost, vehiclespawnx, vehiclespawny, vehiclespawnz, vehiclespawna) VALUES (%d, %d, %d, %f, %f, %f, %f)", CarDealershipInfo[dealershipid][cdID], modelid, price, x, y, z, a);
	mysql_tquery(g_SQL, query_string, "Vehicle_Dealer", "dddddffff", playerid, dealershipid, cdvehicleid, modelid, price, x, y, z, a);			

    return cdvehicleid;
}

forward Vehicle_Dealer(playerid, dealershipid, cdvehicleid, modelid, price, x, y, z, a);
public Vehicle_Dealer(playerid, dealershipid, cdvehicleid, modelid, price, x, y, z, a)
{
	CarDealershipInfo[dealershipid][cdVehicleDBID][cdvehicleid] = cache_insert_id();
	CarDealershipInfo[dealershipid][cdVehicleModel][cdvehicleid] = modelid;
    CarDealershipInfo[dealershipid][cdVehicleCost][cdvehicleid] = price;
    CarDealershipInfo[dealershipid][cdVehicleSpawnX][cdvehicleid] = x;
    CarDealershipInfo[dealershipid][cdVehicleSpawnY][cdvehicleid] = y;
    CarDealershipInfo[dealershipid][cdVehicleSpawnZ][cdvehicleid] = z;
    CarDealershipInfo[dealershipid][cdVehicleSpawnAngle][cdvehicleid] = a;

	SavecDealership(dealershipid);
	return 1;
}

stock DestroyCarDealershipVehicle(dealershipid, cdvehicleid)
{
	new query[128];
    CarDealershipInfo[dealershipid][cdVehicleModel][cdvehicleid] = 0;
    CarDealershipInfo[dealershipid][cdVehicleCost][cdvehicleid] = 0;
    CarDealershipInfo[dealershipid][cdVehicleSpawnX][cdvehicleid] = 0.0;
    CarDealershipInfo[dealershipid][cdVehicleSpawnY][cdvehicleid] = 0.0;
    CarDealershipInfo[dealershipid][cdVehicleSpawnZ][cdvehicleid] = 0.0;
    CarDealershipInfo[dealershipid][cdVehicleSpawnAngle][cdvehicleid] = 0.0;
    DestroyDynamic3DTextLabel(CarDealershipInfo[dealershipid][cdVehicleLabel][cdvehicleid]);
    DestroyVehicle(CarDealershipInfo[dealershipid][cdVehicleId][cdvehicleid]);
    CarDealershipInfo[dealershipid][cdVehicleLabel][cdvehicleid] = Text3D:INVALID_3DTEXT_ID;
    CarDealershipInfo[dealershipid][cdVehicleId][cdvehicleid] = 0;
	mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehicledealer WHERE id=%d", CarDealershipInfo[dealershipid][cdVehicleDBID][cdvehicleid]);
	mysql_tquery(g_SQL, query);
}

stock GetFreeCarDealershipVehicleId(dealershipid)
{
    new
		i = 0;
	while (i < MAX_DEALERSHIPVEHICLES && CarDealershipInfo[dealershipid][cdVehicleModel][i] != 0)
	{
		i++;
	}
	if(i == MAX_DEALERSHIPVEHICLES) return -1;
	return i;

}

IsAVehicleDealerVeh(carid, playerid)
{
	for(new d = 0; d < MAX_CARDEALERSHIPS; d++)
    {
		for(new v = 0; v < MAX_DEALERSHIPVEHICLES; v++) 
		{
			if(carid == CarDealershipInfo[d][cdVehicleId][v] && pData[playerid][pListitems] != 1) return 1;
		}
	}	
	return 0;
}

GetCarDealershipVehicleId(vehicleid)
{
    for(new d = 0; d < MAX_CARDEALERSHIPS; d++)
    {
        for(new v = 0; v < MAX_DEALERSHIPVEHICLES; v++)
        {
            if(vehicleid == CarDealershipInfo[d][cdVehicleId][v])
            {
                return v;
            }
		}
    }
    return 0;
}

stock GetCarDealershipId(vehicleid)
{
    for(new d = 0; d < MAX_CARDEALERSHIPS; d++)
    {
        for(new v = 0; v < MAX_DEALERSHIPVEHICLES; v++)
        {
            if(CarDealershipInfo[d][cdVehicleId][v] == vehicleid)
            {
                return d;
            }
		}
    }
    return -1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    new String[500], string[512], count = 0, found = false;
    if(dialogid == DIALOG_CDEDIT)
	{ // car dealership dialog
		if(response && GetPVarInt(playerid, "editingcd") != -1)
		{
            if(listitem == 0) // My Vehicles
			{
				format(string,sizeof(string),"Vehicle\tCost\n");
				for (new i = 0; i < 10; i ++)
				{
					if(CarDealershipInfo[GetPVarInt(playerid, "editingcd")][cdVehicleModel][i] != 0)
					{
						format(string,sizeof(string),"%s{00FFFF}%s\t"GREEN_E"$%s\n", string, GetVehicleName(CarDealershipInfo[GetPVarInt(playerid, "editingcd")][cdVehicleId][i]),FormatMoney(CarDealershipInfo[GetPVarInt(playerid, "editingcd")][cdVehicleCost][i]));
					}
					else
					{
						format(string, sizeof(string), "%sSpawn\n", string);
					}
					gListedItems[playerid][found] = i;
					found++;
				}
				if(found) 
				{
					ShowPlayerDialog(playerid, DIALOG_CDEDITCARS, DIALOG_STYLE_TABLIST_HEADERS, "Car Dealership:", string, "Edit", "Back");
				}
			}
			else if(listitem == 1) // Till
			{
				new listitems[] = "1 Withdraw\n2 Deposit";
			    ShowPlayerDialog(playerid,DIALOG_CDTILL,DIALOG_STYLE_LIST,"Choose an item to continue", listitems,"Select","Cancel");
			}
			else if(listitem == 2)
			{
				ShowPlayerDialog(playerid, DIALOG_CDNAME, DIALOG_STYLE_INPUT, "Car Dealership:", " Choose the new name:", "Edit", "Back");
			}
		}
		else
		{
			SavecDealership(GetPVarInt(playerid, "editingcd"));
            SetPVarInt(playerid, "editingcd", -1);
		}
	}
	else if(dialogid == DIALOG_CDTILL)
	{ // car dealership dialog
	    if(response && GetPVarInt(playerid, "editingcd") != -1)
		{
            if(listitem == 0) // Withdraw
			{
				format(String, sizeof(String), "{FFFFFF}You have {00FF00}$%s {FFFFFF}in your till account.\nHow much money to withdraw?", FormatMoney(CarDealershipInfo[GetPVarInt(playerid, "editingcd")][cdTill]));
				ShowPlayerDialog(playerid,DIALOG_CDWITHDRAW,DIALOG_STYLE_INPUT,"Withdraw", String,"Select","Cancel");
			}
			else if(listitem == 1) // Deposit
			{
				format(String, sizeof(String), "{FFFFFF}You have {00FF00}$%s {FFFFFF}in your till account.\nHow much money to deposit?", FormatMoney(CarDealershipInfo[GetPVarInt(playerid, "editingcd")][cdTill]));
				ShowPlayerDialog(playerid,DIALOG_CDDEPOSIT,DIALOG_STYLE_INPUT,"Deposit", String,"Select","Cancel");
			}
		}
		else
		{
            SavecDealership(GetPVarInt(playerid, "editingcd"));
            SetPVarInt(playerid, "editingcd", -1);
		}
	}
	else if(dialogid == DIALOG_CDWITHDRAW)
	{ // car dealership dialog
		if(response && GetPVarInt(playerid, "editingcd") != -1)
		{
		    if(IsNumeric(inputtext))
	        {
	             new money = strval(inputtext);
	             if(CarDealershipInfo[GetPVarInt(playerid, "editingcd")][cdTill] < money)
	             {
                     format(String, sizeof(String), "You don't have that much in your till!\n\nYou have $%s in your till account.\n\nHow much money to withdraw?", FormatMoney(CarDealershipInfo[GetPVarInt(playerid, "editingcd")][cdTill]));
				     ShowPlayerDialog(playerid,DIALOG_CDWITHDRAW,DIALOG_STYLE_INPUT,"Withdraw", String,"Select","Cancel");
                     return 1;
	             }
	             CarDealershipInfo[GetPVarInt(playerid, "editingcd")][cdTill] -= money;
	             SetPVarInt(playerid, "Cash", GetPVarInt(playerid, "Cash")+money);
	             GivePlayerMoneyEx(playerid, money);
	             format(String, sizeof(String), "You have successfully withdrawn $%s from your till, new balance: $%s", FormatMoney(money), FormatMoney(CarDealershipInfo[GetPVarInt(playerid, "editingcd")][cdTill]));
	             SendClientMessageEx(playerid, COLOR_GRAD2, String);
	             SavecDealership(GetPVarInt(playerid, "editingcd"));
                 SetPVarInt(playerid, "editingcd", -1);
			}
        }
		else
		{
             SavecDealership(GetPVarInt(playerid, "editingcd"));
             SetPVarInt(playerid, "editingcd", -1);
		}
	}
	else if(dialogid == DIALOG_CDDEPOSIT)
	{ // car dealership dialog
		if(response && GetPVarInt(playerid, "editingcd") != -1)
		{
		    if(IsNumeric(inputtext))
	        {
	             new money = strval(inputtext);
	             if(GetPlayerMoney(playerid) < money)
	             {
                     format(String, sizeof(String), "You don't have that much in your wallet!\n\nYou have $%s in your till account.\n\n\tHow much money to deposit?", FormatMoney(CarDealershipInfo[GetPVarInt(playerid, "editingcd")][cdTill]));
				     ShowPlayerDialog(playerid,DIALOG_CDDEPOSIT,DIALOG_STYLE_INPUT,"Deposit", String,"Select","Cancel");
                     return 1;
	             }
				 //GivePlayerMoneyEx(playerid, -CarDealershipInfo[d][cdPrice]);
	             CarDealershipInfo[GetPVarInt(playerid, "editingcd")][cdTill] += money;
	             SetPVarInt(playerid, "Cash", GetPVarInt(playerid, "Cash")-money);
	             GivePlayerMoneyEx(playerid, -money);
	             format(String, sizeof(String), "You have successfully deposited $%s to your till, new balance: $%s", FormatMoney(money), FormatMoney(CarDealershipInfo[GetPVarInt(playerid, "editingcd")][cdTill]));
	             SendClientMessageEx(playerid, COLOR_GRAD2, String);
	             SavecDealership(GetPVarInt(playerid, "editingcd"));
                 SetPVarInt(playerid, "editingcd", -1);
			}
		}
		else
		{
             SavecDealership(GetPVarInt(playerid, "editingcd"));
             SetPVarInt(playerid, "editingcd", -1);
		}
	}
	else if(dialogid == DIALOG_CDNAME)
	{ // car dealership dialog
		if(response && GetPVarInt(playerid, "editingcd") != -1)
		{
			new d;
			d = GetPVarInt(playerid, "editingcd");
            if(!strlen(inputtext))
			{
			    SendClientMessageEx(playerid, COLOR_LIGHTRED, "** You must type a name **");
    	        ShowPlayerDialog(playerid, DIALOG_CDNAME, DIALOG_STYLE_INPUT, "Car Dealership:", " Choose the new name:", "Edit", "Back");
		        return 1;
			}
			strmid(CarDealershipInfo[d][cdMessage], inputtext, 0, strlen(inputtext), 255);
	        format(String,128,"{00FFFF}[id:%d]\n{FFFF00}%s\n{00FF00}Owner: %s",d, CarDealershipInfo[d][cdMessage], CarDealershipInfo[d][cdOwner]);
	        UpdateDynamic3DTextLabelText(CarDealershipInfo[d][cdTextLabel], COLOR_TWAQUA, String);
	        SavecDealership(GetPVarInt(playerid, "editingcd"));
		}
	}
	else if(dialogid == DIALOG_CDEDITCARS)
	{ // car dealership dialog
		if(response && GetPVarInt(playerid, "editingcd") != -1)
		{
			if(CarDealershipInfo[GetPVarInt(playerid, "editingcd")][cdVehicleModel][gListedItems[playerid][listitem]] == 0)
			{
				pData[playerid][pListitems] = gListedItems[playerid][listitem];
				new listitems[] = "Motorcycle\nSUV\nPickup Vehicles\nLowriders\nSaloons\nSport";
				ShowPlayerDialog(playerid,DIALOG_CDNEWVEH,DIALOG_STYLE_LIST,"Car Dealership:", listitems,"Select","Cancel");
			}
		}
		else
		{
		    new listitems[] = "Vehicles\nDealership - Safes\nChange Name Dealership";
			ShowPlayerDialog(playerid,DIALOG_CDEDIT,DIALOG_STYLE_LIST,"Choose an item to continue", listitems,"Select","Cancel");
		}
	}
	
	else if(dialogid == DIALOG_CDEDITPARK)
	{ // car dealership dialog
		if(response && GetPVarInt(playerid, "editingcd") != -1 && pData[playerid][pListitems] != -1 &&  GetPVarInt(playerid, "editingcdvehpos") == 1 || GetPVarInt(playerid, "editingcdvehnew"))
		{
			new Float: x, Float: y, Float: z, Float: a;
			GetPlayerPos(playerid,x,y,z);
	        GetPlayerFacingAngle(playerid, a);
			new d = GetPVarInt(playerid, "editingcd");
			new v = pData[playerid][pListitems];
			
			if(IsPlayerInRangeOfPoint(playerid, CarDealershipInfo[d][cdRadius], CarDealershipInfo[d][cdEntranceX], CarDealershipInfo[d][cdEntranceY], CarDealershipInfo[d][cdEntranceZ]))
		    {
				CarDealershipInfo[d][cdVehicleSpawnX][v] = x;
				CarDealershipInfo[d][cdVehicleSpawnY][v] = y;
				CarDealershipInfo[d][cdVehicleSpawnZ][v] = z;
				CarDealershipInfo[d][cdVehicleSpawnAngle][v] = a;
				SetPVarInt(playerid, "editingcdvehpos", 0);
				SetPVarInt(playerid, "editingcdvehnew", 0);
				CreateDealershipPickup(d);

				TogglePlayerControllable(playerid, true);
				SavecDealership(d);
			}
			else
			{
				SendClientMessageEx(playerid, COLOR_GREY, "ERROR: You are out of this Car Dealership radius, please try again.");
				TogglePlayerControllable(playerid, true);
			}
		}
		else if(response && GetPVarInt(playerid, "editingcd") != -1 && GetPVarInt(playerid, "editingcdvehpos") == 2)
		{
			new Float: x, Float: y, Float: z, Float: a;
			new d;
			GetPlayerPos(playerid,x,y,z);
	        GetPlayerFacingAngle(playerid, a);
			d = GetPVarInt(playerid, "editingcd");
			if(IsPlayerInRangeOfPoint(playerid, CarDealershipInfo[d][cdRadius], CarDealershipInfo[d][cdEntranceX], CarDealershipInfo[d][cdEntranceY], CarDealershipInfo[d][cdEntranceZ]))
		    {
				CarDealershipInfo[d][cdVehicleSpawn][0] = x;
				CarDealershipInfo[d][cdVehicleSpawn][1] = y;
				CarDealershipInfo[d][cdVehicleSpawn][2] = z;
				CarDealershipInfo[d][cdVehicleSpawn][3] = a;
				SetPVarInt(playerid, "editingcdvehpos", 0);
				TogglePlayerControllable(playerid, true);
				SavecDealership(d);
			}
			else
			{
				SendClientMessageEx(playerid, COLOR_GREY, "ERROR: You are out of this Car Dealership radius, please try again.");
				TogglePlayerControllable(playerid, true);
			}
		}
		else if(!response && GetPVarInt(playerid, "editingcd") != -1 && GetPVarInt(playerid, "editingcdvehpos") == 2)
		{
            TogglePlayerControllable(playerid, true);
			SetPVarInt(playerid, "editingcdvehpos", 0);
		}
	}
	else if(dialogid == DIALOG_CDNEWVEHBIKE)
	{ // car dealership dialog
		if(response && GetPVarInt(playerid, "editingcd") != -1)
		{
			new modelid, d;
			new Float: x, Float: y, Float: z, Float: a;
			new harga;
			d = GetPVarInt(playerid, "editingcd");
			GetPlayerPos(playerid,x,y,z);
	        GetPlayerFacingAngle(playerid, a);
	        
            if(IsPlayerInRangeOfPoint(playerid, CarDealershipInfo[d][cdRadius], CarDealershipInfo[d][cdEntranceX], CarDealershipInfo[d][cdEntranceY], CarDealershipInfo[d][cdEntranceZ]))
	        {
				if(listitem == 0)
				{
					modelid = 461;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					CarDealershipInfo[d][cdTill] -= harga;
					SavecDealership(d);
				}
				else if(listitem == 1)
				{
					modelid = 462;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 2)
				{
					modelid = 463;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 3)
				{
					modelid = 468;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 4)
				{
					modelid = 521;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 5)
				{
					modelid = 581;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
	        }
	        else
	        {
				SendClientMessageEx(playerid, COLOR_GREY, "ERROR: You are out of this Car Dealership radius, please try again.");
				TogglePlayerControllable(playerid, true);
	        }
		}
		else
		{
            TogglePlayerControllable(playerid, true);
			SetPVarInt(playerid, "editingcd", -1);
		}
	}
	else if(dialogid == DIALOG_CDNEWVEHLOWRIDERS)
	{ // car dealership dialog
		if(response && GetPVarInt(playerid, "editingcd") != -1)
		{
			new modelid, d;
			new Float: x, Float: y, Float: z, Float: a;
			new harga;
			d = GetPVarInt(playerid, "editingcd");
			GetPlayerPos(playerid,x,y,z);
	        GetPlayerFacingAngle(playerid, a);
	        
            if(IsPlayerInRangeOfPoint(playerid, CarDealershipInfo[d][cdRadius], CarDealershipInfo[d][cdEntranceX], CarDealershipInfo[d][cdEntranceY], CarDealershipInfo[d][cdEntranceZ]))
	        {
				if(listitem == 0)
				{
					modelid = 412;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 1)
				{
					modelid = 462;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 2)
				{
					modelid = 534;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 3)
				{
					modelid = 535;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 4)
				{
					modelid = 536;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 5)
				{
					modelid = 567;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 6)
				{
					modelid = 575;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 7)
				{
					modelid = 576;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
	        }
	        else
	        {
				SendClientMessageEx(playerid, COLOR_GREY, "ERROR: You are out of this Car Dealership radius, please try again.");
				TogglePlayerControllable(playerid, true);
	        }
		}
		else
		{
            TogglePlayerControllable(playerid, true);
			SetPVarInt(playerid, "editingcd", -1);
		}
	}
	else if(dialogid == DIALOG_CDNEWVEHSALOONS)
	{ // car dealership dialog
		if(response && GetPVarInt(playerid, "editingcd") != -1)
		{
			new modelid, d;
			new Float: x, Float: y, Float: z, Float: a;
			new harga;
			d = GetPVarInt(playerid, "editingcd");
			GetPlayerPos(playerid,x,y,z);
	        GetPlayerFacingAngle(playerid, a);
	        
            if(IsPlayerInRangeOfPoint(playerid, CarDealershipInfo[d][cdRadius], CarDealershipInfo[d][cdEntranceX], CarDealershipInfo[d][cdEntranceY], CarDealershipInfo[d][cdEntranceZ]))
	        {
				if(listitem == 0)
				{
					modelid = 401;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 1)
				{
					modelid = 405;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 2)
				{
					modelid = 410;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 3)
				{
					modelid = 419;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 4)
				{
					modelid = 421;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 5)
				{
					modelid = 426;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 6)
				{
					modelid = 436;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 7)
				{
					modelid = 445;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
                else if(listitem == 8)
				{
					modelid = 466;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
                else if(listitem == 9)
				{
					modelid = 467;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
                else if(listitem == 10)
				{
					modelid = 474;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
                else if(listitem == 11)
				{
					modelid = 491;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
                else if(listitem == 12)
				{
					modelid = 492;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
                else if(listitem == 13)
				{
					modelid = 507;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
                else if(listitem == 14)
				{
					modelid = 516;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
                else if(listitem == 15)
				{
					modelid = 517;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
                else if(listitem == 16)
				{
					modelid = 518;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
                else if(listitem == 17)
				{
					modelid = 526;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
                else if(listitem == 18)
				{
					modelid = 527;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
                else if(listitem == 19)
				{
					modelid = 529;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
                else if(listitem == 20)
				{
					modelid = 540;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
                else if(listitem == 21)
				{
					modelid = 542;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
                else if(listitem == 22)
				{
					modelid = 546;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
                else if(listitem == 23)
				{
					modelid = 547;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
                else if(listitem == 24)
				{
					modelid = 549;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
                else if(listitem == 25)
				{
					modelid = 550;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
                else if(listitem == 26)
				{
					modelid = 551;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
                else if(listitem == 27)
				{
					modelid = 560;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
                else if(listitem == 28)
				{
					modelid = 562;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
                else if(listitem == 29)
				{
					modelid = 585;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
	        }
	        else
	        {
				SendClientMessageEx(playerid, COLOR_GREY, "ERROR: You are out of this Car Dealership radius, please try again.");
				TogglePlayerControllable(playerid, true);
	        }
		}
		else
		{
            TogglePlayerControllable(playerid, true);
			SetPVarInt(playerid, "editingcd", -1);
		}
	}
	else if(dialogid == DIALOG_CDNEWVEHPICKUP)
	{ // car dealership dialog
		if(response && GetPVarInt(playerid, "editingcd") != -1)
		{
			new modelid, d;
			new Float: x, Float: y, Float: z, Float: a;
			new harga;
			d = GetPVarInt(playerid, "editingcd");
			GetPlayerPos(playerid,x,y,z);
	        GetPlayerFacingAngle(playerid, a);
	        
            if(IsPlayerInRangeOfPoint(playerid, CarDealershipInfo[d][cdRadius], CarDealershipInfo[d][cdEntranceX], CarDealershipInfo[d][cdEntranceY], CarDealershipInfo[d][cdEntranceZ]))
	        {
				if(listitem == 0)
				{
					modelid = 600;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 1)
				{
					modelid = 554;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 2)
				{
					modelid = 543;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 3)
				{
					modelid = 478;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 4)
				{
					modelid = 422;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
	        }
	        else
	        {
				SendClientMessageEx(playerid, COLOR_GREY, "ERROR: You are out of this Car Dealership radius, please try again.");
				TogglePlayerControllable(playerid, true);
	        }
		}
		else
		{
            TogglePlayerControllable(playerid, true);
			SetPVarInt(playerid, "editingcd", -1);
		}
	}
	else if(dialogid == DIALOG_CDNEWVEHSPORT)
	{ // car dealership dialog
		if(response && GetPVarInt(playerid, "editingcd") != -1)
		{
			new modelid, d;
			new Float: x, Float: y, Float: z, Float: a;
			new harga;
			d = GetPVarInt(playerid, "editingcd");
			GetPlayerPos(playerid,x,y,z);
	        GetPlayerFacingAngle(playerid, a);
	        
            if(IsPlayerInRangeOfPoint(playerid, CarDealershipInfo[d][cdRadius], CarDealershipInfo[d][cdEntranceX], CarDealershipInfo[d][cdEntranceY], CarDealershipInfo[d][cdEntranceZ]))
	        {
				if(listitem == 0)
				{
					modelid = 402;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 1)
				{
					modelid = 415;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 2)
				{
					modelid = 429;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 3)
				{
					modelid = 475;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 4)
				{
					modelid = 477;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 5)
				{
					modelid = 496;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 6)
				{
					modelid = 558;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 7)
				{
					modelid = 559;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 8)
				{
					modelid = 565;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 9)
				{
					modelid = 587;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 10)
				{
					modelid = 589;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 11)
				{
					modelid = 602;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
	        }
	        else
	        {
				SendClientMessageEx(playerid, COLOR_GREY, "ERROR: You are out of this Car Dealership radius, please try again.");
				TogglePlayerControllable(playerid, true);
	        }
		}
		else
		{
            TogglePlayerControllable(playerid, true);
			SetPVarInt(playerid, "editingcd", -1);
		}
	}
	else if(dialogid == DIALOG_CDNEWVEHSUV)
	{ // car dealership dialog
		if(response && GetPVarInt(playerid, "editingcd") != -1)
		{
			new modelid, d;
			new Float: x, Float: y, Float: z, Float: a;
			new harga;
			d = GetPVarInt(playerid, "editingcd");
			GetPlayerPos(playerid,x,y,z);
	        GetPlayerFacingAngle(playerid, a);
	        
            if(IsPlayerInRangeOfPoint(playerid, CarDealershipInfo[d][cdRadius], CarDealershipInfo[d][cdEntranceX], CarDealershipInfo[d][cdEntranceY], CarDealershipInfo[d][cdEntranceZ]))
	        {
				if(listitem == 0)
				{
					modelid = 413;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 1)
				{
					modelid = 482;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 2)
				{
					modelid = 400;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 3)
				{
					modelid = 579;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 4)
				{
					modelid = 500;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 5)
				{
					modelid = 404;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 6)
				{
					modelid = 418;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 7)
				{
					modelid = 458;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 8)
				{
					modelid = 479;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 9)
				{
					modelid = 561;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
				else if(listitem == 10)
				{
					modelid = 483;
					if(modelid < 400||modelid > 611||modelid == 411||modelid == 415||modelid == 424||modelid == 434||modelid == 451||modelid == 494||modelid == 502||modelid == 503||modelid == 495||modelid == 506||modelid == 503)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "ID Kendaraan tidak diperbolehkan!");
						return 1;
					}
					if(CarDealershipInfo[d][cdTill] >= GetVehicleDealerCost(modelid))
					{
						harga = GetVehicleDealerCost(modelid);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "Anda harus mempunyai modal sebesar "GREEN_E"$%s", FormatMoney(GetVehicleDealerCost(modelid)));
						return 1;
					}
					new cdvehicleid = pData[playerid][pListitems];
					DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][cdvehicleid]);
					if(CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] == 0.0 && CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] == 0.0)
					{
						new vehicleid = CreateVehicle(modelid, x, y, z, a, -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid] = x;
						CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid] = y;
						CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid] = z;
						CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid] = a;
						PutPlayerInVehicle(playerid, vehicleid, 0);
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					else
					{
						new vehicleid = CreateVehicle(modelid, CarDealershipInfo[d][cdVehicleSpawnX][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnY][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnZ][cdvehicleid], CarDealershipInfo[d][cdVehicleSpawnAngle][cdvehicleid], -1, -1, 6);
						CarDealershipInfo[d][cdVehicleId][cdvehicleid] = vehicleid;
						CarDealershipInfo[d][cdVehicleModel][cdvehicleid] = modelid;
						CarDealershipInfo[d][cdVehicleCost][cdvehicleid] = harga;
						
						format(String, sizeof(String), "[slot:%d]\n{00FFFF}%s\n"WHITE_E"Price: "GREEN_E"$%s\n"WHITE_E"Fuel Capacity: "YELLOW_E"100.0\n"WHITE_E"Fuel Total: "YELLOW_E"100.0",cdvehicleid, GetVehicleName(vehicleid), FormatMoney(CarDealershipInfo[d][cdVehicleCost][cdvehicleid]));
						CarDealershipInfo[d][cdVehicleLabel][cdvehicleid] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,0.0, 0.0, 0.0,5.0,INVALID_PLAYER_ID,vehicleid,1);
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "You have created Car Dealership ID %d for Dealership ID %d to your position.", cdvehicleid, d);
					SavecDealership(d);
					CarDealershipInfo[d][cdTill] -= harga;
				}
	        }
	        else
	        {
				SendClientMessageEx(playerid, COLOR_GREY, "ERROR: You are out of this Car Dealership radius, please try again.");
				TogglePlayerControllable(playerid, true);
	        }
		}
		else
		{
            TogglePlayerControllable(playerid, true);
			SetPVarInt(playerid, "editingcd", -1);
		}
	}
	else if(dialogid == DIALOG_CDNEWVEH)
	{ // car dealership dialog
		if(response && GetPVarInt(playerid, "editingcd") != -1)
		{
			if(listitem == 0) // Motorcycle
			{
				ShowPlayerSelectionMenu(playerid, MODEL_SELECTION_Motorcycle, "Dealership Vehicle:", dmvehicle1, sizeof(dmvehicle1));
			}	
			else if(listitem == 1) // SUV
			{
				ShowPlayerSelectionMenu(playerid, MODEL_SELECTION_SUV, "Dealership Vehicle:", dmvehicle2, sizeof(dmvehicle2));
			}	
			else if(listitem == 2) // Pickup Vehicles
			{
				ShowPlayerSelectionMenu(playerid, MODEL_SELECTION_PickupVehicles, "Dealership Vehicle:", dmvehicle3, sizeof(dmvehicle3));
			}	
			else if(listitem == 3) // Lowriders
			{
				ShowPlayerSelectionMenu(playerid, MODEL_SELECTION_Lowriders, "Dealership Vehicle:", dmvehicle4, sizeof(dmvehicle4));
			}	
			else if(listitem == 4) // Saloons
			{
				ShowPlayerSelectionMenu(playerid, MODEL_SELECTION_Saloons, "Dealership Vehicle:", dmvehicle5, sizeof(dmvehicle5));
			}	
			else if(listitem == 5) // Sport
			{
				ShowPlayerSelectionMenu(playerid, MODEL_SELECTION_Sport, "Dealership Vehicle:", dmvehicle6, sizeof(dmvehicle6));
			}	
	        else
	        {
				SendClientMessageEx(playerid, COLOR_GREY, "ERROR: You are out of this Car Dealership radius, please try again.");
				TogglePlayerControllable(playerid, true);
	        }
		}
		else
		{
            TogglePlayerControllable(playerid, true);
			SetPVarInt(playerid, "editingcd", -1);
		}
	}
	else if(dialogid == DIALOG_CDBUY)
	{

	    // Account Eating Bug Fix
	    if(!IsPlayerInAnyVehicle(playerid))
		{
		    TogglePlayerControllable(playerid, 1);
			SendClientMessageEx(playerid,COLOR_GRAD2,"You need to be in the vehicle you wish to purchase.");
			return 1;
		}

		new vehicleid = GetPlayerVehicleID(playerid);
		new v = GetCarDealershipVehicleId(vehicleid);
		new d = GetCarDealershipId(vehicleid);
		if(response)
		{
            if(CarDealershipInfo[d][cdVehicleSpawn][0] == 0.0 && CarDealershipInfo[d][cdVehicleSpawn][1] == 0.0 && CarDealershipInfo[d][cdVehicleSpawn][2] == 0.0)
            {
				SendClientMessageEx(playerid, COLOR_GRAD1, "ERROR: The owner of this Car Dealership hasn't set the purchased vehicles spawn point.");
				RemovePlayerFromVehicle(playerid);
				new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz+1.2);
				TogglePlayerControllable(playerid, 1);
				return 1;
            }
            if(IsVIPModel(vehicleid) && (pData[playerid][pVip] == 0))
            {
                SendClientMessageEx(playerid, COLOR_GREY, "ERROR: Only VIP's can own that type of vehicles.");
                RemovePlayerFromVehicle(playerid);
                new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz+1.2);
                TogglePlayerControllable(playerid, 1);
                return 1;
            }
			new slotflat, slothouse1, slothouse2;
			if(pData[playerid][pFlatOwner] == -1)  slotflat = 0;
			else if(pData[playerid][pFlatOwner] > -1) slotflat = 1;
			if(pData[playerid][pHouseOwner1] == -1) slothouse1 = 0;
			else if (pData[playerid][pHouseOwner1] > -1) slothouse1 = 1;
			if(pData[playerid][pHouseOwner2] == -1) slothouse2 = 0;
			else if (pData[playerid][pHouseOwner2] > -1) slothouse2 = 1;
			new limit = MAX_PLAYER_VEHICLE + slotflat + slothouse1 + slothouse2 + pData[playerid][pVip];
			foreach(new ii : PVehicles)
			{
				if(pvData[ii][cOwner] == pData[playerid][pID] && pvData[ii][cClaim] != 1)
					count++;
			}
			if(count >= limit)
			{
				SendClientMessageEx(playerid, COLOR_GREY, "ERROR: Slot kendaraan anda penuh");
                RemovePlayerFromVehicle(playerid);
                new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz+1.2);
                TogglePlayerControllable(playerid, 1);
				return 1;
			}
		    new randcolor1 = Random(0, 126);
		    new randcolor2 = Random(0, 126);
		    SetPlayerPos(playerid, CarDealershipInfo[d][cdVehicleSpawn][0], CarDealershipInfo[d][cdVehicleSpawn][1], CarDealershipInfo[d][cdVehicleSpawn][2]+2);
		    TogglePlayerControllable(playerid, 1);
		    new cost;
		    cost = CarDealershipInfo[d][cdVehicleCost][v];
	        if(GetPlayerMoney(playerid) < CarDealershipInfo[d][cdVehicleCost][v])
	        {
				SendClientMessageEx(playerid, COLOR_GRAD1, "ERROR: You don't have enough money to buy this.");
				RemovePlayerFromVehicle(playerid);
				return 1;
			}
            GivePlayerMoneyEx(playerid, -CarDealershipInfo[d][cdVehicleCost][v]);
		    CarDealershipInfo[d][cdTill] += ((CarDealershipInfo[d][cdVehicleCost][v]*5)/100)+CarDealershipInfo[d][cdVehicleCost][v];
      		new cQuery[1024];
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], CarDealershipInfo[d][cdVehicleModel][v], randcolor1, randcolor2, cost, CarDealershipInfo[d][cdVehicleSpawn][0], CarDealershipInfo[d][cdVehicleSpawn][1], CarDealershipInfo[d][cdVehicleSpawn][2], CarDealershipInfo[d][cdVehicleSpawn][3]);
			mysql_tquery(g_SQL, cQuery, "OnVehBuyPV", "ddddddffff", playerid, pData[playerid][pID], CarDealershipInfo[d][cdVehicleModel][v], randcolor1, randcolor2, cost, CarDealershipInfo[d][cdVehicleSpawn][0], CarDealershipInfo[d][cdVehicleSpawn][1], CarDealershipInfo[d][cdVehicleSpawn][2], CarDealershipInfo[d][cdVehicleSpawn][3]);
            //Plate
			DestroyVehicle(CarDealershipInfo[d][cdVehicleId][v]);
			DestroyDynamic3DTextLabel(CarDealershipInfo[d][cdVehicleLabel][v]);
			CarDealershipInfo[d][cdVehicleId][v] = 0;
			CarDealershipInfo[d][cdVehicleModel][v] = 0;
    		CarDealershipInfo[d][cdVehicleCost][v] = 0;
			format(String, sizeof(String), "[slot:%d]\n"GREEN_E"No vehicle to preview\n"WHITE_E"Use '"YELLOW_E"/dm > Vehicles"WHITE_E"' to display vehicle here",v);
			CarDealershipInfo[d][cdVehicleLabel][v] = CreateDynamic3DTextLabel(String,COLOR_ARWIN,CarDealershipInfo[d][cdVehicleSpawnX][v], CarDealershipInfo[d][cdVehicleSpawnY][v], CarDealershipInfo[d][cdVehicleSpawnZ][v],8.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID);
            SavecDealership(d);
		}
		else
		{
            RemovePlayerFromVehicle(playerid);
            TogglePlayerControllable(playerid, 1);
			return 1;
		}
	}
	else if(dialogid == DIALOG_CDSELL)
	{
		if(response)
		{
			if(GetPVarInt(playerid, "editingcd") == -1) return 1;

			if(pData[playerid][pOtherPropOwner1] == CarDealershipInfo[GetPVarInt(playerid, "editingcd")][cdID])
			{
				pData[playerid][pOtherPropOwner1] = -1;
			}
			else if(pData[playerid][pOtherPropOwner2] == CarDealershipInfo[GetPVarInt(playerid, "editingcd")][cdID])
			{
				pData[playerid][pOtherPropOwner2] = -1;
			}
			else if(pData[playerid][pOtherPropOwner3] == CarDealershipInfo[GetPVarInt(playerid, "editingcd")][cdID])
			{
				pData[playerid][pOtherPropOwner3] = -1;
			}

            GivePlayerMoneyEx(playerid, CarDealershipInfo[GetPVarInt(playerid, "editingcd")][cdPrice]);
			SellCarDealership(GetPVarInt(playerid, "editingcd"));
			format(String, sizeof(String), "Car Dealership successfully sold for %s!", FormatMoney(CarDealershipInfo[GetPVarInt(playerid, "editingcd")][cdPrice]));
			SendClientMessageEx(playerid, COLOR_WHITE, String);
		}
		else
		{
            SetPVarInt(playerid, "editingcd", -1);
			return 1;
		}
	}
    return 1;
}


CMD:dmvehicleposspawn(playerid, params[])
{
    if(pData[playerid][pAdmin] >= 5)
	{
	    new d;
	    if(sscanf(params, "d", d)) 
		{
			SendClientMessageEx(playerid, COLOR_WHITE, "USAGE: /dmvehicleposspawn [dealerid]");
			return 1;
		}
	    new Float: x, Float: y, Float: z, Float: a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid, a);
		CarDealershipInfo[d][cdVehicleSpawn][0] = x;
		CarDealershipInfo[d][cdVehicleSpawn][1] = y;
		CarDealershipInfo[d][cdVehicleSpawn][2] = z;
		CarDealershipInfo[d][cdVehicleSpawn][3] = a;
		SavecDealership(d);
		SendClientMessageEx(playerid, COLOR_ARWIN, "DEALERSHIP: "YELLOW_E"Succesfull set vehicle pos spawn "YELLOW_E"dealership id {00FFFF}%d", d);
	}
	else
	{
        SendClientMessageEx(playerid, COLOR_GREY, " You are not allowed to use this command.");
	}
    return 1;
}
	
CMD:dmvehiclepos(playerid, params[])
{
    if(pData[playerid][pAdmin] >= 5)
	{
	    new d, v;
	    if(sscanf(params, "dd", d, v)) 
		{
			SendClientMessageEx(playerid, COLOR_WHITE, "USAGE: /dmvehiclepos [dealerid] [slot]");
			return 1;
		}
		if(v == 10)
		{
			SendClientMessageEx(playerid, COLOR_WHITE, "USAGE: /dmvehiclepos [dealerid] [0 - 9]");
			return 1;
		}
	    new Float: x, Float: y, Float: z, Float: a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid, a);
		CarDealershipInfo[d][cdVehicleSpawnX][v] = x;
		CarDealershipInfo[d][cdVehicleSpawnY][v] = y;
		CarDealershipInfo[d][cdVehicleSpawnZ][v] = z;
		CarDealershipInfo[d][cdVehicleSpawnAngle][v] = a;
		SetPVarInt(playerid, "editingcdvehpos", 0);
		SetPVarInt(playerid, "editingcdvehnew", 0);
		CreateDealershipPickup(d);

		SavecDealership(d);
		SendClientMessageEx(playerid, COLOR_ARWIN, "DEALERSHIP: "YELLOW_E"Succesfull set vehicle pos slot {00FFFF}%d "YELLOW_E"dealership id {00FFFF}%d", v, d);
	}
	else
	{
        SendClientMessageEx(playerid, COLOR_GREY, " You are not allowed to use this command.");
	}
    return 1;
}
	
CMD:editcd(playerid, params[])
{
    static
        d,
        type[24],
        string[128];

    if(pData[playerid][pAdmin] < 6)
        return PermissionError(playerid);

    if(sscanf(params, "ds[24]S()[128]", d, type, string))
    {
        Usage(playerid, "/editcd [dealerid] [name]");
        SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} owner, location, money");
        return 1;
    }
    if((d < 0 || d >= MAX_CARDEALERSHIPS))
        return Error(playerid, "You have specified an invalid ID.");

    if(!strcmp(type, "location", true))
    {
		GetPlayerPos(playerid, CarDealershipInfo[d][cdEntranceX], CarDealershipInfo[d][cdEntranceY], CarDealershipInfo[d][cdEntranceZ]);
		CreateDealershipPickup(d);

		SavecDealership(d);
		SendClientMessageEx(playerid, COLOR_ARWIN, "DEALERSHIP: "YELLOW_E"Succesfull location dealerid {00FFFF}%d",d);
    }
    else if(!strcmp(type, "owner", true))
    {
        new owners[MAX_PLAYER_NAME];

        if(sscanf(string, "s[32]", owners))
            return Usage(playerid, "/editcd [dealerid] [owner] [player name] (use '-' to no owner)");

		if(pData[CarDealershipInfo[d][cdOwnerId]][pOtherPropOwner1] == CarDealershipInfo[d][cdID])
		{
			pData[CarDealershipInfo[d][cdOwnerId]][pOtherPropOwner1] = -1;
		}
		else if(pData[CarDealershipInfo[d][cdOwnerId]][pOtherPropOwner2] == CarDealershipInfo[d][cdID])
		{
			pData[CarDealershipInfo[d][cdOwnerId]][pOtherPropOwner2] = -1;
		}
		else if(pData[CarDealershipInfo[d][cdOwnerId]][pOtherPropOwner3] == CarDealershipInfo[d][cdID])
		{
			pData[CarDealershipInfo[d][cdOwnerId]][pOtherPropOwner3] = -1;
		}

        format(CarDealershipInfo[d][cdOwner], MAX_PLAYER_NAME, owners);
  
        CreateDealershipPickup(d);

		SavecDealership(d);
        SendAdminMessage(COLOR_RED, "%s has adjusted the owner of dealer ID: %d to %s", pData[playerid][pAdminname], d, owners);
    }
	else if(!strcmp(type, "money", true))
    {
        new money;

        if(sscanf(string, "d", money))
            return Usage(playerid, "/editcd [dealerid] [money] [Ammount]");

        CarDealershipInfo[d][cdTill] = money;
        SavecDealership(d);
        SendAdminMessage(COLOR_RED, "%s has adjusted the money of Dealer ID: %d to %s.", pData[playerid][pAdminname], d, FormatMoney(money));
    }
    return 1;
}

//DEALER
CMD:dm(playerid, params[])
{
    for(new d = 0 ; d < MAX_CARDEALERSHIPS; d++)
	{
        if(IsPlayerInRangeOfPoint(playerid, 3.0, CarDealershipInfo[d][cdEntranceX], CarDealershipInfo[d][cdEntranceY], CarDealershipInfo[d][cdEntranceZ])) {
            if(IsPlayerOwnerOfCDEx(playerid, d))
			{
                SetPVarInt(playerid, "editingcd", d);
                SetPVarInt(playerid, "editingcdveh", -1);
                SetPVarInt(playerid, "editingcdvehpos", 0);
                SetPVarInt(playerid, "editingcdvehnew", 0);
                new listitems[] = "Vehicles\nDealership - Safes\nChange Name Dealership";
                ShowPlayerDialog(playerid,DIALOG_CDEDIT,DIALOG_STYLE_LIST,"Choose an item to continue", listitems,"Select","Cancel");
                return 1;
            }
            else
			{
                SendClientMessageEx(playerid, COLOR_GREY, "You do not own that Car Dealership.");
                return 1;
            }
        }
    }
    SendClientMessageEx(playerid, COLOR_GREY, "ERROR: You must be standing inside the radius of the Car Dealership.");
    return 1;
}

CMD:destroydealership(playerid, params[])
{
    if(pData[playerid][pAdmin] < 5)
	{
        SendClientMessageEx(playerid, COLOR_GREY, " You are not allowed to use this command.");
        return 1;
    }

    new string[128], dealershipid;
    if(sscanf(params, "d", dealershipid)) return SendClientMessageEx(playerid, COLOR_WHITE, "USAGE: /destroydealership [dealershipid]");

    for(new d = 0 ; d < MAX_CARDEALERSHIPS; d++)
	{
        if(IsPlayerInRangeOfPoint(playerid, 3.0, CarDealershipInfo[d][cdEntranceX], CarDealershipInfo[d][cdEntranceY], CarDealershipInfo[d][cdEntranceZ]))
		{
            DestroyCarDealership(d);
            format(string, sizeof(string), " Car Dealership deleted with ID %d.", d);
            SendClientMessageEx(playerid, COLOR_GRAD1, string);
            return 1;
        }
    }
    if(dealershipid > MAX_CARDEALERSHIPS) return 1;
    if(dealershipid < 0) return 1;
    DestroyCarDealership(dealershipid);
    format(string, sizeof(string), " Car Dealership deleted with ID %d.", dealershipid);
    SendClientMessageEx(playerid, COLOR_GRAD1, string);
    return 1;
}

CMD:buydealership(playerid, params[])
{
    for(new d = 0 ; d < MAX_CARDEALERSHIPS; d++)
	{
        if(IsPlayerInRangeOfPoint(playerid, 3.0, CarDealershipInfo[d][cdEntranceX], CarDealershipInfo[d][cdEntranceY], CarDealershipInfo[d][cdEntranceZ]))
		{
			if(strcmp(CarDealershipInfo[d][cdOwner], "-")) return Error(playerid, "That Car Dealership is already owned and it's not for sale.");

			if(GetPlayerMoney(playerid) < CarDealershipInfo[d][cdPrice])
			{
				SendClientMessageEx(playerid, COLOR_GREY, "Uang Anda kurang untuk membeli dealer kendaraan ini.");
				return 1;
			}
			
			if(pData[playerid][pOtherPropOwner1] == -1)
			{
				pData[playerid][pOtherPropOwner1] = d;
			}
			else if(pData[playerid][pOtherPropOwner2] == -1)
			{
				pData[playerid][pOtherPropOwner2] = d;
			}
			else if(pData[playerid][pOtherPropOwner3] == -1)
			{
				pData[playerid][pOtherPropOwner3] = d;
			}

			GivePlayerMoneyEx(playerid, -CarDealershipInfo[d][cdPrice]);
			GetPlayerName(playerid, CarDealershipInfo[d][cdOwner], MAX_PLAYER_NAME);
			CarDealershipInfo[d][cdOwnerId] = playerid;
			new String[212];
			format(String, sizeof(String), "{00FFFF}[id:%d]\n{FFFF00}%s\n{FFFFFF}Owner: {00FF00}%s",d, CarDealershipInfo[d][cdMessage], CarDealershipInfo[d][cdOwner]);
			UpdateDynamic3DTextLabelText(CarDealershipInfo[d][cdTextLabel], COLOR_TWAQUA, String);
			SavecDealership(d);
        }
    }
    return 1;
}

CMD:selldealership(playerid, params[])
{
	new string[128];

    for(new d = 0 ; d < MAX_CARDEALERSHIPS; d++)
	{
        if(IsPlayerInRangeOfPoint(playerid, 3.0, CarDealershipInfo[d][cdEntranceX], CarDealershipInfo[d][cdEntranceY], CarDealershipInfo[d][cdEntranceZ]))
		{
            if(IsPlayerOwnerOfCDEx(playerid, d))
			{
                SetPVarInt(playerid, "editingcd", d);
                format(string,128,"Are you sure you want to sell this Car Dealership for $%s?\n.", FormatMoney(CarDealershipInfo[d][cdPrice]));
                ShowPlayerDialog(playerid,DIALOG_CDSELL,DIALOG_STYLE_MSGBOX,"Warning:",string,"Sell","Cancel");
                return 1;
            }
            else
			{
                SendClientMessageEx(playerid, COLOR_GREY, "You are not the owner of this car dealership.");
                return 1;
            }
        }
    }
    SendClientMessageEx(playerid, COLOR_GREY, "You have to be near a car dealership.");
    return 1;
}

CMD:destroycdveh(playerid, params[])
{
    if(pData[playerid][pAdmin] < 5)
	{
        SendClientMessageEx(playerid, COLOR_GREY, " You are not allowed to use this command.");
        return 1;
    }

    new string[128], vehid;
    if(sscanf(params, "d", vehid)) return SendClientMessageEx(playerid, COLOR_WHITE, "USAGE: /destroycdveh [vehicleid]");
    DestroyCarDealershipVehicle(GetCarDealershipId(vehid), GetCarDealershipVehicleId(vehid));
    SavecDealership(GetCarDealershipId(vehid));
    format(string, sizeof(string), "Car Dealership Vehicle deleted with ID %d.", vehid);
    SendClientMessageEx(playerid, COLOR_GRAD1, string);
    return 1;
}

CMD:createdealership(playerid, params[])
{
    if(pData[playerid][pAdmin] >= 5)
	{
	    new string[128], price, type, radius, message[64];
	    if(sscanf(params, "ddds[64]", price, type, radius, message)) {
			SendClientMessageEx(playerid, COLOR_WHITE, "USAGE: /createdealership [price ($)] [type] [radius] [message]");
			SendClientMessageEx(playerid, COLOR_GRAD1, "Dealer Car Type List:");
			SendClientMessageEx(playerid, COLOR_GRAD2, "|1. Bike/Motorcycle		|5. Saloons");
			SendClientMessageEx(playerid, COLOR_GRAD1, "|2. SUV					|6. Sport  ");
			SendClientMessageEx(playerid, COLOR_GRAD2, "|3. Pickup Vehicles		|7 Boat.   ");
			SendClientMessageEx(playerid, COLOR_GRAD1, "|4. Lowriders");
			return 1;
		}
	    new Float:X,Float:Y,Float:Z;
	    GetPlayerPos(playerid,X,Y,Z);
	    new dealershipid = CreateCarDealership(playerid, X, Y, Z, radius, price, type, message);
	    if(dealershipid == -1)
		{
	        SendClientMessageEx(playerid, COLOR_GREY, "ERROR: Car Dealerships limit reached.");
	    }
	    else
		{
	        format(string, sizeof(string), "Car Dealership created with ID %d.", dealershipid);
	        SendClientMessageEx(playerid, COLOR_GRAD1, string);
    	}
	}
	else
	{
        SendClientMessageEx(playerid, COLOR_GREY, " You are not allowed to use this command.");
	}
    return 1;
}

CMD:gotocd(playerid, params[])
{
    if(pData[playerid][pAdmin] < 5)
	{
        SendClientMessageEx(playerid, COLOR_GREY, " You are not allowed to use this command.");
        return 1;
    }
	new dealershipid;
    if(sscanf(params, "d", dealershipid)) return SendClientMessageEx(playerid, COLOR_WHITE, "USAGE: /gotodealership [dealershipid]");
    if(!CarDealershipInfo[dealershipid][cdEntranceX]) return SendClientMessage(playerid, COLOR_GREY, "Invalid CarDealership id.");
    SetPlayerPos(playerid, CarDealershipInfo[dealershipid][cdEntranceX], CarDealershipInfo[dealershipid][cdEntranceY], CarDealershipInfo[dealershipid][cdEntranceZ]);
    return 1;
}
