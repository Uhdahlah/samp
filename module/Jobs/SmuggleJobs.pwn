#define SMUGGLER_SALARY 35000
#define MAX_PACKET 5

new selectedLocation;
new packetStatus[MAX_PACKET];
new packetPlayerid[MAX_PACKET] = {INVALID_PLAYER_ID, ...};
new packetObject[MAX_PACKET], Text3D:packetLabel[MAX_PACKET];
new packetActive = 0;

new Float:pickPacket[][3] = {
  {-1633.02, -2239.38, 31.47},
  {-2057.39, -2464.50, 31.17},
  {-418.21, 2229.03, 42.42},
  {1550.20, -29.35, 21.33},
  {-36.12, 2350.08, 24.30}
};

new Float:storePacket[][3] = {
  {-534.31, -103.06, 63.29},
  {-1426.72, 2170.94, 50.62},
  {870.05, -25.43, 63.95},
  {-127.32, 2259.13, 28.43},
  {-391.05, 2487.62, 41.14}
};

SendSmugglerMessage(text[]) {
  foreach (new i : Player) if (pData[i][pJob] == 8 || pData[i][pJob2] == 8) {
    SendCustomMessage(i, "SMUGGLER", "%s", text);
  }
  return 1;
}

task PacketUpdate[300000]() {
  if (packetActive == 0) {
    selectedLocation = random(sizeof(pickPacket));
    if (packetStatus[selectedLocation] == 0) {
      packetStatus[selectedLocation] = 1;
      packetObject[selectedLocation] = CreateDynamicObject(1279, pickPacket[selectedLocation][0], pickPacket[selectedLocation][1], pickPacket[selectedLocation][2]-0.9, 0.0, 0.0, 0.0, 0, 0);
      packetActive = 1;
      SendSmugglerMessage("New packet available '"YELLOW_E"/findpacket"WHITE_E"' to find the packet.");
    }
  } else SendSmugglerMessage("Smuggler job is currently active, use '"YELLOW_E"/findpacket"WHITE_E"' to find the packet.");
}

CMD:findpacket(playerid, params[]) {
  if (pData[playerid][pJob] != 8 && pData[playerid][pJob2] != 8)
    return Error(playerid, "You don't have the appropriate job.");
  
  if (pData[playerid][pSmugglerPick])
    return Error(playerid, "Kamu tidak bisa mengambil packet yang lain, karena kamu sedang mengantarkan paket.");

  if (packetStatus[selectedLocation] == 1) {
    SetPlayerRaceCheckpoint(playerid, 1,  pickPacket[selectedLocation][0], pickPacket[selectedLocation][1], pickPacket[selectedLocation][2], 0, 0, 0, 3.0);
    pData[playerid][pSmugglerFind] = 1;
    SetPVarInt(playerid, "sedangSmuggler", 1);
    SendCustomMessage(playerid, "SMUGGLER", "Please goto the marked location to pickup the packet.");
  } else if (packetStatus[selectedLocation] == 2) {
    new Float:pos[3], Float:oPos[3];
    GetPlayerPos(packetPlayerid[selectedLocation], pos[0], pos[1], pos[2]);
    DisablePlayerRaceCheckpoint(playerid);
    SetPlayerRaceCheckpoint(playerid, 1, pos[0], pos[1], pos[2], 0, 0, 0, 3.0);

    if (packetPlayerid[selectedLocation] == INVALID_PLAYER_ID) {
        GetDynamicObjectPos(packetObject[selectedLocation], oPos[0], oPos[1], oPos[2]);
        SetPlayerRaceCheckpoint(playerid, 1, oPos[0], oPos[1], oPos[2], 0, 0, 0, 3.0);
    }
    SetPVarInt(playerid, "sedangSmuggler", 1);
    SendCustomMessage(playerid, "SMUGGLER", "Please goto the marked location to pickup the packet.");
  } else {
    Error(playerid, "Tidak ada paket yang perlu dikirim.");
  }
  return 1;
}

CMD:pickpacket(playerid, params[]) {
  if (pData[playerid][pJob] != 8 && pData[playerid][pJob2] != 8)
    return Error(playerid, "You don't have the appropriate job.");

  new Float:oPos[3];
  GetDynamicObjectPos(packetObject[selectedLocation], oPos[0], oPos[1], oPos[2]);

  if (!IsPlayerInRangeOfPoint(playerid, 3.0, oPos[0], oPos[1], oPos[2]))
    return Error(playerid, "You're not near any packet.");

  SetPVarInt(playerid, "sedangNganter", 1);
  SetPVarInt(playerid, "sedangSmuggler", 0);

  DestroyDynamicObject(packetObject[selectedLocation]);
  packetObject[selectedLocation] = INVALID_STREAMER_ID;
  DestroyDynamic3DTextLabel(packetLabel[selectedLocation]);
  packetLabel[selectedLocation] = Text3D:INVALID_3DTEXT_ID;
  pData[playerid][pSmugglerPick] = 1;
  pData[playerid][pSmugglerFind] = 0;
  packetPlayerid[selectedLocation] = playerid;
  packetStatus[selectedLocation] = 2;
  SetPlayerRaceCheckpoint(playerid, 1, storePacket[selectedLocation][0], storePacket[selectedLocation][1], storePacket[selectedLocation][2], 0, 0, 0, 3.0);
  SendCustomMessage(playerid, "SMUGGLER", "You've pickup the packet, please go to marked location to store this packet!");
  return 1;
}

CMD:getpacket(playerid, params[]) {
  if (pData[playerid][pJob] != 8 && pData[playerid][pJob2] != 8)
    return Error(playerid, "You don't have the appropriate job.");

  if (GetPVarInt(playerid, "sedangSmuggler") == 1) {
    if (IsPlayerInRangeOfPoint(playerid, 3.0, pickPacket[selectedLocation][0], pickPacket[selectedLocation][1], pickPacket[selectedLocation][2]) && pData[playerid][pSmugglerFind]) {
      packetPlayerid[selectedLocation] = playerid;
      packetStatus[selectedLocation] = 2;
      foreach (new i : Player) if (pData[i][pJob] == 8 || pData[i][pJob2] == 8) {
        if (GetPVarInt(i, "sedangSmuggler") == 1) {
          DisablePlayerRaceCheckpoint(i);
        }
        SendCustomMessage(i, "SMUGGLER", "Someone has already pickup the packet, packet was moved!");
        SendCustomMessage(i, "SMUGGLER", "Type /findpacket again to know the packet location.");
      }
      pData[playerid][pSmugglerPick] = 1;
      pData[playerid][pSmugglerFind] = 0;
      SetPVarInt(playerid, "sedangNganter", 1);
      SetPVarInt(playerid, "sedangSmuggler", 0);
      DestroyDynamicObject(packetObject[selectedLocation]);
      packetObject[selectedLocation] = INVALID_STREAMER_ID;
      SetPlayerRaceCheckpoint(playerid, 1, storePacket[selectedLocation][0], storePacket[selectedLocation][1], storePacket[selectedLocation][2], 0, 0, 0, 3.0);
      ApplyAnimation(playerid, "BSKTBALL", "BBALL_pickup", 4.0, 0, 1, 1, 0, 0, 1);
      SendCustomMessage(playerid, "SMUGGLER", "You've pickup the packet, please go to marked location to store this packet!");
    } else return Error(playerid, "Please go to the marked location, to pickup the packet.");
  }
  return 1;
}

CMD:storepacket(playerid, params[]) {
  if (pData[playerid][pJob] != 8 && pData[playerid][pJob2] != 8)
    return Error(playerid, "You don't have the appropriate job.");

  if (pData[playerid][pSmugglerPick]) {
    if (pData[playerid][pSmugglerPick] && IsPlayerInRangeOfPoint(playerid, 3.0, storePacket[selectedLocation][0], storePacket[selectedLocation][1], storePacket[selectedLocation][2])) {
      ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0, 1);
      GivePlayerMoneyEx(playerid, SMUGGLER_SALARY);
      pData[playerid][pSmugglerPick] = 0;
      pData[playerid][pSmugglerFind] = 0;
      packetPlayerid[selectedLocation] = INVALID_PLAYER_ID;
      packetStatus[selectedLocation] = 0;
      DeletePVar(playerid, "sedangSmuggler");
      DeletePVar(playerid, "sedangNganter");
      packetActive = 0;
      foreach (new i : Player) if (pData[i][pJob] == 8 || pData[i][pJob2] == 8) {
        pData[i][pSmugglerPick] = 0;
        pData[i][pSmugglerFind] = 0;
        DeletePVar(i, "sedangSmuggler");
        DeletePVar(i, "sedangNganter");
      }
      SendCustomMessage(playerid, "SMUGGLER", "You've been stored the packet and you'll received "GREEN_E"%s", FormatMoney(SMUGGLER_SALARY));
    } else return Error(playerid, "Please go to the marked location, to store the packet.");
  }
  return 1;
}

CMD:droppacket(playerid) {
  if (pData[playerid][pJob] != 8 && pData[playerid][pJob2] != 8)
    return Error(playerid, "You don't have the appropriate job.");

  if (pData[playerid][pSmugglerPick] == 0 && GetPVarInt(playerid, "sedangNganter") == 0)
    return Error(playerid, "You are not being sending any packet.");

  new Float:pos[3];
  GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
  packetPlayerid[selectedLocation] = INVALID_PLAYER_ID;
  packetObject[selectedLocation] = CreateDynamicObject(1279, pos[0], pos[1], pos[2]-0.9, 0.0, 0.0, 0.0, 0, 0);
  packetLabel[selectedLocation] = CreateDynamic3DTextLabel("[Packet]\n"WHITE_E"Type "YELLOW_E"/pickpacket"WHITE_E" to pick the packet.", COLOR_ARWIN, pos[0], pos[1], pos[2]+0.5, 7.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
  pData[playerid][pSmugglerPick] = 0;
  pData[playerid][pSmugglerFind] = 0;
  DisablePlayerRaceCheckpoint(playerid);
  SendCustomMessage(playerid, "SMUGGLER", "You've dropped the packet..");
  DeletePVar(playerid, "sedangSmuggler");
  DeletePVar(playerid, "sedangNganter");
  return 1;
}

CMD:resetsmuggler(playerid, params[]) {
  if (pData[playerid][pAdmin] < 5)
    return PermissionError(playerid);

  packetActive = 0;
  packetPlayerid[selectedLocation] = INVALID_PLAYER_ID;
  packetStatus[selectedLocation] = 0;
  foreach (new i : Player) if (pData[i][pJob] == 8 || pData[i][pJob2] == 8) {
    pData[i][pSmugglerPick] = 0;
    pData[i][pSmugglerFind] = 0;
    DeletePVar(i, "sedangSmuggler");
    DeletePVar(i, "sedangNganter");
  }
  SendCustomMessage(playerid, "RESET", "You've reseted smuggler packet.");
  return 1;
}

CMD:testsmuggler(playerid, params[]) {
  if (pData[playerid][pAdmin] < 5)
    return PermissionError(playerid);

  if (packetActive == 0) {
    selectedLocation = random(sizeof(pickPacket));
    if (packetStatus[selectedLocation] == 0) {
      packetStatus[selectedLocation] = 1;
      packetObject[selectedLocation] = CreateDynamicObject(1279, pickPacket[selectedLocation][0], pickPacket[selectedLocation][1], pickPacket[selectedLocation][2]-0.9, 0.0, 0.0, 0.0, 0, 0);
      packetActive = 1;
      SendSmugglerMessage("New packet available '"YELLOW_E"/findpacket"WHITE_E"' to find the packet.");
    }
  } else SendSmugglerMessage("Smuggler job is currently active, use '"YELLOW_E"/findpacket"WHITE_E"' to find the packet.");
  return 1;
}

#include <YSI\y_hooks>
hook OnPlayerEnterRaceCP(playerid)
{   
  if (pData[playerid][pJob] == 8 || pData[playerid][pJob2] == 8) {
    if (GetPVarInt(playerid, "sedangSmuggler") == 1) {
      GameTextForPlayer(playerid, "~p~SMUGGLER PACKET~n~~w~USE ~R~/GETPACKET~w~ TO PICKUP PACKET", 3000, 4);
    } else if (GetPVarInt(playerid, "sedangNganter") == 1) {
      SendCustomMessage(playerid, "SMUGGLER", "Type /storepacket to store this packet.");
    }
  }
  return 1;
}


hook OnPlayerDeath(playerid) {
  if (GetPVarInt(playerid, "sedangNganter")) {
    if ((pData[playerid][pJob] == 8 || pData[playerid][pJob2] == 8) && pData[playerid][pSmugglerPick]) {
      new Float:pos[3];
      GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
      packetObject[selectedLocation] = CreateDynamicObject(1279, pos[0], pos[1], pos[2]-0.9, 0.0, 0.0, 0.0, 0, 0);
      packetLabel[selectedLocation] = CreateDynamic3DTextLabel("[Packet]\n"WHITE_E"Type "YELLOW_E"/pickpacket"WHITE_E" to pick the packet.", COLOR_ARWIN, pos[0], pos[1], pos[2]+0.5, 7.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
      packetPlayerid[selectedLocation] = INVALID_PLAYER_ID;
      pData[playerid][pSmugglerPick] = 0;
      pData[playerid][pSmugglerFind] = 0;
      DisablePlayerRaceCheckpoint(playerid);
      SendCustomMessage(playerid, "SMUGGLER", "You've failed store a packet.");
      DeletePVar(playerid, "sedangSmuggler");
      DeletePVar(playerid, "sedangNganter");
    }
  }
  return 1;
}


hook OnPlayerDisconnectExEx(playerid) {
  if (GetPVarInt(playerid, "sedangNganter")) {
    if ((pData[playerid][pJob] == 8 || pData[playerid][pJob2] == 8) && pData[playerid][pSmugglerPick]) {
      new Float:pos[3];
      GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
      packetObject[selectedLocation] = CreateDynamicObject(1279, pos[0], pos[1], pos[2]-0.9, 0.0, 0.0, 0.0, 0, 0);
      packetLabel[selectedLocation] = CreateDynamic3DTextLabel("[Packet]\n"WHITE_E"Type "YELLOW_E"/pickpacket"WHITE_E" to pick the packet.", COLOR_ARWIN, pos[0], pos[1], pos[2]+0.5, 7.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
      packetPlayerid[selectedLocation] = INVALID_PLAYER_ID;
      pData[playerid][pSmugglerPick] = 0;
      pData[playerid][pSmugglerFind] = 0;
      DisablePlayerRaceCheckpoint(playerid);
      SendCustomMessage(playerid, "SMUGGLER", "You've failed store a packet.");
      DeletePVar(playerid, "sedangSmuggler");
      DeletePVar(playerid, "sedangNganter");
    }
  }
  pData[playerid][pSmugglerPick] = 0;
  pData[playerid][pSmugglerFind] = 0;
  DeletePVar(playerid, "sedangSmuggler");
  DeletePVar(playerid, "sedangNganter");
  return 1;
}