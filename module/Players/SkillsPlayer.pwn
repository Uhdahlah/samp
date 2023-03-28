
CMD:skills(playerid)
{
   if(pData[playerid][IsLoggedIn] == false)
      return Error(playerid, "You must logged in!");
   new irwan[1000], string[1000];
   new bool:found = false;
   strcat(irwan, "Name Skills\tScore\tLevel\n");
   if(pData[playerid][LevelTrucker] < 50)
   {
      format(string, sizeof(string), "Trucker\t"YELLOW_E"[%d/50]\t"WHITE_E"1\n", pData[playerid][LevelTrucker]);
      strcat(irwan, string);
      found = true;
   }
   else if(pData[playerid][LevelTrucker] < 150)
   {
      format(string, sizeof(string), "Trucker\t"YELLOW_E"[%d/150]\t"WHITE_E"2\n", pData[playerid][LevelTrucker]);
      strcat(irwan, string);
      found = true;
   }
   else if(pData[playerid][LevelTrucker] < 200)
   {
      format(string, sizeof(string), "Trucker\t"YELLOW_E"[%d/200]\t"WHITE_E"3\n", pData[playerid][LevelTrucker]);
      strcat(irwan, string);
      found = true;
   }
   else if(pData[playerid][LevelTrucker] < 300)
   {
      format(string, sizeof(string), "Trucker\t"YELLOW_E"[%d/300]\t"WHITE_E"4\n", pData[playerid][LevelTrucker]);
      strcat(irwan, string);
      found = true;
   }
   else if(pData[playerid][LevelTrucker] > 300)
   {
      format(string, sizeof(string), "Trucker\t"YELLOW_E"[%d/MAX]\t"WHITE_E"5\n", pData[playerid][LevelTrucker]);
      strcat(irwan, string);
      found = true;
   }
   if(pData[playerid][LevelFishing] < 99)
   {
      format(string, sizeof(string), "Fish\t"YELLOW_E"[%d/100]\t"WHITE_E"1\n", pData[playerid][LevelFishing]);
      strcat(irwan, string);
      found = true;
   }
   else if(pData[playerid][LevelFishing] > 99)
   {
      format(string, sizeof(string), "Fish\t"YELLOW_E"[%d/MAX]\t"WHITE_E"2\n", pData[playerid][LevelFishing]);
      strcat(irwan, string);
      found = true;
   }
   if(pData[playerid][pSkillBuilder] < 2000)
   {
      format(string, sizeof(string), "Builder\t"YELLOW_E"[%d/2000]\t"WHITE_E"1\n", pData[playerid][pSkillBuilder]);
      strcat(irwan, string);
      found = true;
   }
   else if(pData[playerid][pSkillBuilder] > 2000)
   {
      format(string, sizeof(string), "Builder\t"YELLOW_E"[%d/3000]\t"WHITE_E"2\n", pData[playerid][pSkillBuilder]);
      strcat(irwan, string);
      found = true;
   }
   else if(pData[playerid][pSkillBuilder] > 3000)
   {
      format(string, sizeof(string), "Builder\t"YELLOW_E"[%d/Max]\t"WHITE_E"3\n", pData[playerid][pSkillBuilder]);
      strcat(irwan, string);
      found = true;
   }
   if(pData[playerid][pSkillMecha] < 500)
   {
      format(string, sizeof(string), "Mechanic\t"YELLOW_E"[%d/500]\t"WHITE_E"1\n", pData[playerid][pSkillMecha]);
      strcat(irwan, string);
      found = true;
   }
   else if(pData[playerid][pSkillMecha] > 500)
   {
      format(string, sizeof(string), "Mechanic\t"YELLOW_E"[%d/1500]\t"WHITE_E"2\n", pData[playerid][pSkillMecha]);
      strcat(irwan, string);
      found = true;
   }
   else if(pData[playerid][pSkillMecha] > 1500)
   {
      format(string, sizeof(string), "Mechanic\t"YELLOW_E"[%d/Max]\t"WHITE_E"3\n", pData[playerid][pSkillMecha]);
      strcat(irwan, string);
      found = true;
   }
   if(pData[playerid][FightStyle] == 4)
   {
      format(string, sizeof(string), "Fight Style\t"YELLOW_E"Fight Style Normal"WHITE_E"\n", pData[playerid][LevelTrucker], pData[playerid][pSkillTrucker]);
      strcat(irwan, string);
      found = true;
   }
   else if(pData[playerid][FightStyle] == 5)
   {
      format(string, sizeof(string), "Fight Style\t"YELLOW_E"Fight Style Boxing"WHITE_E"\n", pData[playerid][LevelTrucker], pData[playerid][pSkillTrucker]);
      strcat(irwan, string);
      found = true;
   }
   else if(pData[playerid][FightStyle] == 6)
   {
      format(string, sizeof(string), "Fight Style\t"YELLOW_E"Fight Style Kunfu"WHITE_E"\n", pData[playerid][LevelTrucker], pData[playerid][pSkillTrucker]);
      strcat(irwan, string);
      found = true;
   }
   else if(pData[playerid][FightStyle] == 7)
   {
      format(string, sizeof(string), "Fight Style\t"YELLOW_E"Fight Style Kneehead"WHITE_E"\n", pData[playerid][LevelFishing], pData[playerid][pSkillFishing]);
      strcat(irwan, string);
      found = true;
   }
   else if(pData[playerid][FightStyle] == 15)
   {
      format(string, sizeof(string), "Fight Style\t"YELLOW_E"Fight Style Grabkick"WHITE_E"\n", pData[playerid][LevelFishing], pData[playerid][pSkillFishing]);
      strcat(irwan, string);
      found = true;
   }
   else if(pData[playerid][FightStyle] == 16)
   {
      format(string, sizeof(string), "Fight Style\t"YELLOW_E"Fight Style Elbow"WHITE_E"\n", pData[playerid][LevelFishing], pData[playerid][pSkillFishing]);
      strcat(irwan, string);
      found = true;
   }
   if(found)
         ShowPlayerDialog(playerid, DIALOG_SKILLPLAYER, DIALOG_STYLE_TABLIST_HEADERS, "Skills Player", irwan, "Pilih", "Close");
   return 1;
}

CMD:buyfightstyle(playerid, params[])
{
   new String[212], S3MP4K[212];
   if(!IsPlayerInRangeOfPoint(playerid, 3.0, 758.5930,-77.6466,1000.6508)) return Error(playerid, "Kamu tidak berada di tempat GYM / TRAINING");
   strcat(S3MP4K, "Name Fight\tCoast\n");
   format(String, sizeof(String),"Normal\t$125.00\n");
   strcat(S3MP4K, String);
   format(String, sizeof(String),"Boxing\t$125.00\n");
   strcat(S3MP4K, String);
   format(String, sizeof(String),"Kung-fu\t$125.00\n");
   strcat(S3MP4K, String);
   format(String, sizeof(String),"Kneehead\t$125.00\n");
   strcat(S3MP4K, String);
   format(String, sizeof(String),"GrabKick\t$125.00\n");
   strcat(S3MP4K, String);
   format(String, sizeof(String),"Elbow\t$125.00");
   strcat(S3MP4K, String);
   ShowPlayerDialog(playerid, DIALOG_FIGHTSTYLE, DIALOG_STYLE_TABLIST_HEADERS, "Fight Style", S3MP4K, "Select", "Cancel");
   return 1;
}
