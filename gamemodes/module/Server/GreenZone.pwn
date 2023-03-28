#define MAX_GREENZONE (14)

new GreenZoneArea[MAX_GREENZONE] = {INVALID_STREAMER_ID, ...},
		GangZoneID;


new Float:asgh_Point[] = {
	1142.0, -1387.5, 1199.0, -1284.5 
};
new Float:sapd_Point[] = {
	1530.0, -1718.5, 1589.0, -1604.5 
};
new Float:cityHall_Point[] = {
	1396.0, -1841.5, 1563.0, -1737.5 
};
new Float:sana_Point[] = {
	638.0, -1388.5, 798.0, -1318.5 
};


#include <YSI\y_hooks>
hook OnGameModeInitEx() {
	GreenZoneArea[1] = CreateDynamicRectangle(asgh_Point[0], asgh_Point[1], asgh_Point[2], asgh_Point[3], 0, 0);
	GreenZoneArea[2] = CreateDynamicRectangle(sapd_Point[0], sapd_Point[1], sapd_Point[2], sapd_Point[3], 0, 0);
	GreenZoneArea[3] = CreateDynamicRectangle(cityHall_Point[0], cityHall_Point[1], cityHall_Point[2], cityHall_Point[3], 0, 0);
	GreenZoneArea[4] = CreateDynamicRectangle(sana_Point[0], sana_Point[1], sana_Point[2], sana_Point[3], 0, 0);
	
	GangZoneID = GangZoneCreate(-3000, -3000, 3000, 3000);
	
	return 1;
}


hook OnPlayerEnterDynArea(playerid, areaid) {
    for (new i = 0; i < MAX_GREENZONE; i ++) if (areaid == GreenZoneArea[i]) {
        if (i == 1 || i == 2 || i == 3 || i == 12 || i == 13) {
            GangZoneShowForPlayer(playerid, GangZoneID, 0x0000FF66);
            GangZoneFlashForPlayer(playerid, GangZoneID, 0x0000FF66);
        } else {
            GangZoneShowForPlayer(playerid, GangZoneID, 0x00FF0066);
            GangZoneFlashForPlayer(playerid, GangZoneID, 0x00FF0066);
        }
    }

    return 1;
}


hook OnPlayerLeaveDynArea(playerid, areaid) {
    for (new i = 0; i < MAX_GREENZONE; i ++) if (areaid == GreenZoneArea[i]) {
        GangZoneHideForPlayer(playerid, GangZoneID);
        GangZoneStopFlashForPlayer(playerid, GangZoneID);
    }

    return 1;
}