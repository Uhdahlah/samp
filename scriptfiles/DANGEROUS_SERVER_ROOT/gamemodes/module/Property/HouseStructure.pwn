

            // format(str, sizeof(str), "SELECT * FROM `housestruct` WHERE `HouseID` = '%d'", hData[j][hID]);
            // mysql_tquery(g_iHandle, str, "OnLoadHouseStructure", "d", j);

// House_Delete(houseid)
// {
//     House_RemoveFurniture(houseid);
//     House_RemoveAllItems(houseid);
//     HouseStructure_DeleteAll(houseid);
//     House_RemoveAllGateAndObject(houseid);
    
//     return 1;
// }



hook OnPlayerSelectDynamicObject(playerid, objectid, modelid, Float:x, Float:y, Float:z) {
    #if defined DEBUG_MODE
        printf("[Callback: OnPlayerSelectDynamicObject]: Player ID: %d, Object ID: %d, Model ID: %d, X: %.1f, Y: %.1f, Z: %.1f", playerid, objectid, modelid, x, y, z);
    #endif

    if (pData[playerid][pEditHouseStructure] != -1) {
        new houseid = pData[playerid][pEditHouseStructure];

        foreach (new i : HouseStruct[houseid]) {
            if (HouseStructure[houseid][i][structureObject] == objectid) {
                switch (SelectStructureType[playerid]) {
                    case STRUCTURE_SELECT_EDITOR: {
                        if (HouseStructure[houseid][i][structureType] == 0) {
                            pData[playerid][pEditStructure] = i;
                            pData[playerid][pEditingMode] = STRUCTURE;
                            EditDynamicObject(playerid, HouseStructure[houseid][i][structureObject]);
                            SendCustomMessage(playerid, "BUILDER", "You're now editing %s.", GetStructureNameByModel(HouseStructure[houseid][i][structureModel]));
                            break;
                        }
                    }
                    case STRUCTURE_SELECT_RETEXTURE: {
                        SetPVarInt(playerid, "structureObj", i);
                        CancelEdit(playerid);
                        Dialog_Show(playerid, House_StructureRetexture, DIALOG_STYLE_INPUT, "Retexture House Structure", "Please input the texture name below:\n"YELLOW_E"[model] [txdname] [texture] [opt: alpha] [opt: red] [opt: green] [opt: blue]", "Retexture", "Cancel");
                        break;
                    }
                    case STRUCTURE_SELECT_DELETE: {
                        if (HouseStructure[houseid][i][structureType] == 0) {
                            SendCustomMessage(playerid, "BUILDER", "You've been successfully deleted %s", GetStructureNameByModel(HouseStructure[houseid][i][structureModel]));
                            HouseStructure_Delete(i, houseid);
                            break;
                        }
                    }
                    case STRUCTURE_SELECT_COPY: {
                        if (HouseStructure[houseid][i][structureType] == 0) {
                            new price;

                            for (new id = 0; id < sizeof(g_aHouseStructure); id ++) if (g_aHouseStructure[id][e_StructureModel] == HouseStructure[houseid][i][structureModel]) {
                                price = g_aHouseStructure[id][e_StructureCost];
                            }

                            if (Inventory_Count(playerid, "Component") < price)
                                return Error(playerid, "You need %d Component(s) to copy this structure.", price);

                            new copyId = HouseStructure_CopyObject(i, houseid);

                            if (copyId == cellmin)
                                return Error(playerid, "Your house has reached maximum of structure");

                            Inventory_Remove(playerid, "Component", price);
                            pData[playerid][pEditStructure] = copyId;
                            pData[playerid][pEditingMode] = STRUCTURE;
                            pData[playerid][pEditHouseStructure] = houseid;
                            EditDynamicObject(playerid, HouseStructure[houseid][copyId][structureObject]);
                            SendCustomMessage(playerid, "BUILDER", "You have copied structure for "GREEN_E"%d component(s)", price);
                            SendCustomMessage(playerid, "BUILDER", "You're now editing copied object of %s.", GetStructureNameByModel(HouseStructure[houseid][i][structureModel]));
                            break;
                        }
                    }
                }
                break;
            }
        }
    }

    // if (pData[playerid][pEditFurnHouse] != -1) {
    //     new houseid = pData[playerid][pEditFurnHouse];

    //     foreach (new furnitureid : HouseFurnitures[houseid]) if (objectid == FurnitureData[houseid][furnitureid][furnitureObject]) {
    //         switch (SelectFurnitureType[playerid]) {
    //             case FURNITURE_SELECT_MOVE: {
    //                 pData[playerid][pEditingMode] = FURNITURE;
    //                 pData[playerid][pEditFurniture] = furnitureid;
    //                 EditDynamicObject(playerid, FurnitureData[houseid][furnitureid][furnitureObject]);
    //                 SendCustomMessage(playerid, "HOUSE", "You are now editing the position of item \"%s\".", FurnitureData[houseid][furnitureid][furnitureName]);
    //                 break;
    //             }
    //             case FURNITURE_SELECT_DESTROY:
    //             {
    //                 SendCustomMessage(playerid, "HOUSE", "You have destroyed furniture \"%s\".", FurnitureData[houseid][furnitureid][furnitureName]);
    //                 Furniture_Delete(furnitureid, houseid);

    //                 CancelEdit(playerid);
    //                 pData[playerid][pEditFurniture] = -1;
    //                 pData[playerid][pEditFurnHouse] = -1;
    //                 break;
    //             }
    //             case FURNITURE_SELECT_STORE: {
    //                 if (FurnitureData[houseid][furnitureid][furnitureUnused])
    //                     return Error(playerid, "This furniture is already stored"), CancelEdit(playerid);
                    
    //                 FurnitureData[houseid][furnitureid][furnitureUnused] = 1;
    //                 Furniture_Refresh(furnitureid, houseid);
    //                 Furniture_Save(furnitureid, houseid);
    //                 SendCustomMessage(playerid, "HOUSE", "You have stored furniture \"%s"WHITE_E"\" into your house.", FurnitureData[houseid][furnitureid][furnitureName]);
    //                 break;
    //             }
    //         }
    //         break;
    //     }
    // }
    return 1;
}

hook OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
    if(response == EDIT_RESPONSE_FINAL)
    {
        switch(pData[playerid][pEditingMode])
        {
            case FURNITURE: {
                if(pData[playerid][pEditFurniture] != -1)
                {
                    new id = House_Inside(playerid);
                    if(id != -1 && (House_IsOwner(playerid, id) || hData[id][houseBuilder] == pData[playerid][pID]))
                    {
                        if (Iter_Contains(HouseFurnitures[id], pData[playerid][pEditFurniture])) {
                            FurnitureData[id][pData[playerid][pEditFurniture]][furniturePos][0] = x;
                            FurnitureData[id][pData[playerid][pEditFurniture]][furniturePos][1] = y;
                            FurnitureData[id][pData[playerid][pEditFurniture]][furniturePos][2] = z;
                            FurnitureData[id][pData[playerid][pEditFurniture]][furnitureRot][0] = rx;
                            FurnitureData[id][pData[playerid][pEditFurniture]][furnitureRot][1] = ry;
                            FurnitureData[id][pData[playerid][pEditFurniture]][furnitureRot][2] = rz;
                            
                            SetDynamicObjectPos(objectid,x,y,z);
                            SetDynamicObjectRot(objectid,rx,ry,rz);
                            Furniture_Refresh(pData[playerid][pEditFurniture], id);
                            Furniture_Save(pData[playerid][pEditFurniture], id);

                            SendCustomMessage(playerid, "HOUSE", "You have edited the position of item \"%s\".", FurnitureData[id][pData[playerid][pEditFurniture]][furnitureName]);

                            pData[playerid][pEditFurniture] = -1;
                            pData[playerid][pEditFurnHouse] = -1;
                        }
                    }
                }
            }
            case STRUCTURE: {
                if (pData[playerid][pEditStructure] != -1) {
                    new houseid = House_Inside(playerid), id = pData[playerid][pEditStructure];

                    if (houseid != -1) {
                        if (Iter_Contains(HouseStruct[houseid], id)) {
                            HouseStructure[houseid][id][structurePos][0] = x;
                            HouseStructure[houseid][id][structurePos][1] = y;
                            HouseStructure[houseid][id][structurePos][2] = z;
                            HouseStructure[houseid][id][structureRot][0] = rx;
                            HouseStructure[houseid][id][structureRot][1] = ry;
                            HouseStructure[houseid][id][structureRot][2] = rz;

                            SetDynamicObjectPos(objectid, x, y, z);
                            SetDynamicObjectRot(objectid, rx, ry, rz);
                            HouseStructure_Refresh(id, houseid);
                            HouseStructure_Save(id, houseid);

                            SendCustomMessage(playerid, "BUILDER", "Structure position has been saved.");

                            pData[playerid][pEditHouseStructure] = -1;
                            pData[playerid][pEditStructure] = -1;
                        }
                    }
                }
            }
        }
        pData[playerid][pEditingMode] = NOTHING;
    }
    else if(response == EDIT_RESPONSE_CANCEL)
    {
        new Float:position[3],Float:rotation[3];
        switch(pData[playerid][pEditingMode])
        {
            case FURNITURE: {
                if(pData[playerid][pEditFurniture] != -1) {
                    new slot = pData[playerid][pEditFurniture], houseid = House_Inside(playerid);

                    if (houseid != -1 && Iter_Contains(HouseFurnitures[houseid], slot)) {
                        Streamer_GetFloatData(STREAMER_TYPE_OBJECT,FurnitureData[houseid][slot][furnitureObject],E_STREAMER_X,position[0]);
                        Streamer_GetFloatData(STREAMER_TYPE_OBJECT,FurnitureData[houseid][slot][furnitureObject],E_STREAMER_Y,position[1]);
                        Streamer_GetFloatData(STREAMER_TYPE_OBJECT,FurnitureData[houseid][slot][furnitureObject],E_STREAMER_Z,position[2]);
                        Streamer_GetFloatData(STREAMER_TYPE_OBJECT,FurnitureData[houseid][slot][furnitureObject],E_STREAMER_R_X,rotation[0]);
                        Streamer_GetFloatData(STREAMER_TYPE_OBJECT,FurnitureData[houseid][slot][furnitureObject],E_STREAMER_R_Y,rotation[1]);
                        Streamer_GetFloatData(STREAMER_TYPE_OBJECT,FurnitureData[houseid][slot][furnitureObject],E_STREAMER_R_Z,rotation[2]);
                        SetDynamicObjectPos(objectid,position[0],position[1],position[2]);
                        SetDynamicObjectRot(objectid,rotation[0],rotation[1],rotation[2]);
                    }
                }
            }
            case STRUCTURE: {
                if(pData[playerid][pEditStructure] != -1) {
                    new slot = pData[playerid][pEditStructure], houseid = pData[playerid][pEditHouseStructure];

                    if (houseid != -1) {
                        Streamer_GetFloatData(STREAMER_TYPE_OBJECT,HouseStructure[houseid][slot][structureObject],E_STREAMER_X,position[0]);
                        Streamer_GetFloatData(STREAMER_TYPE_OBJECT,HouseStructure[houseid][slot][structureObject],E_STREAMER_Y,position[1]);
                        Streamer_GetFloatData(STREAMER_TYPE_OBJECT,HouseStructure[houseid][slot][structureObject],E_STREAMER_Z,position[2]);
                        Streamer_GetFloatData(STREAMER_TYPE_OBJECT,HouseStructure[houseid][slot][structureObject],E_STREAMER_R_X,rotation[0]);
                        Streamer_GetFloatData(STREAMER_TYPE_OBJECT,HouseStructure[houseid][slot][structureObject],E_STREAMER_R_Y,rotation[1]);
                        Streamer_GetFloatData(STREAMER_TYPE_OBJECT,HouseStructure[houseid][slot][structureObject],E_STREAMER_R_Z,rotation[2]);
                        SetDynamicObjectPos(objectid,position[0],position[1],position[2]);
                        SetDynamicObjectRot(objectid,rotation[0],rotation[1],rotation[2]);

                        pData[playerid][pEditHouseStructure] = -1;
                        pData[playerid][pEditStructure] = -1;
                    }
                }
            }
        }
        pData[playerid][pEditingMode] = NOTHING;
    }
    return 1;
}

Dialog:FurnitureList(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new id = House_Inside(playerid),
            Float:x,
            Float:y,
            Float:z,
            Float:angle;

        GetPlayerPos(playerid, x, y, z);
        GetPlayerFacingAngle(playerid, angle);

        x += 1.0 * floatsin(-angle, degrees);
        y += 1.0 * floatcos(-angle, degrees);

        if(id != -1 && (House_IsOwner(playerid, id) || hData[id][houseBuilder] == pData[playerid][pID]))
        {
            switch (listitem)
            {
                case 0:
                {
                    new furnitureid = pData[playerid][pEditFurniture];

                    pData[playerid][pEditingMode] = FURNITURE;

                    if(FurnitureData[id][furnitureid][furnitureUnused])
                    {
                        FurnitureData[id][furnitureid][furnitureUnused] = 0;
                        FurnitureData[id][furnitureid][furniturePos][0] = x;
                        FurnitureData[id][furnitureid][furniturePos][1] = y;
                        FurnitureData[id][furnitureid][furniturePos][2] = z;
                        FurnitureData[id][furnitureid][furnitureRot][0] = 0.0;
                        FurnitureData[id][furnitureid][furnitureRot][1] = 0.0;
                        FurnitureData[id][furnitureid][furnitureRot][2] = angle;

                        Furniture_Refresh(furnitureid, id);
                    }
                    EditDynamicObject(playerid, FurnitureData[id][furnitureid][furnitureObject]);
                    SendCustomMessage(playerid, "HOUSE", "You are now editing the position of item \"%s"WHITE_E"\".", FurnitureData[id][furnitureid][furnitureName]);
                }
                case 1:
                {
                    new furnitureid = pData[playerid][pEditFurniture];

                    if(FurnitureData[id][pData[playerid][pEditFurniture]][furnitureUnused])
                        return Error(playerid, "Attach this furniture first by select option \"Editing Position\"");

                    FurnitureData[id][furnitureid][furnitureUnused] = 0;
                    FurnitureData[id][furnitureid][furniturePos][0] = x;
                    FurnitureData[id][furnitureid][furniturePos][1] = y;
                    FurnitureData[id][furnitureid][furniturePos][2] = z;
                    FurnitureData[id][furnitureid][furnitureRot][0] = 0.0;
                    FurnitureData[id][furnitureid][furnitureRot][1] = 0.0;
                    FurnitureData[id][furnitureid][furnitureRot][2] = angle;

                    SetDynamicObjectPos(FurnitureData[id][furnitureid][furnitureObject], FurnitureData[id][furnitureid][furniturePos][0], FurnitureData[id][furnitureid][furniturePos][1], FurnitureData[id][furnitureid][furniturePos][2]);
                    SetDynamicObjectRot(FurnitureData[id][furnitureid][furnitureObject], FurnitureData[id][furnitureid][furnitureRot][0], FurnitureData[id][furnitureid][furnitureRot][1], FurnitureData[id][furnitureid][furnitureRot][2]);
                    Furniture_Refresh(furnitureid, id);
                    Furniture_Save(furnitureid, id);
                    SendCustomMessage(playerid, "HOUSE", "Now this furniture is moved to in front you.");
                }
                case 2:
                {
                    SendCustomMessage(playerid, "HOUSE", "You have destroyed furniture \"%s"WHITE_E"\".", FurnitureData[id][pData[playerid][pEditFurniture]][furnitureName]);
                    Furniture_Delete(pData[playerid][pEditFurniture], id);

                    CancelEdit(playerid);
                    pData[playerid][pEditFurniture] = -1;
                    pData[playerid][pEditFurnHouse] = -1;
                }
                case 3: {
                    new furnitureid = pData[playerid][pEditFurniture];

                    if (FurnitureData[id][furnitureid][furnitureUnused])
                        return Error(playerid, "This furniture is already stored");
                    
                    FurnitureData[id][furnitureid][furnitureUnused] = 1;
                    Furniture_Refresh(furnitureid, id);
                    Furniture_Save(furnitureid, id);
                    SendCustomMessage(playerid, "HOUSE", "You have stored furniture \"%s"WHITE_E"\" into your house.", FurnitureData[id][furnitureid][furnitureName]);
                }
            }
        }
        else {
            pData[playerid][pEditFurniture] = -1;
            pData[playerid][pEditFurnHouse] = -1;
        }
    }
    else {
        pData[playerid][pEditFurniture] = -1;
        pData[playerid][pEditFurnHouse] = -1;
    }
    return 1;
}
