#include <a_samp>
#include <rAgc>
#include <rAcs>
#include <AntiJC>
#include <Opba>
#include <rAct>
#include <rAsc>
#include <rEac>
#include <AntiSba>


public OnPlayerGunCheat(playerid, weaponid, ammo, hacktype)
{
    if(GetPlayerWeapon(playerid) == 25) //shotgun
    {
    	new string[114];
		format(string, sizeof string, "Karuto: %s Terdeteksi Menggunakan Cheat Weapon", pData[playerid][pName]);
		print(string);
    	SendClientMessageToAll(COLOR_RED, string);
		Kick(playerid);
    }
    if(GetPlayerWeapon(playerid) == 38) //minigun
    {
		new string[114];
		format(string, sizeof string, "Karuto: %s Terdeteksi Menggunakan Cheat Weapon", pData[playerid][pName]);
		print(string);
    	SendClientMessageToAll(COLOR_RED, string);
    	Kick(playerid);
    }
}
public OnPlayerJetpackCheat(playerid)
{
	new string[114];
	SendAdminMessage(COLOR_RED, "AdmWarn: %s was a kicked used jetpack cheat!", pData[playerid][pName]);
	print(string);
	Kick(playerid);
	return 1;
}
/*public OnPlayerCarTroll(playerid, vehicleid, trolledid, trolltype)
{
	new string[114];
	if(trolledid == INVALID_PLAYER_ID)
		SendAdminMessage(COLOR_RED,"AdmWarn: %s used car troll cheats vehicle %d type %d !", pData[playerid][pName], vehicleid, trolltype);
	else
		SendAdminMessage(COLOR_RED, "AdmWarn: %s used car troll cheats on ID %d vehicle %d type %d !", pData[playerid][pName], trolledid, vehicleid, trolltype);
	print(string);
	Kick(playerid);
	return 1;
}*/
public OnPlayerBreakAir(playerid, breaktype)
{
	new string[114];
	SendAdminMessage(COLOR_RED, "AdmWarn: %s was used airbreak/teleport cheats type %d, Please spec now!", pData[playerid][pName], breaktype);
	print(string);
	Kick(playerid);
	return 1;
}
public OnPlayerSpeedCheat(playerid, speedtype)
{
	new string[114];
	format(string, sizeof string, "BotWarn: %s has a kicked was using speed cheats type %d!", pData[playerid][pName], speedtype);
	print(string);
	SendClientMessageToAll(TOMATO, string);
	Kick(playerid);
	return 1;
}
public OnPlayerCarSwing(playerid, vehicleid)
{
	new string[114];
	SendAdminMessage(COLOR_RED, "BotWarn: %s was kicked used car swing cheats vehicle %d !", pData[playerid][pName], vehicleid);
	print(string);
	Kick(playerid);
	return 1;
}
public OnPlayerSlide(playerid, weaponid, Float:speed)
{
	new Test_String[80];
	SendAdminMessage(COLOR_RED, "AdmWarn: %s was kicked used slide bugging weapon %d !", pData[playerid][pName], weaponid);
	print(Test_String);
	Kick(playerid);
	return 1;
}