new DCC_Channel:PanelWhitelist;
new DCC_Channel:referralcode;
new DCC_Channel:referralreddem;
new DCC_Channel:activecs;
new DCC_Channel:banneducp;
new DCC_Channel:bannedchar;
new DCC_Channel:VIP;
new DCC_Channel:VIPLogs;
new DCC_Guild:serverid;
new DCC_Role:role;
new playeronline;

DiscordOnGameMode()
{
	PanelWhitelist = DCC_FindChannelById("1031912928770805840"); //id channels untuk mendaftarkan whitelist
	VIP = DCC_FindChannelById("1031912892183875685"); //id channels untuk mendaftarkan whitelist
	VIPLogs = DCC_FindChannelById("1031912892183875685"); //id channels untuk mendaftarkan whitelist
	role = DCC_FindRoleById("1039912407520260197"); //id role untuk mendaftarkan whitelist
	serverid = DCC_FindGuildById("959390655191330877"); //id server untuk mendaftarkan whitelist
	referralcode = DCC_FindChannelById("1031912934198226997"); //id channels untuk mendaftarkan whitelist
	referralreddem = DCC_FindChannelById("1031912934198226997"); //id channels untuk mendaftarkan whitelist
	activecs = DCC_FindChannelById("1039912603348119592"); //id channels untuk mendaftarkan whitelist
	banneducp = DCC_FindChannelById("1031912930771480636"); //id channels untuk mendaftarkan whitelist
	bannedchar = DCC_FindChannelById("1031912930771480636"); //id channels untuk mendaftarkan whitelist
}

function OnUserVerif(strr[])
{
	new DCC_Channel:channel, DCC_Embed:ucp;
	new y, m, d, timestamp[20];
	getdate(y, m , d);
	format(timestamp, sizeof(timestamp), "%02i%02i%02i", y, m, d);
	channel = DCC_GetCreatedPrivateChannel();
	ucp = DCC_CreateEmbed("AMAZED REBORN");
	DCC_SetEmbedTitle(ucp, "AMAZED ROLEPLAY");
	DCC_SetEmbedTimestamp(ucp, timestamp);
	DCC_SetEmbedColor(ucp, 0xff0000);
	DCC_SetEmbedUrl(ucp, "");
	DCC_SetEmbedFooter(ucp, "AMAZED ROLEPLAY", "");
	DCC_SetEmbedDescription(ucp, strr);
	DCC_SetEmbedImage(ucp, "https://cdn.discordapp.com/attachments/955794895627493407/980770861768376330/20220530_165305.png");
	DCC_SendChannelEmbedMessage(channel, ucp);
	return 1;
}

DCMD:ucp(user, channel, params[])
{
    if(channel != PanelWhitelist)
		return DCC_SendChannelMessage(channel, "Bukan Di Channel Ini Goblok!!");
    if(isnull(params)) return DCC_SendChannelMessage(PanelWhitelist, "**[INFO] Untuk melakukan registrasi ucp\nanda harus menggunakan command !ucp [NameUCP**]");
	new query[528], tquery[842];
    mysql_format(g_SQL, query, sizeof(query), "SELECT username FROM ucp WHERE username='%e'", params);
	mysql_query(g_SQL, query);

    if(cache_num_rows() == 1) return DCC_SendChannelMessage(PanelWhitelist, "**UCP: :x: Nama UCP Tersebut Telah Dipakai!**");

	new useri[DCC_ID_SIZE], DCC_User:userid, str[202];
	new hu = random(9999);
	DCC_GetUserId(user, useri);
	userid = DCC_FindUserById(useri);
	format(str, 250, "**Register Ucp**\nSelamat Karakter anda di Amazed Roleplay berhasil didaftarkan Gunakan UCP untuk login di dalam server!\n```\nUcp:%s\nPin:%d\nIp Server:%s\n```", params, hu, IP_SERVER);
	new DCC_Embed:acc, stri[2800];
	acc = DCC_CreateEmbed("AMAZED");
	format(stri, 280, "**Register UCP**\n***%s*** successfully verified, please check the message", params);
	new y, m, d, timestamp[200];
	getdate(y, m , d);
	format(timestamp, sizeof(timestamp), "%02i%02i%02i", y, m, d);
	DCC_SetEmbedTitle(acc, "AMAZED REBORN");
	DCC_SetEmbedTimestamp(acc, timestamp);
	DCC_SetEmbedColor(acc, 0x00ff00);
	DCC_SetEmbedThumbnail(acc, "https://cdn.discordapp.com/attachments/955794895627493407/980770861768376330/20220530_165305.png");
	DCC_SetEmbedFooter(acc, "AMAZED", "");
	DCC_SetEmbedDescription(acc, stri);
	DCC_SendChannelEmbedMessage(channel, acc);
	DCC_CreatePrivateChannel(userid, "OnUserVerif", "s", str);
	new DCC_Guild:guild;
	DCC_GetChannelGuild(channel, guild);
	DCC_SetGuildMemberNickname(guild, user, params);
	DCC_AddGuildMemberRole(guild, user, role);
	
    mysql_format(g_SQL, tquery, sizeof tquery, "INSERT INTO `ucp` (`username`, `pin`) VALUES ('%e', '%d')", params, hu);
    mysql_tquery(g_SQL, tquery);
	return 1;
}

DCMD:banneducp(user, channel, params[])
{
    if(channel != banneducp)
		return DCC_SendChannelMessage(channel, "Bukan Di Channel Ini Goblok!!.");

	new tmp[24], reasonoban[128];
	if(sscanf(params, "s[24]s[128]", tmp, reasonoban))
	{
		DCC_SendChannelMessage(banneducp, "**!banneducp [nameUCP] [reason]**");
		return 1;
	}
	new query[528], bebas[400], reason[212];
	mysql_format(g_SQL, query, sizeof(query), "SELECT username FROM ucp WHERE username='%e'", tmp);
	mysql_query(g_SQL, query);

	if(cache_num_rows() == 0) return DCC_SendChannelMessage(banneducp, "**:x: Nama UCP tidak ada!**");
	
	new authorName[DCC_NICKNAME_SIZE];
    DCC_GetGuildMemberNickname(serverid, user, authorName, sizeof(authorName));
	format(reason, 128, "%s [%s]", reasonoban, authorName);

	new obannedbyirwan = 1;
	new cQuery[3048];
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "UPDATE `ucp` SET ");
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`banned` = '%d', ", cQuery, obannedbyirwan);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`bannedreason` = '%s' ", cQuery, reason);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%sWHERE `username` = '%e'", cQuery, tmp);
	mysql_tquery(g_SQL, cQuery);

	format(bebas ,sizeof(bebas),"**AdmCmd: UCP %s has been blocked by %s**", tmp, authorName);
	DCC_SendChannelMessage(banneducp, bebas);
	format(bebas ,sizeof(bebas),"**Reason: %s**", reason);
	DCC_SendChannelMessage(banneducp, bebas);
	return 1;
}

DCMD:unbanneducp(user, channel, params[])
{
    if(channel != banneducp)
		return DCC_SendChannelMessage(channel, "Akses Anda Kami tolak!!.");

	new tmp[24];
	if(sscanf(params, "s[24]", tmp))
	{
		DCC_SendChannelMessage(banneducp, "**!unbanneducp [nameUCP]**");
		return 1;
	}
	new query[528], bebas[400];
	mysql_format(g_SQL, query, sizeof(query), "SELECT username FROM ucp WHERE username='%e'", tmp);
	mysql_query(g_SQL, query);

	if(cache_num_rows() == 0) return DCC_SendChannelMessage(banneducp, "**:x: Nama UCP tidak ada!**");
	
	new authorName[DCC_NICKNAME_SIZE];
    DCC_GetGuildMemberNickname(serverid, user, authorName, sizeof(authorName));
	new reason[511];
	reason = "";

	new obannedbyirwan = 0;
	new cQuery[3048];
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "UPDATE `ucp` SET ");
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`banned` = '%d', ", cQuery, obannedbyirwan);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`bannedreason` = '%s' ", cQuery, reason);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%sWHERE `username` = '%e'", cQuery, tmp);
	mysql_tquery(g_SQL, cQuery);

	format(bebas ,sizeof(bebas),"**AdmCmd: %s has been unblocked UCP account %s**", authorName, tmp);
	DCC_SendChannelMessage(banneducp, bebas);
	return 1;
}

DCMD:bannedchar(user, channel, params[])
{
    if(channel != bannedchar)
		return DCC_SendChannelMessage(channel, "Akses Anda Kami tolak!!.");

	new tmp[24], reasonoban[128];
	if(sscanf(params, "s[24]s[128]", tmp, reasonoban))
	{
		DCC_SendChannelMessage(bannedchar, "**!bannedchar [name_character] [reason]**");
		return 1;
	}
	new query[528], bebas[400], reason[212];
	mysql_format(g_SQL, query, sizeof(query), "SELECT username FROM players WHERE username='%e'", tmp);
	mysql_query(g_SQL, query);

	if(cache_num_rows() == 0) return DCC_SendChannelMessage(bannedchar, "**:x: Nama Character tidak ada!**");
	
	new authorName[DCC_NICKNAME_SIZE];
    DCC_GetGuildMemberNickname(serverid, user, authorName, sizeof(authorName));
	format(reason, 128, "%s [%s]", reasonoban, authorName);

	new obannedbyirwan = 1;
	new cQuery[3048];
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "UPDATE `players` SET ");
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`pbanned` = '%d', ", cQuery, obannedbyirwan);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`pbanreason` = '%s' ", cQuery, reason);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%sWHERE `username` = '%e'", cQuery, tmp);
	mysql_tquery(g_SQL, cQuery);

	format(bebas ,sizeof(bebas),"**AdmCmd: Character %s has been blocked by %s**", tmp, authorName);
	DCC_SendChannelMessage(bannedchar, bebas);
	format(bebas ,sizeof(bebas),"**Reason: %s**", reason);
	DCC_SendChannelMessage(bannedchar, bebas);
	return 1;
}

DCMD:unbannedchar(user, channel, params[])
{
    if(channel != bannedchar)
		return DCC_SendChannelMessage(channel, "Akses Anda Kami tolak!!.");

	new tmp[24];
	if(sscanf(params, "s[24]", tmp))
	{
		DCC_SendChannelMessage(bannedchar, "**!unbannedchar [name_character]**");
		return 1;
	}
	new query[528], bebas[400];
	mysql_format(g_SQL, query, sizeof(query), "SELECT username FROM players WHERE username='%e'", tmp);
	mysql_query(g_SQL, query);

	if(cache_num_rows() == 0) return DCC_SendChannelMessage(bannedchar, "**:x: Nama Character tidak ada!**");
	
	new authorName[DCC_NICKNAME_SIZE];
    DCC_GetGuildMemberNickname(serverid, user, authorName, sizeof(authorName));
	new reason[511];
	reason = "";

	new obannedbyirwan = 0;
	new cQuery[3048];
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "UPDATE `players` SET ");
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`pbanned` = '%d', ", cQuery, obannedbyirwan);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`pbanreason` = '%s' ", cQuery, reason);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%sWHERE `username` = '%e'", cQuery, tmp);
	mysql_tquery(g_SQL, cQuery);

	format(bebas ,sizeof(bebas),"**AdmCmd: %s has been unblocked Character account %s**", authorName, tmp);
	DCC_SendChannelMessage(bannedchar, bebas);
	return 1;
}

DCMD:activecs(user, channel, params[])
{
    if(channel != activecs)
		return DCC_SendChannelMessage(channel, "Akses Anda Kami tolak!!.");

    if(isnull(params)) return DCC_SendChannelMessage(activecs, "**!activecs [name_character]**");
	new query[528], bebas[400];
    mysql_format(g_SQL, query, sizeof(query), "SELECT username FROM players WHERE username='%e'", params);
	mysql_query(g_SQL, query);

    if(cache_num_rows() == 0) return DCC_SendChannelMessage(activecs, "**CS: :x: Nama Character tidak ada!**");
    
	new rand = 1;
	new cQuery[3048];
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "UPDATE `players` SET ");
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`cschar` = '%d' ", cQuery, rand);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%sWHERE `username` = '%e'", cQuery, params);
	mysql_tquery(g_SQL, cQuery);

	format(bebas ,sizeof(bebas),"**:exclamation: Character Story %s is active**", params);
	DCC_SendChannelMessage(activecs, bebas);
	return 1;
}

DCMD:referralcode(user, channel, params[])
{
    if(channel != referralcode)
		return DCC_SendChannelMessage(channel, "Akses Anda Kami tolak!!.");

    new bebas[400], test[212];
    new query[528];
	new rand = RandomEx(11111111, 99999999);
	new authorName[DCC_NICKNAME_SIZE];
    DCC_GetGuildMemberNickname(serverid, user, authorName, sizeof(authorName));
    mysql_format(g_SQL, query, sizeof(query), "SELECT referral FROM ucp WHERE referral='%d'", rand);
	mysql_query(g_SQL, query);

    if(cache_num_rows() == 0)
	{
		new referral;
		mysql_format(g_SQL, query, sizeof query, "SELECT * FROM `ucp` WHERE `username` = '%e' LIMIT 1", authorName);
		mysql_query(g_SQL, query);
		if(cache_num_rows() == 1)
		{
			cache_get_value_name_int(0, "referral", referral);
			if(referral > 0)
			{
				format(bebas ,sizeof(bebas),"**Code Referral anda adalah %d**", referral);
				DCC_SendChannelMessage(referralcode, bebas);
			}
			else
			{
				new cQuery[3048];
				mysql_format(g_SQL, cQuery, sizeof(cQuery), "UPDATE `ucp` SET ");
				mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`referral` = '%d' ", cQuery, rand);
				mysql_format(g_SQL, cQuery, sizeof(cQuery), "%sWHERE `username` = '%s'", cQuery, authorName);
				mysql_tquery(g_SQL, cQuery);

				format(test ,sizeof(test),"**Code Referral anda adalah %d**", rand);
				DCC_SendChannelMessage(referralcode, test);
			}
			
		}
		
	}
	return 1;
}

DCMD:referral(user, channel, params[])
{
    if(channel != referralreddem)
		return DCC_SendChannelMessage(channel, "Akses Anda Kami tolak!!.");

	new code;
	if(sscanf(params, "d", code)) return DCC_SendChannelMessage(referralreddem, "**!referral [code referral]**");
	{
		new bebas[400], nameucp[52];
		new authorName[DCC_NICKNAME_SIZE];
		DCC_GetGuildMemberNickname(serverid, user, authorName, sizeof(authorName));
		new query[103];
		mysql_format(g_SQL, query, sizeof query, "SELECT * FROM `ucp` WHERE `referral` = '%d' LIMIT 1", code);
		mysql_query(g_SQL, query);

		if(cache_num_rows() > 0)
		{
			cache_get_value_name(0, "username", nameucp);
			mysql_format(g_SQL, query, sizeof query, "SELECT * FROM `referralcode` WHERE `owner` = '%e' LIMIT 1", authorName);
			mysql_query(g_SQL, query);
			if(cache_num_rows() == 1) return DCC_SendChannelMessage(referralreddem, "**:x: Anda sudah pernah memasukan kode referral**");
			new cQuery[528];
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO referralcode(owner, inviteby) VALUES ('%s', '%s')", authorName, nameucp);
			mysql_tquery(g_SQL, cQuery);
			format(bebas ,sizeof(bebas),"**Anda berhasil memasukan code referral dari pemain %s**", nameucp);
			DCC_SendChannelMessage(referralreddem, bebas);
		}
	}
	return 1;
}

DCMD:createvoucher(user, channel, params[])
{
    if(channel != VIP)
		return DCC_SendChannelMessage(channel, "Akses Anda Kami tolak!!.");

    new voucid = Iter_Free(Vouchers);
	if(voucid == -1) return DCC_SendChannelMessage(VIP, "You cant create more voucher!");
    new vip, viptime, gold;
    if(sscanf(params, "ddd", vip, viptime, gold)) return DCC_SendChannelMessage(VIP, "!createvoucher  [VIP] [VIP-TIME(Days)] [GOLD]");
	
    if(vip < 0 || vip > 4) return DCC_SendChannelMessage(VIP, "Invalid vip 0-4.");
    new rand = RandomEx(11111111, 99999999);
    VoucData[voucid][voucCode]=rand;

    new query[528], tquery[842];
    mysql_format(g_SQL, query, sizeof(query), "SELECT code FROM voucher WHERE code='%d'", VoucData[voucid][voucCode]);
	mysql_query(g_SQL, query);

    if(cache_num_rows() == 1) return DCC_SendChannelMessage(VIP, "**:x: Code tersebut telah digunakan!**");

    new authorName[DCC_NICKNAME_SIZE];
    DCC_GetGuildMemberNickname(serverid, user, authorName, sizeof(authorName));
    
    new drank[32];
	switch(vip)
	{
		case 1: drank = "Basic Donator";
		case 2: drank = "Advanced Donator";
		case 3: drank = "Professional Donator";
		case 4: drank = "Lifetime Donator";
		default: drank = "{00FF00}None{FFFFFF}";
	}

	VoucData[voucid][voucVIP] = vip;
	VoucData[voucid][voucVIPTime] = viptime;
	VoucData[voucid][voucGold] = gold;
	format(VoucData[voucid][voucAdmin], 16, authorName);
	format(VoucData[voucid][voucDonature], 16, "None");
	VoucData[voucid][voucClaim] = 0;
	Iter_Add(Vouchers, voucid);

	mysql_format(g_SQL, tquery, sizeof(tquery), "INSERT INTO vouchers SET id='%d', code='%d', vip='%d', vip_time='%d', gold='%d', admin='%s'", voucid, VoucData[voucid][voucCode], VoucData[voucid][voucVIP], VoucData[voucid][voucVIPTime], VoucData[voucid][voucGold], VoucData[voucid][voucAdmin]);
	mysql_tquery(g_SQL, tquery);
	
    new statuz[256];
    format(statuz,sizeof(statuz),"**Voucher created id: %d | code: %d | vip: %s | vip-time: %d | gold: %d | admin: %s**", voucid, VoucData[voucid][voucCode], drank, viptime, VoucData[voucid][voucGold], VoucData[voucid][voucAdmin]);
	DCC_SendChannelMessage(VIP, statuz);
    Voucher_Save(voucid);

	return 1;
}

CMD:redeem(playerid, params[])
{
	new code;
	if(sscanf(params, "d", code)) return Usage(playerid, "/redeem [CODE]");
	
	foreach(new vo : Vouchers)
	{
		if(VoucData[vo][voucCode] == code)
		{
			if(VoucData[vo][voucClaim] == 0)
			{

				if(VoucData[vo][voucVIP] == 0)
				{
					new query[103], nameucp[52];
					mysql_format(g_SQL, query, sizeof query, "SELECT * FROM `referralcode` WHERE `owner` = '%e' LIMIT 1", charData[playerid][cName]);
					mysql_query(g_SQL, query);

					pData[playerid][pGold] += VoucData[vo][voucGold];
					
					VoucData[vo][voucClaim] = 1;
					format(VoucData[vo][voucDonature], 16, pData[playerid][pName]);
					Voucher_Save(vo);
					new statuz[256];
                    
                    Info(playerid, "You have successfully claimed voucher "YELLOW_E"code %d", code);
					if(cache_num_rows() > 0)
					{
						cache_get_value_name(0, "inviteby", nameucp);
						format(statuz,sizeof(statuz),"**ID: %d | Voucher claimed. gold: %d | claimby: %s | referral: %s**", vo, VoucData[vo][voucGold], pData[playerid][pName], nameucp);
                    	DCC_SendChannelMessage(VIPLogs, statuz);
					}	
					else
					{
						format(statuz,sizeof(statuz),"**ID: %d | Voucher claimed. gold: %d | claimby: %s**", vo, VoucData[vo][voucGold], pData[playerid][pName]);
                    	DCC_SendChannelMessage(VIPLogs, statuz);
					}
				}
				else
				{
					new query[103], nameucp[52];
					mysql_format(g_SQL, query, sizeof query, "SELECT * FROM `referralcode` WHERE `owner` = '%e' LIMIT 1", charData[playerid][cName]);
					mysql_query(g_SQL, query);

					new dayz = VoucData[vo][voucVIPTime];
					pData[playerid][pGold] += VoucData[vo][voucGold];
					pData[playerid][pVip] = VoucData[vo][voucVIP];
					pData[playerid][pVipTime] = gettime() + (dayz * 86400);
					
                    new drank[32];
                    switch(VoucData[vo][voucVIP])
                    {
                        case 1: drank = "Basic Donator";
                        case 2: drank = "Advanced Donator";
                        case 3: drank = "Professional Donator";
                        case 4: drank = "Lifetime Donator";
                        default: drank = "{00FF00}None{FFFFFF}";
                    }
					VoucData[vo][voucClaim] = 1;
					format(VoucData[vo][voucDonature], 16, pData[playerid][pName]);
					Voucher_Save(vo);
                    Info(playerid, "You have successfully claimed voucher "YELLOW_E"code %d", code);
					if(cache_num_rows() > 0)
					{
						cache_get_value_name(0, "inviteby", nameucp);
						new statuz[256];
						format(statuz,sizeof(statuz),"**ID: %d | Voucher claimed. VIP: %s | VIP TIME: %d days | gold: %d | claimby: %s | referral: %s**", vo, drank, dayz, VoucData[vo][voucGold], pData[playerid][pName], nameucp);
						DCC_SendChannelMessage(VIPLogs, statuz);
					}	
					else
					{
						new statuz[256];
						format(statuz,sizeof(statuz),"**ID: %d | Voucher claimed. VIP: %s | VIP TIME: %d days | gold: %d | claimby: %s**", vo, drank, dayz, VoucData[vo][voucGold], pData[playerid][pName]);
						DCC_SendChannelMessage(VIPLogs, statuz);
					}
				}
			}
			else return Error(playerid, "Voucher has been expired!");
		}
	}
	return 1;
}

task onlineplayer[1000]()
{
    new statuz[256];
    format(statuz,sizeof(statuz),"AMAZED MENGUDARA! | #AMAZEDREBORN",playeronline);
    DCC_SetBotActivity(statuz);
}