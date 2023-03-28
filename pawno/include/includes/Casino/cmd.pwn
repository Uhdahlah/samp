SSCANF:CasinoMenu(string[]) 
{
 	if(!strcmp(string,"create",true)) return 1;
 	else if(!strcmp(string,"delete",true)) return 2;
 	else if(!strcmp(string,"price",true)) return 3;
 	else if(!strcmp(string,"exterior",true)) return 4;
 	else if(!strcmp(string,"interior",true)) return 5;
 	return 0;
}

CMD:casinomenu(playerid, params[])
{
    static index, action, nextParams[128];

	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	if(sscanf(params, "k<CasinoMenu>S()[128]", action, nextParams))
	{
		Usage(playerid, "/casinomenu [entity]");
		Usage(playerid, "ENTITY: [create/delete/price]");
		Usage(playerid, "ENTITY: [exterior/interior]");
		return 1;
	}

    switch(action)
    {
        case 1:
        {
            if((index = Casino_Create(playerid)) != INVALID_CASINO_ID) Info(playerid, "Sukses membuat casino id %d", index);
            else Error(playerid, "Jumlah casino melebihi batas!");
        }
        case 2:
        {
            if(sscanf(nextParams, "d", index))
                return Usage(playerid, "/casinomenu delete [casino id]");

			if(Casino_Delete(index)) Info(playerid, "Sukses menghapus casino "RED_E"id: %d.", index);
			else Error(playerid, "ID casino yang kamu input tidak terdaftar!");
        }
        case 3:
        {
            new price;
            if(sscanf(nextParams, "dd", index, price))
                return Usage(playerid, "/casinomenu price [casino id] [price]");

            if(!Casino_IsExists(index))
                return Error(playerid, "Casino tidak terdaftar!");

            CasinoData[index][cPrice] = price;
			Casino_Save(index);
            Casino_Sync(index);
            Info(playerid, "Sukses merubah harga casino id %d menjadi %d", index, price);
        }
        case 4:
        {
            if(sscanf(nextParams, "d", index))
                return Usage(playerid, "/casinomenu exterior [casino id]");

            if(!Casino_IsExists(index))
                return Error(playerid, "Casino tidak terdaftar!");

            GetPlayerPos(playerid, CasinoData[index][cPosExtX], CasinoData[index][cPosExtY], CasinoData[index][cPosExtZ]);
            GetPlayerFacingAngle(playerid, CasinoData[index][cPosExtA]);
            Casino_Save(index);
            Casino_Sync(index);
        }
        case 5:
        {
            if(sscanf(nextParams, "d", index))
                return Usage(playerid, "/casinomenu interior [casino id]");

            if(!Casino_IsExists(index))
                return Error(playerid, "Casino tidak terdaftar!");

            GetPlayerPos(playerid, CasinoData[index][cPosIntX], CasinoData[index][cPosIntY], CasinoData[index][cPosIntZ]);
            GetPlayerFacingAngle(playerid, CasinoData[index][cPosIntA]);
            CasinoData[index][cPosWorld] = GetPlayerVirtualWorld(playerid);
            CasinoData[index][cPosInterior] = GetPlayerInterior(playerid);

            Casino_Save(index);
            Casino_Sync(index);
        }
    }
    return 1;
}

CMD:buycasino(playerid, params[])
{
    new index;
    if((index = Casino_Nearest(playerid)) != INVALID_CASINO_ID)
    {
        if(CasinoData[index][cPrice] > GetPlayerMoney(playerid))
            return Error(playerid, "Kamu tidak mempunyai cukup uang untuk beli casino ini !");

        if(CasinoData[index][cOwner] != -1)
            return Error(playerid, "Casino sudah di miliki oleh seseorang!");

        CasinoData[index][cOwner] = pData[playerid][pID];
        format(CasinoData[index][cOwnerName], 128, "%s", ReturnName(playerid));

        GivePlayerMoneyEx(playerid, -CasinoData[index][cPrice]);
        Info(playerid, "Kamu memberi casino ini seharga %d", CasinoData[index][cPrice]);
        Casino_Sync(index);
        Casino_Save(index);
    }
    return 1;
}

CMD:cwithdraw(playerid, params[])
{
    new index = Casino_Inside(playerid);
    
    if(index == -1)
        return Error(playerid, "Kamu tidak berada di dalam casino!");

    if(!Casino_IsOwned(playerid, index))
        return Error(playerid, "Kamu bukan pemilik casino ini!");

    new String[10000], amount[32], dollars, cents, duit[32];

    if(sscanf(params, "s[32]", amount))
    {
        SendClientMessageEx(playerid, COLOR_GRAD2, "KEGUNAAN: /cwithdraw [Jumlah]");
        format(String, sizeof(String), "Anda memiliki uang sebesar %s di dalam Akun casino Anda.", FormatMoney(CasinoData[index][cVault]));
        SendClientMessageEx(playerid, COLOR_GRAD3, String);
        return 1;
    }
    if(strfind(amount, ".", true) != 1)
    {
        sscanf(amount, "p<.>dd", dollars, cents);
        format(duit, sizeof(duit), "%d%02d", dollars, cents);
        if(strval(duit) > CasinoData[index][cVault])
        {
            SendClientMessageEx(playerid, COLOR_GRAD2, "Anda tidak memiliki uang sebesar itu di dalam Akun casino anda!");
            return 1;
        }
        if(strval(duit) < 0) return SendClientMessageEx(playerid, COLOR_GREY, "Tidak bisa dibawah $0.00");
        GivePlayerMoneyEx(playerid,strval(duit));
        CasinoData[index][cVault]=CasinoData[index][cVault]-strval(duit);
        format(String, sizeof(String), "CASINO: {ffffff}You've withdrawn {ffff00}$%s{ffffff} from your bisnis account", FormatMoney(strval(duit)));
        SendClientMessageEx(playerid, COLOR_ARWIN, String);
        format(String, sizeof(String), "CASINO: {ffff00}$%s",FormatMoney(CasinoData[index][cVault]));
        SendClientMessageEx(playerid, COLOR_ARWIN, String);
        Casino_Save(index);
    }
    else
    {
        sscanf(amount, "d", dollars);
        format(duit, sizeof(duit), "%d00", dollars);
        if(strval(duit) > CasinoData[index][cVault])
        {
            SendClientMessageEx(playerid, COLOR_GRAD2, "Anda tidak memiliki uang sebesar itu di dalam Akun bisnis anda!");
            return 1;
        }
        if(strval(duit) < 0) return SendClientMessageEx(playerid, COLOR_GREY, "Tidak bisa dibawah $0.00");
        GivePlayerMoneyEx(playerid,strval(duit));
        CasinoData[index][cVault]=CasinoData[index][cVault]-strval(duit);
        format(String, sizeof(String), "CASINO: {ffffff}You've withdrawn {ffff00}$%s{ffffff} from your bisnis account", FormatMoney(strval(duit)));
        SendClientMessageEx(playerid, COLOR_ARWIN, String);
        format(String, sizeof(String), "CASINO: {ffff00}$%s",FormatMoney(CasinoData[index][cVault]));
        SendClientMessageEx(playerid, COLOR_ARWIN, String);
        Casino_Save(index);
    }
    return 1;
}

CMD:cdeposit(playerid, params[])
{
    new index = Casino_Inside(playerid);
    
    if(index == -1)
        return Error(playerid, "Kamu tidak berada di dalam casino!");

    if(!Casino_IsOwned(playerid, index))
        return Error(playerid, "Kamu bukan pemilik casino ini!");

    new String[10000], amount[32], dollars, cents, duit[32];
    if(sscanf(params, "s[32]", amount))
    {
        SendClientMessageEx(playerid, COLOR_WHITE, "KEGUNAAN: /cdeposit [amount(dollars.cents)]");
        return 1;
    }
    if(strfind(amount, ".", true) != -1)
    {
        sscanf(amount, "p<.>dd", dollars, cents);
        format(duit, sizeof(duit), "%d%02d", dollars, cents);
        if (strval(duit) > GetPlayerMoney(playerid))
        {
            SendClientMessageEx(playerid, COLOR_GREY, "Anda tidak memiliki uang sebesar itu.");
            return 1;
        }
        if(strval(duit) < 0) { SendClientMessageEx(playerid,COLOR_WHITE,"ERROR: Tidak bisa dibawah $0.00 ."); return 1; }
        GivePlayerMoneyEx(playerid, -strval(duit));
        CasinoData[index][cVault]=strval(duit)+CasinoData[index][cVault];
        format(String, sizeof(String), "CASINO: {ffffff}You've stored {ffff00}$%s{ffffff} into your casino account", FormatMoney(strval(duit)));
        SendClientMessageEx(playerid, COLOR_ARWIN, String);
        format(String, sizeof(String), "CASINO: {ffff00}$%s", FormatMoney(CasinoData[index][cVault]));
        SendClientMessageEx(playerid, COLOR_ARWIN, String);
        SendClientMessageEx(playerid, COLOR_WHITE, String);
		Casino_Save(index);

    }
    else
    {
        sscanf(amount, "d", dollars);
        format(duit, sizeof(duit), "%d00", dollars);
        if (strval(duit) > GetPlayerMoney(playerid))
        {
            SendClientMessageEx(playerid, COLOR_GREY, "Anda tidak memiliki uang sebesar itu.");
            return 1;
        }
        if(strval(duit) < 0) { SendClientMessageEx(playerid,COLOR_WHITE,"ERROR: Tidak bisa dibawah $0.00 ."); return 1; }
        GivePlayerMoneyEx(playerid,-strval(duit));
        CasinoData[index][cVault]=strval(duit)+CasinoData[index][cVault];
        format(String, sizeof(String), "CASINO: {ffffff}You've stored {ffff00}$%s{ffffff} into your casino account", FormatMoney(strval(duit)));
        SendClientMessageEx(playerid, COLOR_ARWIN, String);
        format(String, sizeof(String), "CASINO: {ffff00}$%s", FormatMoney(CasinoData[index][cVault]));
        SendClientMessageEx(playerid, COLOR_ARWIN, String);
		Casino_Save(index);

    }
    return 1;
}

CMD:dice(playerid, params[]) // bntr sinyal ane jelek
{
    new
        targetid,
        price,
        index = Casino_Inside(playerid)
    ;
    
    if(index == -1)
        return Error(playerid, "Kamu tidak berada di dalam casino!");

    if(sscanf(params, "ud", targetid, price))
        return Usage(playerid, "/dice [playerid] [price]");

    if(targetid == INVALID_PLAYER_ID)
        return Error(playerid, "Invalid playerid!");

    if(IsPlayerNearPlayer(playerid, targetid, 5.0))
    {
        if(GetPlayerMoney(playerid) < price)
            return Error(playerid, "Kamu tidak mempunyai uang sebanyak $%d", price);
        
        if(GetPlayerMoney(targetid) < price)
            return Error(playerid, "Player tersebut tidak mempunyai uang sebanyak %d", price);

        if(price > 100000)
            return Error(playerid, "Tidak Bisa Di Atas 100000");

        if(price < 1)
            return Error(playerid, "Tidak Bisa Di Atas 1");

        Player_DiceOffer[targetid] = playerid;
        Player_DiceOffer[playerid] = targetid;

        Player_DiceOfferPrice[targetid] = price;
        Player_DiceOfferPrice[playerid] = price;
        Info(playerid, "Kamu menawarkan %s untuk melakukan dice seharga $%d", ReturnName(targetid), price);
        Info(targetid, "Kamu ditawarkan %s untuk melakukan dice seharga $%d (( /acceptdice ))", ReturnName(playerid), price);
    }
    return 1;
}

CMD:acceptdice(playerid, params[])
{
    new 
        index = Casino_Inside(playerid),
        targetid = Player_DiceOffer[playerid],
        price = Player_DiceOfferPrice[playerid],
        rand_1 = random(10), // Untuk player
        rand_2 = random(10), // Untuk target
        vault,
        player
    ;

    if(index == -1)
        return Error(playerid, "Kamu tidak berada di dalam casino!");

    if(targetid == INVALID_PLAYER_ID)
        Error(playerid, "Tidak ada yang menawarkan mu melakukan dice!");

    if(GetPlayerMoney(playerid) < Player_DiceOfferPrice[playerid])
        Error(playerid, "Kamu tidak mempunyai cukup uang!");

    if(GetPlayerMoney(targetid) < Player_DiceOfferPrice[targetid])
        Error(playerid, "Player lawanmu tidak mempunyai cukup uang!");

    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s melakukan dice dan mendapatkan %d.", ReturnName(playerid), rand_1);
    SendNearbyMessage(targetid, 30.0, COLOR_PURPLE, "** %s melakukan dice dan mendapatkan %d.", ReturnName(targetid), rand_2);
    if(rand_1 == rand_2)
    {
        Info(playerid, "Hasil seri, tidak ada yang menang dan kalah, uang tidak berkurang!");
        Info(targetid, "Hasil seri, tidak ada yang menang dan kalah, uang tidak berkurang!");
    }
    else if(rand_1 > rand_2)
    {
        vault = (5*price)/100;
        player = (80*price)/100;
        CasinoData[index][cVault] += vault;
        GivePlayerMoneyEx(playerid, player);
        Info(playerid, "Kamu memenangkan perjudian dice, kamu mendapatkan $%d!", player);
        Info(targetid, "Kamu kalah dalam perjudian dice!");
        GivePlayerMoneyEx(targetid, -price);
        Player_DiceOffer[targetid] = -1;
        Player_DiceOffer[playerid] = -1;
       	Casino_Save(index);
    }
    else
    {
        vault = (5*price)/100;
        player = (80*price)/100;
        CasinoData[index][cVault] += vault;
        GivePlayerMoneyEx(targetid, player);
        Info(targetid, "Kamu memenangkan perjudian dice, kamu mendapatkan $%d!", player);
        Info(playerid, "Kamu kalah dalam perjudian dice!");
        GivePlayerMoneyEx(playerid, -price);
        Player_DiceOffer[targetid] = -1;
        Player_DiceOffer[playerid] = -1;
       	Casino_Save(index);
    }
    return 1;
}


CMD:buyprod(playerid, params[])
{
    new index;
    if((index = Casino_Inside(playerid)) != INVALID_CASINO_ID)
    {
        Dialog_Show(playerid, CasinoMenu, DIALOG_STYLE_LIST, "Casino Product", "Beer - $150\nSprunk - $100", "Choose", "Close");
        SetPVarInt(playerid, "CasinoID", index);
    }
    return 1;
}

Dialog:CasinoMenu(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new index = GetPVarInt(playerid, "CasinoID");
        switch(listitem)
        {
            case 0:
            { 
                if(GetPlayerMoney(playerid) > 150)
                { 
                    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
                    GivePlayerMoneyEx(playerid, -150);
                    CasinoData[index][cVault] += 150;
                    Info(playerid, "Kamu telah membeli beer seharga $150");
                }
                else Error(playerid, "Kamu tidak mempunyai cukup uang!");
            }
            case 1:
            { 
                if(GetPlayerMoney(playerid) > 100)
                { 
                    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_SPRUNK);
                    GivePlayerMoneyEx(playerid, -100);
                    CasinoData[index][cVault] += 100;
                    Info(playerid, "Kamu telah membeli sprunk seharga $100");
                }
                else Error(playerid, "Kamu tidak mempunyai cukup uang!");
            }
        }
    }
    return 1;
}