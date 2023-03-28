
#define MAX_VOUCHER 50

enum E_VOUCHER
{
	voucID,
	voucCode,
	voucVIP,
	voucVIPTime,
	voucGold,
	voucAdmin[16],
	voucDonature[16],
	voucClaim,
};
new VoucData[MAX_VOUCHER][E_VOUCHER],
	Iterator: Vouchers<MAX_VOUCHER>;
	
function LoadVouchers()
{
    new voucid, admin[16], donature[16];
	
	new rows = cache_num_rows();
 	if(rows)
  	{
		for(new i; i < rows; i++)
		{
			cache_get_value_name_int(i, "id", voucid);
			cache_get_value_name_int(i, "code", VoucData[voucid][voucCode]);
			cache_get_value_name_int(i, "vip", VoucData[voucid][voucVIP]);
			cache_get_value_name_int(i, "vip_time", VoucData[voucid][voucVIPTime]);
			cache_get_value_name_int(i, "gold", VoucData[voucid][voucGold]);
			cache_get_value_name(i, "admin", admin);
			format(VoucData[voucid][voucAdmin], 16, admin);
			cache_get_value_name(i, "donature", donature);
			format(VoucData[voucid][voucDonature], 16, donature);
			cache_get_value_name_int(i, "claim", VoucData[voucid][voucClaim]);
			Iter_Add(Vouchers, voucid);
		}
		printf("*** [Database: Loaded] voucher data (%d count).", rows);
	}
}
	
Voucher_Save(voucid)
{
	new cQuery[512];
	format(cQuery, sizeof(cQuery), "UPDATE vouchers SET code='%d', vip='%d', vip_time='%d', gold='%d', admin='%s', donature='%s', claim='%d' WHERE id='%d'",
	VoucData[voucid][voucCode],
	VoucData[voucid][voucVIP],
	VoucData[voucid][voucVIPTime],
	VoucData[voucid][voucGold],
	VoucData[voucid][voucAdmin],
	VoucData[voucid][voucDonature],
	VoucData[voucid][voucClaim],
	voucid
	);
	return mysql_tquery(g_SQL, cQuery);
}

CMD:createvoucher(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
	
	new voucid = Iter_Free(Vouchers), query[128];
	if(voucid == -1) return Error(playerid, "You cant create more voucher!");
	new code, vip, viptime, gold;
	if(sscanf(params, "dddd", code, vip, viptime, gold)) return Usage(playerid, "/createvoucher [CODE(73821)] [VIP] [VIP-TIME(Days)] [GOLD]");
	if(code < 10000 || code > 99999) return Error(playerid, "Invalid code 10000-99999");
	if(vip < 0 || vip > 4) return Error(playerid, "Invalid vip 0-3.");
	if(viptime < 0 || viptime > 60) return Error(playerid, "Invalid vip time 0 - 60 days.");
	foreach(new vo : Vouchers)
	{
		if(VoucData[vo][voucCode] == code)
		{
			return Error(playerid, "Voucher code already registered! try another code!");
		}
	}

	new drank[32];
	switch(vip)
	{
		case 1: drank = "Basic Donator";
		case 2: drank = "Advanced Donator";
		case 3: drank = "Professional Donator";
		case 4: drank = "Lifetime Donator";
		default: drank = "{00FF00}None{FFFFFF}";
	}

	VoucData[voucid][voucCode] = code;
	VoucData[voucid][voucVIP] = vip;
	VoucData[voucid][voucVIPTime] = viptime;
	VoucData[voucid][voucGold] = gold;
	format(VoucData[voucid][voucAdmin], 16, pData[playerid][pAdminname]);
	format(VoucData[voucid][voucDonature], 16, "None");
	VoucData[voucid][voucClaim] = 0;
	Iter_Add(Vouchers, voucid);

	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO vouchers SET id='%d', code='%d', vip='%d', vip_time='%d', gold='%d', admin='%s'", voucid, VoucData[voucid][voucCode], VoucData[voucid][voucVIP], VoucData[voucid][voucVIPTime], VoucData[voucid][voucGold], pData[playerid][pAdminname]);
	mysql_tquery(g_SQL, query, "OnVoucherCreated", "i", voucid);
	
	Servers(playerid, "Voucher created id: %d | code: %d | vip: %s | vip-time: %d | gold: %d | admin: %s", voucid, VoucData[voucid][voucCode], drank, VoucData[voucid][voucVIPTime], VoucData[voucid][voucGold], pData[playerid][pAdminname]);
	return 1;
}

function OnVoucherCreated(voucid)
{
	Voucher_Save(voucid);
	return 1;
}




