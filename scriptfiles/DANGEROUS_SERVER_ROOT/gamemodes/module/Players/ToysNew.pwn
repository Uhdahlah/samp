#define MAX_ACC                         (5)


enum acce {
    accID,
    accName[32],
    accExists,
    accColor1[3],
    accColor2[3],
    accModel,
    accBone,
    accShow,
    Float:accOffset[3],
    Float:accRot[3],
    Float:accScale[3],
};

new AccData[MAX_PLAYERS][MAX_ACC][acce];

enum g_accList
{
    accListType,
    accListModel,
    accListName[24]
};

new const accList[][g_accList] =
{
    //Cap
    {1,18955,"CapOverEye1"},
    {1,18956,"CapOverEye2"},
    {1,18957,"CapOverEye3"},
    {1,18958,"CapOverEye4"},
    {1,18959,"CapOverEye5"},
    {1,19553,"StrawHat1"},
    {1,19554,"Beanie1"},
    {1,19558,"19558"},
    {1,18639,"BlackHat1"},
    {1,18638,"HardHat1"},
    {1,19097,"CowboyHat4"},
    {1,19096,"CowboyHat3"},
    {1,18964,"SkullyCap1"},
    {1,18969,"HatMan1"},
    {1,18968,"HatMan2"},
    {1,18967,"HatMan3"},
    {1,18950,"HatBowler4"},
    {1,18948,"HatBowler2"},
    {1,18949,"HatBowler3"},
    {1,19137,"CluckinBellHat1"},
    {1,18926,"Hat1"},
    {1,18927,"Hat2"},
    {1,18928,"Hat3"},
    {1,18940,"CapBack3"},
    {1,18943,"CapBack5"},
    {1,18922,"Beret2"},
    {1,18921,"Beret1"},
    {1,18923,"Beret3"},
    {1,9067,"HoodyHat1"},
    {1,19069,"HoodyHat3"},
    {1,19161,"PoliceHat1"},

    //Bandana
    {2,18891, "Bandana1"},
    {2,18892, "Bandana2"},
    {2,18893, "Bandana3"},
    {2,18894, "Bandana4"},
    {2,18895, "Bandana5"},
    {2,18896, "Bandana6"},
    {2,18897, "Bandana7"},
    {2,18898, "Bandana8"},
    {2,18899, "Bandana9"},
    {2,18900, "Bandana10"},
    {2,18901, "Bandana11"},
    {2,18902, "Bandana12"},
    {2,18903, "Bandana13"},
    {2,18904, "Bandana14"},
    {2,18905, "Bandana15"},
    {2,18906, "Bandana16"},
    {2,18907, "Bandana17"},
    {2,18908, "Bandana18"},
    {2,18909, "Bandana19"},
    {2,18910, "Bandana20"},
    
    //Mask
    {3,18911, "Mask1"},
    {3,18912, "Mask2"},
    {3,18913, "Mask3"},
    {3,18914, "Mask4"},
    {3,18915, "Mask5"},
    {3,18916, "Mask6"},
    {3,18917, "Mask7"},
    {3,18918, "Mask8"},
    {3,18919, "Mask9"},
    {3,18920, "Mask10"},
    {3,19036,"HockeyMask1"},
    {3,18974,"MaskZorro1"},
    {3,19163,"GimpMask1"},

    //Helmet
    {4,19113, "SillyHelmet1"},
    {4,19114, "SillyHelmet2"},
    {4,19115, "SillyHelmet3"},
    {4,19116, "PlainHelmet1"},
    {4,19117, "PlainHelmet2"},
    {4,19118, "PlainHelmet3"},
    {4,19119, "PlainHelmet4"},
    {4,19120, "PlainHelmet5"},
    {4,18976, "MotorcycleHelmet2"},
    {4,18977, "MotorcycleHelmet3"},
    {4,18978, "MotorcycleHelmet4"},
    {4,18979, "MotorcycleHelmet5"},

    //Watch
    {5,19039, "WatchType1"},
    {5,19040, "WatchType2"},
    {5,19041, "WatchType3"},
    {5,19042, "WatchType4"},
    {5,19043, "WatchType5"},
    {5,19044, "WatchType6"},
    {5,19045, "WatchType7"},
    {5,19046, "WatchType8"},
    {5,19047, "WatchType9"},
    {5,19048, "WatchType10"},
    {5,19049, "WatchType11"},
    {5,19050, "WatchType12"},
    {5,19051, "WatchType13"},
    {5,19052, "WatchType14"},
    {5,19053, "WatchType15"},
    
    //Glasses
    {6,19006, "GlassesType1"},
    {6,19007, "GlassesType2"},
    {6,19008, "GlassesType3"},
    {6,19009, "GlassesType4"},
    {6,19010, "GlassesType5"},
    {6,19011, "GlassesType6"},
    {6,19012, "GlassesType7"},
    {6,19013, "GlassesType8"},
    {6,19014, "GlassesType9"},
    {6,19015, "GlassesType10"},
    {6,19016, "GlassesType11"},
    {6,19017, "GlassesType12"},
    {6,19018, "GlassesType13"},
    {6,19019, "GlassesType14"},
    {6,19020, "GlassesType15"},
    {6,19021, "GlassesType16"},
    {6,19022, "GlassesType17"},
    {6,19023, "GlassesType18"},
    {6,19024, "GlassesType19"},
    {6,19025, "GlassesType20"},
    {6,19026, "GlassesType21"},
    {6,19027, "GlassesType22"},
    {6,19028, "GlassesType23"},
    {6,19029, "GlassesType24"},
    {6,19030, "GlassesType25"},
    {6,19031, "GlassesType26"},
    {6,19032, "GlassesType27"},
    {6,19033, "GlassesType28"},
    {6,19034, "GlassesType29"},
    {6,19035, "GlassesType30"},

    // Hair
    {7,19517,"Hair 1"},
    {7,19516,"Hair 2"},
    {7,19274,"Hair 3"},
    {7,19518,"Hair 4"},
    {7,19519,"Hair 5"},
    {7,19077,"Hair 6"},
    {7,18975,"Hair 7"},
    {7,18640,"Hair 8"},
    
    //Misc
    {8,19896,"CigarettePack1"},
    {8,19897,"CigarettePack2"},
    {8,19904,"ConstructionVest1"},
    {8,19942,"PoliceRadio1"},
    {8,19801,"Balaclava1"},
    {8,19623,"Camera1"},
    {8,19625,"Ciggy1"},
    {8,1485,"Ciggy2"},
    {8,19624,"Case1"},
    {8,19559,"HikerBackpack1"},
    {8,19556,"BoxingGloveR"},
    {8,19555,"BoxingGloveL"},
    {8,19142,"SWATARMOUR1"},
    {8,19141,"SWATHELMET1"},
    {8,19520,"pilotHat01"},
    {8,19521,"policeHat01"},
    {8,19515,"SWATAgrey"},
    {8,19330,"fire_hat01"},
    {8,1550,"CJ_MONEY_BAG"},
    {8,19347,"badge01"},
    {8,371,"gun_para"},
    // {8,2919,"kmb_holdall"}
    {8,11745,"Dufflebag"},
    {8,19317,"Guitar 1"},
    {8,19318,"Guitar 2"},
    {8,19610,"Mic"},
    {8,19611,"Mic Stand"},
    {8,18632,"Fishing Rod"}
};

stock const accBones[][24] = {
    {"Spine"},
    {"Head"},
    {"Left upper arm"},
    {"Right upper arm"},
    {"Left hand"},
    {"Right hand"},
    {"Left thigh"},
    {"Right thigh"},
    {"Left foot"},
    {"Right foot"},
    {"Right calf"},
    {"Left calf"},
    {"Left forearm"},
    {"Right forearm"},
    {"Left clavicle"},
    {"Right clavicle"},
    {"Neck"},
    {"Jaw"}
};

new ListedAcc[MAX_PLAYERS][MAX_ACC];


MySQL_LoadPlayerToys(playerid)
{
	mysql_tquery(g_SQL, sprintf("SELECT * FROM `aksesoris` WHERE `accID` = '%d' ORDER BY `accID` DESC LIMIT %d", pData[playerid][pID], MAX_ACC), "LoadPlayerToys", "d", playerid);
}

function LoadPlayerToys(extraid)
{
	static
		string[128];
    new rows;
	rows = cache_num_rows();

	for (new i = 0; i != rows; i ++) {
		AccData[extraid][i][accExists] = true;

		cache_get_value(i, "Type", AccData[extraid][i][accName], 32);
		
		cache_get_value(i, "Color1", string);
		sscanf(string, "p<|>ddd",AccData[extraid][i][accColor1][0],AccData[extraid][i][accColor1][1],AccData[extraid][i][accColor1][2]);
		
		cache_get_value(i, "Color2", string);
		sscanf(string, "p<|>ddd",AccData[extraid][i][accColor2][0],AccData[extraid][i][accColor2][1],AccData[extraid][i][accColor2][2]);
		
		cache_get_value(i, "Offset", string);
		sscanf(string, "p<|>fff",AccData[extraid][i][accOffset][0],AccData[extraid][i][accOffset][1],AccData[extraid][i][accOffset][2]);

		cache_get_value(i, "Rot", string);
		sscanf(string, "p<|>fff",AccData[extraid][i][accRot][0],AccData[extraid][i][accRot][1],AccData[extraid][i][accRot][2]);

		cache_get_value(i, "Scale", string);
		sscanf(string, "p<|>fff",AccData[extraid][i][accScale][0],AccData[extraid][i][accScale][1],AccData[extraid][i][accScale][2]);

		cache_get_value_int(i, "ID", AccData[extraid][i][accID]);
		cache_get_value_int(i, "Model", AccData[extraid][i][accModel]);
		cache_get_value_int(i, "Bone", AccData[extraid][i][accBone]);
		cache_get_value_int(i, "Show", AccData[extraid][i][accShow]);
		
		if (AccData[extraid][i][accShow])
			Aksesoris_Attach(extraid, i);
	}
	return 1;
}


Aksesoris_Attach(playerid, index)
{
    SetPlayerAttachedObject(playerid,index, AccData[playerid][index][accModel], AccData[playerid][index][accBone],
        AccData[playerid][index][accOffset][0], AccData[playerid][index][accOffset][1], AccData[playerid][index][accOffset][2],
        AccData[playerid][index][accRot][0], AccData[playerid][index][accRot][1], AccData[playerid][index][accRot][2],
        AccData[playerid][index][accScale][0], AccData[playerid][index][accScale][1], AccData[playerid][index][accScale][2], RGBAToARGB(GetRGBColor(playerid, index, 1)), RGBAToARGB(GetRGBColor(playerid, index, 2)));
            
    AccData[playerid][index][accShow] = 1;
            
    MySQL_SavePlayerToys(playerid, index);
    return 1;
}

MySQL_SavePlayerToys(playerid, id)
{
    new query[1024],
        bone = (!AccData[playerid][id][accBone]) ? (1) : (AccData[playerid][id][accBone]);

    format(query,sizeof(query),"UPDATE `aksesoris` SET `Model`='%d',`Bone`='%d',`Color1`='%03d|%03d|%03d',`Color2`='%d|%d|%d',`Offset`='%.04f|%.04f|%.04f',`Rot`='%.04f|%.04f|%.04f'",
        AccData[playerid][id][accModel],
        bone,
        AccData[playerid][id][accColor1][0],
        AccData[playerid][id][accColor1][1],
        AccData[playerid][id][accColor1][2],
        AccData[playerid][id][accColor2][0],
        AccData[playerid][id][accColor2][1],
        AccData[playerid][id][accColor2][2],
        AccData[playerid][id][accOffset][0],
        AccData[playerid][id][accOffset][1],
        AccData[playerid][id][accOffset][2],
        AccData[playerid][id][accRot][0],
        AccData[playerid][id][accRot][1],
        AccData[playerid][id][accRot][2]
    );

    format(query,sizeof(query),"%s,`Scale`='%.04f|%.04f|%.04f', `Type`='%s', `Show`='%d' WHERE `ID` = '%d'",
        query,
        AccData[playerid][id][accScale][0],
        AccData[playerid][id][accScale][1],
        AccData[playerid][id][accScale][2],
        AccData[playerid][id][accName],
        AccData[playerid][id][accShow],
        AccData[playerid][id][accID]
    );

    return mysql_tquery(g_SQL, query);
}

Aksesoris_GetCount(playerid)
{
    new count;
    for (new i = 0; i != MAX_ACC; i++) if(AccData[playerid][i][accExists]) {
        count++;
    }
    return count;
}

Aksesoris_Create(playerid, model, name[])
{
    new query[128];
    
    for (new i = 0; i != MAX_ACC; i++) if(!AccData[playerid][i][accExists]) {
        AccData[playerid][i][accExists] = 1;
        AccData[playerid][i][accShow] = 1;
        format(AccData[playerid][i][accName], 32, name);
        
        AccData[playerid][i][accModel] = model;
        
        AccData[playerid][i][accBone] = 1;
        
        pData[playerid][pAksesoris] = i;
        AccData[playerid][i][accColor1][0] = AccData[playerid][i][accColor1][1] = AccData[playerid][i][accColor1][2] = 255;
        AccData[playerid][i][accColor2][0] = AccData[playerid][i][accColor2][1] = AccData[playerid][i][accColor2][2] = 255;
        
        AccData[playerid][i][accScale][0] = AccData[playerid][i][accScale][1] = AccData[playerid][i][accScale][2] = 1.0;

        format(query,sizeof(query),"INSERT INTO `aksesoris` (`accID`) VALUES (%d)", pData[playerid][pID]);
        mysql_tquery(g_SQL, query, "OnAksesorisCreated", "dd", playerid, i);
        
        return i;
    }
    return 1;
}

function OnAksesorisCreated(playerid, id)
{
    AccData[playerid][id][accID] = cache_insert_id();
    MySQL_SavePlayerToys(playerid, id);
    Aksesoris_Attach(playerid, id);

    new string[256+1];
    for(new i; i < sizeof(accBones); i++)
    {
        format(string,sizeof(string),"%s%s\n",string,accBones[i]);
    }
    Dialog_Show(playerid, AksesorisBone, DIALOG_STYLE_LIST, "Edit Bone",string,"Select","Close");
    SendCustomMessage(playerid, "ACCESORY","Accessory created, type /dyoc to edit this accessory.");
    return 1;
}

CMD:destroyacc(playerid, params[]) {
    if (pData[playerid][pAdmin] < 5)
        return PermissionError(playerid);

    new userid,index;
    if (sscanf(params, "ud", userid,index))
        return Usage(playerid, "/destroyacc [playerid/name] [acc index]");
    
    new string[128];
    AccData[userid][index][accExists] = 0;
    AccData[userid][index][accModel] = 0;
    
    if(IsPlayerAttachedObjectSlotUsed(userid, index))
    {
        RemovePlayerAttachedObject(userid, index);
        AccData[userid][index][accShow] = 0;
        MySQL_SavePlayerToys(userid, index);
    }
    format(string,sizeof(string),"DELETE FROM `aksesoris` WHERE `ID`='%d'", AccData[userid][index][accID]);
    mysql_tquery(g_SQL, string);
    
    SendCustomMessage(playerid, "ACCESORY","You have removed %s accessory index #%d.", ReturnName(userid), index);
    SendCustomMessage(userid, "ACCESORY","%s has removed your accessory index #%d.", ReturnName(playerid), index);
    return 1;
}

CMD:dyoc(playerid)
{
    new info[300],
        count = 0;

    strcat(info,"Index\tName\tBone\n");
    for (new id = 0; id != MAX_ACC; id++) if(AccData[playerid][id][accExists]) {
        if (!AccData[playerid][id][accBone]) { // proteksi buat player android
            AccData[playerid][id][accBone] = 1;
        }
        strcat(info,sprintf("%d\t%s\t%s\n", id, AccData[playerid][id][accName], accBones[AccData[playerid][id][accBone]-1]));
        if (count < 5) {
            ListedAcc[playerid][count] = id;
            count++;
        }
    }
    if(!count) Error(playerid, "You don't have some accesories.");
    else Dialog_Show(playerid, Aksesoris, DIALOG_STYLE_TABLIST_HEADERS, "Editing Accesories", info, "Select","Exit");
    return 1;
}

Dialog:Aksesoris(playerid, response, listitem, inputtext[])
{
    new string[24];
    if(response)
    {
        pData[playerid][pAksesoris] = ListedAcc[playerid][listitem];

        format(string,sizeof(string),"Edit Accessory (#%d)",pData[playerid][pAksesoris]);
        Dialog_Show(playerid, AksesorisEdit, DIALOG_STYLE_LIST, string, "Place %s\nChange Bone\nChange Placement\nChange Color 1\nChange Color 2\nRemove from list\nShare Placement\nChange Placement (Android)", "Select", "Exit", IsPlayerAttachedObjectSlotUsed(playerid, pData[playerid][pAksesoris]) ? ("Off") : ("On"));
    }
    return 1;
}

Dialog:AksesorisEdit(playerid, response, listitem, inputtext[])
{
    new id = pData[playerid][pAksesoris], str[256];
    if(response)
    {
        switch(listitem)
        {
            case 0:
            {
                if(IsPlayerAttachedObjectSlotUsed(playerid, id))
                {
                    RemovePlayerAttachedObject(playerid, id);
                    AccData[playerid][id][accShow] = 0;
                    MySQL_SavePlayerToys(playerid, id);
                }
                else Aksesoris_Attach(playerid, id);
            }
            case 1:
            {
                new string[256+1];
                for(new i; i < sizeof(accBones); i++)
                {
                        format(string,sizeof(string),"%s%s\n",string,accBones[i]);
                }
                Dialog_Show(playerid, AksesorisBone, DIALOG_STYLE_LIST, "Edit Bone",string,"Select","Close");
            }
            case 2:
            {                    
                if(IsPlayerAttachedObjectSlotUsed(playerid, id))
                {
                    Servers(playerid, "Use "YELLOW_E"~k~~PED_SPRINT~"WHITE_E" to look around.");
                    EditAttachedObject(playerid, id);
                }
                else return SendCustomMessage(playerid, "ACCESORY","This accessory is not attached.");
            }
            case 3:
            {                    
                if(!IsPlayerAttachedObjectSlotUsed(playerid, id))
                    return SendCustomMessage(playerid, "ACCESORY","This accessory is not attached.");

                Dialog_Show(playerid, WarnaAksesoris, DIALOG_STYLE_INPUT, "Accessory Color 1",color_string, "Choose","Close");
                SetPVarInt(playerid, "Color", 1);
            }
            case 4:
            {
                if(!IsPlayerAttachedObjectSlotUsed(playerid, id))
                    return SendCustomMessage(playerid, "ACCESORY","This accessory is not attached.");
                        
                Dialog_Show(playerid, WarnaAksesoris, DIALOG_STYLE_INPUT, "Accessory Color 2",color_string, "Choose","Close");
                SetPVarInt(playerid, "Color", 2);
            }
            case 5:
            {
                new string[128];
                AccData[playerid][id][accExists] = 0;
                AccData[playerid][id][accModel] = 0;
                
                if(IsPlayerAttachedObjectSlotUsed(playerid, id))
                {
                    RemovePlayerAttachedObject(playerid, id);
                    AccData[playerid][id][accShow] = 0;
                    MySQL_SavePlayerToys(playerid, id);
                }
                format(string,sizeof(string),"DELETE FROM `aksesoris` WHERE `ID`='%d'", AccData[playerid][id][accID]);
                mysql_tquery(g_SQL, string);
                
                SendCustomMessage(playerid, "ACCESORY","You have removed accessory index #%d.", id);
            }
            case 6: {
                format(str,sizeof(str),"Pos X: %.3f\n",AccData[playerid][id][accOffset][0]);
                format(str,sizeof(str),"%sPos Y: %.3f\n",str,AccData[playerid][id][accOffset][1]);
                format(str,sizeof(str),"%sPos Z: %.3f\n",str,AccData[playerid][id][accOffset][2]);
                format(str,sizeof(str),"%sPos RotX: %.3f\n",str,AccData[playerid][id][accRot][0]);
                format(str,sizeof(str),"%sPos RotY: %.3f\n",str,AccData[playerid][id][accRot][1]);
                format(str,sizeof(str),"%sPos RotZ: %.3f\n",str,AccData[playerid][id][accRot][2]);
                format(str,sizeof(str),"%sPos ScaleX: %.3f\n",str,AccData[playerid][id][accScale][0]);
                format(str,sizeof(str),"%sPos ScaleY: %.3f\n",str,AccData[playerid][id][accScale][1]);
                format(str,sizeof(str),"%sPos ScaleZ: %.3f",str,AccData[playerid][id][accScale][2]);
                Dialog_Show(playerid, DisplayOnly, DIALOG_STYLE_LIST, "Share Accessories Position", str, "Close", "");
            }
            case 7: {
                if(!IsPlayerAttachedObjectSlotUsed(playerid, id))
                    return SendCustomMessage(playerid, "ACCESORY","This accessory is not attached.");

                format(str,sizeof(str),"Position\tValue\n");
                format(str,sizeof(str),"%sX\t%.3f\n",str,AccData[playerid][id][accOffset][0]);
                format(str,sizeof(str),"%sY\t%.3f\n",str,AccData[playerid][id][accOffset][1]);
                format(str,sizeof(str),"%sZ\t%.3f\n",str,AccData[playerid][id][accOffset][2]);
                format(str,sizeof(str),"%sRotX\t%.3f\n",str,AccData[playerid][id][accRot][0]);
                format(str,sizeof(str),"%sRotY\t%.3f\n",str,AccData[playerid][id][accRot][1]);
                format(str,sizeof(str),"%sRotZ\t%.3f\n",str,AccData[playerid][id][accRot][2]);
                format(str,sizeof(str),"%sScaleX\t%.3f\n",str,AccData[playerid][id][accScale][0]);
                format(str,sizeof(str),"%sScaleY\t%.3f\n",str,AccData[playerid][id][accScale][1]);
                format(str,sizeof(str),"%sScaleZ\t%.3f",str,AccData[playerid][id][accScale][2]);
                Dialog_Show(playerid, EditAksesorisAndroid, DIALOG_STYLE_TABLIST_HEADERS, "Edit Placement (Android)", str, "Change", "Close");
            }
        }
    }
    return 1;
}

Dialog:WarnaAksesoris(playerid, response, listitem, inputtext[])
{
    new id = pData[playerid][pAksesoris];
    if(response)
    {
        new color = strval(inputtext);
        
        if(!(0 <= color <= sizeof(ColorList)-1)) 
            return Error(playerid, "Invalid color ID.");
        
        switch(GetPVarInt(playerid, "Color"))
        {
            case 1: GetRGB(ColorList[color], AccData[playerid][id][accColor1][0], AccData[playerid][id][accColor1][1], AccData[playerid][id][accColor1][2]);
            case 2: GetRGB(ColorList[color], AccData[playerid][id][accColor2][0], AccData[playerid][id][accColor2][1], AccData[playerid][id][accColor2][2]);
        }
        Aksesoris_Attach(playerid, id);
    }
    return 1;
}

Dialog:AksesorisBone(playerid, response, listitem, inputtext[])
{
    new id = pData[playerid][pAksesoris];
    if(response)
    {
        if (listitem != -1) {
            AccData[playerid][id][accBone] = listitem+1;
            if(IsPlayerAttachedObjectSlotUsed(playerid, id))
            {
                RemovePlayerAttachedObject(playerid, id);
                AccData[playerid][id][accScale][0] = AccData[playerid][id][accScale][1] = AccData[playerid][id][accScale][2] = 1.0;
                AccData[playerid][id][accOffset][0] = AccData[playerid][id][accOffset][1] = AccData[playerid][id][accOffset][2] = 0.0;
                AccData[playerid][id][accRot][0] = AccData[playerid][id][accRot][1] = AccData[playerid][id][accRot][2] = 0.0;
            
                Aksesoris_Attach(playerid, id);
                EditAttachedObject(playerid, id);
            }
            SendCustomMessage(playerid, "ACCESORY","You have been changed accessory bone index #%d to %s", id, accBones[listitem]);
        }
    }
    return 1;
}

Dialog:EditAksesorisAndroid(playerid, response, listitem, inputtext[]) {
    new id = pData[playerid][pAksesoris];
    if (response) {
        switch (listitem) {
            case 0: {
                new str[128];
                SetPVarInt(playerid, "aksesorisEdit", 1);
                format(str,sizeof(str),"Current X Position: %.3f\nInput new X Position below:", AccData[playerid][id][accOffset][0]);
                Dialog_Show(playerid, EditAksesorisPos, DIALOG_STYLE_INPUT, "Edit X Position", str, "Change", "Close");
            }
            case 1: {
                new str[128];
                SetPVarInt(playerid, "aksesorisEdit", 2);
                format(str,sizeof(str),"Current Y Position: %.3f\nInput new Y Position below:", AccData[playerid][id][accOffset][1]);
                Dialog_Show(playerid, EditAksesorisPos, DIALOG_STYLE_INPUT, "Edit Y Position", str, "Change", "Close");
            }
            case 2: {
                new str[128];
                SetPVarInt(playerid, "aksesorisEdit", 3);
                format(str,sizeof(str),"Current Z Position: %.3f\nInput new Z Position below:", AccData[playerid][id][accOffset][2]);
                Dialog_Show(playerid, EditAksesorisPos, DIALOG_STYLE_INPUT, "Edit Z Position", str, "Change", "Close");
            }
            case 3: {
                new str[128];
                SetPVarInt(playerid, "aksesorisEdit", 4);
                format(str,sizeof(str),"Current RotX Position: %.3f\nInput new RotX Position below:", AccData[playerid][id][accRot][0]);
                Dialog_Show(playerid, EditAksesorisPos, DIALOG_STYLE_INPUT, "Edit RotX Position", str, "Change", "Close");
            }
            case 4: {
                new str[128];
                SetPVarInt(playerid, "aksesorisEdit", 5);
                format(str,sizeof(str),"Current RotY Position: %.3f\nInput new RotY Position below:", AccData[playerid][id][accRot][1]);
                Dialog_Show(playerid, EditAksesorisPos, DIALOG_STYLE_INPUT, "Edit RotY Position", str, "Change", "Close");
            }
            case 5: {
                new str[128];
                SetPVarInt(playerid, "aksesorisEdit", 6);
                format(str,sizeof(str),"Current RotZ Position: %.3f\nInput new RotZ Position below:", AccData[playerid][id][accRot][2]);
                Dialog_Show(playerid, EditAksesorisPos, DIALOG_STYLE_INPUT, "Edit RotZ Position", str, "Change", "Close");
            }
            case 6: {
                new str[128];
                SetPVarInt(playerid, "aksesorisEdit", 7);
                format(str,sizeof(str),"Current ScaleX Position: %.3f\nInput new ScaleX Position below:", AccData[playerid][id][accScale][0]);
                Dialog_Show(playerid, EditAksesorisPos, DIALOG_STYLE_INPUT, "Edit ScaleX Position", str, "Change", "Close");
            }
            case 7: {
                new str[128];
                SetPVarInt(playerid, "aksesorisEdit", 8);
                format(str,sizeof(str),"Current ScaleY Position: %.3f\nInput new ScaleY Position below:", AccData[playerid][id][accScale][1]);
                Dialog_Show(playerid, EditAksesorisPos, DIALOG_STYLE_INPUT, "Edit ScaleY Position", str, "Change", "Close");
            }
            case 8: {
                new str[128];
                SetPVarInt(playerid, "aksesorisEdit", 9);
                format(str,sizeof(str),"Current ScaleZ Position: %.3f\nInput new ScaleZ Position below:", AccData[playerid][id][accScale][2]);
                Dialog_Show(playerid, EditAksesorisPos, DIALOG_STYLE_INPUT, "Edit ScaleZ Position", str, "Change", "Close");
            }
        }
    } else {
        pData[playerid][pAksesoris] = -1;
    }
    return 1;
}

Dialog:EditAksesorisPos(playerid, response, listitem, inputtext[]) {
    new id = pData[playerid][pAksesoris];
    if (response) {
        switch (GetPVarInt(playerid, "aksesorisEdit")) {
            // X Position
            case 1: {
                new Float:X = floatstr(inputtext);

                AccData[playerid][id][accOffset][0] = X;
                Aksesoris_Attach(playerid, id);
                pData[playerid][pAksesoris] = -1;  
                SetPVarInt(playerid, "aksesorisEdit", 0);
                SendCustomMessage(playerid, "ACCESORY","Accessory saved!.");
            }
            // Y Position
            case 2: {
                new Float:Y = floatstr(inputtext);

                AccData[playerid][id][accOffset][1] = Y;
                Aksesoris_Attach(playerid, id);
                pData[playerid][pAksesoris] = -1;  
                SetPVarInt(playerid, "aksesorisEdit", 0);
                SendCustomMessage(playerid, "ACCESORY","Accessory saved!.");
            }
            // Z Position
            case 3: {
                new Float:Z = floatstr(inputtext);

                AccData[playerid][id][accOffset][2] = Z;
                Aksesoris_Attach(playerid, id);
                pData[playerid][pAksesoris] = -1;  
                SetPVarInt(playerid, "aksesorisEdit", 0);
                SendCustomMessage(playerid, "ACCESORY","Accessory saved!.");
            }
            // RotX Position
            case 4: {
                new Float:RotX = floatstr(inputtext);

                AccData[playerid][id][accRot][0] = RotX;
                Aksesoris_Attach(playerid, id);
                pData[playerid][pAksesoris] = -1;  
                SetPVarInt(playerid, "aksesorisEdit", 0);
                SendCustomMessage(playerid, "ACCESORY","Accessory saved!.");
            }
            // RotY Position
            case 5: {
                new Float:RotY = floatstr(inputtext);

                AccData[playerid][id][accRot][1] = RotY;
                Aksesoris_Attach(playerid, id);
                pData[playerid][pAksesoris] = -1;  
                SetPVarInt(playerid, "aksesorisEdit", 0);
                SendCustomMessage(playerid, "ACCESORY","Accessory saved!.");
            }
            // RotZ Position
            case 6: {
                new Float:RotZ = floatstr(inputtext);

                AccData[playerid][id][accRot][2] = RotZ;
                Aksesoris_Attach(playerid, id);
                pData[playerid][pAksesoris] = -1;  
                SetPVarInt(playerid, "aksesorisEdit", 0);
                SendCustomMessage(playerid, "ACCESORY","Accessory saved!.");
            }
            // ScaleX Position
            case 7: {
                new Float:ScaleX = floatstr(inputtext);

                AccData[playerid][id][accScale][0] = ScaleX;
                Aksesoris_Attach(playerid, id);
                pData[playerid][pAksesoris] = -1;  
                SetPVarInt(playerid, "aksesorisEdit", 0);
                SendCustomMessage(playerid, "ACCESORY","Accessory saved!.");
            }
            // Scale Y Position
            case 8: {
                new Float:ScaleY = floatstr(inputtext);

                AccData[playerid][id][accScale][1] = ScaleY;
                Aksesoris_Attach(playerid, id);
                pData[playerid][pAksesoris] = -1;  
                SetPVarInt(playerid, "aksesorisEdit", 0);
                SendCustomMessage(playerid, "ACCESORY","Accessory saved!.");
            }
            // Scale Z Position
            case 9: {
                new Float:ScaleZ = floatstr(inputtext);

                AccData[playerid][id][accScale][2] = ScaleZ;
                Aksesoris_Attach(playerid, id);
                pData[playerid][pAksesoris] = -1;  
                SetPVarInt(playerid, "aksesorisEdit", 0);
                SendCustomMessage(playerid, "ACCESORY","Accessory saved!.");
            }
        }
    } else {
        pData[playerid][pAksesoris] = -1;
    }
    return 1;
}
 
GetRGB(color, &r, &g, &b)
{
    new col[3 char];
    col[0] = color;
    r = col{0};
    g = col{1};
    b = col{2};
}

GetRGBColor(playerid, id, type = 0)
{
    if(!type) return 0;
    else if(type == 1) return AccData[playerid][id][accColor1][0] << 24 | AccData[playerid][id][accColor1][0] << 16 | AccData[playerid][id][accColor1][0] << 8 | 0xFF;
    else if(type == 2) return AccData[playerid][id][accColor2][0] << 24 | AccData[playerid][id][accColor2][0] << 16 | AccData[playerid][id][accColor2][0] << 8 | 0xFF;
    else return 0;
}

GetAksesorisNameByModel(model)
{
    new
        name[32];

    for (new i = 0; i < sizeof(accList); i ++) if(accList[i][accListModel] == model) {
        strcat(name, accList[i][accListName]);

        break;
    }
    return name;
}