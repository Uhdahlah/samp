// Anti DDOS
stock strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}

stock split(const strsrc[], strdest[][], delimiter)
{
	new i, li;
	new aNum;
	new len;
	while(i <= strlen(strsrc)){
		if(strsrc[i]==delimiter || i==strlen(strsrc)){
			len = strmid(strdest[aNum], strsrc, li, i, 128);
			strdest[aNum][len] = 0;
			li = i+1;
			aNum++;
		}
		i++;
	}
	return 1;
}

stock GetHealth(playerid)
{
	new Float:health;
	GetPlayerHealth(playerid, health);
	return floatround(health);
}

stock GetArmor(playerid)
{
	new Float:armor;
 	GetPlayerArmour(playerid, armor);
	return floatround(armor);
}

stock GenerateRandomPlate() {
	new string[32], rand[3];

	rand[0] = random(sizeof(PlatePossible));
	rand[1] = random(sizeof(PlatePossible));
	rand[2] = random(sizeof(PlatePossible));

	format(string, 32, "AZ %d%d%d%d %s%s%s", random(9), random(9), random(9), random(9), PlatePossible[rand[0]], PlatePossible[rand[1]], PlatePossible[rand[2]]);

	return string;
}

stock GenerateRandomVIP() {
	new string[52], rand[3];

	rand[0] = random(sizeof(PlatePossible));
	rand[1] = random(sizeof(PlatePossible));
	rand[2] = random(sizeof(PlatePossible));

	format(string, 52, "MRP%d%s%s%s%d%d%d", random(9), PlatePossible[rand[0]], PlatePossible[rand[1]], PlatePossible[rand[2]], random(9), random(9), random(9));

	return string;
}

FormatText(text[])
{
	new len = strlen(text);
	if(len > 1)
	{
		for(new i = 0; i < len; i++)
		{
			if(text[i] == 92)
			{
				// New line
			    if(text[i+1] == 'n')
			    {
					text[i] = '\n';
					for(new j = i+1; j < len; j++) text[j] = text[j+1], text[j+1] = 0;
					continue;
			    }

				// Tab
			    if(text[i+1] == 't')
			    {
					text[i] = '\t';
					for(new j = i+1; j < len-1; j++) text[j] = text[j+1], text[j+1] = 0;
					continue;
			    }

				// Literal
			    if(text[i+1] == 92)
			    {
					text[i] = 92;
					for(new j = i+1; j < len-1; j++) text[j] = text[j+1], text[j+1] = 0;
			    }
			}
		}
	}
	return 1;
}

stock getword(const input[], wordnum, output[], size = sizeof(output))
{
    new
        i,
        wordcount = 0,
        start = 0,
        end = 0;

    for (i = 0; i < strlen(input); i++)
    {
        if (input[i] == ' ')
        {
            wordcount++;
            if (wordcount == wordnum)
            {
                start = end + 1;
                end = i;
            }
            else if (wordcount == wordnum + 1)
            {
                end = i;
                break;
            }
        }
    }

    if (wordcount < wordnum)
    {
        return 0;
    }

    new len = end - start;
    if (len >= size)
    {
        len = size - 1;
    }

    for (i = 0; i < len; i++)
    {
        output[i] = input[start + i];
    }

    output[len] = '\0';
    return 1;
}

stock experieddate( timestamp, _form=0 )
{
    /*
        date( 1247182451 )  will print >> 09.07.2009-23:34:11
        date( 1247182451, 1) will print >> 09/07/2009, 23:34:11
        date( 1247182451, 2) will print >> July 09, 2009, 23:34:11
        date( 1247182451, 3) will print >> 9 Jul 2009, 23:34
    */
    new year=1970, day=0, month=0, hourt=0, mins=0, sec=0;

    new days_of_month[12] = { 31,28,31,30,31,30,31,31,30,31,30,31 };
    new names_of_month[12][10] = {"January","February","March","April","May","June","July","August","September","October","November","December"};
    new returnstring[500];

    while(timestamp>31622400){
        timestamp -= 31536000;
        if ( ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0) ) timestamp -= 86400;
        year++;
    }

    if ( ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0) )
        days_of_month[1] = 29;
    else
        days_of_month[1] = 28;


    while(timestamp>86400){
        timestamp -= 86400, day++;
        if(day==days_of_month[month]) day=0, month++;
    }

    while(timestamp>60){
        timestamp -= 60, mins++;
        if( mins == 60) mins=0, hourt++;
    }

    sec=timestamp;

    switch( _form ){
        case 1: format(returnstring, 500, ""WHITE_E"["GREEN_E"Valid until %02d/%02d/%d"WHITE_E"]", day+1, month+1, year);
        case 2: format(returnstring, 500, ""WHITE_E"["ORANGE_E"Expired since %02d/%02d/%d"WHITE_E"]", day+1, month+1, year);
        case 3: format(returnstring, 500, "%d %c%c%c %d, %02d:%02d", day+1,names_of_month[month][0],names_of_month[month][1],names_of_month[month][2], year,hourt,mins);
		case 4: format(returnstring, 500, "%s %02d, %d", names_of_month[month],day+1,year);
        default: format(returnstring, 500, "%02d.%02d.%d-%02d:%02d:%02d", day+1, month+1, year, hourt, mins, sec);
    }

    return returnstring;
}

stock SendDiscordMessage(channel, message[]) {
	new DCC_Channel:ChannelId;
	switch(channel)
	{
		//==[ Log Join & Leave ]
		case 0:
		{
			ChannelId = DCC_FindChannelById("961533528779149323");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
		//==[ Log Command ]
		case 1:
		{
			ChannelId = DCC_FindChannelById("961533528779149323");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
		//==[ Log Chat IC ]
		case 2:
		{
			ChannelId = DCC_FindChannelById("961533528779149323");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
		//==[ Warning & Banned ]
		case 3:
		{
			ChannelId = DCC_FindChannelById("973840302253158450");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
		//==[ Log Death ]
		case 4:
		{
			ChannelId = DCC_FindChannelById("973840302253158450");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
		//==[ Ucp ]
		case 5:
		{
			ChannelId = DCC_FindChannelById("973840302253158450");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
		case 6://Korup
		{
			ChannelId = DCC_FindChannelById("961533528779149323");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
		case 7://Register
		{
			ChannelId = DCC_FindChannelById("973840302253158450");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
		case 8://Bot Admin
		{
			ChannelId = DCC_FindChannelById("961533528779149323");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
	}
	return 1;
}
stock StopStream(playerid)
{
	DeletePVar(playerid, "pAudioStream");
    StopAudioStreamForPlayer(playerid);
}

stock PlayStream(playerid, url[], Float:posX = 0.0, Float:posY = 0.0, Float:posZ = 0.0, Float:distance = 50.0, usepos = 0)
{
	if(GetPVarType(playerid, "pAudioStream")) StopAudioStreamForPlayer(playerid);
	else SetPVarInt(playerid, "pAudioStream", 1);
    PlayAudioStreamForPlayer(playerid, url, posX, posY, posZ, distance, usepos);
}

stock PickUpBoombox(playerid)
{
    foreach(new i : Player)
	{
 		if(IsPlayerInDynamicArea(i, GetPVarInt(playerid, "BBArea")))
   		{
     		StopStream(i);
		}
	}
	DeletePVar(playerid, "BBArea");
	DestroyDynamicObject(GetPVarInt(playerid, "PlacedBB"));
	DestroyDynamic3DTextLabel(Text3D:GetPVarInt(playerid, "BBLabel"));
	DeletePVar(playerid, "PlacedBB"); DeletePVar(playerid, "BBLabel");
 	DeletePVar(playerid, "BBX"); DeletePVar(playerid, "BBY"); DeletePVar(playerid, "BBZ");
	DeletePVar(playerid, "BBInt");
	DeletePVar(playerid, "BBVW");
	DeletePVar(playerid, "BBStation");
	return 1;
}

stock SetVehicleSpeedTT(vehicleid, Float:speed)
{
    new Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2, Float:a;
    GetVehicleVelocity(vehicleid, x1, y1, z1);
    GetVehiclePos(vehicleid, x2, y2, z2);
    GetVehicleZAngle(vehicleid, a); a = 360 - a;
    x1 = (floatsin(a, degrees) * (speed/100) + floatcos(a, degrees) * 0 + x2) - x2;
    y1 = (floatcos(a, degrees) * (speed/100) + floatsin(a, degrees) * 0 + y2) - y2;
    SetVehicleVelocity(vehicleid, x1, y1, z1);
}

stock DisablePlayerGPS(playerid)
{
	if(GetPlayerGPSInfo(playerid, G_ENABLED) == GPS_STATUS_ON)
	{
		DisablePlayerCheckpoint(playerid);

		SetPlayerGPSInfo(playerid, G_ENABLED, GPS_STATUS_OFF);
	}
	return 1;
}

stock EnablePlayerGPS(playerid, Float: x, Float: y, Float: z, message[] = "Lokasi ditandai pada GPS Anda")
{
	SetPlayerGPSInfo(playerid, G_POS_X, x);
	SetPlayerGPSInfo(playerid, G_POS_Y, y);
	SetPlayerGPSInfo(playerid, G_POS_Z, z);

	SetPlayerCheckpoint(playerid, x, y, z, 3.0);

	if(strlen(message))
		SendClientMessage(playerid, 0xFFFF00FF, message);

	SetPlayerGPSInfo(playerid, G_ENABLED, GPS_STATUS_ON);

	return 1;
}

stock PositionToPoint(Float:radi, Float:posx, Float:posy, Float:posz, Float:pointx, Float:pointy, Float:pointz)
{
	new Float:tempposx, Float:tempposy, Float:tempposz;
	tempposx = (posx -pointx);
	tempposy = (posy -pointy);
	tempposz = (posz -pointz);
	//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
	if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
	{
		return 1;
	}
	return 0;
}

stock ORANK(playerid)
{
	new name[32];
	if(pData[playerid][pLevel] == 1) format(name, sizeof(name), "New Player");
	else if(pData[playerid][pLevel] == 2) format(name, sizeof(name), "Regular Player");
	else if(pData[playerid][pLevel] == 3) format(name, sizeof(name), "Junior Player");
	else if(pData[playerid][pLevel] == 4) format(name, sizeof(name), "Second Player");
	else if(pData[playerid][pLevel] == 5) format(name, sizeof(name), "Senior Player");
	else if(pData[playerid][pLevel] == 6) format(name, sizeof(name), "Big Slave");
	else if(pData[playerid][pLevel] == 7) format(name, sizeof(name), "Royal Slave");
	else if(pData[playerid][pLevel] == 8) format(name, sizeof(name), "Perfect Slave");
	else if(pData[playerid][pLevel] == 9) format(name, sizeof(name), "Get a Life");
	else if(pData[playerid][pLevel] == 10) format(name, sizeof(name), "Take a Life");
	else if(pData[playerid][pLevel] == 11) format(name, sizeof(name), "9 Life");
	else if(pData[playerid][pLevel] == 12) format(name, sizeof(name), "Big Ranked");
	else if(pData[playerid][pLevel] == 13) format(name, sizeof(name), "High Ranked");
	else if(pData[playerid][pLevel] == 14) format(name, sizeof(name), "Big Roller");
	else if(pData[playerid][pLevel] == 15) format(name, sizeof(name), "High Roller");
	else if(pData[playerid][pLevel] == 16) format(name, sizeof(name), "Get a Roller");
	else if(pData[playerid][pLevel] == 17) format(name, sizeof(name), "9 Life Roller");
	else if(pData[playerid][pLevel] == 18) format(name, sizeof(name), "Loyal Player");
	else if(pData[playerid][pLevel] == 19) format(name, sizeof(name), "Perfect Player");
	else if(pData[playerid][pLevel] == 20) format(name, sizeof(name), "Legend Of Player");
	else if(pData[playerid][pLevel] == 21) format(name, sizeof(name), "Level 21");
	else if(pData[playerid][pLevel] == 22) format(name, sizeof(name), "Level 22");
	else if(pData[playerid][pLevel] == 23) format(name, sizeof(name), "Level 23");
	else if(pData[playerid][pLevel] == 24) format(name, sizeof(name), "Level 24");
	else if(pData[playerid][pLevel] == 25) format(name, sizeof(name), "Level 25");
	else if(pData[playerid][pLevel] == 26) format(name, sizeof(name), "Level 26");
	else if(pData[playerid][pLevel] == 27) format(name, sizeof(name), "Level 27");
	else if(pData[playerid][pLevel] == 28) format(name, sizeof(name), "Level 28");
	else if(pData[playerid][pLevel] == 29) format(name, sizeof(name), "Level 29");
	else if(pData[playerid][pLevel] == 30) format(name, sizeof(name), "Level 30");
	else if(pData[playerid][pLevel] == 31) format(name, sizeof(name), "Level 31");
	else if(pData[playerid][pLevel] == 32) format(name, sizeof(name), "Level 32");
	else if(pData[playerid][pLevel] == 33) format(name, sizeof(name), "Level 33");
	else if(pData[playerid][pLevel] == 34) format(name, sizeof(name), "Level 34");
	else if(pData[playerid][pLevel] == 35) format(name, sizeof(name), "Level 35");
	return name;
}

stock SendClientAdm(color,String[],level)
{
	foreach(new i : Player)
	{
		if(pData[i][pAdmin] >= level)
		{
			SendClientMessageEx(i, color, String);
		}
	}
	return 1;
}

stock IsPlayerInRangeOfPlayer(playerid, playerid2, Float: radius)
{

	new
		Float:Floats[3];

	GetPlayerPos(playerid2, Floats[0], Floats[1], Floats[2]);
	return IsPlayerInRangeOfPoint(playerid, radius, Floats[0], Floats[1], Floats[2]);
}

stock IsACBUGWeapon(playerid)
{
	if (IsPlayerConnected(playerid))
	{
	    new wID = GetPlayerWeapon ( playerid ) ;
	    if (wID == 24 || wID == 25 || wID == 27 || wID == 34 ) return 1 ;
	}
	return 0 ;
}

stock PlayerSpeed(playerid)
{
    new Float:ST[4];
    if(IsPlayerInAnyVehicle(playerid))
    GetVehicleVelocity(GetPlayerVehicleID(playerid),ST[0],ST[1],ST[2]);
    else GetPlayerVelocity(playerid,ST[0],ST[1],ST[2]);
    ST[3] = floatsqroot(floatpower(floatabs(ST[0]), 2.0) + floatpower(floatabs(ST[1]), 2.0) + floatpower(floatabs(ST[2]), 2.0)) * 179.28625;
    return floatround(ST[3]);
}

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
    0x706C67FF, 0x3B3E42FF, 0x2E2D33FF, 0x7B7E7DFF, 0x4A4442FF, 0x28344EFF, 0x33FF0000
};

stock ReturnVehicleModelID(string[])
{

	if(IsNumeric(string))
	{
		new id = strval(string);

		if(id >= 400 && id <= 611)
		{
		    return id;
		}
	}

	for(new i = 0;i < sizeof(vehName);i++)
    {
        if(strfind(vehName[i],string,true) != -1)
        {
            return i + 400;
        }
    }

    return 0;
}

stock SetPlayerJoinCamera(playerid)
{
	new randcamera = RandomEx(1,9);
	switch(randcamera)
	{
		case 1: // Gym
		{
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerInterior(playerid, 0);
			Streamer_UpdateEx(playerid,2229.4968,-1722.0701,13.5625);
			SetPlayerPos(playerid,2211.1460,-1748.3909,-10.0);
			SetPlayerCameraPos(playerid,2211.1460,-1748.3909,29.3744);
			SetPlayerCameraLookAt(playerid,2229.4968,-1722.0701,13.5625);
		}
		case 2: // Paintball Arena
		{
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerInterior(playerid, 0);
			Streamer_UpdateEx(playerid,1295.6960,-1422.5111,14.9596);
			SetPlayerPos(playerid,1283.8524,-1385.5304,-10.0);
			SetPlayerCameraPos(playerid,1283.8524,-1385.5304,25.8896);
			SetPlayerCameraLookAt(playerid,1295.6960,-1422.5111,14.9596);
		}
		case 3: // LSPD
		{
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerInterior(playerid, 0);
			Streamer_UpdateEx(playerid,1554.3381,-1675.5692,16.1953);
			SetPlayerPos(playerid,1514.7783,-1700.2913,-10.0);
			SetPlayerCameraPos(playerid,1514.7783,-1700.2913,36.7506);
			SetPlayerCameraLookAt(playerid,1554.3381,-1675.5692,16.1953);
		}
		case 4: // SaC HQ (Gang HQ)
		{
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerInterior(playerid, 0);
			Streamer_UpdateEx(playerid,655.5394,-1867.2231,5.4609);
			SetPlayerPos(playerid,655.5394,-1867.2231,-10.0);
			SetPlayerCameraPos(playerid,699.7435,-1936.7568,24.8646);
			SetPlayerCameraLookAt(playerid,655.5394,-1867.2231,5.4609);

		}
		case 5: // Fishing Pier
		{
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerInterior(playerid, 0);
			Streamer_UpdateEx(playerid,370.0804,-2087.8767,7.8359);
			SetPlayerPos(playerid,370.0804,-2087.8767,-10.0);
			SetPlayerCameraPos(playerid,423.3802,-2067.7915,29.8605);
			SetPlayerCameraLookAt(playerid,370.0804,-2087.8767,7.8359);
		}
		case 6: // VIP
		{
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerInterior(playerid, 0);
			Streamer_UpdateEx(playerid,1797.3397,-1578.3440,14.0798);
			SetPlayerPos(playerid,1797.3397,-1578.3440,-10.0);
			SetPlayerCameraPos(playerid,1832.1698,-1600.1538,32.2877);
			SetPlayerCameraLookAt(playerid,1797.3397,-1578.3440,14.0798);
		}
		case 7: // All Saints
		{
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerInterior(playerid, 0);
			Streamer_UpdateEx(playerid,1175.5581,-1324.7922,18.1610);
			SetPlayerPos(playerid, 1188.4574,-1309.2242,-10.0);
			SetPlayerCameraPos(playerid,1188.4574,-1309.2242,13.5625+6.0);
			SetPlayerCameraLookAt(playerid,1175.5581,-1324.7922,18.1610);
		}
		case 8: // Unity
		{
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerInterior(playerid, 0);
			Streamer_UpdateEx(playerid,1716.1129,-1880.0715,22.0264);
			SetPlayerPos(playerid,1716.1129,-1880.0715,-10.0);
			SetPlayerCameraPos(playerid,1755.0413,-1824.8710,20.2100);
			SetPlayerCameraLookAt(playerid,1716.1129,-1880.0715,22.0264);
		}
	}
	return 1;
}
