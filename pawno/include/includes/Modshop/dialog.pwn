Dialog:EditingVehObject(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        Player_EditVehicleObjectSlot[playerid] = ListedVehObject[playerid][listitem];
        new 
            string[24],
            slot = Player_EditVehicleObjectSlot[playerid],
            vehicleid = Player_EditVehicleObject[playerid]
        ;

        format(string,sizeof(string),"Vehicle Edit Object (#%d)",Player_EditVehicleObjectSlot[playerid]);
        Dialog_Show(playerid, VACCSE, DIALOG_STYLE_LIST, "Vehicle Accesories > Edit", "Set Accesories Color\nEdit Position%s", "Select", "Back", VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_BODY ? ("\nRemove From Vehicle") : ("\nEdit Text\nRemove From Vehicle"));
    }
    return 1;
}

Dialog:VACCSE(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new 
            slot = Player_EditVehicleObjectSlot[playerid],
            vehicleid = Player_EditVehicleObject[playerid],
            modelid = VehicleObjects[vehicleid][slot][vehObjectModel]
        ;

        switch(listitem)
        {
            case 0:
            {
                if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_TEXT)
                    Dialog_Show(playerid, VACCSE, DIALOG_STYLE_LIST, "Vehicle Accesories > Edit", "Set Accesories Color\nEdit Position%s", "Select", "Back", VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_BODY ? ("\nRemove From Vehicle") : ("\nEdit Text\nRemove From Vehicle"));

				Dialog_Show(playerid, VEH_OBJECT_COLOR, DIALOG_STYLE_INPUT, "Select Index", color_string, "Select", "Close");
                Info(playerid, "You're now editing color of %s!", GetVehObjectNameByModel(modelid));
            }
            case 1:
            {
				if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_BODY)
				{
                    SetVehicleZAngle(vehicleid, 0.0);
					Vehicle_ObjectEdit(playerid, vehicleid, slot);
					Info(playerid, "You're now editing %s!", GetVehObjectNameByModel(modelid));
				}
				else
				{
                    SetVehicleZAngle(vehicleid, 0.0);
					Vehicle_ObjectEdit(playerid, vehicleid, slot, true);
					Info(playerid, "You're now editing sticker!");
				}
			}
            case 2:
            {
                if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_BODY)
                {
                    Vehicle_ObjectDelete(vehicleid, slot);
                    Info(playerid, "You removed %s from your vehicle!", GetVehObjectNameByModel(modelid));
                }
                else
                {
                    Dialog_Show(playerid, VEH_OBJECT_TEXT, DIALOG_STYLE_LIST, "Vehicle Accesories > Edit Text", "Text Name\nText Size\nText Font\nText Color", "Select", "Close");
                }
            }
            case 3:
            {
                Vehicle_ObjectDelete(vehicleid, slot);
                Info(playerid, "You removed vehicle text object!", GetVehObjectNameByModel(modelid));
            }
        }
    }
    return 1;
}

Dialog:VEH_OBJECT_COLOR(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new 
            slot = Player_EditVehicleObjectSlot[playerid],
            vehicleid = Player_EditVehicleObject[playerid]        
		;

        if(!(0 <= strval(inputtext) <= sizeof(ColorList)-1))
            return Dialog_Show(playerid, VEH_OBJECT_COLOR, DIALOG_STYLE_INPUT, "Input Color", color_string, "Update", "Close");
		
		VehicleObjects[vehicleid][slot][vehObjectColor] = strval(inputtext);
		Vehicle_ObjectColorSync(vehicleid, slot);
    }
	return 1;
}
Dialog:VEH_OBJECT_TEXT(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				Dialog_Show(playerid, VEH_OBJECT_TEXTNAME, DIALOG_STYLE_INPUT, "Input Text Name", "Input Text name 32 Character : ", "Update", "Close");
			}
			case 1:
			{
				Dialog_Show(playerid, VEH_OBJECT_TEXTSIZE, DIALOG_STYLE_INPUT, "Input Text Size", "Input Text Size Maximal Ukuran 200 : ", "Update", "Close");
			}
			case 2:
			{
				Dialog_Show(playerid, VEH_OBJECT_TEXTFONT, DIALOG_STYLE_LIST, "Input Text Font", object_font, "Update", "Close");
			}
			case 3:
			{
				Dialog_Show(playerid, VEH_OBJECT_TEXTCOLOR, DIALOG_STYLE_INPUT, "Input Text Color", color_string, "Update", "Close");
			}
		}
	}
	return 1;
}

Dialog:VEH_OBJECT_TEXTNAME(playerid, response, listitem, inputtext[])
{
	if(response)
	{
        new 
            slot = Player_EditVehicleObjectSlot[playerid],
            vehicleid = Player_EditVehicleObject[playerid]
        ;

		if(isnull(inputtext))
			return Dialog_Show(playerid, VEH_OBJECT_TEXTNAME, DIALOG_STYLE_INPUT, "Input Text Name", "Error : Text tidak boleh kosong\n\nInput Text name 32 Character : ", "Select", "Close");

		if(strlen(inputtext) > 32)
			return Dialog_Show(playerid, VEH_OBJECT_TEXTNAME, DIALOG_STYLE_INPUT, "Input Text Name", "Error : Nama lebih dari 32 karakter\n\nMasukan nama text 32 character! : ", "Select", "Close");

		format(VehicleObjects[vehicleid][slot][vehObjectText], 32, "%s", inputtext);
		Vehicle_ObjectTextSync(vehicleid, slot);
		
	}
	return 1;
}
Dialog:VEH_OBJECT_TEXTCOLOR(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new 
            slot = Player_EditVehicleObjectSlot[playerid],
            vehicleid = Player_EditVehicleObject[playerid]        
		;

        if(!(0 <= strval(inputtext) <= sizeof(ColorList)-1))
            return Dialog_Show(playerid, VEH_OBJECT_TEXTFONT, DIALOG_STYLE_INPUT, "Input Text Color", color_string, "Update", "Close");
		
		VehicleObjects[vehicleid][slot][vehObjectFontColor] = strval(inputtext);
		Vehicle_ObjectTextSync(vehicleid, slot);
    }
    return 1;
}
Dialog:VEH_OBJECT_TEXTSIZE(playerid, response, listitem, inputtext[])
{
	if(response)
	{
        new 
            slot = Player_EditVehicleObjectSlot[playerid],
            vehicleid = Player_EditVehicleObject[playerid]
        ;

		if(!(0 < strval(inputtext) <= 200))
			return Dialog_Show(playerid, VEH_OBJECT_TEXTSIZE, DIALOG_STYLE_INPUT, "Input Text Size", "Error: ukuran dibatasi mulai dari 1 sampai 200\n\nMasukkan ukuran font mulai dari angka 1 sampai 200 :", "Update", "Back");

		VehicleObjects[vehicleid][slot][vehObjectFontSize] = strval(inputtext);
		Vehicle_ObjectTextSync(vehicleid, slot);
	}
	return 1;
}

Dialog:VEH_OBJECT_TEXTFONT(playerid, response, listitem, inputtext[])
{
	if(response)
	{
        new 
            slot = Player_EditVehicleObjectSlot[playerid],
            vehicleid = Player_EditVehicleObject[playerid]
        ;

		if(listitem == sizeof(FontNames) - 1)
			return Dialog_Show(playerid, VEH_OBJECT_FONTCUSTOM, DIALOG_STYLE_INPUT, "Input Text Font - Custom Font", "Masukkan nama font yang akan kamu ubah:", "Input", "Back");

		format(VehicleObjects[vehicleid][slot][vehObjectFont], 32, "%s", inputtext);
		Vehicle_ObjectTextSync(vehicleid, slot);
	}
	return 1;
}
Dialog:VEH_OBJECT_FONTCUSTOM(playerid, response, listitem, inputtext[])
{
	if(response)
	{
        new 
            slot = Player_EditVehicleObjectSlot[playerid],
            vehicleid = Player_EditVehicleObject[playerid]
        ;
		if(!strlen(inputtext))
			return Dialog_Show(playerid, VEH_OBJECT_FONTCUSTOM, DIALOG_STYLE_INPUT, "Input Text Font - Custom Font", "Error : nama font tidak boleh kosong!\n\nMasukkan nama font yang akan kamu ubah\nPastikan nama font benar!:", "Input", "Back");

		format(VehicleObjects[vehicleid][slot][vehObjectFont], 32, "%s", inputtext);
		Vehicle_ObjectTextSync(vehicleid, slot);
	}
	return 1;
}		