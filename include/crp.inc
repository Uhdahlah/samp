
/*
	јвтор: Fro он же Fro1sha	
	ќписание: –усский текст в CR:MP
	ѕрава:  Copyright © 2009-2016 TBG

	http://tb-games.ru/	
*/

#if defined _crp_included
	#endinput
#endif
#define _crp_included
#pragma library crp

stock ConvertRusToPwn(text[])
{
	for(new i = 0; i != strlen(text); ++i)
	{
		switch(text[i])
		{
			case 'а': text[i] = 'a';
			case 'ј': text[i] = 'A';
			case 'б': text[i] = 'Ч';
		    case 'Ѕ': text[i] = 'А';
			case 'в': text[i] = 'Ґ';
		    case '¬': text[i] = 'Л';
		    case 'г': text[i] = 'Щ';
		    case '√': text[i] = 'В';
		    case 'д': text[i] = 'Ъ';
		    case 'ƒ': text[i] = 'Г';
		    case 'е': text[i] = 'e';
		    case '≈': text[i] = 'E';
		    case 'Є': text[i] = 'e';
		    case '®': text[i] = 'E';
		    case 'ж': text[i] = 'Ы';
		    case '∆': text[i] = 'Д';
		    case 'з': text[i] = 'Я';
		    case '«': text[i] = 'И';
		    case 'и': text[i] = 'Ь';
		    case '»': text[i] = 'Е';
		    case 'й': text[i] = 'Э';
		    case '…': text[i] = 'Ж';
		    case 'к': text[i] = 'k';
		    case ' ': text[i] = 'K';
		    case 'л': text[i] = 'Ю';
		    case 'Ћ': text[i] = 'З';
		    case 'м': text[i] = 'ѓ';
		    case 'ћ': text[i] = 'M';
		    case 'н': text[i] = 'Ѓ';
		    case 'Ќ': text[i] = 'H';
		    case 'о': text[i] = 'o';
		    case 'ќ': text[i] = 'O';
		    case 'п': text[i] = '£';
		    case 'ѕ': text[i] = 'М';
		    case 'р': text[i] = 'p';
		    case '–': text[i] = 'P';
		    case 'с': text[i] = 'c';
		    case '—': text[i] = 'C';
		    case 'т': text[i] = '¶';
		    case '“': text[i] = 'П';
		    case 'у': text[i] = 'y';
		    case '”': text[i] = 'Y';
		    case 'ф': text[i] = 'Ш';
		    case '‘': text[i] = 'Б';
		    case 'х': text[i] = 'x';
		    case '’': text[i] = 'X';
		    case 'ц': text[i] = '†'; // 160
		    case '÷': text[i] = 'Й';
		    case 'ч': text[i] = '§';
		    case '„': text[i] = 'Н';
		    case 'ш': text[i] = '•';
		    case 'Ў': text[i] = 'О';
		    case 'щ': text[i] = '°';
		    case 'ў': text[i] = 'К';
		    case 'ь': text[i] = '©';
		    case '№': text[i] = 'Т';
		    case 'ъ': text[i] = 'І';
		    case 'Џ': text[i] = 'Р';
		    case 'ы': text[i] = '®';
		    case 'џ': text[i] = 'С';
		    case 'э': text[i] = '™';
		    case 'Ё': text[i] = 'У';
		    case 'ю': text[i] = 'Ђ';
		    case 'ё': text[i] = 'Ф';
		    case '€': text[i] = 'ђ';
		    case 'я': text[i] = 'Х';
			case '*': text[i] = ']';
		}
	}
	
	return 1;
}

stock CRP_GameTextForAll(string[], time, style) 
{
	ConvertRusToPwn(string);
	
	return GameTextForAll(string, time, style);
}

stock CRP_GameTextForPlayer(playerid, string[], time, style) 
{
	ConvertRusToPwn(string);
	
	return GameTextForPlayer(playerid, string, time, style);
}

stock Menu:CRP_CreateMenu(title[], columns, Float:x, Float:y, Float:col1width, Float:col2width = 0.0) 
{
	ConvertRusToPwn(title);
	
	return CreateMenu(title, columns, x, y, col1width, col2width);
}

stock CRP_AddMenuItem(Menu:menuid, column, menutext[]) 
{
	ConvertRusToPwn(menutext);

	return AddMenuItem(menuid, column, menutext);
}

stock CRP_SetMenuColumnHeader(Menu:menuid, column, columnheader[]) 
{
	ConvertRusToPwn(columnheader);
	
	return SetMenuColumnHeader(menuid, column, columnheader);
}

stock Text:CRP_TextDrawCreate(Float:x, Float:y, text[]) 
{
	ConvertRusToPwn(text);
	
	return TextDrawCreate(x, y, text);
}

stock CRP_TextDrawSetString(Text:text, string[]) 
{
	ConvertRusToPwn(string);
	
	return TextDrawSetString(text, string);
}

stock PlayerText:CRP_CreatePlayerTextDraw(playerid, Float:x, Float:y, text[]) 
{
	ConvertRusToPwn(text);
	
	return CreatePlayerTextDraw(playerid, x, y, text);
}

stock CRP_PlayerTextDrawSetString(playerid, PlayerText:text, string[]) 
{
	ConvertRusToPwn(string);
	
	return PlayerTextDrawSetString(playerid, text, string);
}

#if defined _ALS_GameTextForAll
    #undef GameTextForAll
#else
    #define _ALS_GameTextForAll
#endif
#define GameTextForAll CRP_GameTextForAll

#if defined _ALS_GameTextForPlayer
    #undef GameTextForPlayer
#else
    #define _ALS_GameTextForPlayer
#endif
#define GameTextForPlayer CRP_GameTextForPlayer
/*
#if defined _ALS_CreateMenu
    #undef CreateMenu
#else
    #define _ALS_CreateMenu
#endif
#define CreateMenu CRP_CreateMenu

#if defined _ALS_AddMenuItem
    #undef AddMenuItem
#else
    #define _ALS_AddMenuItem
#endif
#define AddMenuItem CRP_AddMenuItem

#if defined _ALS_SetMenuColumnHeader
    #undef SetMenuColumnHeader
#else
    #define _ALS_SetMenuColumnHeader
#endif
#define SetMenuColumnHeader CRP_SetMenuColumnHeader
*/
#if defined _ALS_TextDrawCreate
    #undef TextDrawCreate
#else
    #define _ALS_TextDrawCreate
#endif
#define TextDrawCreate CRP_TextDrawCreate

#if defined _ALS_TextDrawSetString
    #undef TextDrawSetString
#else
    #define _ALS_TextDrawSetString
#endif
#define TextDrawSetString CRP_TextDrawSetString

#if defined _ALS_CreatePlayerTextDraw
    #undef CreatePlayerTextDraw
#else
    #define _ALS_CreatePlayerTextDraw
#endif
#define CreatePlayerTextDraw CRP_CreatePlayerTextDraw

#if defined _ALS_PlayerTextDrawSetString
    #undef PlayerTextDrawSetString
#else
    #define _ALS_PlayerTextDrawSetString
#endif
#define PlayerTextDrawSetString CRP_PlayerTextDrawSetString