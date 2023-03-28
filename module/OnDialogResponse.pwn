
//----------[ Dialog Login Register]----------
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    while(strfind(inputtext, "%s",true) !=-1) strdel(inputtext,strfind(inputtext, "%s",true),strfind(inputtext, "%s",true)+2);
	while(strfind(inputtext, "%s",true) !=-1) strdel(inputtext,strfind(inputtext, "%s",true),strfind(inputtext, "%s",true)+2);

    if(dialogid == DIALOG_LOGIN)
    {
        if(!response) return Kick(playerid);

		new hashed_pass[65];
		SHA256_PassHash(inputtext, charData[playerid][cSalt], hashed_pass, 65);
		
		if (strcmp(hashed_pass, charData[playerid][cPassword]) == 0)
		{
			charData[playerid][cCharOn] = 0;
            LoadPlayerChar(playerid);
		}
		else
		{
			pData[playerid][LoginAttempts]++;

			if (pData[playerid][LoginAttempts] >= 5)
			{
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Login", "Anda terlalu sering salah mengetik kata sandi (3 kali).", "Okay", "");
				KickEx(playerid);
			}
			else
			{
				new String[512];
				format(String, sizeof(String), "UCP Account: {00FFFF}%s\n"WHITE_E"Attemp: {00FFFF}%d/5\n"WHITE_E"Password: "GREEN_E"(input below)", charData[playerid][cName], pData[playerid][LoginAttempts]);
				ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login To Amazed Roleplay", String," Login","Exit");
			}
		}
        return 1;
    }
    if( dialogid == DIALOG_LOGINCHAR)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
				if(GetPVarInt(playerid,"Char1da")==1)
				{
					loadPlayerChars(playerid,1);
					SetPlayerName(playerid, charData[playerid][cChar1]);
				}
				else
				{
					Info(playerid, "Penggunaan nama harus mengikuti format Firstname_Lastname.");
					Info(playerid, "Sebagai contoh, Steven_Dreschler, Nick_Raymond, dll.");
					ShowPlayerDialog(playerid, DIALOG_CREATECHARNEW1, DIALOG_STYLE_INPUT, "Username Character","Masukan Username yang mau anda gunakan","Next","Close");
					SetPVarInt(playerid,"createchar1",1);
				}
			}
			case 1:
			{
				if(GetPVarInt(playerid,"Char2da")==1)
				{
					loadPlayerChars(playerid,2);
					SetPlayerName(playerid, charData[playerid][cChar2]);
				}
				else
				{
					Info(playerid, "Penggunaan nama harus mengikuti format Firstname_Lastname.");
					Info(playerid, "Sebagai contoh, Steven_Dreschler, Nick_Raymond, dll.");
					ShowPlayerDialog(playerid, DIALOG_CREATECHARNEW1, DIALOG_STYLE_INPUT, "Username Character","Masukan Username yang mau anda gunakan","Next","Close");
					SetPVarInt(playerid,"createchar2",1);
				}
			}
			case 2:
			{
				if(GetPVarInt(playerid,"Char3da")==1)
				{
					loadPlayerChars(playerid,3);
					SetPlayerName(playerid, charData[playerid][cChar3]);
				}
				else
				{
					Info(playerid, "Penggunaan nama harus mengikuti format Firstname_Lastname.");
					Info(playerid, "Sebagai contoh, Steven_Dreschler, Nick_Raymond, dll.");
					ShowPlayerDialog(playerid, DIALOG_CREATECHARNEW1, DIALOG_STYLE_INPUT, "Username Character","Masukan Username yang mau anda gunakan","Next","Close");
					SetPVarInt(playerid,"createchar3",1);
				}
			}
		}
		return 1;
	}
	if( dialogid == DIALOG_CREATECHARNEW1)
	{
		if(!response) return 1;
		if(!IsValidName(inputtext))
		{
			Error(playerid, "Nama tidak sesuai format untuk server mode roleplay.");
			Error(playerid, "Penggunaan nama harus mengikuti format Firstname_Lastname.");
			Error(playerid, "Sebagai contoh, Steven_Dreschler, Nick_Raymond, dll.");
			ShowPlayerDialog(playerid, DIALOG_CREATECHARNEW1, DIALOG_STYLE_INPUT, "Username Character","Masukan Username yang mau anda gunakan","Next","Close");
			return 1;
		}
		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "SELECT username FROM players WHERE username='%e'", inputtext);
		mysql_tquery(g_SQL, query, "CreateChar", "is", playerid, inputtext);
		return 1;
	}
	if(dialogid == DIALOG_REGISTER1)
    {
		if (!response) return Kick(playerid);
		if (strlen(inputtext) <= 5) return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "Registration", "Kata sandi Anda harus lebih dari 5 karakter!\nSilakan masukkan kata sandi Anda di bidang di bawah ini:", "Register", "Abort");
		
		if(!IsValidPassword(inputtext))
		{
			Error(playerid, "Kata sandi hanya dapat berisi A-Z, a-z, 0-9, _, [ ], ( )");
			ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "Registration", "Your password must be valid characters!\nSilakan masukkan kata sandi Anda di bidang di bawah ini:", "Register", "Abort");
			return 1;
		}
		new query[512], pass[65], salt[16], verif=1;
		for (new i = 0; i < 16; i++) salt[i] = random(94) + 33;
		SHA256_PassHash(inputtext, salt, pass, 65);

		mysql_format(g_SQL, query, sizeof(query), "UPDATE ucp SET password='%s', salt='%e', verifemail='%d' WHERE username='%s'", pass, salt, verif, charData[playerid][cName]);
		mysql_tquery(g_SQL, query);

		ShowPlayerDialog(playerid, DIALOG_CREATECHARNEW1, DIALOG_STYLE_INPUT, "Username Character","Masukan Username yang mau anda gunakan","Next","Close");
		SetPVarInt(playerid,"createchar1",1);
		return 1;
	}	
	if(dialogid == DIALOG_REGISTER)
    {
		if (!response) return Kick(playerid);

		new String[512];
		format(String, sizeof(String), "UCP Account: {00FFFF}%s\n"WHITE_E"Attemp: {00FFFF}%d/5\n"WHITE_E"Password: "GREEN_E"(input below)", charData[playerid][cName], pData[playerid][LoginAttempts]);
		if(charData[playerid][cCharPinCode] == strval(inputtext))
		{
			ShowPlayerDialog(playerid, DIALOG_REGISTER1, DIALOG_STYLE_PASSWORD, "Register", String," Regis","Exit");
		}
		else return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "Enter the pin code", "Enter the pin code sent in your discrod message!"," Regis","Exit");
	}
	if(dialogid == DIALOG_AGE)
    {
		if(!response) return ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Tanggal Lahir", "Masukan tanggal lahir (Tgl/Bulan/Tahun): 15/04/1998", "Pilih", "Batal");
		if(response)
		{
			new
				iDay,
				iMonth,
				iYear,
				day,
				month,
				year;
				
			getdate(year, month, day);

			static const
					arrMonthDays[] = {31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

			if(sscanf(inputtext, "p</>ddd", iDay, iMonth, iYear)) {
				ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Tanggal Lahir", "Error! Invalid Input\nMasukan tanggal lahir (Tgl/Bulan/Tahun): 15/04/1998", "Pilih", "Batal");
			}
			else if(iYear < 1900 || iYear > year) {
				ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Tahun Lahir", "Error! Invalid Input\nMasukan tanggal lahir (Tgl/Bulan/Tahun): 15/04/1998", "Pilih", "Batal");
			}
			else if(iMonth < 1 || iMonth > 12) {
				ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Bulan Lahir", "Error! Invalid Input\nMasukan tanggal lahir (Tgl/Bulan/Tahun): 15/04/1998", "Pilih", "Batal");
			}
			else if(iDay < 1 || iDay > arrMonthDays[iMonth - 1]) {
				ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Tanggal Lahir", "Error! Invalid Input\nMasukan tanggal lahir (Tgl/Bulan/Tahun): 15/04/1998", "Pilih", "Batal");
			}
			else 
			{
				format(pData[playerid][pAge], 50, inputtext);
				new query[842];
				mysql_format(g_SQL, query, sizeof query, "INSERT INTO `players` (`username`, `age`) VALUES ('%e', '%s')", pData[playerid][pName], inputtext);
				mysql_tquery(g_SQL, query, "OnPlayerRegisterChar", "i", playerid);
				SetPlayerName(playerid, pData[playerid][pName]);
			}
		}
		else ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Tanggal Lahir", "Masukan tanggal lahir (Tgl/Bulan/Tahun): 15/04/1998", "Pilih", "Batal");
		return 1;
	}
	if(dialogid == DIALOG_GENDER)
    {
		if(!response) return ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male\n2. Female", "Pilih", "Batal");
		if(response)
		{
			pData[playerid][pGender] = listitem + 1;
			switch (listitem) 
			{
				case 0: 
				{
					switch (pData[playerid][pGender])
					{
						case 1: 
						{
							new rand = Random(1, 7);
							pData[playerid][pSkin] = rand;
						}
						case 2: 
						{
							new rand = Random(10, 13);
							pData[playerid][pSkin] = rand;
						}	
					}
				}
				case 1: 
				{
					switch (pData[playerid][pGender])
					{
						case 1: 
						{
							new rand = Random(1, 7);
							pData[playerid][pSkin] = rand;
						}
						case 2: 
						{
							new rand = Random(10, 13);
							pData[playerid][pSkin] = rand;
						}	
					}
				}
			}
			pData[playerid][pnewplayer] = 1;
			SetPlayerSkin(playerid,pData[playerid][pSkin]);
			SetPlayerColor(playerid,COLOR_WHITE);
			SetPlayerInterior(playerid,0);
			SetPlayerPos(playerid,1745.8828, -1860.8129, 13.5783);//stasiun
			TogglePlayerControllable(playerid, 1);
			SetPlayerFacingAngle(playerid, 90);
			SetCameraBehindPlayer(playerid);
			SetPlayerVirtualWorld(playerid, 0);
			pData[playerid][pHBEMode] = 1;
			if(pData[playerid][pHBEMode] == 1) //Modern
			{
				TextDrawShowForPlayer(playerid, PlayerSpriteDrink);
				TextDrawShowForPlayer(playerid, PlayerSpriteHunger);
				PlayerTextDrawShow(playerid, PlayerDrink[playerid]);
				PlayerTextDrawShow(playerid, PlayerHunger[playerid]);
			}
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid, pData[playerid][pMoney]);
			SetPlayerScore(playerid, pData[playerid][pLevel]);
			pData[playerid][pSpawned] = 1;
			SetWeapons(playerid);
			SetPlayerArmedWeapon(playerid, 0);
			SendClientMessageEx(playerid, COLOR_ARWIN, "ACCOUNT: "WHITE_E"You've arrive at Unity Station with "GREEN_E"$50.00 {FFFFFF}in your hand and "GREEN_E"$100.00 {FFFFFF}on your Bank Account");
		}
		else ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male\n2. Female", "Pilih", "Batal");
		return 1;
	}
	if(dialogid == DIALOG_ORIGIN)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					pData[playerid][pAccent1] = 0;
					new String[256];
					format(String, sizeof(String), "ORIGIN: {ffffff}Your character's accent has been set to '{ffff00}%s{ffffff}'", GetPlayerAccent(playerid));
					SendClientMessageEx(playerid,COLOR_ARWIN,String);
					ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male\n2. Female", "Pilih", "Batal");
				}
				case 1:
				{	
					pData[playerid][pAccent1] = 1;
					new String[256];
					format(String, sizeof(String), "ORIGIN: {ffffff}Your character's accent has been set to '{ffff00}%s{ffffff}'", GetPlayerAccent(playerid));
					SendClientMessageEx(playerid,COLOR_ARWIN,String);
					ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male\n2. Female", "Pilih", "Batal");
				}
				case 2:
				{
					pData[playerid][pAccent1] = 2;
					new String[256];
					format(String, sizeof(String), "ORIGIN: {ffffff}Your character's accent has been set to '{ffff00}%s{ffffff}'", GetPlayerAccent(playerid));
					SendClientMessageEx(playerid,COLOR_ARWIN,String);
					ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male\n2. Female", "Pilih", "Batal");
				}
				case 3:
				{
					pData[playerid][pAccent1] = 3;
					new String[256];
					format(String, sizeof(String), "ORIGIN: {ffffff}Your character's accent has been set to '{ffff00}%s{ffffff}'", GetPlayerAccent(playerid));
					SendClientMessageEx(playerid,COLOR_ARWIN,String);
					ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male\n2. Female", "Pilih", "Batal");
				}
				case 4:
				{
					pData[playerid][pAccent1] = 4;
					new String[256];
					format(String, sizeof(String), "ORIGIN: {ffffff}Your character's accent has been set to '{ffff00}%s{ffffff}'", GetPlayerAccent(playerid));
					SendClientMessageEx(playerid,COLOR_ARWIN,String);
					ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male\n2. Female", "Pilih", "Batal");
				}
				case 5:
				{
					pData[playerid][pAccent1] = 5;
					new String[256];
					format(String, sizeof(String), "ORIGIN: {ffffff}Your character's accent has been set to '{ffff00}%s{ffffff}'", GetPlayerAccent(playerid));
					SendClientMessageEx(playerid,COLOR_ARWIN,String);
					ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male\n2. Female", "Pilih", "Batal");
				}
				case 6:
				{
					pData[playerid][pAccent1] = 6;
					new String[256];
					format(String, sizeof(String), "ORIGIN: {ffffff}Your character's accent has been set to '{ffff00}%s{ffffff}'", GetPlayerAccent(playerid));
					SendClientMessageEx(playerid,COLOR_ARWIN,String);
					ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male\n2. Female", "Pilih", "Batal");
				}
				case 7:
				{	
					pData[playerid][pAccent1] = 7;
					new String[256];
					format(String, sizeof(String), "ORIGIN: {ffffff}Your character's accent has been set to '{ffff00}%s{ffffff}'", GetPlayerAccent(playerid));
					SendClientMessageEx(playerid,COLOR_ARWIN,String);
					ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male\n2. Female", "Pilih", "Batal");
				}
				case 8:
				{
					pData[playerid][pAccent1] = 8;
					new String[256];
					format(String, sizeof(String), "ORIGIN: {ffffff}Your character's accent has been set to '{ffff00}%s{ffffff}'", GetPlayerAccent(playerid));
					SendClientMessageEx(playerid,COLOR_ARWIN,String);
					ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male\n2. Female", "Pilih", "Batal");
				}
				case 9:
				{
					pData[playerid][pAccent1] = 9;
					new String[256];
					format(String, sizeof(String), "ORIGIN: {ffffff}Your character's accent has been set to '{ffff00}%s{ffffff}'", GetPlayerAccent(playerid));
					SendClientMessageEx(playerid,COLOR_ARWIN,String);
					ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male\n2. Female", "Pilih", "Batal");
				}
				case 10:
				{
					pData[playerid][pAccent1] = 10;
					new String[256];
					format(String, sizeof(String), "ORIGIN: {ffffff}Your character's accent has been set to '{ffff00}%s{ffffff}'", GetPlayerAccent(playerid));
					SendClientMessageEx(playerid,COLOR_ARWIN,String);
					ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male\n2. Female", "Pilih", "Batal");
				}
				case 11:
				{
					pData[playerid][pAccent1] = 11;
					new String[256];
					format(String, sizeof(String), "ORIGIN: {ffffff}Your character's accent has been set to '{ffff00}%s{ffffff}'", GetPlayerAccent(playerid));
					SendClientMessageEx(playerid,COLOR_ARWIN,String);
					ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male\n2. Female", "Pilih", "Batal");
				}
				case 12:
				{
					pData[playerid][pAccent1] = 12;
					new String[256];
					format(String, sizeof(String), "ORIGIN: {ffffff}Your character's accent has been set to '{ffff00}%s{ffffff}'", GetPlayerAccent(playerid));
					SendClientMessageEx(playerid,COLOR_ARWIN,String);
					ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male\n2. Female", "Pilih", "Batal");
				}
				case 13:
				{	
					pData[playerid][pAccent1] = 13;
					new String[256];
					format(String, sizeof(String), "ORIGIN: {ffffff}Your character's accent has been set to '{ffff00}%s{ffffff}'", GetPlayerAccent(playerid));
					SendClientMessageEx(playerid,COLOR_ARWIN,String);
					ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male\n2. Female", "Pilih", "Batal");
				}
				case 14:
				{
					pData[playerid][pAccent1] = 14;
					new String[256];
					format(String, sizeof(String), "ORIGIN: {ffffff}Your character's accent has been set to '{ffff00}%s{ffffff}'", GetPlayerAccent(playerid));
					SendClientMessageEx(playerid,COLOR_ARWIN,String);
					ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male\n2. Female", "Pilih", "Batal");
				}
				case 15:
				{
					pData[playerid][pAccent1] = 15;
					new String[256];
					format(String, sizeof(String), "ORIGIN: {ffffff}Your character's accent has been set to '{ffff00}%s{ffffff}'", GetPlayerAccent(playerid));
					SendClientMessageEx(playerid,COLOR_ARWIN,String);
					ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male\n2. Female", "Pilih", "Batal");
				}
				case 16:
				{
					pData[playerid][pAccent1] = 16;
					new String[256];
					format(String, sizeof(String), "ORIGIN: {ffffff}Your character's accent has been set to '{ffff00}%s{ffffff}'", GetPlayerAccent(playerid));
					SendClientMessageEx(playerid,COLOR_ARWIN,String);
					ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male\n2. Female", "Pilih", "Batal");
				}
				case 17:
				{
					pData[playerid][pAccent1] = 17;
					new String[256];
					format(String, sizeof(String), "ORIGIN: {ffffff}Your character's accent has been set to '{ffff00}%s{ffffff}'", GetPlayerAccent(playerid));
					SendClientMessageEx(playerid,COLOR_ARWIN,String);
					ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male\n2. Female", "Pilih", "Batal");
				}
				case 18:
				{
					pData[playerid][pAccent1] = 18;
					new String[256];
					format(String, sizeof(String), "ORIGIN: {ffffff}Your character's accent has been set to '{ffff00}%s{ffffff}'", GetPlayerAccent(playerid));
					SendClientMessageEx(playerid,COLOR_ARWIN,String);
					ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male\n2. Female", "Pilih", "Batal");
				}
				case 19:
				{	
					pData[playerid][pAccent1] = 19;
					new String[256];
					format(String, sizeof(String), "ORIGIN: {ffffff}Your character's accent has been set to '{ffff00}%s{ffffff}'", GetPlayerAccent(playerid));
					SendClientMessageEx(playerid,COLOR_ARWIN,String);
					ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male\n2. Female", "Pilih", "Batal");
				}
				case 20:
				{
					pData[playerid][pAccent1] = 20;
					new String[256];
					format(String, sizeof(String), "ORIGIN: {ffffff}Your character's accent has been set to '{ffff00}%s{ffffff}'", GetPlayerAccent(playerid));
					SendClientMessageEx(playerid,COLOR_ARWIN,String);
					ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male\n2. Female", "Pilih", "Batal");
				}
				case 21:
				{
					pData[playerid][pAccent1] = 21;
					new String[256];
					format(String, sizeof(String), "ORIGIN: {ffffff}Your character's accent has been set to '{ffff00}%s{ffffff}'", GetPlayerAccent(playerid));
					SendClientMessageEx(playerid,COLOR_ARWIN,String);
					ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male\n2. Female", "Pilih", "Batal");
				}
				case 22:
				{
					pData[playerid][pAccent1] = 22;
					new String[256];
					format(String, sizeof(String), "ORIGIN: {ffffff}Your character's accent has been set to '{ffff00}%s{ffffff}'", GetPlayerAccent(playerid));
					SendClientMessageEx(playerid,COLOR_ARWIN,String);
					ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male\n2. Female", "Pilih", "Batal");
				}
				case 23:
				{
					pData[playerid][pAccent1] = 23;
					new String[256];
					format(String, sizeof(String), "ORIGIN: {ffffff}Your character's accent has been set to '{ffff00}%s{ffffff}'", GetPlayerAccent(playerid));
					SendClientMessageEx(playerid,COLOR_ARWIN,String);
					ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male\n2. Female", "Pilih", "Batal");
				}
				case 24:
				{
					pData[playerid][pAccent1] = 24;
					new String[256];
					format(String, sizeof(String), "ORIGIN: {ffffff}Your character's accent has been set to '{ffff00}%s{ffffff}'", GetPlayerAccent(playerid));
					SendClientMessageEx(playerid,COLOR_ARWIN,String);
					ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male\n2. Female", "Pilih", "Batal");
				}
				case 25:
				{	
					pData[playerid][pAccent1] = 25;
					new String[256];
					format(String, sizeof(String), "ORIGIN: {ffffff}Your character's accent has been set to '{ffff00}%s{ffffff}'", GetPlayerAccent(playerid));
					SendClientMessageEx(playerid,COLOR_ARWIN,String);
					ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male\n2. Female", "Pilih", "Batal");
				}
				case 26:
				{
					pData[playerid][pAccent1] = 26;
					new String[256];
					format(String, sizeof(String), "ORIGIN: {ffffff}Your character's accent has been set to '{ffff00}%s{ffffff}'", GetPlayerAccent(playerid));
					SendClientMessageEx(playerid,COLOR_ARWIN,String);
					ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male\n2. Female", "Pilih", "Batal");
				}
				case 27:
				{
					pData[playerid][pAccent1] = 27;
					new String[256];
					format(String, sizeof(String), "ORIGIN: {ffffff}Your character's accent has been set to '{ffff00}%s{ffffff}'", GetPlayerAccent(playerid));
					SendClientMessageEx(playerid,COLOR_ARWIN,String);
					ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male\n2. Female", "Pilih", "Batal");
				}
				case 28:
				{
					pData[playerid][pAccent1] = 28;
					new String[256];
					format(String, sizeof(String), "ORIGIN: {ffffff}Your character's accent has been set to '{ffff00}%s{ffffff}'", GetPlayerAccent(playerid));
					SendClientMessageEx(playerid,COLOR_ARWIN,String);
					ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male\n2. Female", "Pilih", "Batal");
				}
				case 29:
				{
					pData[playerid][pAccent1] = 29;
					new String[256];
					format(String, sizeof(String), "ORIGIN: {ffffff}Your character's accent has been set to '{ffff00}%s{ffffff}'", GetPlayerAccent(playerid));
					SendClientMessageEx(playerid,COLOR_ARWIN,String);
					ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male\n2. Female", "Pilih", "Batal");
				}
				case 30:
				{
					pData[playerid][pAccent1] = 30;
					new String[256];
					format(String, sizeof(String), "ORIGIN: {ffffff}Your character's accent has been set to '{ffff00}%s{ffffff}'", GetPlayerAccent(playerid));
					SendClientMessageEx(playerid,COLOR_ARWIN,String);
					ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male\n2. Female", "Pilih", "Batal");
				}
			}
		}
	}
	if(dialogid == DIALOG_STATS)
	{
		if(response)
		{
			return callcmd::settings(playerid);
		}
	}
	if(dialogid == DIALOG_SETTINGS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					ShowPlayerDialog(playerid, DIALOG_HBEMODE, DIALOG_STYLE_LIST, "HBE Mode", "Show\nHide Textdraw", "Set", "Close");
				}
				case 1:
				{	
					return callcmd::togpm(playerid);
				}
				case 2:
				{
					return callcmd::toglog(playerid);
				}
				case 3:
				{
					return callcmd::togads(playerid);
				}
				case 4:
				{
					return callcmd::togwt(playerid);
				}
				case 5:
				{
					return callcmd::togmoneycent(playerid);
				}
				case 6:
				{
					return callcmd::togradio(playerid);
				}
			}
		}
	}
	if(dialogid == DIALOG_HBEMODE)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					pData[playerid][pHBEMode] = 1;
					TextDrawShowForPlayer(playerid, PlayerSpriteDrink);
					TextDrawShowForPlayer(playerid, PlayerSpriteHunger);
					PlayerTextDrawShow(playerid, PlayerDrink[playerid]);
					PlayerTextDrawShow(playerid, PlayerHunger[playerid]);
				}
				case 1:
				{
					pData[playerid][pHBEMode] = 2;
					TextDrawHideForPlayer(playerid, PlayerSpriteDrink);
					TextDrawHideForPlayer(playerid, PlayerSpriteHunger);
					PlayerTextDrawHide(playerid, PlayerDrink[playerid]);
					PlayerTextDrawHide(playerid, PlayerHunger[playerid]);
				}
			}
		}
	}
	if(dialogid == DIALOG_CHANGEAGE)
    {
		if(response)
		{
			new
				iDay,
				iMonth,
				iYear,
				day,
				month,
				year;
				
			getdate(year, month, day);

			static const
					arrMonthDays[] = {31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

			if(sscanf(inputtext, "p</>ddd", iDay, iMonth, iYear)) {
				ShowPlayerDialog(playerid, DIALOG_CHANGEAGE, DIALOG_STYLE_INPUT, "Tanggal Lahir", "Error! Invalid Input\nMasukan tanggal lahir (Tgl/Bulan/Tahun): 15/04/1998", "Pilih", "Batal");
			}
			else if(iYear < 1900 || iYear > year) {
				ShowPlayerDialog(playerid, DIALOG_CHANGEAGE, DIALOG_STYLE_INPUT, "Tahun Lahir", "Error! Invalid Input\nMasukan tanggal lahir (Tgl/Bulan/Tahun): 15/04/1998", "Pilih", "Batal");
			}
			else if(iMonth < 1 || iMonth > 12) {
				ShowPlayerDialog(playerid, DIALOG_CHANGEAGE, DIALOG_STYLE_INPUT, "Bulan Lahir", "Error! Invalid Input\nMasukan tanggal lahir (Tgl/Bulan/Tahun): 15/04/1998", "Pilih", "Batal");
			}
			else if(iDay < 1 || iDay > arrMonthDays[iMonth - 1]) {
				ShowPlayerDialog(playerid, DIALOG_CHANGEAGE, DIALOG_STYLE_INPUT, "Tanggal Lahir", "Error! Invalid Input\nMasukan tanggal lahir (Tgl/Bulan/Tahun): 15/04/1998", "Pilih", "Batal");
			}
			else 
			{
				format(pData[playerid][pAge], 50, inputtext);
				SendClientMessageEx(playerid, COLOR_ARWIN, "AGE: "WHITE_E"New Age for your character is "YELLOW_E"%s.", pData[playerid][pAge]);
				GivePlayerMoneyEx(playerid, -300);
				Server_AddMoney(300);
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_GOLDSHOP)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					if(pData[playerid][pGold] < 50) return Error(playerid, "Not enough gold!");
					pData[playerid][pGold] -= 50;
					pData[playerid][pWarn]--;
					SendClientMessageEx(playerid, COLOR_ARWIN, "GOLD: "WHITE_E"You reduce 1 warning point");
				}
				case 1:
				{
					if(pData[playerid][pGold] < 150) return Error(playerid, "Not enough gold!");
					ShowPlayerDialog(playerid, DIALOG_CHANGENOPHONE, DIALOG_STYLE_INPUT, ""YELLOW_E"Change Phone Number ", "Masukan No Phone Yang Mau Anda Gunakan", "Change", "Exit");
				}
				case 2:
				{
					if(pData[playerid][pGold] < 100) return Error(playerid, "Not enough gold!");
					new found = false, msg2[512];
					format(msg2, sizeof(msg2), "Model(ID)\tPlate\n");
					for(new i = 0; i < MAX_VEHICLES; i++)
					{
						if(pvData[i][cClaim] == 1) continue;
						if(pvData[i][cOwner] == pData[playerid][pID])
						{
							gListedItems[playerid][found] = i;
							format(msg2, sizeof(msg2), "%s%s(%d)\t%s\n", msg2, GetVehicleModelName(pvData[i][cModel]), pvData[i][cVeh], pvData[i][cPlate]);
							found++;
						}
					}
					if(found)
						ShowPlayerDialog(playerid, DIALOG_CUSTOMPLATE, DIALOG_STYLE_TABLIST_HEADERS, "Custom Plate", msg2, "Select", "Close");
				}
				case 3:
				{
					if(pData[playerid][pGold] < 250) return Error(playerid, "Not enough gold!");
					ShowPlayerDialog(playerid, DIALOG_CHANGEMASK, DIALOG_STYLE_INPUT, ""YELLOW_E"Change Mask Number ", "Masukan no mask Yang Mau Anda Gunakan", "Change", "Exit");
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_CHANGENOPHONE)
	{
		if(response)
		{
			if(strlen(inputtext) < 4) return Error(playerid, "New phone number can't be shorter than 4 characters!"),  ShowPlayerDialog(playerid, DIALOG_CHANGENOPHONE, DIALOG_STYLE_INPUT, ""YELLOW_E"Change Phone Number ", "Masukan No Phone Yang Mau Anda Gunakan", "Change", "Exit");
			if(strlen(inputtext) > 8) return Error(playerid, "New phone number can't be longer than 8 characters!"),  ShowPlayerDialog(playerid, DIALOG_CHANGENOPHONE, DIALOG_STYLE_INPUT, ""YELLOW_E"Change Phone Number ", "Masukan No Phone Yang Mau Anda Gunakan", "Change", "Exit");
			new query[512];
			mysql_format(g_SQL, query, sizeof(query), "SELECT phone FROM players WHERE phone='%d'", strval(inputtext));
			mysql_tquery(g_SQL, query, "PhoneNumberUpdate", "ii", playerid, strval(inputtext));
		}
		return 1;
	}
	if(dialogid == DIALOG_CHANGEMASK)
	{
		if(response)
		{
			if(strlen(inputtext) < 7) return Error(playerid, "New phone number can't be shorter than 7 characters!"),  ShowPlayerDialog(playerid, DIALOG_CHANGEMASK, DIALOG_STYLE_INPUT, ""YELLOW_E"Change Mask Number ", "Masukan no mask Yang Mau Anda Gunakan", "Change", "Exit");
			if(strlen(inputtext) > 8) return Error(playerid, "New phone number can't be longer than 8 characters!"),  ShowPlayerDialog(playerid, DIALOG_CHANGEMASK, DIALOG_STYLE_INPUT, ""YELLOW_E"Change Mask Number ", "Masukan no mask Yang Mau Anda Gunakan", "Change", "Exit");
			
			new query[512];
			mysql_format(g_SQL, query, sizeof(query), "SELECT mask FROM players WHERE mask='%d'", strval(inputtext));
			mysql_tquery(g_SQL, query, "ChangeMask", "ii", playerid, strval(inputtext));
		}
		return 1;
	}
	if(dialogid == DIALOG_GOLDNAME)
	{
		if(response)
		{
			if(strlen(inputtext) < 4) return Error(playerid, "New name can't be shorter than 4 characters!"),  ShowPlayerDialog(playerid, DIALOG_GOLDNAME, DIALOG_STYLE_INPUT, ""WHITE_E"Change Name", "Enter your new name:", "Enter", "Exit");
			if(strlen(inputtext) > 20) return Error(playerid, "New name can't be longer than 20 characters!"),  ShowPlayerDialog(playerid, DIALOG_GOLDNAME, DIALOG_STYLE_INPUT, ""WHITE_E"Change Name", "Enter your new name:", "Enter", "Exit");
			if(!IsValidRoleplayName(inputtext))
			{
				Error(playerid, "Name contains invalid characters, please doublecheck!");
				ShowPlayerDialog(playerid, DIALOG_GOLDNAME, DIALOG_STYLE_INPUT, ""WHITE_E"Change Name", "Enter your new name:", "Enter", "Exit");
				return 1;
			}
			new query[512];
			mysql_format(g_SQL, query, sizeof(query), "SELECT username FROM players WHERE username='%s'", inputtext);
			mysql_tquery(g_SQL, query, "ChangeName", "is", playerid, inputtext);
		}
		return 1;
	}
	//-----------[ Bisnis Dialog ]------------
	if(dialogid == DIALOG_SELL_BISNISS)
	{
		if(!response) return 1;
		new str[248];
		SetPVarInt(playerid, "SellingBisnis", ReturnPlayerBisnisID(playerid, (listitem + 1)));
		new bid = GetPVarInt(playerid, "SellingBisnis");
		if(bData[bid][bSegel] == 1) return Error(playerid, "Biz anda masih tersegel.");
		format(str, sizeof(str), "Are you sure you will sell bisnis id: %d", GetPVarInt(playerid, "SellingBisnis"));
				
		ShowPlayerDialog(playerid, DIALOG_SELL_BISNIS, DIALOG_STYLE_MSGBOX, "Sell Bisnis", str, "Sell", "Cancel");
	}
	if(dialogid == DIALOG_SELL_BISNIS)
	{
		if(response)
		{
			new bid = GetPVarInt(playerid, "SellingBisnis");
			GivePlayerMoneyEx(playerid, 2);
			SendClientMessageEx(playerid, COLOR_ARWIN, "BISNIS: "WHITE_E"Anda berhasil menjual bisnis id (%d) dengan setengah harga("LG_E"$2"WHITE_E") pada saat anda membelinya.", bid);
			Bisnis_Reset(bid);
			Bisnis_Save(bid);
			Bisnis_Refresh(bid);
		}
		DeletePVar(playerid, "SellingBisnis");
		return 1;
	}
	if(dialogid == DIALOG_MY_BISNIS)
	{
		if(!response) return true;
		SetPVarInt(playerid, "ClickedBisnis", ReturnPlayerBisnisID(playerid, (listitem + 1)));
		ShowPlayerDialog(playerid, BISNIS_INFO, DIALOG_STYLE_LIST, "{0000FF}Bisnis", "Show Information\nTrack Bisnis", "Select", "Cancel");
		return 1;
	}
	if(dialogid == BISNIS_INFO)
	{
		if(!response) return true;
		new bid = GetPVarInt(playerid, "ClickedBisnis");
		switch(listitem)
		{
			case 0:
			{
				new line9[900];
				new lock[128], type[128];
				if(bData[bid][bLocked] == 1)
				{
					lock = "{FF0000}Locked";
			
				}
				else
				{
					lock = "{00FF00}Unlocked";
				}
				if(bData[bid][bType] == 1)
				{
					type = "Fast Food";
			
				}
				else if(bData[bid][bType] == 2)
				{
					type = "Market";
				}
				else if(bData[bid][bType] == 3)
				{
					type = "Clothes";
				}
				else if(bData[bid][bType] == 4)
				{
					type = "Equipment";
				}
				else
				{
					type = "Unknow";
				}
				format(line9, sizeof(line9), "Bisnis ID: %d\nBisnis Owner: %s\nBisnis Name: %s\nBisnis Price: $%s\nBisnis Type: %s\nBisnis Status: %s\nBisnis Product: %d",
				bid, bData[bid][bOwner], bData[bid][bName], FormatMoney(bData[bid][bPrice]), type, lock, bData[bid][bProd]);

				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Bisnis Info", line9, "Close","");
			}
			case 1:
			{
				new S3MP4K[10000];	
				pData[playerid][pTrackBisnis] = 1;
				SetPlayerRaceCheckpoint(playerid,1, bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ], 0.0, 0.0, 0.0, 3.5);
				SendClientMessageEx(playerid, COLOR_ARWIN, "HINT: "WHITE_E"Ikuti checkpoint untuk menemukan bisnis anda!");
			    format(S3MP4K, sizeof(S3MP4K), "HINT: {FFFFFF}Your bisnis waypoint was set to "YELLOW_E"%s.", GetLocation(bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ]));
				SendClientMessageEx(playerid, COLOR_ARWIN, S3MP4K);	
			}
		}
		return 1;
	}
	if(dialogid == BISNIS_MENU)
	{
		new bid = pData[playerid][pInBiz];
		new lock[128];
		if(bData[bid][bLocked] == 1)
		{
			lock = "Locked";
		}
		else
		{
			lock = "Unlocked";
		}
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{	
					new mstr[248], lstr[512];
					format(mstr,sizeof(mstr),"Bisnis ID %d", bid);
					format(lstr,sizeof(lstr),"Bisnis Name:\t%s\nBisnis Locked:\t%s\nBisnis Product:\t%d\nBisnis Vault:\t$%s", bData[bid][bName], lock, bData[bid][bProd], FormatMoney(bData[bid][bMoney]));
					ShowPlayerDialog(playerid, BISNIS_INFO, DIALOG_STYLE_TABLIST, mstr, lstr,"Back","Close");
				}
				case 1:
				{
					new mstr[248];
					format(mstr,sizeof(mstr),"Nama sebelumnya: %s\n\nMasukkan nama bisnis yang kamu inginkan\nMaksimal 32 karakter untuk nama bisnis", bData[bid][bName]);
					ShowPlayerDialog(playerid, BISNIS_NAME, DIALOG_STYLE_INPUT,"Bisnis Name", mstr,"Done","Back");
				}
				case 2:
				{
					Bisnis_ProductMenu(playerid, bid);
				}
				case 3:
				{
					Bisnis_ProductMenuName(playerid, bid);
				}
				case 4:
				{
					if(bData[bid][bProd] > 100)
						return Error(playerid, "Bisnis ini masih memiliki cukup produck.");
					new mstr[248];
					format(mstr,sizeof(mstr),""GREEN_E"Masukan Jumlah Product Yang Anda Beli");
					ShowPlayerDialog(playerid, BISNIS_BUYRESTOCK, DIALOG_STYLE_INPUT,"Bisnis Restock", mstr,"Buy","Back");
				}
				case 5:
				{
					ShowPlayerDialog(playerid, DIALOG_URL_BISNIS, DIALOG_STYLE_INPUT, "Radio URL", "Enter music url to play music", "Play", "Cancel");
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_URL_BISNIS)
	{
		if(response)
		{
		    if(strlen(inputtext))
		    {
				new bid = pData[playerid][pInBiz];
				format(bData[bid][bStream], 128, inputtext);
				SendClientMessageEx(playerid, COLOR_ARWIN, "BISNIS: "WHITE_E"You have set the radio URL with the URL "YELLOW_E"%s", inputtext);
				new Float:BBCoord[3];
				GetPlayerPos(playerid, BBCoord[0], BBCoord[1], BBCoord[2]);
				PlayStream(playerid, inputtext, BBCoord[0], BBCoord[1], BBCoord[2], 30.0, 1);	
			}
		}
	}
	if(dialogid == BISNIS_BUYRESTOCK)
	{
		if (response)
		{
			new bid = pData[playerid][pInBiz];
		    new idiot = floatround(strval(inputtext));
			new value = idiot * 50, String[212];
			if(bData[bid][bMoney] < value) return Error(playerid, "Uang Di Bisnis anda tidak cukup untuk merestock bisnis");
			bData[bid][bMoney] -= value;
			bData[bid][bProd] += idiot;
			format(String, sizeof(String), "BISNIS: "WHITE_E"Anda telah membeli product bisnis {00FFFF}%d "WHITE_E"unit dengan harga "YELLOW_E"$%s", idiot, FormatMoney(value));
			SendClientMessage(playerid, COLOR_ARWIN, String);
		}
	}
	if(dialogid == BISNIS_INFO)
	{
		if(response)
		{
			return callcmd::bm(playerid, "\0");
		}
		return 1;
	}
	if(dialogid == BISNIS_NAME)
	{
		if(response)
		{
			new bid = pData[playerid][pInBiz];

			if(!Player_OwnsBisnis(playerid, pData[playerid][pInBiz])) return Error(playerid, "You don't own this bisnis.");
			
			if (isnull(inputtext))
			{
				new mstr[512];
				format(mstr,sizeof(mstr),""RED_E"NOTE: "WHITE_E"Nama Bisnis tidak di perbolehkan kosong!\n\n"WHITE_E"Nama sebelumnya: %s\n\nMasukkan nama Bisnis yang kamu inginkan\nMaksimal 32 karakter untuk nama Bisnis", bData[bid][bName]);
				ShowPlayerDialog(playerid, BISNIS_NAME, DIALOG_STYLE_INPUT,"Bisnis Name", mstr,"Done","Back");
				return 1;
			}
			if(strlen(inputtext) > 32 || strlen(inputtext) < 5)
			{
				new mstr[512];
				format(mstr,sizeof(mstr),""RED_E"NOTE: "WHITE_E"Nama Bisnis harus 5 sampai 32 karakter.\n\n"WHITE_E"Nama sebelumnya: %s\n\nMasukkan nama Bisnis yang kamu inginkan\nMaksimal 32 karakter untuk nama Bisnis", bData[bid][bName]);
				ShowPlayerDialog(playerid, BISNIS_NAME, DIALOG_STYLE_INPUT,"Bisnis Name", mstr,"Done","Back");
				return 1;
			}
			format(bData[bid][bName], 32, ColouredText(inputtext));

			Bisnis_Refresh(bid);
			Bisnis_Save(bid);

			Servers(playerid, "Bisnis name set to: \"%s\".", bData[bid][bName]);
		}
		else return callcmd::bm(playerid, "\0");
		return 1;
	}
	if(dialogid == BISNIS_VAULT)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new mstr[512];
					format(mstr,sizeof(mstr),"Uang kamu: $%s.\n\nMasukkan berapa banyak uang yang akan kamu simpan di dalam bisnis ini", FormatMoney(GetPlayerMoney(playerid)));
					ShowPlayerDialog(playerid, BISNIS_DEPOSIT, DIALOG_STYLE_INPUT, "Deposit", mstr, "Deposit", "Back");
				}
				case 1:
				{
					new mstr[512];
					format(mstr,sizeof(mstr),"Business Vault: $%s\n\nMasukkan berapa banyak uang yang akan kamu ambil di dalam bisnis ini", FormatMoney(bData[pData[playerid][pInBiz]][bMoney]));
					ShowPlayerDialog(playerid, BISNIS_WITHDRAW, DIALOG_STYLE_INPUT,"Withdraw", mstr,"Withdraw","Back");
				}
			}
		}
		return 1;
	}
	if(dialogid == BISNIS_WITHDRAW)
	{
		if(response)
		{
			new bid = pData[playerid][pInBiz];
			new amount = floatround(strval(inputtext));
			if(amount < 1 || amount > bData[bid][bMoney])
				return Error(playerid, "Invalid amount specified!");

			bData[bid][bMoney] -= amount;
			Bisnis_Save(bid);

			GivePlayerMoneyEx(playerid, amount);

			SendClientMessageEx(playerid, COLOR_LBLUE,"BUSINESS: "WHITE_E"You have withdrawn "GREEN_E"$%s "WHITE_E"from the business vault.", FormatMoney(strval(inputtext)));
		}
		else
			ShowPlayerDialog(playerid, BISNIS_VAULT, DIALOG_STYLE_LIST,"Business Vault","Deposit\nWithdraw","Next","Back");
		return 1;
	}
	if(dialogid == BISNIS_DEPOSIT)
	{
		if(response)
		{
			new bid = pData[playerid][pInBiz];
			new amount = floatround(strval(inputtext));
			if(amount < 1 || amount > GetPlayerMoney(playerid))
				return Error(playerid, "Invalid amount specified!");

			bData[bid][bMoney] += amount;
			Bisnis_Save(bid);

			GivePlayerMoneyEx(playerid, -amount);
			
			SendClientMessageEx(playerid, COLOR_LBLUE,"BUSINESS: "WHITE_E"You have deposit "GREEN_E"$%s "WHITE_E"into the business vault.", FormatMoney(strval(inputtext)));
		}
		else
			ShowPlayerDialog(playerid, BISNIS_VAULT, DIALOG_STYLE_LIST,"Business Vault","Deposit\nWithdraw","Next","Back");
		return 1;
	}
	if(dialogid == BISNIS_BUYPROD)
	{
		static
        bizid = -1,
        price;

		if((bizid = pData[playerid][pInBiz]) != -1 && response && listitem != -1)
		{
			price = bData[bizid][bP][listitem];

			if(GetPlayerMoney(playerid) < price)
				return Error(playerid, "Not enough money!");

			if(bData[bizid][bProd] < 1)
				return Error(playerid, "This business is out of stock product.");
				
			new Float:health;
			GetPlayerHealth(playerid,health);
			if(bData[bizid][bType] == 1)
			{
				switch(listitem)
				{
					case 0:
					{
						GivePlayerMoneyEx(playerid, -price);
						pData[playerid][pHunger] += 12;
						SendClientMessageEx(playerid, COLOR_ARWIN, "SHOP: {ffffff}You've purchased {ffff00}%s {ffffff}for {00ff00}$%s", bData[bizid][bPName0], FormatMoney(price));
						
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}
					case 1:
					{
						GivePlayerMoneyEx(playerid, -price);
						pData[playerid][pHunger] += 45;
						SendClientMessageEx(playerid, COLOR_ARWIN, "SHOP: {ffffff}You've purchased {ffff00}%s {ffffff}for {00ff00}$%s", bData[bizid][bPName1], FormatMoney(price));
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}
					case 2:
					{
						GivePlayerMoneyEx(playerid, -price);
						pData[playerid][pHunger] += 60;
						SendClientMessageEx(playerid, COLOR_ARWIN, "SHOP: {ffffff}You've purchased {ffff00}%s {ffffff}for {00ff00}$%s", bData[bizid][bPName2], FormatMoney(price));
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}
					case 3:
					{
						GivePlayerMoneyEx(playerid, -price);
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
						pData[playerid][pEnergy] += 45;
						SendClientMessageEx(playerid, COLOR_ARWIN, "SHOP: {ffffff}You've purchased {ffff00}%s {ffffff}for {00ff00}$%s", bData[bizid][bPName3], FormatMoney(price));
					}
				}
			}
			else if(bData[bizid][bType] == 2)
			{
				switch(listitem)
				{
					case 0:
					{
						GivePlayerMoneyEx(playerid, -price);
						if(pData[playerid][pSnack] > 5) return Error(playerid, "maximum bring snacks in invetory 5");
						pData[playerid][pSnack]++;
						SendClientMessageEx(playerid, COLOR_ARWIN, "SHOP: {ffffff}You've purchased {ffff00}%s {ffffff}for {00ff00}$%s", bData[bizid][bPName0], FormatMoney(price));
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}
					case 1:
					{
						GivePlayerMoneyEx(playerid, -price);
						pData[playerid][pSprunk]++;
						if(pData[playerid][pSprunk] > 5) return Error(playerid, "maximum bring spurnk in invetory 5");
						SendClientMessageEx(playerid, COLOR_ARWIN, "SHOP: {ffffff}You've purchased {ffff00}%s {ffffff}for {00ff00}$%s", bData[bizid][bPName1], FormatMoney(price));
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}
					case 2:
					{
						GivePlayerMoneyEx(playerid, -price);
						pData[playerid][pBandage]++;
						SendClientMessageEx(playerid, COLOR_ARWIN, "SHOP: {ffffff}You've purchased {ffff00}%s {ffffff}for {00ff00}$%s", bData[bizid][bPName3], FormatMoney(price));
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}
					case 3:
					{
						GivePlayerMoneyEx(playerid, -price);
						pData[playerid][pRokok]++;
						SendClientMessageEx(playerid, COLOR_ARWIN, "SHOP: {ffffff}You've purchased {ffff00}%s {ffffff}for {00ff00}$%s", bData[bizid][bPName9], FormatMoney(price));
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}
					case 4:
					{
						GivePlayerMoneyEx(playerid, -price);
						pData[playerid][pPayToll] += 50;
						SendClientMessageEx(playerid, COLOR_ARWIN, "SHOP: {ffffff}You've purchased {ffff00}%s {ffffff}for {00ff00}$%s", bData[bizid][bPName10], FormatMoney(price));
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}
				}
			}
			else if(bData[bizid][bType] == 3)
			{
				new models[50] = {-1, ... },
                	count;
				switch(listitem)
				{
					case 0:
					{
						switch(pData[playerid][pGender])
						{
							case 1: ShowPlayerSelectionMenu(playerid, MODEL_SELECTION_SkinMale, "Clothes Shop", maleSkins, sizeof(maleSkins));
							case 2: ShowPlayerSelectionMenu(playerid, MODEL_SELECTION_SkinFemale, "Clothes Shop", femaleSkins, sizeof(femaleSkins));
						}
					}
					case 1:
					{

						if (pData[playerid][pVip] > 0) {
							if(Aksesoris_GetCount(playerid) >= MAX_ACC)
							return Error(playerid, "Slot untuk aksesoris sudah penuh.");
						} else {
							if(Aksesoris_GetCount(playerid) >= MAX_ACC-2)
								return Error(playerid, "Slot untuk aksesoris sudah penuh.");
						}

						pData[playerid][pClothesType] = 2;
							
						for (new id; id < sizeof(accList); id++) if(accList[id][accListType] == 1) {
							models[count++] = accList[id][accListModel];
						}
						ShowCustomSelection(playerid, "Cap List", MODEL_SELECTION_AKSESORIS, models, count);
					}
					case 2:
					{
						if (pData[playerid][pVip] > 0) {
							if(Aksesoris_GetCount(playerid) >= MAX_ACC)
								return Error(playerid, "Slot untuk aksesoris sudah penuh.");
						} else {
							if(Aksesoris_GetCount(playerid) >= MAX_ACC-2)
								return Error(playerid, "Slot untuk aksesoris sudah penuh.");
						}

						pData[playerid][pClothesType] = 3;

						for (new id; id < sizeof(accList); id++) if(accList[id][accListType] == 2) {
							models[count++] = accList[id][accListModel];
						}
						ShowCustomSelection(playerid, "Bandana List", MODEL_SELECTION_AKSESORIS, models, count);
					}
					case 3:
					{
						if (pData[playerid][pVip] > 0) {
							if(Aksesoris_GetCount(playerid) >= MAX_ACC)
							return Error(playerid, "Slot untuk aksesoris sudah penuh.");
						} else {
							if(Aksesoris_GetCount(playerid) >= MAX_ACC-2)
								return Error(playerid, "Slot untuk aksesoris sudah penuh.");
						}

						pData[playerid][pClothesType] = 4;

						for (new id; id < sizeof(accList); id++) if(accList[id][accListType] == 3) {
							models[count++] = accList[id][accListModel];
						}
						ShowCustomSelection(playerid, "Mask List", MODEL_SELECTION_AKSESORIS, models, count);
					}
					case 4:
					{
						if (pData[playerid][pVip] > 0) {
							if(Aksesoris_GetCount(playerid) >= MAX_ACC)
								return Error(playerid, "Slot untuk aksesoris sudah penuh.");
						} else {
							if(Aksesoris_GetCount(playerid) >= MAX_ACC-2)
								return Error(playerid, "Slot untuk aksesoris sudah penuh.");
						}

						pData[playerid][pClothesType] = 5;

						for (new id; id < sizeof(accList); id++) if(accList[id][accListType] == 4) {
							models[count++] = accList[id][accListModel];
						}
						ShowCustomSelection(playerid, "Helmet List", MODEL_SELECTION_AKSESORIS, models, count);
					}
					case 5:
					{
						if (pData[playerid][pVip] > 0) {
							if(Aksesoris_GetCount(playerid) >= MAX_ACC)
								return Error(playerid, "Slot untuk aksesoris sudah penuh.");
						} else {
							if(Aksesoris_GetCount(playerid) >= MAX_ACC-2)
								return Error(playerid, "Slot untuk aksesoris sudah penuh.");
						}

						pData[playerid][pClothesType] = 6;

						for (new id; id < sizeof(accList); id++) if(accList[id][accListType] == 5) {
							models[count++] = accList[id][accListModel];
						}
						ShowCustomSelection(playerid, "Watch List", MODEL_SELECTION_AKSESORIS, models, count);
					}
					case 6:
					{
						if (pData[playerid][pVip] > 0) {
							if(Aksesoris_GetCount(playerid) >= MAX_ACC)
								return Error(playerid, "Slot untuk aksesoris sudah penuh.");
						} else {
							if(Aksesoris_GetCount(playerid) >= MAX_ACC-2)
								return Error(playerid, "Slot untuk aksesoris sudah penuh.");
						}

						pData[playerid][pClothesType] = 7;

						for (new id; id < sizeof(accList); id++) if(accList[id][accListType] == 6) {
							models[count++] = accList[id][accListModel];
						}
						ShowCustomSelection(playerid, "Glasses List", MODEL_SELECTION_AKSESORIS, models, count);
					}
					case 7:
					{
						if (pData[playerid][pVip] > 0) {
							if(Aksesoris_GetCount(playerid) >= MAX_ACC)
								return Error(playerid, "Slot untuk aksesoris sudah penuh.");
						} else {
							if(Aksesoris_GetCount(playerid) >= MAX_ACC-2)
								return Error(playerid, "Slot untuk aksesoris sudah penuh.");
						}

						pData[playerid][pClothesType] = 8;

						for (new id; id < sizeof(accList); id++) if(accList[id][accListType] == 7) {
							models[count++] = accList[id][accListModel];
						}
						ShowCustomSelection(playerid, "Hair List", MODEL_SELECTION_AKSESORIS, models, count);
					}
					case 8:
					{
						if (pData[playerid][pVip] > 0) {
							if(Aksesoris_GetCount(playerid) >= MAX_ACC)
								return Error(playerid, "Slot untuk aksesoris sudah penuh.");
						} else {
							if(Aksesoris_GetCount(playerid) >= MAX_ACC-2)
								return Error(playerid, "Slot untuk aksesoris sudah penuh.");
						}

						pData[playerid][pClothesType] = 9;

						for (new id; id < sizeof(accList); id++) if(accList[id][accListType] == 8) {
							models[count++] = accList[id][accListModel];
						}
						ShowCustomSelection(playerid, "Misc List", MODEL_SELECTION_AKSESORIS, models, count);
					}
				}
			}
			else if(bData[bizid][bType] == 4)
			{
				switch(listitem)
				{
					case 0:
					{
						GivePlayerMoneyEx(playerid, -price);
						GivePlayerWeaponEx(playerid, 5, 1);
						SendClientMessageEx(playerid, COLOR_ARWIN, "SHOP: {ffffff}You've purchased {ffff00}%s {ffffff}for {00ff00}$%s", bData[bizid][bPName0], FormatMoney(price));
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}
					case 1:
					{
						GivePlayerMoneyEx(playerid, -price);
						GivePlayerWeaponEx(playerid, 6, 1);
						SendClientMessageEx(playerid, COLOR_ARWIN, "SHOP: {ffffff}You've purchased {ffff00}%s {ffffff}for {00ff00}$%s", bData[bizid][bPName1], FormatMoney(price));
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}
					case 2:
					{
						GivePlayerMoneyEx(playerid, -price);
						GivePlayerWeaponEx(playerid, 15, 1);
						SendClientMessageEx(playerid, COLOR_ARWIN, "SHOP: {ffffff}You've purchased {ffff00}%s {ffffff}for {00ff00}$%s", bData[bizid][bPName2], FormatMoney(price));
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}
					case 3:
					{
						if(pData[playerid][pFishTool] > 1) return Error(playerid, "Anda masih memiliki pancingan!");
						GivePlayerMoneyEx(playerid, -price);
						pData[playerid][pFishTool] = 100;
						SendClientMessageEx(playerid, COLOR_ARWIN, "SHOP: {ffffff}You've purchased {ffff00}%s {ffffff}for {00ff00}$%s", bData[bizid][bPName3], FormatMoney(price));
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}
					case 4:
					{
						if(pData[playerid][pMask] > 0) return Error(playerid, "Anda sudah memiliki Mask");
						GivePlayerMoneyEx(playerid, -price);
						pData[playerid][pMask] = 1;
						pData[playerid][pMaskID] = random(9999)+1000+pData[playerid][pMask];
						SendClientMessageEx(playerid, COLOR_ARWIN, "SHOP: {ffffff}You've purchased {ffff00}%s {ffffff}for {00ff00}$%s", bData[bizid][bPName4], FormatMoney(price));
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}
				}
			}
			else if(bData[bizid][bType] == 5)
			{
				switch(listitem)
				{
					case 0:
					{
						if(pData[playerid][pPhone] > 0) return Error(playerid, "Anda sudah memiliki Handphone");
						GivePlayerMoneyEx(playerid, -price);
						new query[128], rand = RandomEx(11111111, 99999999);
						new phone = rand+pData[playerid][pID];
						mysql_format(g_SQL, query, sizeof(query), "SELECT phone FROM players WHERE phone='%d'", phone);
						mysql_tquery(g_SQL, query, "PhoneNumber", "id", playerid, phone);
						//pData[playerid][pPhone] = ;
						SendClientMessageEx(playerid, COLOR_ARWIN, "SHOP: {ffffff}You've purchased {ffff00}%s {ffffff}for {00ff00}$%s", bData[bizid][bPName0], FormatMoney(price));
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}	
					case 1:
					{
						if(pData[playerid][pGPS] > 0) return Error(playerid, "Anda sudah memiliki GPS");
						GivePlayerMoneyEx(playerid, -price);
						pData[playerid][pGPS] = 1;
						SendClientMessageEx(playerid, COLOR_ARWIN, "SHOP: {ffffff}You've purchased {ffff00}%s {ffffff}for {00ff00}$%s", bData[bizid][bPName1], FormatMoney(price));
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}
					case 2:
					{
						GivePlayerMoneyEx(playerid, -price);
						pData[playerid][pPhoneCredit] += 1000;
						SendClientMessageEx(playerid, COLOR_ARWIN, "SHOP: {ffffff}You've purchased {ffff00}%s {ffffff}for {00ff00}$%s", bData[bizid][bPName2], FormatMoney(price));
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}
					case 3:
					{
						if(pData[playerid][pWT] > 0) return Error(playerid, "Anda sudah memiliki walkie talkie");
						GivePlayerMoneyEx(playerid, -price);
						pData[playerid][pWT] = 1;
						SendClientMessageEx(playerid, COLOR_ARWIN, "SHOP: {ffffff}You've purchased {ffff00}%s {ffffff}for {00ff00}$%s", bData[bizid][bPName3], FormatMoney(price));
						bData[bizid][bProd]--;
						bData[bizid][bMoney] += Server_Percent(price);
						Server_AddPercent(price);
						Bisnis_Save(bizid);
					}
				}
			}		
		}
		return 1;
	}
	if(dialogid == BISNIS_EDITPROD)
	{
		if(Player_OwnsBisnis(playerid, pData[playerid][pInBiz]))
		{
			if(response)
			{
				static
					item[40],
					str[128];

				strmid(item, inputtext, 0, strfind(inputtext, "-") - 1);
				strpack(pData[playerid][pEditingItem], item, 40 char);

				pData[playerid][pProductModify] = listitem;
				format(str,sizeof(str), "Please enter the new product price for %s:", item);
				ShowPlayerDialog(playerid, BISNIS_PRICESET, DIALOG_STYLE_INPUT, "Business: Set Price", str, "Modify", "Back");
			}
			else
				return callcmd::bm(playerid, "\0");
		}
		return 1;
	}
	if(dialogid == BISNIS_PRICESET)
	{
		static
        item[40];
		new bizid = pData[playerid][pInBiz];
		if(Player_OwnsBisnis(playerid, pData[playerid][pInBiz]))
		{
			if(response)
			{
				strunpack(item, pData[playerid][pEditingItem]);

				if(isnull(inputtext))
				{
					new str[128];
					format(str,sizeof(str), "Please enter the new product price for %s:", item);
					ShowPlayerDialog(playerid, BISNIS_PRICESET, DIALOG_STYLE_INPUT, "Business: Set Price", str, "Modify", "Back");
					return 1;
				}
				if(strval(inputtext) < 1 || strval(inputtext) > 5000)
				{
					new str[128];
					format(str,sizeof(str), "Please enter the new product price for %s ($1 to $50.00):", item);
					ShowPlayerDialog(playerid, BISNIS_PRICESET, DIALOG_STYLE_INPUT, "Business: Set Price", str, "Modify", "Back");
					return 1;
				}
				bData[bizid][bP][pData[playerid][pProductModify]] = strval(inputtext);
				Bisnis_Save(bizid);

				Servers(playerid, "You have adjusted the price of %s to: $%s!", item, FormatMoney(strval(inputtext)));
				Bisnis_ProductMenu(playerid, bizid);
			}
			else
			{
				Bisnis_ProductMenu(playerid, bizid);
			}
		}
		return 1;
	}
	if(dialogid == BISNIS_EDITPRODNAME)
	{
		if(Player_OwnsBisnis(playerid, pData[playerid][pInBiz]))
		{
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
						static
							item[40],
							str[128];

						strmid(item, inputtext, 0, strfind(inputtext, "-") - 1);
						strpack(pData[playerid][pEditingItem], item, 40 char);

						pData[playerid][pProductModify] = 0;
						format(str,sizeof(str), "Please enter the new product name for %s:", item);
						ShowPlayerDialog(playerid, BISNIS_NAMESETPROD, DIALOG_STYLE_INPUT, "Business: Set Name", str, "Modify", "Back");
					}
					case 1:
					{
						static
							item[40],
							str[128];

						strmid(item, inputtext, 0, strfind(inputtext, "-") - 1);
						strpack(pData[playerid][pEditingItem], item, 40 char);

						pData[playerid][pProductModify] = 1;
						format(str,sizeof(str), "Please enter the new product name for %s:", item);
						ShowPlayerDialog(playerid, BISNIS_NAMESETPROD, DIALOG_STYLE_INPUT, "Business: Set Name", str, "Modify", "Back");
					}
					case 2:
					{
						static
							item[40],
							str[128];

						strmid(item, inputtext, 0, strfind(inputtext, "-") - 1);
						strpack(pData[playerid][pEditingItem], item, 40 char);

						pData[playerid][pProductModify] = 2;
						format(str,sizeof(str), "Please enter the new product name for %s:", item);
						ShowPlayerDialog(playerid, BISNIS_NAMESETPROD, DIALOG_STYLE_INPUT, "Business: Set Name", str, "Modify", "Back");
					}
					case 3:
					{
						static
							item[40],
							str[128];

						strmid(item, inputtext, 0, strfind(inputtext, "-") - 1);
						strpack(pData[playerid][pEditingItem], item, 40 char);

						pData[playerid][pProductModify] = 3;
						format(str,sizeof(str), "Please enter the new product name for %s:", item);
						ShowPlayerDialog(playerid, BISNIS_NAMESETPROD, DIALOG_STYLE_INPUT, "Business: Set Name", str, "Modify", "Back");
					}
					case 4:
					{
						static
							item[40],
							str[128];

						strmid(item, inputtext, 0, strfind(inputtext, "-") - 1);
						strpack(pData[playerid][pEditingItem], item, 40 char);

						pData[playerid][pProductModify] = 4;
						format(str,sizeof(str), "Please enter the new product name for %s:", item);
						ShowPlayerDialog(playerid, BISNIS_NAMESETPROD, DIALOG_STYLE_INPUT, "Business: Set Name", str, "Modify", "Back");
					}
					case 5:
					{
						static
							item[40],
							str[128];

						strmid(item, inputtext, 0, strfind(inputtext, "-") - 1);
						strpack(pData[playerid][pEditingItem], item, 40 char);

						pData[playerid][pProductModify] = 5;
						format(str,sizeof(str), "Please enter the new product name for %s:", item);
						ShowPlayerDialog(playerid, BISNIS_NAMESETPROD, DIALOG_STYLE_INPUT, "Business: Set Name", str, "Modify", "Back");
					}
					case 6:
					{
						static
							item[40],
							str[128];

						strmid(item, inputtext, 0, strfind(inputtext, "-") - 1);
						strpack(pData[playerid][pEditingItem], item, 40 char);

						pData[playerid][pProductModify] = 6;
						format(str,sizeof(str), "Please enter the new product name for %s:", item);
						ShowPlayerDialog(playerid, BISNIS_NAMESETPROD, DIALOG_STYLE_INPUT, "Business: Set Name", str, "Modify", "Back");
					}
					case 7:
					{
						static
							item[40],
							str[128];

						strmid(item, inputtext, 0, strfind(inputtext, "-") - 1);
						strpack(pData[playerid][pEditingItem], item, 40 char);

						pData[playerid][pProductModify] = 7;
						format(str,sizeof(str), "Please enter the new product name for %s:", item);
						ShowPlayerDialog(playerid, BISNIS_NAMESETPROD, DIALOG_STYLE_INPUT, "Business: Set Name", str, "Modify", "Back");
					}
					case 8:
					{
						static
							item[40],
							str[128];

						strmid(item, inputtext, 0, strfind(inputtext, "-") - 1);
						strpack(pData[playerid][pEditingItem], item, 40 char);

						pData[playerid][pProductModify] = 8;
						format(str,sizeof(str), "Please enter the new product name for %s:", item);
						ShowPlayerDialog(playerid, BISNIS_NAMESETPROD, DIALOG_STYLE_INPUT, "Business: Set Name", str, "Modify", "Back");
					}
					case 9:
					{
						static
							item[40],
							str[128];

						strmid(item, inputtext, 0, strfind(inputtext, "-") - 1);
						strpack(pData[playerid][pEditingItem], item, 40 char);

						pData[playerid][pProductModify] = 9;
						format(str,sizeof(str), "Please enter the new product name for %s:", item);
						ShowPlayerDialog(playerid, BISNIS_NAMESETPROD, DIALOG_STYLE_INPUT, "Business: Set Name", str, "Modify", "Back");
					}
					case 10:
					{
						static
							item[40],
							str[128];

						strmid(item, inputtext, 0, strfind(inputtext, "-") - 1);
						strpack(pData[playerid][pEditingItem], item, 40 char);

						pData[playerid][pProductModify] = 10;
						format(str,sizeof(str), "Please enter the new product name for %s:", item);
						ShowPlayerDialog(playerid, BISNIS_NAMESETPROD, DIALOG_STYLE_INPUT, "Business: Set Name", str, "Modify", "Back");
					}
					case 11:
					{
						static
							item[40],
							str[128];

						strmid(item, inputtext, 0, strfind(inputtext, "-") - 1);
						strpack(pData[playerid][pEditingItem], item, 40 char);

						pData[playerid][pProductModify] = 11;
						format(str,sizeof(str), "Please enter the new product name for %s:", item);
						ShowPlayerDialog(playerid, BISNIS_NAMESETPROD, DIALOG_STYLE_INPUT, "Business: Set Name", str, "Modify", "Back");
					}
				}	
			}
			else
				return callcmd::bm(playerid, "\0");
		}
		return 1;
	}
	if(dialogid == BISNIS_NAMESETPROD)
	{
		new bid = pData[playerid][pInBiz];
		if(response)
		{
			if(!Player_OwnsBisnis(playerid, pData[playerid][pInBiz])) return 1;
			if(pData[playerid][pProductModify] == 0)
			{
				format(bData[bid][bPName0], 128, inputtext);
				Bisnis_Save(bid);

				Servers(playerid, "You have adjusted the name %s!", inputtext);
				Bisnis_ProductMenuName(playerid, bid);
			}
			else if(pData[playerid][pProductModify] == 1)
			{
				format(bData[bid][bPName1], 128, inputtext);
				Bisnis_Save(bid);

				Servers(playerid, "You have adjusted the name %s!", inputtext);
				Bisnis_ProductMenuName(playerid, bid);
			}
			else if(pData[playerid][pProductModify] == 2)
			{
				format(bData[bid][bPName2], 128, inputtext);
				Bisnis_Save(bid);

				Servers(playerid, "You have adjusted the name %s!", inputtext);
				Bisnis_ProductMenuName(playerid, bid);
			}
			else if(pData[playerid][pProductModify] == 3)
			{
				format(bData[bid][bPName3], 128, inputtext);
				Bisnis_Save(bid);

				Servers(playerid, "You have adjusted the name %s!", inputtext);
				Bisnis_ProductMenuName(playerid, bid);
			}
			else if(pData[playerid][pProductModify] == 4)
			{
				format(bData[bid][bPName4], 128, inputtext);
				Bisnis_Save(bid);

				Servers(playerid, "You have adjusted the name %s!", inputtext);
				Bisnis_ProductMenuName(playerid, bid);
			}
			else if(pData[playerid][pProductModify] == 5)
			{
				format(bData[bid][bPName5], 128, inputtext);
				Bisnis_Save(bid);

				Servers(playerid, "You have adjusted the name %s!", inputtext);
				Bisnis_ProductMenuName(playerid, bid);
			}
			else if(pData[playerid][pProductModify] == 6)
			{
				format(bData[bid][bPName6], 128, inputtext);
				Bisnis_Save(bid);

				Servers(playerid, "You have adjusted the name %s!", inputtext);
				Bisnis_ProductMenuName(playerid, bid);
			}
			else if(pData[playerid][pProductModify] == 7)
			{
				format(bData[bid][bPName7], 128, inputtext);
				Bisnis_Save(bid);

				Servers(playerid, "You have adjusted the name %s!", inputtext);
				Bisnis_ProductMenuName(playerid, bid);
			}
			else if(pData[playerid][pProductModify] == 8)
			{
				format(bData[bid][bPName8], 128, inputtext);
				Bisnis_Save(bid);

				Servers(playerid, "You have adjusted the name %s!", inputtext);
				Bisnis_ProductMenuName(playerid, bid);
			}
			else if(pData[playerid][pProductModify] == 9)
			{
				format(bData[bid][bPName9], 128, inputtext);
				Bisnis_Save(bid);

				Servers(playerid, "You have adjusted the name %s!", inputtext);
				Bisnis_ProductMenuName(playerid, bid);
			}
			else if(pData[playerid][pProductModify] == 10)
			{
				format(bData[bid][bPName10], 128, inputtext);
				Bisnis_Save(bid);

				Servers(playerid, "You have adjusted the name %s!", inputtext);
				Bisnis_ProductMenuName(playerid, bid);
			}
		}
		else return Bisnis_ProductMenuName(playerid, bid);
		return 1;
	}
	//-----------[ House Dialog ]------------------
	if(dialogid == DIALOG_SELL_HOUSES)
	{
		if(!response) return 1;
		new str[248];
		SetPVarInt(playerid, "SellingHouse", ReturnPlayerHousesID(playerid, (listitem + 1)));
		format(str, sizeof(str), "Are you sure you will sell house id: %d", GetPVarInt(playerid, "SellingHouse"));
				
		ShowPlayerDialog(playerid, DIALOG_SELL_HOUSE, DIALOG_STYLE_MSGBOX, "Sell House", str, "Sell", "Cancel");
	}
	if(dialogid == DIALOG_SELL_HOUSE)
	{
		if(response)
		{
			new hid = GetPVarInt(playerid, "SellingHouse");
			GivePlayerMoneyEx(playerid, 2);
			Info(playerid, "Anda berhasil menjual rumah id (%d) dengan setengah harga("LG_E"$2"WHITE_E") pada saat anda membelinya.", hid);
			HouseReset(hid);
			House_Save(hid);
			House_Refresh(hid);
		}
		DeletePVar(playerid, "SellingHouse");
		return 1;
	}
	if(dialogid == DIALOG_MY_HOUSES)
	{
		if(!response) return 1;
		SetPVarInt(playerid, "ClickedHouse", ReturnPlayerHousesID(playerid, (listitem + 1)));
		ShowPlayerDialog(playerid, HOUSE_INFO, DIALOG_STYLE_LIST, "{0000FF}Houses", "Show Information\nTrack House", "Select", "Cancel");
		return 1;
	}
	if(dialogid == HOUSE_INFO)
	{
		if(!response) return 1;
		new hid = GetPVarInt(playerid, "ClickedHouse");
		switch(listitem)
		{
			case 0:
			{
				new line9[900];
				new lock[128], type[128];
				if(hData[hid][hLocked] == 1)
				{
					lock = "{FF0000}Locked";
			
				}
				else
				{
					lock = "{00FF00}Unlocked";
				}
				if(hData[hid][hType] == 1)
				{
					type = "Small";
			
				}
				else if(hData[hid][hType] == 2)
				{
					type = "Medium";
				}
				else if(hData[hid][hType] == 3)
				{
					type = "Big";
				}
				else
				{
					type = "Unknow";
				}
				format(line9, sizeof(line9), "House ID: %d\nHouse Owner: %s\nHouse Address: %s\nHouse Price: %s\nHouse Type: %s\nHouse Status: %s",
				hid, hData[hid][hOwner], hData[hid][hAddress], FormatMoney(hData[hid][hPrice]), type, lock);

				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "House Info", line9, "Close","");
			}
			case 1:
			{
				pData[playerid][pTrackHouse] = 1;
				SetPlayerRaceCheckpoint(playerid,1, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ], 0.0, 0.0, 0.0, 3.5);
				//SetPlayerCheckpoint(playerid, hData[hid][hExtpos][0], hData[hid][hExtpos][1], hData[hid][hExtpos][2], 4.0);
				Info(playerid, "Ikuti checkpoint untuk menemukan rumah anda!");
			}
		}
		return 1;
	}
	if(dialogid == VEHICLE_STORAGE)
	{
		new vehicleid = pData[playerid][pUseVehicleid];
		if(response)
		{
			if(listitem == 0) 
			{
				Vehicle_WeaponStorage(playerid, vehicleid);
			}
			else if(listitem == 1) 
			{
				ShowPlayerDialog(playerid, VEHICLE_COMPONENT, DIALOG_STYLE_LIST, "Component Safe", "Withdraw from safe\nDeposit into safe", "Select", "Back");
			}
			else if(listitem == 2) 
			{
				ShowPlayerDialog(playerid, VEHICLE_MATERIAL, DIALOG_STYLE_LIST, "Material Safe", "Withdraw from safe\nDeposit into safe", "Select", "Back");
			}
			else if(listitem == 3) 
			{
				ShowPlayerDialog(playerid, VEHICLE_CGUN, DIALOG_STYLE_LIST, "Cgun Safe", "Withdraw from safe\nDeposit into safe", "Select", "Back");
			}
			else if(listitem == 4) 
			{
				ShowPlayerDialog(playerid, VEHICLE_CRACK, DIALOG_STYLE_LIST, "Crack Safe", "Withdraw from safe\nDeposit into safe", "Select", "Back");
			}
		}
		else
		{
			SwitchVehicleBoot(vehicleid, false);
		}
		return 1;
	}
	if(dialogid == VEHICLE_CRACK)
	{
		new vehicleid = pData[playerid][pUseVehicleid];
		if(response)
		{
			switch (listitem)
			{
				case 0: 
				{
					new str[128];
					format(str, sizeof(str), "Please enter how much you wish to withdraw from the safe:");
					ShowPlayerDialog(playerid, VEHICLE_WITHDRAWCRACK, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
				}
				case 1: 
				{
					new str[128];
					format(str, sizeof(str), "Please enter how much you wish to deposit into the safe:");
					ShowPlayerDialog(playerid, VEHICLE_DEPOSITCRACK, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
				}
			}
		}
		else Vehicle_OpenStorage(playerid, vehicleid);
		return 1;
	}
	// if(dialogid == VEHICLE_WITHDRAWCRACK)
	// {
	// 	new vehicleid = pData[playerid][pUseVehicleid];
	// 	if(response)
	// 	{
    //         foreach(new ii : PVehicles)
	// 		{
	// 			if(pvData[ii][cVeh] == vehicleid)
	// 			{
    //                 new amount = strval(inputtext);

    //                 if(isnull(inputtext))
    //                 {
    //                     new str[128];
    //                     format(str, sizeof(str), "Please enter how much you wish to withdraw from the safe:", pvData[ii][cCrack]);
    //                     ShowPlayerDialog(playerid, VEHICLE_WITHDRAWCRACK, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
    //                     return 1;
    //                 }
    //                 if(amount < 1 || amount > pvData[ii][cCrack])
    //                 {
    //                     new str[128];
    //                     format(str, sizeof(str), "Please enter how much you wish to withdraw from the safe:", pvData[ii][cCrack]);
    //                     ShowPlayerDialog(playerid, VEHICLE_WITHDRAWCRACK, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
    //                     return 1;
    //                 }
                    
    //                 pvData[ii][cCrack] -= amount;
    //                 pData[playerid][pMarijuana] += amount;

    //                 Vehicle_OpenStorage(playerid, vehicleid);

    //                 SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has withdrawn %d from their trunk safe.", ReturnName(playerid), amount);
    //             }
    //         }    
    //     }
	// 	else ShowPlayerDialog(playerid, VEHICLE_CRACK, DIALOG_STYLE_LIST, "Crack safe", "Withdraw from safe\nDeposit into safe", "Select", "Back");
	// 	return 1;
	// }
	// if(dialogid == VEHICLE_DEPOSITCRACK)
	// {
	// 	new vehicleid = pData[playerid][pUseVehicleid];
	// 	if(response)
	// 	{
    //         foreach(new ii : PVehicles)
	// 		{
	// 			if(pvData[ii][cVeh] == vehicleid)
	// 			{
    //                 new amount = strval(inputtext);

    //                 if(isnull(inputtext))
    //                 {
    //                     new str[128];
    //                     format(str, sizeof(str), "Please enter how much you wish to deposit into the safe:", pvData[ii][cCrack]);
    //                     ShowPlayerDialog(playerid, VEHICLE_DEPOSITCRACK, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
    //                     return 1;
    //                 }
    //                 if(amount < 1 || amount > pData[playerid][pMarijuana])
    //                 {
    //                     new str[128];
    //                     format(str, sizeof(str), "Please enter how much you wish to deposit into the safe:", pvData[ii][cCrack]);
    //                     ShowPlayerDialog(playerid, VEHICLE_DEPOSITCRACK, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
    //                     return 1;
    //                 }
	// 				if(pvData[ii][cCrack] > 1000) return Error(playerid, "Tidak bisa memasukan barang lagi");
    //                 pvData[ii][cCrack] += amount;
    //                 pData[playerid][pMarijuana] -= amount;

    //                 Vehicle_OpenStorage(playerid, vehicleid);

    //                 SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has deposited %d into their trunk safe.", ReturnName(playerid), amount);
    //             }
    //         }
    //     }
	// 	else ShowPlayerDialog(playerid, VEHICLE_CRACK, DIALOG_STYLE_LIST, "Crack safe", "Withdraw from safe\nDeposit into safe", "Select", "Back");
	// 	return 1;
	// }
	if(dialogid == VEHICLE_CGUN)
	{
		new vehicleid = pData[playerid][pUseVehicleid];
		if(response)
		{
			switch (listitem)
			{
				case 0: 
				{
					new str[128];
					format(str, sizeof(str), "Please enter how much you wish to withdraw from the safe:");
					ShowPlayerDialog(playerid, VEHICLE_WITHDRAWCGUN, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
				}
				case 1: 
				{
					new str[128];
					format(str, sizeof(str), "Please enter how much you wish to deposit into the safe:");
					ShowPlayerDialog(playerid, VEHICLE_DEPOSITCGUN, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
				}
			}
		}
		else Vehicle_OpenStorage(playerid, vehicleid);
		return 1;
	}
	if(dialogid == VEHICLE_WITHDRAWCGUN)
	{
		new vehicleid = pData[playerid][pUseVehicleid];
		if(response)
		{
            foreach(new ii : PVehicles)
			{
				if(pvData[ii][cVeh] == vehicleid)
				{
                    new amount = strval(inputtext);

                    if(isnull(inputtext))
                    {
                        new str[128];
                        format(str, sizeof(str), "Please enter how much you wish to withdraw from the safe:", pvData[ii][cCgun]);
                        ShowPlayerDialog(playerid, VEHICLE_WITHDRAWCGUN, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
                        return 1;
                    }
                    if(amount < 1 || amount > pvData[ii][cCgun])
                    {
                        new str[128];
                        format(str, sizeof(str), "Please enter how much you wish to withdraw from the safe:", pvData[ii][cCgun]);
                        ShowPlayerDialog(playerid, VEHICLE_WITHDRAWCGUN, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
                        return 1;
                    }
                    pvData[ii][cCgun] -= amount;
                    pData[playerid][pCgun] += amount;

                    Vehicle_OpenStorage(playerid, vehicleid);

                    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has withdrawn %d from their trunk safe.", ReturnName(playerid), amount);
                }
            }    
        }
		else ShowPlayerDialog(playerid, VEHICLE_CGUN, DIALOG_STYLE_LIST, "Cgun safe", "Withdraw from safe\nDeposit into safe", "Select", "Back");
		return 1;
	}
	if(dialogid == VEHICLE_DEPOSITCGUN)
	{
		new vehicleid = pData[playerid][pUseVehicleid];
		if(response)
		{
            foreach(new ii : PVehicles)
			{
				if(pvData[ii][cVeh] == vehicleid)
				{
                    new amount = strval(inputtext);

                    if(isnull(inputtext))
                    {
                        new str[128];
                        format(str, sizeof(str), "Please enter how much you wish to deposit into the safe:", pvData[ii][cCgun]);
                        ShowPlayerDialog(playerid, VEHICLE_DEPOSITCGUN, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
                        return 1;
                    }
                    if(amount < 1 || amount > pData[playerid][pCgun])
                    {
                        new str[128];
                        format(str, sizeof(str), "Please enter how much you wish to deposit into the safe:", pvData[ii][cCgun]);
                        ShowPlayerDialog(playerid, VEHICLE_DEPOSITCGUN, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
                        return 1;
                    }
					if(pvData[ii][cCgun] > 1000) return Error(playerid, "Tidak bisa memasukan barang lagi");
                    pvData[ii][cCgun] += amount;
                    pData[playerid][pCgun] -= amount;

                    Vehicle_OpenStorage(playerid, vehicleid);

                    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has deposited %d into their trunk safe.", ReturnName(playerid), amount);
                }
            }    
        }
		else ShowPlayerDialog(playerid, VEHICLE_CGUN, DIALOG_STYLE_LIST, "Cgun safe", "Withdraw from safe\nDeposit into safe", "Select", "Back");
		return 1;
	}
	if(dialogid == VEHICLE_MATERIAL)
	{
		new vehicleid = pData[playerid][pUseVehicleid];
		if(response)
		{
			switch (listitem)
			{
				case 0: 
				{
					new str[128];
					format(str, sizeof(str), "Please enter how much you wish to withdraw from the safe:");
					ShowPlayerDialog(playerid, VEHICLE_WITHDRAWMATERIAL, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
				}
				case 1: 
				{
					new str[128];
					format(str, sizeof(str), "Please enter how much you wish to deposit into the safe:");
					ShowPlayerDialog(playerid, VEHICLE_DEPOSITMATERIAL, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
				}
			}
		}
		else Vehicle_OpenStorage(playerid, vehicleid);
		return 1;
	}
	if(dialogid == VEHICLE_WITHDRAWMATERIAL)
	{
		new vehicleid = pData[playerid][pUseVehicleid];
		if(response)
		{
            foreach(new ii : PVehicles)
			{
				if(pvData[ii][cVeh] == vehicleid)
				{
                    new amount = strval(inputtext);

                    if(isnull(inputtext))
                    {
                        new str[128];
                        format(str, sizeof(str), "Please enter how much you wish to withdraw from the safe:", pvData[ii][cMaterial]);
                        ShowPlayerDialog(playerid, VEHICLE_WITHDRAWMATERIAL, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
                        return 1;
                    }
                    if(amount < 1 || amount > pvData[ii][cMaterial])
                    {
                        new str[128];
                        format(str, sizeof(str), "Please enter how much you wish to withdraw from the safe:", pvData[ii][cMaterial]);
                        ShowPlayerDialog(playerid, VEHICLE_WITHDRAWMATERIAL, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
                        return 1;
                    }
                    pvData[ii][cMaterial] -= amount;
                    pData[playerid][pMaterial] += amount;

					if(pvData[ii][cMaterial] == 0)
					{
						if(IsValidDynamicObject(ObjectVehicle[pvData[ii][cVeh]][1]))
						{
							DestroyDynamicObject(ObjectVehicle[pvData[ii][cVeh]][1]);
						}
					}

                    Vehicle_OpenStorage(playerid, vehicleid);

                    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has withdrawn %d from their trunk safe.", ReturnName(playerid), amount);
                }
            }    
        }
		else ShowPlayerDialog(playerid, VEHICLE_MATERIAL, DIALOG_STYLE_LIST, "Material safe", "Withdraw from safe\nDeposit into safe", "Select", "Back");
		return 1;
	}
	if(dialogid == VEHICLE_DEPOSITMATERIAL)
	{
		new vehicleid = pData[playerid][pUseVehicleid];
		if(response)
		{
            foreach(new ii : PVehicles)
			{
				if(pvData[ii][cVeh] == vehicleid)
				{
                    new amount = strval(inputtext);

                    if(isnull(inputtext))
                    {
                        new str[128];
                        format(str, sizeof(str), "Please enter how much you wish to deposit into the safe:", pvData[ii][cMaterial]);
                        ShowPlayerDialog(playerid, VEHICLE_DEPOSITMATERIAL, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
                        return 1;
                    }
                    if(amount < 1 || amount > pData[playerid][pMaterial])
                    {
                        new str[128];
                        format(str, sizeof(str), "Please enter how much you wish to deposit into the safe:", pvData[ii][cMaterial]);
                        ShowPlayerDialog(playerid, VEHICLE_DEPOSITMATERIAL, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
                        return 1;
                    }
					if(pvData[ii][cMaterial] > 2000) return Error(playerid, "Tidak bisa memasukan barang lagi");
                    pvData[ii][cMaterial] += amount;
                    pData[playerid][pMaterial] -= amount;
					if(IsValidDynamicObject(ObjectVehicle[pvData[ii][cVeh]][1]))
					{
						DestroyDynamicObject(ObjectVehicle[pvData[ii][cVeh]][1]);
					}
					if(GetVehicleModel(pvData[ii][cVeh]) == 422 || GetVehicleModel(pvData[ii][cVeh]) == 543)
					{
						ObjectVehicle[ii][1] = CreateDynamicObject(964,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
						AttachDynamicObjectToVehicle(ObjectVehicle[ii][1], pvData[ii][cVeh], 0.000, -1.180, -0.220, 0.000, 0.000, 0.000);	
					}
                    Vehicle_OpenStorage(playerid, vehicleid);

                    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has deposited %d into their trunk safe.", ReturnName(playerid), amount);
                }
            }    
        }
		else ShowPlayerDialog(playerid, VEHICLE_MATERIAL, DIALOG_STYLE_LIST, "Material safe", "Withdraw from safe\nDeposit into safe", "Select", "Back");
		return 1;
	}
	if(dialogid == VEHICLE_COMPONENT)
	{
		new vehicleid = pData[playerid][pUseVehicleid];
		if(response)
		{
			switch (listitem)
			{
				case 0: 
				{
					new str[128];
					format(str, sizeof(str), "Please enter how much you wish to withdraw from the safe:");
					ShowPlayerDialog(playerid, VEHICLE_WITHDRAWCOMPONENT, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
				}
				case 1: 
				{
					new str[128];
					format(str, sizeof(str), "Please enter how much you wish to deposit into the safe:");
					ShowPlayerDialog(playerid, VEHICLE_DEPOSITCOMPONENT, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
				}
			}
		}
		else Vehicle_OpenStorage(playerid, vehicleid);
		return 1;
	}
	// if(dialogid == VEHICLE_WITHDRAWCOMPONENT)
	// {
	// 	new vehicleid = pData[playerid][pUseVehicleid];
	// 	if(response)
	// 	{
    //         foreach(new ii : PVehicles)
	// 		{
	// 			if(pvData[ii][cVeh] == vehicleid)
	// 			{
    //                 new amount = strval(inputtext);

    //                 if(isnull(inputtext))
    //                 {
    //                     new str[128];
    //                     format(str, sizeof(str), "Please enter how much you wish to withdraw from the safe:", pvData[ii][cComponent]);
    //                     ShowPlayerDialog(playerid, VEHICLE_WITHDRAWCOMPONENT, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
    //                     return 1;
    //                 }
    //                 if(amount < 1 || amount > pvData[ii][cComponent])
    //                 {
    //                     new str[128];
    //                     format(str, sizeof(str), "Please enter how much you wish to withdraw from the safe:", pvData[ii][cComponent]);
    //                     ShowPlayerDialog(playerid, VEHICLE_WITHDRAWCOMPONENT, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
    //                     return 1;
    //                 }
    //                 pvData[ii][cComponent] -= amount;
    //                 pData[playerid][pComponent] += amount;

	// 				if(pvData[ii][cComponent] == 0)
	// 				{
	// 					if(IsValidDynamicObject(ObjectVehicle[pvData[ii][cVeh]][0]))
	// 					{
	// 						DestroyDynamicObject(ObjectVehicle[pvData[ii][cVeh]][0]);
	// 					}
	// 				}

    //                 Vehicle_OpenStorage(playerid, vehicleid);

    //                 SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has withdrawn %d from their trunk safe.", ReturnName(playerid), amount);
    //             }
    //         }    
    //     }
	// 	else ShowPlayerDialog(playerid, VEHICLE_COMPONENT, DIALOG_STYLE_LIST, "Component safe", "Withdraw from safe\nDeposit into safe", "Select", "Back");
	// 	return 1;
	// }
	// if(dialogid == VEHICLE_DEPOSITCOMPONENT)
	// {
	// 	new vehicleid = pData[playerid][pUseVehicleid];
	// 	if(response)
	// 	{
    //         foreach(new ii : PVehicles)
	// 		{
	// 			if(pvData[ii][cVeh] == vehicleid)
	// 			{
    //                 new amount = strval(inputtext);

    //                 if(isnull(inputtext))
    //                 {
    //                     new str[128];
    //                     format(str, sizeof(str), "Please enter how much you wish to deposit into the safe:", pvData[ii][cComponent]);
    //                     ShowPlayerDialog(playerid, VEHICLE_DEPOSITCOMPONENT, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
    //                     return 1;
    //                 }
    //                 if(amount < 1 || amount > pData[playerid][pComponent])
    //                 {
    //                     new str[128];
    //                     format(str, sizeof(str), "Please enter how much you wish to deposit into the safe:", pvData[ii][cComponent]);
    //                     ShowPlayerDialog(playerid, VEHICLE_DEPOSITCOMPONENT, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
    //                     return 1;
    //                 }
    //                 if(pvData[ii][cComponent] > 2000) return Error(playerid, "Tidak bisa memasukan barang lagi");
    //                 pvData[ii][cComponent] += amount;
    //                 pData[playerid][pComponent] -= amount;

    //                 Vehicle_OpenStorage(playerid, vehicleid);
	// 				if(IsValidDynamicObject(ObjectVehicle[pvData[ii][cVeh]][0]))
	// 				{
	// 					DestroyDynamicObject(ObjectVehicle[pvData[ii][cVeh]][0]);
	// 				}
	// 				if(GetVehicleModel(pvData[ii][cVeh]) == 422 || GetVehicleModel(pvData[ii][cVeh]) == 543)
	// 				{
	// 					ObjectVehicle[ii][0] = CreateDynamicObject(964,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
	// 					AttachDynamicObjectToVehicle(ObjectVehicle[ii][0], pvData[ii][cVeh], 0.000, -1.180, -0.220, 0.000, 0.000, 0.000);	
	// 				}
    //                 SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has deposited %d into their trunk safe.", ReturnName(playerid), amount);
    //             }
    //         }    
    //     }
	// 	else ShowPlayerDialog(playerid, VEHICLE_COMPONENT, DIALOG_STYLE_LIST, "Component safe", "Withdraw from safe\nDeposit into safe", "Select", "Back");
	// 	return 1;
	// }
	if(dialogid == VEHICLE_WEAPONS)
	{
		new vehicleid = pData[playerid][pUseVehicleid];
				
		if(response)
		{
            foreach(new ii : PVehicles)
			{
				if(pvData[ii][cVeh] == vehicleid)
				{
                    if(pvData[ii][cWeapon][listitem] != 0)
                    {
                        GivePlayerWeaponEx(playerid, pvData[ii][cWeapon][listitem], pvData[ii][cAmmo][listitem]);

                        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has taken a \"%s\" from their weapon storage.", ReturnName(playerid), ReturnWeaponName(pvData[ii][cWeapon][listitem]));

                        pvData[ii][cWeapon][listitem] = 0;
                        pvData[ii][cAmmo][listitem] = 0;
                        Vehicle_WeaponStorage(playerid, vehicleid);
                    }
                    else
                    {
                        new
                            weaponid = GetPlayerWeaponEx(playerid),
                            ammo = GetPlayerAmmoEx(playerid);

                        if(!weaponid)
                            return Error(playerid, "You are not holding any weapon!");

						pData[playerid][pGuns][g_aWeaponSlots[weaponid]] = 0;
						pData[playerid][pAmmo][g_aWeaponSlots[weaponid]] = 0;
						ResetWeapon(playerid, weaponid);
                        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has stored a \"%s\" into their weapon storage.", ReturnName(playerid), ReturnWeaponName(weaponid));
                        pvData[ii][cWeapon][listitem] = weaponid;
                        pvData[ii][cAmmo][listitem] = ammo;
                        Vehicle_WeaponStorage(playerid, vehicleid);
                    }
                }
            }    
        }
		else
		{
			SwitchVehicleBoot(vehicleid, false);
		}
		return 1;
	}
	if(dialogid == HOUSE_STORAGE)
	{
		new hid = pData[playerid][pInHouse];
		if(response)
		{
			if(listitem == 0) 
			{
				House_WeaponStorage(playerid, hid);
			}
			else if(listitem == 1) 
			{
				ShowPlayerDialog(playerid, HOUSE_MONEY, DIALOG_STYLE_LIST, "Money Safe", "Withdraw from safe\nDeposit into safe", "Select", "Back");
			}
		}
		return 1;
	}
	if(dialogid == HOUSE_WEAPONS)
	{
		new houseid = pData[playerid][pInHouse];
				
		if(response)
		{
			if(hData[houseid][hWeapon][listitem] != 0)
			{
				GivePlayerWeaponEx(playerid, hData[houseid][hWeapon][listitem], hData[houseid][hAmmo][listitem]);

				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has taken a \"%s\" from their weapon storage.", ReturnName(playerid), ReturnWeaponName(hData[houseid][hWeapon][listitem]));

				hData[houseid][hWeapon][listitem] = 0;
				hData[houseid][hAmmo][listitem] = 0;

				House_Save(houseid);
				House_WeaponStorage(playerid, houseid);
			}
			else
			{
				new
					weaponid = GetPlayerWeaponEx(playerid),
					ammo = GetPlayerAmmoEx(playerid);

				if(!weaponid)
					return Error(playerid, "You are not holding any weapon!");

				ResetWeapon(playerid, weaponid);
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has stored a \"%s\" into their weapon storage.", ReturnName(playerid), ReturnWeaponName(weaponid));

				hData[houseid][hWeapon][listitem] = weaponid;
				hData[houseid][hAmmo][listitem] = ammo;

				House_Save(houseid);
				House_WeaponStorage(playerid, houseid);
			}
		}
		else
		{
			House_OpenStorage(playerid, houseid);
		}
		return 1;
	}
	if(dialogid == HOUSE_MONEY)
	{
		new houseid = pData[playerid][pInHouse];
		if(response)
		{
			switch (listitem)
			{
				case 0: 
				{
					new str[128];
					format(str, sizeof(str), "Safe Balance: %s\n\nPlease enter how much money you wish to withdraw from the safe:", FormatMoney(hData[houseid][hMoney]));
					ShowPlayerDialog(playerid, HOUSE_WITHDRAWMONEY, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
				}
				case 1: 
				{
					new str[128];
					format(str, sizeof(str), "Safe Balance: %s\n\nPlease enter how much money you wish to deposit into the safe:", FormatMoney(hData[houseid][hMoney]));
					ShowPlayerDialog(playerid, HOUSE_DEPOSITMONEY, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
				}
			}
		}
		else House_OpenStorage(playerid, houseid);
		return 1;
	}
	if(dialogid == HOUSE_WITHDRAWMONEY)
	{
		new houseid = pData[playerid][pInHouse];
		if(response)
		{
			new amount = strval(inputtext);

			if(isnull(inputtext))
			{
				new str[128];
				format(str, sizeof(str), "Safe Balance: %s\n\nPlease enter how much money you wish to withdraw from the safe:", FormatMoney(hData[houseid][hMoney]));
				ShowPlayerDialog(playerid, HOUSE_WITHDRAWMONEY, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
				return 1;
			}
			if(amount < 1 || amount > hData[houseid][hMoney])
			{
				new str[128];
				format(str, sizeof(str), "Error: Insufficient funds.\n\nSafe Balance: %s\n\nPlease enter how much money you wish to withdraw from the safe:", FormatMoney(hData[houseid][hMoney]));
				ShowPlayerDialog(playerid, HOUSE_WITHDRAWMONEY, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
				return 1;
			}
			hData[houseid][hMoney] -= amount;
			GivePlayerMoneyEx(playerid, amount);

			House_Save(houseid);
			House_OpenStorage(playerid, houseid);

			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has withdrawn %s from their house safe.", ReturnName(playerid), FormatMoney(amount));
		}
		else ShowPlayerDialog(playerid, HOUSE_MONEY, DIALOG_STYLE_LIST, "Money Safe", "Withdraw from safe\nDeposit into safe", "Select", "Back");
		return 1;
	}
	if(dialogid == HOUSE_DEPOSITMONEY)
	{
		new houseid = pData[playerid][pInHouse];
		if(response)
		{
			new amount = strval(inputtext);

			if(isnull(inputtext))
			{
				new str[128];
				format(str, sizeof(str), "Safe Balance: %s\n\nPlease enter how much money you wish to deposit into the safe:", FormatMoney(hData[houseid][hMoney]));
				ShowPlayerDialog(playerid, HOUSE_DEPOSITMONEY, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
				return 1;
			}
			if(amount < 1 || amount > GetPlayerMoney(playerid))
			{
				new str[128];
				format(str, sizeof(str), "Error: Insufficient funds.\n\nSafe Balance: %s\n\nPlease enter how much money you wish to deposit into the safe:", FormatMoney(hData[houseid][hMoney]));
				ShowPlayerDialog(playerid, HOUSE_DEPOSITMONEY, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
				return 1;
			}
			hData[houseid][hMoney] += amount;
			GivePlayerMoneyEx(playerid, -amount);

			House_Save(houseid);
			House_OpenStorage(playerid, houseid);

			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has deposited %s into their house safe.", ReturnName(playerid), FormatMoney(amount));
		}
		else ShowPlayerDialog(playerid, HOUSE_MONEY, DIALOG_STYLE_LIST, "Money Safe", "Withdraw from safe\nDeposit into safe", "Select", "Back");
		return 1;
	}
	//------------[ Private Player Vehicle Dialog ]--------
	if(dialogid == DIALOG_CLAIMINSU)
	{
		if(response) 
		{
			new vehicleid = gListedItems[playerid][listitem];
			if(pvData[vehicleid][cOwner] == pData[playerid][pID] && pvData[vehicleid][cClaim] == 1)
			{
				SetValidVehicleHealth(pvData[vehicleid][cVeh], 1000);
				SetVehiclePos(pvData[vehicleid][cVeh], 1793.21, -1070.38, 23.66);
				SetVehicleZAngle(pvData[vehicleid][cVeh], 323.92);
				SetVehicleFuel(pvData[vehicleid][cVeh], 1000);
				SetVehicleVirtualWorld(pvData[vehicleid][cVeh], 0);
				pvData[vehicleid][cClaim] = 0;
				SendClientMessageEx(playerid, COLOR_ARWIN, "INSURANCE: "WHITE_E"You have successfully claimed the {00FFFF}%s "WHITE_E"vehicle", GetVehicleModelName(pvData[vehicleid][cModel]));
			}	
		}
		return 1;
	}
	if(dialogid == DIALOG_UNIMPOUND)
	{
		if(response) 
		{
			new vehicleid = gListedItems[playerid][listitem];
			new price = pvData[vehicleid][cPrice] / 25;
			if(GetPlayerMoney(playerid) < price) return Error(playerid, "You don't have enough money to pay the fine");
			if(!IsValidVehicle(pvData[vehicleid][cVeh])) return 0;
			if(pvData[vehicleid][cOwner] == pData[playerid][pID] && pvData[vehicleid][cImpound] == 1)
			{
				SetValidVehicleHealth(pvData[vehicleid][cVeh], 1000);
				SetVehiclePos(pvData[vehicleid][cVeh], 2813.1353,-1473.6005,16.1020);
				SetVehicleZAngle(pvData[vehicleid][cVeh], 177.4413);
				SetVehicleFuel(pvData[vehicleid][cVeh], 1000);
				SetVehicleVirtualWorld(pvData[vehicleid][cVeh], 0);
				PutPlayerInVehicle(playerid, pvData[vehicleid][cVeh], 0);
				pvData[vehicleid][cImpound] = 0;
				GivePlayerMoneyEx(playerid, -price);
				SendClientMessageEx(playerid, COLOR_ARWIN, "IMPOUND: "WHITE_E"You've unimpound your {00FFFF}%s "WHITE_E"from the impound center for "GREEN_E"$%s", GetVehicleModelName(pvData[vehicleid][cModel]), FormatMoney(price));
			}	
		}
		return 1;
	}
	if(dialogid == DIALOG_BUYINSU)
	{
		if(response) 
		{
			new vehicleid = gListedItems[playerid][listitem];
			new price = pvData[vehicleid][cPrice] / 60;
			if(GetPlayerMoney(playerid) < price) return Error(playerid, "You don't have enough money to buy insurance");
			if(!IsValidVehicle(pvData[vehicleid][cVeh])) return 0;
			if(pvData[vehicleid][cOwner] == pData[playerid][pID] && pvData[vehicleid][cImpound] == 0 && pvData[vehicleid][cClaim] == 0)
			{
				pvData[vehicleid][cInsu]++;
				GivePlayerMoneyEx(playerid, -price);
				SendClientMessageEx(playerid, COLOR_ARWIN, "INSURANCE: "WHITE_E"You buy insurance for "GREEN_E"$%s "WHITE_E"for the {00FFFF}%s "WHITE_E"car, total insurance "YELLOW_E"%d", FormatMoney(price), GetVehicleModelName(pvData[vehicleid][cModel]), pvData[vehicleid][cInsu]);
			}	
		}
		return 1;
	}
	if(dialogid == DIALOG_LOCKVEHICLE)
	{
		if(response) 
		{
			new carid = gListedItems[playerid][listitem];
			if(!IsValidVehicle(pvData[carid][cVeh])) return 0;
			new Float:x, Float:y, Float:z;
			GetVehiclePos(pvData[carid][cVeh], x, y, z);

			if(pvData[carid][cOwner] == pData[playerid][pID] && pvData[carid][cImpound] == 0 && pvData[carid][cClaim] == 0)
			{
				if(IsPlayerInRangeOfPoint(playerid, 5.0, x, y, z))
				{
					if(!pvData[carid][cLocked])
					{
						pvData[carid][cLocked] = 1;
						GameTextForPlayer(playerid,"~w~vehicle ~r~locked",5000,6);
						SwitchVehicleDoors(pvData[carid][cVeh], true);
					}
					else
					{
						pvData[carid][cLocked] = 0;
						GameTextForPlayer(playerid,"~w~vehicle ~g~unlocked",5000,6);
						SwitchVehicleDoors(pvData[carid][cVeh], false);
					}
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_SPAWNEDGARKOT)
	{
		if(response) 
		{
			new vehicleid = gListedItems[playerid][listitem];
			if(!IsValidVehicle(pvData[vehicleid][cVeh])) return 0;
			if(pvData[vehicleid][cOwner] == pData[playerid][pID] && pvData[vehicleid][cImpound] == 4)
			{
				SetVehicleVirtualWorld(pvData[vehicleid][cVeh], 0);
				PutPlayerInVehicle(playerid, pvData[vehicleid][cVeh], 0);
				pvData[vehicleid][cImpound] = 0;
				SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"You have successfully "YELLOW_E"spawned "WHITE_E"the {00FFFF}%s "WHITE_E"vehicle", GetVehicleName(vehicleid));
			}	
		}
		return 1;
	}
	if(dialogid == DIALOG_CUSTOMPLATE)
	{
		if(response) 
		{
			pData[playerid][pListitems] = gListedItems[playerid][listitem];
			ShowPlayerDialog(playerid, DIALOG_CUSTOMPLATE1, DIALOG_STYLE_INPUT, "Custom Plate", "Masukan teks yang ingin anda jadikan plate kendaraan anda", "Select", "Close");
		}
		return 1;
	}
	if(dialogid == DIALOG_CUSTOMPLATE1)
	{
		if(response) 
		{
			new carid = pData[playerid][pListitems];
			if(!IsValidVehicle(pvData[carid][cVeh])) return 0;
			if(pvData[carid][cOwner] == pData[playerid][pID])
			{
				format(pvData[carid][cPlate], 32, "%s", inputtext);
				new plate[62];
				format(plate, sizeof(plate), ""GREEN_E"%s", pvData[carid][cPlate]);
				SetVehicleNumberPlate(pvData[carid][cVeh], plate);
				SetVehicleNumberPlate(pvData[carid][cVeh], inputtext);
				SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"You've turned your vehicle's plate into a {00FFFF}%s", inputtext);
				pData[playerid][pGold] -= 100;
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_VEHDETAIL)
	{
		if(response) 
		{
			new vehicleid = gListedItems[playerid][listitem], otherid = strval(inputtext), string[512], irwan[512];
			
			if(!IsValidVehicle(pvData[vehicleid][cVeh])) return 0;
			if(!IsPlayerConnected(otherid)) return 0;
			SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"You show your {00FFFF}%s "WHITE_E"vehicle license to "YELLOW_E"%s", GetVehicleName(vehicleid), pData[otherid][pName]);
			format(string, sizeof(string), "{FFFFFF}Vehicle: {00FFFF}%s\n", GetVehicleModelName(pvData[pvData[vehicleid][cVeh]][cModel]));
			strcat(irwan, string);
			format(string, sizeof(string), "{FFFFFF}Plate Vehicle: {FFFF00}%s\n", pvData[pvData[vehicleid][cVeh]][cPlate]);
			strcat(irwan, string);
			format(string, sizeof(string), "{FFFFFF}Insurance: {FFFF00}%d year(s)\n", pvData[pvData[vehicleid][cVeh]][cInsu]);
			strcat(irwan, string);
			format(string, sizeof(string), "{FFFFFF}Upgarde\n");
			strcat(irwan, string);
			if(pvData[pvData[vehicleid][cVeh]][cMesinUpgrade] == 1)
			{
				format(string, sizeof(string), "{FFFFFF}- {00FF00}Engine\n");
				strcat(irwan, string);
			}	
			if(pvData[pvData[vehicleid][cVeh]][pvBodyUpgrade] == 1)
			{
				format(string, sizeof(string), "{FFFFFF}- {00FF00}Body");
				strcat(irwan, string);
			}
			SendClientMessageEx(otherid, COLOR_ARWIN, string);
		}
		return 1;
	}
	if(dialogid == DIALOG_PICKUPVEH)
	{
		if(response)
		{
			new id = ReturnAnyVehiclePark((listitem + 1), pData[playerid][pPark]);

			if(pvData[id][cOwner] != pData[playerid][pID]) return Error(playerid, "This is not your Vehicle!");
			pvData[id][cPark] = -1;
			SetVehicleVirtualWorld(pvData[id][cVeh], GetPlayerVirtualWorld(playerid));
			LinkVehicleToInterior(pvData[id][cVeh], GetPlayerInterior(playerid));
			SendClientMessageEx(playerid, COLOR_ARWIN, "GARAGE: "WHITE_E"Your vehicle was successfully removed from the garage.");
			PutPlayerInVehicle(playerid, pvData[id][cVeh], 0);
		}
	}
	if(dialogid == DIALOG_FINDVEH1)
	{
		if(response) 
		{
			pData[playerid][pListitems] = gListedItems[playerid][listitem];
			ShowPlayerDialog(playerid, DIALOG_VEHICLEINFO1, DIALOG_STYLE_LIST, "Vehicle Info", "Despawn Vehicle\nSpawn Vehicle\nDetails\nFind My Vehicle", "Select", "Close");
		}
		return 1;
	}
	if(dialogid == DIALOG_VEHICLEINFO1)
	{
		if(response) 
		{
			switch(listitem)
			{
				case 0:
				{
					new carid = pData[playerid][pListitems];
					if(!IsValidVehicle(pvData[carid][cVeh])) return 0;
					if(pvData[carid][cOwner] == pData[playerid][pID] && pvData[carid][cImpound] == 0 && pvData[carid][cClaim] == 0 && pvData[carid][cPark] == -1)
					{
						foreach(new i : Player)
						{
							if(GetPlayerState(i) == PLAYER_STATE_DRIVER && GetPlayerVehicleID(i) == carid)
							{
								Error(playerid, "Vehicles cannot be di despawn");
							}
							else
							{
								new Float:x, Float:y, Float:z;
								GetVehiclePos(pvData[carid][cVeh], x, y, z);
								if(IsPlayerInRangeOfPoint(playerid, 20.0, x, y, z))
								{
									SetVehicleVirtualWorld(pvData[carid][cVeh], 12);
									pvData[carid][cImpound] = 4;
									SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"You have successfully "YELLOW_E"despawned "WHITE_E"the {00FFFF}%s "WHITE_E"vehicle", GetVehicleModelName(pvData[carid][cModel]));
								}
							}
						}		
					}
				}
				case 1:
				{
					new carid = pData[playerid][pListitems];
					if(pvData[carid][cOwner] == pData[playerid][pID] && pvData[carid][cImpound] == 4 && pvData[carid][cClaim] == 0 && pvData[carid][cPark] == -1)
					{
						foreach(new i : Player)
						{
							new Float:x, Float:y, Float:z;
							GetVehiclePos(pvData[carid][cVeh], x, y, z);
							if(IsPlayerInRangeOfPoint(playerid, 20.0, x, y, z))
							{
								SetVehicleVirtualWorld(pvData[carid][cVeh], GetPlayerVirtualWorld(playerid));
								LinkVehicleToInterior(pvData[carid][cVeh], GetPlayerInterior(playerid));
								pvData[carid][cImpound] = 0;
								SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"You have successfully "YELLOW_E"spawned "WHITE_E"the {00FFFF}%s "WHITE_E"vehicle", GetVehicleModelName(pvData[carid][cModel]));
							}
						}		
					}
				}
				case 2:
				{
					new i = pData[playerid][pListitems];
					new irwan[500], string[500];
					if(!IsValidVehicle(pvData[i][cVeh])) return 0;
					if(pvData[i][cOwner] == pData[playerid][pID])
					{
						format(string, sizeof(string), "{FFFFFF}Vehicle: {00FFFF}%s\n", GetVehicleModelName(pvData[i][cModel]));
						strcat(irwan, string);
						format(string, sizeof(string), "{FFFFFF}Plate Vehicle: {FFFF00}%s\n", pvData[i][cPlate]);
						strcat(irwan, string);
						format(string, sizeof(string), "{FFFFFF}Insurance: {FFFF00}%d year(s)\n", pvData[i][cInsu]);
						strcat(irwan, string);
						format(string, sizeof(string), "{FFFFFF}Upgarde\n");
						strcat(irwan, string);
						if(pvData[i][cMesinUpgrade] == 1)
						{
							format(string, sizeof(string), "{FFFFFF}- {00FF00}Engine\n");
							strcat(irwan, string);
						}	
						if(pvData[i][pvBodyUpgrade] == 1)
						{
							format(string, sizeof(string), "{FFFFFF}- {00FF00}Body");
							strcat(irwan, string);
						}	
						format(string, sizeof(string), "{FFFFFF}Input a player ID or Name to show this information to other player:"GREEN_E" input below\n");
						strcat(irwan, string);
						ShowPlayerDialog(playerid, DIALOG_VEHDETAIL, DIALOG_STYLE_INPUT, "Vehicle Detail", irwan, "Show", "Back");
					}
				}
				case 3:
				{
					new Float:posisiX, Float:posisiY, Float:posisiZ,
						carid = pData[playerid][pListitems];
					new S3MP4K[212];
					if(pvData[carid][cOwner] == pData[playerid][pID] && pvData[carid][cClaim] == 0)
					{
						GetVehiclePos(pvData[carid][cVeh], posisiX, posisiY, posisiZ);
						pData[playerid][pTrackCar] = 1;
						SetPlayerRaceCheckpoint(playerid,1, posisiX, posisiY, posisiZ, 0.0, 0.0, 0.0, 3.5);
						format(S3MP4K, sizeof(S3MP4K), "HINT: {FFFFFF}Your car waypoint was set to "YELLOW_E"%s.", GetLocation(posisiX, posisiY, posisiZ));
						SendClientMessageEx(playerid, COLOR_ARWIN, S3MP4K);	
					}
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_TRACKVEH)
	{
		if(response) 
		{	
			new Float:posisiX, Float:posisiY, Float:posisiZ,
				carid = strval(inputtext);
			new S3MP4K[512];	
			foreach(new veh : PVehicles)
			{
				if(carid == pvData[veh][cVeh] && pvData[veh][cImpound] == 0)
				{
					if(IsValidVehicle(pvData[veh][cVeh]))
					{
						if(pvData[veh][cOwner] == pData[playerid][pID])
						{
							GetVehiclePos(carid, posisiX, posisiY, posisiZ);
							pData[playerid][pTrackCar] = 1;
							//SetPlayerCheckpoint(playerid, posisi[0], posisi[1], posisi[2], 4.0);
							SetPlayerRaceCheckpoint(playerid,1, posisiX, posisiY, posisiZ, 0.0, 0.0, 0.0, 3.5);
						    format(S3MP4K, sizeof(S3MP4K), "HINT: {FFFFFF}Your car waypoint was set to "YELLOW_E"%s.", GetLocation(posisiX, posisiY, posisiZ));
							SendClientMessageEx(playerid, COLOR_ARWIN, S3MP4K);	
						}
						else return Error(playerid, "Id kendaraan ini bukan milik anda!");
					}
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_GOTOVEH)
	{
		if(response) 
		{
			new Float:posisiX, Float:posisiY, Float:posisiZ,
				carid = strval(inputtext);
			
			GetVehiclePos(carid, posisiX, posisiY, posisiZ);
			Info(playerid, "Your teleport to %s (vehicle id: %d).", GetLocation(posisiX, posisiY, posisiZ), carid);
			SetPlayerPosition(playerid, posisiX, posisiY, posisiZ+3.0, 4.0, 0);
		}
		return 1;
	}
	if(dialogid == DIALOG_GETVEH)
	{
		if(response) 
		{
			new Float:posisiX, Float:posisiY, Float:posisiZ,
				carid = strval(inputtext);
			
			GetPlayerPos(playerid, posisiX, posisiY, posisiZ);
			Info(playerid, "Your get spawn vehicle to %s (vehicle id: %d).", GetLocation(posisiX, posisiY, posisiZ), carid);
			SetVehiclePos(carid, posisiX, posisiY, posisiZ+0.5);
		}
		return 1;
	}
	if(dialogid == DIALOG_DELETEVEH)
	{
		if(response) 
		{
			new carid = strval(inputtext);
			
			//for(new i = 0; i != MAX_PRIVATE_VEHICLE; i++) if(Iter_Contains(PVehicles, i))
			foreach(new i : PVehicles)			
			{
				if(carid == pvData[i][cVeh])
				{
					new query[128];
					mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehicle WHERE id = '%d'", pvData[i][cID]);
					mysql_tquery(g_SQL, query);
					DestroyVehicle(pvData[i][cVeh]);
					Iter_SafeRemove(PVehicles, i, i);
					Servers(playerid, "Your deleted private vehicle id %d (database id: %d).", pvData[i][cVeh], pvData[i][cID]);
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_BUYPLATE)
	{
		if(response) 
		{
			new i = gListedItems[playerid][listitem];
			new price = pvData[i][cPrice] / 95;
			if(GetPlayerMoney(playerid) < price) return Error(playerid, "You don't have enough money to pay the fine");
			if(!IsValidVehicle(pvData[i][cVeh])) return 0;
			if(pvData[i][cOwner] == pData[playerid][pID])
			{
				format(pvData[i][cPlate], 32, "%s", GenerateRandomPlate());
				new plate[62];
				format(plate, sizeof(plate), ""GREEN_E"%s", pvData[i][cPlate]);
				SetVehicleNumberPlate(pvData[i][cVeh], plate);
				pvData[i][cPlateTime] = gettime() + (91 * 86400);
				GivePlayerMoneyEx(playerid, -price);
				SendClientMessageEx(playerid, COLOR_ARWIN, "VEHICLE: "WHITE_E"Model: %s || New plate: %s || Plate Time: %s", GetVehicleModelName(pvData[i][cModel]), pvData[i][cPlate], ReturnTimelapse(gettime(), pvData[i][cPlateTime]));
			}	
		}
		return 1;
	}
	//-----------[ Player Commands Dialog ]----------
	if(dialogid == DIALOG_HELP)
    {
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Players Help", "/drag /undrag /items /frisk /give /pay /stats /use /togmask /weapon /deny /accept /accent /eject /showlicense /showvehlic /buy /helmet /deposit /withdraw /death /settings /togauto", "Ok", "Kembali");
			}
			case 1:
			{
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Chat Help", "/n /l /s /pm /togpm /w /o /me /ame /ado /do /try", "Ok", "Kembali");
			}
			case 2:
			{
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Vehicle Help", "/mv /engine /light /trunk /lock /tow /untow /unimpound /unlocktire /buyplate /givepv", "Ok", "Kembali");
			}
			case 3:
			{
				ShowPlayerDialog(playerid, DIALOG_HELP_JOBS, DIALOG_STYLE_LIST, "Jobs", "{00FFFF}Jobs: "WHITE_E"Taxi Drivers\n{00FFFF}Jobs: "WHITE_E"Mechanic\n{00FFFF}Jobs: "WHITE_E"Lumber Jack\n{00FFFF}Jobs: "WHITE_E"Trucker\n{00FFFF}Jobs: "WHITE_E"Farmer\n{00FFFF}Jobs: "WHITE_E"Builder\n"YELLOW_E"Sidejobs: "WHITE_E"TrashMaster\n"YELLOW_E"Sidejobs: "WHITE_E"Forklift\n"RED_E"IlegalJobs: "WHITE_E"Arms Dealer\n"RED_E"IlegalJobs: "WHITE_E"Drugs Dealer\n"RED_E"IlegalJobs: "WHITE_E"Smuggle", "Select", "Close");
				return 1;
			}
			case 4:
			{
				return callcmd::factionhelp(playerid);
			}
			case 5:
			{
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Family Help", "/fsafe /finvite /funinvite /fsetrank /finfo", "Ok", "Kembali");
			}
			case 6:
			{
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Bisnis Help", "/buy /bm /lockbisnis /unlockbisnis /bwithdraw /bdeposit", "Ok", "Kembali");
			}
			case 7:
			{
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "House Help", "/buyhouse /lockhouse /hm /myhouse /findhouse", "Ok", "Kembali");
			}
			case 8:
			{
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Flat Help", "/buyflat /flock /flatmenu", "Ok", "Kembali");
			}
			case 9:
			{
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Workshop Help", "/buy /wsafe /winvite /wuninvite /winfo /sellworkshop", "Ok", "Kembali");
			}
			case 10:
			{
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Farm Help", "/buy /lainvite /launinvite /lasafe /lainfo /sellfarm", "Ok", "Kembali");
			}
			case 11:
			{
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Donatur Help", "/gshop /cv /togvip /radio", "Ok", "Kembali");
			}
			case 12:
			{
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "FurnStore Help", "/buyfurnstore /fsm /buyfurniture", "Ok", "Kembalik");
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_HELP_JOBS)
    {
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Jobs Taxi Help", "/jobduty /flare /accept taxi", "Ok", "Kembali");
			}
			case 1:
			{
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Jobs Mechanic Help", "/jobduty /vm /acceptmecha /unloadcomponent /loadcomponent", "Ok", "Kembali");
			}
			case 2:
			{
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "LumberJack Help", "/lumber cut /lumber take /lumber sell /lumber pickup /findtree", "Ok", "Kembali");
			}
			case 3:
			{
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Trucker Help", "/missions /getcrate /loadcrate /dropcrate /unloadcrate", "Ok", "Kembali");
			}
			case 4:
			{
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Farmer Help", "/plant /buyseeds /unloadplant /loadplant", "Ok", "Kembali");
			}
			case 5:
			{
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Builder Help", "/cb /eb", "Ok", "Kembali");
			}
			case 6:
			{
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Trashmaster Help", "/loadtrash", "Ok", "Kembali");
			}
			case 7:
			{
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Forklift Help", "/loadcrate /unloadcreate", "Ok", "Kembali");
			}
			case 8:
			{
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Arms Dealer Help", "/buypacket /creategun /createammo /givegun", "Ok", "Kembali");
			}
			case 9:
			{
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Drugs Dealer Help", "/buycrack", "Ok", "Kembali");
			}
			case 10:
			{
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Smuggle Help", "/findpacket /takepacket /givepacket", "Ok", "Kembali");
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_TRACKBIZRESTO)
	{
		if(response)
		{
			new bid = gListedItems[playerid][listitem];

			SetPlayerRaceCheckpoint(playerid, 1, bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ], 0,0,0, 5); //type ,x ,y ,z pertama terus kedua sebagai arah x, y, z, range
			SendClientMessageEx(playerid, COLOR_ARWIN, "GPS: "WHITE_E"Bisnis Checkpoint targeted! "YELLOW_E"(%s)", GetLocation(bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ]));
		}
		else return ShowPlayerDialog(playerid, DIALOG_GPS, DIALOG_STYLE_LIST, "GPS Menu", "Public Location\nDealership\nRestaurants\nElectronic Store\nSports Store\nSupermarket\nClothes Store\nGas Station\nWorkshop\nMy Vehicle", "Select", "Close");
	}
	
	if(dialogid == DIALOG_TRACKBIZELE)
	{
		if(response)
		{
			new bid = gListedItems[playerid][listitem];

			SetPlayerRaceCheckpoint(playerid, 1, bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ], 0,0,0, 5); //type ,x ,y ,z pertama terus kedua sebagai arah x, y, z, range
			SendClientMessageEx(playerid, COLOR_ARWIN, "GPS: "WHITE_E"Bisnis Checkpoint targeted! "YELLOW_E"(%s)", GetLocation(bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ]));
		}
		else return ShowPlayerDialog(playerid, DIALOG_GPS, DIALOG_STYLE_LIST, "GPS Menu", "Public Location\nDealership\nRestaurants\nElectronic Store\nSports Store\nSupermarket\nClothes Store\nGas Station\nWorkshop\nMy Vehicle", "Select", "Close");
	}
	
	if(dialogid == DIALOG_TRACKBIZSPORTS)
	{
		if(response)
		{
			new bid = gListedItems[playerid][listitem];

			SetPlayerRaceCheckpoint(playerid, 1, bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ], 0,0,0, 5); //type ,x ,y ,z pertama terus kedua sebagai arah x, y, z, range
			SendClientMessageEx(playerid, COLOR_ARWIN, "GPS: "WHITE_E"Bisnis Checkpoint targeted! "YELLOW_E"(%s)", GetLocation(bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ]));
		}
		else return ShowPlayerDialog(playerid, DIALOG_GPS, DIALOG_STYLE_LIST, "GPS Menu", "Public Location\nDealership\nRestaurants\nElectronic Store\nSports Store\nSupermarket\nClothes Store\nGas Station\nWorkshop\nMy Vehicle", "Select", "Close");
	}
	if(dialogid == DIALOG_TRACKBIZMARKET)
	{
		if(response)
		{
			new bid = gListedItems[playerid][listitem];

			SetPlayerRaceCheckpoint(playerid, 1, bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ], 0,0,0, 5); //type ,x ,y ,z pertama terus kedua sebagai arah x, y, z, range
			SendClientMessageEx(playerid, COLOR_ARWIN, "GPS: "WHITE_E"Bisnis Checkpoint targeted! (%s)", GetLocation(bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ]));
		}
		else return ShowPlayerDialog(playerid, DIALOG_GPS, DIALOG_STYLE_LIST, "GPS Menu", "Public Location\nDealership\nRestaurants\nElectronic Store\nSports Store\nSupermarket\nClothes Store\nGas Station\nWorkshop\nMy Vehicle", "Select", "Close");
	}
	if(dialogid == DIALOG_TRACKBIZCLOTHES)
	{
		if(response)
		{
			new bid = gListedItems[playerid][listitem];

			SetPlayerRaceCheckpoint(playerid, 1, bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ], 0,0,0, 5); //type ,x ,y ,z pertama terus kedua sebagai arah x, y, z, range
			SendClientMessageEx(playerid, COLOR_ARWIN, "GPS: "WHITE_E"Bisnis Checkpoint targeted! (%s)", GetLocation(bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ]));
		}
		else return ShowPlayerDialog(playerid, DIALOG_GPS, DIALOG_STYLE_LIST, "GPS Menu", "Public Location\nDealership\nRestaurants\nElectronic Store\nSports Store\nSupermarket\nClothes Store\nGas Station\nWorkshop\nMy Vehicle", "Select", "Close");
	}
	if(dialogid == DIALOG_TRACKWS)
	{
		if(response)
		{
			new id = gListedItems[playerid][listitem];

			SetPlayerRaceCheckpoint(playerid, 1, wData[id][wExtposX], wData[id][wExtposY], wData[id][wExtposZ], 0,0,0, 5); //type ,x ,y ,z pertama terus kedua sebagai arah x, y, z, range
			SendClientMessageEx(playerid, COLOR_ARWIN, "GPS: "WHITE_E"Workshop Checkpoint targeted! (%s)", GetLocation(wData[id][wExtposX], wData[id][wExtposY], wData[id][wExtposZ]));
		}
		else return ShowPlayerDialog(playerid, DIALOG_GPS, DIALOG_STYLE_LIST, "GPS Menu", "Public Location\nDealership\nRestaurants\nElectronic Store\nSports Store\nSupermarket\nClothes Store\nGas Station\nWorkshop\nMy Vehicle", "Select", "Close");
	}
	if(dialogid == DIALOG_TRACKGAS)
	{
		if(response)
		{
			new gsid = gListedItems[playerid][listitem];

			SetPlayerRaceCheckpoint(playerid, 1, gsData[gsid][gsPosX], gsData[gsid][gsPosY], gsData[gsid][gsPosZ], 0,0,0, 5); //type ,x ,y ,z pertama terus kedua sebagai arah x, y, z, range
			SendClientMessageEx(playerid, COLOR_ARWIN, "GPS: "WHITE_E"Gas Station Checkpoint targeted! (%s)", GetLocation(gsData[gsid][gsPosX], gsData[gsid][gsPosY], gsData[gsid][gsPosZ]));
		}
		else return ShowPlayerDialog(playerid, DIALOG_GPS, DIALOG_STYLE_LIST, "GPS Menu", "Public Location\nDealership\nRestaurants\nElectronic Store\nSports Store\nSupermarket\nClothes Store\nGas Station\nWorkshop\nMy Vehicle", "Select", "Close");
	}
	if(dialogid == DIALOG_GPS_DEALER)
	{
		if(response)
		{
			new dealershipid = gListedItems[playerid][listitem];

			SetPlayerRaceCheckpoint(playerid, 1, CarDealershipInfo[dealershipid][cdEntranceX], CarDealershipInfo[dealershipid][cdEntranceY], CarDealershipInfo[dealershipid][cdEntranceZ], 0,0,0, 5); //type ,x ,y ,z pertama terus kedua sebagai arah x, y, z, range
			SendClientMessageEx(playerid, COLOR_ARWIN, "GPS: "WHITE_E"Dealership Checkpoint targeted! (%s)", GetLocation(CarDealershipInfo[dealershipid][cdEntranceX], CarDealershipInfo[dealershipid][cdEntranceY], CarDealershipInfo[dealershipid][cdEntranceZ]));
		}
		else return ShowPlayerDialog(playerid, DIALOG_GPS, DIALOG_STYLE_LIST, "GPS Menu", "Public Location\nDealership\nRestaurants\nElectronic Store\nSports Store\nSupermarket\nClothes Store\nGas Station\nWorkshop\nMy Vehicle", "Select", "Close");
	}
	if(dialogid == DIALOG_GPS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					ShowPlayerDialog(playerid, DIALOG_GPS_PUBLIC, DIALOG_STYLE_LIST, "GPS Menu", "General\nJobs\nSidejobs", "Select", "Close");
				}
				case 1:
				{
					new msg2[512], found = false;
					format(msg2, sizeof(msg2), "Name\tDistance\n");
					for(new id = 0; id < MAX_CARDEALERSHIPS; id++)
					{	
						gListedItems[playerid][found] = id;
						format(msg2,sizeof(msg2), "%s%s\t%0.2fm\n", msg2, CarDealershipInfo[id][cdMessage], GetPlayerDistanceFromPoint(playerid,CarDealershipInfo[id][cdEntranceX], CarDealershipInfo[id][cdEntranceY], CarDealershipInfo[id][cdEntranceZ]));
						found++;
					}
					ShowPlayerDialog(playerid, DIALOG_GPS_DEALER, DIALOG_STYLE_TABLIST_HEADERS,"GPS: Dealership",msg2,"Goto","Cancel");
				}
				case 2:
				{
					new msg2[512], found = false;
					format(msg2, sizeof(msg2), "Name\tDistance\n");
					for(new id = 0; id < MAX_BISNIS; id++)
					{	
						if(bData[id][bType] == 1)
						{
							gListedItems[playerid][found] = id;
							format(msg2,sizeof(msg2), "%s%s\t%0.2fm\n", msg2, bData[id][bName], GetPlayerDistanceFromPoint(playerid, bData[id][bExtposX], bData[id][bExtposY], bData[id][bExtposZ]));
							found++;
						}
					}
					ShowPlayerDialog(playerid, DIALOG_TRACKBIZRESTO, DIALOG_STYLE_TABLIST_HEADERS,"GPS: Restaurant",msg2,"Goto","Cancel");
				}
				case 3:
				{
					new msg2[512], found = false;
					format(msg2, sizeof(msg2), "Name\tDistance\n");
					for(new id = 0; id < MAX_BISNIS; id++)
					{	
						if(bData[id][bType] == 5)
						{
							gListedItems[playerid][found] = id;
							format(msg2,sizeof(msg2), "%s%s\t%0.2fm\n", msg2, bData[id][bName], GetPlayerDistanceFromPoint(playerid, bData[id][bExtposX], bData[id][bExtposY], bData[id][bExtposZ]));
							found++;
						}
					}
					ShowPlayerDialog(playerid, DIALOG_TRACKBIZELE, DIALOG_STYLE_TABLIST_HEADERS,"GPS: Electronic",msg2,"Goto","Cancel");
				}
				case 4:
				{
					new msg2[512], found = false;
					format(msg2, sizeof(msg2), "Name\tDistance\n");
					for(new id = 0; id < MAX_BISNIS; id++)
					{	
						if(bData[id][bType] == 4)
						{
							gListedItems[playerid][found] = id;
							format(msg2,sizeof(msg2), "%s%s\t%0.2fm\n", msg2, bData[id][bName], GetPlayerDistanceFromPoint(playerid, bData[id][bExtposX], bData[id][bExtposY], bData[id][bExtposZ]));
							found++;
						}
					}
					ShowPlayerDialog(playerid, DIALOG_TRACKBIZSPORTS, DIALOG_STYLE_TABLIST_HEADERS,"GPS: Sports Store",msg2,"Goto","Cancel");
				}
				case 5:
				{
					new msg2[512], found = false;
					format(msg2, sizeof(msg2), "Name\tDistance\n");
					for(new id = 0; id < MAX_BISNIS; id++)
					{	
						if(bData[id][bType] == 2)
						{
							gListedItems[playerid][found] = id;
							format(msg2,sizeof(msg2), "%s%s\t%0.2fm\n", msg2, bData[id][bName], GetPlayerDistanceFromPoint(playerid, bData[id][bExtposX], bData[id][bExtposY], bData[id][bExtposZ]));
							found++;
						}
					}
					ShowPlayerDialog(playerid, DIALOG_TRACKBIZMARKET, DIALOG_STYLE_TABLIST_HEADERS,"GPS: Supermarket",msg2,"Goto","Cancel");
				}
				case 6:
				{
					new msg2[512], found = false;
					format(msg2, sizeof(msg2), "Name\tDistance\n");
					for(new id = 0; id < MAX_BISNIS; id++)
					{	
						if(bData[id][bType] == 3)
						{
							gListedItems[playerid][found] = id;
							format(msg2,sizeof(msg2), "%s%s\t%0.2fm\n", msg2, bData[id][bName], GetPlayerDistanceFromPoint(playerid, bData[id][bExtposX], bData[id][bExtposY], bData[id][bExtposZ]));
							found++;
						}
					}
					ShowPlayerDialog(playerid, DIALOG_TRACKBIZCLOTHES, DIALOG_STYLE_TABLIST_HEADERS,"GPS: Clothes",msg2,"Goto","Cancel");
				}
				case 7:
				{
					new msg2[512], found = false;
					format(msg2, sizeof(msg2), "Name\tDistance\n");
					foreach(new id : GStation)
					{
						gListedItems[playerid][found] = id;
						format(msg2,sizeof(msg2), "%s%s\t%0.2fm\n", msg2, GetLocation(gsData[id][gsPosX], gsData[id][gsPosY], gsData[id][gsPosZ]), GetPlayerDistanceFromPoint(playerid, gsData[id][gsPosX], gsData[id][gsPosY], gsData[id][gsPosZ]));
						found++;
					}
					ShowPlayerDialog(playerid, DIALOG_TRACKGAS, DIALOG_STYLE_TABLIST_HEADERS,"GPS: Gas Station",msg2,"Goto","Cancel");
				}
				case 8:
				{
					new msg2[512], found = false;
					format(msg2, sizeof(msg2), "Name\tDistance\n");
					foreach(new id : WORKSHOPS)
					{
						gListedItems[playerid][found] = id;
						format(msg2,sizeof(msg2), "%s%s\t%0.2fm\n", msg2, wData[id][wName], GetPlayerDistanceFromPoint(playerid, wData[id][wExtposX], wData[id][wExtposY], wData[id][wExtposZ]));
						found++;
					}
					ShowPlayerDialog(playerid, DIALOG_TRACKWS, DIALOG_STYLE_TABLIST_HEADERS,"GPS: Workshop",msg2,"Goto","Cancel");
				}
				case 9:
				{
					return callcmd::mv(playerid, "");
				}
			}
		}
	}
	if(dialogid == DIALOG_TRACKTREE)
	{
		if(response)
		{
			new id = ReturnTreeID((listitem + 1));

			pData[playerid][pLoc] = id;
			SetPlayerRaceCheckpoint(playerid,1, TreeData[id][treeX], TreeData[id][treeY], TreeData[id][treeZ], 0.0, 0.0, 0.0, 3.5);
			Info(playerid, "Tree Checkpoint targeted! (%s)", GetLocation(TreeData[id][treeX], TreeData[id][treeY], TreeData[id][treeZ]));
		}
	}
	if(dialogid == DIALOG_GPS_PUBLIC)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					ShowPlayerDialog(playerid, DIALOG_GPS_GENERAL, DIALOG_STYLE_LIST, "GPS Menu", "Bank Los Santos\nDriving School\nMechanic City\nInsurance Company\nComponent Factory\nLos Santos Fish Factory\nLos Santos Impound Center\nCity Hall\nModshop\nBoat Repair", "Select", "Close");
				}
				case 1:
				{
					ShowPlayerDialog(playerid, DIALOG_GPS_JOB, DIALOG_STYLE_LIST, "GPS JOB", "Taxi\nMechanic\nLumber Jack\nTrucker\nFarmer", "Select", "Close");
				}
				case 2:
				{
					ShowPlayerDialog(playerid, DIALOG_GPS_SIDEJOB, DIALOG_STYLE_LIST, "GPS JOB", "Sidejob: Sweeper\nSidejob: Bus [A/B]\nSidejob: TrashMaster\nSidejob: Forklift\nActivity: Fishing", "Select", "Close");
				}
			}
		}
		else return ShowPlayerDialog(playerid, DIALOG_GPS, DIALOG_STYLE_LIST, "GPS Menu", "Public Location\nDealership\nRestaurants\nElectronic Store\nSports Store\nSupermarket\nClothes Store\nGas Station\nWorkshop\nMy Vehicle", "Select", "Close");
	}
	if(dialogid == DIALOG_GPS_SIDEJOB)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					SetPlayerRaceCheckpoint(playerid,1, 1625.3225, -1892.8766, 13.5503, 0.0, 0.0, 0.0, 3.5); //Swpper
					SendClientMessageEx(playerid, COLOR_ARWIN, "HINT: "WHITE_E"GPS active! follow the checkpoint.");
					
				}
				case 1:
				{
					SetPlayerRaceCheckpoint(playerid,1, 1697.1055,-1530.4958,13.3828, 0.0, 0.0, 0.0, 3.5); //Bus
					SendClientMessageEx(playerid, COLOR_ARWIN, "HINT: "WHITE_E"GPS active! follow the checkpoint.");
					
				}
				case 2:
				{
					SetPlayerRaceCheckpoint(playerid,1, 2094.4639,-2040.1442,14.0958, 0.0, 0.0, 0.0, 3.5); //TrashMaster
					SendClientMessageEx(playerid, COLOR_ARWIN, "HINT: "WHITE_E"GPS active! follow the checkpoint.");
					
				}
				case 3:
				{
					SetPlayerRaceCheckpoint(playerid,1, 2742.4250,-2420.9465,13.6463, 0.0, 0.0, 0.0, 3.5); //Forklift
					SendClientMessageEx(playerid, COLOR_ARWIN, "HINT: "WHITE_E"GPS active! follow the checkpoint.");
					
				}
				case 4:
				{
					SetPlayerRaceCheckpoint(playerid,1, 361.2099,-2032.1703,7.8359, 0.0, 0.0, 0.0, 3.5); //Fish
					SendClientMessageEx(playerid, COLOR_ARWIN, "HINT: "WHITE_E"GPS active! follow the checkpoint.");
					
				}
			}
		}
		else return ShowPlayerDialog(playerid, DIALOG_GPS_PUBLIC, DIALOG_STYLE_LIST, "GPS Menu", "General\nJobs\nSidejobs", "Select", "Close");
	}
	if(dialogid == DIALOG_GPS_GENERAL)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					SetPlayerRaceCheckpoint(playerid,1, 1462.2328,-1021.0492,24.1048, 0.0, 0.0, 0.0, 3.5);
					SendClientMessageEx(playerid, COLOR_ARWIN, "HINT: "WHITE_E"GPS active! follow the checkpoint.");
				}
				case 1:
				{
					SetPlayerRaceCheckpoint(playerid,1, 2059.1587,-1912.5458,13.5469, 0.0, 0.0, 0.0, 3.5);
					SendClientMessageEx(playerid, COLOR_ARWIN, "HINT: "WHITE_E"GPS active! follow the checkpoint.");
				}
				case 2:
				{
					SetPlayerRaceCheckpoint(playerid,1, 1629.6818,-1825.1205,13.1310, 0.0, 0.0, 0.0, 3.5);
					SendClientMessageEx(playerid, COLOR_ARWIN, "HINT: "WHITE_E"GPS active! follow the checkpoint.");
				}
				case 3:
				{
					SetPlayerRaceCheckpoint(playerid,1, 1657.9524,-1394.4664,13.5469, 0.0, 0.0, 0.0, 3.5);
					SendClientMessageEx(playerid, COLOR_ARWIN, "HINT: "WHITE_E"GPS active! follow the checkpoint.");
				}
				case 4:
				{
					SetPlayerRaceCheckpoint(playerid,1, 323.6411, 904.5583, 21.5862, 0.0, 0.0, 0.0, 3.5);
					SendClientMessageEx(playerid, COLOR_ARWIN, "HINT: "WHITE_E"GPS active! follow the checkpoint.");
				}
				case 5:
				{
					SetPlayerRaceCheckpoint(playerid,1, 2836.3945,-1541.1984,11.0991, 0.0, 0.0, 0.0, 3.5);
					SendClientMessageEx(playerid, COLOR_ARWIN, "HINT: "WHITE_E"GPS active! follow the checkpoint.");
				}
				case 6:
				{
					SetPlayerRaceCheckpoint(playerid,1, 2820.2354, -1475.2073, 16.2500, 0.0, 0.0, 0.0, 3.5);
					SendClientMessageEx(playerid, COLOR_ARWIN, "HINT: "WHITE_E"GPS active! follow the checkpoint.");
				}
				case 7:
				{
					SetPlayerRaceCheckpoint(playerid,1, 1481.0156,-1772.1384,18.8370, 0.0, 0.0, 0.0, 3.5);
					SendClientMessageEx(playerid, COLOR_ARWIN, "HINT: "WHITE_E"GPS active! follow the checkpoint.");
				}
				case 8:
				{
					SetPlayerRaceCheckpoint(playerid,1, 2244.4438,-2002.7745,18.8555, 0.0, 0.0, 0.0, 3.5);
					SendClientMessageEx(playerid, COLOR_ARWIN, "HINT: "WHITE_E"GPS active! follow the checkpoint.");
				}
				case 9:
				{
					SetPlayerRaceCheckpoint(playerid,1, 2615.8027,-2473.2822,3.1963, 0.0, 0.0, 0.0, 3.5);
					SendClientMessageEx(playerid, COLOR_ARWIN, "HINT: "WHITE_E"GPS active! follow the checkpoint.");
				}
			}
		}
		else return ShowPlayerDialog(playerid, DIALOG_GPS, DIALOG_STYLE_LIST, "GPS Menu", "Public Location\nDealership\nRestaurants\nElectronic Store\nSports Store\nSupermarket\nClothes Store\nGas Station\nWorkshop\nMy Vehicle", "Select", "Close");
	}
	if(dialogid == DIALOG_GPS_CRATETRUCKER)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					SetPlayerRaceCheckpoint(playerid,1, 336.63, 891.82, 20.40, 0.0, 0.0, 0.0, 3.5);
					SendClientMessageEx(playerid, COLOR_ARWIN, "HINT: "WHITE_E"GPS active! follow the checkpoint.");
				}
				case 1:
				{
					SetPlayerRaceCheckpoint(playerid,1, 797.7953,-616.8799,16.3359, 0.0, 0.0, 0.0, 3.5);
					SendClientMessageEx(playerid, COLOR_ARWIN, "HINT: "WHITE_E"GPS active! follow the checkpoint.");
				}
				case 2:
				{
					SetPlayerRaceCheckpoint(playerid,1, 2836.3945,-1541.1984,11.0991, 0.0, 0.0, 0.0, 3.5);
					SendClientMessageEx(playerid, COLOR_ARWIN, "HINT: "WHITE_E"GPS active! follow the checkpoint.");
				}
				case 3:
				{
					SetPlayerRaceCheckpoint(playerid,1, -577.1335,-503.6530,25.5107, 0.0, 0.0, 0.0, 3.5);
					SendClientMessageEx(playerid, COLOR_ARWIN, "HINT: "WHITE_E"GPS active! follow the checkpoint.");
				}
			}
		}
		else return ShowPlayerDialog(playerid, DIALOG_GPS, DIALOG_STYLE_LIST, "GPS Menu", "Public Location\nRestaurants\nSupermarket\nClothes Store\nWorkshop\nFind Tree(Lumberjack)\nCrate Storage(Trucker)\nMy Vehicle\nMy House\nMy Bisnis", "Select", "Close");
	}
	if(dialogid == DIALOG_GPS_JOB)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					SetPlayerRaceCheckpoint(playerid,1, 1685.4528,-1464.4073,13.5469, 0.0,0.0,0.0, 3.5); //Taxi
					SendClientMessageEx(playerid, COLOR_ARWIN, "HINT: "WHITE_E"GPS active! follow the checkpoint.");
				}
				case 1:
				{
					SetPlayerRaceCheckpoint(playerid,1, 2330.1626,-2315.2642,13.5469, 0.0, 0.0, 0.0, 3.5); //Mechanic
					SendClientMessageEx(playerid, COLOR_ARWIN, "HINT: "WHITE_E"GPS active! follow the checkpoint.");
				}
				case 2:
				{
					SetPlayerRaceCheckpoint(playerid,1, -1438.4968,-1544.1377,101.7578, 0.0, 0.0, 0.0, 3.5); //Lumber
					SendClientMessageEx(playerid, COLOR_ARWIN, "HINT: "WHITE_E"GPS active! follow the checkpoint.");
					
				}
				case 3:
				{
					SetPlayerRaceCheckpoint(playerid,1, -77.1687,-1136.5388,1.0781, 0.0, 0.0, 0.0, 3.5); //Trucker
					SendClientMessageEx(playerid, COLOR_ARWIN, "HINT: "WHITE_E"GPS active! follow the checkpoint.");
				}
				case 4:
				{
					SetPlayerRaceCheckpoint(playerid,1, -382.7033,-1438.9998,26.1691, 0.0, 0.0, 0.0, 3.5); //Farmer
					SendClientMessageEx(playerid, COLOR_ARWIN, "HINT: "WHITE_E"GPS active! follow the checkpoint.");
				}
			}
		}
		else return ShowPlayerDialog(playerid, DIALOG_GPS_PUBLIC, DIALOG_STYLE_LIST, "GPS Menu", "General\nJobs\nSidejobs", "Select", "Close");
	}
	if(dialogid == DIALOG_GPS_RENTALVEH)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					SetPlayerRaceCheckpoint(playerid,1, 1303.38, 714.16, 10.87, 0.0,0.0,0.0, 3.5); //LV
					SendClientMessageEx(playerid, COLOR_ARWIN, "HINT: "WHITE_E"GPS active! follow the checkpoint.");
				}
				case 1:
				{
					SetPlayerRaceCheckpoint(playerid,1, 1732.5892,-1861.9855,13.5768, 0.0, 0.0, 0.0, 3.5); //LS
					SendClientMessageEx(playerid, COLOR_ARWIN, "HINT: "WHITE_E"GPS active! follow the checkpoint.");
				}
			}
		}
		else return ShowPlayerDialog(playerid, DIALOG_GPS_PUBLIC, DIALOG_STYLE_LIST, "GPS Menu", "General\nJobs\nSidejobs", "Select", "Close");
	}
	if(dialogid == DIALOG_PAY)
	{
		if(response)
		{
			new mstr[128];
			new otherid = GetPVarInt(playerid, "gcPlayer");
			new money = GetPVarInt(playerid, "gcAmount");

			if(otherid == INVALID_PLAYER_ID)
				return Error(playerid, "Player not connected!");
			GivePlayerMoneyEx(otherid, money);
			GivePlayerMoneyEx(playerid, -money);

			format(mstr, sizeof(mstr), "Server: "YELLOW_E"You have sent %s(%i) "GREEN_E"$%s", ReturnName(otherid), otherid, FormatMoney(money));
			SendClientMessage(playerid, COLOR_GREY, mstr);
			format(mstr, sizeof(mstr), "Server: "YELLOW_E"%s(%i) has sent you "GREEN_E"$%s", ReturnName(playerid), playerid, FormatMoney(money));
			SendClientMessage(otherid, COLOR_GREY, mstr);
			InfoTD_MSG(playerid, 3500, "~g~~h~Money Sent!");
			InfoTD_MSG(otherid, 3500, "~g~~h~Money received!");
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			
			new query[512];
			mysql_format(g_SQL, query, sizeof(query), "INSERT INTO logpay (player,playerid,toplayer,toplayerid,ammount,time) VALUES('%s','%d','%s','%d','%d',UNIX_TIMESTAMP())", pData[playerid][pName], pData[playerid][pID], pData[otherid][pName], pData[otherid][pID], money);
			mysql_tquery(g_SQL, query);
		}
		return 1;
	}
	//-------------[ Player Weapons Atth ]-----------2262.7527,2036.2036,10.8203,266.1790
	if(dialogid == DIALOG_EDITBONE)
	{
		if(response)
		{
			new weaponid = EditingWeapon[playerid], weaponname[18], string[150];
	 
			GetWeaponName(weaponid, weaponname, sizeof(weaponname));
		   
			WeaponSettings[playerid][weaponid - 1][Bone] = listitem + 1;

			SendClientMessageEx(playerid, COLOR_ARWIN, "WEAPONINFO: "WHITE_E"You have successfully changed the bone of your %s.", weaponname);
		   
			mysql_format(g_SQL, string, sizeof(string), "INSERT INTO weaponsettings (Owner, WeaponID, Bone) VALUES ('%d', %d, %d) ON DUPLICATE KEY UPDATE Bone = VALUES(Bone)", pData[playerid][pID], weaponid, listitem + 1);
			mysql_tquery(g_SQL, string);
		}
		EditingWeapon[playerid] = 0;
	}
	//------------[ Family Dialog ]------------
	if(dialogid == FAMILY_SAFE)
	{
		if(!response) return 1;
		new fid = pData[playerid][pFamily];
		switch(listitem)
		{
			case 0: Family_OpenStorage(playerid, fid);
			case 1:
			{
				//Marijuana
				ShowPlayerDialog(playerid, FAMILY_MARIJUANA, DIALOG_STYLE_LIST, "Marijuana", "Withdraw from safe\nDeposit into safe", "Select", "Back");
			}
			case 2:
			{
				//Component
				ShowPlayerDialog(playerid, FAMILY_COMPONENT, DIALOG_STYLE_LIST, "Component", "Withdraw from safe\nDeposit into safe", "Select", "Back");
			}
			case 3:
			{
				//Material
				ShowPlayerDialog(playerid, FAMILY_MATERIAL, DIALOG_STYLE_LIST, "Cgun", "Withdraw from safe\nDeposit into safe", "Select", "Back");
			}
			case 4:
			{
				//Money
				ShowPlayerDialog(playerid, FAMILY_MONEY, DIALOG_STYLE_LIST, "Money", "Withdraw from safe\nDeposit into safe", "Select", "Back");
			}
		}
		return 1;
	}
	if(dialogid == FAMILY_STORAGE)
	{
		new fid = pData[playerid][pFamily];
		if(response)
		{
			if(listitem == 0)
			{
				Family_WeaponStorage(playerid, fid);
			}
		}
		return 1;
	}
	if(dialogid == FAMILY_WEAPONS)
	{
		new fid = pData[playerid][pFamily];
		if(response)
		{
			if(fData[fid][fGun][listitem] != 0)
			{
				if(pData[playerid][pFamilyRank] < 5)
					return Error(playerid, "Only boss can taken the weapon!");

				GivePlayerWeaponEx(playerid, fData[fid][fGun][listitem], fData[fid][fAmmo][listitem]);

				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has taken a \"%s\" from their weapon storage.", ReturnName(playerid), ReturnWeaponName(fData[fid][fGun][listitem]));

				fData[fid][fGun][listitem] = 0;
				fData[fid][fAmmo][listitem] = 0;

				Family_Save(fid);
				Family_WeaponStorage(playerid, fid);
			}
			else
			{
				new
					weaponid = GetPlayerWeapon(playerid),
					ammo = GetPlayerAmmo(playerid);

				if(!weaponid)
					return Error(playerid, "You are not holding any weapon!");

				/*if(weaponid == 23 && pData[playerid][pTazer])
					return Error(playerid, "You can't store a tazer into your safe.");

				if(weaponid == 25 && pData[playerid][pBeanBag])
					return Error(playerid, "You can't store a beanbag shotgun into your safe.");*/

				ResetWeapon(playerid, weaponid);
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has stored a \"%s\" into their weapon storage.", ReturnName(playerid), ReturnWeaponName(weaponid));

				fData[fid][fGun][listitem] = weaponid;
				fData[fid][fAmmo][listitem] = ammo;

				Family_Save(fid);
				Family_WeaponStorage(playerid, fid);
			}
		}
		else
		{
			Family_OpenStorage(playerid, fid);
		}
		return 1;
	}
	if(dialogid == FAMILY_MARIJUANA)
	{
		if(response)
		{
			new fid = pData[playerid][pFamily];
			if(fid == -1) return Error(playerid, "You don't have family.");
			if(response)
			{
				switch (listitem)
				{
					case 0:
					{
						if(pData[playerid][pFamilyRank] < 5)
							return Error(playerid, "Only boss can withdraw marijuana!");

						new str[128];
						format(str, sizeof(str), "Marijuana Balance: %d\n\nPlease enter how much marijuana you wish to withdraw from the safe:", fData[fid][fMarijuana]);
						ShowPlayerDialog(playerid, FAMILY_WITHDRAWMARIJUANA, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
					}
					case 1:
					{
						new str[128];
						format(str, sizeof(str), "Marijuana Balance: %d\n\nPlease enter how much marijuana you wish to deposit into the safe:", fData[fid][fMarijuana]);
						ShowPlayerDialog(playerid, FAMILY_DEPOSITMARIJUANA, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
					}
				}
			}
			else callcmd::fsafe(playerid);
		}
		return 1;
	}
	// if(dialogid == FAMILY_WITHDRAWMARIJUANA)
	// {
	// 	new fid = pData[playerid][pFamily];
	// 	if(fid == -1) return Error(playerid, "You don't have family.");

	// 	if(response)
	// 	{
	// 		new amount = strval(inputtext);

	// 		if(isnull(inputtext))
	// 		{
	// 			new str[128];
	// 			format(str, sizeof(str), "Marijuana Balance: %d\n\nPlease enter how much marijuana you wish to withdraw from the safe:", fData[fid][fMarijuana]);
	// 			ShowPlayerDialog(playerid, FAMILY_WITHDRAWMARIJUANA, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
	// 			return 1;
	// 		}
	// 		if(amount < 1 || amount > fData[fid][fMarijuana])
	// 		{
	// 			new str[128];
	// 			format(str, sizeof(str), "Error: Insufficient funds.\n\nMarijuana Balance: %d\n\nPlease enter how much marijuana you wish to withdraw from the safe:", fData[fid][fMarijuana]);
	// 			ShowPlayerDialog(playerid, FAMILY_WITHDRAWMARIJUANA, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
	// 			return 1;
	// 		}
	// 		fData[fid][fMarijuana] -= amount;
	// 		pData[playerid][pMarijuana] += amount;

	// 		Family_Save(fid);
	// 		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has withdrawn %d marijuana from their family safe.", ReturnName(playerid), amount);
	// 		callcmd::fsafe(playerid);
	// 		return 1;
	// 	}
	// 	else callcmd::fsafe(playerid);
	// 	return 1;
	// }
	// if(dialogid == FAMILY_DEPOSITMARIJUANA)
	// {
	// 	new fid = pData[playerid][pFamily];
	// 	if(fid == -1) return Error(playerid, "You don't have family.");
	// 	if(response)
	// 	{
	// 		new amount = strval(inputtext);

	// 		if(isnull(inputtext))
	// 		{
	// 			new str[128];
	// 			format(str, sizeof(str), "Marijuana Balance: %d\n\nPlease enter how much marijuana you wish to deposit into the safe:", fData[fid][fMarijuana]);
	// 			ShowPlayerDialog(playerid, FAMILY_DEPOSITMARIJUANA, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
	// 			return 1;
	// 		}
	// 		if(amount < 1 || amount > pData[playerid][pMarijuana])
	// 		{
	// 			new str[128];
	// 			format(str, sizeof(str), "Error: Insufficient funds.\n\nMarijuana Balance: %d\n\nPlease enter how much marijuana you wish to deposit into the safe:", fData[fid][fMarijuana]);
	// 			ShowPlayerDialog(playerid, FAMILY_DEPOSITMARIJUANA, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
	// 			return 1;
	// 		}
	// 		fData[fid][fMarijuana] += amount;
	// 		pData[playerid][pMarijuana] -= amount;

	// 		Family_Save(fid);
	// 		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has deposited %d marijuana into their family safe.", ReturnName(playerid), amount);
	// 	}
	// 	else callcmd::fsafe(playerid);
	// 	return 1;
	// }
	if(dialogid == FAMILY_COMPONENT)
	{
		if(response)
		{
			new fid = pData[playerid][pFamily];
			if(fid == -1) return Error(playerid, "You don't have family.");
			if(response)
			{
				switch (listitem)
				{
					case 0:
					{
						if(pData[playerid][pFamilyRank] < 5)
							return Error(playerid, "Only boss can withdraw component!");

						new str[128];
						format(str, sizeof(str), "Component Balance: %d\n\nPlease enter how much component you wish to withdraw from the safe:", fData[fid][fComponent]);
						ShowPlayerDialog(playerid, FAMILY_WITHDRAWCOMPONENT, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
					}
					case 1:
					{
						new str[128];
						format(str, sizeof(str), "Component Balance: %d\n\nPlease enter how much component you wish to deposit into the safe:", fData[fid][fComponent]);
						ShowPlayerDialog(playerid, FAMILY_DEPOSITCOMPONENT, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
					}
				}
			}
			else callcmd::fsafe(playerid);
		}
		return 1;
	}
	if(dialogid == FAMILY_WITHDRAWCOMPONENT)
	{
		new fid = pData[playerid][pFamily];
		if(fid == -1) return Error(playerid, "You don't have family.");

		if(response)
		{
			new amount = strval(inputtext);

			if(isnull(inputtext))
			{
				new str[128];
				format(str, sizeof(str), "Component Balance: %d\n\nPlease enter how much component you wish to withdraw from the safe:", fData[fid][fComponent]);
				ShowPlayerDialog(playerid, FAMILY_WITHDRAWCOMPONENT, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
				return 1;
			}
			if(amount < 1 || amount > fData[fid][fComponent])
			{
				new str[128];
				format(str, sizeof(str), "Error: Insufficient funds.\n\nComponent Balance: %d\n\nPlease enter how much component you wish to withdraw from the safe:", fData[fid][fComponent]);
				ShowPlayerDialog(playerid, FAMILY_WITHDRAWCOMPONENT, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
				return 1;
			}
			fData[fid][fComponent] -= amount;
			pData[playerid][pComponent] += amount;

			Family_Save(fid);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has withdrawn %d component from their family safe.", ReturnName(playerid), amount);
			callcmd::fsafe(playerid);
			return 1;
		}
		else callcmd::fsafe(playerid);
		return 1;
	}
	if(dialogid == FAMILY_DEPOSITCOMPONENT)
	{
		new fid = pData[playerid][pFamily];
		if(fid == -1) return Error(playerid, "You don't have family.");
		if(response)
		{
			new amount = strval(inputtext);

			if(isnull(inputtext))
			{
				new str[128];
				format(str, sizeof(str), "Component Balance: %d\n\nPlease enter how much component you wish to deposit into the safe:", fData[fid][fComponent]);
				ShowPlayerDialog(playerid, FAMILY_DEPOSITCOMPONENT, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
				return 1;
			}
			if(amount < 1 || amount > pData[playerid][pComponent])
			{
				new str[128];
				format(str, sizeof(str), "Error: Insufficient funds.\n\nComponent Balance: %d\n\nPlease enter how much component you wish to deposit into the safe:", fData[fid][fComponent]);
				ShowPlayerDialog(playerid, FAMILY_DEPOSITCOMPONENT, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
				return 1;
			}
			fData[fid][fComponent] += amount;
			pData[playerid][pComponent] -= amount;

			Family_Save(fid);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has deposited %d component into their family safe.", ReturnName(playerid), amount);
		}
		else callcmd::fsafe(playerid);
		return 1;
	}
	if(dialogid == FAMILY_MATERIAL)
	{
		if(response)
		{
			new fid = pData[playerid][pFamily];
			if(fid == -1) return Error(playerid, "You don't have family.");
			if(response)
			{
				switch (listitem)
				{
					case 0:
					{
						if(pData[playerid][pFamilyRank] < 5)
							return Error(playerid, "Only boss can withdraw Cgun!");

						new str[128];
						format(str, sizeof(str), "Cgun Balance: %d\n\nPlease enter how much Cgun you wish to withdraw from the safe:", fData[fid][fMaterial]);
						ShowPlayerDialog(playerid, FAMILY_WITHDRAWMATERIAL, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
					}
					case 1:
					{
						new str[128];
						format(str, sizeof(str), "Cgun Balance: %d\n\nPlease enter how much Cgun you wish to deposit into the safe:", fData[fid][fMaterial]);
						ShowPlayerDialog(playerid, FAMILY_DEPOSITMATERIAL, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
					}
				}
			}
			else callcmd::fsafe(playerid);
		}
		return 1;
	}
	if(dialogid == FAMILY_WITHDRAWMATERIAL)
	{
		new fid = pData[playerid][pFamily];
		if(fid == -1) return Error(playerid, "You don't have family.");

		if(response)
		{
			new amount = strval(inputtext);

			if(isnull(inputtext))
			{
				new str[128];
				format(str, sizeof(str), "Cgun Balance: %d\n\nPlease enter how much Cgun you wish to withdraw from the safe:", fData[fid][fMaterial]);
				ShowPlayerDialog(playerid, FAMILY_WITHDRAWMATERIAL, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
				return 1;
			}
			if(amount < 1 || amount > fData[fid][fMaterial])
			{
				new str[128];
				format(str, sizeof(str), "Error: Insufficient funds.\n\nCgun Balance: %d\n\nPlease enter how much Cgun you wish to withdraw from the safe:", fData[fid][fMaterial]);
				ShowPlayerDialog(playerid, FAMILY_WITHDRAWMATERIAL, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
				return 1;
			}
			fData[fid][fMaterial] -= amount;
			pData[playerid][pCgun] += amount;

			Family_Save(fid);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has withdrawn %d Cgun from their family safe.", ReturnName(playerid), amount);
			callcmd::fsafe(playerid);
			return 1;
		}
		else callcmd::fsafe(playerid);
		return 1;
	}
	if(dialogid == FAMILY_DEPOSITMATERIAL)
	{
		new fid = pData[playerid][pFamily];
		if(fid == -1) return Error(playerid, "You don't have family.");
		if(response)
		{
			new amount = strval(inputtext);

			if(isnull(inputtext))
			{
				new str[128];
				format(str, sizeof(str), "Cgun Balance: %d\n\nPlease enter how much Cgun you wish to deposit into the safe:", fData[fid][fMaterial]);
				ShowPlayerDialog(playerid, FAMILY_DEPOSITMATERIAL, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
				return 1;
			}
			if(amount < 1 || amount > pData[playerid][pCgun])
			{
				new str[128];
				format(str, sizeof(str), "Error: Insufficient funds.\n\nCgun Balance: %d\n\nPlease enter how much Cgun you wish to deposit into the safe:", fData[fid][fMaterial]);
				ShowPlayerDialog(playerid, FAMILY_DEPOSITMATERIAL, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
				return 1;
			}
			fData[fid][fMaterial] += amount;
			pData[playerid][pCgun] -= amount;

			Family_Save(fid);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has deposited %d Cgun into their family safe.", ReturnName(playerid), amount);
		}
		else callcmd::fsafe(playerid);
		return 1;
	}
	if(dialogid == FAMILY_MONEY)
	{
		if(response)
		{
			new fid = pData[playerid][pFamily];
			if(fid == -1) return Error(playerid, "You don't have family.");
			if(response)
			{
				switch (listitem)
				{
					case 0:
					{
						if(pData[playerid][pFamilyRank] < 5)
							return Error(playerid, "Only boss can withdraw money!");

						new str[128];
						format(str, sizeof(str), "Money Balance: $%s\n\nPlease enter how much money you wish to withdraw from the safe:", FormatMoney(fData[fid][fMoney]));
						ShowPlayerDialog(playerid, FAMILY_WITHDRAWMONEY, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
					}
					case 1:
					{
						new str[128];
						format(str, sizeof(str), "Money Balance: $%s\n\nPlease enter how much money you wish to deposit into the safe:", FormatMoney(fData[fid][fMoney]));
						ShowPlayerDialog(playerid, FAMILY_DEPOSITMONEY, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
					}
				}
			}
			else callcmd::fsafe(playerid);
		}
		return 1;
	}
	if(dialogid == FAMILY_WITHDRAWMONEY)
	{
		new fid = pData[playerid][pFamily];
		if(fid == -1) return Error(playerid, "You don't have family.");

		if(response)
		{
			new amount = strval(inputtext);

			if(isnull(inputtext))
			{
				new str[128];
				format(str, sizeof(str), "Money Balance: $%s\n\nPlease enter how much money you wish to withdraw from the safe:", FormatMoney(fData[fid][fMoney]));
				ShowPlayerDialog(playerid, FAMILY_WITHDRAWMONEY, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
				return 1;
			}
			if(amount < 1 || amount > fData[fid][fMoney])
			{
				new str[128];
				format(str, sizeof(str), "Error: Insufficient funds.\n\nMoney Balance: $%s\n\nPlease enter how much money you wish to withdraw from the safe:", FormatMoney(fData[fid][fMoney]));
				ShowPlayerDialog(playerid, FAMILY_WITHDRAWMONEY, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
				return 1;
			}
			fData[fid][fMoney] -= amount;
			GivePlayerMoneyEx(playerid, amount);

			Family_Save(fid);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has withdrawn $%s money from their family safe.", ReturnName(playerid), FormatMoney(amount));
			callcmd::fsafe(playerid);
			return 1;
		}
		else callcmd::fsafe(playerid);
		return 1;
	}
	if(dialogid == FAMILY_DEPOSITMONEY)
	{
		new fid = pData[playerid][pFamily];
		if(fid == -1) return Error(playerid, "You don't have family.");
		if(response)
		{
			new amount = strval(inputtext);

			if(isnull(inputtext))
			{
				new str[128];
				format(str, sizeof(str), "Money Balance: $%s\n\nPlease enter how much money you wish to deposit into the safe:", FormatMoney(fData[fid][fMoney]));
				ShowPlayerDialog(playerid, FAMILY_DEPOSITMATERIAL, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
				return 1;
			}
			if(amount < 1 || amount > GetPlayerMoney(playerid))
			{
				new str[128];
				format(str, sizeof(str), "Error: Insufficient funds.\n\nMoney Balance: $%s\n\nPlease enter how much money you wish to deposit into the safe:", FormatMoney(fData[fid][fMoney]));
				ShowPlayerDialog(playerid, FAMILY_DEPOSITMATERIAL, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
				return 1;
			}
			fData[fid][fMoney] += amount;
			GivePlayerMoneyEx(playerid, -amount);

			Family_Save(fid);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has deposited $%s money into their family safe.", ReturnName(playerid), FormatMoney(amount));
		}
		else callcmd::fsafe(playerid);
		return 1;
	}
	if(dialogid == FAMILY_INFO)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					if(pData[playerid][pFamily] == -1)
						return Error(playerid, "You dont have family!");
					new query[512];
					mysql_format(g_SQL, query, sizeof(query), "SELECT name,leader,marijuana,component,material,money FROM familys WHERE ID = %d", pData[playerid][pFamily]);
					mysql_tquery(g_SQL, query, "ShowFamilyInfo", "i", playerid);
				}
				case 1:
				{
					if(pData[playerid][pFamily] == -1)
						return Error(playerid, "You dont have family!");

					new lstr[1024];
					format(lstr, sizeof(lstr), "Rank\tName\n");
					foreach(new i: Player)
					{
						if(pData[i][pFamily] == pData[playerid][pFamily])
						{
							format(lstr, sizeof(lstr), "%s%s\t%s(%d)", lstr, GetFamilyRank(i), pData[i][pName], i);
							format(lstr, sizeof(lstr), "%s\n", lstr);
						}
					}
					format(lstr, sizeof(lstr), "%s\n", lstr);
					ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Family Online", lstr, "Close", "");

				}
				case 2:
				{
					if(pData[playerid][pFamily] == -1)
						return Error(playerid, "You dont have family!");
					new query[512];
					mysql_format(g_SQL, query, sizeof(query), "SELECT username,familyrank FROM players WHERE family = %d", pData[playerid][pFamily]);
					mysql_tquery(g_SQL, query, "ShowFamilyMember", "i", playerid);
				}
			}
		}
		return 1;
	}
	// if(dialogid == APART_STORAGE)
	// {
	// 	if(!response) return 1;
	// 	switch(listitem)
	// 	{

	// 		case 0:
	// 		{
	// 			//Cgun Apart
	// 			ShowPlayerDialog(playerid, APART_CGUN, DIALOG_STYLE_LIST, "cGun", "Withdraw from safe\nDeposit into safe", "Select", "Back");
	// 		}
	// 		case 1:
	// 		{
	// 			//marijuana Apart
	// 			ShowPlayerDialog(playerid, APART_MARIJUANA, DIALOG_STYLE_LIST, "Marijuana", "Withdraw from safe\nDeposit into safe", "Select", "Back");
	// 		}
	// 		case 2:
	// 		{
	// 			//Component Apart
	// 			ShowPlayerDialog(playerid, APART_COMPONENT, DIALOG_STYLE_LIST, "Component", "Withdraw from safe\nDeposit into safe", "Select", "Back");
	// 		}
	// 		case 3:
	// 		{
	// 			//Material Apart
	// 			ShowPlayerDialog(playerid, APART_MATERIAL, DIALOG_STYLE_LIST, "Material", "Withdraw from safe\nDeposit into safe", "Select", "Back");
	// 		}
	// 	}
	// 	return 1;
	// }
	// if(dialogid == APART_CGUN)
	// {
	// 	if(response)
	// 	{
	// 		new ap = pData[playerid][pApart];
	// 		if(ap == -1) return Error(playerid, "You don't have Apart.");
	// 		if(response)
	// 		{
	// 			switch (listitem)
	// 			{
	// 				case 0:
	// 				{
	// 					new str[128];
	// 					format(str, sizeof(str), "cGun Balance: %d\n\nPlease enter how much cGun you wish to withdraw from the safe:", apData[ap][hcGun]);
	// 					ShowPlayerDialog(playerid, APART_WITHDRAWCGUN, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
	// 				}
	// 				case 1:
	// 				{
	// 					new str[128];
	// 					format(str, sizeof(str), "cGun Balance: %d\n\nPlease enter how much cGun you wish to deposit into the safe:", apData[ap][hcGun]);
	// 					ShowPlayerDialog(playerid, APART_DEPOSITCGUN, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
	// 				}
	// 			}
	// 		}
	// 		else callcmd::apsafe(playerid);
	// 	}
	// 	return 1;
	// }
	// if(dialogid == APART_WITHDRAWCGUN)
	// {
	// 	new ap = pData[playerid][pApart];
	// 	if(ap == -1) return Error(playerid, "You don't have Apart.");

	// 	if(response)
	// 	{
	// 		new amount = strval(inputtext);

	// 		if(isnull(inputtext))
	// 		{
	// 			new str[128];
	// 			format(str, sizeof(str), "cGun Balance: %d\n\nPlease enter how much cGun you wish to withdraw from the safe:", apData[ap][hcGun]);
	// 			ShowPlayerDialog(playerid, APART_WITHDRAWCGUN, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
	// 			return 1;
	// 		}
	// 		if(amount < 1 || amount > apData[ap][hcGun])
	// 		{
	// 			new str[128];
	// 			format(str, sizeof(str), "Error: Insufficient funds.\n\ncGun Balance: %d\n\nPlease enter how much cGun you wish to withdraw from the safe:", apData[ap][hcGun]);
	// 			ShowPlayerDialog(playerid, APART_WITHDRAWCGUN, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
	// 			return 1;
	// 		}
	// 		apData[ap][hcGun] -= amount;
	// 		pData[playerid][pCgun] += amount;

	// 		Apart_Save(ap);
	// 		SendClientMessageEx(playerid, COLOR_ARWIN, "APART: "WHITE_E"Kamu Berhasil withdraw "YELLOW_E"cGun "WHITE_E"sebesar "YELLOW_E"%d", amount);
	// 		callcmd::apsafe(playerid);
	// 		return 1;
	// 	}
	// 	else callcmd::apsafe(playerid);
	// 	return 1;
	// }
	// if(dialogid == APART_DEPOSITCGUN)
	// {
	// 	new ap = pData[playerid][pApart];
	// 	if(ap == -1) return Error(playerid, "You don't have Apart.");
	// 	if(response)
	// 	{
	// 		new amount = strval(inputtext);

	// 		if(isnull(inputtext))
	// 		{
	// 			new str[128];
	// 			format(str, sizeof(str), "cGun Balance: %d\n\nPlease enter how much cGun you wish to deposit into the safe:", apData[ap][hcGun]);
	// 			ShowPlayerDialog(playerid, APART_DEPOSITCGUN, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
	// 			return 1;
	// 		}
	// 		if(amount < 1 || amount > pData[playerid][pCgun])
	// 		{
	// 			new str[128];
	// 			format(str, sizeof(str), "Error: Insufficient funds.\n\ncGun Balance: %d\n\nPlease enter how much cGun you wish to deposit into the safe:", apData[ap][hcGun]);
	// 			ShowPlayerDialog(playerid, APART_DEPOSITCGUN, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
	// 			return 1;
	// 		}
	// 		apData[ap][hcGun] += amount;
	// 		pData[playerid][pCgun] -= amount;

	// 		Apart_Save(ap);
	// 		SendClientMessageEx(playerid, COLOR_ARWIN, "APART: "WHITE_E"Kamu Berhasil deposit "YELLOW_E"cGun "WHITE_E"sebesar "YELLOW_E"%d", amount);
	// 	}
	// 	else callcmd::apsafe(playerid);
	// 	return 1;
	// }
	// if(dialogid == APART_MARIJUANA)
	// {
	// 	if(response)
	// 	{
	// 		new ap = pData[playerid][pApart];
	// 		if(ap == -1) return Error(playerid, "You don't have Apart.");
	// 		if(response)
	// 		{
	// 			switch (listitem)
	// 			{
	// 				case 0:
	// 				{
	// 					new str[128];
	// 					format(str, sizeof(str), "Marju Balance: %d\n\nPlease enter how much Marju you wish to withdraw from the safe:", apData[ap][hMarju]);
	// 					ShowPlayerDialog(playerid, APART_WITHDRAWMARJU, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
	// 				}
	// 				case 1:
	// 				{
	// 					new str[128];
	// 					format(str, sizeof(str), "Marju Balance: %d\n\nPlease enter how much Marju you wish to deposit into the safe:", apData[ap][hMarju]);
	// 					ShowPlayerDialog(playerid, APART_DEPOSITMARJU, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
	// 				}
	// 			}
	// 		}
	// 		else callcmd::apsafe(playerid);
	// 	}
	// 	return 1;
	// }
	// if(dialogid == APART_WITHDRAWMARJU)
	// {
	// 	new ap = pData[playerid][pApart];
	// 	if(ap == -1) return Error(playerid, "You don't have Apart.");

	// 	if(response)
	// 	{
	// 		new amount = strval(inputtext);

	// 		if(isnull(inputtext))
	// 		{
	// 			new str[128];
	// 			format(str, sizeof(str), "Marijuana Balance: %d\n\nPlease enter how much Marijuana you wish to withdraw from the safe:", apData[ap][hMarju]);
	// 			ShowPlayerDialog(playerid, APART_WITHDRAWMARJU, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
	// 			return 1;
	// 		}
	// 		if(amount < 1 || amount > apData[ap][hMarju])
	// 		{
	// 			new str[128];
	// 			format(str, sizeof(str), "Error: Insufficient funds.\n\nMarijuana Balance: %d\n\nPlease enter how much Marijuana you wish to withdraw from the safe:", apData[ap][hMarju]);
	// 			ShowPlayerDialog(playerid, APART_WITHDRAWMARJU, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
	// 			return 1;
	// 		}
	// 		apData[ap][hMarju] -= amount;
	// 		pData[playerid][pMarijuana] += amount;

	// 		Apart_Save(ap);
	// 		SendClientMessageEx(playerid, COLOR_ARWIN, "APART: "WHITE_E"Kamu Berhasil withdraw "YELLOW_E"Marijuana "WHITE_E"sebesar "YELLOW_E"%d", amount);
	// 		callcmd::apsafe(playerid);
	// 		return 1;
	// 	}
	// 	else callcmd::apsafe(playerid);
	// 	return 1;
	// }
	// if(dialogid == APART_DEPOSITMARJU)
	// {
	// 	new ap = pData[playerid][pApart];
	// 	if(ap == -1) return Error(playerid, "You don't have Apart.");
	// 	if(response)
	// 	{
	// 		new amount = strval(inputtext);

	// 		if(isnull(inputtext))
	// 		{
	// 			new str[128];
	// 			format(str, sizeof(str), "Marijuana Balance: %d\n\nPlease enter how much Marijuana you wish to deposit into the safe:", apData[ap][hMarju]);
	// 			ShowPlayerDialog(playerid, APART_DEPOSITMARJU, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
	// 			return 1;
	// 		}
	// 		if(amount < 1 || amount > pData[playerid][pMarijuana])
	// 		{
	// 			new str[128];
	// 			format(str, sizeof(str), "Error: Insufficient funds.\n\nMarijuana Balance: %d\n\nPlease enter how much Marijuana you wish to deposit into the safe:", apData[ap][hMarju]);
	// 			ShowPlayerDialog(playerid, APART_DEPOSITMARJU, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
	// 			return 1;
	// 		}
	// 		apData[ap][hMarju] += amount;
	// 		pData[playerid][pMarijuana] -= amount;

	// 		Apart_Save(ap);
	// 		SendClientMessageEx(playerid, COLOR_ARWIN, "APART: "WHITE_E"Kamu Berhasil deposit "YELLOW_E"Marijuana "WHITE_E"sebesar "YELLOW_E"%d", amount);
	// 	}
	// 	else callcmd::apsafe(playerid);
	// 	return 1;
	// }
	// if(dialogid == APART_COMPONENT)
	// {
	// 	if(response)
	// 	{
	// 		new ap = pData[playerid][pApart];
	// 		if(ap == -1) return Error(playerid, "You don't have Apart.");
	// 		if(response)
	// 		{
	// 			switch (listitem)
	// 			{
	// 				case 0:
	// 				{
	// 					new str[128];
	// 					format(str, sizeof(str), "Component Balance: %d\n\nPlease enter how much Component you wish to withdraw from the safe:", apData[ap][hCompo]);
	// 					ShowPlayerDialog(playerid, APART_WITHDRAWCOMPO, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
	// 				}
	// 				case 1:
	// 				{
	// 					new str[128];
	// 					format(str, sizeof(str), "Component Balance: %d\n\nPlease enter how much Component you wish to deposit into the safe:", apData[ap][hCompo]);
	// 					ShowPlayerDialog(playerid, APART_DEPOSITCOMPO, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
	// 				}
	// 			}
	// 		}
	// 		else callcmd::apsafe(playerid);
	// 	}
	// 	return 1;
	// }
	// if(dialogid == APART_WITHDRAWCOMPO)
	// {
	// 	new ap = pData[playerid][pApart];
	// 	if(ap == -1) return Error(playerid, "You don't have Apart.");

	// 	if(response)
	// 	{
	// 		new amount = strval(inputtext);

	// 		if(isnull(inputtext))
	// 		{
	// 			new str[128];
	// 			format(str, sizeof(str), "Component Balance: %d\n\nPlease enter how much Component you wish to withdraw from the safe:", apData[ap][hCompo]);
	// 			ShowPlayerDialog(playerid, APART_WITHDRAWCOMPO, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
	// 			return 1;
	// 		}
	// 		if(amount < 1 || amount > apData[ap][hCompo])
	// 		{
	// 			new str[128];
	// 			format(str, sizeof(str), "Error: Insufficient funds.\n\nComponent Balance: %d\n\nPlease enter how much Marijuana you wish to withdraw from the safe:", apData[ap][hCompo]);
	// 			ShowPlayerDialog(playerid, APART_WITHDRAWCOMPO, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
	// 			return 1;
	// 		}
	// 		apData[ap][hCompo] -= amount;
	// 		pData[playerid][pComponent] += amount;

	// 		Apart_Save(ap);
	// 		SendClientMessageEx(playerid, COLOR_ARWIN, "APART: "WHITE_E"Kamu Berhasil withdraw "YELLOW_E"Component "WHITE_E"sebesar "YELLOW_E"%d", amount);
	// 		callcmd::apsafe(playerid);
	// 		return 1;
	// 	}
	// 	else callcmd::apsafe(playerid);
	// 	return 1;
	// }
	// if(dialogid == APART_DEPOSITCOMPO)
	// {
	// 	new ap = pData[playerid][pApart];
	// 	if(ap == -1) return Error(playerid, "You don't have Apart.");
	// 	if(response)
	// 	{
	// 		new amount = strval(inputtext);

	// 		if(isnull(inputtext))
	// 		{
	// 			new str[128];
	// 			format(str, sizeof(str), "Component Balance: %d\n\nPlease enter how much Component you wish to deposit into the safe:", apData[ap][hCompo]);
	// 			ShowPlayerDialog(playerid, APART_DEPOSITCOMPO, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
	// 			return 1;
	// 		}
	// 		if(amount < 1 || amount > pData[playerid][pComponent])
	// 		{
	// 			new str[128];
	// 			format(str, sizeof(str), "Error: Insufficient funds.\n\nComponent Balance: %d\n\nPlease enter how much Marijuana you wish to deposit into the safe:", apData[ap][hCompo]);
	// 			ShowPlayerDialog(playerid, APART_DEPOSITCOMPO, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
	// 			return 1;
	// 		}
	// 		apData[ap][hCompo] += amount;
	// 		pData[playerid][pComponent] -= amount;

	// 		Apart_Save(ap);
	// 		SendClientMessageEx(playerid, COLOR_ARWIN, "APART: "WHITE_E"Kamu Berhasil deposit "YELLOW_E"Component "WHITE_E"sebesar "YELLOW_E"%d", amount);
	// 	}
	// 	else callcmd::apsafe(playerid);
	// 	return 1;
	// }
	// if(dialogid == APART_MATERIAL)
	// {
	// 	if(response)
	// 	{
	// 		new ap = pData[playerid][pApart];
	// 		if(ap == -1) return Error(playerid, "You don't have Apart.");
	// 		if(response)
	// 		{
	// 			switch (listitem)
	// 			{
	// 				case 0:
	// 				{
	// 					new str[128];
	// 					format(str, sizeof(str), "Material Balance: %d\n\nPlease enter how much Material you wish to withdraw from the safe:", apData[ap][hMaterial]);
	// 					ShowPlayerDialog(playerid, APART_WITHDRAWMATERIAL, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
	// 				}
	// 				case 1:
	// 				{
	// 					new str[128];
	// 					format(str, sizeof(str), "Material Balance: %d\n\nPlease enter how much Material you wish to deposit into the safe:", apData[ap][hMaterial]);
	// 					ShowPlayerDialog(playerid, APART_DEPOSITMATERIAL, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
	// 				}
	// 			}
	// 		}
	// 		else callcmd::apsafe(playerid);
	// 	}
	// 	return 1;
	// }
	// if(dialogid == APART_WITHDRAWMATERIAL)
	// {
	// 	new ap = pData[playerid][pApart];
	// 	if(ap == -1) return Error(playerid, "You don't have Apart.");

	// 	if(response)
	// 	{
	// 		new amount = strval(inputtext);

	// 		if(isnull(inputtext))
	// 		{
	// 			new str[128];
	// 			format(str, sizeof(str), "Material Balance: %d\n\nPlease enter how much Material you wish to withdraw from the safe:", apData[ap][hMaterial]);
	// 			ShowPlayerDialog(playerid, APART_WITHDRAWMATERIAL, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
	// 			return 1;
	// 		}
	// 		if(amount < 1 || amount > apData[ap][hMaterial])
	// 		{
	// 			new str[128];
	// 			format(str, sizeof(str), "Error: Insufficient funds.\n\nMaterial Balance: %d\n\nPlease enter how much Marijuana you wish to withdraw from the safe:", apData[ap][hMaterial]);
	// 			ShowPlayerDialog(playerid, APART_WITHDRAWMATERIAL, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
	// 			return 1;
	// 		}
	// 		apData[ap][hMaterial] -= amount;
	// 		pData[playerid][pMaterial] += amount;

	// 		Apart_Save(ap);
	// 		//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has withdrawn %d Material from their apart safe.", ReturnName(playerid), amount);
	// 		SendClientMessageEx(playerid, COLOR_ARWIN, "APART: "WHITE_E"Kamu Berhasil withdraw "YELLOW_E"Material "WHITE_E"sebesar "YELLOW_E"%d", amount);
	// 		callcmd::apsafe(playerid);
	// 		return 1;
	// 	}
	// 	else callcmd::apsafe(playerid);
	// 	return 1;
	// }
	// if(dialogid == APART_DEPOSITMATERIAL)
	// {
	// 	new ap = pData[playerid][pApart];
	// 	if(ap == -1) return Error(playerid, "You don't have Apart.");
	// 	if(response)
	// 	{
	// 		new amount = strval(inputtext);

	// 		if(isnull(inputtext))
	// 		{
	// 			new str[128];
	// 			format(str, sizeof(str), "Material Balance: %d\n\nPlease enter how much Material you wish to deposit into the safe:", apData[ap][hMaterial]);
	// 			ShowPlayerDialog(playerid, APART_DEPOSITMATERIAL, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
	// 			return 1;
	// 		}
	// 		if(amount < 1 || amount > pData[playerid][pMaterial])
	// 		{
	// 			new str[128];
	// 			format(str, sizeof(str), "Error: Insufficient funds.\n\nMaterial Balance: %d\n\nPlease enter how much Marijuana you wish to deposit into the safe:", apData[ap][hMaterial]);
	// 			ShowPlayerDialog(playerid, APART_DEPOSITMATERIAL, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
	// 			return 1;
	// 		}
	// 		apData[ap][hMaterial] += amount;
	// 		pData[playerid][pMaterial] -= amount;

	// 		Apart_Save(ap);
	// 		SendClientMessageEx(playerid, COLOR_ARWIN, "APART: "WHITE_E"Kamu Berhasil deposit "YELLOW_E"Material "WHITE_E"sebesar "YELLOW_E"%d", amount);
	// 	}
	// 	else callcmd::apsafe(playerid);
	// 	return 1;
	// }
	if(dialogid == WORKSHOP_SAFE)
	{
		if(!response) return 1;
	//	new wid = pData[playerid][pWorkshop];
		switch(listitem)
		{
			case 0:
			{	
				ShowPlayerDialog(playerid, WORKSHOP_TEXT, DIALOG_STYLE_INPUT, "Workshop Board",""BLUE_E"HINT:\n"WHITE_E"- Teks mendukung bbcode, gunakan (n):untuk membuat baris baru, \
					(r):warna merah, (w):putih, \n\
					\t(b):biru, (bl):hitam, (g):hijau, (bl):kuning\n\
					\tContoh: Ganti (r)saya (w)menjadi merah dan seterusnya putih\n\
					- Tidak memasukkan teks kepanjangan\n\n\
					Maksimal teks tidak lebih dari 40 huruf:", "Ubah", "Keluar");
			}
			case 1:
			{
				//Name
				ShowPlayerDialog(playerid, WORKSHOP_NAME, DIALOG_STYLE_INPUT, "Workshop Name:", "Masukkan nama bisnis yang kamu inginkan\nMaksimal 32 karakter untuk nama bisnis", "Select", "Back");
			}
			case 2:
			{
				//Component
				ShowPlayerDialog(playerid, WORKSHOP_COMPONENT, DIALOG_STYLE_LIST, "Component", "Withdraw from safe\nDeposit into safe", "Select", "Back");
			}
			case 3:
			{
				//Money
				ShowPlayerDialog(playerid, WORKSHOP_MONEY, DIALOG_STYLE_LIST, "Money", "Withdraw from safe\nDeposit into safe", "Select", "Back");
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_WORKSHOPSELL)
	{
		if(response)
		{
			new wid = pData[playerid][pWorkshop];
			new pay;
			pay = wData[wid][wPrice] / 80;
			GivePlayerMoneyEx(playerid, pay);
			format(wData[wid][wName], 50, "-");
			format(wData[wid][wOwner], 50, "-");
			Workshop_Save(wid);
			Workshop_Refresh(wid);
			SendClientMessageEx(playerid, COLOR_ARWIN, "WORKSHOP: "WHITE_E"Anda berhasil menjual workshop dengan harga "GREEN_E"$%s", pay);
			foreach(new ii : Player)
			{
				if(pData[ii][pWorkshop] == wid)
				{
					pData[ii][pWorkshop]= -1;
					pData[ii][pWorkshopRank] = 0;
				}
			}	
			pData[playerid][pWorkshop] = -1;
			pData[playerid][pWorkshopRank] = 0;	
		}
		return 1;
	}
	if(dialogid == WORKSHOP_NAME) //Workshop Board
	{
	    if(response)
		{
			new idx = pData[playerid][pWorkshop], String[525];
			if(idx == -1) return Error(playerid, "You don't have workshop.");
			format(wData[idx][wName], 128, "%s", ColouredText(inputtext));
			format(String, sizeof(String), "%s\n%s", ColouredText(inputtext), wData[idx][wsPapanText]);
			FormatText(String);
			SetDynamicObjectMaterialText(wData[idx][wsPapan], 0, String, 130, "Arial", 45, 1, 0xFFFFFFFF, 0xFF000000, 1);
			Workshop_Save(idx);
		}
		return 1;
	}
	if(dialogid == WORKSHOP_TEXT) //Workshop Board
	{
	    if(response)
		{
			new idx = pData[playerid][pWorkshop], String[525];
			if(idx == -1) return Error(playerid, "You don't have workshop.");
			format(String, sizeof(String), "%s\n%s", wData[idx][wName], ReplaceString(inputtext));
			FormatText(String);
			SetDynamicObjectMaterialText(wData[idx][wsPapan], 0, String, 130, "Arial", 45, 1, 0xFFFFFFFF, 0xFF000000, 1);
			Workshop_Save(idx);
		}
		return 1;
	}
	if(dialogid == WORKSHOP_COMPONENT)
	{
		if(response)
		{
			new wid = pData[playerid][pWorkshop];
			if(wid == -1) return Error(playerid, "You don't have workshop.");
			if(response)
			{
				switch (listitem)
				{
					case 0:
					{
						if(pData[playerid][pWorkshopRank] < 5)
							return Error(playerid, "Only boss can withdraw component!");

						new str[128];
						format(str, sizeof(str), "Component Balance: %d\n\nPlease enter how much component you wish to withdraw from the safe:", wData[wid][wComponent]);
						ShowPlayerDialog(playerid, WORKSHOP_WITHDRAWCOMPONENT, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
					}
					case 1:
					{
						new str[128];
						format(str, sizeof(str), "Component Balance: %d\n\nPlease enter how much component you wish to deposit into the safe:", wData[wid][wComponent]);
						ShowPlayerDialog(playerid, WORKSHOP_DEPOSITCOMPONENT, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
					}
				}
			}
			else callcmd::wsafe(playerid);
		}
		return 1;
	}
	if(dialogid == WORKSHOP_WITHDRAWCOMPONENT)
	{
		new wid = pData[playerid][pWorkshop];
		if(wid == -1) return Error(playerid, "You don't have workshop.");

		if(response)
		{
			new amount = strval(inputtext);

			if(isnull(inputtext))
			{
				new str[128];
				format(str, sizeof(str), "Component Balance: %d\n\nPlease enter how much component you wish to withdraw from the safe:", wData[wid][wComponent]);
				ShowPlayerDialog(playerid, WORKSHOP_WITHDRAWCOMPONENT, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
				return 1;
			}
			if(amount < 1 || amount > wData[wid][wComponent])
			{
				new str[128];
				format(str, sizeof(str), "Error: Insufficient funds.\n\nComponent Balance: %d\n\nPlease enter how much component you wish to withdraw from the safe:", wData[wid][wComponent]);
				ShowPlayerDialog(playerid, WORKSHOP_WITHDRAWCOMPONENT, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
				return 1;
			}
			wData[wid][wComponent] -= amount;
			pData[playerid][pComponent] += amount;

			Workshop_Save(wid);
			SendClientMessageEx(playerid, COLOR_ARWIN, "WORKSHOP: {ffffff}You've withdrawn %d Component from Workshop Bank", strval(inputtext));
			callcmd::wsafe(playerid);
			return 1;
		}
		else callcmd::wsafe(playerid);
		return 1;
	}
	if(dialogid == WORKSHOP_DEPOSITCOMPONENT)
	{
		new wid = pData[playerid][pWorkshop];
		if(wid == -1) return Error(playerid, "You don't have workshop.");
		if(response)
		{
			new amount = strval(inputtext);

			if(isnull(inputtext))
			{
				new str[128];
				format(str, sizeof(str), "Component Balance: %d\n\nPlease enter how much component you wish to deposit into the safe:", wData[wid][wComponent]);
				ShowPlayerDialog(playerid, WORKSHOP_DEPOSITCOMPONENT, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
				return 1;
			}
			if(amount < 1 || amount > pData[playerid][pComponent])
			{
				new str[128];
				format(str, sizeof(str), "Error: Insufficient funds.\n\nComponent Balance: %d\n\nPlease enter how much component you wish to deposit into the safe:", wData[wid][wComponent]);
				ShowPlayerDialog(playerid, WORKSHOP_DEPOSITCOMPONENT, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
				return 1;
			}
			wData[wid][wComponent] += amount;
			pData[playerid][pComponent] -= amount;

			Workshop_Save(wid);
			SendClientMessageEx(playerid, COLOR_ARWIN, "WORKSHOP: {ffffff}You've stored %d Component to Workshop", amount);
		}
		else callcmd::wsafe(playerid);
		return 1;
	}
	if(dialogid == WORKSHOP_MONEY)
	{
		if(response)
		{
			new wid = pData[playerid][pWorkshop];
			if(wid == -1) return Error(playerid, "You don't have workshop.");
			if(response)
			{
				switch (listitem)
				{
					case 0:
					{
						if(pData[playerid][pWorkshopRank] < 5)
							return Error(playerid, "Only workshop owners can use this access!");

						new str[128];
						format(str, sizeof(str), "Money Balance: $%s\n\nPlease enter how much money you wish to withdraw from the safe:", FormatMoney(wData[wid][wMoney]));
						ShowPlayerDialog(playerid, WORKSHOP_WITHDRAWMONEY, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
					}
					case 1:
					{
						new str[128];
						format(str, sizeof(str), "Money Balance: $%s\n\nPlease enter how much money you wish to deposit into the safe:", FormatMoney(wData[wid][wMoney]));
						ShowPlayerDialog(playerid, WORKSHOP_DEPOSITMONEY, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
					}
				}
			}
			else callcmd::wsafe(playerid);
		}
		return 1;
	}
	if(dialogid == WORKSHOP_WITHDRAWMONEY)
	{
		new wid = pData[playerid][pWorkshop];
		if(wid == -1) return Error(playerid, "You don't have workshop.");

		if(response)
		{
			new amount = strval(inputtext);

			if(isnull(inputtext))
			{
				new str[128];
				format(str, sizeof(str), "Money Balance: $%s\n\nPlease enter how much money you wish to withdraw from the safe:", FormatMoney(wData[wid][wMoney]));
				ShowPlayerDialog(playerid, WORKSHOP_WITHDRAWMONEY, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
				return 1;
			}
			if(amount < 1 || amount > wData[wid][wMoney])
			{
				new str[128];
				format(str, sizeof(str), "Error: Insufficient funds.\n\nMoney Balance: $%s\n\nPlease enter how much money you wish to withdraw from the safe:", FormatMoney(wData[wid][wMoney]));
				ShowPlayerDialog(playerid, WORKSHOP_WITHDRAWMONEY, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
				return 1;
			}
			wData[wid][wMoney] -= amount;
			GivePlayerMoneyEx(playerid, amount);

			Workshop_Save(wid);
			SendClientMessageEx(playerid, COLOR_ARWIN, "WORKSHOP: {ffffff}You've withdrawn $%s from Workshop Bank", FormatMoney(strval(inputtext)));
			callcmd::wsafe(playerid);
			return 1;
		}
		else callcmd::wsafe(playerid);
		return 1;
	}
	if(dialogid == WORKSHOP_DEPOSITMONEY)
	{
		new wid = pData[playerid][pWorkshop];
		if(wid == -1) return Error(playerid, "You don't have workshop.");
		if(response)
		{
			new amount = strval(inputtext);

			if(isnull(inputtext))
			{
				new str[128];
				format(str, sizeof(str), "Money Balance: $%s\n\nPlease enter how much money you wish to deposit into the safe:", FormatMoney(wData[wid][wMoney]));
				ShowPlayerDialog(playerid, WORKSHOP_DEPOSITMATERIAL, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
				return 1;
			}
			if(amount < 1 || amount > GetPlayerMoney(playerid))
			{
				new str[128];
				format(str, sizeof(str), "Error: Insufficient funds.\n\nMoney Balance: $%s\n\nPlease enter how much money you wish to deposit into the safe:", FormatMoney(wData[wid][wMoney]));
				ShowPlayerDialog(playerid, WORKSHOP_DEPOSITMATERIAL, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
				return 1;
			}
			wData[wid][wMoney] += amount;
			GivePlayerMoneyEx(playerid, -amount);

			Workshop_Save(wid);
			SendClientMessageEx(playerid, COLOR_ARWIN, "WORKSHOP: {ffffff}You've stored $%s to Workshop Bank", FormatMoney(strval(inputtext)));
		}
		else callcmd::wsafe(playerid);
		return 1;
	}
	
	if(dialogid == WORKSHOP_INFO)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					if(pData[playerid][pWorkshop] == -1)
						return Error(playerid, "You dont have workshop!");
					new query[512];
					mysql_format(g_SQL, query, sizeof(query), "SELECT name,owner,component,money FROM workshops WHERE ID = %d", pData[playerid][pWorkshop]);
					mysql_tquery(g_SQL, query, "ShowWorkshopInfo", "i", playerid);
				}
				case 1:
				{
					if(pData[playerid][pWorkshop] == -1)
						return Error(playerid, "You dont have family!");

					new lstr[1024];
					format(lstr, sizeof(lstr), "Rank\tName\n");
					foreach(new i: Player)
					{
						if(pData[i][pWorkshop] == pData[playerid][pWorkshop])
						{
							format(lstr, sizeof(lstr), "%s\t%s(%d)", lstr, pData[i][pName], i);
							format(lstr, sizeof(lstr), "%s\n", lstr);
						}
					}
					format(lstr, sizeof(lstr), "%s\n", lstr);
					ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Workshop Online", lstr, "Close", "");

				}
				case 2:
				{
					if(pData[playerid][pWorkshop] == -1)
						return Error(playerid, "You dont have workshop!");
					new query[512];
					mysql_format(g_SQL, query, sizeof(query), "SELECT username,workshoprank FROM players WHERE workshop = %d", pData[playerid][pWorkshop]);
					mysql_tquery(g_SQL, query, "ShowWorkshopMember", "i", playerid);
				}
			}
		}
		return 1;
	}
	//------------[ VIP Locker Dialog ]----------
	if(dialogid == DIALOG_LOCKERVIP)
	{
		if(response)
		{
			switch (listitem) 
			{
				case 0: 
				{
					SetPlayerHealthEx(playerid, 100);
				}
				case 1:
				{
					GivePlayerWeaponEx(playerid, 1, 1);
					GivePlayerWeaponEx(playerid, 7, 1);
					GivePlayerWeaponEx(playerid, 15, 1);
				}
				case 2:
				{
				}
			}
		}
	}
	//-------------[ Faction Commands Dialog ]-----------
	if(dialogid == DIALOG_LOCKERSAPD)
	{
		if(response)
		{
			switch (listitem) 
			{
				case 0: 
				{
					if(pData[playerid][pOnDuty] == 1)
					{
						pData[playerid][pOnDuty] = 0;
						SetPlayerColor(playerid, COLOR_WHITE);
						SetPlayerSkin(playerid, pData[playerid][pSkin]);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s places their badge and gun in their locker.", ReturnName(playerid));
						ResetWeapon(playerid, 25);
						ResetWeapon(playerid, 27);
						ResetWeapon(playerid, 29);
						ResetWeapon(playerid, 31);
						ResetWeapon(playerid, 33);
						ResetWeapon(playerid, 34);
					}
					else
					{
						pData[playerid][pOnDuty] = 1;
						SetFactionColor(playerid);
						if(pData[playerid][pGender] == 1)
						{
							SetPlayerSkin(playerid, 300);
							pData[playerid][pFacSkin] = 300;
						}
						else
						{
							SetPlayerSkin(playerid, 306);
							pData[playerid][pFacSkin] = 306;
						}
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s withdraws their badge and on duty from their locker", ReturnName(playerid));
					}
				}
				case 1: 
				{
					SetPlayerHealthEx(playerid, 100);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s telah mengambil medical kit dari locker", ReturnName(playerid));
				}
				case 2:
				{
					SetPlayerArmourEx(playerid, 90);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s telah mengambil armour pelindung dari locker", ReturnName(playerid));
				}
				case 3:
				{
					if(pData[playerid][pOnDuty] <= 0)
						return Error(playerid, "Kamu harus On duty untuk mengambil barang!");
						
					ShowPlayerDialog(playerid, DIALOG_WEAPONSAPD, DIALOG_STYLE_LIST, "SAPD Weapons", "SPRAYCAN\nPARACHUTE\nNITE STICK\nKNIFE\nCOLT45\nSILENCED\nDEAGLE\nSHOTGUN\nSHOTGSPA\nMP5\nM4\nRIFLE\nSNIPER", "Pilih", "Batal");
				}
				case 4:
				{
					if(pData[playerid][pOnDuty] <= 0)
						return Error(playerid, "Kamu harus On duty untuk mengambil barang!");
					
					switch (pData[playerid][pGender])
					{
						case 1: ShowPlayerSelectionMenu(playerid, MODEL_SELECTION_SAPDMale, "LSPD:", sapdmale, sizeof(sapdmale));
						case 2: ShowPlayerSelectionMenu(playerid, MODEL_SELECTION_SAPDFemale, "LSPD:", sapdfemale, sizeof(sapdfemale));
					}
				}
				case 5:
				{
					if(pData[playerid][pOnDuty] <= 0)
						return Error(playerid, "Kamu harus On duty untuk mengambil barang!");
					if(pData[playerid][pFactionRank] < 3)
						return Error(playerid, "You are not allowed!");
					
					switch (pData[playerid][pGender])
					{
						case 1: ShowPlayerSelectionMenu(playerid, MODEL_SELECTION_SAPDWar, "LSPD:", sapdwar, sizeof(sapdwar));
						case 2: ShowPlayerSelectionMenu(playerid, MODEL_SELECTION_SAPDFemale, "LSPD:", sapdfemale, sizeof(sapdfemale));
					}
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_WEAPONSAPD)
	{
		if(response)
		{
			switch (listitem) 
			{
				case 0:
				{
					GivePlayerWeaponEx(playerid, 41, 200);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(41));
				}
				case 1:
				{
					GivePlayerWeaponEx(playerid, 46, 1);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(46));
				}
				case 2:
				{
					GivePlayerWeaponEx(playerid, 3, 200);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(3));
				}
				case 3:
				{
					GivePlayerWeaponEx(playerid, 4, 200);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(4));
				}
				case 4:
				{
					GivePlayerWeaponEx(playerid, 22, 200);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(22));
				}
				case 5:
				{
					if(pData[playerid][pFactionRank] < 2)
						return Error(playerid, "You are not allowed!");
						
					GivePlayerWeaponEx(playerid, 23, 200);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(23));
				}
				case 6:
				{
					if(pData[playerid][pFactionRank] < 2)
						return Error(playerid, "You are not allowed!");
						
					GivePlayerWeaponEx(playerid, 24, 200);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(24));
				}	
				case 7:
				{
					if(pData[playerid][pFactionRank] < 3)
						return Error(playerid, "You are not allowed!");
					GivePlayerWeaponEx(playerid, 25, 200);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(25));
				}
				case 8:
				{
					if(pData[playerid][pFactionRank] < 3)
						return Error(playerid, "You are not allowed!");
					GivePlayerWeaponEx(playerid, 27, 200);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(27));
				}
				case 9:
				{
					if(pData[playerid][pFactionRank] < 3)
						return Error(playerid, "You are not allowed!");
					GivePlayerWeaponEx(playerid, 29, 200);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(29));
				}
				case 10:
				{
					if(pData[playerid][pFactionRank] < 4)
						return Error(playerid, "You are not allowed!");
					GivePlayerWeaponEx(playerid, 31, 200);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(31));
				}
				case 11:
				{
					if(pData[playerid][pFactionRank] < 4)
						return Error(playerid, "You are not allowed!");
					GivePlayerWeaponEx(playerid, 33, 200);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(33));
				}
				case 12:
				{
					if(pData[playerid][pFactionRank] < 4)
						return Error(playerid, "You are not allowed!");
					GivePlayerWeaponEx(playerid, 34, 200);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(34));
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_LOCKERSAGS)
	{
		if(response)
		{
			switch (listitem) 
			{
				case 0: 
				{
					if(pData[playerid][pOnDuty] == 1)
					{
						pData[playerid][pOnDuty] = 0;
						SetPlayerColor(playerid, COLOR_WHITE);
						SetPlayerSkin(playerid, pData[playerid][pSkin]);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s places their badge in their locker.", ReturnName(playerid));
					}
					else
					{
						pData[playerid][pOnDuty] = 1;
						SetFactionColor(playerid);
						if(pData[playerid][pGender] == 1)
						{
							SetPlayerSkin(playerid, 295);
							pData[playerid][pFacSkin] = 295;
						}
						else
						{
							SetPlayerSkin(playerid, 141);
							pData[playerid][pFacSkin] = 141;
						}
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s withdraws their badge and on duty from their locker", ReturnName(playerid));
					}
				}
				case 1: 
				{
					SetPlayerHealthEx(playerid, 100);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s telah mengambil medical kit dari locker", ReturnName(playerid));
				}
				case 2:
				{
					SetPlayerArmourEx(playerid, 90);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s telah mengambil armour pelindung dari locker", ReturnName(playerid));
				}
				case 3:
				{
					if(pData[playerid][pOnDuty] <= 0)
						return Error(playerid, "Kamu harus On duty untuk mengambil barang!");
						
					ShowPlayerDialog(playerid, DIALOG_WEAPONSAGS, DIALOG_STYLE_LIST, "SAGS Weapons", "NITE STICK\nKNIFE", "Pilih", "Batal");
				}
				case 4:
				{
					if(pData[playerid][pOnDuty] <= 0)
						return Error(playerid, "Kamu harus On duty untuk mengambil barang!");
					switch (pData[playerid][pGender])
					{
					}
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_WEAPONSAGS)
	{
		if(response)
		{
			switch (listitem) 
			{
				case 0:
				{
					GivePlayerWeaponEx(playerid, 3, 200);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(3));
				}
				case 1:
				{
					GivePlayerWeaponEx(playerid, 4, 200);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(4));
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_LOCKERSAMD)
	{
		if(response)
		{
			switch (listitem) 
			{
				case 0: 
				{
					if(pData[playerid][pOnDuty] == 1)
					{
						pData[playerid][pOnDuty] = 0;
						SetPlayerColor(playerid, COLOR_WHITE);
						SetPlayerSkin(playerid, pData[playerid][pSkin]);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s places their badge in their locker.", ReturnName(playerid));
					}
					else
					{
						pData[playerid][pOnDuty] = 1;
						SetFactionColor(playerid);
						if(pData[playerid][pGender] == 1)
						{
							SetPlayerSkin(playerid, 276);
							pData[playerid][pFacSkin] = 276;
						}
						else
						{
							SetPlayerSkin(playerid, 308);
							pData[playerid][pFacSkin] = 308;
						}
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s withdraws their badge and on duty from their locker", ReturnName(playerid));
					}
				}
				case 1: 
				{
					SetPlayerHealthEx(playerid, 100);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s telah mengambil medical kit dari locker", ReturnName(playerid));
				}
				case 2:
				{
					SetPlayerArmourEx(playerid, 90);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s telah mengambil armour pelindung dari locker", ReturnName(playerid));
				}
				case 3:
				{
					if(pData[playerid][pOnDuty] <= 0)
						return Error(playerid, "Kamu harus On duty untuk mengambil barang!");
					switch (pData[playerid][pGender])
					{
                        case 1: ShowPlayerSelectionMenu(playerid, MODEL_SELECTION_SAMDMale, "SAMD:", samdmale, sizeof(samdmale));
						case 2: ShowPlayerSelectionMenu(playerid, MODEL_SELECTION_SAMDFemale, "SAMD:", samdfemale, sizeof(samdfemale));
					}
				}
				case 4:
				{
					if(pData[playerid][pOnDuty] <= 0)
						return Error(playerid, "Kamu harus On duty untuk mengambil barang!");
					pData[playerid][pMedicine]++;
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s telah mengambil medicine dari locker", ReturnName(playerid));
				}
				case 5:
				{
					if(pData[playerid][pOnDuty] <= 0)
						return Error(playerid, "Kamu harus On duty untuk mengambil barang!");
					pData[playerid][pMedkit]++;
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s telah mengambil medkit dari locker", ReturnName(playerid));
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_WEAPONSAMD)
	{
		if(response)
		{
			switch (listitem) 
			{
				case 0:
				{
					GivePlayerWeaponEx(playerid, 42, 200);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(42));
				}
				case 1:
				{
					GivePlayerWeaponEx(playerid, 41, 200);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(41));
				}
				case 2:
				{
					GivePlayerWeaponEx(playerid, 46, 1);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(46));
				}
				case 3:
				{
					//GivePlayerWeaponEx(playerid, 3, 200);
					//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(3));
				}
				case 4:
				{
					//GivePlayerWeaponEx(playerid, 4, 200);
					//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(4));
				}
				case 5:
				{
					if(pData[playerid][pFactionRank] < 3)
						return Error(playerid, "You are not allowed!");
						
					//GivePlayerWeaponEx(playerid, 22, 200);
					//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(22));
				}
				case 6:
				{
					if(pData[playerid][pFactionRank] < 3)
						return Error(playerid, "You are not allowed!");
						
					//GivePlayerWeaponEx(playerid, 23, 200);
					//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(23));
				}
				case 7:
				{
					if(pData[playerid][pFactionRank] < 3)
						return Error(playerid, "You are not allowed!");
						
					//GivePlayerWeaponEx(playerid, 24, 200);
					//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(24));
				}	
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_LOCKERSANEW)
	{
		if(response)
		{
			switch (listitem) 
			{
				case 0: 
				{
					if(pData[playerid][pOnDuty] == 1)
					{
						pData[playerid][pOnDuty] = 0;
						SetPlayerColor(playerid, COLOR_WHITE);
						SetPlayerSkin(playerid, pData[playerid][pSkin]);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s places their badge and gun in their locker.", ReturnName(playerid));
					}
					else
					{
						pData[playerid][pOnDuty] = 1;
						SetFactionColor(playerid);
						if(pData[playerid][pGender] == 1)
						{
							SetPlayerSkin(playerid, 189);
							pData[playerid][pFacSkin] = 189;
						}
						else
						{
							SetPlayerSkin(playerid, 150); //194
							pData[playerid][pFacSkin] = 150; //194
						}
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s withdraws their badge and on duty from their locker", ReturnName(playerid));
					}
				}
				case 1: 
				{
					SetPlayerHealthEx(playerid, 100);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s telah mengambil medical kit dari locker", ReturnName(playerid));
				}
				case 2:
				{
					SetPlayerArmourEx(playerid, 90);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s telah mengambil armour pelindung dari locker", ReturnName(playerid));
				}
				case 3:
				{
					if(pData[playerid][pOnDuty] <= 0)
						return Error(playerid, "Kamu harus On duty untuk mengambil barang!");
					switch (pData[playerid][pGender])
					{
                        case 1: ShowPlayerSelectionMenu(playerid, MODEL_SELECTION_SANEWSMale, "SANEWS:", sanewsmale, sizeof(sanewsmale));
						case 2: ShowPlayerSelectionMenu(playerid, MODEL_SELECTION_SANEWSFemale, "SANEWS:", sanewsfemale, sizeof(sanewsfemale));
					}
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_WEAPONSANEW)
	{
		if(response)
		{
			switch (listitem) 
			{
				case 0:
				{
					GivePlayerWeaponEx(playerid, 43, 200);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(43));
				}
				case 1:
				{
					GivePlayerWeaponEx(playerid, 41, 200);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(41));
				}
				case 2:
				{
					GivePlayerWeaponEx(playerid, 46, 1);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(46));
				}
				case 3:
				{
					//GivePlayerWeaponEx(playerid, 3, 200);
					//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(3));
				}
				case 4:
				{
					//GivePlayerWeaponEx(playerid, 4, 200);
					//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(4));
				}
				case 5:
				{
					if(pData[playerid][pFactionRank] < 3)
						return Error(playerid, "You are not allowed!");
						
					//GivePlayerWeaponEx(playerid, 22, 200);
					//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(22));
				}
			}
		}
		return 1;
	}
	//--------[ DIALOG JOB ]--------
	if(dialogid == DIALOG_SERVICE)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
                    if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						new Float:health, comp;
						GetVehicleHealth(pData[playerid][pMechVeh], health);
						if(health > 1000.0) health = 1000.0;
						if(health > 0.0) health *= -1;
						comp = floatround(health, floatround_round) / 10 + 100;
						
						if(health > 2000.0 && pvData[pData[playerid][pMechVeh]][cMesinUpgrade] == 2) return Error(playerid, "This vehicle can't be fixing.");
						if(health > 1000.0 && pvData[pData[playerid][pMechVeh]][cMesinUpgrade] == 0) return Error(playerid, "This vehicle can't be fixing.");
						if(pData[playerid][pComponent] < comp) return Error(playerid, "Component anda kurang!");
						pData[playerid][pComponent] -= comp;
						pData[playerid][pSkillMecha] += comp;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You repair the vehicle engine with the "YELLOW_E"%d component", comp);
						pData[playerid][pMechanic] = SetTimerEx("EngineFix", 1300, true, "id", playerid, pData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Fixing Engine");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
						foreach(new pid : Player) 
						{
							if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
							{
								SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"has started examining your {00FFFF}%s "WHITE_E"engine repairing", pData[playerid][pName], GetVehicleName(pData[playerid][pMechVeh]));
							}	
						}
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 1:
				{
                    if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						pData[playerid][pComponent] -= 50;
						pData[playerid][pSkillMecha] += 50;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You repair the vehicle wheels with "YELLOW_E"50 components");
						pData[playerid][pMechanic] = SetTimerEx("TiresFix", 1300, true, "id", playerid, pData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Fixing Tires");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
						foreach(new pid : Player) 
						{
							if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
							{
								SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"has started examining your {00FFFF}%s "WHITE_E"wheel repairing", pData[playerid][pName], GetVehicleName(pData[playerid][pMechVeh]));
							}	
						}
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 2:
				{
                    if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						new panels, doors, light, tires, comp;
						
						GetVehicleDamageStatus(pData[playerid][pMechVeh], panels, doors, light, tires);
						new cpanels = panels / 1000000;
						new lights = light / 2;
						new pintu;
						if(doors != 0) pintu = 5;
						if(doors == 0) pintu = 0;
						comp = cpanels + lights + pintu + 20;
						
						if(pData[playerid][pComponent] < comp) return Error(playerid, "Component anda kurang!");
						if(comp <= 0) return Error(playerid, "This vehicle can't be fixing.");
						pData[playerid][pComponent] -= comp;
						pData[playerid][pSkillMecha] += comp;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You repair the vehicle body with "YELLOW_E"%d component", comp);
						pData[playerid][pMechanic] = SetTimerEx("BodyFix", 1300, true, "id", playerid, pData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Fixing Body");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
						foreach(new pid : Player) 
						{
							if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
							{
								SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"has started examining your {00FFFF}%s "WHITE_E"body repairing", pData[playerid][pName], GetVehicleName(pData[playerid][pMechVeh]));
							}	
						}
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 3:
				{
					ShowPlayerDialog(playerid, DIALOG_CHANGECOLOR, DIALOG_STYLE_LIST, "Vehicle Menu", "Spray Car\nPaint Job Car", "Service", "Cancel");	
				}
				case 4:
				{
					if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");
					ShowPlayerDialog(playerid, DIALOG_UPGRADE, DIALOG_STYLE_LIST, "Vehicle Menu", "Upgrade Mesin\nUpgrade Body", "Service", "Cancel");	
				}
				case 5:
				{
					if(pData[playerid][pWorkshop] == -1)
						return Error(playerid, "Kamu bukan anggota workshop!");
					ShowPlayerDialog(playerid, DIALOG_REMOVEMODIF, DIALOG_STYLE_LIST, "Removing Mod", "Spoiler\nHood\nRoof\nSidekirt\nLamps\nNitro\nExhaust\nWheels\nStereo\nHydraulics\nFront Bumper\nRear Bumper\nVent\nNeon", "Service", "Cancel");	
				}
				case 6:
				{
					if(pData[playerid][pWorkshop] == -1)
						return Error(playerid, "Kamu bukan anggota workshop!");
					ShowPlayerDialog(playerid, DIALOG_MODIF, DIALOG_STYLE_LIST, "Vehicle Menu", "Wheels Car\nSpoiler Car\nHood Car\nVents Car\nLights Car\nExhausts\nFront bumpers\nRear Bumpers\nRoofs Car\nSide skirts\nBullbars\nStereo\nHydraulics\nNitro 1\nNitro 2\nNitro 3\nNeon", "Service", "Cancel");	
				}
			}
		}
	}
	if(dialogid == DIALOG_REMOVEMODIF)
	{
		if(response)
		{
            switch(listitem)
			{
				case 0:
				{
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");

					if(pData[playerid][pWorkshop] == -1)
						return Error(playerid, "Kamu bukan anggota workshop!");
					{
						if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
						{
							if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 112;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You remove spoiler modifications from the {00FFFF}%s "WHITE_E"car by using component "YELLOW_E"50", GetVehicleName(pData[playerid][pMechVeh]));
							pData[playerid][pMechanic] = SetTimerEx("RemoveModification1", 4000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Removing Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"Start removing modifications in your car", pData[playerid][pName]);
								}	
							}
						}
						else
						{
							KillTimer(pData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							pData[playerid][pActivityTime] = 0;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
                }
				case 1:
				{
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");

					if(pData[playerid][pWorkshop] == -1)
						return Error(playerid, "Kamu bukan anggota workshop!");
					{
						if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
						{
							if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 112;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You remove hood modifications from the {00FFFF}%s "WHITE_E"car by using component "YELLOW_E"50", GetVehicleName(pData[playerid][pMechVeh]));
							pData[playerid][pMechanic] = SetTimerEx("RemoveModification2", 4000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Removing Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"Start removing modifications in your car", pData[playerid][pName]);
								}	
							}
						}
						else
						{
							KillTimer(pData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							pData[playerid][pActivityTime] = 0;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
                }
				case 2:
				{
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");

					if(pData[playerid][pWorkshop] == -1)
						return Error(playerid, "Kamu bukan anggota workshop!");
					{
						if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
						{
							if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 112;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You remove roof modifications from the {00FFFF}%s "WHITE_E"car by using component "YELLOW_E"50", GetVehicleName(pData[playerid][pMechVeh]));
							pData[playerid][pMechanic] = SetTimerEx("RemoveModification3", 4000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Removing Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"Start removing modifications in your car", pData[playerid][pName]);
								}	
							}
						}
						else
						{
							KillTimer(pData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							pData[playerid][pActivityTime] = 0;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
                }
				case 3:
				{
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");

					if(pData[playerid][pWorkshop] == -1)
						return Error(playerid, "Kamu bukan anggota workshop!");
					{
						if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
						{
							if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 112;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You remove sidekirts modifications from the {00FFFF}%s "WHITE_E"car by using component "YELLOW_E"50", GetVehicleName(pData[playerid][pMechVeh]));
							pData[playerid][pMechanic] = SetTimerEx("RemoveModification4", 4000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Removing Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"Start removing modifications in your car", pData[playerid][pName]);
								}	
							}
						}
						else
						{
							KillTimer(pData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							pData[playerid][pActivityTime] = 0;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
                }
				case 4:
				{
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");

					if(pData[playerid][pWorkshop] == -1)
						return Error(playerid, "Kamu bukan anggota workshop!");
					{
						if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
						{
							if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 112;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You remove lamps modifications from the {00FFFF}%s "WHITE_E"car by using component "YELLOW_E"50", GetVehicleName(pData[playerid][pMechVeh]));
							pData[playerid][pMechanic] = SetTimerEx("RemoveModification5", 4000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Removing Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"Start removing modifications in your car", pData[playerid][pName]);
								}	
							}
						}
						else
						{
							KillTimer(pData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							pData[playerid][pActivityTime] = 0;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
                }
				case 5:
				{
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");

					if(pData[playerid][pWorkshop] == -1)
						return Error(playerid, "Kamu bukan anggota workshop!");
					{
						if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
						{
							if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 112;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You remove nitro modifications from the {00FFFF}%s "WHITE_E"car by using component "YELLOW_E"50", GetVehicleName(pData[playerid][pMechVeh]));
							pData[playerid][pMechanic] = SetTimerEx("RemoveModification6", 4000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Removing Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"Start removing modifications in your car", pData[playerid][pName]);
								}	
							}
						}
						else
						{
							KillTimer(pData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							pData[playerid][pActivityTime] = 0;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
                }
				case 6:
				{
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");

					if(pData[playerid][pWorkshop] == -1)
						return Error(playerid, "Kamu bukan anggota workshop!");
					{
						if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
						{
							if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 112;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You remove exhaust modifications from the {00FFFF}%s "WHITE_E"car by using component "YELLOW_E"50", GetVehicleName(pData[playerid][pMechVeh]));
							pData[playerid][pMechanic] = SetTimerEx("RemoveModification7", 4000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Removing Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"Start removing modifications in your car", pData[playerid][pName]);
								}	
							}
						}
						else
						{
							KillTimer(pData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							pData[playerid][pActivityTime] = 0;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
                }
				case 7:
				{
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");

					if(pData[playerid][pWorkshop] == -1)
						return Error(playerid, "Kamu bukan anggota workshop!");
					{
						if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
						{
							if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 112;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You remove wheel modifications from the {00FFFF}%s "WHITE_E"car by using component "YELLOW_E"50", GetVehicleName(pData[playerid][pMechVeh]));
							pData[playerid][pMechanic] = SetTimerEx("RemoveModification8", 4000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Removing Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"Start removing modifications in your car", pData[playerid][pName]);
								}	
							}
						}
						else
						{
							KillTimer(pData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							pData[playerid][pActivityTime] = 0;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
                }
				case 8:
				{
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");

					if(pData[playerid][pWorkshop] == -1)
						return Error(playerid, "Kamu bukan anggota workshop!");
					{
						if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
						{
							if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 112;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You remove streo modifications from the {00FFFF}%s "WHITE_E"car by using component "YELLOW_E"50", GetVehicleName(pData[playerid][pMechVeh]));
							pData[playerid][pMechanic] = SetTimerEx("RemoveModification9", 4000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Removing Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"Start removing modifications in your car", pData[playerid][pName]);
								}	
							}
						}
						else
						{
							KillTimer(pData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							pData[playerid][pActivityTime] = 0;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
                }
				case 9:
				{
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");

					if(pData[playerid][pWorkshop] == -1)
						return Error(playerid, "Kamu bukan anggota workshop!");
					{
						if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
						{
							if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 112;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You remove hydraulic modifications from the {00FFFF}%s "WHITE_E"car by using component "YELLOW_E"50", GetVehicleName(pData[playerid][pMechVeh]));
							pData[playerid][pMechanic] = SetTimerEx("RemoveModification10", 4000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Removing Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"Start removing modifications in your car", pData[playerid][pName]);
								}	
							}
						}
						else
						{
							KillTimer(pData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							pData[playerid][pActivityTime] = 0;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
                }
				case 10:
				{
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");

					if(pData[playerid][pWorkshop] == -1)
						return Error(playerid, "Kamu bukan anggota workshop!");
					{
						if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
						{
							if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 112;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You remove front bumper modifications from the {00FFFF}%s "WHITE_E"car by using component "YELLOW_E"50", GetVehicleName(pData[playerid][pMechVeh]));
							pData[playerid][pMechanic] = SetTimerEx("RemoveModification12", 4000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Removing Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"Start removing modifications in your car", pData[playerid][pName]);
								}	
							}
						}
						else
						{
							KillTimer(pData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							pData[playerid][pActivityTime] = 0;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
                }
				case 11:
				{
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");

					if(pData[playerid][pWorkshop] == -1)
						return Error(playerid, "Kamu bukan anggota workshop!");
					{
						if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
						{
							if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 112;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You remove rear bumper modifications from the {00FFFF}%s "WHITE_E"car by using component "YELLOW_E"50", GetVehicleName(pData[playerid][pMechVeh]));
							pData[playerid][pMechanic] = SetTimerEx("RemoveModification13", 4000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Removing Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"Start removing modifications in your car", pData[playerid][pName]);
								}	
							}
						}
						else
						{
							KillTimer(pData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							pData[playerid][pActivityTime] = 0;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
                }
				case 12:
				{
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");

					if(pData[playerid][pWorkshop] == -1)
						return Error(playerid, "Kamu bukan anggota workshop!");
					{
						if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
						{
							if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 112;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You remove vent modifications from the {00FFFF}%s "WHITE_E"car by using component "YELLOW_E"50", GetVehicleName(pData[playerid][pMechVeh]));
							pData[playerid][pMechanic] = SetTimerEx("RemoveModification14", 4000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Removing Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"Start removing modifications in your car", pData[playerid][pName]);
								}	
							}
						}
						else
						{
							KillTimer(pData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							pData[playerid][pActivityTime] = 0;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
                }
				case 13:
				{
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");

					if(pData[playerid][pWorkshop] == -1)
						return Error(playerid, "Kamu bukan anggota workshop!");
					{
						if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
						{
							if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 112;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You remove spoiler modifications from the {00FFFF}%s "WHITE_E"car by using component "YELLOW_E"50", GetVehicleName(pData[playerid][pMechVeh]));
							pData[playerid][pMechanic] = SetTimerEx("RemoveModification1", 4000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Removing Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"Start removing modifications in your car", pData[playerid][pName]);
								}	
							}
						}
						else
						{
							KillTimer(pData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							pData[playerid][pActivityTime] = 0;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
                }
            }
        }
    }
    if(dialogid == DIALOG_CHANGECOLOR)
	{
		if(response)
		{
            switch(listitem)
			{
				case 0:
				{
                    if(pData[playerid][pSkillMecha] < 500) return Error(playerid, "Skill Mecha Anda harus level 2!");
                    if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
                    ShowPlayerDialog(playerid, DIALOG_SERVICE_COLOR, DIALOG_STYLE_INPUT, "Color ID 1", "Enter the color 0 - 255 | 0 - 255", "Next", "Close");
                }
                case 1:
                {
                    if(pData[playerid][pSkillMecha] < 500) return Error(playerid, "Skill Mecha Anda harus level 2!");
                    if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
					ShowPlayerDialog(playerid, DIALOG_SERVICE_PAINTJOB, DIALOG_STYLE_INPUT, "Paintjob", "Enter the vehicle paintjob id:(0 - 2 | 3 - Remove paintJob)", "Paintjob", "Close");
                }
            }
        }
    }  
    if(dialogid == DIALOG_UPGRADE)
	{
		if(response)
		{
            switch(listitem)
			{
				case 0:
				{
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");
                    new vehid = GetNearestVehicleToPlayer(playerid, 3.8, false);
					if(pData[playerid][pWorkshop] == -1)
						return Error(playerid, "Kamu bukan anggota workshop!");
					if(pvData[vehid][cMesinUpgrade] == 2)
						return Error(playerid, "Mobil ini sudah di upgrade!");
					{
						if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
						{
							if(pData[playerid][pComponent] < 120) return Error(playerid, "Component anda kurang!");
							pData[playerid][pComponent] -= 120;
							pData[playerid][pSkillMecha] += 120;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You upgrade the vehicle engine with a "YELLOW_E"120 components");
							pData[playerid][pMechanic] = SetTimerEx("UpgradeMesin", 4000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Upgrade Engine");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[vehid][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"has started examining your {00FFFF}%s "WHITE_E"engine upgrade", pData[playerid][pName], GetVehicleName(pData[playerid][pMechVeh]));
								}	
							}
						}
						else
						{
							KillTimer(pData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							pData[playerid][pActivityTime] = 0;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
                }
                case 1:
                {
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");
                    new vehid = GetNearestVehicleToPlayer(playerid, 3.8, false);
					if(pData[playerid][pWorkshop] == -1)
						return Error(playerid, "Kamu bukan anggota workshop!");
					if(pvData[vehid][pvBodyUpgrade] == 2)
						return Error(playerid, "Mobil ini sudah di upgrade!");
					{
						if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
						if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
						{
							if(pData[playerid][pComponent] < 120) return Error(playerid, "Component anda kurang!");
							pData[playerid][pComponent] -= 120;
							pData[playerid][pSkillMecha] += 120;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You upgrade the vehicle body with a "YELLOW_E"120 components");
							pData[playerid][pMechanic] = SetTimerEx("UpgradeBody", 4000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Upgrade Body");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[vehid][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"has started examining your {00FFFF}%s "WHITE_E"body upgrade", pData[playerid][pName], GetVehicleName(pData[playerid][pMechVeh]));
								}	
							}
						}
						else
						{
							KillTimer(pData[playerid][pMechanic]);
							HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
							PlayerTextDrawHide(playerid, ActiveTD[playerid]);
							pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
							pData[playerid][pActivityTime] = 0;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
							return 1;
						}
					}
                }
            }
        }
    }                
    if(dialogid == DIALOG_MODIF)
	{
		if(response)
		{
            switch(listitem)
			{
				case 0:
				{
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");
                    if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
                    if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
                    {
                        ShowPlayerDialog(playerid, DIALOG_SERVICE_WHEELS, DIALOG_STYLE_LIST, "Wheels", "Offroad\nMega\nWires\nTwist\nGrove\nImport\nAtomic\nAhab\nVirtual\nAccess\nTrance\nShadow\nRimshine\nClassic\nCutter\nSwitch\nDollar", "Confirm", "back");
                    }
                    else
                    {
                        KillTimer(pData[playerid][pMechanic]);
                        HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
                        PlayerTextDrawHide(playerid, ActiveTD[playerid]);
                        pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
                        pData[playerid][pActivityTime] = 0;
                        SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
                        return 1;
                    }
                }
                case 1:
                {
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");
                    if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
                    if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
                    {
                        ShowPlayerDialog(playerid, DIALOG_SERVICE_SPOILER,DIALOG_STYLE_LIST,"Choose below","Wheel Arc. Alien Spoiler\nWheel Arc. X-Flow Spoiler\nTransfender Win Spoiler\nTransfender Fury Spoiler\nTransfender Alpha Spoiler\nTransfender Pro Spoiler\nTransfender Champ Spoiler\nTransfender Race Spoiler\nTransfender Drag Spoiler\n","Choose","back");
                    }
                    else
                    {
                        KillTimer(pData[playerid][pMechanic]);
                        HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
                        PlayerTextDrawHide(playerid, ActiveTD[playerid]);
                        pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
                        pData[playerid][pActivityTime] = 0;
                        SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
                        return 1;
                    }
                }
                case 2:
				{
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");
                    if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
                    if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
                    {
                        ShowPlayerDialog(playerid, DIALOG_SERVICE_HOODS, DIALOG_STYLE_LIST, "Hoods", "Fury\nChamp\nRace\nWorx\n", "Confirm", "back");
                    }
                    else
                    {
                        KillTimer(pData[playerid][pMechanic]);
                        HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
                        PlayerTextDrawHide(playerid, ActiveTD[playerid]);
                        pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
                        pData[playerid][pActivityTime] = 0;
                        SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
                        return 1;
                    }
                }
                case 3:
				{
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");
                    if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
                    if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
                    {
                        ShowPlayerDialog(playerid, DIALOG_SERVICE_VENTS, DIALOG_STYLE_LIST, "Vents", "Oval\nSquare\n", "Confirm", "back");
                    }
                    else
                    {
                        KillTimer(pData[playerid][pMechanic]);
                        HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
                        PlayerTextDrawHide(playerid, ActiveTD[playerid]);
                        pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
                        pData[playerid][pActivityTime] = 0;
                        SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
                        return 1;
                    }
                }
                case 4:
				{
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");
                    if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
                    if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
                    {
                        ShowPlayerDialog(playerid, DIALOG_SERVICE_LIGHTS, DIALOG_STYLE_LIST, "Lights", "Round\nSquare\n", "Confirm", "back");
                    }
                    else
                    {
                        KillTimer(pData[playerid][pMechanic]);
                        HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
                        PlayerTextDrawHide(playerid, ActiveTD[playerid]);
                        pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
                        pData[playerid][pActivityTime] = 0;
                        SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
                        return 1;
                    }
                }
                case 5:
				{
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");
                    if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
                    if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
                    {
                        ShowPlayerDialog(playerid, DIALOG_SERVICE_EXHAUSTS, DIALOG_STYLE_LIST, "Exhausts", "Wheel Arc. Alien exhaust\nWheel Arc. X-Flow exhaust\nLow Co. Chromer exhaust\nLow Co. Slamin exhaust\nTransfender Large exhaust\nTransfender Medium exhaust\nTransfender Small exhaust\nTransfender Twin exhaust\nTransfender Upswept exhaust", "Confirm", "back");
                    }
                    else
                    {
                        KillTimer(pData[playerid][pMechanic]);
                        HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
                        PlayerTextDrawHide(playerid, ActiveTD[playerid]);
                        pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
                        pData[playerid][pActivityTime] = 0;
                        SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
                        return 1;
                    }
                }
                case 6:
				{
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");
                    if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
                    if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
                    {
                       ShowPlayerDialog(playerid, DIALOG_SERVICE_FRONT_BUMPERS, DIALOG_STYLE_LIST, "Front bumpers", "Wheel Arc. Alien Bumper\nWheel Arc. X-Flow Bumper\nLow co. Chromer Bumper\nLow co. Slamin Bumper", "Confirm", "back");
                    }
                    else
                    {
                        KillTimer(pData[playerid][pMechanic]);
                        HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
                        PlayerTextDrawHide(playerid, ActiveTD[playerid]);
                        pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
                        pData[playerid][pActivityTime] = 0;
                        SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
                        return 1;
                    }
                }
                case 7:
				{
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");
                    if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
                    if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
                    if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
                    {
                       ShowPlayerDialog(playerid, DIALOG_SERVICE_REAR_BUMPERS, DIALOG_STYLE_LIST, "Rear bumpers", "Wheel Arc. Alien Bumper\nWheel Arc. X-Flow Bumper\nLow co. Chromer Bumper\nLow co. Slamin Bumper", "Confirm", "back");
                    }
                    else
                    {
                        KillTimer(pData[playerid][pMechanic]);
                        HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
                        PlayerTextDrawHide(playerid, ActiveTD[playerid]);
                        pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
                        pData[playerid][pActivityTime] = 0;
                        SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
                        return 1;
                    }
                }
                case 8:
				{
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");
                    if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
                    if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
                    {
                        ShowPlayerDialog(playerid, DIALOG_SERVICE_ROOFS, DIALOG_STYLE_LIST, "Roofs", "Wheel Arc. Alien\nWheel Arc. X-Flow\nLow Co. Hardtop Roof\nLow Co. Softtop Roof\nTransfender Roof Scoop", "Confirm", "back");
                    }
                    else
                    {
                        KillTimer(pData[playerid][pMechanic]);
                        HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
                        PlayerTextDrawHide(playerid, ActiveTD[playerid]);
                        pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
                        pData[playerid][pActivityTime] = 0;
                        SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
                        return 1;
                    }
                }
                case 9:
				{
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");
                    if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
                    if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
                    {
                       ShowPlayerDialog(playerid, DIALOG_SERVICE_SIDE_SKIRTS, DIALOG_STYLE_LIST, "Side skirts", "Wheel Arc. Alien Side Skirt\nWheel Arc. X-Flow Side Skirt\nLocos Chrome Strip\nLocos Chrome Flames\nLocos Chrome Arches \nLocos Chrome Trim\nLocos Wheelcovers\nTransfender Side Skirt", "Confirm", "back");
                    }
                    else
                    {
                        KillTimer(pData[playerid][pMechanic]);
                        HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
                        PlayerTextDrawHide(playerid, ActiveTD[playerid]);
                        pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
                        pData[playerid][pActivityTime] = 0;
                        SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
                        return 1;
                    }
                }
                case 10:
				{
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");
                    if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
                    if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
                    {
                        ShowPlayerDialog(playerid, DIALOG_SERVICE_BULLBARS, DIALOG_STYLE_LIST, "Bull bars", "Locos Chrome Grill\nLocos Chrome Bars\nLocos Chrome Lights \nLocos Chrome Bullbar", "Confirm", "back");
                    }
                    else
                    {
                        KillTimer(pData[playerid][pMechanic]);
                        HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
                        PlayerTextDrawHide(playerid, ActiveTD[playerid]);
                        pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
                        pData[playerid][pActivityTime] = 0;
                        SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
                        return 1;
                    }
                }
                case 11:
				{
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");
                    if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
                    if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
                    {
                       ShowPlayerDialog(playerid, DIALOG_SERVICE_SIDE_SKIRTS, DIALOG_STYLE_LIST, "Side skirts", "Wheel Arc. Alien Side Skirt\nWheel Arc. X-Flow Side Skirt\nLocos Chrome Strip\nLocos Chrome Flames\nLocos Chrome Arches \nLocos Chrome Trim\nLocos Wheelcovers\nTransfender Side Skirt", "Confirm", "back");
                    }
                    else
                    {
                        KillTimer(pData[playerid][pMechanic]);
                        HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
                        PlayerTextDrawHide(playerid, ActiveTD[playerid]);
                        pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
                        pData[playerid][pActivityTime] = 0;
                        SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
                        return 1;
                    }
                }
                case 12:
				{
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");
                    if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
                    if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
                    {
                        ShowPlayerDialog(playerid, DIALOG_SERVICE_BULLBARS, DIALOG_STYLE_LIST, "Bull bars", "Locos Chrome Grill\nLocos Chrome Bars\nLocos Chrome Lights \nLocos Chrome Bullbar", "Confirm", "back");
                    }
                    else
                    {
                        KillTimer(pData[playerid][pMechanic]);
                        HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
                        PlayerTextDrawHide(playerid, ActiveTD[playerid]);
                        pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
                        pData[playerid][pActivityTime] = 0;
                        SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
                        return 1;
                    }
                }
                case 13:
				{
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");
                    pData[playerid][pMechColor1] = 1086;
                    pData[playerid][pMechColor2] = 0;
            
                    if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
                    if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
                    {	
                        if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
                        pData[playerid][pComponent] -= 50;
                        SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
                        TogglePlayerControllable(playerid, 0);
                        ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
                        pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
                        PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
                        PlayerTextDrawShow(playerid, ActiveTD[playerid]);
                        ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
						foreach(new pid : Player) 
						{
							if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
							{
								SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
							}	
						}
                    }
                    else
                    {
                        KillTimer(pData[playerid][pMechanic]);
                        HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
                        PlayerTextDrawHide(playerid, ActiveTD[playerid]);
                        pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
                        pData[playerid][pMechColor1] = 0;
                        pData[playerid][pMechColor2] = 0;
                        pData[playerid][pActivityTime] = 0;
                        SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
                        return 1;
                    }
                }
                case 14:
				{
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");
                    pData[playerid][pMechColor1] = 1087;
                    pData[playerid][pMechColor2] = 0;
            
                    if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
                    if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
                    {	
                        if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
                        pData[playerid][pComponent] -= 50;
						pData[playerid][pSkillMecha] += 50;
                        SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
                        TogglePlayerControllable(playerid, 0);
                        ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
                        pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
                        PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
                        PlayerTextDrawShow(playerid, ActiveTD[playerid]);
                        ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
						foreach(new pid : Player) 
						{
							if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
							{
								SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
							}	
						}
                    }
                    else
                    {
                        KillTimer(pData[playerid][pMechanic]);
                        HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
                        PlayerTextDrawHide(playerid, ActiveTD[playerid]);
                        pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
                        pData[playerid][pMechColor1] = 0;
                        pData[playerid][pMechColor2] = 0;
                        pData[playerid][pActivityTime] = 0;
                        SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
                        return 1;
                    }
                }
                case 15:
				{
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");
                    pData[playerid][pMechColor1] = 1009;
                    pData[playerid][pMechColor2] = 0;
            
                    if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
                    if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
                    {	
                        if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
                        pData[playerid][pComponent] -= 50;
						pData[playerid][pSkillMecha] += 50;
                        SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
                        TogglePlayerControllable(playerid, 0);
                        ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
                        pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
                        PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
                        PlayerTextDrawShow(playerid, ActiveTD[playerid]);
                        ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
						foreach(new pid : Player) 
						{
							if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
							{
								SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
							}	
						}
                    }
                    else
                    {
                        KillTimer(pData[playerid][pMechanic]);
                        HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
                        PlayerTextDrawHide(playerid, ActiveTD[playerid]);
                        pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
                        pData[playerid][pMechColor1] = 0;
                        pData[playerid][pMechColor2] = 0;
                        pData[playerid][pActivityTime] = 0;
                        SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
                        return 1;
                    }
                }
                case 16:
				{
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");
                    pData[playerid][pMechColor1] = 1008;
                    pData[playerid][pMechColor2] = 0;
            
                    if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
                    if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
                    {	
                        if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
                        pData[playerid][pComponent] -= 50;
						pData[playerid][pSkillMecha] += 50;
                        SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
                        TogglePlayerControllable(playerid, 0);
                        ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
                        pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
                        PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
                        PlayerTextDrawShow(playerid, ActiveTD[playerid]);
                        ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
						foreach(new pid : Player) 
						{
							if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
							{
								SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
							}	
						}
                    }
                    else
                    {
                        KillTimer(pData[playerid][pMechanic]);
                        HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
                        PlayerTextDrawHide(playerid, ActiveTD[playerid]);
                        pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
                        pData[playerid][pMechColor1] = 0;
                        pData[playerid][pMechColor2] = 0;
                        pData[playerid][pActivityTime] = 0;
                        SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
                        return 1;
                    }
                }
                case 17:
				{
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");
                    pData[playerid][pMechColor1] = 1010;
                    pData[playerid][pMechColor2] = 0;
            
                    if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
                    if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
                    {	
                        if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
                        pData[playerid][pComponent] -= 50;
						pData[playerid][pSkillMecha] += 50;
                        SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
                        TogglePlayerControllable(playerid, 0);
                        ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
                        pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
                        PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
                        PlayerTextDrawShow(playerid, ActiveTD[playerid]);
                        ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
						foreach(new pid : Player) 
						{
							if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
							{
								SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
							}	
						}
                    }
                    else
                    {
                        KillTimer(pData[playerid][pMechanic]);
                        HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
                        PlayerTextDrawHide(playerid, ActiveTD[playerid]);
                        pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
                        pData[playerid][pMechColor1] = 0;
                        pData[playerid][pMechColor2] = 0;
                        pData[playerid][pActivityTime] = 0;
                        SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
                        return 1;
                    }
                }
                case 18:
				{
                    if(pData[playerid][pSkillMecha] < 1500) return Error(playerid, "Skill Mecha Anda harus level 3!");
                    if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
                    if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
                    {
                        ShowPlayerDialog(playerid, DIALOG_SERVICE_NEON,DIALOG_STYLE_LIST,"Neon","Red\nBlue\nGreen\nYellow\nPink\nWhite\nRemove","Choose","back");
                    }
                    else
                    {
                        KillTimer(pData[playerid][pMechanic]);
                        HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
                        PlayerTextDrawHide(playerid, ActiveTD[playerid]);
                        pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
                        pData[playerid][pActivityTime] = 0;
                        SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
                        return 1;
                    }
                }
            }
        }
    }
	if(dialogid == DIALOG_SERVICE_COLOR)
	{
		if(response)
		{
			if(pData[playerid][pMechColor1] < 0 || pData[playerid][pMechColor1] > 255 || pData[playerid][pMechColor2] < 0 || pData[playerid][pMechColor2] > 255)
				return ShowPlayerDialog(playerid, DIALOG_SERVICE_COLOR, DIALOG_STYLE_INPUT, "Color ID 1", "Enter the color 0 - 255 | 0 - 255", "Next", "Close");
			new pos[2];
			if(!sscanf(inputtext, "dd",pos[0],pos[1])) 
			{
				pData[playerid][pMechColor1] = pos[0];
				pData[playerid][pMechColor2] = pos[1];
				if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
				if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
				{	
					if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
					pData[playerid][pComponent] -= 50;
					pData[playerid][pSkillMecha] += 50;
					SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
					pData[playerid][pMechanic] = SetTimerEx("SprayCar", 2000, true, "id", playerid, pData[playerid][pMechVeh]);
					PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Spraying Car...");
					PlayerTextDrawShow(playerid, ActiveTD[playerid]);
					ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					foreach(new pid : Player) 
					{
						if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
						{
							SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"has started examining your {00FFFF}%s "WHITE_E"color change", pData[playerid][pName], GetVehicleName(pData[playerid][pMechVeh]));
						}	
					}
				}
				else
				{
					KillTimer(pData[playerid][pMechanic]);
					HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
					PlayerTextDrawHide(playerid, ActiveTD[playerid]);
					pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
					pData[playerid][pMechColor1] = 0;
					pData[playerid][pMechColor2] = 0;
					pData[playerid][pActivityTime] = 0;
					SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
					return 1;
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_SERVICE_COLOR2)
	{
		if(response)
		{
			pData[playerid][pMechColor2] = floatround(strval(inputtext));
			
			if(pData[playerid][pMechColor2] < 0 || pData[playerid][pMechColor2] > 255)
				return ShowPlayerDialog(playerid, DIALOG_SERVICE_COLOR2, DIALOG_STYLE_INPUT, "Color ID 2", "Enter the color id 2:(0 - 255)", "Next", "Close");
			
			if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
			if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
			{	
				if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
				pData[playerid][pComponent] -= 50;
				pData[playerid][pSkillMecha] += 50;
				SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
				pData[playerid][pMechanic] = SetTimerEx("SprayCar", 2000, true, "id", playerid, pData[playerid][pMechVeh]);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Spraying Car...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
				foreach(new pid : Player) 
				{
					if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
					{
						SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"has started examining your {00FFFF}%s "WHITE_E"color change", pData[playerid][pName], GetVehicleName(pData[playerid][pMechVeh]));
					}	
				}
			}
			else
			{
				KillTimer(pData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
				pData[playerid][pMechColor1] = 0;
				pData[playerid][pMechColor2] = 0;
				pData[playerid][pActivityTime] = 0;
				SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
				return 1;
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_SERVICE_PAINTJOB)
	{
		if(response)
		{
			pData[playerid][pMechColor1] = floatround(strval(inputtext));
			
			if(pData[playerid][pMechColor1] < 0 || pData[playerid][pMechColor1] > 3)
				return ShowPlayerDialog(playerid, DIALOG_SERVICE_PAINTJOB, DIALOG_STYLE_INPUT, "Paintjob", "Enter the vehicle paintjob id:(0 - 2 | 3 - Remove paintJob)", "Paintjob", "Close");
			
			if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
			if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
			{	
				if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
				pData[playerid][pComponent] -= 50;
				pData[playerid][pSkillMecha] += 50;
				SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
				pData[playerid][pMechanic] = SetTimerEx("PaintjobCar", 2000, true, "id", playerid, pData[playerid][pMechVeh]);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Painting Car");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
				foreach(new pid : Player) 
				{
					if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
					{
						SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"has started examining your {00FFFF}%s "WHITE_E"painting vehicle", pData[playerid][pName], GetVehicleName(pData[playerid][pMechVeh]));
					}	
				}
			}
			else
			{
				KillTimer(pData[playerid][pMechanic]);
				HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
				pData[playerid][pMechColor1] = 0;
				pData[playerid][pMechColor2] = 0;
				pData[playerid][pActivityTime] = 0;
				SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
				return 1;
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_SERVICE_WHEELS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					pData[playerid][pMechColor1] = 1025;
					pData[playerid][pMechColor2] = 0;

					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						pData[playerid][pComponent] -= 50;
						pData[playerid][pSkillMecha] += 50;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
						pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
						foreach(new pid : Player) 
						{
							if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
							{
								SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
							}	
						}
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 1:
				{
					pData[playerid][pMechColor1] = 1074;
					pData[playerid][pMechColor2] = 0;
			
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{	
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						pData[playerid][pComponent] -= 50;
						pData[playerid][pSkillMecha] += 50;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
						pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
						foreach(new pid : Player) 
						{
							if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
							{
								SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
							}	
						}
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 2:
				{
					pData[playerid][pMechColor1] = 1076;
					pData[playerid][pMechColor2] = 0;
			
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{	
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						pData[playerid][pComponent] -= 50;
						pData[playerid][pSkillMecha] += 50;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
						pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
						foreach(new pid : Player) 
						{
							if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
							{
								SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
							}	
						}
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 3:
				{
					pData[playerid][pMechColor1] = 1078;
					pData[playerid][pMechColor2] = 0;
			
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{	
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						pData[playerid][pComponent] -= 50;
						pData[playerid][pSkillMecha] += 50;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
						pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
						foreach(new pid : Player) 
						{
							if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
							{
								SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
							}	
						}
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 4:
				{
					pData[playerid][pMechColor1] = 1081;
					pData[playerid][pMechColor2] = 0;
			
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{	
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						pData[playerid][pComponent] -= 50;
						pData[playerid][pSkillMecha] += 50;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
						pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
						foreach(new pid : Player) 
						{
							if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
							{
								SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
							}	
						}
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 5:
				{
					pData[playerid][pMechColor1] = 1082;
					pData[playerid][pMechColor2] = 0;
			
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{	
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						pData[playerid][pComponent] -= 50;
						pData[playerid][pSkillMecha] += 50;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
						pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
						foreach(new pid : Player) 
						{
							if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
							{
								SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
							}	
						}
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 6:
				{
					pData[playerid][pMechColor1] = 1085;
					pData[playerid][pMechColor2] = 0;
			
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{	
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						pData[playerid][pComponent] -= 50;
						pData[playerid][pSkillMecha] += 50;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
						pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
						foreach(new pid : Player) 
						{
							if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
							{
								SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
							}	
						}
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 7:
				{
					pData[playerid][pMechColor1] = 1096;
					pData[playerid][pMechColor2] = 0;
			
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{	
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						pData[playerid][pComponent] -= 50;
						pData[playerid][pSkillMecha] += 50;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
						pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
						foreach(new pid : Player) 
						{
							if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
							{
								SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
							}	
						}
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 8:
				{
					pData[playerid][pMechColor1] = 1097;
					pData[playerid][pMechColor2] = 0;
			
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{	
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						pData[playerid][pComponent] -= 50;
						pData[playerid][pSkillMecha] += 50;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
						pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
						foreach(new pid : Player) 
						{
							if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
							{
								SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
							}	
						}
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 9:
				{
					pData[playerid][pMechColor1] = 1098;
					pData[playerid][pMechColor2] = 0;
			
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{	
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						pData[playerid][pComponent] -= 50;
						pData[playerid][pSkillMecha] += 50;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
						pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
						foreach(new pid : Player) 
						{
							if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
							{
								SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
							}	
						}
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 10:
				{
					pData[playerid][pMechColor1] = 1084;
					pData[playerid][pMechColor2] = 0;
			
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{	
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						pData[playerid][pComponent] -= 50;
						pData[playerid][pSkillMecha] += 50;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
						pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
						foreach(new pid : Player) 
						{
							if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
							{
								SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
							}	
						}
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 11:
				{
					pData[playerid][pMechColor1] = 1073;
					pData[playerid][pMechColor2] = 0;
			
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{	
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						pData[playerid][pComponent] -= 50;
						pData[playerid][pSkillMecha] += 50;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
						pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
						foreach(new pid : Player) 
						{
							if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
							{
								SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
							}	
						}
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 12:
				{
					pData[playerid][pMechColor1] = 1075;
					pData[playerid][pMechColor2] = 0;
			
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{	
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						pData[playerid][pComponent] -= 50;
						pData[playerid][pSkillMecha] += 50;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
						pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
						foreach(new pid : Player) 
						{
							if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
							{
								SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
							}	
						}
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 13:
				{
					pData[playerid][pMechColor1] = 1077;
					pData[playerid][pMechColor2] = 0;
			
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{	
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						pData[playerid][pComponent] -= 50;
						pData[playerid][pSkillMecha] += 50;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
						pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
						foreach(new pid : Player) 
						{
							if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
							{
								SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
							}	
						}
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 14:
				{
					pData[playerid][pMechColor1] = 1079;
					pData[playerid][pMechColor2] = 0;
			
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{	
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						pData[playerid][pComponent] -= 50;
						pData[playerid][pSkillMecha] += 50;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
						pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
						foreach(new pid : Player) 
						{
							if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
							{
								SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
							}	
						}
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 15:
				{
					pData[playerid][pMechColor1] = 1080;
					pData[playerid][pMechColor2] = 0;
			
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{	
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						pData[playerid][pComponent] -= 50;
						pData[playerid][pSkillMecha] += 50;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
						pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
						foreach(new pid : Player) 
						{
							if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
							{
								SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
							}	
						}
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 16:
				{
					pData[playerid][pMechColor1] = 1083;
					pData[playerid][pMechColor2] = 0;
			
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{	
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						pData[playerid][pComponent] -= 50;
						pData[playerid][pSkillMecha] += 50;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
						pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
						foreach(new pid : Player) 
						{
							if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
							{
								SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
							}	
						}
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_SERVICE_SPOILER)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 70) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 562 ||
						VehicleModel == 565 ||
						VehicleModel == 559 ||
						VehicleModel == 561 ||
						VehicleModel == 558 ||
						VehicleModel == 560)
						{
							if(VehicleModel == 562)
							{
								pData[playerid][pMechColor1] = 1147;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 565)
							{
								pData[playerid][pMechColor1] = 1049;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 559)
							{
								pData[playerid][pMechColor1] = 1162;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 561)
							{
								pData[playerid][pMechColor1] = 1058;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 558)
							{
								pData[playerid][pMechColor1] = 1164;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 560)
							{
								pData[playerid][pMechColor1] = 1138;
								pData[playerid][pMechColor2] = 0;
							}
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 1:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 562 ||
						VehicleModel == 565 ||
						VehicleModel == 559 ||
						VehicleModel == 561 ||
						VehicleModel == 558 ||
						VehicleModel == 560)
						{
							if(VehicleModel == 562)
							{
								pData[playerid][pMechColor1] = 1146;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 565)
							{
								pData[playerid][pMechColor1] = 1050;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 559)
							{
								pData[playerid][pMechColor1] = 1158;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 561)
							{
								pData[playerid][pMechColor1] = 1060;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 558)
							{
								pData[playerid][pMechColor1] = 1163;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 560)
							{
								pData[playerid][pMechColor1] = 1139;
								pData[playerid][pMechColor2] = 0;
							}
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 2:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 401 ||
						VehicleModel == 518 ||
						VehicleModel == 527 ||
						VehicleModel == 415 ||
						VehicleModel == 546 ||
						VehicleModel == 603 ||
						VehicleModel == 426 ||
						VehicleModel == 436 ||
						VehicleModel == 405 ||
						VehicleModel == 477 ||
						VehicleModel == 580 ||
						VehicleModel == 550 ||
						VehicleModel == 549)
						{
				
							pData[playerid][pMechColor1] = 1001;
							pData[playerid][pMechColor2] = 0;
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 3:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 518 ||
						VehicleModel == 415 ||
						VehicleModel == 546 ||
						VehicleModel == 517 ||
						VehicleModel == 603 ||
						VehicleModel == 405 ||
						VehicleModel == 477 ||
						VehicleModel == 580 ||
						VehicleModel == 550 ||
						VehicleModel == 549)
						{
				
							pData[playerid][pMechColor1] = 1023;
							pData[playerid][pMechColor2] = 0;
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 4:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 518 ||
						VehicleModel == 415 ||
						VehicleModel == 401 ||
						VehicleModel == 517 ||
						VehicleModel == 426 ||
						VehicleModel == 436 ||
						VehicleModel == 477 ||
						VehicleModel == 547 ||
						VehicleModel == 550 ||
						VehicleModel == 549)
						{
				
							pData[playerid][pMechColor1] = 1003;
							pData[playerid][pMechColor2] = 0;
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 5:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 589 ||
						VehicleModel == 492 ||
						VehicleModel == 547 ||
						VehicleModel == 405)
						{
				
							pData[playerid][pMechColor1] = 1000;
							pData[playerid][pMechColor2] = 0;
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 6:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 527 ||
						VehicleModel == 542 ||
						VehicleModel == 405)
						{
				
							pData[playerid][pMechColor1] = 1014;
							pData[playerid][pMechColor2] = 0;
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 7:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 527 ||
						VehicleModel == 542)
						{
				
							pData[playerid][pMechColor1] = 1015;
							pData[playerid][pMechColor2] = 0;
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 8:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 546 ||
						VehicleModel == 517)
						{
				
							pData[playerid][pMechColor1] = 1002;
							pData[playerid][pMechColor2] = 0;
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
			}
		}
	}
	if(dialogid == DIALOG_SERVICE_HOODS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(
						VehicleModel == 401 ||
						VehicleModel == 518 ||
						VehicleModel == 589 ||
						VehicleModel == 492 ||
						VehicleModel == 426 ||
						VehicleModel == 550)
						{
				
							pData[playerid][pMechColor1] = 1005;
							pData[playerid][pMechColor2] = 0;
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 1:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(
						VehicleModel == 401 ||
						VehicleModel == 402 ||
						VehicleModel == 546 ||
						VehicleModel == 426 ||
						VehicleModel == 550)
						{
				
							pData[playerid][pMechColor1] = 1004;
							pData[playerid][pMechColor2] = 0;
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 2:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 401)
						{
				
							pData[playerid][pMechColor1] = 1011;
							pData[playerid][pMechColor2] = 0;
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 3:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 549)
						{
				
							pData[playerid][pMechColor1] = 1012;
							pData[playerid][pMechColor2] = 0;
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_SERVICE_VENTS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 401 ||
						VehicleModel == 518 ||
						VehicleModel == 546 ||
						VehicleModel == 517 ||
						VehicleModel == 603 ||
						VehicleModel == 547 ||
						VehicleModel == 439 ||
						VehicleModel == 550 ||
						VehicleModel == 549)
						{
				
							pData[playerid][pMechColor1] = 1142;
							pData[playerid][pMechColor2] = 1143;
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 1:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 401 ||
						VehicleModel == 518 ||
						VehicleModel == 589 ||
						VehicleModel == 546 ||
						VehicleModel == 517 ||
						VehicleModel == 603 ||
						VehicleModel == 439 ||
						VehicleModel == 550 ||
						VehicleModel == 549)
						{
				
							pData[playerid][pMechColor1] = 1144;
							pData[playerid][pMechColor2] = 1145;
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
			}
		}
	}
	if(dialogid == DIALOG_SERVICE_LIGHTS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 401 ||
						VehicleModel == 518 ||
						VehicleModel == 589 ||
						VehicleModel == 400 ||
						VehicleModel == 436 ||
						VehicleModel == 439)
						{
				
							pData[playerid][pMechColor1] = 1013;
							pData[playerid][pMechColor2] = 0;
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 1:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 589 ||
						VehicleModel == 603 ||
						VehicleModel == 400)
						{
				
							pData[playerid][pMechColor1] = 1024;
							pData[playerid][pMechColor2] = 0;
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_SERVICE_EXHAUSTS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 562 ||
						VehicleModel == 565 ||
						VehicleModel == 559 ||
						VehicleModel == 558 ||
						VehicleModel == 561 ||
						VehicleModel == 560)
						{
							if(VehicleModel == 562)
							{
								pData[playerid][pMechColor1] = 1034;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 565)
							{
								pData[playerid][pMechColor1] = 1046;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 559)
							{
								pData[playerid][pMechColor1] = 1065;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 561)
							{
								pData[playerid][pMechColor1] = 1064;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 560)
							{
								pData[playerid][pMechColor1] = 1028;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 558)
							{
								pData[playerid][pMechColor1] = 1089;
								pData[playerid][pMechColor2] = 0;
							}
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 1:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 70) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 562 ||
						VehicleModel == 565 ||
						VehicleModel == 559 ||
						VehicleModel == 558 ||
						VehicleModel == 561 ||
						VehicleModel == 560)
						{
							if(VehicleModel == 562)
							{
								pData[playerid][pMechColor1] = 1037;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 565)
							{
								pData[playerid][pMechColor1] = 1045;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 559)
							{
								pData[playerid][pMechColor1] = 1066;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 561)
							{
								pData[playerid][pMechColor1] = 1059;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 560)
							{
								pData[playerid][pMechColor1] = 1029;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 558)
							{
								pData[playerid][pMechColor1] = 1092;
								pData[playerid][pMechColor2] = 0;
							}
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 2:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 575 ||
						VehicleModel == 534 ||
						VehicleModel == 567 ||
						VehicleModel == 536 ||
						VehicleModel == 576 ||
						VehicleModel == 535)
						{
							if(VehicleModel == 575)
							{
								pData[playerid][pMechColor1] = 1044;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 534)
							{
								pData[playerid][pMechColor1] = 1126;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 567)
							{
								pData[playerid][pMechColor1] = 1129;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 536)
							{
								pData[playerid][pMechColor1] = 1104;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 576)
							{
								pData[playerid][pMechColor1] = 1113;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 535)
							{
								pData[playerid][pMechColor1] = 1136;
								pData[playerid][pMechColor2] = 0;
							}
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 3:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 575 ||
						VehicleModel == 534 ||
						VehicleModel == 567 ||
						VehicleModel == 536 ||
						VehicleModel == 576 ||
						VehicleModel == 535)
						{
							if(VehicleModel == 575)
							{
								pData[playerid][pMechColor1] = 1043;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 534)
							{
								pData[playerid][pMechColor1] = 1127;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 567)
							{
								pData[playerid][pMechColor1] = 1132;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 536)
							{
								pData[playerid][pMechColor1] = 1105;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 576)
							{
								pData[playerid][pMechColor1] = 1135;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 535)
							{
								pData[playerid][pMechColor1] = 1114;
								pData[playerid][pMechColor2] = 0;
							}
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 4:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(
						VehicleModel == 401 ||
						VehicleModel == 518 ||
						VehicleModel == 527 ||
						VehicleModel == 542 ||
						VehicleModel == 589 ||
						VehicleModel == 400 ||
						VehicleModel == 517 ||
						VehicleModel == 603 ||
						VehicleModel == 426 ||
						VehicleModel == 547 ||
						VehicleModel == 405 ||
						VehicleModel == 580 ||
						VehicleModel == 550 ||
						VehicleModel == 549 ||
						VehicleModel == 477)
						{
							
							pData[playerid][pMechColor1] = 1020;
							pData[playerid][pMechColor2] = 0;
								
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 5:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(
						VehicleModel == 527 ||
						VehicleModel == 542 ||
						VehicleModel == 400 ||
						VehicleModel == 426 ||
						VehicleModel == 436 ||
						VehicleModel == 547 ||
						VehicleModel == 405 ||
						VehicleModel == 477)
						{
							
							pData[playerid][pMechColor1] = 1021;
							pData[playerid][pMechColor2] = 0;
								
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 6:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 436)
						{
							
							pData[playerid][pMechColor1] = 1022;
							pData[playerid][pMechColor2] = 0;
								
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 7:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(
						VehicleModel == 518 ||
						VehicleModel == 415 ||
						VehicleModel == 542 ||
						VehicleModel == 546 ||
						VehicleModel == 400 ||
						VehicleModel == 517 ||
						VehicleModel == 603 ||
						VehicleModel == 426 ||
						VehicleModel == 436 ||
						VehicleModel == 547 ||
						VehicleModel == 405 ||
						VehicleModel == 550 ||
						VehicleModel == 549 ||
						VehicleModel == 477)
						{
							
							pData[playerid][pMechColor1] = 1019;
							pData[playerid][pMechColor2] = 0;
								
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 8:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(
						VehicleModel == 401 ||
						VehicleModel == 518 ||
						VehicleModel == 415 ||
						VehicleModel == 542 ||
						VehicleModel == 546 ||
						VehicleModel == 400 ||
						VehicleModel == 517 ||
						VehicleModel == 603 ||
						VehicleModel == 426 ||
						VehicleModel == 415 ||
						VehicleModel == 547 ||
						VehicleModel == 405 ||
						VehicleModel == 550 ||
						VehicleModel == 549 ||
						VehicleModel == 477)
						{
							
							pData[playerid][pMechColor1] = 1018;
							pData[playerid][pMechColor2] = 0;
								
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_SERVICE_FRONT_BUMPERS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 562 ||
						VehicleModel == 565 ||
						VehicleModel == 559 ||
						VehicleModel == 561 ||
						VehicleModel == 558 ||
						VehicleModel == 560)
						{
							if(VehicleModel == 562)
							{
								pData[playerid][pMechColor1] = 1171;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 565)
							{
								pData[playerid][pMechColor1] = 1153;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 559)
							{
								pData[playerid][pMechColor1] = 1160;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 561)
							{
								pData[playerid][pMechColor1] = 1155;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 558)
							{
								pData[playerid][pMechColor1] = 1166;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 560)
							{
								pData[playerid][pMechColor1] = 1169;
								pData[playerid][pMechColor2] = 0;
							}
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 1:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 562 ||
						VehicleModel == 565 ||
						VehicleModel == 559 ||
						VehicleModel == 561 ||
						VehicleModel == 558 ||
						VehicleModel == 560)
						{
							if(VehicleModel == 562)
							{
								pData[playerid][pMechColor1] = 1172;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 565)
							{
								pData[playerid][pMechColor1] = 1152;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 559)
							{
								pData[playerid][pMechColor1] = 1173;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 561)
							{
								pData[playerid][pMechColor1] = 1157;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 558)
							{
								pData[playerid][pMechColor1] = 1165;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 560)
							{
								pData[playerid][pMechColor1] = 1170;
								pData[playerid][pMechColor2] = 0;
							}
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 2:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 575 ||
						VehicleModel == 534 ||
						VehicleModel == 567 ||
						VehicleModel == 536 ||
						VehicleModel == 576 ||
						VehicleModel == 535)
						{
							if(VehicleModel == 575)
							{
								pData[playerid][pMechColor1] = 1174;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 534)
							{
								pData[playerid][pMechColor1] = 1179;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 567)
							{
								pData[playerid][pMechColor1] = 1189;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 536)
							{
								pData[playerid][pMechColor1] = 1182;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 576)
							{
								pData[playerid][pMechColor1] = 1191;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 535)
							{
								pData[playerid][pMechColor1] = 1115;
								pData[playerid][pMechColor2] = 0;
							}
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 3:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 575 ||
						VehicleModel == 534 ||
						VehicleModel == 567 ||
						VehicleModel == 536 ||
						VehicleModel == 576 ||
						VehicleModel == 535)
						{
							if(VehicleModel == 575)
							{
								pData[playerid][pMechColor1] = 1175;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 534)
							{
								pData[playerid][pMechColor1] = 1185;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 567)
							{
								pData[playerid][pMechColor1] = 1188;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 536)
							{
								pData[playerid][pMechColor1] = 1181;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 576)
							{
								pData[playerid][pMechColor1] = 1190;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 535)
							{
								pData[playerid][pMechColor1] = 1116;
								pData[playerid][pMechColor2] = 0;
							}
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_SERVICE_REAR_BUMPERS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 562 ||
						VehicleModel == 565 ||
						VehicleModel == 559 ||
						VehicleModel == 561 ||
						VehicleModel == 558 ||
						VehicleModel == 560)
						{
							if(VehicleModel == 562)
							{
								pData[playerid][pMechColor1] = 1149;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 565)
							{
								pData[playerid][pMechColor1] = 1150;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 559)
							{
								pData[playerid][pMechColor1] = 1159;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 561)
							{
								pData[playerid][pMechColor1] = 1154;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 558)
							{
								pData[playerid][pMechColor1] = 1168;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 560)
							{
								pData[playerid][pMechColor1] = 1141;
								pData[playerid][pMechColor2] = 0;
							}
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 1:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 562 ||
						VehicleModel == 565 ||
						VehicleModel == 559 ||
						VehicleModel == 561 ||
						VehicleModel == 558 ||
						VehicleModel == 560)
						{
							if(VehicleModel == 562)
							{
								pData[playerid][pMechColor1] = 1148;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 565)
							{
								pData[playerid][pMechColor1] = 1151;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 559)
							{
								pData[playerid][pMechColor1] = 1161;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 561)
							{
								pData[playerid][pMechColor1] = 1156;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 558)
							{
								pData[playerid][pMechColor1] = 1167;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 560)
							{
								pData[playerid][pMechColor1] = 1140;
								pData[playerid][pMechColor2] = 0;
							}
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 2:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 575 ||
						VehicleModel == 534 ||
						VehicleModel == 567 ||
						VehicleModel == 536 ||
						VehicleModel == 576 ||
						VehicleModel == 535)
						{
							if(VehicleModel == 575)
							{
								pData[playerid][pMechColor1] = 1176;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 534)
							{
								pData[playerid][pMechColor1] = 1180;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 567)
							{
								pData[playerid][pMechColor1] = 1187;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 536)
							{
								pData[playerid][pMechColor1] = 1184;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 576)
							{
								pData[playerid][pMechColor1] = 1192;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 535)
							{
								pData[playerid][pMechColor1] = 1109;
								pData[playerid][pMechColor2] = 0;
							}
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 3:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 575 ||
						VehicleModel == 534 ||
						VehicleModel == 567 ||
						VehicleModel == 536 ||
						VehicleModel == 576 ||
						VehicleModel == 535)
						{
							if(VehicleModel == 575)
							{
								pData[playerid][pMechColor1] = 1177;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 534)
							{
								pData[playerid][pMechColor1] = 1178;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 567)
							{
								pData[playerid][pMechColor1] = 1186;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 536)
							{
								pData[playerid][pMechColor1] = 1183;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 576)
							{
								pData[playerid][pMechColor1] = 1193;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 535)
							{
								pData[playerid][pMechColor1] = 1110;
								pData[playerid][pMechColor2] = 0;
							}
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_SERVICE_ROOFS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 562 ||
						VehicleModel == 565 ||
						VehicleModel == 559 ||
						VehicleModel == 561 ||
						VehicleModel == 558 ||
						VehicleModel == 560)
						{
							if(VehicleModel == 562)
							{
								pData[playerid][pMechColor1] = 1038;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 565)
							{
								pData[playerid][pMechColor1] = 1054;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 559)
							{
								pData[playerid][pMechColor1] = 1067;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 561)
							{
								pData[playerid][pMechColor1] = 1055;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 558)
							{
								pData[playerid][pMechColor1] = 1088;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 560)
							{
								pData[playerid][pMechColor1] = 1032;
								pData[playerid][pMechColor2] = 0;
							}
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 1:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 562 ||
						VehicleModel == 565 ||
						VehicleModel == 559 ||
						VehicleModel == 561 ||
						VehicleModel == 558 ||
						VehicleModel == 560)
						{
							if(VehicleModel == 562)
							{
								pData[playerid][pMechColor1] = 1038;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 565)
							{
								pData[playerid][pMechColor1] = 1053;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 559)
							{
								pData[playerid][pMechColor1] = 1068;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 561)
							{
								pData[playerid][pMechColor1] = 1061;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 558)
							{
								pData[playerid][pMechColor1] = 1091;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 560)
							{
								pData[playerid][pMechColor1] = 1033;
								pData[playerid][pMechColor2] = 0;
							}
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 2:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 567 ||
						VehicleModel == 536)
						{
							if(VehicleModel == 567)
							{
								pData[playerid][pMechColor1] = 1130;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 536)
							{
								pData[playerid][pMechColor1] = 1128;
								pData[playerid][pMechColor2] = 0;
							}
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 3:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 567 ||
						VehicleModel == 536)
						{
							if(VehicleModel == 567)
							{
								pData[playerid][pMechColor1] = 1131;
								pData[playerid][pMechColor2] = 0;
							}
							if(VehicleModel == 536)
							{
								pData[playerid][pMechColor1] = 1103;
								pData[playerid][pMechColor2] = 0;
							}
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 4:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(
						VehicleModel == 401 ||
						VehicleModel == 518 ||
						VehicleModel == 589 ||
						VehicleModel == 492 ||
						VehicleModel == 546 ||
						VehicleModel == 603 ||
						VehicleModel == 426 ||
						VehicleModel == 436 ||
						VehicleModel == 580 ||
						VehicleModel == 550 ||
						VehicleModel == 477)
						{

							pData[playerid][pMechColor1] = 1006;
							pData[playerid][pMechColor2] = 0;
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_SERVICE_SIDE_SKIRTS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 562 ||
						VehicleModel == 565 ||
						VehicleModel == 559 ||
						VehicleModel == 561 ||
						VehicleModel == 558 ||
						VehicleModel == 560)
						{
							if(VehicleModel == 562)
							{
								pData[playerid][pMechColor1] = 1036;
								pData[playerid][pMechColor2] = 1040;
							}
							if(VehicleModel == 565)
							{
								pData[playerid][pMechColor1] = 1047;
								pData[playerid][pMechColor2] = 1051;
							}
							if(VehicleModel == 559)
							{
								pData[playerid][pMechColor1] = 1069;
								pData[playerid][pMechColor2] = 1071;
							}
							if(VehicleModel == 561)
							{
								pData[playerid][pMechColor1] = 1056;
								pData[playerid][pMechColor2] = 1062;
							}
							if(VehicleModel == 558)
							{
								pData[playerid][pMechColor1] = 1090;
								pData[playerid][pMechColor2] = 1094;
							}
							if(VehicleModel == 560)
							{
								pData[playerid][pMechColor1] = 1026;
								pData[playerid][pMechColor2] = 1027;
							}
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 1:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 562 ||
						VehicleModel == 565 ||
						VehicleModel == 559 ||
						VehicleModel == 561 ||
						VehicleModel == 558 ||
						VehicleModel == 560)
						{
							if(VehicleModel == 562)
							{
								pData[playerid][pMechColor1] = 1039;
								pData[playerid][pMechColor2] = 1041;
							}
							if(VehicleModel == 565)
							{
								pData[playerid][pMechColor1] = 1048;
								pData[playerid][pMechColor2] = 1052;
							}
							if(VehicleModel == 559)
							{
								pData[playerid][pMechColor1] = 1070;
								pData[playerid][pMechColor2] = 1072;
							}
							if(VehicleModel == 561)
							{
								pData[playerid][pMechColor1] = 1057;
								pData[playerid][pMechColor2] = 1063;
							}
							if(VehicleModel == 558)
							{
								pData[playerid][pMechColor1] = 1093;
								pData[playerid][pMechColor2] = 1095;
							}
							if(VehicleModel == 560)
							{
								pData[playerid][pMechColor1] = 1031;
								pData[playerid][pMechColor2] = 1030;
							}
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 2:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 575 ||
						VehicleModel == 536 ||
						VehicleModel == 576 ||
						VehicleModel == 567)
						{
							if(VehicleModel == 575)
							{
								pData[playerid][pMechColor1] = 1042;
								pData[playerid][pMechColor2] = 1099;
							}
							if(VehicleModel == 536)
							{
								pData[playerid][pMechColor1] = 1108;
								pData[playerid][pMechColor2] = 1107;
							}
							if(VehicleModel == 576)
							{
								pData[playerid][pMechColor1] = 1134;
								pData[playerid][pMechColor2] = 1137;
							}
							if(VehicleModel == 567)
							{
								pData[playerid][pMechColor1] = 1102;
								pData[playerid][pMechColor2] = 1133;
							}
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 3:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 534)
						{
				
							pData[playerid][pMechColor1] = 1102;
							pData[playerid][pMechColor2] = 1101;
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 4:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 534)
						{
				
							pData[playerid][pMechColor1] = 1106;
							pData[playerid][pMechColor2] = 1124;
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 5:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 535)
						{
				
							pData[playerid][pMechColor1] = 1118;
							pData[playerid][pMechColor2] = 1120;
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 6:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 535)
						{
				
							pData[playerid][pMechColor1] = 1119;
							pData[playerid][pMechColor2] = 1121;
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 7:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(
						VehicleModel == 401 ||
						VehicleModel == 518 ||
						VehicleModel == 527 ||
						VehicleModel == 415 ||
						VehicleModel == 589 ||
						VehicleModel == 546 ||
						VehicleModel == 517 ||
						VehicleModel == 603 ||
						VehicleModel == 436 ||
						VehicleModel == 439 ||
						VehicleModel == 580 ||
						VehicleModel == 549 ||
						VehicleModel == 477)
						{
				
							pData[playerid][pMechColor1] = 1007;
							pData[playerid][pMechColor2] = 1017;
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_SERVICE_BULLBARS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 534)
						{
				
							pData[playerid][pMechColor1] = 1100;
							pData[playerid][pMechColor2] = 0;
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 1:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 534)
						{
				
							pData[playerid][pMechColor1] = 1123;
							pData[playerid][pMechColor2] = 0;
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 2:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 534)
						{
				
							pData[playerid][pMechColor1] = 1125;
							pData[playerid][pMechColor2] = 0;
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 3:
				{
					new VehicleModel = GetVehicleModel(pData[playerid][pMechVeh]);
					
					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						if(VehicleModel == 534)
						{
				
							pData[playerid][pMechColor1] = 1117;
							pData[playerid][pMechColor2] = 0;
							
							pData[playerid][pComponent] -= 50;
							pData[playerid][pSkillMecha] += 50;
							SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
							pData[playerid][pMechanic] = SetTimerEx("ModifCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
							PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Install Mod");
							PlayerTextDrawShow(playerid, ActiveTD[playerid]);
							ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
							foreach(new pid : Player) 
							{
								if (pvData[pData[playerid][pMechVeh]][cOwner] == pData[pid][pID])
								{
									SendClientMessageEx(pid, COLOR_ARWIN, "MECHANIC: "YELLOW_E"%s "WHITE_E"start installing modifications on your car", pData[playerid][pName]);
								}	
							}
						}
						else return Error(playerid, "This vehicle is not supported!");
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_SERVICE_NEON)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					pData[playerid][pMechColor1] = RED_NEON;

					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						pData[playerid][pComponent] -= 50;
						pData[playerid][pSkillMecha] += 50;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
						pData[playerid][pMechanic] = SetTimerEx("NeonCar", 3000, true, "id", playerid, pData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Neon Vehicle");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 1:
				{
					pData[playerid][pMechColor1] = BLUE_NEON;

					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						pData[playerid][pComponent] -= 50;
						pData[playerid][pSkillMecha] += 50;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
						pData[playerid][pMechanic] = SetTimerEx("NeonCar", 1000, true, "id", playerid, pData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Neon Vehicle");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 2:
				{
					pData[playerid][pMechColor1] = GREEN_NEON;

					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						pData[playerid][pComponent] -= 50;
						pData[playerid][pSkillMecha] += 50;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
						pData[playerid][pMechanic] = SetTimerEx("NeonCar", 1000, true, "id", playerid, pData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Neon Vehicle");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 3:
				{
					pData[playerid][pMechColor1] = YELLOW_NEON;

					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						pData[playerid][pComponent] -= 50;
						pData[playerid][pSkillMecha] += 50;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
						pData[playerid][pMechanic] = SetTimerEx("NeonCar", 1000, true, "id", playerid, pData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Neon Vehicle");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 4:
				{
					pData[playerid][pMechColor1] = PINK_NEON;

					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						pData[playerid][pComponent] -= 50;
						pData[playerid][pSkillMecha] += 50;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
						pData[playerid][pMechanic] = SetTimerEx("NeonCar", 1000, true, "id", playerid, pData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Neon Vehicle");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 5:
				{
					pData[playerid][pMechColor1] = WHITE_NEON;

					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						pData[playerid][pComponent] -= 50;
						pData[playerid][pSkillMecha] += 50;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
						pData[playerid][pMechanic] = SetTimerEx("NeonCar", 1000, true, "id", playerid, pData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Neon Vehicle");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
				case 6:
				{
					pData[playerid][pMechColor1] = 0;

					if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You already checking vehicle!");
					if(GetNearestVehicleToPlayer(playerid, 3.8, false) == pData[playerid][pMechVeh])
					{
						if(pData[playerid][pComponent] < 50) return Error(playerid, "Component anda kurang!");
						pData[playerid][pComponent] -= 50;
						pData[playerid][pSkillMecha] += 50;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"You customize the vehicle with a "YELLOW_E"50 component");
						pData[playerid][pMechanic] = SetTimerEx("NeonCar", 1000, true, "id", playerid, pData[playerid][pMechVeh]);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Neon Vehicle");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					}
					else
					{
						KillTimer(pData[playerid][pMechanic]);
						HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
						PlayerTextDrawHide(playerid, ActiveTD[playerid]);
						pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
						pData[playerid][pMechColor1] = 0;
						pData[playerid][pMechColor2] = 0;
						pData[playerid][pActivityTime] = 0;
						SendClientMessageEx(playerid, COLOR_ARWIN, "MECHANIC: "WHITE_E"Kendaraan pelanggan anda yang sebelumnya sudah terlalu jauh.");
						return 1;
					}
				}
			}
		}
		return 1;
	}

	if(dialogid == DIALOG_PLANT)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					if(pData[playerid][pSeedWheat] < 1) return Error(playerid, "Not enough seed!");
					new pid = GetNearPlant(playerid);
					if(pid != -1) return Error(playerid, "You too closes with other plant!");
					
					new id = Iter_Free(Plants);
					if(id == -1) return Error(playerid, "Cant plant any more plant!");
					
					//if(pData[playerid][pPlantTime] > 0) return Error(playerid, "You must wait 10 minutes for plant again!");
					new laid = pData[playerid][pLadang];
					if(IsPlayerInRangeOfPoint(playerid, 80.0, -237.43, -1357.56, 8.52) || IsPlayerInRangeOfPoint(playerid, 100.0, -475.43, -1343.56, 28.14)
					|| IsPlayerInRangeOfPoint(playerid, 50.0, -265.43, -1511.56, 5.49) || IsPlayerInRangeOfPoint(playerid, 30.0, -419.43, -1623.56, 18.87)
					|| IsPlayerInRangeOfPoint(playerid,60.0,-245.3497,-1369.2710,10.1751) || IsPlayerInRangeOfPoint(playerid,60.0,-280.9533,-1510.9729,6.2169)
					|| IsPlayerInRangeOfPoint(playerid, 80, laData[laid][laExtTanemX], laData[laid][laExtTanemY], laData[laid][laExtTanemZ]))
					{
					
						pData[playerid][pSeedWheat] -= 1;
						new Float:x, Float:y, Float:z, query[512];
						GetPlayerPos(playerid, x, y, z);
						
						PlantData[id][PlantType] = 1;
						PlantData[id][PlantTime] = 10800;
						PlantData[id][PlantX] = x;
						PlantData[id][PlantY] = y;
						PlantData[id][PlantZ] = z;
						PlantData[id][PlantHarvest] = false;
						PlantData[id][PlantTimer] = SetTimerEx("PlantGrowup", 1000, true, "i", id);
						Iter_Add(Plants, id);
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO plants SET id='%d', type='%d', time='%d', posx='%f', posy='%f', posz='%f'", id, PlantData[id][PlantType], PlantData[id][PlantTime], x, y, z);
						mysql_tquery(g_SQL, query, "OnPlantCreated", "di", playerid, id);
						pData[playerid][pPlant]++;
					}
					else return Error(playerid, "Kamu harus berada di flint area atau ladang pribadi kamu");
				}
				case 1:
				{
					if(pData[playerid][pSeedOnion] < 1) return Error(playerid, "Not enough seed!");
					new pid = GetNearPlant(playerid);
					if(pid != -1) return Error(playerid, "You too closes with other plant!");
					
					new id = Iter_Free(Plants);
					if(id == -1) return Error(playerid, "Cant plant any more plant!");
					
					//if(pData[playerid][pPlantTime] > 0) return Error(playerid, "You must wait 10 minutes for plant again!");
					new laid = pData[playerid][pLadang];
					if(IsPlayerInRangeOfPoint(playerid, 80.0, -237.43, -1357.56, 8.52) || IsPlayerInRangeOfPoint(playerid, 100.0, -475.43, -1343.56, 28.14)
					|| IsPlayerInRangeOfPoint(playerid, 50.0, -265.43, -1511.56, 5.49) || IsPlayerInRangeOfPoint(playerid, 30.0, -419.43, -1623.56, 18.87)
					|| IsPlayerInRangeOfPoint(playerid,60.0,-245.3497,-1369.2710,10.1751) || IsPlayerInRangeOfPoint(playerid,60.0,-280.9533,-1510.9729,6.2169)
					|| IsPlayerInRangeOfPoint(playerid, 80, laData[laid][laExtTanemX], laData[laid][laExtTanemY], laData[laid][laExtTanemZ]))
					{
					
						pData[playerid][pSeedOnion] -= 1;
						new Float:x, Float:y, Float:z, query[512];
						GetPlayerPos(playerid, x, y, z);
						
						PlantData[id][PlantType] = 2;
						PlantData[id][PlantTime] = 10800;
						PlantData[id][PlantX] = x;
						PlantData[id][PlantY] = y;
						PlantData[id][PlantZ] = z;
						PlantData[id][PlantHarvest] = false;
						PlantData[id][PlantTimer] = SetTimerEx("PlantGrowup", 1000, true, "i", id);
						Iter_Add(Plants, id);
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO plants SET id='%d', type='%d', time='%d', posx='%f', posy='%f', posz='%f'", id, PlantData[id][PlantType], PlantData[id][PlantTime], x, y, z);
						mysql_tquery(g_SQL, query, "OnPlantCreated", "di", playerid, id);
						pData[playerid][pPlant]++;
					}
					else return Error(playerid, "Kamu harus berada di flint area atau ladang pribadi kamu");
				}
				case 2:
				{
					if(pData[playerid][pSeedCarrot] < 1) return Error(playerid, "Not enough seed!");
					new pid = GetNearPlant(playerid);
					if(pid != -1) return Error(playerid, "You too closes with other plant!");
					
					new id = Iter_Free(Plants);
					if(id == -1) return Error(playerid, "Cant plant any more plant!");
					
					//if(pData[playerid][pPlantTime] > 0) return Error(playerid, "You must wait 10 minutes for plant again!");
					new laid = pData[playerid][pLadang];
					if(IsPlayerInRangeOfPoint(playerid, 80.0, -237.43, -1357.56, 8.52) || IsPlayerInRangeOfPoint(playerid, 100.0, -475.43, -1343.56, 28.14)
					|| IsPlayerInRangeOfPoint(playerid, 50.0, -265.43, -1511.56, 5.49) || IsPlayerInRangeOfPoint(playerid, 30.0, -419.43, -1623.56, 18.87)
					|| IsPlayerInRangeOfPoint(playerid,60.0,-245.3497,-1369.2710,10.1751) || IsPlayerInRangeOfPoint(playerid,60.0,-280.9533,-1510.9729,6.2169)
					|| IsPlayerInRangeOfPoint(playerid, 80, laData[laid][laExtTanemX], laData[laid][laExtTanemY], laData[laid][laExtTanemZ]))
					{
					
						pData[playerid][pSeedCarrot] -= 1;
						new Float:x, Float:y, Float:z, query[512];
						GetPlayerPos(playerid, x, y, z);
						
						PlantData[id][PlantType] = 3;
						PlantData[id][PlantTime] = 10800;
						PlantData[id][PlantX] = x;
						PlantData[id][PlantY] = y;
						PlantData[id][PlantZ] = z;
						PlantData[id][PlantHarvest] = false;
						PlantData[id][PlantTimer] = SetTimerEx("PlantGrowup", 1000, true, "i", id);
						Iter_Add(Plants, id);
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO plants SET id='%d', type='%d', time='%d', posx='%f', posy='%f', posz='%f'", id, PlantData[id][PlantType], PlantData[id][PlantTime], x, y, z);
						mysql_tquery(g_SQL, query, "OnPlantCreated", "di", playerid, id);
						pData[playerid][pPlant]++;
					}
					else return Error(playerid, "Kamu harus berada di flint area atau ladang pribadi kamu");
				}
				case 3:
				{
					if(pData[playerid][pSeedPotato] < 1) return Error(playerid, "Not enough seed!");
					new pid = GetNearPlant(playerid);
					if(pid != -1) return Error(playerid, "You too closes with other plant!");
					
					new id = Iter_Free(Plants);
					if(id == -1) return Error(playerid, "Cant plant any more plant!");
					
					//if(pData[playerid][pPlantTime] > 0) return Error(playerid, "You must wait 10 minutes for plant again!");
					new laid = pData[playerid][pLadang];
					if(IsPlayerInRangeOfPoint(playerid, 80.0, -237.43, -1357.56, 8.52) || IsPlayerInRangeOfPoint(playerid, 100.0, -475.43, -1343.56, 28.14)
					|| IsPlayerInRangeOfPoint(playerid, 50.0, -265.43, -1511.56, 5.49) || IsPlayerInRangeOfPoint(playerid, 30.0, -419.43, -1623.56, 18.87)
					|| IsPlayerInRangeOfPoint(playerid,60.0,-245.3497,-1369.2710,10.1751) || IsPlayerInRangeOfPoint(playerid,60.0,-280.9533,-1510.9729,6.2169)
					|| IsPlayerInRangeOfPoint(playerid, 80, laData[laid][laExtTanemX], laData[laid][laExtTanemY], laData[laid][laExtTanemZ]))
					{
					
						pData[playerid][pSeedPotato] -= 1;
						new Float:x, Float:y, Float:z, query[512];
						GetPlayerPos(playerid, x, y, z);
						
						PlantData[id][PlantType] = 4;
						PlantData[id][PlantTime] = 10800;
						PlantData[id][PlantX] = x;
						PlantData[id][PlantY] = y;
						PlantData[id][PlantZ] = z;
						PlantData[id][PlantHarvest] = false;
						PlantData[id][PlantTimer] = SetTimerEx("PlantGrowup", 1000, true, "i", id);
						Iter_Add(Plants, id);
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO plants SET id='%d', type='%d', time='%d', posx='%f', posy='%f', posz='%f'", id, PlantData[id][PlantType], PlantData[id][PlantTime], x, y, z);
						mysql_tquery(g_SQL, query, "OnPlantCreated", "di", playerid, id);
						pData[playerid][pPlant]++;
					}
					else return Error(playerid, "Kamu harus berada di flint area atau ladang pribadi kamu");
				}
				case 4:
				{
					if(pData[playerid][pSeedCorn] < 1) return Error(playerid, "Not enough seed!");
					new pid = GetNearPlant(playerid);
					if(pid != -1) return Error(playerid, "You too closes with other plant!");
					
					new id = Iter_Free(Plants);
					if(id == -1) return Error(playerid, "Cant plant any more plant!");
					
					//if(pData[playerid][pPlantTime] > 0) return Error(playerid, "You must wait 10 minutes for plant again!");
					new laid = pData[playerid][pLadang];
					if(IsPlayerInRangeOfPoint(playerid, 80.0, -237.43, -1357.56, 8.52) || IsPlayerInRangeOfPoint(playerid, 100.0, -475.43, -1343.56, 28.14)
					|| IsPlayerInRangeOfPoint(playerid, 50.0, -265.43, -1511.56, 5.49) || IsPlayerInRangeOfPoint(playerid, 30.0, -419.43, -1623.56, 18.87)
					|| IsPlayerInRangeOfPoint(playerid,60.0,-245.3497,-1369.2710,10.1751) || IsPlayerInRangeOfPoint(playerid,60.0,-280.9533,-1510.9729,6.2169)
					|| IsPlayerInRangeOfPoint(playerid, 80, laData[laid][laExtTanemX], laData[laid][laExtTanemY], laData[laid][laExtTanemZ]))
					{
					
						pData[playerid][pSeedCorn] -= 1;
						new Float:x, Float:y, Float:z, query[512];
						GetPlayerPos(playerid, x, y, z);
						
						PlantData[id][PlantType] = 5;
						PlantData[id][PlantTime] = 10800;
						PlantData[id][PlantX] = x;
						PlantData[id][PlantY] = y;
						PlantData[id][PlantZ] = z;
						PlantData[id][PlantHarvest] = false;
						PlantData[id][PlantTimer] = SetTimerEx("PlantGrowup", 1000, true, "i", id);
						Iter_Add(Plants, id);
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO plants SET id='%d', type='%d', time='%d', posx='%f', posy='%f', posz='%f'", id, PlantData[id][PlantType], PlantData[id][PlantTime], x, y, z);
						mysql_tquery(g_SQL, query, "OnPlantCreated", "di", playerid, id);
						pData[playerid][pPlant]++;
					}
					else return Error(playerid, "Kamu harus berada di flint area atau ladang pribadi kamu");
				}
			}
		}
	}
	if(dialogid == DIALOG_COMPONENT)
	{
		if(response)
		{
			new amount = floatround(strval(inputtext));
			new total = pData[playerid][pComponent] + amount;
			new vehicleid = GetPlayerVehicleID(playerid), strings[212];
			new total1 = pvData[vehicleid][cComponent] + amount;
			new value = amount * 50;
			if(amount < 0 || amount > 1000) return Error(playerid, "amount maximal 0 - 1000");
			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
				if(total1 > 1000) return Error(playerid, "Component too full in your inventory! Maximal 1000");
				if(GetPlayerMoney(playerid) < value) return Error(playerid, "Uang anda kurang.");
				if(StockComponent < amount) return Error(playerid, "Component stock tidak mencukupi.");
				GivePlayerMoneyEx(playerid, -value);
				pvData[vehicleid][cComponent] += amount;
				StockComponent -= amount;
				Server_AddMoney(value);
				ComponentStockRefresh();
				SendClientMessageEx(playerid, COLOR_ARWIN, "COMPONENT: "WHITE_E"Anda berhasil membeli "GREEN_E"%d "WHITE_E"component seharga "RED_E"$%s.", amount, FormatMoney(value));
				if(IsValidDynamicObject(ObjectVehicle[pvData[vehicleid][cVeh]][0]))
				{
					DestroyDynamicObject(ObjectVehicle[pvData[vehicleid][cVeh]][0]);
				}
				if(GetVehicleModel(pvData[vehicleid][cVeh]) == 422 || GetVehicleModel(pvData[vehicleid][cVeh]) == 543)
				{
					ObjectVehicle[pvData[vehicleid][cVeh]][0] = CreateDynamicObject(964,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
					AttachDynamicObjectToVehicle(ObjectVehicle[pvData[vehicleid][cVeh]][0], pvData[vehicleid][cVeh], 0.000, -1.180, -0.220, 0.000, 0.000, 0.000);	
				}
				format(strings, sizeof(strings), "{00FFFF}Component Factory\n"WHITE_E"Price: "GREEN_E"$0.50 "WHITE_E"/ unit\n"WHITE_E"Stock: "GREEN_E"%d "YELLOW_E"/ 50000\n"WHITE_E"Use '"YELLOW_E"/buycomponent"WHITE_E"' to buy components", StockComponent);
				UpdateDynamic3DTextLabelText(Compo2, COLOR_ARWIN, strings);
			}
			else
			{
				if(total > 250) return Error(playerid, "Component too full in your inventory! Maximal 250");
				if(GetPlayerMoney(playerid) < value) return Error(playerid, "Uang anda kurang.");
				if(StockComponent < amount) return Error(playerid, "Component stock tidak mencukupi.");
				GivePlayerMoneyEx(playerid, -value);
				pData[playerid][pComponent] += amount;
				StockComponent -= amount;
				Server_AddMoney(value);
				ComponentStockRefresh();
				SendClientMessageEx(playerid, COLOR_ARWIN, "COMPONENT: "WHITE_E"Anda berhasil membeli "GREEN_E"%d "WHITE_E"component seharga "RED_E"$%s.", amount, FormatMoney(value));
				format(strings, sizeof(strings), "{00FFFF}Component Factory\n"WHITE_E"Price: "GREEN_E"$0.50 "WHITE_E"/ unit\n"WHITE_E"Stock: "GREEN_E"%d "YELLOW_E"/ 50000\n"WHITE_E"Use '"YELLOW_E"/buycomponent"WHITE_E"' to buy components", StockComponent);
				UpdateDynamic3DTextLabelText(Compo2, COLOR_ARWIN, strings);
			}
		}
	}
	if(dialogid == DIALOG_PACKETCGUN)
	{
		if(response)
		{
			new strings[214];
			if(GetPlayerMoney(playerid) < 200368) return Error(playerid, "You don't have enough cash");
			GivePlayerMoneyEx(playerid, -200368);
			pData[playerid][pMaterial] += 2500;
			StockMaterial -= 2500;
			format(strings, sizeof(strings), ""RED_E"Job: Arms Dealer\n"YELLOW_E"'/joinjob' "WHITE_E"to be an Arms Dealer\n"YELLOW_E"'/buypacket' "WHITE_E"to buy gun material package\nAvailable packages: "GREEN_E"%d", StockMaterial);
			UpdateDynamic3DTextLabelText(Material, COLOR_ARWIN, strings);
			SendClientMessageEx(playerid, COLOR_ARWIN, "DEALER: "WHITE_E"You've purchase a material package that contains "YELLOW_E"2500 units "WHITE_E"of material for "GREEN_E"$2,003.68");
		}
	}
	if(dialogid == DIALOG_BUYPOT)
	{
		if(response)
		{
			new strings2[214];
			if(GetPlayerMoney(playerid) < 30436) return Error(playerid, "You don't have enough cash");
			GivePlayerMoneyEx(playerid, -30436);
			pData[playerid][pPot] += 100;
			StockCrack -= 100;
			format(strings2, sizeof(strings2), ""RED_E"Job: Drugs Dealer\n"YELLOW_E"'/joinjob' "WHITE_E"to be an Drug Dealer\n"YELLOW_E"'/buypacket' "WHITE_E"to buy drugs package\nAvailable packages: "GREEN_E"%d", StockCrack);
			UpdateDynamic3DTextLabelText(Crack, COLOR_ARWIN, strings2);
			SendClientMessageEx(playerid, COLOR_ARWIN, "DEALER: "WHITE_E"You've purchase a drug package that contains "YELLOW_E"100 grams "WHITE_E"of pot for "GREEN_E"$304.36");
		}
	}
	if(dialogid == DIALOG_BUYCRACK)
	{
		if(response)
		{
			new strings2[214];
			if(GetPlayerMoney(playerid) < 30436) return Error(playerid, "You don't have enough cash");
			GivePlayerMoneyEx(playerid, -30436);
			pData[playerid][pCrack] += 50;
			StockCrack -= 50;
			format(strings2, sizeof(strings2), ""RED_E"Job: Drugs Dealer\n"YELLOW_E"'/joinjob' "WHITE_E"to be an Drug Dealer\n"YELLOW_E"'/buypacket' "WHITE_E"to buy drugs package\nAvailable packages: "GREEN_E"%d", StockCrack);
			UpdateDynamic3DTextLabelText(Crack, COLOR_ARWIN, strings2);
			SendClientMessageEx(playerid, COLOR_ARWIN, "DEALER: "WHITE_E"You've purchase a drug package that contains "YELLOW_E"50 grams "WHITE_E"of crack for "GREEN_E"$304.36");
		}
	}
	if(dialogid == DIALOG_EDIT_PRICE)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new mstr[128];
					format(mstr, sizeof(mstr), ""WHITE_E"Masukan harga Sprunk(1 - 500):\nPrice 1(Sprunk): "GREEN_E"$%s", FormatMoney(pData[playerid][pPrice1]));
					ShowPlayerDialog(playerid, DIALOG_EDIT_PRICE1, DIALOG_STYLE_INPUT, "Price 1", mstr, "Edit", "Cancel");
				}
				case 1:
				{
					new mstr[128];
					format(mstr, sizeof(mstr), ""WHITE_E"Masukan harga Snack(1 - 500):\nPrice 2(Snack): "GREEN_E"$%s", FormatMoney(pData[playerid][pPrice2]));
					ShowPlayerDialog(playerid, DIALOG_EDIT_PRICE2, DIALOG_STYLE_INPUT, "Price 2", mstr, "Edit", "Cancel");
				}
				case 2:
				{
					new mstr[128];
					format(mstr, sizeof(mstr), ""WHITE_E"Masukan harga Ice Cream Orange(1 - 500):\nPrice 3(Ice Cream Orange): "GREEN_E"$%s", FormatMoney(pData[playerid][pPrice3]));
					ShowPlayerDialog(playerid, DIALOG_EDIT_PRICE3, DIALOG_STYLE_INPUT, "Price 3", mstr, "Edit", "Cancel");
				}
				case 3:
				{
					new mstr[128];
					format(mstr, sizeof(mstr), ""WHITE_E"Masukan harga Hotdog(1 - 500):\nPrice 4(Hotdog): "GREEN_E"$%s", FormatMoney(pData[playerid][pPrice4]));
					ShowPlayerDialog(playerid, DIALOG_EDIT_PRICE4, DIALOG_STYLE_INPUT, "Price 4", mstr, "Edit", "Cancel");
				}
			}
		}
	}
	if(dialogid == DIALOG_EDIT_PRICE1)
	{
		if(response)
		{
			new amount = floatround(strval(inputtext));
			
			if(amount < 0 || amount > 10000) return Error(playerid, "Invalid price! $1 - $100.00");
			pData[playerid][pPrice1] = amount;
			SendClientMessageEx(playerid, COLOR_ARWIN, "BISNIS: "WHITE_E"Anda berhasil mengedit price 1(Sprunk) ke "GREEN_E"$%s.", FormatMoney(amount));
			return 1;
		}
	}
	if(dialogid == DIALOG_EDIT_PRICE2)
	{
		if(response)
		{
			new amount = floatround(strval(inputtext));
			
			if(amount < 0 || amount > 10000) return Error(playerid, "Invalid price! $1 - $100.00.");
			pData[playerid][pPrice2] = amount;
			SendClientMessageEx(playerid, COLOR_ARWIN, "BISNIS: "WHITE_E"Anda berhasil mengedit price 2(Snack) ke "GREEN_E"$%s.", FormatMoney(amount));
			return 1;
		}
	}
	if(dialogid == DIALOG_EDIT_PRICE3)
	{
		if(response)
		{
			new amount = floatround(strval(inputtext));
			
			if(amount < 0 || amount > 10000) return Error(playerid, "Invalid price! $1 - $100.00.");
			pData[playerid][pPrice3] = amount;
			SendClientMessageEx(playerid, COLOR_ARWIN, "BISNIS: "WHITE_E"Anda berhasil mengedit price 3(Ice Cream Orange) ke "GREEN_E"$%s.", FormatMoney(amount));
			return 1;
		}
	}
	if(dialogid == DIALOG_EDIT_PRICE4)
	{
		if(response)
		{
			new amount = floatround(strval(inputtext));
			
			if(amount < 0 || amount > 10000) return Error(playerid, "Invalid price! $1 - $100.00.");
			pData[playerid][pPrice4] = amount;
			SendClientMessageEx(playerid, COLOR_ARWIN, "BISNIS: "WHITE_E"Anda berhasil mengedit price 4(Hotdog) ke "GREEN_E"$%s.", FormatMoney(amount));
			return 1;
		}
	}
	if(dialogid == DIALOG_OFFER)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new id = pData[playerid][pOffer];
					if(!IsPlayerConnected(id) || !NearPlayer(playerid, id, 4.0))
						return Error(playerid, "You not near with offer player!");
					
					if(GetPlayerMoney(playerid) < pData[id][pPrice1])
						return Error(playerid, "Not enough money!");
						
					if(pData[id][pFood] < 5)
						return Error(playerid, "Food stock empty!");
					
					GivePlayerMoneyEx(id, pData[id][pPrice1]);
					pData[id][pFood] -= 5;
					
					GivePlayerMoneyEx(playerid, -pData[id][pPrice1]);
					pData[playerid][pSprunk] += 1;
					
					SendNearbyMessage(playerid, 10.0, COLOR_PURPLE, "** %s telah membeli sprunk seharga $%s.", ReturnName(playerid), FormatMoney(pData[id][pPrice1]));
				}
				case 1:
				{
					new id = pData[playerid][pOffer];
					if(!IsPlayerConnected(id) || !NearPlayer(playerid, id, 4.0))
						return Error(playerid, "You not near with offer player!");
					
					if(GetPlayerMoney(playerid) < pData[id][pPrice2])
						return Error(playerid, "Not enough money!");
					
					if(pData[id][pFood] < 5)
						return Error(playerid, "Food stock empty!");
						
					GivePlayerMoneyEx(id, pData[id][pPrice2]);
					pData[id][pFood] -= 5;
					
					GivePlayerMoneyEx(playerid, -pData[id][pPrice2]);
					pData[playerid][pSnack] += 1;
					
					SendNearbyMessage(playerid, 10.0, COLOR_PURPLE, "** %s telah membeli snack seharga $%s.", ReturnName(playerid), FormatMoney(pData[id][pPrice2]));	
				}
				case 2:
				{
					new id = pData[playerid][pOffer];
					if(!IsPlayerConnected(id) || !NearPlayer(playerid, id, 4.0))
						return Error(playerid, "You not near with offer player!");
					
					if(GetPlayerMoney(playerid) < pData[id][pPrice3])
						return Error(playerid, "Not enough money!");
					
					if(pData[id][pFood] < 10)
						return Error(playerid, "Food stock empty!");
						
					GivePlayerMoneyEx(id, pData[id][pPrice3]);
					pData[id][pFood] -= 10;
					
					GivePlayerMoneyEx(playerid, -pData[id][pPrice3]);
					pData[playerid][pEnergy] += 30;
					
					SendNearbyMessage(playerid, 10.0, COLOR_PURPLE, "** %s telah membeli ice cream orange seharga $%s.", ReturnName(playerid), FormatMoney(pData[id][pPrice3]));
				}
				case 3:
				{
					new id = pData[playerid][pOffer];
					if(!IsPlayerConnected(id) || !NearPlayer(playerid, id, 4.0))
						return Error(playerid, "You not near with offer player!");
					
					if(GetPlayerMoney(playerid) < pData[id][pPrice4])
						return Error(playerid, "Not enough money!");
						
					if(pData[id][pFood] < 10)
						return Error(playerid, "Food stock empty!");
					
					GivePlayerMoneyEx(id, pData[id][pPrice4]);
					pData[id][pFood] -= 10;
					
					GivePlayerMoneyEx(playerid, -pData[id][pPrice4]);
					pData[playerid][pHunger] += 30;
					
					SendNearbyMessage(playerid, 10.0, COLOR_PURPLE, "** %s telah membeli hotdog seharga $%s.", ReturnName(playerid), FormatMoney(pData[id][pPrice4]));
				}
			}
		}
		pData[playerid][pOffer] = -1;
	}
	/*if(dialogid == DIALOG_APOTEK)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					if(Apotek < 1) return Error(playerid, "Product out of stock!");
					if(GetPlayerMoney(playerid) < MedicinePrice) return Error(playerid, "Not enough money.");
					pData[playerid][pMedicine]++;
					Apotek--;
					GivePlayerMoneyEx(playerid, -2500);
					Server_AddMoney(MedicinePrice);
					SendClientMessageEx(playerid, COLOR_ARWIN, "APOTEK: "WHITE_E"Anda membeli medicine seharga "RED_E"$25.00,"WHITE_E" /use untuk menggunakannya.", FormatMoney(MedicinePrice));
				}
				case 1:
				{
					if(Apotek < 1) return Error(playerid, "Product out of stock!");
					if(pData[playerid][pFaction] != 3) return Error(playerid, "You are not a medical member.");
					if(GetPlayerMoney(playerid) < MedkitPrice) return Error(playerid, "Not enough money.");
					pData[playerid][pMedkit]++;
					Apotek--;
					GivePlayerMoneyEx(playerid, -2500);
					Server_AddMoney(MedkitPrice);
					SendClientMessageEx(playerid, COLOR_ARWIN, "APOTEK: "WHITE_E"Anda membeli medkit seharga "RED_E"$25.00", FormatMoney(MedkitPrice));
				}
				case 2:
				{
					if(Apotek < 1) return Error(playerid, "Product out of stock!");
					if(pData[playerid][pFaction] != 3) return Error(playerid, "You are not a medical member.");
					if(GetPlayerMoney(playerid) < 100) return Error(playerid, "Not enough money.");
					pData[playerid][pBandage]++;
					Apotek--;
					GivePlayerMoneyEx(playerid, -1000);
					Server_AddMoney(100);
					SendClientMessageEx(playerid, COLOR_ARWIN, "APOTEK: "WHITE_E"Anda membeli bandage seharga "RED_E"$10.00");
				}
			}
		}
	}*/
	if(dialogid == DIALOG_ATM)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0: // Check Balance
			{
				new mstr[512];
				format(mstr, sizeof(mstr), "{F6F6F6}You have "LB_E"$%s {F6F6F6}in your bank account.", FormatMoney(pData[playerid][pBankMoney]));
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""LB_E"Bank", mstr, "Close", "");
			}
			case 1: // Withdraw
			{
				new mstr[128];			
				format(mstr, sizeof(mstr), ""WHITE_E"My Balance: "LB_E"$%s", FormatMoney(pData[playerid][pBankMoney]));
				ShowPlayerDialog(playerid, DIALOG_ATMWITHDRAW, DIALOG_STYLE_LIST, mstr, "$50.00\n$200.00\n$500.00\n$1,000.00\n$5,000.00", "Withdraw", "Cancel");
			}
			case 2: //Paycheck
			{
				DisplayPaycheck(playerid);
			}
		}
	}
	if(dialogid == DIALOG_ATMWITHDRAW)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					if(pData[playerid][pBankMoney] < 5000)
						return Error(playerid, "Not enough balance!");
					
					GivePlayerMoneyEx(playerid, 5000);
					pData[playerid][pBankMoney] -= 5000;
					SendClientMessageEx(playerid, COLOR_ARWIN, "ATMINFO: "WHITE_E"You withdraw "LG_E"$50.00");
				}
				case 1:
				{
					if(pData[playerid][pBankMoney] < 20000)
						return Error(playerid, "Not enough balance!");
					
					GivePlayerMoneyEx(playerid, 20000);
					pData[playerid][pBankMoney] -= 20000;
					SendClientMessageEx(playerid, COLOR_ARWIN, "ATMINFO: "WHITE_E"You withdraw "LG_E"$200.00");
				}
				case 2:
				{
					if(pData[playerid][pBankMoney] < 50000)
						return Error(playerid, "Not enough balance!");
					
					GivePlayerMoneyEx(playerid, 50000);
					pData[playerid][pBankMoney] -= 50000;
					SendClientMessageEx(playerid, COLOR_ARWIN, "ATMINFO: "WHITE_E"You withdraw "LG_E"$500.00");
				}
				case 3:
				{
					if(pData[playerid][pBankMoney] < 100000)
						return Error(playerid, "Not enough balance!");
					
					GivePlayerMoneyEx(playerid, 100000);
					pData[playerid][pBankMoney] -= 100000;
					SendClientMessageEx(playerid, COLOR_ARWIN, "ATMINFO: "WHITE_E"You withdraw "LG_E"$1,000.00");
				}
				case 4:
				{
					if(pData[playerid][pBankMoney] < 500000)
						return Error(playerid, "Not enough balance!");
					
					GivePlayerMoneyEx(playerid, 500000);
					pData[playerid][pBankMoney] -= 500000;
					SendClientMessageEx(playerid, COLOR_ARWIN, "ATMINFO: "WHITE_E"You withdraw "LG_E"$5,000.00");
				}
			}
		}
	}
	if(dialogid == DIALOG_BANK)
	{
		if(!response) return true;
		switch(listitem)
		{
			case 0: // Check Balance
			{
				new mstr[512];
				format(mstr, sizeof(mstr), "{F6F6F6}You have "LB_E"$%s {F6F6F6}in your bank account.", FormatMoney(pData[playerid][pBankMoney]));
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""LB_E"Bank", mstr, "Close", "");
			}
			case 1:
			{
				DisplayPaycheck(playerid);
			}
		}
	}
	if(dialogid == DIALOG_BANKREKENING)
	{
		if(!response) return true;
		new amount = floatround(strval(inputtext));
		if(amount > pData[playerid][pBankMoney]) return Error(playerid, "Uang dalam rekening anda kurang.");
		if(amount < 1) return Error(playerid, "You have entered an invalid amount!");

		else
		{
			pData[playerid][pTransfer] = amount;
			ShowPlayerDialog(playerid, DIALOG_BANKTRANSFER, DIALOG_STYLE_INPUT, ""LB_E"Bank", "Masukan nomor rekening target:", "Transfer", "Cancel");
		}
	}
	if(dialogid == DIALOG_BANKTRANSFER)
	{

		/*if(!response) return true;
		new rek = floatround(strval(inputtext)), query[128];
	    if(rek < 1) return Error(playerid, "You have entered an invalid no rek!");
	    
		mysql_format(g_SQL, query, sizeof(query), "SELECT brek FROM players WHERE brek='%d'", rek);
	    mysql_tquery(g_SQL, query, "SearchRek", "id", playerid, rek);*/
		return 1;
	}
	if(dialogid == DIALOG_BANKCONFIRM)
	{
		if(response)
		{
			new query[128], mstr[248];
			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET bmoney=bmoney+%d WHERE brek=%d", pData[playerid][pTransfer], pData[playerid][pTransferRek]);
			mysql_tquery(g_SQL, query);
			
			foreach(new ii : Player)
			{
				if(pData[ii][pBankRek] == pData[playerid][pTransferRek])
				{
					pData[ii][pBankMoney] += pData[playerid][pTransfer];
				}
			}
			
			pData[playerid][pBankMoney] -= pData[playerid][pTransfer];
			
			format(mstr, sizeof(mstr), ""WHITE_E"No Rek Target: "YELLOW_E"%d\n"WHITE_E"Nama Target: "YELLOW_E"%s\n"WHITE_E"Jumlah: "GREEN_E"%s\n\n"WHITE_E"Anda telah berhasil mentransfer!", pData[playerid][pTransferRek], pData[playerid][pTransferName], FormatMoney(pData[playerid][pTransfer]));
			ShowPlayerDialog(playerid, DIALOG_BANKSUKSES, DIALOG_STYLE_MSGBOX, ""LB_E"Transfer Sukses", mstr, "Sukses", "");
		}
	}
	if(dialogid == DIALOG_BANKSUKSES)
	{
		if(response)
		{
			pData[playerid][pTransfer] = 0;
			pData[playerid][pTransferRek] = 0;
		}
	}
	if(dialogid == DIALOG_REPORTS)
	{
		if(response) 
		{
			new i = ListItemReportId[playerid][listitem];
			if(pData[playerid][pAdmin] < 1)
				if(pData[playerid][pHelper] == 0)
					return PermissionError(playerid);
			new String[212];
			
			format(String, sizeof(String), "RESPOND: {FF0000}%s {FFFFFF}has accepted the report from {00FFFF}%s[id:%d].", pData[playerid][pAdminname], pData[Reports[i][ReportFrom]][pName],Reports[i][ReportFrom]);
			SendStaffMessage(COLOR_ARWIN, String, 1);
			format(String, sizeof(String), "RESPOND: {FF0000}%s {FFFFFF}has responded to your report", pData[playerid][pAdminname]);
			SendClientMessageEx(Reports[i][ReportFrom], COLOR_ARWIN, String);
		    Reports[i][BeingUsed] = 0;
			Reports[i][ReportFrom] = 999;
			Reports[i][CheckingReport] = 999;
			Reports[i][CheckingReport] = playerid;
			Reports[i][BeingUsed] = 0;
			Reports[i][TimeToExpire] = 0;
			strmid(Reports[i][Report], "None", 0, 4, 4);
		}
	}
	// if(dialogid == DIALOG_ADS)
	// {
	// 	if(response)
	// 	{
	// 		pData[playerid][pListitems] = gListedItems[playerid][listitem];
	// 		new lstr[512];
	// 		format(lstr,sizeof(lstr),""RED_E"Ad: "GREEN_E"%s\n"RED_E"Contact Person: ["GREEN_E"%s"RED_E"] Phone Number: ["GREEN_E"%d"RED_E"]", AdsData[pData[playerid][pListitems]][adsText], pData[AdsData[pData[playerid][pListitems]][adsFrom]][pName], pData[AdsData[pData[playerid][pListitems]][adsFrom]][pPhone]);
	// 		ShowPlayerDialog(playerid, DIALOG_REPLYADS, DIALOG_STYLE_MSGBOX,"Advertisement",lstr,"Reply","Close");
	// 	}
	// }
	// if(dialogid == DIALOG_REPLYADS)
	// {
	// 	if(response)
	// 	{
	// 		new lstr[512];

	// 		format(lstr,sizeof(lstr),"To: %d\nMessage:", pData[AdsData[pData[playerid][pListitems]][adsFrom]][pPhone]);
	// 		ShowPlayerDialog(playerid, DIALOG_REPLYADS1, DIALOG_STYLE_INPUT,"Phone > Messaging > Write",lstr,"Send","Close");
	// 	}
	// }
	// if(dialogid == DIALOG_REPLYADS1)
	// {
	// 	if(response)
	// 	{
	// 		new ph = pData[AdsData[pData[playerid][pListitems]][adsFrom]][pPhone];
	// 		new String[512];
	// 		foreach(new ii : Player)
	// 		{
	// 			if(pData[ii][pPhone] == ph)
	// 			{
	// 				if(ii == INVALID_PLAYER_ID || !IsPlayerConnected(ii)) return Error(playerid, "This number is not actived!");
	// 				if(pData[ii][pPhoneOff] == 1) return Error(playerid, "The specified phone number went offline");

	// 				format(String, sizeof(String), "SMS: {ffffff}You have received one new message from '{ffff00}%d{ffffff}'", pData[playerid][pPhone]);
	// 				SendClientMessageEx(ii, COLOR_RED, String);	
	// 				format(String, sizeof(String), "Message: {ffff00}%s", inputtext);
	// 				SendClientMessageEx(ii, COLOR_RED, String);
	// 				Info(ii, "Gunakan "LB_E"'@<text>' "WHITE_E"untuk membalas SMS!");
	// 				SendClientMessageEx(playerid, COLOR_ARWIN, "SMS: {FFFF00}Message sent");
	// 				SendClientMessageEx(playerid, COLOR_WHITE, "AME: {C2A2DA}types something to his cellphone");
	// 				format(String, sizeof(String), "types something to his cellphone");
	// 				SetPlayerChatBubble(playerid, String, COLOR_PURPLE, 5.0, 5000);
	// 				PlayerPlaySound(ii, 6003, 0,0,0);
	// 				pData[ii][pSMS] = pData[playerid][pPhone];
					
	// 				pData[playerid][pPhoneCredit] -= 1;
	// 				return 1;
	// 			}
	// 		}
	// 	}
	// }
	if(dialogid == DIALOG_BUYPV)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(response)
		{
			if(!IsPlayerInAnyVehicle(playerid))
			{
				TogglePlayerControllable(playerid, 1);
				Error(playerid,"Anda harus berada di dalam kendaraan untuk membelinya.");
				return 1;
			}
			new cost = GetVehicleCost(GetVehicleModel(vehicleid));
			if(pData[playerid][pMoney] < cost)
			{
				Error(playerid, "Uang anda tidak mencukupi.!");
				RemovePlayerFromVehicle(playerid);
				SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
				return 1;
			}
			//if(playerid == INVALID_PLAYER_ID) return Error(playerid, "Invalid player ID!");
			new count = 0, limit = MAX_PLAYER_VEHICLE + pData[playerid][pVip];
			foreach(new ii : PVehicles)
			{
				if(pvData[ii][cOwner] == pData[playerid][pID] && pvData[ii][cClaim] != 1)
					count++;
			}
			if(count >= limit)
			{
				Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
				RemovePlayerFromVehicle(playerid);
				SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
				return 1;
			}
			GivePlayerMoneyEx(playerid, -cost);
			new cQuery[1024];
			new Float:x,Float:y,Float:z, Float:a;
			new model, color1, color2;
			color1 = 0;
			color2 = 0;
			model = GetVehicleModel(GetPlayerVehicleID(playerid));
			x = 1367.3292;
			y = 751.2957;
			z = 10.4451;
			a = 90.0883;
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, cost, x, y, z, a);
			mysql_tquery(g_SQL, cQuery, "OnVehBuyPV", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, cost, x, y, z, a);
			return 1;
		}
		else
		{
			RemovePlayerFromVehicle(playerid);
			SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
			return 1;
		}
	}
	if(dialogid == DIALOG_BUYPVCP)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					//Cars
					new str[1024];
					format(str, sizeof(str), ""WHITE_E"%s\t\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n",
					GetVehicleModelName(400), FormatMoney(GetVehicleCost(400)),
					GetVehicleModelName(412), FormatMoney(GetVehicleCost(412)),
					GetVehicleModelName(419), FormatMoney(GetVehicleCost(419)),
					GetVehicleModelName(426), FormatMoney(GetVehicleCost(426)),
					GetVehicleModelName(436), FormatMoney(GetVehicleCost(436)),
					GetVehicleModelName(466), FormatMoney(GetVehicleCost(466)),
					GetVehicleModelName(467), FormatMoney(GetVehicleCost(467)),
					GetVehicleModelName(474), FormatMoney(GetVehicleCost(474)),
					GetVehicleModelName(475), FormatMoney(GetVehicleCost(475)),
					GetVehicleModelName(480), FormatMoney(GetVehicleCost(480)),
					GetVehicleModelName(603), FormatMoney(GetVehicleCost(603)),
					GetVehicleModelName(421), FormatMoney(GetVehicleCost(421)),
					GetVehicleModelName(602), FormatMoney(GetVehicleCost(602)),
					GetVehicleModelName(492), FormatMoney(GetVehicleCost(492)),
					GetVehicleModelName(545), FormatMoney(GetVehicleCost(545)),
					GetVehicleModelName(489), FormatMoney(GetVehicleCost(489)),
					GetVehicleModelName(405), FormatMoney(GetVehicleCost(405)),
					GetVehicleModelName(445), FormatMoney(GetVehicleCost(445)),
					GetVehicleModelName(579), FormatMoney(GetVehicleCost(579)),
					GetVehicleModelName(507), FormatMoney(GetVehicleCost(507))
					);

					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CARS, DIALOG_STYLE_LIST, "Cars", str, "Buy", "Close");
				}
				case 1:
				{
					//Unique Cars
					new str[1024];
					format(str, sizeof(str), ""WHITE_E"%s\t\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n",
					GetVehicleModelName(483), FormatMoney(GetVehicleCost(483)),
					GetVehicleModelName(534), FormatMoney(GetVehicleCost(534)),
					GetVehicleModelName(535), FormatMoney(GetVehicleCost(535)),
					GetVehicleModelName(536), FormatMoney(GetVehicleCost(536)),
					GetVehicleModelName(558), FormatMoney(GetVehicleCost(558)),
					GetVehicleModelName(559), FormatMoney(GetVehicleCost(559)),
					GetVehicleModelName(560), FormatMoney(GetVehicleCost(560)),
					GetVehicleModelName(561), FormatMoney(GetVehicleCost(561)),
					GetVehicleModelName(562), FormatMoney(GetVehicleCost(562)),
					GetVehicleModelName(565), FormatMoney(GetVehicleCost(565)),
					GetVehicleModelName(567), FormatMoney(GetVehicleCost(567)),
					GetVehicleModelName(575), FormatMoney(GetVehicleCost(575)),
					GetVehicleModelName(576), FormatMoney(GetVehicleCost(576))
					);

					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_UCARS, DIALOG_STYLE_LIST, "Unique Cars", str, "Buy", "Close");
				}
			}
		}
	}
	if(dialogid == DIALOG_BUYPVCP_CARS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new modelid = 400;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 1:
				{
					new modelid = 412;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 2:
				{
					new modelid = 419;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 3:
				{
					new modelid = 426;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 4:
				{
					new modelid = 436;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 5:
				{
					new modelid = 466;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 6:
				{
					new modelid = 467;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 7:
				{
					new modelid = 474;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 8:
				{
					new modelid = 475;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 9:
				{
					new modelid = 480;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 10:
				{
					new modelid = 603;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 11:
				{
					new modelid = 421;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 12:
				{
					new modelid = 602;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 13:
				{
					new modelid = 492;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 14:
				{
					new modelid = 545;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 15:
				{
					new modelid = 489;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 16:
				{
					new modelid = 405;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 17:
				{
					new modelid = 445;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 18:
				{
					new modelid = 579;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 19:
				{
					new modelid = 507;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
			}
		}
	}
	if(dialogid == DIALOG_BUYPVCP_UCARS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new modelid = 483;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 1:
				{
					new modelid = 534;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 2:
				{
					new modelid = 535;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 3:
				{
					new modelid = 536;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 4:
				{
					new modelid = 558;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 5:
				{
					new modelid = 559;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 6:
				{
					new modelid = 560;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 7:
				{
					new modelid = 561;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 8:
				{
					new modelid = 562;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 9:
				{
					new modelid = 565;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 10:
				{
					new modelid = 567;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 11:
				{
					new modelid = 575;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 12:
				{
					new modelid = 576;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
			}
		}
	}
	if(dialogid == DIALOG_RENT_JOBCARS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new modelid = 462;
					new tstr[128];
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$1.50 / 1 hari", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARSCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
				}
				case 1:
				{
					new modelid = 481;
					new tstr[128];
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$1.50 / 1 hari", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARSCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
				}
				case 2:
				{
					new modelid = 509;
					new tstr[128];
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$1.50 / 1 hari", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARSCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
				}
			}
		}
	}
	if(dialogid == DIALOG_RENT_JOBCARSCONFIRM)
	{
		new modelid = pData[playerid][pBuyPvModel];
		if(response)
		{
			if(modelid <= 0) return Error(playerid, "Invalid model id.");
			new cost = GetVehicleCost(modelid);
			if(pData[playerid][pMoney] < 500)
			{
				Error(playerid, "Uang anda tidak mencukupi.!");
				return 1;
			}
			new count = 0, limit = MAX_PLAYER_VEHICLE + pData[playerid][pVip];
			foreach(new ii : PVehicles)
			{
				if(pvData[ii][cOwner] == pData[playerid][pID] && pvData[ii][cClaim] != 1)
					count++;
			}
			if(count >= limit)
			{
				Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
				return 1;
			}
			GivePlayerMoneyEx(playerid, -150);
			new cQuery[1024];
			new Float:x,Float:y,Float:z, Float:a;
			new model, color1, color2, rental;
			color1 = 0;
			color2 = 0;
			model = modelid;
			x = 1367.3292;
			y = 751.2957;
			z = 10.4451;
			a = 90.0883;
			rental = gettime() + (1 * 86400);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`, `rental`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f', '%d')", pData[playerid][pID], model, color1, color2, cost, x, y, z, a, rental);
			mysql_tquery(g_SQL, cQuery, "OnVehRentPV", "ddddddffffd", playerid, pData[playerid][pID], model, color1, color2, cost, x, y, z, a, rental);
			return 1;
		}
		else
		{
			pData[playerid][pBuyPvModel] = 0;
		}
	}
	if(dialogid == DIALOG_RENT_JOBCARS2)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new modelid = 462;
					new tstr[128];
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$1.50 / 1 hari", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARSCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
				}
				case 1:
				{
					new modelid = 481;
					new tstr[128];
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$1.50 / 1 hari", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARSCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
				}
				case 2:
				{
					new modelid = 509;
					new tstr[128];
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$1.50 / 1 hari", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARSCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
				}
			}
		}
	}
	if(dialogid == DIALOG_RENT_JOBCARSCONFIRM2)
	{
		new modelid = pData[playerid][pBuyPvModel];
		if(response)
		{
			if(modelid <= 0) return Error(playerid, "Invalid model id.");
			new cost = GetVehicleCost(modelid);
			if(pData[playerid][pMoney] < 2000)
			{
				Error(playerid, "Uang anda tidak mencukupi.!");
				return 1;
			}
			new count = 0, limit = MAX_PLAYER_VEHICLE + pData[playerid][pVip];
			foreach(new ii : PVehicles)
			{
				if(pvData[ii][cOwner] == pData[playerid][pID] && pvData[ii][cClaim] != 1)
					count++;
			}
			if(count >= limit)
			{
				Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
				return 1;
			}
			GivePlayerMoneyEx(playerid, -2000);
			new cQuery[1024];
			new Float:x,Float:y,Float:z, Float:a;
			new model, color1, color2, rental;
			color1 = 2;
			color2 = 1;
			model = modelid;
			x = 1729.7035;
			y = -1858.3126;
			z = 13.4141;
			a = 273.2739;
			rental = gettime() + (1 * 86400);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`, `rental`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f', '%d')", pData[playerid][pID], model, color1, color2, cost, x, y, z, a, rental);
			mysql_tquery(g_SQL, cQuery, "OnVehRentPV", "ddddddffffd", playerid, pData[playerid][pID], model, color1, color2, cost, x, y, z, a, rental);
			return 1;
		}
		else
		{
			pData[playerid][pBuyPvModel] = 0;
		}
	}
    if(dialogid == DIALOG_RENT_NEWPLAYER)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new modelid = 462;
					new tstr[128];
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$1.50 / 1 hari", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENT_NEWPLAYERCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
				}
				case 1:
				{
					new modelid = 481;
					new tstr[128];
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$1.50 / 1 hari", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARSCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
				}
				case 2:
				{
					new modelid = 509;
					new tstr[128];
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$1.50 / 1 hari", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARSCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
				}
			}
		}
	}
	if(dialogid == DIALOG_RENT_NEWPLAYERCONFIRM)
	{
		new modelid = pData[playerid][pBuyPvModel];
		if(response)
		{
			if(modelid <= 0) return Error(playerid, "Invalid model id.");
			new cost = GetVehicleCost(modelid);
			if(pData[playerid][pMoney] < 500)
			{
				Error(playerid, "Uang anda tidak mencukupi.!");
				return 1;
			}
			new count = 0, limit = MAX_PLAYER_VEHICLE + pData[playerid][pVip];
			foreach(new ii : PVehicles)
			{
				if(pvData[ii][cOwner] == pData[playerid][pID] && pvData[ii][cClaim] != 1)
					count++;
			}
			if(count >= limit)
			{
				Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
				return 1;
			}
			GivePlayerMoneyEx(playerid, -150);
			new cQuery[1024];
			new Float:x,Float:y,Float:z, Float:a;
			new model, color1, color2, rental;
			color1 = 0;
			color2 = 0;
			model = modelid;
			x = 1367.3292;
			y = 751.2957;
			z = 10.4451;
			a = 90.0883;
			rental = gettime() + (1 * 86400);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`, `rental`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f', '%d')", pData[playerid][pID], model, color1, color2, cost, x, y, z, a, rental);
			mysql_tquery(g_SQL, cQuery, "OnVehRentPV", "ddddddffffd", playerid, pData[playerid][pID], model, color1, color2, cost, x, y, z, a, rental);
			return 1;
		}
		else
		{
			pData[playerid][pBuyPvModel] = 0;
		}
	}
	if(dialogid == DIALOG_RENT_NEWPLAYER2)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new modelid = 462;
					new tstr[128];
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$20.00 / 1 hari", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENT_NEWPLAYERCONFIRM2, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
				}
				case 1:
				{
					new modelid = 481;
					new tstr[128];
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$20.00 / 1 hari", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENT_NEWPLAYERCONFIRM2, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
				}
				case 2:
				{
					new modelid = 509;
					new tstr[128];
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$20.00 / 1 hari", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENT_NEWPLAYERCONFIRM2, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
				}
			}
		}
	}
	if(dialogid == DIALOG_RENT_NEWPLAYERCONFIRM2)
	{
		new modelid = pData[playerid][pBuyPvModel];
		if(response)
		{
			if(modelid <= 0) return Error(playerid, "Invalid model id.");
			new cost = GetVehicleCost(modelid);
			if(pData[playerid][pMoney] < 2000)
			{
				Error(playerid, "Uang anda tidak mencukupi.!");
				return 1;
			}
			new count = 0, limit = MAX_PLAYER_VEHICLE + pData[playerid][pVip];
			foreach(new ii : PVehicles)
			{
				if(pvData[ii][cOwner] == pData[playerid][pID] && pvData[ii][cClaim] != 1)
					count++;
			}
			if(count >= limit)
			{
				Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
				return 1;
			}
			GivePlayerMoneyEx(playerid, -2000);
			new cQuery[1024];
			new Float:x,Float:y,Float:z, Float:a;
			new model, color1, color2, rental;
			color1 = 2;
			color2 = 1;
			model = modelid;
			x = 1727.0498;
			y = -1857.8225;
			z = 13.4141;
			a = 270.9773;
			rental = gettime() + (1 * 86400);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`, `rental`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f', '%d')", pData[playerid][pID], model, color1, color2, cost, x, y, z, a, rental);
			mysql_tquery(g_SQL, cQuery, "OnVehRentPV", "ddddddffffd", playerid, pData[playerid][pID], model, color1, color2, cost, x, y, z, a, rental);
			return 1;
		}
		else
		{
			pData[playerid][pBuyPvModel] = 0;
		}
	}
	if(dialogid == DIALOG_BUYPVCP_CONFIRM)
	{
		new modelid = pData[playerid][pBuyPvModel];
		if(response)
		{
			if(modelid <= 0) return Error(playerid, "Invalid model id.");
			new cost = GetVehicleCost(modelid);
			
			if(pData[playerid][pMoney] < cost)
			{
				Error(playerid, "Uang anda tidak mencukupi.!");
				return 1;
			}
			new count = 0, limit = MAX_PLAYER_VEHICLE + pData[playerid][pVip];
			foreach(new ii : PVehicles)
			{
				if(pvData[ii][cOwner] == pData[playerid][pID] && pvData[ii][cClaim] != 1)
					count++;
			}
			if(count >= limit)
			{
				Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
				return 1;
			}
			Server_Save();
			GivePlayerMoneyEx(playerid, -cost);
			new cQuery[1024];
			new Float:x,Float:y,Float:z, Float:a;
			new model, color1, color2;
			color1 = 0;
			color2 = 0;
			model = modelid;
			x = 2120.0930;
			y = -1150.1932;
			z = 23.7561;
			a = 345.6978;
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, cost, x, y, z, a);
			mysql_tquery(g_SQL, cQuery, "OnVehBuyPV", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, cost, x, y, z, a);
			return 1;
		}
		else
		{
			pData[playerid][pBuyPvModel] = 0;
		}
	}
	if(dialogid == 11111)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
				    if(DialogHauling[0] == false)
				    {
					    DialogHauling[0] = true;
					    DialogPenting[playerid][0] = true;
						SendClientMessage(playerid, GREY,"TRUCKING: {FFFFFF}Go to marked checkpoint on your map");
						SetPlayerRaceCheckpoint(playerid, 1, 2791.4016, -2494.5452, 14.2522, 2791.4016, -2494.5452, 14.2522, 10.0);
						TrailerHauling[playerid] = CreateVehicle(435, 2791.4016, -2494.5452, 14.2522, 89.5366, 1, 1, -1);
						SedangHauling[playerid] = 1;
					}
					else
					    Error(playerid, "Trucking Missions already taken by Someone");
				}
				case 1:
				{
				    if(DialogHauling[1] == false)
				    {
					    DialogHauling[1] = true;
					    DialogPenting[playerid][1] = true;
						SendClientMessage(playerid, GREY,"TRUCKING: {FFFFFF}Go to marked checkpoint on your map");
						SetPlayerRaceCheckpoint(playerid, 1, 2786.9629, -2456.2334, 14.6518, 0.0, 0.0, 0.0, 10.0);
						TrailerHauling[playerid] = CreateVehicle(450, 2786.9629, -2456.2334, 14.6518, 90.3246, 1, 1, -1);
						SedangHauling[playerid] = 3;
					}
					else
					    Error(playerid, "Trucking Missions already taken by Someone");
				}
				case 2:
				{
				    if(DialogHauling[2] == false)
				    {
					    DialogHauling[2] = true;
					    DialogPenting[playerid][3] = true;
						SendClientMessage(playerid, GREY,"TRUCKING: {FFFFFF}Go to marked checkpoint on your map");
						SetPlayerRaceCheckpoint(playerid, 1,-1963.0142, -2436.3079, 31.2311, -1963.0142, -2436.3079, 31.2311, 10.0);
						TrailerHauling[playerid] = CreateVehicle(450, -1963.0142, -2436.3079, 31.2311, 226.1548, 1, 1, -1);
						SedangHauling[playerid] = 5;
					}
					else
					    Error(playerid, "Trucking Missions already taken by Someone");
				}
				case 3:
				{
				    if(DialogHauling[3] == false)
				    {
					    DialogHauling[3] = true;
					    DialogPenting[playerid][4] = true;
						SendClientMessage(playerid, GREY,"TRUCKING: {FFFFFF}Go to marked checkpoint on your map");
						SetPlayerRaceCheckpoint(playerid, 1,-1963.0142, -2436.3079, 31.2311, -1963.0142, -2436.3079, 31.2311, 10.0);
						TrailerHauling[playerid] = CreateVehicle(450, -1963.0142, -2436.3079, 31.2311, 226.1548, 1, 1, -1);
						SedangHauling[playerid] = 7;
					}
					else
					    Error(playerid, "Trucking Missions already taken by Someone");
				}
				case 4:
				{
				    if(DialogHauling[4] == false)
				    {
					    DialogHauling[4] = true;
					    DialogPenting[playerid][5] = true;
						SendClientMessage(playerid, GREY,"TRUCKING: {FFFFFF}Go to marked checkpoint on your map");
						SetPlayerRaceCheckpoint(playerid, 1,-1963.0142, -2436.3079, 31.2311, -1963.0142, -2436.3079, 31.2311, 10.0);
						TrailerHauling[playerid] = CreateVehicle(450, -1963.0142, -2436.3079, 31.2311, 226.1548, 1, 1, -1);
						SedangHauling[playerid] = 9;
					}
					else
					    Error(playerid, "Trucking Missions already taken by Someone");
				}
				case 5:
				{
				    if(DialogHauling[5] == false)
				    {
					    DialogHauling[5] = true;
					    DialogPenting[playerid][6] = true;
						SendClientMessage(playerid, GREY,"TRUCKING: {FFFFFF}Go to marked checkpoint on your map");
						SetPlayerRaceCheckpoint(playerid, 1, 2786.9629, -2456.2334, 14.6518, 0.0, 0.0, 0.0, 10.0);
						TrailerHauling[playerid] = CreateVehicle(450, 2786.9629, -2456.2334, 14.6518, 90.3246, 1, 1, -1);
						SedangHauling[playerid] = 11;
					}
					else
					    Error(playerid, "Trucking Missions already taken by Someone");
				}
			}
		}
	}
	if(dialogid == DIALOG_PAYCHECK)
	{
		if(response)
		{
			if(pData[playerid][pPaycheck] < 0) return Error(playerid, "Sekarang belum waktunya anda mengambil paycheck.");
			
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
				SendClientMessageEx(playerid, COLOR_ARWIN, "{00FFFF}<====================< "WHITE_E"Paycheck {00FFFF}>====================>");
				SendClientMessageEx(playerid, COLOR_ARWIN, "{00FFFF}=> "WHITE_E"Previous Balance: "GREEN_E"$%s", FormatMoney(oldbalance));
				SendClientMessageEx(playerid, COLOR_ARWIN, "{00FFFF}=> "WHITE_E"Income Tax: "RED_E"$%s", FormatMoney(pajak));
				SendClientMessageEx(playerid, COLOR_ARWIN, "{00FFFF}=> "WHITE_E"New Balance: "GREEN_E"$%s", FormatMoney(pData[playerid][pBankMoney]));
				SendClientMessageEx(playerid, COLOR_ARWIN, "{00FFFF}<======================================================================>");
				Server_MinMoney(hasil);
				pData[playerid][pPaycheck] = 0;
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
				SendClientMessageEx(playerid, COLOR_ARWIN, "{00FFFF}<====================< "WHITE_E"Paycheck {00FFFF}>====================>");
				SendClientMessageEx(playerid, COLOR_ARWIN, "{00FFFF}=> "WHITE_E"Previous Balance: "GREEN_E"$%s", FormatMoney(oldbalance));
				SendClientMessageEx(playerid, COLOR_ARWIN, "{00FFFF}=> "WHITE_E"Income Tax: "RED_E"$%s", FormatMoney(pajak));
				SendClientMessageEx(playerid, COLOR_ARWIN, "{00FFFF}=> "WHITE_E"New Balance: "GREEN_E"$%s", FormatMoney(pData[playerid][pBankMoney]));
				SendClientMessageEx(playerid, COLOR_ARWIN, "{00FFFF}<======================================================================>");
				Server_MinMoney(hasil);
				pData[playerid][pPaycheck] = 0;
				pData[playerid][pOnDutyTime] = 0;
				pData[playerid][pTaxiTime] = 0;
			}
		}
	}
	if(dialogid == DIALOG_FORKLIFT)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(response)
		{
			if(pData[playerid][pSideJobsForklift] > 0)
			{
				Error(playerid, "Anda harus menunggu "GREY2_E"%d "WHITE_E"detik lagi.", pData[playerid][pSideJobsForklift]);
				RemovePlayerFromVehicle(playerid);
				SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
				return 1;
			}
			pData[playerid][pSideJob] = 401;
			SetPlayerCheckpoint(playerid, Forkliftpoint1, 3.0);
			InfoTD_MSG(playerid, 3000, "Follow the checkpoint!");
		}
		else
		{
			RemovePlayerFromVehicle(playerid);
			SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
		}
	}
	if(dialogid == HAULING)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0://Ocean Dock 1
				{
				    if(DialogHauling[0] == false) // Kalau False atau tidak dipilih
				    {
					    DialogHauling[0] = true; // Dialog 0 telah di pilih
					    DialogSaya[playerid][0] = true;
						SendClientMessage(playerid, COLOR_ARWIN,"TRUCKING: {FFFFFF}Go to marked checkpoint on your map");
						SetPlayerRaceCheckpoint(playerid, 1, 2791.4016, -2494.5452, 14.2522, 2791.4016, -2494.5452, 14.2522, 10.0);
						TrailerHauling[playerid] = CreateVehicle(435, 2791.4016, -2494.5452, 14.2522, 89.5366, 1, 1, -1);
						SedangHauling[playerid] = 1;
					}
					else
					    SendClientMessage(playerid,-1,"ERROR: Trucking Missions already taken by Someone");
				}
				case 1://Ocean Dock 2
				{
				    if(DialogHauling[1] == false) // Kalau False atau tidak dipilih
				    {
					    DialogHauling[1] = true; // Dialog 1 telah di pilih
					    DialogSaya[playerid][1] = true;
						SendClientMessage(playerid, COLOR_ARWIN,"TRUCKING: {FFFFFF}Go to marked checkpoint on your map");
						SetPlayerRaceCheckpoint(playerid, 1, 2784.3132, -2456.6299, 14.2415, 2784.3132, -2456.6299, 14.2415, 10.0);
						TrailerHauling[playerid] = CreateVehicle(591, 2784.3132, -2456.6299, 14.2415, 89.4938, 1, 1, -1);
						SedangHauling[playerid] = 3;
					}
					else
					    SendClientMessage(playerid,-1,"ERROR: Trucking Missions already taken by Someone");
				}
				case 2://Angel Pine 1
				{
				    if(DialogHauling[2] == false) // Kalau False atau tidak dipilih
				    {
					    DialogHauling[2] = true; // Dialog 2 telah di pilih
					    DialogSaya[playerid][3] = true;
						SendClientMessage(playerid, COLOR_ARWIN,"TRUCKING: {FFFFFF}Go to marked checkpoint on your map");
						SetPlayerRaceCheckpoint(playerid, 1,-1963.0142, -2436.3079, 31.2311, -1963.0142, -2436.3079, 31.2311, 10.0);
						TrailerHauling[playerid] = CreateVehicle(450, -1963.0142, -2436.3079, 31.2311, 226.1548, 1, 1, -1);
						SedangHauling[playerid] = 5;
					}
					else
					    SendClientMessage(playerid,-1,"ERROR: Trucking Missions already taken by Someone");
				}
				case 3://Angel Pine 2
				{
				    if(DialogHauling[3] == false) // Kalau False atau tidak dipilih
				    {
					    DialogHauling[3] = true; // Dialog 0 telah di pilih
					    DialogSaya[playerid][3] = true;
						SendClientMessage(playerid, COLOR_ARWIN,"TRUCKING: {FFFFFF}Go to marked checkpoint on your map");
						SetPlayerRaceCheckpoint(playerid, 1, -1966.5603, -2439.9380, 31.2306, -1966.5603, -2439.9380, 31.2306, 10.0);
						TrailerHauling[playerid] = CreateVehicle(450, -1966.5603, -2439.9380, 31.2306, 225.5799, 1, 1, -1);
						SedangHauling[playerid] = 7;
					}
					else
					    SendClientMessage(playerid,-1,"ERROR: Trucking Missions already taken by Someone");
				}
				case 4://Dekat Jembatan Montgomery 1
				{
				    if(DialogHauling[4] == false) // Kalau False atau tidak dipilih
				    {
					    DialogHauling[4] = true; // Dialog 1 telah di pilih
					    DialogSaya[playerid][4] = true;
						SendClientMessage(playerid, COLOR_ARWIN,"TRUCKING: {FFFFFF}Go to marked checkpoint on your map");
						SetPlayerRaceCheckpoint(playerid, 1, -1863.1541, -1720.5603, 22.3558, -1863.1541, -1720.5603, 22.3558, 10.0);
						TrailerHauling[playerid] = CreateVehicle(450, -1863.1541, -1720.5603, 22.3558, 122.1463, 1, 1, -1);
						SedangHauling[playerid] = 9;
					}
					else
					    SendClientMessage(playerid,-1,"ERROR: Trucking Missions already taken by Someone");
				}
				case 5://Dekat Jembatan Montgomery 2
				{
				    if(DialogHauling[5] == false) // Kalau False atau tidak dipilih
				    {
					    DialogHauling[5] = true; // Dialog 2 telah di pilih
					    DialogSaya[playerid][5] = true;
						SendClientMessage(playerid, COLOR_ARWIN,"TRUCKING: {FFFFFF}Go to marked checkpoint on your map");
						SetPlayerRaceCheckpoint(playerid, 1, -1855.7255, -1726.0389, 22.3566, -1855.7255, -1726.0389, 22.3566, 10.0);
						TrailerHauling[playerid] = CreateVehicle(450, -1855.7255, -1726.0389, 22.3566, 124.4187, 1, 1, -1);
						SedangHauling[playerid] = 11;
					}
					else
					    SendClientMessage(playerid,-1,"ERROR: Trucking Missions already taken by Someone");
				}
				case 6://Pabrik Easter Egg
				{
				    if(DialogHauling[6] == false) // Kalau False atau tidak dipilih
				    {
					    DialogHauling[6] = true; // Dialog 0 telah di pilih
					    DialogSaya[playerid][6] = true;
						SendClientMessage(playerid, COLOR_ARWIN,"TRUCKING: {FFFFFF}Go to marked checkpoint on your map");
						SetPlayerRaceCheckpoint(playerid, 1, -1053.6145, -658.6473, 32.6319, -1053.6145, -658.6473, 32.6319, 10.0);
						TrailerHauling[playerid] = CreateVehicle(584, -1053.6145, -658.6473, 32.6319, 260.6392, 1, 1, -1);
						SedangHauling[playerid] = 13;
					}
					else
					    SendClientMessage(playerid,-1,"ERROR: Trucking Missions already taken by Someone");
				}
				case 7://Blueberry Atas
				{
				    if(DialogHauling[7] == false) // Kalau False atau tidak dipilih
				    {
					    DialogHauling[7] = true; // Dialog 1 telah di pilih
					    DialogSaya[playerid][7] = true;
						SendClientMessage(playerid, COLOR_ARWIN,"TRUCKING: {FFFFFF}Go to marked checkpoint on your map");
						SetPlayerRaceCheckpoint(playerid, 1, -459.3511, -48.3457, 60.5507, -459.3511, -48.3457, 60.5507, 10.0);
						TrailerHauling[playerid] = CreateVehicle(450, -459.3511, -48.3457, 60.5507, 182.7280, 1, 1, -1);
						SedangHauling[playerid] = 15;
					}
					else
					    SendClientMessage(playerid,-1,"ERROR: Trucking Missions already taken by Someone");
				}
				case 8://LV Tanah
				{
				    if(DialogHauling[8] == false) // Kalau False atau tidak dipilih
				    {
					    DialogHauling[8] = true; // Dialog 2 telah di pilih
					    DialogSaya[playerid][8] = true;
						SendClientMessage(playerid, COLOR_ARWIN,"TRUCKING: {FFFFFF}Go to marked checkpoint on your map");
						SetPlayerRaceCheckpoint(playerid, 1, 847.0450, 921.0422, 13.9579, 847.0450, 921.0422, 13.9579, 10.0);
						TrailerHauling[playerid] = CreateVehicle(450, 847.0450, 921.0422, 13.9579, 201.2555, 1, 1, -1);
						SedangHauling[playerid] = 17;
					}
					else
					    SendClientMessage(playerid,-1,"ERROR: Trucking Missions already taken by Someone");
				}
				case 9://LV Pabrik
				{
				    if(DialogHauling[9] == false) // Kalau False atau tidak dipilih
				    {
					    DialogHauling[9] = true; // Dialog 2 telah di pilih
					    DialogSaya[playerid][9] = true;
						SendClientMessage(playerid, COLOR_ARWIN,"TRUCKING: {FFFFFF}Go to marked checkpoint on your map");
						SetPlayerRaceCheckpoint(playerid, 1, 249.6713, 1395.7150, 11.1923, 249.6713, 1395.7150, 11.1923, 10.0);
						TrailerHauling[playerid] = CreateVehicle(584, 249.6713, 1395.7150, 11.1923, 269.0699, 1, 1, -1);
						SedangHauling[playerid] = 19;
					}
					else
					    SendClientMessage(playerid,-1,"ERROR: Trucking Missions already taken by Someone");
				}
			}
		}
	}
	if(dialogid == BUSJOB)
	{
		if(response)
		{
		    switch(listitem)
			{
			    case 0:
			    {
				 	if(pData[playerid][pSideJobTimeBus] == 0)
				 	{
				 	    if(DialogBus[0] == false) // Kalau False atau tidak dipilih
			    		{
					    	DialogBus[0] = true; // Dialog 0 telah di pilih
					    	DialogSaya[playerid][10] = true;
		                	BusSteps[playerid][0] = 2;
					     	KerjaBus[playerid] = 1;
					     	SetPlayerRaceCheckpoint(playerid, 0, 1673.9481,-1477.2500,13.4674,1655.0614,-1509.0916,13.4789, 5.0);
							SendClientMessage(playerid, COLOR_ARWIN, "SIDEJOBINFO: {FFFFFF}Ikutilah checkpoint yang tersedia pada Radar");
						}
						else{
						    SendClientMessage(playerid,-1,"ERROR: Route already taken by Someone");
						    return 1;
						}
					}
				}
				case 1:
			    {
				 	if(pData[playerid][pSideJobTimeBus] == 0)
				 	{
				 	    if(DialogBus[1] == false) // Kalau False atau tidak dipilih
			    		{
					    	DialogBus[1] = true; // Dialog 1 telah di pilih
					    	DialogSaya[playerid][11] = true;
		                	BusSteps[playerid][1] = 2;
					     	KerjaBus[playerid] = 1;
					     	SetPlayerRaceCheckpoint(playerid, 0, 1678.8490,-1477.8701,13.4881,1655.7677,-1517.0698,13.4846, 5);
					     	SendClientMessage(playerid, COLOR_ARWIN, "SIDEJOBINFO: {FFFFFF}Ikutilah checkpoint yang tersedia pada Radar");
						}
						else
						    SendClientMessage(playerid,-1,"ERROR: Route already taken by Someone");
					}
				}
                case 2:
			    {
				 	if(pData[playerid][pSideJobTimeBus] == 0)
				 	{
				 	    if(DialogBus[2] == false) // Kalau False atau tidak dipilih
			    		{
					    	DialogBus[2] = true; // Dialog 1 telah di pilih
					    	DialogSaya[playerid][12] = true;
		                	BusSteps[playerid][2] = 2;
					     	KerjaBus[playerid] = 1;
					     	SetPlayerRaceCheckpoint(playerid, 0, 1675.9579,-1477.6978,13.4807,1655.6171,-1553.4003,13.4852, 5);
					     	SendClientMessage(playerid, COLOR_ARWIN, "SIDEJOBINFO: {FFFFFF}Ikutilah checkpoint yang tersedia pada Radar");
						}
						else
						    SendClientMessage(playerid,-1,"ERROR: Route already taken by Someone");
					}
				}
			}
		}
		else RemovePlayerFromVehicle(playerid);
	}
	if(dialogid == BUSJOBCD)
	{
		if(response)
		{
		    switch(listitem)
			{
			    case 0:
			    {
				 	if(pData[playerid][pSideJobTimeBus] == 0)
				 	{
				 	    if(DialogBusCD[0] == false) // Kalau False atau tidak dipilih
			    		{
					    	DialogBusCD[0] = true; // Dialog 0 telah di pilih
		                	BusCDSteps[playerid][0] = 2;
					     	KerjaBus[playerid] = 1;
					     	SetPlayerRaceCheckpoint(playerid, 0, 1789.7118, -1911.4409, 13.4901, 1824.4303, -1868.5961, 13.4755, 5.0);
							SendClientMessage(playerid, COLOR_ARWIN, "SIDEJOBINFO: {FFFFFF}Ikutilah checkpoint yang tersedia pada Radar");
						}
						else{
						    SendClientMessage(playerid,-1,"ERROR: Route already taken by Someone");
						    return 1;
						}
					}
				}
				case 1:
			    {
				 	if(pData[playerid][pSideJobTimeBus] == 0)
				 	{
				 	    if(DialogBusCD[1] == false) // Kalau False atau tidak dipilih
			    		{
					    	DialogBusCD[1] = true; // Dialog 1 telah di pilih
		                	BusCDSteps[playerid][1] = 2;
					     	KerjaBus[playerid] = 1;
					     	SetPlayerRaceCheckpoint(playerid, 0, 1789.5856, -1910.6434, 13.4955, 1819.2391, -1910.0963, 13.4926, 5);
					     	SendClientMessage(playerid, COLOR_ARWIN, "SIDEJOBINFO: {FFFFFF}Ikutilah checkpoint yang tersedia pada Radar");
						}
						else
						    SendClientMessage(playerid,-1,"ERROR: Route already taken by Someone");
					}
				}
			}
		}
		else RemovePlayerFromVehicle(playerid);
	}
    if(dialogid == SWEEPERJOB)
	{
		if(response)
		{
		    switch(listitem)
			{
			    case 0:
			    {
				 	if(pData[playerid][pSideJobTimeSweap] == 0)
				 	{
				 	    if(DialogSweeper[0] == false) // Kalau False atau tidak dipilih
			    		{
					    	DialogSweeper[0] = true; // Dialog 0 telah di pilih
					    	DialogSaya[playerid][13] = true;
		                	SweeperSteps[playerid][0] = 2;
					     	KerjaSweeper[playerid] = 1;
					     	SetPlayerRaceCheckpoint(playerid, 0, 1631.1259,-1875.8676,13.1079,1679.4075,-1867.3059,13.1157, 5.0);
					     	SendClientMessage(playerid, COLOR_ARWIN, "SIDEJOBINFO: {FFFFFF}Ikutilah checkpoint yang tersedia pada Radar");
						}
						else
						    SendClientMessage(playerid,-1,"ERROR: Route already taken by Someone");
					}
				}
				case 1:
			    {
				 	if(pData[playerid][pSideJobTimeSweap] == 0)
				 	{
				 	    if(DialogSweeper[1] == false) // Kalau False atau tidak dipilih
			    		{
					    	DialogSweeper[1] = true; // Dialog 1 telah di pilih
					    	DialogSaya[playerid][14] = true;
		                	SweeperSteps[playerid][1] = 2;
					     	KerjaSweeper[playerid] = 1;
					     	SetPlayerRaceCheckpoint(playerid, 0, 1613.3342,-1876.3984,13.1080,1543.2211,-1870.5433,13.1079, 5);
					     	SendClientMessage(playerid, COLOR_ARWIN, "SIDEJOBINFO: {FFFFFF}Ikutilah checkpoint yang tersedia pada Radar");
						}
						else
						    SendClientMessage(playerid,-1,"ERROR: Route already taken by Someone");
					}
				}
                case 2:
			    {
				 	if(pData[playerid][pSideJobTimeSweap] == 0)
				 	{
				 	    if(DialogSweeper[2] == false) // Kalau False atau tidak dipilih
			    		{
					    	DialogSweeper[2] = true; // Dialog 1 telah di pilih
					    	DialogSaya[playerid][15] = true;
		                	SweeperSteps[playerid][2] = 2;
					     	KerjaSweeper[playerid] = 1;
					     	SetPlayerRaceCheckpoint(playerid, 0, 1631.8092,-1875.8730,13.4909,1691.4486,-1833.3379,13.4829, 5);
					     	SendClientMessage(playerid, COLOR_ARWIN, "SIDEJOBINFO: {FFFFFF}Ikutilah checkpoint yang tersedia pada Radar");
						}
						else
						    SendClientMessage(playerid,-1,"ERROR: Route already taken by Someone");
					}
				}
			}
		}
		else RemovePlayerFromVehicle(playerid);
	}
	if(dialogid == DIALOG_BUYPVLS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					//Bikes
					new str[1024];
					format(str, sizeof(str), ""WHITE_E"%s\t\t"LG_E"$%s\n%s\t\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n",
					GetVehicleModelName(481), FormatMoney(GetVehicleCost(481)),
					GetVehicleModelName(509), FormatMoney(GetVehicleCost(509)),
					GetVehicleModelName(510), FormatMoney(GetVehicleCost(510)),
					GetVehicleModelName(462), FormatMoney(GetVehicleCost(462)),
					GetVehicleModelName(586), FormatMoney(GetVehicleCost(586)),
					GetVehicleModelName(581), FormatMoney(GetVehicleCost(581)),
					GetVehicleModelName(461), FormatMoney(GetVehicleCost(461)),
					GetVehicleModelName(521), FormatMoney(GetVehicleCost(521)),
					GetVehicleModelName(463), FormatMoney(GetVehicleCost(463)),
					GetVehicleModelName(468), FormatMoney(GetVehicleCost(468))
					);

					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_BIKES, DIALOG_STYLE_LIST, "Bikes", str, "Buy", "Close");
				}
				case 1:
				{
					//Cars
					new str[1024];
					format(str, sizeof(str), ""WHITE_E"%s\t\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n",
					GetVehicleModelName(400), FormatMoney(GetVehicleCost(400)),
					GetVehicleModelName(412), FormatMoney(GetVehicleCost(412)),
					GetVehicleModelName(419), FormatMoney(GetVehicleCost(419)),
					GetVehicleModelName(426), FormatMoney(GetVehicleCost(426)),
					GetVehicleModelName(436), FormatMoney(GetVehicleCost(436)),
					GetVehicleModelName(466), FormatMoney(GetVehicleCost(466)),
					GetVehicleModelName(467), FormatMoney(GetVehicleCost(467)),
					GetVehicleModelName(474), FormatMoney(GetVehicleCost(474)),
					GetVehicleModelName(475), FormatMoney(GetVehicleCost(475)),
					GetVehicleModelName(480), FormatMoney(GetVehicleCost(480)),
					GetVehicleModelName(603), FormatMoney(GetVehicleCost(603)),
					GetVehicleModelName(421), FormatMoney(GetVehicleCost(421)),
					GetVehicleModelName(602), FormatMoney(GetVehicleCost(602)),
					GetVehicleModelName(492), FormatMoney(GetVehicleCost(492)),
					GetVehicleModelName(545), FormatMoney(GetVehicleCost(545)),
					GetVehicleModelName(489), FormatMoney(GetVehicleCost(489)),
					GetVehicleModelName(405), FormatMoney(GetVehicleCost(405)),
					GetVehicleModelName(445), FormatMoney(GetVehicleCost(445)),
					GetVehicleModelName(579), FormatMoney(GetVehicleCost(579)),
					GetVehicleModelName(507), FormatMoney(GetVehicleCost(507))
					);

					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CARS, DIALOG_STYLE_LIST, "Cars", str, "Buy", "Close");
				}
				case 2:
				{
					//Job Cars
					new str[1024];
					format(str, sizeof(str), "%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s\n%s\t"LG_E"$%s",
					GetVehicleModelName(422), FormatMoney(GetVehicleCost(422)),
					GetVehicleModelName(478), FormatMoney(GetVehicleCost(478)),
					GetVehicleModelName(482), FormatMoney(GetVehicleCost(482)),
					GetVehicleModelName(423), FormatMoney(GetVehicleCost(423)),
					GetVehicleModelName(588), FormatMoney(GetVehicleCost(588)),
					GetVehicleModelName(543), FormatMoney(GetVehicleCost(543)),
					GetVehicleModelName(554), FormatMoney(GetVehicleCost(554))
					);

					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_JOBCARS, DIALOG_STYLE_LIST, "Job Cars", str, "Buy", "Close");
				}
			}
		}
	}
	if(dialogid == DIALOG_BUYPVLS_BIKES)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new modelid = 481;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 1:
				{
					new modelid = 509;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 2:
				{
					new modelid = 510;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 3:
				{
					new modelid = 462;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 4:
				{
					new modelid = 586;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 5:
				{
					new modelid = 581;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 6:
				{
					new modelid = 461;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 7:
				{
					new modelid = 521;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 8:
				{
					new modelid = 463;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 9:
				{
					new modelid = 468;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
			}
		}
	}
	if(dialogid == DIALOG_BUYPVLS_CARS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new modelid = 400;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 1:
				{
					new modelid = 412;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 2:
				{
					new modelid = 419;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 3:
				{
					new modelid = 426;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 4:
				{
					new modelid = 436;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 5:
				{
					new modelid = 466;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 6:
				{
					new modelid = 467;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 7:
				{
					new modelid = 474;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 8:
				{
					new modelid = 475;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 9:
				{
					new modelid = 480;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 10:
				{
					new modelid = 603;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 11:
				{
					new modelid = 421;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 12:
				{
					new modelid = 602;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 13:
				{
					new modelid = 492;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 14:
				{
					new modelid = 545;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 15:
				{
					new modelid = 489;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 16:
				{
					new modelid = 405;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 17:
				{
					new modelid = 445;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 18:
				{
					new modelid = 579;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 19:
				{
					new modelid = 507;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
			}
		}
	}
	if(dialogid == DIALOG_BUYPVLS_JOBCARS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new modelid = 422;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 1:
				{
					new modelid = 478;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 2:
				{
					new modelid = 482;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 3:
				{
					new modelid = 423;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 4:
				{
					new modelid = 588;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 5:
				{
					new modelid = 543;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 6:
				{
					new modelid = 554;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVLS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
			}
		}
	}
	if(dialogid == DIALOG_BUYVEHVIP)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new String[1024], S3MP4K[1024];
					strcat(S3MP4K, "Model\tCost\n");
					format(String, sizeof(String),"%s\t$%s\n", GetVehicleModelName(522), FormatMoney(GetVehicleCostVIP(522)));
					strcat(S3MP4K, String);
					format(String, sizeof(String),"%s\t$%s\n", GetVehicleModelName(411), FormatMoney(GetVehicleCostVIP(411)));
					strcat(S3MP4K, String);
					format(String, sizeof(String),"%s\t$%s\n", GetVehicleModelName(451), FormatMoney(GetVehicleCostVIP(451)));
					strcat(S3MP4K, String);
					format(String, sizeof(String),"%s\t$%s\n", GetVehicleModelName(494), FormatMoney(GetVehicleCostVIP(494)));
					strcat(S3MP4K, String);
					format(String, sizeof(String),"%s\t$%s\n", GetVehicleModelName(541), FormatMoney(GetVehicleCostVIP(541)));
					strcat(S3MP4K, String);
					format(String, sizeof(String),"%s\t$%s\n", GetVehicleModelName(573), FormatMoney(GetVehicleCostVIP(573)));
					strcat(S3MP4K, String);
					ShowPlayerDialog(playerid, DIALOG_BUYVEHVIP_CONFIRM, DIALOG_STYLE_TABLIST_HEADERS, "Vehicle", S3MP4K, "Buy", "Cancel");
				}
			}
		}
	}
	if(dialogid == DIALOG_BUYVEHVIP_CONFIRM)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new modelid = 522;
					new tstr[128], price = GetVehicleCostVIP(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYVEHVIP_CONFIRM2, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 1:
				{
					new modelid = 411;
					new tstr[128], price = GetVehicleCostVIP(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYVEHVIP_CONFIRM2, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 2:
				{
					new modelid = 451;
					new tstr[128], price = GetVehicleCostVIP(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYVEHVIP_CONFIRM2, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 3:
				{
					new modelid = 494;
					new tstr[128], price = GetVehicleCostVIP(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYVEHVIP_CONFIRM2, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 4:
				{
					new modelid = 541;
					new tstr[128], price = GetVehicleCostVIP(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYVEHVIP_CONFIRM2, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 5:
				{
					new modelid = 573;
					new tstr[128], price = GetVehicleCostVIP(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYVEHVIP_CONFIRM2, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
			}
		}
	}
	if(dialogid == DIALOG_BUYVEHVIP_CONFIRM2)
	{
		new modelid = pData[playerid][pBuyPvModel];
		if(response)
		{
			if(modelid <= 0) return Error(playerid, "Invalid model id.");
			new cost = GetVehicleCostVIP(modelid);
			
			if(pData[playerid][pMoney] < cost)
			{
				Error(playerid, "Uang anda tidak mencukupi.!");
				return 1;
			}
			new count = 0, limit = MAX_PLAYER_VEHICLE + pData[playerid][pVip];
			foreach(new ii : PVehicles)
			{
				if(pvData[ii][cOwner] == pData[playerid][pID] && pvData[ii][cClaim] != 1)
					count++;
			}
			if(count >= limit)
			{
				Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
				return 1;
			}
			Server_Save();
			GivePlayerMoneyEx(playerid, -cost);
			new cQuery[1024];
			new Float:x,Float:y,Float:z, Float:a;
			new model, color1, color2;
			new randcolor1 = Random(0, 126);
		    new randcolor2 = Random(0, 126);
			color1 = randcolor1;
			color2 = randcolor2;
			model = modelid;
			x = 561.8560;
			y = -1280.7902;
			z = 16.9526;
			a = 10.5345;
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, cost, x, y, z, a);
			mysql_tquery(g_SQL, cQuery, "VehBuyVIP", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, cost, x, y, z, a);
			return 1;
		}
		else
		{
			pData[playerid][pBuyPvModel] = 0;
		}
	}
	
	if(dialogid == DIALOG_BUYBIKE_CONFIRM)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new modelid = 481;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYBIKE_CONFIRM2, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 1:
				{
					new modelid = 509;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYBIKE_CONFIRM2, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 2:
				{
					new modelid = 510;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYBIKE_CONFIRM2, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
			}
		}
	}
	if(dialogid == DIALOG_BUYBIKE_CONFIRM2)
	{
		new modelid = pData[playerid][pBuyPvModel];
		if(response)
		{
			if(modelid <= 0) return Error(playerid, "Invalid model id.");
			new cost = GetVehicleCost(modelid);
			
			if(pData[playerid][pMoney] < cost)
			{
				Error(playerid, "Uang anda tidak mencukupi.!");
				return 1;
			}
			new count = 0, limit = MAX_PLAYER_VEHICLE + pData[playerid][pVip];
			foreach(new ii : PVehicles)
			{
				if(pvData[ii][cOwner] == pData[playerid][pID] && pvData[ii][cClaim] != 1)
					count++;
			}
			if(count >= limit)
			{
				Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
				return 1;
			}
			Server_Save();
			GivePlayerMoneyEx(playerid, -cost);
			new cQuery[1024];
			new Float:x,Float:y,Float:z, Float:a;
			new model, color1, color2;
			new randcolor1 = Random(0, 126);
		    new randcolor2 = Random(0, 126);
			color1 = randcolor1;
			color2 = randcolor2;
			model = modelid;
			x = 704.8390;
			y = -523.3535;
			z = 15.9037;
			a = 265.6138;
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, cost, x, y, z, a);
			mysql_tquery(g_SQL, cQuery, "OnVehBuyPVLS", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, cost, x, y, z, a);
			return 1;
		}
		else
		{
			pData[playerid][pBuyPvModel] = 0;
		}
	}
	if(dialogid == DIALOG_BUYMOTOR_CONFIRM)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new modelid = 463;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYMOTOR_CONFIRM2, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 1:
				{
					new modelid = 521;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYMOTOR_CONFIRM2, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 2:
				{
					new modelid = 461;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYMOTOR_CONFIRM2, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 3:
				{
					new modelid = 581;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYMOTOR_CONFIRM2, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 4:
				{
					new modelid = 468;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYMOTOR_CONFIRM2, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 5:
				{
					new modelid = 586;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYMOTOR_CONFIRM2, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 6:
				{
					new modelid = 462;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYMOTOR_CONFIRM2, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
			}
		}
	}
	if(dialogid == DIALOG_BUYMOTOR_CONFIRM2)
	{
		new modelid = pData[playerid][pBuyPvModel];
		if(response)
		{
			if(modelid <= 0) return Error(playerid, "Invalid model id.");
			new cost = GetVehicleCost(modelid);
			
			if(pData[playerid][pMoney] < cost)
			{
				Error(playerid, "Uang anda tidak mencukupi.!");
				return 1;
			}
			new count = 0, limit = MAX_PLAYER_VEHICLE + pData[playerid][pVip];
			foreach(new ii : PVehicles)
			{
				if(pvData[ii][cOwner] == pData[playerid][pID] && pvData[ii][cClaim] != 1)
					count++;
			}
			if(count >= limit)
			{
				Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
				return 1;
			}
			Server_Save();
			GivePlayerMoneyEx(playerid, -cost);
			new cQuery[1024];
			new Float:x,Float:y,Float:z, Float:a;
			new model, color1, color2;
			new randcolor1 = Random(0, 126);
		    new randcolor2 = Random(0, 126);
			color1 = randcolor1;
			color2 = randcolor2;
			model = modelid;
			x = 1841.7048;
			y = -1871.9816;
			z = 12.9575;
			a = 0.1687;
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, cost, x, y, z, a);
			mysql_tquery(g_SQL, cQuery, "OnVehBuyPVLS", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, cost, x, y, z, a);
			return 1;
		}
		else
		{
			pData[playerid][pBuyPvModel] = 0;
		}
	}
	if(dialogid == DIALOG_BUYPVLS_CONFIRM)
	{
		new modelid = pData[playerid][pBuyPvModel];
		if(response)
		{
			if(modelid <= 0) return Error(playerid, "Invalid model id.");
			new cost = GetVehicleCost(modelid);
			
			if(pData[playerid][pMoney] < cost)
			{
				Error(playerid, "Uang anda tidak mencukupi.!");
				return 1;
			}
			new count = 0, limit = MAX_PLAYER_VEHICLE + pData[playerid][pVip];
			foreach(new ii : PVehicles)
			{
				if(pvData[ii][cOwner] == pData[playerid][pID] && pvData[ii][cClaim] != 1)
					count++;
			}
			if(count >= limit)
			{
				Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
				return 1;
			}
			Server_Save();
			GivePlayerMoneyEx(playerid, -cost);
			new cQuery[1024];
			new Float:x,Float:y,Float:z, Float:a;
			new model, color1, color2;
			color1 = 0;
			color2 = 0;
			model = modelid;
			x = 1870.07;
			y = -1400.41;
			z = 13.17;
			a = 1.35;
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, cost, x, y, z, a);
			mysql_tquery(g_SQL, cQuery, "OnVehBuyPVLS", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, cost, x, y, z, a);
			return 1;
		}
		else
		{
			pData[playerid][pBuyPvModel] = 0;
		}
	}
	if(dialogid == DIALOG_SHARELOC)
	{
		if(response)
		{
			new otherid = strval(inputtext);

			if(pData[playerid][pInjured] == 1)
		        return Error(playerid, "You are injured at the moment.");

			if(!IsPlayerConnected(otherid) || otherid == playerid) return SendClientMessage(playerid, 0xCECECEFF, "Tidak ada pemain seperti itu");

		    SetPVarInt(otherid, "sharelok", playerid);
		    //Info(otherid, "%s Telah menawari sharelok kepada anda, /accept sharelok untuk menerimanya /deny sharelok untuk membatalkannya.", ReturnName(playerid));
			SendClientMessageEx(playerid, COLOR_ARWIN, "SHARELOC: "WHITE_E"Anda berhasil menawari sharelok kepada player %s", ReturnName(otherid));
			SendClientMessageEx(otherid, COLOR_ARWIN, "SHARELOC: "WHITE_E"%s Telah menawari sharelok kepada anda, /accept sharelok untuk menerimanya /deny sharelok untuk membatalkannya.", ReturnName(playerid));

		}
		return 1;
	}
	if(dialogid == DIALOG_BUYPVBOAT)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					//Bikes
					new str[1024];
					format(str, sizeof(str), ""WHITE_E"%s\t\t"LG_E"$%s",
					GetVehicleModelName(453), FormatMoney(GetVehicleCost(453))
					);

					ShowPlayerDialog(playerid, DIALOG_BUYPVCP_BOAT, DIALOG_STYLE_LIST, "Boat", str, "Buy", "Close");
				}
			}
		}
	}
	if(dialogid == DIALOG_BUYPVCP_BOAT)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new modelid = 453;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYPVBOAT_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
			}
		}
	}
	if(dialogid == DIALOG_BUYPVBOAT_CONFIRM)
	{
		new modelid = pData[playerid][pBuyPvModel];
		if(response)
		{
			if(modelid <= 0) return Error(playerid, "Invalid model id.");
			new cost = GetVehicleCost(modelid);
			if(pData[playerid][pMoney] < cost)
			{
				Error(playerid, "Uang anda tidak mencukupi.!");
				return 1;
			}
			new count = 0, limit = MAX_PLAYER_VEHICLE + pData[playerid][pVip];
			foreach(new ii : PVehicles)
			{
				if(pvData[ii][cOwner] == pData[playerid][pID] && pvData[ii][cClaim] != 1)
					count++;
			}
			if(count >= limit)
			{
				Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
				return 1;
			}
			GivePlayerMoneyEx(playerid, -cost);
			new cQuery[1024];
			new Float:x,Float:y,Float:z, Float:a;
			new model, color1, color2;
			color1 = 0;
			color2 = 0;
			model = modelid;
			x = 90.90;
			y = -1902.95;
			z = -0.60;
			a = 74.91;
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, cost, x, y, z, a);
			mysql_tquery(g_SQL, cQuery, "OnVehBuyPVBOAT", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, cost, x, y, z, a);
			return 1;
		}
		else
		{
			pData[playerid][pBuyPvModel] = 0;
		}
	}
	if(dialogid == DIALOG_MODSHOP)
	{
		if(response)
		{
			switch (listitem)
			{
				case 0:
				{   
					ShowPlayerSelectionMenu(playerid, MODEL_SELECTION_Transfender, "Modshop:", transfender, sizeof(transfender));
				}
				case 1:
				{   
					ShowPlayerSelectionMenu(playerid, MODEL_SELECTION_Waa, "Modshop:", waa, sizeof(waa));
			    }
				case 2:
				{   
					ShowPlayerSelectionMenu(playerid, MODEL_SELECTION_Loco, "Modshop:", loco, sizeof(loco));
			    }
				case 3:
				{
				    if(pData[playerid][pVip] < 2) return PermissionError(playerid);
				    static 
				        vehicle;
				    
				    vehicle = Vehicle_Nearest(playerid);
				    if(vehicle != INVALID_VEHICLE_ID) 
				    {
				    	Vehicle_TextAdd(playerid, vehicle, 18661, OBJECT_TYPE_TEXT);
				    	return 1;
				    } 
				    else Error(playerid, "Invalid vehicle id.");
				    
				}
				case 4:
				{
				    if(pData[playerid][pVip] < 2) return PermissionError(playerid);
				    static 
				        vehicle;
				    
				    vehicle = Vehicle_Nearest(playerid);
				    if(vehicle != INVALID_VEHICLE_ID) 
				    {
				    	Vehicle_SpotLightAdd(playerid, vehicle, 19281, OBJECT_TYPE_LIGHT);
				    	return 1;
				    } 
				    else Error(playerid, "Invalid vehicle id.");
				    
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_SKILLPLAYER)
	{
		if(response)
		{
			switch (listitem)
			{
				case 0:
				{
					new tstr[500];
					format(tstr, sizeof(tstr), "Kegunaan Skil Player\n- {00FFFF}Level "YELLOW_E"2 {00FFFF}Mendapatkan Bonus "YELLOW_E"5\n- {00FFFF}Level "YELLOW_E"3 {00FFFF}Mendapatkan Bonus "YELLOW_E"10\n- {00FFFF}Level "YELLOW_E"4 {00FFFF}Mendapatkan Bonus "YELLOW_E"15\n- {00FFFF}Level "YELLOW_E"5 {00FFFF}Mendapatkan Bonus "YELLOW_E"20");
					ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Skill Player", tstr, "Close", "");
				}
				case 1:
				{
					new tstr[500];
					format(tstr, sizeof(tstr), "Kegunaan Skil Player\n- {00FFFF}Level "YELLOW_E"1 {00FFFF}Hanya bisa mancing di pemancingan\n- {00FFFF}Level "YELLOW_E"2 {00FFFF}Bisa mancing di tengah laut dan di pemancingan");
					ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Skill Player", tstr, "Close", "");
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_FIGHTSTYLE)
	{
		if(response)
		{
			switch (listitem)
			{
				case 0:
				{
					if(GetPlayerMoney(playerid) < 12500)
						return Error(playerid, "Not enough money!");
					SetPlayerFightingStyle(playerid, 4);
					SendClientMessageEx(playerid, COLOR_ARWIN, "BISNIS: "WHITE_E"You've managed to buy a fight style.");
					GivePlayerMoneyEx(playerid, -12500);
					pData[playerid][FightStyle] = 4;
				}
				case 1:
				{
					if(GetPlayerMoney(playerid) < 12500)
						return Error(playerid, "Not enough money!");
					SetPlayerFightingStyle(playerid, 5);
					SendClientMessageEx(playerid, COLOR_ARWIN, "BISNIS: "WHITE_E"You've managed to buy a fight style.");
					GivePlayerMoneyEx(playerid, -12500);
					pData[playerid][FightStyle] = 5;
				}
				case 2:
				{
					if(GetPlayerMoney(playerid) < 12500)
						return Error(playerid, "Not enough money!");
					SetPlayerFightingStyle(playerid, 6);
					SendClientMessageEx(playerid, COLOR_ARWIN, "BISNIS: "WHITE_E"You've managed to buy a fight style.");
					GivePlayerMoneyEx(playerid, -12500);
					pData[playerid][FightStyle] = 6;
				}
				case 3:
				{
					if(GetPlayerMoney(playerid) < 12500)
						return Error(playerid, "Not enough money!");		
					SetPlayerFightingStyle(playerid, 7);
					SendClientMessageEx(playerid, COLOR_ARWIN, "BISNIS: "WHITE_E"You've managed to buy a fight style.");
					GivePlayerMoneyEx(playerid, -12500);
					pData[playerid][FightStyle] = 7;
				}
				case 4:
				{
					if(GetPlayerMoney(playerid) < 12500)
						return Error(playerid, "Not enough money!");			
					SetPlayerFightingStyle(playerid, 15);
					SendClientMessageEx(playerid, COLOR_ARWIN, "BISNIS: "WHITE_E"You've managed to buy a fight style.");
					GivePlayerMoneyEx(playerid, -12500);
					pData[playerid][FightStyle] = 15;
				}
				case 5:
				{
					if(GetPlayerMoney(playerid) < 12500)
						return Error(playerid, "Not enough money!");
					SetPlayerFightingStyle(playerid, 16);
					SendClientMessageEx(playerid, COLOR_ARWIN, "BISNIS: "WHITE_E"You've managed to buy a fight style.");
					GivePlayerMoneyEx(playerid, -12500);
					pData[playerid][FightStyle] = 16;
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_URL_BOOMBOX)
	{
		if(response)
		{
		    if(strlen(inputtext))
		    {
				new string[128], Float:BBCoord[4];
				GetPlayerPos(playerid, BBCoord[0], BBCoord[1], BBCoord[2]);
				GetPlayerFacingAngle(playerid, BBCoord[3]);
				SetPVarFloat(playerid, "BBX", BBCoord[0]);
				SetPVarFloat(playerid, "BBY", BBCoord[1]);
				SetPVarFloat(playerid, "BBZ", BBCoord[2]);
				BBCoord[0] += (2 * floatsin(-BBCoord[3], degrees));
				BBCoord[1] += (2 * floatcos(-BBCoord[3], degrees));
				BBCoord[2] -= 1.0;
				if(GetPVarInt(playerid, "PlacedBB")) return Error(playerid, "You already placed a radio");
				foreach(new i : Player)
				{
					if(GetPVarType(i, "PlacedBB"))
					{
						if(IsPlayerInRangeOfPoint(playerid, 30.0, GetPVarFloat(i, "BBX"), GetPVarFloat(i, "BBY"), GetPVarFloat(i, "BBZ")))
						{
							SendClientMessage(playerid, COLOR_ARWIN, "RADIO: "WHITE_E"You cannot put your radio in this Radius as their is already one placed in this radius");
							return 1;
						}
					}
				}
				SetPVarInt(playerid, "PlacedBB", CreateDynamicObject(2226, BBCoord[0], BBCoord[1], BBCoord[2], 0.0, 0.0, 0.0, .worldid = GetPlayerVirtualWorld(playerid), .interiorid = GetPlayerInterior(playerid)));
				format(string, sizeof(string), "{00FFFF}[RADIO]\n"YELLOW_E"%s", pData[playerid][pName]);
				SetPVarInt(playerid, "BBLabel", _:CreateDynamic3DTextLabel(string, -1, BBCoord[0], BBCoord[1], BBCoord[2]+0.6, 5, .worldid = GetPlayerVirtualWorld(playerid), .interiorid = GetPlayerInterior(playerid)));
				SetPVarInt(playerid, "BBArea", CreateDynamicSphere(BBCoord[0], BBCoord[1], BBCoord[2], 30.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid)));
				SetPVarInt(playerid, "BBInt", GetPlayerInterior(playerid));
				SetPVarInt(playerid, "BBVW", GetPlayerVirtualWorld(playerid));
		        if(GetPVarType(playerid, "PlacedBB"))
				{
				    foreach(new i : Player)
					{
						if(IsPlayerInDynamicArea(i, GetPVarInt(playerid, "BBArea")))
						{
							PlayStream(i, inputtext, GetPVarFloat(playerid, "BBX"), GetPVarFloat(playerid, "BBY"), GetPVarFloat(playerid, "BBZ"), 30.0, 1);
				  		}
				  	}
			  		SetPVarString(playerid, "BBStation", inputtext);
				}
			}
		}
	}
	//Farm
	if(dialogid == FARM_SAFE)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
				ShowPlayerDialog(playerid, FARM_PRODUCT, DIALOG_STYLE_LIST, "Potato", "Withdraw from safe\nDeposit into safe", "Select", "Back");
			}
			case 1:
			{
				ShowPlayerDialog(playerid, FARM_WHITE, DIALOG_STYLE_LIST, "Wheat", "Withdraw from safe\nDeposit into safe", "Select", "Back");
			}
			case 2:
			{
				ShowPlayerDialog(playerid, FARM_ORANGE, DIALOG_STYLE_LIST, "Orange", "Withdraw from safe\nDeposit into safe", "Select", "Back");
			}
			case 3:
			{
				if(pData[playerid][pLadangRank] < 5)
					return Error(playerid, "You must Farm level 5 - 6!");
				ShowPlayerDialog(playerid, FARM_CHANGENAME, DIALOG_STYLE_INPUT, "Farm Change Name","Change Name Farm","OK","Exit");
			}
		}
		return 1;
	}
	if(dialogid == FARM_CHANGENAME)
	{
		if(response) 
		{
			new wid = pData[playerid][pLadang];
		    format(laData[wid][laName], 50, inputtext);
			Ladang_Save(wid);
			Ladang_Refresh(wid);
			SendClientMessageEx(playerid, COLOR_ARWIN, "FARM: "WHITE_E"kamu telah mengganti nama Farm menjadi "YELLOW_E"%s.", inputtext);
		}
		return 1;
	}
	if(dialogid == FARM_PRODUCT)
	{
		if(response)
		{
			new wid = pData[playerid][pLadang];
			if(wid == -1) return Error(playerid, "You don't have farm.");
			if(response)
			{
				switch (listitem)
				{
					case 0:
					{
						if(pData[playerid][pLadangRank] < 5)
							return Error(playerid, "You must farm owner!");
						new str[128];
						format(str, sizeof(str), "Product Balance: %d\n\nPlease enter how much product you wish to withdraw from the safe:", laData[wid][laProduct]);
						ShowPlayerDialog(playerid, FARM_WITHDRAWPRODUCT, DIALOG_STYLE_INPUT, "Withdraw from safe", str, "Withdraw", "Back");
					}
					case 1:
					{
						new str[128];
						format(str, sizeof(str), "Product Balance: %d\n\nPlease enter how much Product you wish to deposit into the safe:", laData[wid][laProduct]);
						ShowPlayerDialog(playerid, FARM_DEPOSITPRODUCT, DIALOG_STYLE_INPUT, "Deposit into safe", str, "Deposit", "Back");
					}
				}
			}
			else callcmd::lasafe(playerid);
		}
		return 1;
	}
    if( dialogid == DIALOG_MAKEAMMO)
	{
		if(response)
		{
			if(pData[playerid][pMaterial] < 1) return Error(playerid, "Anda todak mempunyai material");
			SendClientMessageEx(playerid, COLOR_ARWIN, "CRAFTING: "WHITE_E"Crafted "YELLOW_E"250 Ammo "WHITE_E"Using "YELLOW_E"1000 materials");
			pData[playerid][pMaterial] -= 1000;
			pData[playerid][pAmmo][GetWeaponSlot(GetPlayerWeapon(playerid))] += 250;
		}
	}
	if( dialogid == DIALOG_CREATEGUN)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
				if(pData[playerid][pMaterial] >= 1000)
				{
					GivePlayerWeaponEx(playerid, 33, 1);
					pData[playerid][pMaterial] -= 1000;
					SendClientMessageEx(playerid, COLOR_ARWIN, "CRAFTING: "WHITE_E"You've crafted "YELLOW_E"Riffle "WHITE_E"Using {00FFFF}1000 materials");
				}
				else
				{
					Error(playerid, "You don't have enough material to make this weapon.");
				}
			}
			case 1:
			{
				if(pData[playerid][pMaterial] >= 2000)
				{
					GivePlayerWeaponEx(playerid, 25, 1);
					pData[playerid][pMaterial] -= 2000;
					SendClientMessageEx(playerid, COLOR_ARWIN, "CRAFTING: "WHITE_E"You've crafted "YELLOW_E"Shotgun "WHITE_E"Using {00FFFF}2000 materials");
				}
				else
				{
					Error(playerid, "You don't have enough material to make this weapon.");
				}
			}
			case 2:
			{
				if(pData[playerid][pFamily] < 0) return Error(playerid, "You're not in a family.");
				if(pData[playerid][pMaterial] >= 2500)
				{
					GivePlayerWeaponEx(playerid, 24, 1);
					pData[playerid][pMaterial] -= 2500;
					SendClientMessageEx(playerid, COLOR_ARWIN, "CRAFTING: "WHITE_E"You've crafted "YELLOW_E"Desert Eagle "WHITE_E"Using {00FFFF}2500 materials");
				}
				else
				{
					Error(playerid, "You don't have enough material to make this weapon.");
				}
			}
			case 3:
			{
				if(pData[playerid][pFamily] < 0) return Error(playerid, "You're not in a family.");
				if(pData[playerid][pMaterial] >= 5000)
				{
					GivePlayerWeaponEx(playerid, 29, 1);
					pData[playerid][pMaterial] -= 5000;
					SendClientMessageEx(playerid, COLOR_ARWIN, "CRAFTING: "WHITE_E"You've crafted "YELLOW_E"MP5 "WHITE_E"Using {00FFFF}5000 materials");
				}
				else
				{
					Error(playerid, "You don't have enough material to make this weapon.");
				}
			}
			case 4:
			{
				if(pData[playerid][pFamily] < 0) return Error(playerid, "You're not in a family.");
				if(pData[playerid][pMaterial] >= 7000)
				{
					GivePlayerWeaponEx(playerid, 30, 1);
					pData[playerid][pMaterial] -= 7000;
					SendClientMessageEx(playerid, COLOR_ARWIN, "CRAFTING: "WHITE_E"You've crafted "YELLOW_E"AK47 "WHITE_E" Using {00FFFF}7000 materials");
				}
				else
				{
					Error(playerid, "You don't have enough material to make this weapon.");
				}
			}
		}
		return 1;
	}	
	// if(dialogid == AdsTextPhone)
	// {
	// 	if(response)
	// 	{
	// 		SendAdsToQue(playerid, inputtext);
	// 		SendClientMessageEx(playerid, COLOR_ARWIN, "ADS: {ffffff}Your Advertisement has been issued to the queue, use '{ffff00}/ads{ffffff}' to see your Advertisement");
	// 		pData[playerid][pAdsTime] = 900;
	// 	}
	// 	return 1;
	// }
	if( dialogid == DIALOG_REFUEL)
	{
		if (response)
		{
		    new idiot = floatround(strval(inputtext));
			new value = idiot * HargaBensin, String[212];
			if(idiot > 999 || idiot < 0) return Error(playerid, "Tidak bisa di atas 999");
			if(GetPlayerMoney(playerid) < value) return Error(playerid, "Uang anda tidak cukup untuk membeli bensin sebanyak itu");
			GivePlayerMoneyEx(playerid, -value);
			pData[playerid][pFillTime] = SetTimerEx("Filling", 2000, true, "i", playerid);
			format(String, sizeof(String), "FUEL: "WHITE_E"Anda telah membeli %d unit bensin dengan harga $%s", idiot, FormatMoney(value));
			SendClientMessage(playerid, COLOR_ARWIN, String);
		}
	}
	if(dialogid == DIALOG_BUYTRUCK)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new modelid = 403;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYTRUCKCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 1:
				{
					new modelid = 514;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYTRUCKCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 2:
				{
					new modelid = 515;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYTRUCKCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 3:
				{
					new modelid = 498;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYTRUCKCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 4:
				{
					new modelid = 499;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYTRUCKCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 5:
				{
					new modelid = 455;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYTRUCKCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 6:
				{
					new modelid = 403;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYTRUCKCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 7:
				{
					new modelid = 516;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYTRUCKCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 8:
				{
					new modelid = 515;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYTRUCKCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
			}
		}
	}
	if(dialogid == DIALOG_BUYTRUCKCONFIRM)
	{
		new modelid = pData[playerid][pBuyPvModel];
		if(response)
		{
			if(modelid <= 0) return Error(playerid, "Invalid model id.");
			new cost = GetVehicleCost(modelid);
			
			if(pData[playerid][pMoney] < cost)
			{
				Error(playerid, "Uang anda tidak mencukupi.!");
				return 1;
			}
			new count = 0, limit = MAX_PLAYER_VEHICLE + pData[playerid][pVip];
			foreach(new ii : PVehicles)
			{
				if(pvData[ii][cOwner] == pData[playerid][pID] && pvData[ii][cClaim] != 1)
					count++;
			}
			if(count >= limit)
			{
				Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
				return 1;
			}
			Server_Save();
			GivePlayerMoneyEx(playerid, -cost);
			new cQuery[1024];
			new Float:x,Float:y,Float:z, Float:a;
			new model, color1, color2;
			color1 = 0;
			color2 = 0;
			model = modelid;
			x = -72.1491;
			y = -1129.5632;
			z = 1.0781;
			a = 69.9099;
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, cost, x, y, z, a);
			mysql_tquery(g_SQL, cQuery, "OnVehBuyPV", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, cost, x, y, z, a);
			return 1;
		}
		else
		{
			pData[playerid][pBuyPvModel] = 0;
		}
	}
	if(dialogid == DIALOG_BUYTAXI)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new modelid = 420;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYTAXICONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 1:
				{
					new modelid = 438;
					new tstr[128], price = GetVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYTAXICONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
			}
		}
	}
	if(dialogid == DIALOG_BUYTAXICONFIRM)
	{
		new modelid = pData[playerid][pBuyPvModel];
		if(response)
		{
			if(modelid <= 0) return Error(playerid, "Invalid model id.");
			new cost = GetVehicleCost(modelid);
			
			if(pData[playerid][pMoney] < cost)
			{
				Error(playerid, "Uang anda tidak mencukupi.!");
				return 1;
			}
			new count = 0, limit = MAX_PLAYER_VEHICLE + pData[playerid][pVip];
			foreach(new ii : PVehicles)
			{
				if(pvData[ii][cOwner] == pData[playerid][pID] && pvData[ii][cClaim] != 1)
					count++;
			}
			if(count >= limit)
			{
				Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
				return 1;
			}
			Server_Save();
			GivePlayerMoneyEx(playerid, -cost);
			new cQuery[1024];
			new Float:x,Float:y,Float:z, Float:a;
			new model, color1, color2;
			color1 = 0;
			color2 = 0;
			model = modelid; //1700.5409,-1476.8165,13.3893,91.6928
			x = 1700.5409;
			y = -1476.8165;
			z = 13.3893;
			a = 91.6928;
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, cost, x, y, z, a);
			mysql_tquery(g_SQL, cQuery, "OnVehBuyPV", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, cost, x, y, z, a);
			return 1;
		}
		else
		{
			pData[playerid][pBuyPvModel] = 0;
		}
	}
	if( dialogid == DIALOG_BUYBAIT) //bait system
	{
		new tbait = strval(inputtext);
		new String[212];
		if(!response)
		{
			format(String, sizeof(String), "Bait Price: $0.5");
			ShowPlayerDialog( playerid, DIALOG_BUYBAIT, DIALOG_STYLE_INPUT, "Buy Bait",String, "Buy", "Cancel" );
		}
		else
		{
		    if(GetPlayerMoney(playerid) < tbait * 5) { Error(playerid, "Uang anda tidak cukup !"); return 1; }
            if(tbait > 100) { Info(playerid, "Kamu telah memiliki banyak umpan."); return 1; }
            if(tbait < 1) { Error(playerid, "Minimal membeli 1 Umpan."); return 1; }
            new harga = tbait * 5;
			GivePlayerMoneyEx(playerid, -harga);
			format(String, sizeof(String), "FISH: "WHITE_E"Anda telah membeli %d Bait Umpan dengan harga %s",tbait, FormatMoney(harga));
			SendClientMessageEx(playerid,COLOR_ARWIN,String);
			pData[playerid][pWorm] += tbait;
		}
  		return 1;
 	}
	if( dialogid == DIALOG_SELLFISH)
	{
		if(response)
		{
			new totalfish = pData[playerid][pFish] + pData[playerid][pFish1] + pData[playerid][pFish2] + pData[playerid][pFish3] + pData[playerid][pFish4];
		    new String[212];
			StockFish += totalfish / 25;
			GivePlayerMoneyEx(playerid, totalfish * FishPrice / 2);
	      	format(String, sizeof(String), "FISH: {FFFF00}Kamu mendapat uang sebesar {FF0000}$%s {FFFF00}dari menjual ikan", FormatMoney(totalfish * FishPrice));
			SendClientMessageEx(playerid, COLOR_ARWIN, String);
			pData[playerid][pFish] = 0;
			pData[playerid][pFish1] = 0;
			pData[playerid][pFish2] = 0;
			pData[playerid][pFish3] = 0;
			pData[playerid][pFish4] = 0;
			pData[playerid][pDelayFishing] = 1200;	
			pData[playerid][pFishMax] = 0;
			new random2 = RandomEx(1, 5);
			pData[playerid][LevelFishing] += random2;
			ammountsellfish++;
			Server_Save();
		}
	}
	if(dialogid == DIALOG_BUG)
	{
	    if(!response) return 1;
		if(response)
		{
			new String[212];
		    if(listitem == 0)
		    {
				foreach(new i : Player)
				{
					if(pData[i][pAdmin] > 0)
					{
						format(String,sizeof(String), "[STUCK]: {00FFFF}%s[id:%d] "YELLOW_E"Freeze bug while Spawn or Death.", ReturnName(playerid), playerid);
						SendClientMessage(playerid, COLOR_ARWIN, String);
					}
				}
				SendClientMessage(playerid, COLOR_ARWIN, "REPORTINFO: "WHITE_E"Report anda telah dikirim ke Administrator yang online");
				return 1;
			}
			if(listitem == 1)
			{
				foreach(new i : Player)
				{
					if(pData[i][pAdmin] > 0)
					{
						format(String,sizeof(String), "[STUCK]: {00FFFF}%s[id:%d] "YELLOW_E"Wrong World ID (WWID) (vw: %d, int: %d)",ReturnName(playerid), playerid, pData[playerid][pWorld], pData[playerid][pInt]);
						SendClientMessage(playerid, COLOR_ARWIN, String);
					}
				}
				SendClientMessage(playerid, COLOR_ARWIN, "REPORTINFO: "WHITE_E"Report anda telah dikirim ke Administrator yang online");
				return 1;
			}
			if(listitem == 2)
			{
				foreach(new i : Player)
				{
					if(pData[i][pAdmin] > 0)
					{
						format(String,sizeof(String), "[STUCK]: {00FFFF}%s[id:%d] "YELLOW_E"Stuck at someone property or entraance (vw: %d, int: %d)",ReturnName(playerid), playerid, pData[playerid][pWorld], pData[playerid][pInt]);
						SendClientMessage(playerid, COLOR_ARWIN, String);
					}
				}
				SendClientMessage(playerid, COLOR_ARWIN, "REPORTINFO: "WHITE_E"Report anda telah dikirim ke Administrator yang online");
				return 1;
			}
			if(listitem == 3)
			{
				foreach(new i : Player)
				{
					if(pData[i][pAdmin] > 0)
					{
						format(String,sizeof(String), "[STUCK]: {00FFFF}%s[id:%d] "YELLOW_E"Spawn at Blueberry (vw: %d, int: %d)",ReturnName(playerid), playerid, pData[playerid][pWorld], pData[playerid][pInt]);
						SendClientMessage(playerid, COLOR_ARWIN, String);
					}
				}
				SendClientMessage(playerid, COLOR_ARWIN, "REPORTINFO: "WHITE_E"Report anda telah dikirim ke Administrator yang online");
				return 1;
			}
			if(listitem == 4)
			{
				foreach(new i : Player)
				{
					if(pData[i][pAdmin] > 0)
					{
						format(String,sizeof(String), "[STUCK]: {00FFFF}%s[id:%d] "YELLOW_E"Bug Death (vw: %d, int: %d)",ReturnName(playerid), playerid, pData[playerid][pWorld], pData[playerid][pInt]);
						SendClientMessage(playerid, COLOR_ARWIN, String);
					}
				}
				SendClientMessage(playerid, COLOR_ARWIN, "REPORTINFO: "WHITE_E"Report anda telah dikirim ke Administrator yang online");
				return 1;
			}
		}
	}
	// if(dialogid == DIALOG_COORD)
	// {
	//     if(response)
	// 	{
	// 		switch(listitem)
	// 		{
	// 		    case 0: ShowPlayerDialog(playerid, DIALOG_X, DIALOG_STYLE_INPUT, "Object Edit", "Input an X Offset from -100 to 100", "Confirm", "Cancel");
	// 			case 1: ShowPlayerDialog(playerid, DIALOG_Y, DIALOG_STYLE_INPUT, "Object Edit", "Input a Y Offset from -100 to 100", "Confirm", "Cancel");
	// 		    case 2: ShowPlayerDialog(playerid, DIALOG_Z, DIALOG_STYLE_INPUT, "Object Edit", "Input a Z Offset from -100 to 100", "Confirm", "Cancel");
	// 		    case 3: ShowPlayerDialog(playerid, DIALOG_RX, DIALOG_STYLE_INPUT, "Object Edit", "Input an X Rotation from 0 to 360", "Confirm", "Cancel");
	// 			case 4: ShowPlayerDialog(playerid, DIALOG_RY, DIALOG_STYLE_INPUT, "Object Edit", "Input a Y Rotation from 0 to 360", "Confirm", "Cancel");
	// 			case 5: ShowPlayerDialog(playerid, DIALOG_RZ, DIALOG_STYLE_INPUT, "Object Edit", "Input a Z Rotation from 0 to 360", "Confirm", "Cancel");
	// 		}
	// 	}
	// }
	// if(dialogid == DIALOG_MTC)
	// {
	//     if(response)
	// 	{
	// 		switch(listitem)
	// 		{
	// 		    case 0: ShowPlayerDialog(playerid, DIALOG_MTX, DIALOG_STYLE_INPUT, "Material Text Edit", "Input an X Offset from -100 to 100", "Confirm", "Cancel");
	// 			case 1: ShowPlayerDialog(playerid, DIALOG_MTY, DIALOG_STYLE_INPUT, "Material Text Edit", "Input a Y Offset from -100 to 100", "Confirm", "Cancel");
	// 		    case 2: ShowPlayerDialog(playerid, DIALOG_MTZ, DIALOG_STYLE_INPUT, "Material Text Edit", "Input a Z Offset from -100 to 100", "Confirm", "Cancel");
	// 		    case 3: ShowPlayerDialog(playerid, DIALOG_MTRX, DIALOG_STYLE_INPUT, "Material Text Edit", "Input an X Rotation from 0 to 360", "Confirm", "Cancel");
	// 			case 4: ShowPlayerDialog(playerid, DIALOG_MTRY, DIALOG_STYLE_INPUT, "Material Text Edit", "Input a Y Rotation from 0 to 360", "Confirm", "Cancel");
	// 			case 5: ShowPlayerDialog(playerid, DIALOG_MTRZ, DIALOG_STYLE_INPUT, "Material Text Edit", "Input a Z Rotation from 0 to 360", "Confirm", "Cancel");
	// 		}
	// 	}
	// }
	// if(dialogid == DIALOG_MTX)
	// {
	//     if(response)
	//     {
	//         new Float:offset = floatstr(inputtext);
	//         new Float:obj = MatextData[EditingMatext[playerid]][mtPos][0];
	//         if(offset < -100) offset = 0;
	// 		else if(offset > 100) offset = 100;
	//         offset = offset/100;
    //      	MatextData[EditingMatext[playerid]][mtPos][0] = obj + offset;

	//         Matext_Refresh(EditingMatext[playerid]);
	//         Matext_Save(EditingMatext[playerid]);

	//         EditingMatext[playerid] = -1;
	// 	}
	// }
	// if(dialogid == DIALOG_MTY)
	// {
	//     if(response)
	//     {
	//         new Float:offset = floatstr(inputtext);
	//         new Float:obj = MatextData[EditingMatext[playerid]][mtPos][1];
	//         if(offset < -100) offset = 0;
	// 		else if(offset > 100) offset = 100;
	//         offset = offset/100;
	//         MatextData[EditingMatext[playerid]][mtPos][1] = obj + offset;

	//         Matext_Refresh(EditingMatext[playerid]);
	//         Matext_Save(EditingMatext[playerid]);

	//         EditingMatext[playerid] = -1;
	// 	}
	// }
	// if(dialogid == DIALOG_MTZ)
	// {
	//     if(response)
	//     {
	//         new Float:offset = floatstr(inputtext);
	//         new Float:obj = MatextData[EditingMatext[playerid]][mtPos][2];
	//         if(offset < -100) offset = 0;
	// 		else if(offset > 100) offset = 100;
	//         offset = offset/100;
	//         MatextData[EditingMatext[playerid]][mtPos][2] = obj + offset;

	//         Matext_Refresh(EditingMatext[playerid]);
	//         Matext_Save(EditingMatext[playerid]);

	//         EditingMatext[playerid] = -1;
	// 	}
	// }
	// if(dialogid == DIALOG_MTRX)
	// {
	//     if(response)
	//     {
	//         new Float:offset = floatstr(inputtext);
	//         new Float:obj = MatextData[EditingMatext[playerid]][mtPos][3];
	//         if(offset < -100) offset = 0;
	// 		else if(offset > 100) offset = 100;
	//         offset = offset/100;
	//         MatextData[EditingMatext[playerid]][mtPos][3] = obj + offset;

	//         Matext_Refresh(EditingMatext[playerid]);
	//         Matext_Save(EditingMatext[playerid]);

	//         EditingMatext[playerid] = -1;
	// 	}
	// }
	// if(dialogid == DIALOG_MTRY)
	// {
	//     if(response)
	//     {
	//         new Float:offset = floatstr(inputtext);
	//         new Float:obj = MatextData[EditingMatext[playerid]][mtPos][4];
	//         if(offset < -100) offset = 0;
	// 		else if(offset > 100) offset = 100;
	//         offset = offset/100;
	//         MatextData[EditingMatext[playerid]][mtPos][4] = obj + offset;

	//         Matext_Refresh(EditingMatext[playerid]);
	//         Matext_Save(EditingMatext[playerid]);

	//         EditingMatext[playerid] = -1;
	// 	}
	// }
	// if(dialogid == DIALOG_MTRZ)
	// {
	//     if(response)
	//     {
	//         new Float:offset = floatstr(inputtext);
	//         new Float:obj = MatextData[EditingMatext[playerid]][mtPos][5];
	//         if(offset < -100) offset = 0;
	// 		else if(offset > 100) offset = 100;
	//         offset = offset/100;
	//         MatextData[EditingMatext[playerid]][mtPos][5] = obj + offset;

	//         Matext_Refresh(EditingMatext[playerid]);
	//         Matext_Save(EditingMatext[playerid]);

	//         EditingMatext[playerid] = -1;
	// 	}
	// }
	// if(dialogid == DIALOG_X)
	// {
	//     if(response)
	//     {
	//         new Float:offset = floatstr(inputtext);
	//         new Float:obj = ObjectData[EditingObject[playerid]][objPos][0];
	//         if(offset < -100) offset = 0;
	// 		else if(offset > 100) offset = 100;
	//         offset = offset/100;
    //      	ObjectData[EditingObject[playerid]][objPos][0] = obj + offset;

	//         Object_Refresh(EditingObject[playerid]);
	//         Object_Save(EditingObject[playerid]);

	//         EditingObject[playerid] = -1;
	// 	}
	// }
	// if(dialogid == DIALOG_Y)
	// {
	//     if(response)
	//     {
	//         new Float:offset = floatstr(inputtext);
	//         new Float:obj = ObjectData[EditingObject[playerid]][objPos][1];
	//         if(offset < -100) offset = 0;
	// 		else if(offset > 100) offset = 100;
	//         offset = offset/100;
	//         ObjectData[EditingObject[playerid]][objPos][1] = obj + offset;

	//         Object_Refresh(EditingObject[playerid]);
	//         Object_Save(EditingObject[playerid]);

	//         EditingObject[playerid] = -1;
	// 	}
	// }
	// if(dialogid == DIALOG_Z)
	// {
	//     if(response)
	//     {
	//         new Float:offset = floatstr(inputtext);
	//         new Float:obj = ObjectData[EditingObject[playerid]][objPos][2];
	//         if(offset < -100) offset = 0;
	// 		else if(offset > 100) offset = 100;
	//         offset = offset/100;
	//         ObjectData[EditingObject[playerid]][objPos][2] = obj + offset;

	//         Object_Refresh(EditingObject[playerid]);
	//         Object_Save(EditingObject[playerid]);

	//         EditingObject[playerid] = -1;
	// 	}
	// }
	// if(dialogid == DIALOG_RX)
	// {
	//     if(response)
	//     {
	//         new Float:offset = floatstr(inputtext);
	//         new Float:obj = ObjectData[EditingObject[playerid]][objPos][3];
	//         if(offset < -100) offset = 0;
	// 		else if(offset > 100) offset = 100;
	//         offset = offset/100;
	//         ObjectData[EditingObject[playerid]][objPos][3] = obj + offset;

	//         Object_Refresh(EditingObject[playerid]);
	//         Object_Save(EditingObject[playerid]);

	//         EditingObject[playerid] = -1;
	// 	}
	// }
	// if(dialogid == DIALOG_RY)
	// {
	//     if(response)
	//     {
	//         new Float:offset = floatstr(inputtext);
	//         new Float:obj = ObjectData[EditingObject[playerid]][objPos][4];
	//         if(offset < -100) offset = 0;
	// 		else if(offset > 100) offset = 100;
	//         offset = offset/100;
	//         ObjectData[EditingObject[playerid]][objPos][4] = obj + offset;

	//         Object_Refresh(EditingObject[playerid]);
	//         Object_Save(EditingObject[playerid]);

	//         EditingObject[playerid] = -1;
	// 	}
	// }
	// if(dialogid == DIALOG_RZ)
	// {
	//     if(response)
	//     {
	//         new Float:offset = floatstr(inputtext);
	//         new Float:obj = ObjectData[EditingObject[playerid]][objPos][5];
	//         if(offset < -100) offset = 0;
	// 		else if(offset > 100) offset = 100;
	//         offset = offset/100;
	//         ObjectData[EditingObject[playerid]][objPos][5] = obj + offset;

	//         Object_Refresh(EditingObject[playerid]);
	//         Object_Save(EditingObject[playerid]);

	//         EditingObject[playerid] = -1;
	// 	}
	// }
	// if(dialogid == DIALOG_MTEDIT)
	// {
	//     if(response)
	//     {
	//         switch(listitem)
	//         {
	// 	        case 0:
	// 	        {
	// 	            EditDynamicObject(playerid, MatextData[EditingMatext[playerid]][mtCreate]);
	// 	            SendClientMessageEx(playerid, COLOR_ARWIN, "MATEXT: {FFFFFF}You're Editing Material Text ID %d with Move Object", EditingMatext[playerid]);
	// 			}
	// 			case 1:
	// 			{
	// 				new stringg[512];
	// 				format(stringg, sizeof(stringg), "Offset X (%f)\nOffset Y (%f)\nOffset Z (%f)\nRotation X (%f)\nRotation Y (%f)\nRotation Z (%f)",
	//    				MatextData[EditingMatext[playerid]][mtPos][0],
	// 			    MatextData[EditingMatext[playerid]][mtPos][1],
	// 			    MatextData[EditingMatext[playerid]][mtPos][2],
	//    				MatextData[EditingMatext[playerid]][mtPos][3],
	// 			    MatextData[EditingMatext[playerid]][mtPos][4],
	// 			    MatextData[EditingMatext[playerid]][mtPos][5]
	// 				);
	// 				ShowPlayerDialog(playerid, DIALOG_MTC, DIALOG_STYLE_LIST, "Editing Material Text", stringg, "Select", "Cancel");
	// 			}
	// 			case 2:
	// 			{
	// 				ShowPlayerDialog(playerid, DIALOG_MTTEXT, DIALOG_STYLE_INPUT, "Editing Material Text", "Change Text", "Select", "Cancel");
	// 			}
	// 			case 3:
	// 			{
	// 				//ShowPlayerDialog(playerid, DIALOG_MTTEXT, DIALOG_STYLE_LIST, "Editing Material Text", object_font, "Select", "Cancel");
	// 			}
	// 			case 4:
	// 			{
	// 				ShowPlayerDialog(playerid, DIALOG_MTBOLD, DIALOG_STYLE_LIST, "Editing Material Text", "Off\nOn", "Select", "Cancel");
	// 			}
	// 			case 5:
	// 			{
	// 				ShowPlayerDialog(playerid, DIALOG_MTSIZEOB, DIALOG_STYLE_INPUT, "Editing Material Text", "Change Size Object", "Select", "Cancel");
	// 			}
	// 			case 6:
	// 			{
	// 				ShowPlayerDialog(playerid, DIALOG_MTCOLOR, DIALOG_STYLE_LIST, "Editing Material Text", "White\nBlue\nRed\nYellow", "Select", "Cancel");
	// 			}
	// 			case 7:
	// 			{
	// 				Matext_Delete(EditingMatext[playerid]);
	// 				SendClientMessageEx(playerid, COLOR_ARWIN, "OBJECT: {FFFFFF}You have successfully destroyed Material Text ID: %d.", EditingMatext[playerid]);
	// 			}
	// 		}
	// 	}
	// }
	// if(dialogid == DIALOG_MTTEXT)
	// {
	//     if(response)
	//     {
	// 		format(MatextData[EditingMatext[playerid]][mtText], 128, "%s", inputtext);
	// 		SendClientMessageEx(playerid, COLOR_ARWIN, "MATEXT: {FFFFFF}Text Change to %s", inputtext);
	// 		Matext_Refresh(EditingMatext[playerid]);
	// 		Matext_Save(EditingMatext[playerid]);
	// 	}	
	// }
	// if(dialogid == DIALOG_MTCOLOR)
	// {
	//     if(response)
	//     {
	//         switch(listitem)
	//         {
	// 	        case 0:
	// 	        {
	// 				MatextData[EditingMatext[playerid]][mtColor] = 1;
	// 				Matext_Refresh(EditingMatext[playerid]);
	// 				Matext_Save(EditingMatext[playerid]);
	// 				SendClientMessageEx(playerid, COLOR_ARWIN, "MATEXT: {FFFFFF}Material Text Color changed white");
	// 			}
	// 			case 1:
	// 			{
	// 				MatextData[EditingMatext[playerid]][mtColor] = 2;
	// 				Matext_Refresh(EditingMatext[playerid]);
	// 				Matext_Save(EditingMatext[playerid]);
	// 				SendClientMessageEx(playerid, COLOR_ARWIN, "MATEXT: {FFFFFF}Material Text Color changed blue");
	// 			}	
	// 			case 2:
	// 			{
	// 				MatextData[EditingMatext[playerid]][mtColor] = 3;
	// 				Matext_Refresh(EditingMatext[playerid]);
	// 				Matext_Save(EditingMatext[playerid]);
	// 				SendClientMessageEx(playerid, COLOR_ARWIN, "MATEXT: {FFFFFF}Material Text Color changed red");
	// 			}	
	// 			case 3:
	// 			{
	// 				MatextData[EditingMatext[playerid]][mtColor] = 4;
	// 				Matext_Refresh(EditingMatext[playerid]);
	// 				Matext_Save(EditingMatext[playerid]);
	// 				SendClientMessageEx(playerid, COLOR_ARWIN, "MATEXT: {FFFFFF}Material Text Color changed yellow");
	// 			}	
	// 		}
	// 	}
	// }	
	// if(dialogid == DIALOG_MTSIZEOB)
	// {
	//     if(response)
	//     {
	// 		MatextData[EditingMatext[playerid]][mtSize] = strval(inputtext);
	// 		SendClientMessageEx(playerid, COLOR_ARWIN, "MATEXT: {FFFFFF}Font Size changed to %d", strval(inputtext));
	// 		Matext_Refresh(EditingMatext[playerid]);
	// 		Matext_Save(EditingMatext[playerid]);
	// 	}	
	// }
	// if(dialogid == DIALOG_MTBOLD)
	// {
	//     if(response)
	//     {
	//         switch(listitem)
	//         {
	// 	        case 0:
	// 	        {
	// 				MatextData[EditingMatext[playerid]][mtBold] = 0;
	// 				Matext_Refresh(EditingMatext[playerid]);
	// 				Matext_Save(EditingMatext[playerid]);
	// 				SendClientMessageEx(playerid, COLOR_ARWIN, "MATEXT: {FFFFFF}Material Text Bold changed to off");
	// 			}
	// 			case 1:
	// 			{
	// 				MatextData[EditingMatext[playerid]][mtBold] = 1;
	// 				Matext_Refresh(EditingMatext[playerid]);
	// 				Matext_Save(EditingMatext[playerid]);
	// 				SendClientMessageEx(playerid, COLOR_ARWIN, "MATEXT: {FFFFFF}Material Text Bold changed to on");
	// 			}	
	// 		}
	// 	}
	// }			
	// if(dialogid == DIALOG_EDIT)
	// {
	//     if(response)
	//     {
	//         switch(listitem)
	//         {
	// 	        case 0:
	// 	        {
	// 	            EditDynamicObject(playerid, ObjectData[EditingObject[playerid]][objCreate]);
	// 	            SendClientMessageEx(playerid, COLOR_ARWIN, "OBJECT: {FFFFFF}You're Editing Created object %d with Move Object", EditingObject[playerid]);
	// 			}
	// 			case 1:
	// 			{
	// 				new stringg[512];
	// 				format(stringg, sizeof(stringg), "Offset X (%f)\nOffset Y (%f)\nOffset Z (%f)\nRotation X (%f)\nRotation Y (%f)\nRotation Z (%f)",
	//    				ObjectData[EditingObject[playerid]][objPos][0],
	// 			    ObjectData[EditingObject[playerid]][objPos][1],
	// 			    ObjectData[EditingObject[playerid]][objPos][2],
	//    				ObjectData[EditingObject[playerid]][objPos][3],
	// 			    ObjectData[EditingObject[playerid]][objPos][4],
	// 			    ObjectData[EditingObject[playerid]][objPos][5]
	// 				);
	// 				ShowPlayerDialog(playerid, DIALOG_COORD, DIALOG_STYLE_LIST, "Editing Object", stringg, "Select", "Cancel");
	// 			}
	// 			case 2:
	// 			{
	// 				ShowPlayerDialog(playerid, DIALOG_CHANGEMODELOB, DIALOG_STYLE_INPUT, "Change Object", "Masukan ID object yang mau anda ubah", "Select", "Cancel");
	// 			}
	// 			case 3:
	// 			{
	// 				Object_Delete(EditingObject[playerid]);
	// 				SendClientMessageEx(playerid, COLOR_ARWIN, "OBJECT: {FFFFFF}You have successfully destroyed Created Object ID: %d.", EditingObject[playerid]);
	// 			}
	// 		}
	// 	}
	// }
	// if(dialogid == DIALOG_CHANGEMODELOB)
	// {
	//     if(response)
	//     {
	// 		ObjectData[EditingObject[playerid]][objModel] = strval(inputtext);
	// 		SendClientMessageEx(playerid, COLOR_ARWIN, "OBJECT: {FFFFFF}Successfully Changed Model of Created Object ID %d", strval(inputtext));
	// 		Object_Refresh(EditingObject[playerid]);
	// 		Object_Save(EditingObject[playerid]);
	// 	}	
	// }	
	if(dialogid == DIALOG_RENTVEH)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new modelid = 462;
					new tstr[128];
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$75.00 / hours", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENTVEH_CONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
				}
				case 1:
				{
					new modelid = 481;
					new tstr[128];
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$50.00 / hours", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENTVEH_CONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
				}
				case 2:
				{
					new modelid = 509;
					new tstr[128];
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$50.00 / hours", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENTVEH_CONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
				}
			}
		}
	}
	if(dialogid == DIALOG_JOBSVEH)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new modelid = 438;
					new tstr[128];
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$75.00 / hours", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENTVEH_CONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
				}
				case 1:
				{
					new modelid = 420;
					new tstr[128];
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$50.00 / hours", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENTVEH_CONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
				}
				case 2:
				{
					new modelid = 422;
					new tstr[128];
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$50.00 / hours", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENTVEH_CONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
				}
				case 3:
				{
					new modelid = 543;
					new tstr[128];
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$50.00 / hours", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENTVEH_CONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
				}
				case 4:
				{
					new modelid = 499;
					new tstr[128];
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$50.00 / hours", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENTVEH_CONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
				}
			}
		}
	}
	if(dialogid == DIALOG_BOATVEH)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new modelid = 473;
					new tstr[128];
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$75.00 / hours", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENTVEH_CONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
					
				}
				case 1:
				{
					new modelid = 453;
					new tstr[128];
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$50.00 / hours", GetVehicleModelName(modelid));
					ShowPlayerDialog(playerid, DIALOG_RENTVEH_CONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
				}
			}
		}
	}
	if(dialogid == DIALOG_RENTVEH_CONFIRM)
	{
		new modelid = pData[playerid][pBuyPvModel];
		new id = pData[playerid][pRentData];
		if(response)
		{
			if(rentData[id][rRX] != 0.0)
	    	{
				if(modelid <= 0) return Error(playerid, "Invalid model id.");
				new cost = 0;
				if(modelid == 462)
				{
					cost = 7500;
				}
				else if(modelid == 481)
				{
					cost = 5000;
				}
				else if(modelid == 509)
				{
					cost = 5000;
				}
				else if(modelid == 483)
				{
					cost = 5000;
				}
				else if(modelid == 420)
				{
					cost = 7500;
				}
				else if(modelid == 422)
				{
					cost = 7000;
				}
				else if(modelid == 543)
				{
					cost = 7000;
				}
				else if(modelid == 499)
				{
					cost = 7500;
				}
				else if(modelid == 473)
				{
					cost = 4500;
				}
				else if(modelid == 453)
				{
					cost = 5000;
				}
				if(pData[playerid][pMoney] < cost)
				{
					Error(playerid, "Uang anda tidak mencukupi.!");
					return 1;
				}
				new count = 0, limit = MAX_PLAYER_VEHICLE + pData[playerid][pVip];
				foreach(new ii : PVehicles)
				{
					if(pvData[ii][cOwner] == pData[playerid][pID] && pvData[ii][cClaim] != 1)
						count++;
				}
				if(count >= limit)
				{
					Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
					return 1;
				}
				GivePlayerMoneyEx(playerid, -cost);
				new cQuery[1024];
				new Float:x,Float:y,Float:z, Float:a;
				new model, color1, color2, rental;
				color1 = 0;
				color2 = 0;
				model = modelid;
				x = rentData[id][rRX];
				y = rentData[id][rRY];
				z = rentData[id][rRZ];
				a = rentData[id][rRA];
				rental = gettime() + (1 * 86400);
				mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`, `rental`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f', '%d')", pData[playerid][pID], model, color1, color2, cost, x, y, z, a, rental);
				mysql_tquery(g_SQL, cQuery, "OnVehRentPV", "ddddddffffd", playerid, pData[playerid][pID], model, color1, color2, cost, x, y, z, a, rental);
				return 1;
			}
			else return Error(playerid, "Titik spawn belum di buat");	
		}
		else
		{
			pData[playerid][pBuyPvModel] = 0;
		}
	}
	if(dialogid == DIALOG_TOGAUTO)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					if(pData[playerid][pTogPaycheck] == 0)
					{
						pData[playerid][pTogPaycheck] = 1;
						SendClientMessageEx(playerid, COLOR_ARWIN, "SETTING: "WHITE_E"Automatic Paycheck claiming has been "GREEN_E"enable");
						return callcmd::togauto(playerid, "");
					}
					else
					{
						pData[playerid][pTogPaycheck] = 0;	
						SendClientMessageEx(playerid, COLOR_ARWIN, "SETTING: "WHITE_E"Automatic Paycheck claiming has been "RED_E"disable");
						return callcmd::togauto(playerid, "");
					}
				}
				case 1:
				{
					if(pData[playerid][pTogSealtbelt] == 0)
					{
						pData[playerid][pTogSealtbelt] = 1;
						SendClientMessageEx(playerid, COLOR_ARWIN, "SETTING: "WHITE_E"Automatic car seatbelt has been "GREEN_E"enable");
						return callcmd::togauto(playerid, "");
					}
					else
					{
						pData[playerid][pTogSealtbelt] = 0;	
						SendClientMessageEx(playerid, COLOR_ARWIN, "SETTING: "WHITE_E"Automatic car seatbelt has been "RED_E"disable");
						return callcmd::togauto(playerid, "");
					}
				}
				case 2:
				{
					if(pData[playerid][pTogHelmet] == 0)
					{
						pData[playerid][pTogHelmet] = 1;
						SendClientMessageEx(playerid, COLOR_ARWIN, "SETTING: "WHITE_E"Automatic wear/remove motorclycle Helmet has been "GREEN_E"enable");
						return callcmd::togauto(playerid, "");
					}
					else
					{
						pData[playerid][pTogHelmet] = 0;	
						SendClientMessageEx(playerid, COLOR_ARWIN, "SETTING: "WHITE_E"Automatic wear/remove motorclycle Helmet has been "RED_E"disable");
						return callcmd::togauto(playerid, "");
					}
				}
				case 3:
				{
					if(pData[playerid][pTogChat] == 0)
					{
						pData[playerid][pTogChat] = 1;
						SendClientMessageEx(playerid, COLOR_ARWIN, "SETTING: "WHITE_E"Automatic Upper-case first leter of chat "GREEN_E"enable");
						return callcmd::togauto(playerid, "");
					}
					else
					{
						pData[playerid][pTogChat] = 0;	
						SendClientMessageEx(playerid, COLOR_ARWIN, "SETTING: "WHITE_E"Automatic Upper-case first leter of chat "RED_E"disable");
						return callcmd::togauto(playerid, "");
					}
				}
				case 4:
				{
					if(pData[playerid][pTogMask] == 0)
					{
						pData[playerid][pTogMask] = 1;
						SendClientMessageEx(playerid, COLOR_ARWIN, "SETTING: "WHITE_E"Automatic Nametag masking on login has been "GREEN_E"enable");
						return callcmd::togauto(playerid, "");
					}
					else
					{
						pData[playerid][pTogMask] = 0;	
						SendClientMessageEx(playerid, COLOR_ARWIN, "SETTING: "WHITE_E"Automatic Nametag masking on login has been "RED_E"disable");
						return callcmd::togauto(playerid, "");
					}
				}
				case 5:
				{
					if(pData[playerid][pTogAmmo] == 0)
					{
						pData[playerid][pTogAmmo] = 1;
						SendClientMessageEx(playerid, COLOR_ARWIN, "SETTING: "WHITE_E"Toggle TD Ammo has been "GREEN_E"enable");
						return callcmd::togauto(playerid, "");
					}
					else
					{
						pData[playerid][pTogAmmo] = 0;	
						SendClientMessageEx(playerid, COLOR_ARWIN, "SETTING: "WHITE_E"Toggle TD Ammo has been "RED_E"disable");
						return callcmd::togauto(playerid, "");
					}
				}
			}
		}
	}		
	if(dialogid == DIALOG_SELLPLANT)
	{
		if(response)
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
				if(!IsValidVehicle(vehicleid)) return Error(playerid, "You're not in any vehicle.");
				foreach(new pv : PVehicles)
				{
					if(vehicleid == pvData[pv][cVeh])
					{
						if(pvData[pv][cWheat] > 0)
						{
							StockPlant += pvData[pv][cWheat];
							new cash = pvData[pv][cWheat] * HargaAnggur;
							new list[212];
							format(list, sizeof(list), "Sold %d units of wheat", pvData[pv][cWheat]);
							AddPlayerSalary(playerid, "Farmer Storage Co", list, cash);
							SendClientMessageEx(playerid, COLOR_ARWIN, "PLANTINFO: {FFFFFF}You've sold "YELLOW_E"%d "WHITE_E"units of "YELLOW_E"Wheat "WHITE_E"for "GREEN_E"$%s", pvData[pv][cWheat], FormatMoney(pvData[pv][cWheat]*(HargaAnggur)));
							pvData[pv][cWheat] = 0;
							if(IsValidDynamicObject(ObjectVehicle[pvData[pv][cVeh]][2]))
							{
								DestroyDynamicObject(ObjectVehicle[pvData[pv][cVeh]][2]);
							}
							TextDrawHideForPlayer(playerid, Crate[0]);
							TextDrawHideForPlayer(playerid, Crate[1]);
							PlayerTextDrawHide(playerid, PlayerCrate[playerid]);
							ammountsellwheat++;
						}
						else if(pvData[pv][cOnion] > 0)
						{
							StockPlant += pvData[pv][cOnion];
							new cash = pvData[pv][cOnion] * HargaBlueberry;
							new list[212];
							format(list, sizeof(list), "Sold %d units of wheat", pvData[pv][cOnion]);
							AddPlayerSalary(playerid, "Farmer Storage Co", list, cash);
							SendClientMessageEx(playerid, COLOR_ARWIN, "PLANTINFO: {FFFFFF}You've sold "YELLOW_E"%d "WHITE_E"units of "YELLOW_E"Onion "WHITE_E"for "GREEN_E"$%s", pvData[pv][cOnion], FormatMoney(pvData[pv][cOnion]*(HargaBlueberry)));
							pvData[pv][cOnion] = 0;
							if(IsValidDynamicObject(ObjectVehicle[pvData[pv][cVeh]][2]))
							{
								DestroyDynamicObject(ObjectVehicle[pvData[pv][cVeh]][2]);
							}
							TextDrawHideForPlayer(playerid, Crate[0]);
							TextDrawHideForPlayer(playerid, Crate[1]);
							PlayerTextDrawHide(playerid, PlayerCrate[playerid]);
							ammountsellonion++;
						}
						else if(pvData[pv][cCarrot] > 0)
						{
							StockPlant += pvData[pv][cCarrot];
							new cash = pvData[pv][cCarrot] * HargaStrawberry;
							new list[212];
							format(list, sizeof(list), "Sold %d units of wheat", pvData[pv][cCarrot]);
							AddPlayerSalary(playerid, "Farmer Storage Co", list, cash);
							SendClientMessageEx(playerid, COLOR_ARWIN, "PLANTINFO: {FFFFFF}You've sold "YELLOW_E"%d "WHITE_E"units of "YELLOW_E"Carrot "WHITE_E"for "GREEN_E"$%s", pvData[pv][cCarrot], FormatMoney(pvData[pv][cCarrot]*(HargaStrawberry)));
							pvData[pv][cCarrot] = 0;
							if(IsValidDynamicObject(ObjectVehicle[pvData[pv][cVeh]][2]))
							{
								DestroyDynamicObject(ObjectVehicle[pvData[pv][cVeh]][2]);
							}
							TextDrawHideForPlayer(playerid, Crate[0]);
							TextDrawHideForPlayer(playerid, Crate[1]);
							PlayerTextDrawHide(playerid, PlayerCrate[playerid]);
							ammountsellcarrot++;
						}
						else if(pvData[pv][cPotato] > 0)
						{
							StockPlant += pvData[pv][cPotato];
							new cash = pvData[pv][cPotato] * HargaGandum;
							new list[212];
							format(list, sizeof(list), "Sold %d units of wheat", pvData[pv][cPotato]);
							AddPlayerSalary(playerid, "Farmer Storage Co", list, cash);
							SendClientMessageEx(playerid, COLOR_ARWIN, "PLANTINFO: {FFFFFF}You've sold "YELLOW_E"%d "WHITE_E"units of "YELLOW_E"Potato "WHITE_E"for "GREEN_E"$%s", pvData[pv][cPotato], FormatMoney(pvData[pv][cPotato]*(HargaGandum)));
							pvData[pv][cPotato] = 0;
							if(IsValidDynamicObject(ObjectVehicle[pvData[pv][cVeh]][2]))
							{
								DestroyDynamicObject(ObjectVehicle[pvData[pv][cVeh]][2]);
							}
							TextDrawHideForPlayer(playerid, Crate[0]);
							TextDrawHideForPlayer(playerid, Crate[1]);
							PlayerTextDrawHide(playerid, PlayerCrate[playerid]);
							ammountsellpotato++;
						}
						else if(pvData[pv][cCorn] > 0)
						{
							StockPlant += pvData[pv][cCorn];
							new cash = pvData[pv][cCorn] * HargaTomat;
							new list[212];
							format(list, sizeof(list), "Sold %d units of wheat", pvData[pv][cCorn]);
							AddPlayerSalary(playerid, "Farmer Storage Co", list, cash);
							SendClientMessageEx(playerid, COLOR_ARWIN, "PLANTINFO: {FFFFFF}You've sold "YELLOW_E"%d "WHITE_E"units of "YELLOW_E"Corn "WHITE_E"for "GREEN_E"$%s", pvData[pv][cCorn], FormatMoney(pvData[pv][cCorn]*(HargaTomat)));
							pvData[pv][cCorn] = 0;
							if(IsValidDynamicObject(ObjectVehicle[pvData[pv][cVeh]][2]))
							{
								DestroyDynamicObject(ObjectVehicle[pvData[pv][cVeh]][2]);
							}
							TextDrawHideForPlayer(playerid, Crate[0]);
							TextDrawHideForPlayer(playerid, Crate[1]);
							PlayerTextDrawHide(playerid, PlayerCrate[playerid]);
							ammountsellcorn++;
						}
					}
				}			
			}
			else
			{
				if(pData[playerid][pWheat] > 0)
				{
					StockPlant += pData[playerid][pWheat];
					new cash = pData[playerid][pWheat] * HargaAnggur;
					new list[212];
					format(list, sizeof(list), "Sold %d units of wheat", pData[playerid][pWheat]);
					AddPlayerSalary(playerid, "Farmer Storage Co", list, cash);
					SendClientMessageEx(playerid, COLOR_ARWIN, "PLANTINFO: {FFFFFF}You've sold "YELLOW_E"%d "WHITE_E"units of "YELLOW_E"Wheat "WHITE_E"for "GREEN_E"$%s", pData[playerid][pWheat], FormatMoney(pData[playerid][pWheat]*(HargaAnggur)));
					pData[playerid][pWheat] = 0;
					ammountsellwheat++;
				}
				else if(pData[playerid][pOnion] > 0)
				{
					StockPlant += pData[playerid][pOnion];
					new cash = pData[playerid][pOnion] * HargaBlueberry;
					new list[212];
					format(list, sizeof(list), "Sold %d units of onion", pData[playerid][pOnion]);
					AddPlayerSalary(playerid, "Farmer Storage Co", list, cash);
					SendClientMessageEx(playerid, COLOR_ARWIN, "PLANTINFO: {FFFFFF}You've sold "YELLOW_E"%d "WHITE_E"units of "YELLOW_E"Onion "WHITE_E"for "GREEN_E"$%s", pData[playerid][pOnion], FormatMoney(pData[playerid][pOnion]*HargaBlueberry));
					pData[playerid][pOnion] = 0;
					ammountsellonion++;
				}
				else if(pData[playerid][pCarrot] > 0)
				{
					StockPlant += pData[playerid][pCarrot];
					new cash = pData[playerid][pCarrot] * HargaStrawberry;
					new list[212];
					format(list, sizeof(list), "Sold %d units of Carrot", pData[playerid][pCarrot]);
					AddPlayerSalary(playerid, "Farmer Storage Co", list, cash);
					SendClientMessageEx(playerid, COLOR_ARWIN, "PLANTINFO: {FFFFFF}You've sold "YELLOW_E"%d "WHITE_E"units of "YELLOW_E"Carrot "WHITE_E"for "GREEN_E"$%s", pData[playerid][pCarrot], FormatMoney(pData[playerid][pCarrot]*HargaStrawberry));
					pData[playerid][pCarrot] = 0;
					ammountsellcarrot++;
				}
				else if(pData[playerid][pPotato] > 0)
				{
					StockPlant += pData[playerid][pPotato];
					new cash = pData[playerid][pPotato] * HargaGandum;
					new list[212];
					format(list, sizeof(list), "Sold %d units of Potato", pData[playerid][pPotato]);
					AddPlayerSalary(playerid, "Farmer Storage Co", list, cash);
					SendClientMessageEx(playerid, COLOR_ARWIN, "PLANTINFO: {FFFFFF}You've sold "YELLOW_E"%d "WHITE_E"units of "YELLOW_E"Potato "WHITE_E"for "GREEN_E"$%s", pData[playerid][pPotato], FormatMoney(pData[playerid][pPotato]*HargaGandum));
					pData[playerid][pPotato] = 0;
					ammountsellpotato++;
				}
				else if(pData[playerid][pCorn] > 0)
				{
					StockPlant += pData[playerid][pCorn];
					new cash = pData[playerid][pCorn] * HargaTomat;
					new list[212];
					format(list, sizeof(list), "Sold %d units of Corn", pData[playerid][pCorn]);
					AddPlayerSalary(playerid, "Farmer Storage Co", list, cash);
					SendClientMessageEx(playerid, COLOR_ARWIN, "PLANTINFO: {FFFFFF}You've sold "YELLOW_E"%d "WHITE_E"units of "YELLOW_E"Corn "WHITE_E"for "GREEN_E"$%s", pData[playerid][pCorn], FormatMoney(pData[playerid][pCorn]*HargaTomat));
					pData[playerid][pCorn] = 0;
					ammountsellcorn++;
				}
			}
			
		}
	}
	if (dialogid == DIALOG_ADDFURNOBJECT) {
        if (response)
        {           
            new id = FurnObject_Add(playerid, strval(inputtext), ManageFurnStore[playerid]);

            if(id == cellmin)
                return Error(playerid, "Furniture object untuk furniture store ini sudah mencapai batas maksimal.");

            ManageFurnObject[playerid] = id;
            Dialog_Show(playerid, ManageFurnObject, DIALOG_STYLE_LIST, "Manage Object", "Produce\nMove\nSet Name\nSet Price\nTexture\nDelete", "Select", "Close");

            Servers(playerid, "Object baru telah di buat, silahkan untuk memposisikan object dengan benar Menyalah gunakan akan mendapat sanksi berupa BANNED 3 hari.", 5000);
        } else FurnObject_Category(playerid);
    }
	return 1;
}
