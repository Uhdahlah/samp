AddPlayerSalary(playerid, info[], reason[], money)
{
	new query[512];
	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO salary(owner, info, reason, money, date) VALUES ('%d', '%s', '%s', '%d', CURRENT_TIMESTAMP())", pData[playerid][pID], info, reason, money);
	mysql_tquery(g_SQL, query);
	return true;
}

alias:salary("mysalary")

CMD:salary(playerid, params[])
{
	DisplaySalary(playerid);
	return 1;
}


DisplaySalary(playerid)
{
	new query[512];
	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM salary WHERE owner='%d' ORDER BY id ASC LIMIT 100", pData[playerid][pID]);
	mysql_query(g_SQL, query);
	new rows = cache_num_rows();
	if(rows) 
	{
		new list[2000], listfirst[522], date[30], info[46], reason[124], money, totalduty, gajiduty, totalsal, total;
		
		totalduty = pData[playerid][pTaxiTime];
		if(totalduty > 500)
		{
			gajiduty += 500;
		}
		else
		{
			gajiduty += totalduty;
		}
		format(listfirst, sizeof(listfirst), ""WHITE_E"Date\tIssuer\tAmmount\tReason\n");
		if(pData[playerid][pJob] == 1 || pData[playerid][pJob2] == 1)
		{
			format(list, sizeof(list), "%s"WHITE_E"Current Time\tTaxi Duty\t"LG_E"$%s\n", list, FormatMoney(gajiduty));
		}
		for(new i; i < rows; ++i)
	    {
			cache_get_value_name(i, "info", info);
			cache_get_value_name(i, "date", date);
			cache_get_value_name_int(i, "money", money);
			cache_get_value_name(i, "reason", reason);
			
			format(list, sizeof(list), "%s"WHITE_E"%s\t%s\t"LG_E"$%s\t%s\n", list, date, info, FormatMoney(money), reason);
			totalsal += money;
		}
		total = gajiduty + totalsal;
		format(list, sizeof(list), "%sGrand Total:     \t\t"LG_E"\t"LG_E"$%s\n%s", listfirst, FormatMoney(total), list);
		
		new title[48];
		format(title, sizeof(title), "Pending Salary");
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, title, list, "Close", "");
	}
	else
	{
		new list[2000], totalduty, gajiduty;
		
		totalduty = pData[playerid][pTaxiTime];
		if(totalduty > 1500)
		{
			gajiduty += 500;
		}
		else
		{
			gajiduty += totalduty;
		}
		format(list, sizeof(list), ""WHITE_E"Date\tInfo\tAmmount\n");
		if(pData[playerid][pJob] == 1 || pData[playerid][pJob2] == 1)
		{
			format(list, sizeof(list), "%s"WHITE_E"Current Time\tTaxi Duty\t"LG_E"$%s\n", list, FormatMoney(gajiduty));
		}
		format(list, sizeof(list), "%s"WHITE_E"     \tTotal:\t"LG_E"$%s\n", list, FormatMoney(gajiduty));
		
		new title[48];
		format(title, sizeof(title), "Pending Salary");
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, title, "You don't have a pending salary", "Close", "");
	}
	return 1;
}


DisplayPaycheck(playerid)
{
	new oldbalance = pData[playerid][pBankMoney]; 
	new query[512];
	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM salary WHERE owner='%d' ORDER BY id ASC LIMIT 100", pData[playerid][pID]);
	mysql_query(g_SQL, query);
	new rows = cache_num_rows();
	if(rows) 
	{
		new date[30], info[16], money, totalduty, gajiduty, totalsal, total, pajak, hasil;
		
		totalduty = pData[playerid][pOnDutyTime] + pData[playerid][pTaxiTime];
		for(new i; i < rows; ++i)
		{
			cache_get_value_name(i, "info", info);
			cache_get_value_name(i, "date", date);
			cache_get_value_name_int(i, "money", money);
			totalsal += money;
		}
		
		if(totalduty > 1500)
		{
			gajiduty = 600;
		}
		else
		{
			gajiduty = totalduty;
		}
		total = gajiduty + totalsal;
		pajak = total / 100 * 10;
		hasil = total - pajak;
		pData[playerid][pBankMoney] += hasil;
		PlayerPlaySound(playerid, 1186, 0, 0, 0);
		SendClientMessageEx(playerid, COLOR_ARWIN, "{00FFFF}<====================< "WHITE_E"Paycheck {00FFFF}>====================>");
		SendClientMessageEx(playerid, COLOR_ARWIN, "{00FFFF}=> "WHITE_E"Previous Balance: "GREEN_E"$%s", FormatMoney(oldbalance));
		SendClientMessageEx(playerid, COLOR_ARWIN, "{00FFFF}=> "WHITE_E"Income Tax: "RED_E"$%s", FormatMoney(pajak));
		SendClientMessageEx(playerid, COLOR_ARWIN, "{00FFFF}=> "WHITE_E"New Balance: "GREEN_E"$%s", FormatMoney(pData[playerid][pBankMoney]));
		SendClientMessageEx(playerid, COLOR_ARWIN, "{00FFFF}<==================================================>");
		Server_MinMoney(hasil);
		pData[playerid][pPaycheck] = 3600;
		pData[playerid][pOnDutyTime] = 0;
		pData[playerid][pTaxiTime] = 0;
		mysql_format(g_SQL, query, sizeof(query), "DELETE FROM salary WHERE owner='%d'", pData[playerid][pID]);
		mysql_query(g_SQL, query);
	}
	else
	{
		new totalduty, gajiduty, total, pajak, hasil;
		
		totalduty = pData[playerid][pOnDutyTime] + pData[playerid][pTaxiTime];
		
		if(totalduty > 600)
		{
			gajiduty = 600;
		}
		else
		{
			gajiduty = totalduty;
		}
		total = gajiduty;
		pajak = total / 100 * 10;
		hasil = total - pajak;
		
		pData[playerid][pBankMoney] += hasil;
		PlayerPlaySound(playerid, 1186, 0, 0, 0);
		SendClientMessageEx(playerid, COLOR_ARWIN, "{00FFFF}<====================< "WHITE_E"Paycheck {00FFFF}>====================>");
		SendClientMessageEx(playerid, COLOR_ARWIN, "{00FFFF}=> "WHITE_E"Previous Balance: "GREEN_E"$%s", FormatMoney(oldbalance));
		SendClientMessageEx(playerid, COLOR_ARWIN, "{00FFFF}=> "WHITE_E"Income Tax: "RED_E"$%s", FormatMoney(pajak));
		SendClientMessageEx(playerid, COLOR_ARWIN, "{00FFFF}=> "WHITE_E"New Balance: "GREEN_E"$%s", FormatMoney(pData[playerid][pBankMoney]));
		SendClientMessageEx(playerid, COLOR_ARWIN, "{00FFFF}<==================================================>");
		Server_MinMoney(hasil);
		pData[playerid][pPaycheck] = 3600;
		pData[playerid][pOnDutyTime] = 0;
		pData[playerid][pTaxiTime] = 0;
	}
	return 1;
}


