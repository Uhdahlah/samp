
//----------[ Native Login Register]----------


UpdatePlayerData(playerid)
{
	if(pData[playerid][IsLoggedIn] == false) return 0;
	if(IsPlayerInAnyVehicle(playerid))
	{
		if(IsATruck(GetPlayerVehicleID(playerid)))
		{
			RemovePlayerFromVehicle(playerid);
			GetPlayerPos(playerid, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]);
			pData[playerid][pPosZ] = pData[playerid][pPosZ]+0.4;
		}
		else
		{
			GetPlayerPos(playerid, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]);
		}
    }
	else
	{
		GetPlayerPos(playerid, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]);
	}
	GetPlayerFacingAngle(playerid, pData[playerid][pPosA]);
	if(pData[playerid][pAdminDuty] == 1)
	{
		pData[playerid][pHealth] = HealthDuty[playerid];
	}
	else
	{
		GetPlayerHealth(playerid, pData[playerid][pHealth]);
	}
	GetPlayerArmour(playerid, pData[playerid][pArmour]);
	new cQuery[5000], PlayerIP[16];
	GetPlayerIp(playerid, PlayerIP, sizeof(PlayerIP));
	
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "UPDATE `players` SET ");
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Gun1` = '%d', ", cQuery, pData[playerid][pGuns][0]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Gun2` = '%d', ", cQuery, pData[playerid][pGuns][1]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Gun3` = '%d', ", cQuery, pData[playerid][pGuns][2]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Gun4` = '%d', ", cQuery, pData[playerid][pGuns][3]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Gun5` = '%d', ", cQuery, pData[playerid][pGuns][4]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Gun6` = '%d', ", cQuery, pData[playerid][pGuns][5]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Gun7` = '%d', ", cQuery, pData[playerid][pGuns][6]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Gun8` = '%d', ", cQuery, pData[playerid][pGuns][7]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Gun9` = '%d', ", cQuery, pData[playerid][pGuns][8]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Gun10` = '%d', ", cQuery, pData[playerid][pGuns][9]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Gun11` = '%d', ", cQuery, pData[playerid][pGuns][10]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Gun12` = '%d', ", cQuery, pData[playerid][pGuns][11]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Gun13` = '%d', ", cQuery, pData[playerid][pGuns][12]);
	
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Ammo1` = '%d', ", cQuery, pData[playerid][pAmmo][0]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Ammo2` = '%d', ", cQuery, pData[playerid][pAmmo][1]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Ammo3` = '%d', ", cQuery, pData[playerid][pAmmo][2]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Ammo4` = '%d', ", cQuery, pData[playerid][pAmmo][3]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Ammo5` = '%d', ", cQuery, pData[playerid][pAmmo][4]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Ammo6` = '%d', ", cQuery, pData[playerid][pAmmo][5]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Ammo7` = '%d', ", cQuery, pData[playerid][pAmmo][6]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Ammo8` = '%d', ", cQuery, pData[playerid][pAmmo][7]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Ammo9` = '%d', ", cQuery, pData[playerid][pAmmo][8]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Ammo10` = '%d', ", cQuery, pData[playerid][pAmmo][9]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Ammo11` = '%d', ", cQuery, pData[playerid][pAmmo][10]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Ammo12` = '%d', ", cQuery, pData[playerid][pAmmo][11]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Ammo13` = '%d', ", cQuery, pData[playerid][pAmmo][12]);
	
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`adminname` = '%e', ", cQuery, pData[playerid][pAdminname]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`ucpname` = '%e', ", cQuery, charData[playerid][cName]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`ip` = '%s', ", cQuery, PlayerIP);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`admin` = '%d', ", cQuery, pData[playerid][pAdmin]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`helper` = '%d', ", cQuery, pData[playerid][pHelper]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`level` = '%d', ", cQuery, pData[playerid][pLevel]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`levelup` = '%d', ", cQuery, pData[playerid][pLevelUp]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`cschar` = '%d', ", cQuery, pData[playerid][pCS]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`vip` = '%d', ", cQuery, pData[playerid][pVip]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`vip_time` = '%d', ", cQuery, pData[playerid][pVipTime]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`gold` = '%d', ", cQuery, pData[playerid][pGold]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`money` = '%d', ", cQuery, pData[playerid][pMoney]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`bmoney` = '%d', ", cQuery, pData[playerid][pBankMoney]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`brek` = '%d', ", cQuery, pData[playerid][pBankRek]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`phone` = '%d', ", cQuery, pData[playerid][pPhone]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`phonecredit` = '%d', ", cQuery, pData[playerid][pPhoneCredit]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`wt` = '%d', ", cQuery, pData[playerid][pWT]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`hours` = '%d', ", cQuery, pData[playerid][pHours]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`minutes` = '%d', ", cQuery, pData[playerid][pMinutes]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`seconds` = '%d', ", cQuery, pData[playerid][pSeconds]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`paycheck` = '%d', ", cQuery, pData[playerid][pPaycheck]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`skin` = '%d', ", cQuery, pData[playerid][pSkin]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`facskin` = '%d', ", cQuery, pData[playerid][pFacSkin]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`gender` = '%d', ", cQuery, pData[playerid][pGender]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`newp` = '%d', ", cQuery, pData[playerid][pnewplayer]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`age` = '%s', ", cQuery, pData[playerid][pAge]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`indoor` = '%d', ", cQuery, pData[playerid][pInDoor]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`inhouse` = '%d', ", cQuery, pData[playerid][pInHouse]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`inbiz` = '%d', ", cQuery, pData[playerid][pInBiz]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`posx` = '%f', ", cQuery, pData[playerid][pPosX]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`posy` = '%f', ", cQuery, pData[playerid][pPosY]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`posz` = '%f', ", cQuery, pData[playerid][pPosZ]+0.3);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`posa` = '%f', ", cQuery, pData[playerid][pPosA]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`interior` = '%d', ", cQuery, GetPlayerInterior(playerid));
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`world` = '%d', ", cQuery, GetPlayerVirtualWorld(playerid));
	
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`health` = '%f', ", cQuery, pData[playerid][pHealth]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`armour` = '%f', ", cQuery, pData[playerid][pArmour]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`hunger` = '%d', ", cQuery, pData[playerid][pHunger]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`energy` = '%d', ", cQuery, pData[playerid][pEnergy]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`sick` = '%d', ", cQuery, pData[playerid][pSick]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`hospital` = '%d', ", cQuery, pData[playerid][pHospital]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`injured` = '%d', ", cQuery, pData[playerid][pInjured]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`duty` = '%d', ", cQuery, pData[playerid][pOnDuty]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`dutytime` = '%d', ", cQuery, pData[playerid][pOnDutyTime]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`faction` = '%d', ", cQuery, pData[playerid][pFaction]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`factionrank` = '%d', ", cQuery, pData[playerid][pFactionRank]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`factionlead` = '%d', ", cQuery, pData[playerid][pFactionLead]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`family` = '%d', ", cQuery, pData[playerid][pFamily]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`familyrank` = '%d', ", cQuery, pData[playerid][pFamilyRank]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`jail` = '%d', ", cQuery, pData[playerid][pJail]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`jail_time` = '%d', ", cQuery, pData[playerid][pJailTime]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`arrest` = '%d', ", cQuery, pData[playerid][pArrest]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`arrest_time` = '%d', ", cQuery, pData[playerid][pArrestTime]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`warn` = '%d', ", cQuery, pData[playerid][pWarn]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`job` = '%d', ", cQuery, pData[playerid][pJob]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`job2` = '%d', ", cQuery, pData[playerid][pJob2]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`jobtime` = '%d', ", cQuery, pData[playerid][pJobTime]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`sidejobtime` = '%d', ", cQuery, pData[playerid][pSideJobTime]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`exitjob` = '%d', ", cQuery, pData[playerid][pExitJob]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`taxitime` = '%d', ", cQuery, pData[playerid][pTaxiTime]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`medicine` = '%d', ", cQuery, pData[playerid][pMedicine]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`medkit` = '%d', ", cQuery, pData[playerid][pMedkit]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`mask` = '%d', ", cQuery, pData[playerid][pMask]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`helmet` = '%d', ", cQuery, pData[playerid][pHelmet]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`snack` = '%d', ", cQuery, pData[playerid][pSnack]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`sprunk` = '%d', ", cQuery, pData[playerid][pSprunk]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`gas` = '%d', ", cQuery, pData[playerid][pGas]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`bandage` = '%d', ", cQuery, pData[playerid][pBandage]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`gps` = '%d', ", cQuery, pData[playerid][pGPS]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`material` = '%d', ", cQuery, pData[playerid][pMaterial]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`component` = '%d', ", cQuery, pData[playerid][pComponent]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`food` = '%d', ", cQuery, pData[playerid][pFood]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`seedwheat` = '%d', ", cQuery, pData[playerid][pSeedWheat]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`seedonion` = '%d', ", cQuery, pData[playerid][pSeedOnion]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`seedcarrot` = '%d', ", cQuery, pData[playerid][pSeedCarrot]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`seedpotato` = '%d', ", cQuery, pData[playerid][pSeedPotato]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`seedcorn` = '%d', ", cQuery, pData[playerid][pSeedCorn]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`wheat` = '%d', ", cQuery, pData[playerid][pWheat]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`onion` = '%d', ", cQuery, pData[playerid][pOnion]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`carrot` = '%d', ", cQuery, pData[playerid][pCarrot]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`potato` = '%d', ", cQuery, pData[playerid][pPotato]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`corn` = '%d', ", cQuery, pData[playerid][pCorn]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`price1` = '%d', ", cQuery, pData[playerid][pPrice1]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`price2` = '%d', ", cQuery, pData[playerid][pPrice2]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`price3` = '%d', ", cQuery, pData[playerid][pPrice3]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`price4` = '%d', ", cQuery, pData[playerid][pPrice4]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`crack` = '%d', ", cQuery, pData[playerid][pCrack]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`pot` = '%d', ", cQuery, pData[playerid][pPot]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`plant` = '%d', ", cQuery, pData[playerid][pPlant]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`plant_time` = '%d', ", cQuery, pData[playerid][pPlantTime]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`fishtool` = '%d', ", cQuery, pData[playerid][pFishTool]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`fish` = '%d', ", cQuery, pData[playerid][pFish]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`fish1` = '%d', ", cQuery, pData[playerid][pFish1]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`fish2` = '%d', ", cQuery, pData[playerid][pFish2]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`fish3` = '%d', ", cQuery, pData[playerid][pFish3]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`fish4` = '%d', ", cQuery, pData[playerid][pFish4]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`fishmax` = '%d', ", cQuery, pData[playerid][pFishMax]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`worm` = '%d', ", cQuery, pData[playerid][pWorm]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`drivelic` = '%d', ", cQuery, pData[playerid][pDriveLic]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`drivelic_time` = '%d', ", cQuery, pData[playerid][pDriveLicTime]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`flylic` = '%d', ", cQuery, pData[playerid][pFlyLic]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`flylic_time` = '%d', ", cQuery, pData[playerid][pFlyLicTime]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`boatlic` = '%d', ", cQuery, pData[playerid][pBoatLic]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`boatlic_time` = '%d', ", cQuery, pData[playerid][pBoatLicTime]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`gunlic` = '%d', ", cQuery, pData[playerid][pGunLic]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`gunlic_time` = '%d', ", cQuery, pData[playerid][pGunLicTime]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`trucker` = '%d', ", cQuery, pData[playerid][pTruckerLic]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`trucker_time` = '%d', ", cQuery, pData[playerid][pTruckerLicTime]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`lumber` = '%d', ", cQuery, pData[playerid][pLumberLic]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`lumber_time` = '%d', ", cQuery, pData[playerid][pLumberLicTime]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`hbemode` = '%d', ", cQuery, pData[playerid][pHBEMode]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`togpm` = '%d', ", cQuery, pData[playerid][pTogPM]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`togads` = '%d', ", cQuery, pData[playerid][pTogAds]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`togwt` = '%d', ", cQuery, pData[playerid][pTogWT]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`togradio` = '%d', ", cQuery, pData[playerid][pTogRadio]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`togpaycheck` = '%d', ", cQuery, pData[playerid][pTogPaycheck]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`togseatbelt` = '%d', ", cQuery, pData[playerid][pTogSealtbelt]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`togchat` = '%d', ", cQuery, pData[playerid][pTogChat]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toghelmet` = '%d', ", cQuery, pData[playerid][pTogHelmet]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`togmask` = '%d', ", cQuery, pData[playerid][pTogMask]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`togammo` = '%d', ", cQuery, pData[playerid][pTogAmmo]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`pbanned` = '%d', ", cQuery, pData[playerid][pBanned]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`pbanreason` = '%s', ", cQuery, pData[playerid][pBanReason]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`pbanby` = '%s', ", cQuery, pData[playerid][pBanBy]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`workshop` = '%d', ", cQuery, pData[playerid][pWorkshop]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`workshoprank` = '%d', ", cQuery, pData[playerid][pWorkshopRank]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`sidejobtimesweap` = '%d', ", cQuery, pData[playerid][pSideJobTimeSweap]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`sidejobtimebus` = '%d', ", cQuery, pData[playerid][pSideJobTimeBus]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`haulingtime` = '%d', ", cQuery, pData[playerid][pHaulingTime]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`rokok` = '%d', ", cQuery, pData[playerid][pRokok]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`cgun` = '%d', ", cQuery, pData[playerid][pCgun]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`trashtime` = '%d', ", cQuery, pData[playerid][pSideJobsTrash]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`forklifttime` = '%d', ", cQuery, pData[playerid][pSideJobsForklift]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`smugglertime` = '%d', ", cQuery, pData[playerid][pJobSmugglerTime]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`fightstyle` = '%d', ", cQuery, pData[playerid][FightStyle]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`leveltrucker` = '%d', ", cQuery, pData[playerid][LevelTrucker]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`skilltrucker` = '%d', ", cQuery, pData[playerid][pSkillTrucker]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`married` = '%d', ", cQuery, pData[playerid][pMarried]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`marriedto` = '%e', ", cQuery, pData[playerid][pMarriedTo]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`paytoll` = '%d', ", cQuery, pData[playerid][pPayToll]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`levelfishing` = '%d', ", cQuery, pData[playerid][LevelFishing]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`delaytruckdeli` = '%d', ", cQuery, pData[playerid][pDelayTruckerDeli]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`delayfishing` = '%d', ", cQuery, pData[playerid][pDelayFishing]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`apart` = '%d', ", cQuery, pData[playerid][pApart]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`ladang` = '%d', ", cQuery, pData[playerid][pLadang]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`ladangrank` = '%d', ", cQuery, pData[playerid][pLadangRank]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`maskid` = '%d', ", cQuery, pData[playerid][pMaskID]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`adsdelay` = '%d', ", cQuery, pData[playerid][pAdsTime]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`inapart` = '%d', ", cQuery, pData[playerid][pInApart]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`indoorflat` = '%d', ", cQuery, pData[playerid][pInDoorFlat]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`mutewt` = '%d', ", cQuery, pData[playerid][pMuteWt]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`skillbuilder` = '%d', ", cQuery, pData[playerid][pSkillBuilder]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`skillmecha` = '%d', ", cQuery, pData[playerid][pSkillMecha]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`rentveh` = '%d', ", cQuery, pData[playerid][pRents]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`accent` = '%d', ", cQuery, pData[playerid][pAccent1]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`furnstore` = '%d', ", cQuery, pData[playerid][pFurnStore]);

	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`last_login` = CURRENT_TIMESTAMP() WHERE `reg_id` = '%d'", cQuery, pData[playerid][pID]);
	mysql_tquery(g_SQL, cQuery);
	
	UpdateCharData(playerid);
	return 1;
}

UpdateCharData(playerid)
{
	new cQuery[3048];

	mysql_format(g_SQL, cQuery, sizeof(cQuery), "UPDATE `ucp` SET ");
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`CharName` = '%d', ", cQuery, charData[playerid][cCharName]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`CharName2` = '%d', ", cQuery, charData[playerid][cCharName2]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`CharName3` = '%d' ", cQuery, charData[playerid][cCharName3]);
	
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%sWHERE `username` = '%s'", cQuery, charData[playerid][cName]);
	mysql_tquery(g_SQL, cQuery);
	return 1;
}

ResetVariables(playerid)
{
	static const empty_player[E_PLAYERS];
	pData[playerid] = empty_player;
	
	pData[playerid][pInDoor] = -1;
	pData[playerid][pInHouse] = -1;
	pData[playerid][pInApart] = -1;
	pData[playerid][pInDoorFlat] = -1;
	for(new i = 0; i < 3; i++)
	{
		BusSteps[playerid][i] = 0;
	}
	pData[playerid][pInBiz] = -1;
	pData[playerid][pFamily] = -1;
	pData[playerid][IsLoggedIn] = false;
	pData[playerid][PurchasedToy] = false;
	pData[playerid][pHealth] = 100.0;
	pData[playerid][pArmour] = 0.0;
	pData[playerid][pSpec] = -1;
	pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;

	pData[playerid][pFlareActive] = false;
	pData[playerid][pAdoActive] = false;
	pData[playerid][CuttingTreeID] = -1;
	pData[playerid][CarryingLumber] = false;
	pData[playerid][EditingTreeID] = -1;
	pData[playerid][pNewsGuest] = INVALID_PLAYER_ID;
	pData[playerid][pFindEms] = INVALID_PLAYER_ID;
	pData[playerid][pCall] = INVALID_PLAYER_ID;
		
	pData[playerid][pHarvestID] = -1;
	pData[playerid][pOffer] = -1;
	
	pData[playerid][pFill] = -1;
	
	pData[playerid][pMission] = -1;
	pData[playerid][pHauling] = -1;
	
	pData[playerid][pFacInvite] = -1;
	pData[playerid][pFacOffer] = -1;
	pData[playerid][pFamInvite] = -1;
	pData[playerid][pFamOffer] = -1;
	pData[playerid][pWorkInvite] = -1;
	pData[playerid][pWorkOffer] = -1;
	pData[playerid][pLadangInvite] = -1;
	pData[playerid][pLadangOffer] = -1;
	pData[playerid][nspectOffer] = INVALID_PLAYER_ID;
	pData[playerid][pMarriedAccept] = INVALID_PLAYER_ID;	
	pData[playerid][pMarriedCancel] = INVALID_PLAYER_ID;	
	pData[playerid][pHBEMode] = 1;
	gPlayerUsingLoopingAnim[playerid] = 0;
	gPlayerAnimLibsPreloaded[playerid] = 0;
	
	SetPVarInt(playerid, "GiveUptime", 0);
	
	ResetVariableTazer(playerid);
	
	for (new i = 0; i != MAX_CONTACTS; i ++) {
	    ContactData[playerid][i][contactExists] = false;
	    ContactData[playerid][i][contactID] = 0;
	    ContactData[playerid][i][contactNumber] = 0;
	    ListedContacts[playerid][i] = -1;
	}
	for (new i = 0; i != MAX_ACC; i ++) if(AccData[playerid][i][accExists]) {
        AccData[playerid][i][accExists] = false;
        AccData[playerid][i][accID] = 0;
        AccData[playerid][i][accModel] = 0;
        AccData[playerid][i][accBone] = 1;
        AccData[playerid][i][accShow] = 0;

        AccData[playerid][i][accColor1][0] = AccData[playerid][i][accColor1][1] = AccData[playerid][i][accColor1][2] = 0;
        AccData[playerid][i][accColor2][0] = AccData[playerid][i][accColor2][1] = AccData[playerid][i][accColor2][2] = 0;

        AccData[playerid][i][accOffset][0] = AccData[playerid][i][accOffset][1] = AccData[playerid][i][accOffset][2] = 0.0;
        AccData[playerid][i][accRot][0] = AccData[playerid][i][accRot][1] = AccData[playerid][i][accRot][2] = 0.0;
        AccData[playerid][i][accScale][0] = AccData[playerid][i][accScale][1] = AccData[playerid][i][accScale][2] = 0.0;
    }
	pData[playerid][pPhoneOff] = 0;
	pData[playerid][pNameTag] = Text3D:INVALID_3DTEXT_ID;
	RemovePlayerVehicle(playerid);
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	AimbotWarnings[playerid] = 0;
	pData[playerid][MiningOreID] = -1;
	pData[playerid][CarryingLog] = -1;
	pData[playerid][EditingOreID] = -1;
	pData[playerid][EditingATMID] = -1;

	pData[playerid][gEditID] = -1;
	Jump[playerid] = 0;
	InVeh[playerid] = -1;
	EnterVeh[playerid] = 0;
	StopStream(playerid);
	Mobile[playerid] = INVALID_PLAYER_ID;
	pData[playerid][pInGarageH] = -1;
	pData[playerid][pJobsSmuggleOn] = 0;
	pData[playerid][pJobsSmugglePacket] = 0;
	pData[playerid][pJobsSmuggleTakePacket] = 0;
	pData[playerid][pDelayNotifSmuggle] = 0;
	//AfkLogin[playerid] = 0;
	for(new i; i <= 10; i++) // 9 = Total Dialog , Jadi kita mau tau kalau Player Ini Apakah Ambil Dialog dari 3 tersebut apa ga !
	{
		if(DialogSaya[playerid][i] == true) // Cari apakah dia punya salah satu diantara 10 dialog tersebut
		{
		    DialogSaya[playerid][i] = false; // Ubah Jadi Dia ga punya dialog lagi Kalau Udah Disconnect (Bukan dia lagi pemilik)
		    DialogHauling[i] = false; // Jadi ga ada yang punya nih dialog
		    DestroyVehicle(TrailerHauling[playerid]);
		}
	}
	pData[playerid][fuelbar] = INVALID_PLAYER_BAR_ID;
	pData[playerid][damagebar] = INVALID_PLAYER_BAR_ID;
	pData[playerid][hungrybar] = INVALID_PLAYER_BAR_ID;
	pData[playerid][energybar] = INVALID_PLAYER_BAR_ID;
	pData[playerid][healtbar] = INVALID_PLAYER_BAR_ID;
	pData[playerid][armorbar] = INVALID_PLAYER_BAR_ID;

	pData[playerid][pDelayCrate] = 0;
	pData[playerid][pCrate] = 0;
	pData[playerid][pCrateType] = 0;
	for(new s = 0; s < 13; s++)
	{
		pData[playerid][pGuns][s] = 0;
		pData[playerid][pAmmo][s] = 0;
		pData[playerid][pAmmo][s] = 0;
	}
	pData[playerid][pKeyVehicle] = INVALID_VEHICLE_ID;
	pData[playerid][pJobsForklift1] = -1;
	TrashTotal[playerid] = 0;
	for(new idx = 0; idx < 100; idx++) 	gListedItems[playerid][idx] = -1;
	pData[playerid][pListitems] = -1;
	for(new s = 0; s < 40; s++)
	{
		ListItemReportId[playerid][s] = -1;
	}
	CancelReport[playerid] = -1;
	for(new i = 0; i < MAX_REPORTS; i++)
	{
	    if(Reports[i][ReportFrom] == playerid)
	    {
	        Reports[i][ReportFrom] = 999;
			Reports[i][BeingUsed] = 0;
			Reports[i][TimeToExpire] = 0;
		}
	}
	pData[playerid][pUsedFlashlight] =0;
	EditingObject[playerid] = -1;
	EditingMatext[playerid] = -1;
	pData[playerid][pTaxiCall] = -1;
	pData[playerid][pMechaCall] = -1;
	pData[playerid][pWorkshop] = -1;
	pData[playerid][pLadang] = -1;
	pData[playerid][pRents] = -1;
	TempCarID[playerid] = -1;
	SedangHauling[playerid] = -1;
	SetPVarInt(playerid, "editingcd", -1);
	for (new i = 0; i != 10; i ++) {
        ListedAds[playerid][i] = -1;
    }
}

KickEx(playerid, time = 1900)
{
	SetTimerEx("_KickPlayerDelayed", time, false, "i", playerid);
	return 1;
}

IsValidRoleplayName(const name[]) 
{
    if(!name[0] || strfind(name, "_") == -1)
        return 0;

    else for (new i = 0, len = strlen(name); i != len; i ++) {
    if((i == 0) && (name[i] < 'A' || name[i] > 'Z'))
            return 0;

        else if((i != 0 && i < len  && name[i] == '_') && (name[i + 1] < 'A' || name[i + 1] > 'Z'))
            return 0;

        else if((name[i] < 'A' || name[i] > 'Z') && (name[i] < 'a' || name[i] > 'z') && name[i] != '_' && name[i] != '.')
            return 0;
    }
    return 1;
}

IsValidName(const name[])
{
	new len = strlen(name);

	for(new ch = 0; ch != len; ch++)
	{
		switch(name[ch])
		{
			case 'A' .. 'Z', 'a' .. 'z', '0' .. '9', ']', '[', '(', ')', '_', '.': continue;
			default: return false;
		}
	}
	return true;
}

IsValidPassword(const name[])
{
	new len = strlen(name);

	for(new ch = 0; ch != len; ch++)
	{
		switch(name[ch])
		{
			case 'A' .. 'Z', 'a' .. 'z', '0' .. '9', ']', '[', '(', ')', '_', '.', '@', '#': continue;
			default: return false;
		}
	}
	return true;
}

//----------[ Anti-Cheat Native ]------
//Anti Money Hack
GivePlayerMoneyEx(playerid, cashgiven)
{
	pData[playerid][pMoney] += cashgiven;
	GivePlayerMoney(playerid, cashgiven);
}

ResetPlayerMoneyEx(playerid)
{
	pData[playerid][pMoney] = 0;
	ResetPlayerMoney(playerid);
}

//Anti Health and Armour Hack
SetPlayerHealthEx(playerid, Float:heal)
{
	pData[playerid][pHealth] = heal;
	SetPlayerHealth(playerid, heal);
}

SetPlayerArmourEx(playerid, Float:armor)
{
	pData[playerid][pArmour] = armor;
	SetPlayerArmour(playerid, armor);
}

//----------[ Admin Native ]----------
GetStaffRank(playerid)
{
	new name[40];
	if(pData[playerid][pAdmin] == 1)
	{
		name = ""RED_E"Volunteer";
	}
	else if(pData[playerid][pAdmin] == 2)
	{
		name = ""RED_E"Helper";
	}
	else if(pData[playerid][pAdmin] == 3)
	{
		name = ""RED_E"Staff Administrator";
	}
	else if(pData[playerid][pAdmin] == 4)
	{
		name = ""RED_E"Administrator";
	}
	else if(pData[playerid][pAdmin] == 5)
	{
		name = ""RED_E"Head Admin";
	}
	else if(pData[playerid][pAdmin] == 6)
	{
		name = ""RED_E"Developer";
	}
	else if(pData[playerid][pHelper] == 1 && pData[playerid][pAdmin] == 0)
	{
		name = ""GREEN_E"Junior Helper";
	}
	else if(pData[playerid][pHelper] == 2 && pData[playerid][pAdmin] == 0)
	{
		name = ""GREEN_E"Senior Helper";
	}
	else if(pData[playerid][pHelper] == 3 && pData[playerid][pAdmin] == 0)
	{
		name = ""GREEN_E"Head Helper";
	}
	else
	{
		name = "None";
	}
	return name;
}

SendStaffMessage(color, const str[], {Float,_}:...)
{
    static
        args,
        start,
        end,
        string[144]
    ;
    #emit LOAD.S.pri 8
    #emit STOR.pri args

    if(args > 8)
    {
        #emit ADDR.pri str
        #emit STOR.pri start

        for (end = start + (args - 8); end > start; end -= 4)
        {
            #emit LREF.pri end
            #emit PUSH.pri
        }
        #emit PUSH.S str
        #emit PUSH.C 144
        #emit PUSH.C string

        #emit LOAD.S.pri 8
        #emit ADD.C 4
        #emit PUSH.pri

        #emit SYSREQ.C format
        #emit LCTRL 5
        #emit SCTRL 4

        foreach (new i : Player)
        {
            if(pData[i][pAdmin] >= 1 || pData[i][pHelper] >= 1) {
                SendClientMessageEx(i, color, ""TOMATO_E"%s", string);
            }
        }
        return 1;
    }
    foreach (new i : Player)
    {
        if(pData[i][pAdmin] >= 1 || pData[i][pHelper] >= 1) {
            SendClientMessageEx(i, color, ""TOMATO_E"%s", string);
        }
    }
    return 1;
}

SendAdminMessage(color, const str[], {Float,_}:...)
{
    static
        args,
        start,
        end,
        string[144]
    ;
    #emit LOAD.S.pri 8
    #emit STOR.pri args

    if(args > 8)
    {
        #emit ADDR.pri str
        #emit STOR.pri start

        for (end = start + (args - 8); end > start; end -= 4)
        {
            #emit LREF.pri end
            #emit PUSH.pri
        }
        #emit PUSH.S str
        #emit PUSH.C 144
        #emit PUSH.C string

        #emit LOAD.S.pri 8
        #emit ADD.C 4
        #emit PUSH.pri

        #emit SYSREQ.C format
        #emit LCTRL 5
        #emit SCTRL 4

        foreach (new i : Player)
        {
            if(pData[i][pAdmin] >= 1 /*&& !pData[i][pDisableAdmin]*/) {
				SendClientMessageEx(i, color, ""TOMATO_E"%s", string);
            }
        }
        return 1;
    }
    foreach (new i : Player)
    {
        if(pData[i][pAdmin] >= 1 /*&& !pData[i][pDisableAdmin]*/) {
			SendClientMessageEx(i, color, ""TOMATO_E"%s", string);
        }
    }
    return 1;
}

StaffCommandLog(const command[], adminid, player = INVALID_PLAYER_ID, logstr[] = '*')
{
	// Set the logging message to be correct
	new logStrEscaped[128], query[512];
	if(logstr[0] == '*')
		logStrEscaped = "*", printf("AdminCommandLog: logstr detected as unnecessary, logStrEscaped = '%s' (must be '*')", logStrEscaped);
	else
		mysql_escape_string(logstr, logStrEscaped), printf("AdminCommandLog: logstr detected necessary, escaped from '%s' to '%s'", logstr, logStrEscaped);

	if(player != INVALID_PLAYER_ID)
	{
		// The action involves a player, get their name
		mysql_format(g_SQL, query, sizeof(query), "INSERT INTO logstaff (command,admin,adminid,player,playerid,str,time) VALUES('%s','%s(%s)',%d,'%s',%d,'%s',UNIX_TIMESTAMP())", command, pData[adminid][pName], pData[adminid][pAdminname], pData[adminid][pID], pData[player][pName], pData[player][pID], logStrEscaped);
	}
	else
	{
		mysql_format(g_SQL, query, sizeof(query), "INSERT INTO logstaff (command,admin,adminid,str,time) VALUES('%s','%s(%s)',%d,'%s',UNIX_TIMESTAMP())", command, pData[adminid][pName], pData[adminid][pAdminname], pData[adminid][pID], logStrEscaped);
	}

	// Send the query!
	mysql_tquery(g_SQL, query);
	return 1;
}

//----------[ VIP Native ]----------
GetVipRank(playerid)
{
	new name[40];
	if(pData[playerid][pVip] == 1)
	{
		name = ""LG_E"Basic";
	}
	else if(pData[playerid][pVip] == 2)
	{
		name = ""YELLOW_E"Advanced";
	}
	else if(pData[playerid][pVip] == 3)
	{
		name = ""PURPLE_E"Professional";
	}
	else if(pData[playerid][pVip] == 4)
	{
		name = ""PURPLE_E"Lifetime";
	}
	else
	{
		name = "None";
	}
	return name;
}

//----------[ Faction Native ]----------
SetFactionColor(playerid)
{
    new factionid = pData[playerid][pFaction];

    if(factionid == 1)
	{
		SetPlayerColor(playerid, COLOR_BLUE);
	}
	else if(factionid == 2)
	{
		SetPlayerColor(playerid, COLOR_LBLUE);
	}
	else if(factionid == 3)
	{
		SetPlayerColor(playerid, COLOR_PINK2);
	}
	else if(factionid == 4)
	{
		SetPlayerColor(playerid, COLOR_ORANGE2);
	}
	else
	{
		SetPlayerColor(playerid, COLOR_WHITE);
	}
	return 1;
}

GetFactionRank(playerid)
{
	new rank[24];
	if(pData[playerid][pFaction] == 1)
	{
		if(pData[playerid][pFactionRank] == 1)
		{
			rank = "PD Officer I";
		}
		else if(pData[playerid][pFactionRank] == 2)
		{
			rank = "PD Officer II";
		}
		else if(pData[playerid][pFactionRank] == 3)
		{
			rank = "PD Officer III";
		}
		else if(pData[playerid][pFactionRank] == 4)
		{
			rank = "Commander";
		}
		else if(pData[playerid][pFactionRank] == 5)
		{
			rank = "Deputy Of Chief";
		}
		else if(pData[playerid][pFactionRank] == 6)
		{
			rank = "Chief Of Police";
		}
		else
		{
			rank = "None";
		}
	}
  	if(pData[playerid][pFaction] == 2)
	{
		if(pData[playerid][pFactionRank] == 1)
		{
			rank = "Officer";
		}
		else if(pData[playerid][pFactionRank] == 2)
		{
			rank = "Staff";
		}
		else if(pData[playerid][pFactionRank] == 3)
		{
			rank = "Agent";
		}
		else if(pData[playerid][pFactionRank] == 4)
		{
			rank = "Regent";
		}
		else if(pData[playerid][pFactionRank] == 5)
		{
			rank = "Mayor";
		}
		else if(pData[playerid][pFactionRank] == 6)
		{
			rank = "Governor";
		}
		else
		{
			rank = "None";
		}
	}
	if(pData[playerid][pFaction] == 3)
	{
		if(pData[playerid][pFactionRank] == 1)
		{
			rank = "Officer";
		}
		else if(pData[playerid][pFactionRank] == 2)
		{
			rank = "Staff";
		}
		else if(pData[playerid][pFactionRank] == 3)
		{
			rank = "Paramedic";
		}
		else if(pData[playerid][pFactionRank] == 4)
		{
			rank = "Specialist";
		}
		else if(pData[playerid][pFactionRank] == 5)
		{
			rank = "Deputy of Chief";
		}
		else if(pData[playerid][pFactionRank] == 6)
		{
			rank = "Chief of Medic";
		}
		else
		{
			rank = "None";
		}
	}
  	if(pData[playerid][pFaction] == 4)
	{
		if(pData[playerid][pFactionRank] == 1)
		{
			rank = "Officer";
		}
		else if(pData[playerid][pFactionRank] == 2)
		{
			rank = "Staff";
		}
		else if(pData[playerid][pFactionRank] == 3)
		{
			rank = "Reporter";
		}
		else if(pData[playerid][pFactionRank] == 4)
		{
			rank = "Manager";
		}
		else if(pData[playerid][pFactionRank] == 5)
		{
			rank = "CEO";
		}
		else if(pData[playerid][pFactionRank] == 6)
		{
			rank = "Intern";
		}
		else
		{
			rank = "None";
		}
	}
	return rank;
}

SetPlayerArrest(playerid, cellid)
{
	if(cellid == 1)
	{
		SetPlayerPositionEx(playerid, 227.49, 109.84, 999.01, 3.70, 2000);
	}
	else if(cellid == 2)
	{
		SetPlayerPositionEx(playerid, 223.51, 109.61, 999.01, 0.25, 2000);
	}
	else if(cellid == 3)
	{
		SetPlayerPositionEx(playerid, 219.52, 109.52, 999.01, 150, 2000);
	}
	else if(cellid == 4)
	{
		SetPlayerPositionEx(playerid, 215.33, 109.62, 999.01, 357.05, 2000);
	}
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 10);
	ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
	SetPlayerWantedLevel(playerid, 0);
	PlayerPlaySound(playerid, 1186, 0, 0, 0);
    ResetPlayerWeaponsEx(playerid);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	pData[playerid][pCuffed] = 0;
	pData[playerid][pInBiz] = -1;
	pData[playerid][pInHouse] = -1;
	pData[playerid][pInDoor] = -1;
}

SendFactionMessage(factionid, color, const str[], {Float,_}:...)
{
    static
        args,
        start,
        end,
        string[144]
    ;
    #emit LOAD.S.pri 8
    #emit STOR.pri args

    if(args > 12)
    {
        #emit ADDR.pri str
        #emit STOR.pri start

        for (end = start + (args - 12); end > start; end -= 4)
        {
            #emit LREF.pri end
            #emit PUSH.pri
        }
        #emit PUSH.S str
        #emit PUSH.C 144
        #emit PUSH.C string
        #emit PUSH.C args

        #emit SYSREQ.C format
        #emit LCTRL 5
        #emit SCTRL 4

        foreach (new i : Player) if(pData[i][pFaction] == factionid /*&& !pData[i][pDisableFaction]*/) 
        {
            SendClientMessage(i, color, string);
        }
        return 1;
    }
    foreach (new i : Player) if(pData[i][pFaction] == factionid /*&& !pData[i][pDisableFaction]*/) 
    {
        SendClientMessage(i, color, str);
    }
    return 1;
}

//----------[ Family Native]----------
GetFamilyRank(playerid)
{
	new rank[24];
	if(pData[playerid][pFamily] != -1)
	{
		if(pData[playerid][pFamilyRank] == 1) 
		{
			rank = "Outsider(1)";
		}
		else if(pData[playerid][pFamilyRank] == 2) 
		{
			rank = "Associate(2)";
		}
		else if(pData[playerid][pFamilyRank] == 3) 
		{
			rank = "Soldier(3)";
		}
		else if(pData[playerid][pFamilyRank] == 4) 
		{
			rank = "Advisor(4)";
		}
		else if(pData[playerid][pFamilyRank] == 5) 
		{
			rank = "UnderBoss(5)";
		}
		else if(pData[playerid][pFamilyRank] == 6) 
		{
			rank = "GodFather(6)";
		}
		else
		{
			rank = "None";
		}
	}
	else
	{
		rank = "None";
	}
	return rank;
}

SendFamilyMessage(familyid, color, const str[], {Float,_}:...)
{
    static
        args,
        start,
        end,
        string[144],
        mstr[144]
    ;
    #emit LOAD.S.pri 8
    #emit STOR.pri args

    if(args > 12)
    {
        #emit ADDR.pri str
        #emit STOR.pri start

        for (end = start + (args - 12); end > start; end -= 4)
        {
            #emit LREF.pri end
            #emit PUSH.pri
        }
        #emit PUSH.S str
        #emit PUSH.C 144
        #emit PUSH.C string
        #emit PUSH.C args

        #emit SYSREQ.C format
        #emit LCTRL 5
        #emit SCTRL 4

        foreach (new i : Player) if(pData[i][pFamily] == familyid /*&& !pData[i][pDisableFaction]*/) 
        {
            SendClientMessage(i, color, string);
           	format(mstr, sizeof(mstr), "[<RADIO>]\n* %s *", string);
			//SetPlayerChatBubble(i, mstr, COLOR_YELLOW, 10.0, 3000);
        }
        return 1;
    }
    foreach (new i : Player) if(pData[i][pFamily] == familyid /*&& !pData[i][pDisableFaction]*/) 
    {
        SendClientMessage(i, color, str);
        format(mstr, sizeof(mstr), "[<RADIO>]\n* %s *", str);
		//SetPlayerChatBubble(i, mstr, COLOR_YELLOW, 10.0, 3000);
    }
    return 1;
}

//----------[ Job Native ]----------
GetJobName(type)
{
    static
        str[24];

    switch (type)
    {
        case 1: str = "Taxi_Driver";
        case 2: str = "Mechanic";
		case 3: str = "Lumber_Jack";
		case 4: str = "Trucker";
		case 5: str = "Farmer";
		case 6: str = "Arms_dealer";
		case 7: str = "Drugs_dealer";
		case 8: str = "Smuggle_dealer";
		case 9: str = "Builder";
        default: str = "None";
    }
    return str;
}

//-----------[ Player Native ]----------
GetID(const name[])
{
	foreach(new i : Player)
	{
		if(!strcmp(name, pData[i][pName]))
			return i;
	}
	return -1;
}

DisplayStats(playerid, p2)
{
	new gstr[1250], header[512], scoremath = ((pData[p2][pLevel])*8), fac[100], fid = pData[p2][pFamily], wid = pData[p2][pWorkshop], laid = pData[p2][pLadang];
	header = "";
	gstr = "";
	
	if(pData[p2][pFaction] == 1)
	{
		fac = "San Andreas Police Department";
	}
	else if(pData[p2][pFaction] == 2)
	{
		fac = "San Andreas Goverment Service";
	}
	else if(pData[p2][pFaction] == 3)
	{
		fac = "San Andreas Medical Department";
	}
	else if(pData[p2][pFaction] == 4)
	{
		fac = "San Andreas Network";
	}
	else
	{
		fac = "None";
	}
	
	new fname[128];
	if(fid != -1)
	{
		format(fname, 128, fData[fid][fName]);
	}
	else
	{
		format(fname, 128, "None");
	}

	new wname[128];
	if(wid != -1)
	{
		format(wname, 128, wData[wid][wName]);
	}
	else
	{
		format(wname, 128, "None");
	}
	new laname[128];
	if(laid != -1)
	{
		format(laname, 128, laData[laid][laName]);
	}
	else
	{
		format(laname, 128, "None");
	}
	new married[20];
	strmid(married, pData[p2][pMarriedTo], 0, strlen(pData[p2][pMarriedTo]), 255);
	new drank[32];
	switch(pData[p2][pVip])
	{
		case 1: drank = "Basic Donator";
		case 2: drank = "Advanced Donator";
		case 3: drank = "Professional Donator";
		case 4: drank = "Lifetime Donator";
		default: drank = "{00FF00}None{FFFFFF}";
	}
	new csstatus[32];
	switch(pData[p2][pCS])
	{
		case 1: csstatus = "Approved";
		default: csstatus = "{FF0000}None{FFFFFF}";
	}
	new coordsString[1000], S3MP4K[1000], idiot[1000];
	S3MP4K = "";
	idiot = "";
	format(idiot, sizeof(idiot), "{C6E2FF}%s(pid: %d)", pData[p2][pName], pData[p2][pID]);
	//SendClientMessageEx(playerid,COLOR_WHITE,coordsString);
	format(coordsString, sizeof(coordsString), "{F7FF00}IC Information:\n");
	strcat(S3MP4K, coordsString);
	format(coordsString, sizeof(coordsString), "{FFFFFF}Gender: [{C6E2FF}%s{FFFFFF}] {FFFFFF}Origin: [{C6E2FF}%s{FFFFFF}] Money: [{00FF00}$%s{FFFFFF}] Bank: [{00FF00}$%s{FFFFFF}] Married With: [{C6E2FF}%s{FFFFFF}] Phone number: [{C6E2FF}%d{FFFFFF}] Phone credit: [{C6E2FF}%d Point{FFFFFF}]\n",(pData[p2][pGender] == 2) ? ("Female") : ("Male"), GetPlayerAccent(p2), FormatMoney(pData[p2][pMoney]), FormatMoney(pData[p2][pBankMoney]), married, pData[p2][pPhone], pData[p2][pPhoneCredit]);
    strcat(S3MP4K, coordsString);
	format(coordsString, sizeof(coordsString), "Job: [%s, %s{FFFFFF}] Faction: [{C6E2FF}%s{FFFFFF}] Family: [{C6E2FF}%s{FFFFFF}]\n", GetJobName(pData[p2][pJob]), GetJobName(pData[p2][pJob2]),fac, fname);
    strcat(S3MP4K, coordsString);
    format(coordsString, sizeof(coordsString), "Workshop: [{C6E2FF}%s{FFFFFF}] Farm: [{C6E2FF}%s{FFFFFF}]\n", wname, laname);
    strcat(S3MP4K, coordsString);
	format(coordsString, sizeof(coordsString), "{F7FF00}OOC Information:\n");
    strcat(S3MP4K, coordsString);
	format(coordsString, sizeof(coordsString), "{FFFFFF}User: [{00CCFF}%s{FFFFFF}] Player Rank: [{C6E2FF}%s{FFFFFF}] Level score: [{F7FF00}%d/%d{FFFFFF}] Warns: [{F7FF00}%d{FFFFFF}/{FF0000}20{FFFFFF}]\n", charData[p2][cName], ORANK(p2), pData[p2][pLevelUp], scoremath, pData[p2][pWarn]);
    strcat(S3MP4K, coordsString);
	format(coordsString, sizeof(coordsString), "Word: [{C6E2FF}%d{FFFFFF}] Interior: [{C6E2FF}%d{FFFFFF}] Health: [{ff0000}%.1f{FFFFFF}] Armour: [{ff0000}%.1f{FFFFFF}] Character Story: [{00FF00}%s{FFFFFF}]\n",GetPlayerVirtualWorld(p2), GetPlayerInterior(p2), pData[p2][pHealth], pData[p2][pArmour], csstatus);
    strcat(S3MP4K, coordsString);
    format(coordsString, sizeof(coordsString), "Time Played : [{00CCFF}%d hour(s) %d minute(s) %02d second(s){FFFFFF}] Donator rank: [{FF0000}%s{FFFFFF}] Gold: [{F7FF00}%d{FFFFFF}]\n",pData[p2][pHours], pData[p2][pMinutes], pData[p2][pSeconds], drank, pData[p2][pGold]);
    strcat(S3MP4K, coordsString);
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, idiot, S3MP4K,"Close","");	
	return 1;
}
/*IsValidNameUCP(const name[])
{
	new len = strlen(name);

	for(new ch = 0; ch != len; ch++)
	{
		switch(name[ch])
		{
			case 'A' .. 'Z', 'a' .. 'z', '0' .. '9': continue;
			default: return false;
		}
	}
	return true;
}*/
DisplayItems(playerid, p2)
{
	new mstr[512], lstr[1024];
	format(mstr, sizeof(mstr), "Items (%s)", pData[p2][pName]);
    format(lstr, sizeof(lstr), "Name\tAmmount\nCash\t$%s\n", FormatMoney(pData[p2][pMoney]));
	if(pData[p2][pBandage] > 0)
	{
		format(lstr, sizeof(lstr), "%s\nBandage\t%d", lstr, pData[p2][pBandage]);
	}
	if(pData[p2][pSnack] > 0)
	{
		format(lstr, sizeof(lstr), "%s\nSnack\t%d", lstr, pData[p2][pSnack]);
	}
	if(pData[p2][pSprunk] > 0)
	{
		format(lstr, sizeof(lstr), "%s\nSprunk\t%d", lstr, pData[p2][pSprunk]);
	}
	if(pData[p2][pRokok] > 0)
	{
		format(lstr, sizeof(lstr), "%s\nCigaretes\t%d", lstr, pData[p2][pRokok]);
	}
	if(pData[p2][pMedicine] > 0)
	{
		format(lstr, sizeof(lstr), "%s\nMedicine\t%d", lstr, pData[p2][pMedicine]);
	}
	if(pData[p2][pMedkit] > 0)
	{
		format(lstr, sizeof(lstr), "%s\nMedkit\t%d", lstr, pData[p2][pMedkit]);
	}
	if(pData[p2][pComponent] > 0)
	{
		format(lstr, sizeof(lstr), "%s\nComponent\t%d", lstr, pData[p2][pComponent]);
	}
	if(pData[p2][pFood] > 0)
	{
		format(lstr, sizeof(lstr), "%s\nFood\t%d", lstr, pData[p2][pFood]);
	}
	if(pData[p2][pWorm] > 0)
	{
		format(lstr, sizeof(lstr), "%s\nBait\t%d", lstr, pData[p2][pWorm]);
	}
	if(pData[p2][pFish] > 0)
	{
		format(lstr, sizeof(lstr), "%s\nFish total\t%d Lbs", lstr, pData[p2][pFish]);
	}
	if(pData[p2][pFish1] > 0)
	{
		format(lstr, sizeof(lstr), "%s\nFish total\t%d Lbs", lstr, pData[p2][pFish1]);
	}
	if(pData[p2][pFish2] > 0)
	{
		format(lstr, sizeof(lstr), "%s\nFish total\t%d Lbs", lstr, pData[p2][pFish2]);
	}
	if(pData[p2][pFish3] > 0)
	{
		format(lstr, sizeof(lstr), "%s\nFish total\t%d Lbs", lstr, pData[p2][pFish3]);
	}
	if(pData[p2][pFish4] > 0)
	{
		format(lstr, sizeof(lstr), "%s\nFish total\t%d Lbs", lstr, pData[p2][pFish4]);
	}
	if(pData[p2][pPayToll] > 0)
	{
		format(lstr, sizeof(lstr), "%s\nToll Card\t%d", lstr, pData[p2][pPayToll]);
	}
	if(pData[p2][pSeedWheat] > 0)
	{
		format(lstr, sizeof(lstr), "%s\n[SEED] Wheat\t%d Units", lstr, pData[p2][pSeedWheat]);
	}
	if(pData[p2][pSeedOnion] > 0)
	{
		format(lstr, sizeof(lstr), "%s\n[SEED] Onion\t%d Units", lstr, pData[p2][pSeedOnion]);
	}
	if(pData[p2][pSeedCarrot] > 0)
	{
		format(lstr, sizeof(lstr), "%s\n[SEED] Carrot\t%d Units", lstr, pData[p2][pSeedCarrot]);
	}
	if(pData[p2][pSeedPotato] > 0)
	{
		format(lstr, sizeof(lstr), "%s\n[SEED] Potato\t%d Units", lstr, pData[p2][pSeedPotato]);
	}
	if(pData[p2][pSeedCorn] > 0)
	{
		format(lstr, sizeof(lstr), "%s\n[SEED] Corn\t%d Units", lstr, pData[p2][pSeedCorn]);
	}
	if(pData[p2][pWheat] > 0)
	{
		format(lstr, sizeof(lstr), "%s\n[PLANT] Wheat\t%d Units", lstr, pData[p2][pWheat]);
	}
	if(pData[p2][pOnion] > 0)
	{
		format(lstr, sizeof(lstr), "%s\n[PLANT] Onion\t%d Units", lstr, pData[p2][pOnion]);
	}
	if(pData[p2][pCarrot] > 0)
	{
		format(lstr, sizeof(lstr), "%s\n[PLANT] Carrot\t%d Units", lstr, pData[p2][pCarrot]);
	}
	if(pData[p2][pPotato] > 0)
	{
		format(lstr, sizeof(lstr), "%s\n[PLANT] Potato\t%d Units", lstr, pData[p2][pPotato]);
	}
	if(pData[p2][pCorn] > 0)
	{
		format(lstr, sizeof(lstr), "%s\n[PLANT] Corn\t%d Units", lstr, pData[p2][pCorn]);
	}
	if(pData[p2][pCrack] > 0)
	{
		format(lstr, sizeof(lstr), "%s\n"RED_E"Crack\t"RED_E"%d gram(s)", lstr, pData[p2][pCrack]);
	}
	if(pData[p2][pPot] > 0)
	{
		format(lstr, sizeof(lstr), "%s\n"RED_E"Pot\t"RED_E"%d gram(s)", lstr, pData[p2][pPot]);
	}
	if(pData[p2][pMaterial] > 0)
	{
		format(lstr, sizeof(lstr), "%s\n"RED_E"Material\t%d units", lstr, pData[p2][pMaterial]);
	}
    for(new i; i < 13; ++i)
   	{
	    new weapons[13][2];
	    GetPlayerWeaponData(p2, i, weapons[i][0], weapons[i][1]);
		if(pData[p2][pGuns][i] > 0)
		{
			new wname[212];
			GetWeaponName(pData[p2][pGuns][i], wname, sizeof(wname));
			format(lstr, sizeof(lstr), "%s\n{FF0000}[WEAPON] %s\t%d Ammo\n", lstr, wname, pData[p2][pAmmo][i]);
		}
	}
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, mstr, lstr,"Close","");
	return 1;
}

ReturnTimelapse(start, till)
{
    new ret[32];
	new second = till - start;

	const
		MINUTE = 60,
		HOUR = 60 * MINUTE,
		DAY = 24 * HOUR,
		MONTH = 30 * DAY;

	if (second == 1)
		format(ret, sizeof(ret), "a second");
	if (second < (1 * MINUTE))
		format(ret, sizeof(ret), "%i seconds", second);
	else if (second < (2 * MINUTE))
		format(ret, sizeof(ret), "a minute");
	else if (second < (45 * MINUTE))
		format(ret, sizeof(ret), "%i minutes", (second / MINUTE));
	else if (second < (90 * MINUTE))
		format(ret, sizeof(ret), "an hour");
	else if (second < (24 * HOUR))
		format(ret, sizeof(ret), "%i hours", (second / HOUR));
	else if (second < (48 * HOUR))
		format(ret, sizeof(ret), "a day");
	else if (second < (30 * DAY))
		format(ret, sizeof(ret), "%i days", (second / DAY));
	else if (second < (12 * MONTH))
    {
		new month = floatround(second / DAY / 30);
      	if (month <= 1)
			format(ret, sizeof(ret), "a month");
      	else
			format(ret, sizeof(ret), "%i months", month);
	}
    else
    {
      	new year = floatround(second / DAY / 365);
      	if (year <= 1)
			format(ret, sizeof(ret), "a year");
      	else
			format(ret, sizeof(ret), "%i years", year);
	}
	return ret;
}

GetPlayerGender(playerid)
{
	new gender[26];
	switch(pData[playerid][pGender]) 	
	{
		case 1: gender = "Male";
		case 2: gender = "Female";
	}
	return gender;
}

GetPlayerAccent(playerid) 
{
	new accent[26];
	switch(pData[playerid][pAccent1]) 	
	{
		case 0: accent = "United States Of America";
		case 1: accent = "Singapore";
		case 2: accent = "Indonesia";
		case 3: accent = "Afganistan";
		case 4: accent = "Albania";
		case 5: accent = "Pakistan";
		case 6: accent = "Phillpines";
		case 7: accent = "Russian";
		case 8: accent = "Qatar";
		case 9: accent = "Spanish";
		case 10: accent = "Argentina";
		case 11: accent = "Arabic";
		case 12: accent = "Australia";
		case 13: accent = "Bangladesh";
		case 14: accent = "Brazil";
		case 15: accent = "Bulgaria";
		case 16: accent = "Canada";
		case 17: accent = "China";
		case 18: accent = "Colombia";
		case 19: accent = "Congo";
		case 20: accent = "Denmark";
		case 21: accent = "Italian";
		case 22: accent = "Germany";
		case 23: accent = "HongKong";
		case 24: accent = "India";
		case 25: accent = "Iran";
		case 26: accent = "Iraq";
		case 27: accent = "Jamaica";
		case 28: accent = "Japan";
		case 29: accent = "Korea";
		case 30: accent = "Mexico";
	}
	return accent;
}

GetLicenseDriver(playerid) 
{
	new Text1[500];
	if(pData[playerid][pDriveLic] == 1) 
	{
		Text1 = experieddate(pData[playerid][pDriveLicTime], 1); 
	}
	else if(pData[playerid][pDriveLic] == 0)
	{ 
		Text1 = ""WHITE_E"[{FF0000}Not passed"WHITE_E"]"; 
	} 
	else if(pData[playerid][pDriveLic] == 2)
	{ 
		Text1 = experieddate(pData[playerid][pDriveLicTime], 2); 
	}
	
	return Text1;
}

GetLicenseFly(playerid) 
{
	new Text2[500];
	if(pData[playerid][pFlyLic] == 1) 
	{ 
		Text2 = experieddate(pData[playerid][pFlyLicTime], 1); 
	}
	else if(pData[playerid][pFlyLic] == 0)
	{ 
		Text2 = ""WHITE_E"[{FF0000}Not passed"WHITE_E"]"; 
	} 
	else if(pData[playerid][pFlyLic] == 2)
	{ 
		Text2 = experieddate(pData[playerid][pFlyLicTime], 2); 
	}
	
	return Text2;
}

GetLicenseBoat(playerid) 
{
	new Text3[500];
	if(pData[playerid][pBoatLic] == 1) 
	{ 
		Text3 = experieddate(pData[playerid][pBoatLicTime], 1); 
	}
	else if(pData[playerid][pBoatLic] == 0)
	{ 
		Text3 = ""WHITE_E"[{FF0000}Not passed"WHITE_E"]"; 
	} 
	else if(pData[playerid][pBoatLic] == 2)
	{ 
		Text3 = experieddate(pData[playerid][pBoatLicTime], 2); 
	}
	return Text3;
}

GetLicenseGun(playerid) 
{
	new Text4[500];
	if(pData[playerid][pGunLic] == 1) 
	{ 
		Text4 = experieddate(pData[playerid][pGunLicTime], 1); 
	}
	else if(pData[playerid][pGunLic] == 0)
	{ 
		Text4 = ""WHITE_E"[{FF0000}Not passed"WHITE_E"]"; 
	} 
	else if(pData[playerid][pGunLic] == 2)
	{ 
		Text4 = experieddate(pData[playerid][pGunLicTime], 2); 
	}
	
	return Text4;
}

GetLicenseTrucker(playerid) 
{
	new Text5[500];
	if(pData[playerid][pTruckerLic] == 1) 
	{ 
		Text5 = experieddate(pData[playerid][pTruckerLicTime], 1); 
	}
	else if(pData[playerid][pTruckerLic] == 0)
	{ 
		Text5 = ""WHITE_E"[{FF0000}Not passed"WHITE_E"]"; 
	} 
	else if(pData[playerid][pTruckerLic] == 2)
	{ 
		Text5 = experieddate(pData[playerid][pTruckerLicTime], 2); 
	}
	
	return Text5;
}

GetLicenseLumber(playerid) 
{
	new Text6[500];
	if(pData[playerid][pLumberLic] == 1) 
	{ 
		Text6 = experieddate(pData[playerid][pLumberLicTime], 1); 
	}
	else if(pData[playerid][pLumberLic] == 0)
	{ 
		Text6 = ""WHITE_E"[{FF0000}Not passed"WHITE_E"]"; 
	} 
	else if(pData[playerid][pLumberLic] == 2)
	{ 
		Text6 = experieddate(pData[playerid][pLumberLicTime], 2); 
	}
	
	return Text6;
}

//----------[ Vehicle Native ]---------
IsVehicleEmpty(vehicleid)
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
			if(IsPlayerInVehicle(i, vehicleid)) return 0;
	}
	return 1;
}

JB_IsBicycle(vehicleid)
{
	switch (GetVehicleModel(vehicleid))
	{
		case 481, 509, 510: return 1;
	}
	return 0;
}

IsABoat(vehicleid)
{
    switch (GetVehicleModel(vehicleid)) {
        case 430, 446, 452, 453, 454, 472, 473, 484, 493, 595: return 1;
    }
    return 0;
}

IsABike(vehicleid)
{
    switch (GetVehicleModel(vehicleid)) {
        case 448, 461..463, 468, 521..523, 581, 586, 481, 509, 510: return 1;
    }
    return 0;
}

IsAPlane(vehicleid)
{
    switch (GetVehicleModel(vehicleid)) {
        case 460, 464, 476, 511, 512, 513, 519, 520, 553, 577, 592, 593: return 1;
    }
    return 0;
}

IsAHelicopter(vehicleid)
{
    switch (GetVehicleModel(vehicleid)) {
        case 417, 425, 447, 465, 469, 487, 488, 497, 501, 548, 563: return 1;
    }
    return 0;
}

IsATowTruck(vehicleid)
{
	if(GetVehicleModel(vehicleid) == 485 || GetVehicleModel(vehicleid) == 525 || GetVehicleModel(vehicleid) == 583 || GetVehicleModel(vehicleid) == 574)
	{
		return 1;
	}
	return 0;
}

IsATruck(vehicleid)
{
	switch(GetVehicleModel(vehicleid))
	{
	    case 414, 455, 456, 498, 499, 609, 515: return 1;
	    default: return 0;
	}

	return 0;
}

IsATruckCrate(vehicleid)
{
	switch(GetVehicleModel(vehicleid))
	{
	    case 455, 499: return 1;
	    default: return 0;
	}

	return 0;
}

IsAPickup(vehicleid)
{
    switch (GetVehicleModel(vehicleid)) {
        case 478, 422, 543, 554: return 1;
    }
    return 0;
}

IsAMechanic(vehicleid)
{
    switch (GetVehicleModel(vehicleid)) {
        case 422, 543, 525: return 1;
    }
    return 0;
}

IsEngineVehicle(vehicleid)
{
    static const g_aEngineStatus[] = {
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1,
        1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0
    };
    new modelid = GetVehicleModel(vehicleid);

    if(modelid < 400 || modelid > 611)
        return 0;

    return (g_aEngineStatus[modelid - 400]);
}

GetVehicleMaxSeats(vehicleid)
{
    static const g_arrMaxSeats[] = {
        4, 2, 2, 2, 4, 4, 1, 2, 2, 4, 2, 2, 2, 4, 2, 2, 4, 2, 4, 2, 4, 4, 2, 2, 2, 1, 4, 4, 4, 2,
        1, 7, 1, 2, 2, 0, 2, 7, 4, 2, 4, 1, 2, 2, 2, 4, 1, 2, 1, 0, 0, 2, 1, 1, 1, 2, 2, 2, 4, 4,
        2, 2, 2, 2, 1, 1, 4, 4, 2, 2, 4, 2, 1, 1, 2, 2, 1, 2, 2, 4, 2, 1, 4, 3, 1, 1, 1, 4, 2, 2,
        4, 2, 4, 1, 2, 2, 2, 4, 4, 2, 2, 1, 2, 2, 2, 2, 2, 4, 2, 1, 1, 2, 1, 1, 2, 2, 4, 2, 2, 1,
        1, 2, 2, 2, 2, 2, 2, 2, 2, 4, 1, 1, 1, 2, 2, 2, 2, 7, 7, 1, 4, 2, 2, 2, 2, 2, 4, 4, 2, 2,
        4, 4, 2, 1, 2, 2, 2, 2, 2, 2, 4, 4, 2, 2, 1, 2, 4, 4, 1, 0, 0, 1, 1, 2, 1, 2, 2, 1, 2, 4,
        4, 2, 4, 1, 0, 4, 2, 2, 2, 2, 0, 0, 7, 2, 2, 1, 4, 4, 4, 2, 2, 2, 2, 2, 4, 2, 0, 0, 0, 4,
        0, 0
    };
    new
        model = GetVehicleModel(vehicleid);

    if(400 <= model <= 611)
        return g_arrMaxSeats[model - 400];

    return 0;
}

RemoveFromVehicle(playerid)
{
    if(IsPlayerInAnyVehicle(playerid))
    {
        static
        Float:fX,
        Float:fY,
        Float:fZ;

        GetPlayerPos(playerid, fX, fY, fZ);
        SetPlayerPos(playerid, fX, fY, fZ + 1.5);
    }
    return 1;
}

GetAvailableSeat(vehicleid, start = 1)
{
    new seats = GetVehicleMaxSeats(vehicleid);

    for (new i = start; i < seats; i ++) if(!IsVehicleSeatUsed(vehicleid, i)) {
        return i;
    }
    return -1;
}

IsVehicleSeatUsed(vehicleid, seat)
{
    foreach (new i : Player) if(IsPlayerInVehicle(i, vehicleid) && GetPlayerVehicleSeat(i) == seat) {
        return 1;
    }
    return 0;
}

//----------[ Other Native]----------

Uptime()
{
	new uptime[40];
	switch(up_days)
	{
	    case 0:
	    {
			if(up_hours)
			{
				if(up_minutes)
					format(uptime, sizeof(uptime), "%d hour%s and %d minute%s", up_hours, (up_hours != 1 ?("s") : ("")), up_minutes, (up_minutes != 1 ? ("s") : ("")));
				else
					format(uptime, sizeof(uptime), "%d hour%s", up_hours, (up_hours != 1 ? ("s") : ("")));
			}
			else
			{
				if(up_minutes)
					format(uptime, sizeof(uptime), "%d minute%s and %d second%s", up_minutes, (up_minutes != 1 ? ("s") : ("")), up_seconds, (up_seconds != 1 ? ("s") : ("")));
				else
					format(uptime, sizeof(uptime), "%d seconds", up_seconds);
			}
		}
		case 1:
		{
			switch(up_hours)
			{
				case 0: uptime = "24 hours";
				case 1: uptime = "one day and 1 hour";
				default: format(uptime, sizeof(uptime), "one day and %d hours", up_hours);
			}
		}
		default:
		{
			switch(up_hours)
			{
				case 0: format(uptime, sizeof(uptime), "%d days", up_days);
				case 1: format(uptime, sizeof(uptime), "%d days and 1 hour", up_days);
				default: format(uptime, sizeof(uptime), "%d days and %d hours", up_days, up_hours);
			}
		}
	}
	return uptime;
}

GetVehicleCost(carid)
{
	//Ini Kendaraan saat beli pakai uang IC

	//Category kendaraan laut
	if(carid == 453) return 350000; //Sancehz

	//Category Kendaraan Bike
	if(carid == 481) return 35000;  //Bmx
	if(carid == 509) return 25000; //Bike
	if(carid == 510) return 25000; //Mt bike
	if(carid == 463) return 150000; //Freeway harley
	if(carid == 521) return 650000; //Fcr 900
	if(carid == 461) return 250000; //Pcj 600
	if(carid == 581) return 150000; //Bf
	if(carid == 468) return 95000; //Sancehz
	if(carid == 586) return 82000; //Wayfare
	if(carid == 462) return 70000; //Faggio

	//Category Kendaraan Cars
	if(carid == 445) return 154000; //Admiral
	if(carid == 496) return 170000; //Blista Compact
	if(carid == 401) return 110000; //Bravura
	if(carid == 518) return 150000; //Buccaneer
	if(carid == 527) return 130000; //Cadrona
	if(carid == 483) return 125000; //Camper
	if(carid == 542) return 90000; //Clover
	if(carid == 589) return 140000; //Club
	if(carid == 507) return 150000; //Elegant
	if(carid == 540) return 132000; //Vincent
	if(carid == 585) return 115000; //Emperor
	if(carid == 419) return 140000; //Esperanto
	if(carid == 526) return 130000; //Fortune
	if(carid == 466) return 120000; //Glendale
	if(carid == 492) return 125000; //Greenwood
	if(carid == 474) return 150000; //Hermes
	if(carid == 546) return 156000; //Intruder
	if(carid == 517) return 125000; //Majestic
	if(carid == 410) return 140000; //Manana
	if(carid == 551) return 140000; //Merit
	if(carid == 516) return 140000; //Nebula
	if(carid == 467) return 125000; //Oceanic
	if(carid == 404) return 132000; //Perenniel
	if(carid == 600) return 125000; //Picador
	if(carid == 426) return 125000; //Premier
	if(carid == 436) return 116000; //Previon
	if(carid == 547) return 121000; //Primo
	if(carid == 405) return 122000; //Sentinel
	if(carid == 458) return 133000; //Solair
	if(carid == 439) return 135000; //Stallion
	if(carid == 550) return 240000; //Sunrise
	if(carid == 566) return 120000; //Tahoma
	if(carid == 549) return 100000; //Tampa
	if(carid == 491) return 100000; //Virgo
	if(carid == 412) return 100000; //Voodoo
	if(carid == 421) return 220000; //Washington
	if(carid == 529) return 300000; //Willard
	if(carid == 555) return 130000; //Windsor
	if(carid == 580) return 160000; //Stafford
	if(carid == 475) return 130000; //Sabre
	if(carid == 545) return 150000; //Hustler
	
	//Category Kendaraan Lowriders
	if(carid == 536) return 130000; //Blade
	if(carid == 575) return 130000; //Broadway
	if(carid == 533) return 130000; //Feltzer
	if(carid == 534) return 130000; //Remington
	if(carid == 567) return 150000; //Savanna
	if(carid == 535) return 100000; //Slamvan
	if(carid == 576) return 130000; //Tornado
	if(carid == 566) return 150000; //Tahoma
	if(carid == 412) return 100000; //Voodoo
	
	//Category Kendaraan SUVS Cars
	if(carid == 579) return 240000; //Huntley
	if(carid == 400) return 210000; //Landstalker
	if(carid == 500) return 220000; //Mesa
	if(carid == 489) return 250000; //Rancher
	if(carid == 479) return 210000; //Regina
	if(carid == 482) return 230000; //Burrito
	if(carid == 418) return 270000; //Moonbeam
	if(carid == 413) return 210000; //Pony
	//if(carid == 554) return 18000; //Yosemite
	
	//Category Kendaraan Sports
	if(carid == 602) return 110000; //Alpha
	if(carid == 429) return 250000; //Banshee
	if(carid == 562) return 530000; //Elegy
	if(carid == 587) return 450000; //Euros
	if(carid == 565) return 320000; //Flash
	if(carid == 559) return 250000; //Jester
	if(carid == 561) return 220000; //Stratum
	if(carid == 560) return 670000; //Sultan
	if(carid == 506) return 580000; //Super GT
	if(carid == 558) return 150000; //Uranus
	if(carid == 477) return 380000; //Zr-350
	if(carid == 480) return 270000; //Comet
	
	//Category Kendaraan Non Dealer
	if(carid == 434) return 1200000; //Hotknife
	if(carid == 502) return 1500000; //Hotring Racer
	if(carid == 495) return 2000000; //Sandking
	if(carid == 451) return 1300000; //Turismo
	if(carid == 470) return 2000000; //Patriot
	if(carid == 424) return 1200000; //BF Injection
	if(carid == 522) return 700000; //Nrg
	if(carid == 411) return 1250000; //Infernus
	if(carid == 541) return 1350000; //Bullet
	if(carid == 504) return 1200000; //Bloodring Banger
	if(carid == 603) return 700000; //Phoenix
	if(carid == 415) return 1200000; //Cheetah
	if(carid == 402) return 1300000; //Buffalo
	if(carid == 508) return 500000; //Journey
	if(carid == 457) return 2500000; //Caddy
	if(carid == 471) return 700000; //Quad

	//Category Kendaraan Job
	if(carid == 420) return 85000; //Taxi
	if(carid == 438) return 55000; //Cabbie
	if(carid == 403) return 150000; //Linerunner
	if(carid == 414) return 340000; //Mule
	if(carid == 422) return 85000; //Bobcat
	if(carid == 440) return 150000; //Rumpo
	if(carid == 455) return 120000; //Flatbead
	if(carid == 456) return 95000; //Yankee
	if(carid == 478) return 90000; //Walton
	if(carid == 498) return 100000; //Boxville
	if(carid == 499) return 95000; //Benson
	if(carid == 514) return 150000; //Tanker
	if(carid == 515) return 550000; //Roadtrain
	if(carid == 524) return 200000; //Cement Truck
	if(carid == 525) return 85000; //Towtruck
	if(carid == 543) return 90000; //Sadler
	if(carid == 552) return 200000; //Utility Van
	if(carid == 554) return 150000; //Yosemite
	if(carid == 578) return 200000; //DFT-30
	if(carid == 609) return 100000; //Boxville
	if(carid == 423) return 120000; //Mr Whoopee/Ice cream
	if(carid == 588) return 100000; //Hotdog
 	return -1;
}

GetVehicleDealerCost(carid)
{
	if(carid == 401) return 230000; //Bravura
	if(carid == 585) return 210000;  //Emperor
	if(carid == 546) return 220000; //Intruder
	if(carid == 547) return 220000; //Primo
	if(carid == 549) return 260000; //Tampa
	if(carid == 560) return 560000; //Sultan
	if(carid == 550) return 280000; //Sunrise
	if(carid == 551) return 210000; //Merit
	if(carid == 562) return 530000; //Elegy
	if(carid == 540) return 210000; //Vincent
	if(carid == 542) return 280000; //Clover
	if(carid == 529) return 260000; //Willard
	if(carid == 527) return 220000; //Cadrona
	if(carid == 517) return 210000; //Majestic
	if(carid == 518) return 200000; //Buccaneer
	if(carid == 507) return 260000; //Elegant
	if(carid == 516) return 210000; //Nebula
	if(carid == 492) return 180000; //Greenwood
	if(carid == 491) return 170000; //Virgo
	if(carid == 474) return 90000; //Hermes
	if(carid == 436) return 220000; //Previon
	if(carid == 445) return 250000; //Admiral
	if(carid == 419) return 270000; //Esperanto
	if(carid == 426) return 290000; //Premier
	if(carid == 421) return 230000; //Washington
	if(carid == 410) return 200000; //Manana
	if(carid == 405) return 190000; //Sentinel
	if(carid == 466) return 200000; //Glendale
	if(carid == 467) return 190000; //Oceanic
	if(carid == 581) return 160000; //BF-400
	if(carid == 586) return 140000; //Wayfarer
	if(carid == 521) return 540000; //FCR-900
	if(carid == 468) return 100000; //Sanchez
	if(carid == 471) return 310000; //Quad
	if(carid == 462) return 60000; //Faggio
	if(carid == 463) return 190000; //Freeway
	if(carid == 461) return 180000; //PCJ-600
	if(carid == 404) return 190000; //Perenniel
	if(carid == 458) return 380000; //Solair
	if(carid == 561) return 400000; //Stratum
	if(carid == 479) return 290000; //Regina
	if(carid == 418) return 290000; //Moonbeam
	if(carid == 534) return 290000; //Remington
	if(carid == 535) return 390000; //Slamvan
	if(carid == 536) return 290000; //Blade
	if(carid == 566) return 270000; //Tahoma
	if(carid == 567) return 270000; //Savanna
	if(carid == 575) return 250000; //Broadway
	if(carid == 576) return 180000; //Tornado
	if(carid == 412) return 190000; //Voodoo
	if(carid == 400) return 320000; //Landstalker
	if(carid == 500) return 360000; //Mesa
	if(carid == 579) return 500000; //Huntley
	if(carid == 554) return 390000; //Yosemite
	if(carid == 545) return 300000; //Hustler
	if(carid == 483) return 300000; //Camper
	if(carid == 508) return 490000; //Journey
	if(carid == 480) return 480000; //Comet
	if(carid == 439) return 430000; //Stallion
	if(carid == 533) return 420000; //Feltzer
	if(carid == 413) return 230000; //Pony
	if(carid == 543) return 140000; //Sadler
	if(carid == 422) return 170000; //Bobcat
	if(carid == 478) return 120000; //Walton
	if(carid == 482) return 200000; //Burrito
	if(carid == 600) return 130000; //Picador
	if(carid == 602) return 220000; //Alpha
	if(carid == 587) return 390000; //Euros
	if(carid == 589) return 330000; //Club
	if(carid == 565) return 330000; //Flash
	if(carid == 559) return 250000; //Jester
	if(carid == 558) return 150000; //Uranus
	if(carid == 429) return 900000; //Banshee
	if(carid == 402) return 280000; //Bufallo
	if(carid == 415) return 550000; //Cheetah
	if(carid == 475) return 170000; //Sabre
	if(carid == 477) return 380000; //ZR-350
	if(carid == 496) return 280000; //Blista Compact
 	return -1;
}

GetVehicleCostVIP(carid)
{
	if(carid == 522) return 2000000; //NRG-500
	if(carid == 411) return 1500000; //Infernus
	if(carid == 451) return 1250000; //Turismo
	if(carid == 494) return 1250000; //Hotring
	if(carid == 541) return 1100000; //Bullet
	if(carid == 573) return 2000000; //Duneride
 	return -1;
}

SendClientMessageEx(playerid, color, const text[], {Float, _}:...)
{
    static
        args,
            str[144];

    if((args = numargs()) == 3)
    {
            SendClientMessage(playerid, color, text);
    }
    else
    {
        while (--args >= 3)
        {
            #emit LCTRL 5
            #emit LOAD.alt args
            #emit SHL.C.alt 2
            #emit ADD.C 12
            #emit ADD
            #emit LOAD.I
            #emit PUSH.pri
        }
        #emit PUSH.S text
        #emit PUSH.C 144
        #emit PUSH.C str
        #emit PUSH.S 8
        #emit SYSREQ.C format
        #emit LCTRL 5
        #emit SCTRL 4

        SendClientMessage(playerid, color, str);

        #emit RETN
    }
    return 1;
}

SendClientMessageToAllEx(color, const text[], {Float, _}:...)
{
    static
        args,
            str[144];

    if((args = numargs()) == 2)
    {
            SendClientMessageToAll(color, text);
    }
    else
    {
        while (--args >= 2)
        {
            #emit LCTRL 5
            #emit LOAD.alt args
            #emit SHL.C.alt 2
            #emit ADD.C 12
            #emit ADD
            #emit LOAD.I
            #emit PUSH.pri
        }
        #emit PUSH.S text
        #emit PUSH.C 144
        #emit PUSH.C str
        #emit LOAD.S.pri 8
        #emit ADD.C 4
        #emit PUSH.pri
        #emit SYSREQ.C format
        #emit LCTRL 5
        #emit SCTRL 4

        SendClientMessageToAll(color, str);

        #emit RETN
    }
    return 1;
}

SendNearbyMessage(playerid, Float:radius, color, const str[], {Float,_}:...)
{
    static
        args,
        start,
        end,
        string[144]
    ;
    #emit LOAD.S.pri 8
    #emit STOR.pri args

    if(args > 16)
    {
        #emit ADDR.pri str
        #emit STOR.pri start

        for (end = start + (args - 16); end > start; end -= 4)
        {
            #emit LREF.pri end
            #emit PUSH.pri
        }
        #emit PUSH.S str
        #emit PUSH.C 144
        #emit PUSH.C string

        #emit LOAD.S.pri 8
        #emit CONST.alt 4
        #emit SUB
        #emit PUSH.pri

        #emit SYSREQ.C format
        #emit LCTRL 5
        #emit SCTRL 4

        foreach (new i : Player)
        {
            if(NearPlayer(i, playerid, radius)) {
                SendClientMessage(i, color, string);
            }
        }
        return 1;
    }
    foreach (new i : Player)
    {
        if(NearPlayer(i, playerid, radius)) {
            SendClientMessage(i, color, str);
        }
    }
    return 1;
}

SetPlayerPosition(playerid, Float:X, Float:Y, Float:Z, Float:a, inter = 0)
{
    SetPlayerInterior(playerid, inter);
    SetPlayerPos(playerid, X, Y, Z);
	SetPlayerFacingAngle(playerid, a);
	SetCameraBehindPlayer(playerid);
	//SetPlayerWorldBounds(playerid, 20000, -20000, 20000, -20000);
}

SetPlayerPositionEx(playerid, Float:x, Float:y, Float:z, Float:a, time = 2000)
{
    if(pData[playerid][pFreeze])
    {
        KillTimer(pData[playerid][pFreezeTimer]);
        pData[playerid][pFreeze] = 0;
        TogglePlayerControllable(playerid, 1);
    }
	TogglePlayerControllable(playerid, 0);
    SetCameraBehindPlayer(playerid);
    pData[playerid][pFreeze] = 1;
    SetPlayerPos(playerid, x, y, z + 0.5);
	SetPlayerFacingAngle(playerid, a);
	pData[playerid][pFreezeTimer] = SetTimerEx("SetPlayerToUnfreeze", time, false, "iffff", playerid, x, y, z, a);
}

SendPlayerToPlayer(playerid, targetid)
{
    new
        Float:x,
        Float:y,
        Float:z;
		
	if(pData[targetid][pSpawned] == 0 || pData[playerid][pSpawned] == 0)
	{
		Error(playerid, "Player/Target sedang tidak spawn!");
		return 1;
	}
	if(pData[playerid][pJail] > 0 || pData[targetid][pJail] > 0)
		return Error(playerid, "Player/Target sedang di jail");
		
	if(pData[playerid][pArrest] > 0 || pData[targetid][pArrest] > 0)
		return Error(playerid, "Player/Target sedang di arrest");
		
    GetPlayerPos(targetid, x, y, z);

    if(IsPlayerInAnyVehicle(playerid))
    {
        SetVehiclePos(GetPlayerVehicleID(playerid), x, y + 2, z);
        LinkVehicleToInterior(GetPlayerVehicleID(playerid), GetPlayerInterior(targetid));
    }
    else
    {
        SetPlayerPosition(playerid, x + 1, y, z, 750);
    }
    SetPlayerInterior(playerid, GetPlayerInterior(targetid));
    SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(targetid));

    pData[playerid][pInHouse] = pData[targetid][pInHouse];
    pData[playerid][pInBiz] = pData[targetid][pInBiz];
    pData[playerid][pInDoor] = pData[targetid][pInDoor];
    return 1;
}

ProxDetector(Float: f_Radius, playerid, string[],col1,col2,col3,col4,col5) 
{
		new
			Float: f_playerPos[3];

		GetPlayerPos(playerid, f_playerPos[0], f_playerPos[1], f_playerPos[2]);
		foreach(new i : Player) 
		{
			if(!pData[i][pSPY]) 
			{
				if(GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid)) 
				{
					if(IsPlayerInRangeOfPoint(i, f_Radius / 16, f_playerPos[0], f_playerPos[1], f_playerPos[2])) {
						SendClientMessage(i, col1, string);
					}
					else if(IsPlayerInRangeOfPoint(i, f_Radius / 8, f_playerPos[0], f_playerPos[1], f_playerPos[2])) {
						SendClientMessage(i, col2, string);
					}
					else if(IsPlayerInRangeOfPoint(i, f_Radius / 4, f_playerPos[0], f_playerPos[1], f_playerPos[2])) {
						SendClientMessage(i, col3, string);
					}
					else if(IsPlayerInRangeOfPoint(i, f_Radius / 2, f_playerPos[0], f_playerPos[1], f_playerPos[2])) {
						SendClientMessage(i, col4, string);
					}
					else if(IsPlayerInRangeOfPoint(i, f_Radius, f_playerPos[0], f_playerPos[1], f_playerPos[2])) {
						SendClientMessage(i, col5, string);
					}
				}
			}
			else SendClientMessage(i, col1, string);
		}
		return 1;
}

NearPlayer(playerid, targetid, Float:radius)
{
    static
        Float:fX,
        Float:fY,
        Float:fZ;

    GetPlayerPos(targetid, fX, fY, fZ);

    return (GetPlayerInterior(playerid) == GetPlayerInterior(targetid) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(targetid)) && IsPlayerInRangeOfPoint(playerid, radius, fX, fY, fZ);
}

GetLocation(Float:fX, Float:fY, Float:fZ)
{
    enum e_ZoneData
    {
            e_ZoneName[32 char],
        Float:e_ZoneArea[6]
    };
    static const g_arrZoneData[][e_ZoneData] =
    {
        {!"The Big Ear",                {-410.00, 1403.30, -3.00, -137.90, 1681.20, 200.00}},
        {!"Aldea Malvada",                {-1372.10, 2498.50, 0.00, -1277.50, 2615.30, 200.00}},
        {!"Angel Pine",                   {-2324.90, -2584.20, -6.10, -1964.20, -2212.10, 200.00}},
        {!"Arco del Oeste",               {-901.10, 2221.80, 0.00, -592.00, 2571.90, 200.00}},
        {!"Avispa Country Club",          {-2646.40, -355.40, 0.00, -2270.00, -222.50, 200.00}},
        {!"Avispa Country Club",          {-2831.80, -430.20, -6.10, -2646.40, -222.50, 200.00}},
        {!"Avispa Country Club",          {-2361.50, -417.10, 0.00, -2270.00, -355.40, 200.00}},
        {!"Avispa Country Club",          {-2667.80, -302.10, -28.80, -2646.40, -262.30, 71.10}},
        {!"Avispa Country Club",          {-2470.00, -355.40, 0.00, -2270.00, -318.40, 46.10}},
        {!"Avispa Country Club",          {-2550.00, -355.40, 0.00, -2470.00, -318.40, 39.70}},
        {!"Back o Beyond",                {-1166.90, -2641.10, 0.00, -321.70, -1856.00, 200.00}},
        {!"Battery Point",                {-2741.00, 1268.40, -4.50, -2533.00, 1490.40, 200.00}},
        {!"Bayside",                      {-2741.00, 2175.10, 0.00, -2353.10, 2722.70, 200.00}},
        {!"Bayside Marina",               {-2353.10, 2275.70, 0.00, -2153.10, 2475.70, 200.00}},
        {!"Beacon Hill",                  {-399.60, -1075.50, -1.40, -319.00, -977.50, 198.50}},
        {!"Blackfield",                   {964.30, 1203.20, -89.00, 1197.30, 1403.20, 110.90}},
        {!"Blackfield",                   {964.30, 1403.20, -89.00, 1197.30, 1726.20, 110.90}},
        {!"Blackfield Chapel",            {1375.60, 596.30, -89.00, 1558.00, 823.20, 110.90}},
        {!"Blackfield Chapel",            {1325.60, 596.30, -89.00, 1375.60, 795.00, 110.90}},
        {!"Blackfield Intersection",      {1197.30, 1044.60, -89.00, 1277.00, 1163.30, 110.90}},
        {!"Blackfield Intersection",      {1166.50, 795.00, -89.00, 1375.60, 1044.60, 110.90}},
        {!"Blackfield Intersection",      {1277.00, 1044.60, -89.00, 1315.30, 1087.60, 110.90}},
        {!"Blackfield Intersection",      {1375.60, 823.20, -89.00, 1457.30, 919.40, 110.90}},
        {!"Blueberry",                    {104.50, -220.10, 2.30, 349.60, 152.20, 200.00}},
        {!"Blueberry",                    {19.60, -404.10, 3.80, 349.60, -220.10, 200.00}},
        {!"Blueberry Acres",              {-319.60, -220.10, 0.00, 104.50, 293.30, 200.00}},
        {!"Caligula's Palace",            {2087.30, 1543.20, -89.00, 2437.30, 1703.20, 110.90}},
        {!"Caligula's Palace",            {2137.40, 1703.20, -89.00, 2437.30, 1783.20, 110.90}},
        {!"Calton Heights",               {-2274.10, 744.10, -6.10, -1982.30, 1358.90, 200.00}},
        {!"Chinatown",                    {-2274.10, 578.30, -7.60, -2078.60, 744.10, 200.00}},
        {!"City Hall",                    {-2867.80, 277.40, -9.10, -2593.40, 458.40, 200.00}},
        {!"Come-A-Lot",                   {2087.30, 943.20, -89.00, 2623.10, 1203.20, 110.90}},
        {!"Commerce",                     {1323.90, -1842.20, -89.00, 1701.90, -1722.20, 110.90}},
        {!"Commerce",                     {1323.90, -1722.20, -89.00, 1440.90, -1577.50, 110.90}},
        {!"Commerce",                     {1370.80, -1577.50, -89.00, 1463.90, -1384.90, 110.90}},
        {!"Commerce",                     {1463.90, -1577.50, -89.00, 1667.90, -1430.80, 110.90}},
        {!"Commerce",                     {1583.50, -1722.20, -89.00, 1758.90, -1577.50, 110.90}},
        {!"Commerce",                     {1667.90, -1577.50, -89.00, 1812.60, -1430.80, 110.90}},
        {!"Conference Center",            {1046.10, -1804.20, -89.00, 1323.90, -1722.20, 110.90}},
        {!"Conference Center",            {1073.20, -1842.20, -89.00, 1323.90, -1804.20, 110.90}},
        {!"Cranberry Station",            {-2007.80, 56.30, 0.00, -1922.00, 224.70, 100.00}},
        {!"Creek",                        {2749.90, 1937.20, -89.00, 2921.60, 2669.70, 110.90}},
        {!"Dillimore",                    {580.70, -674.80, -9.50, 861.00, -404.70, 200.00}},
        {!"Doherty",                      {-2270.00, -324.10, -0.00, -1794.90, -222.50, 200.00}},
        {!"Doherty",                      {-2173.00, -222.50, -0.00, -1794.90, 265.20, 200.00}},
        {!"Downtown",                     {-1982.30, 744.10, -6.10, -1871.70, 1274.20, 200.00}},
        {!"Downtown",                     {-1871.70, 1176.40, -4.50, -1620.30, 1274.20, 200.00}},
        {!"Downtown",                     {-1700.00, 744.20, -6.10, -1580.00, 1176.50, 200.00}},
        {!"Downtown",                     {-1580.00, 744.20, -6.10, -1499.80, 1025.90, 200.00}},
        {!"Downtown",                     {-2078.60, 578.30, -7.60, -1499.80, 744.20, 200.00}},
        {!"Downtown",                     {-1993.20, 265.20, -9.10, -1794.90, 578.30, 200.00}},
        {!"Downtown Los Santos",          {1463.90, -1430.80, -89.00, 1724.70, -1290.80, 110.90}},
        {!"Downtown Los Santos",          {1724.70, -1430.80, -89.00, 1812.60, -1250.90, 110.90}},
        {!"Downtown Los Santos",          {1463.90, -1290.80, -89.00, 1724.70, -1150.80, 110.90}},
        {!"Downtown Los Santos",          {1370.80, -1384.90, -89.00, 1463.90, -1170.80, 110.90}},
        {!"Downtown Los Santos",          {1724.70, -1250.90, -89.00, 1812.60, -1150.80, 110.90}},
        {!"Downtown Los Santos",          {1370.80, -1170.80, -89.00, 1463.90, -1130.80, 110.90}},
        {!"Downtown Los Santos",          {1378.30, -1130.80, -89.00, 1463.90, -1026.30, 110.90}},
        {!"Downtown Los Santos",          {1391.00, -1026.30, -89.00, 1463.90, -926.90, 110.90}},
        {!"Downtown Los Santos",          {1507.50, -1385.20, 110.90, 1582.50, -1325.30, 335.90}},
        {!"East Beach",                   {2632.80, -1852.80, -89.00, 2959.30, -1668.10, 110.90}},
        {!"East Beach",                   {2632.80, -1668.10, -89.00, 2747.70, -1393.40, 110.90}},
        {!"East Beach",                   {2747.70, -1668.10, -89.00, 2959.30, -1498.60, 110.90}},
        {!"East Beach",                   {2747.70, -1498.60, -89.00, 2959.30, -1120.00, 110.90}},
        {!"East Los Santos",              {2421.00, -1628.50, -89.00, 2632.80, -1454.30, 110.90}},
        {!"East Los Santos",              {2222.50, -1628.50, -89.00, 2421.00, -1494.00, 110.90}},
        {!"East Los Santos",              {2266.20, -1494.00, -89.00, 2381.60, -1372.00, 110.90}},
        {!"East Los Santos",              {2381.60, -1494.00, -89.00, 2421.00, -1454.30, 110.90}},
        {!"East Los Santos",              {2281.40, -1372.00, -89.00, 2381.60, -1135.00, 110.90}},
        {!"East Los Santos",              {2381.60, -1454.30, -89.00, 2462.10, -1135.00, 110.90}},
        {!"East Los Santos",              {2462.10, -1454.30, -89.00, 2581.70, -1135.00, 110.90}},
        {!"Easter Basin",                 {-1794.90, 249.90, -9.10, -1242.90, 578.30, 200.00}},
        {!"Easter Basin",                 {-1794.90, -50.00, -0.00, -1499.80, 249.90, 200.00}},
        {!"Easter Bay Airport",           {-1499.80, -50.00, -0.00, -1242.90, 249.90, 200.00}},
        {!"Easter Bay Airport",           {-1794.90, -730.10, -3.00, -1213.90, -50.00, 200.00}},
        {!"Easter Bay Airport",           {-1213.90, -730.10, 0.00, -1132.80, -50.00, 200.00}},
        {!"Easter Bay Airport",           {-1242.90, -50.00, 0.00, -1213.90, 578.30, 200.00}},
        {!"Easter Bay Airport",           {-1213.90, -50.00, -4.50, -947.90, 578.30, 200.00}},
        {!"Easter Bay Airport",           {-1315.40, -405.30, 15.40, -1264.40, -209.50, 25.40}},
        {!"Easter Bay Airport",           {-1354.30, -287.30, 15.40, -1315.40, -209.50, 25.40}},
        {!"Easter Bay Airport",           {-1490.30, -209.50, 15.40, -1264.40, -148.30, 25.40}},
        {!"Easter Bay Chemicals",         {-1132.80, -768.00, 0.00, -956.40, -578.10, 200.00}},
        {!"Easter Bay Chemicals",         {-1132.80, -787.30, 0.00, -956.40, -768.00, 200.00}},
        {!"El Castillo del Diablo",       {-464.50, 2217.60, 0.00, -208.50, 2580.30, 200.00}},
        {!"El Castillo del Diablo",       {-208.50, 2123.00, -7.60, 114.00, 2337.10, 200.00}},
        {!"El Castillo del Diablo",       {-208.50, 2337.10, 0.00, 8.40, 2487.10, 200.00}},
        {!"El Corona",                    {1812.60, -2179.20, -89.00, 1970.60, -1852.80, 110.90}},
        {!"El Corona",                    {1692.60, -2179.20, -89.00, 1812.60, -1842.20, 110.90}},
        {!"El Quebrados",                 {-1645.20, 2498.50, 0.00, -1372.10, 2777.80, 200.00}},
        {!"Esplanade East",               {-1620.30, 1176.50, -4.50, -1580.00, 1274.20, 200.00}},
        {!"Esplanade East",               {-1580.00, 1025.90, -6.10, -1499.80, 1274.20, 200.00}},
        {!"Esplanade East",               {-1499.80, 578.30, -79.60, -1339.80, 1274.20, 20.30}},
        {!"Esplanade North",              {-2533.00, 1358.90, -4.50, -1996.60, 1501.20, 200.00}},
        {!"Esplanade North",              {-1996.60, 1358.90, -4.50, -1524.20, 1592.50, 200.00}},
        {!"Esplanade North",              {-1982.30, 1274.20, -4.50, -1524.20, 1358.90, 200.00}},
        {!"Fallen Tree",                  {-792.20, -698.50, -5.30, -452.40, -380.00, 200.00}},
        {!"Fallow Bridge",                {434.30, 366.50, 0.00, 603.00, 555.60, 200.00}},
        {!"Fern Ridge",                   {508.10, -139.20, 0.00, 1306.60, 119.50, 200.00}},
        {!"Financial",                    {-1871.70, 744.10, -6.10, -1701.30, 1176.40, 300.00}},
        {!"Fisher's Lagoon",              {1916.90, -233.30, -100.00, 2131.70, 13.80, 200.00}},
        {!"Flint Intersection",           {-187.70, -1596.70, -89.00, 17.00, -1276.60, 110.90}},
        {!"Flint Range",                  {-594.10, -1648.50, 0.00, -187.70, -1276.60, 200.00}},
        {!"Fort Carson",                  {-376.20, 826.30, -3.00, 123.70, 1220.40, 200.00}},
        {!"Foster Valley",                {-2270.00, -430.20, -0.00, -2178.60, -324.10, 200.00}},
        {!"Foster Valley",                {-2178.60, -599.80, -0.00, -1794.90, -324.10, 200.00}},
        {!"Foster Valley",                {-2178.60, -1115.50, 0.00, -1794.90, -599.80, 200.00}},
        {!"Foster Valley",                {-2178.60, -1250.90, 0.00, -1794.90, -1115.50, 200.00}},
        {!"Frederick Bridge",             {2759.20, 296.50, 0.00, 2774.20, 594.70, 200.00}},
        {!"Gant Bridge",                  {-2741.40, 1659.60, -6.10, -2616.40, 2175.10, 200.00}},
        {!"Gant Bridge",                  {-2741.00, 1490.40, -6.10, -2616.40, 1659.60, 200.00}},
        {!"Ganton",                       {2222.50, -1852.80, -89.00, 2632.80, -1722.30, 110.90}},
        {!"Ganton",                       {2222.50, -1722.30, -89.00, 2632.80, -1628.50, 110.90}},
        {!"Garcia",                       {-2411.20, -222.50, -0.00, -2173.00, 265.20, 200.00}},
        {!"Garcia",                       {-2395.10, -222.50, -5.30, -2354.00, -204.70, 200.00}},
        {!"Garver Bridge",                {-1339.80, 828.10, -89.00, -1213.90, 1057.00, 110.90}},
        {!"Garver Bridge",                {-1213.90, 950.00, -89.00, -1087.90, 1178.90, 110.90}},
        {!"Garver Bridge",                {-1499.80, 696.40, -179.60, -1339.80, 925.30, 20.30}},
        {!"Glen Park",                    {1812.60, -1449.60, -89.00, 1996.90, -1350.70, 110.90}},
        {!"Glen Park",                    {1812.60, -1100.80, -89.00, 1994.30, -973.30, 110.90}},
        {!"Glen Park",                    {1812.60, -1350.70, -89.00, 2056.80, -1100.80, 110.90}},
        {!"Green Palms",                  {176.50, 1305.40, -3.00, 338.60, 1520.70, 200.00}},
        {!"Greenglass College",           {964.30, 1044.60, -89.00, 1197.30, 1203.20, 110.90}},
        {!"Greenglass College",           {964.30, 930.80, -89.00, 1166.50, 1044.60, 110.90}},
        {!"Hampton Barns",                {603.00, 264.30, 0.00, 761.90, 366.50, 200.00}},
        {!"Hankypanky Point",             {2576.90, 62.10, 0.00, 2759.20, 385.50, 200.00}},
        {!"Harry Gold Parkway",           {1777.30, 863.20, -89.00, 1817.30, 2342.80, 110.90}},
        {!"Hashbury",                     {-2593.40, -222.50, -0.00, -2411.20, 54.70, 200.00}},
        {!"Hilltop Farm",                 {967.30, -450.30, -3.00, 1176.70, -217.90, 200.00}},
        {!"Hunter Quarry",                {337.20, 710.80, -115.20, 860.50, 1031.70, 203.70}},
        {!"Idlewood",                     {1812.60, -1852.80, -89.00, 1971.60, -1742.30, 110.90}},
        {!"Idlewood",                     {1812.60, -1742.30, -89.00, 1951.60, -1602.30, 110.90}},
        {!"Idlewood",                     {1951.60, -1742.30, -89.00, 2124.60, -1602.30, 110.90}},
        {!"Idlewood",                     {1812.60, -1602.30, -89.00, 2124.60, -1449.60, 110.90}},
        {!"Idlewood",                     {2124.60, -1742.30, -89.00, 2222.50, -1494.00, 110.90}},
        {!"Idlewood",                     {1971.60, -1852.80, -89.00, 2222.50, -1742.30, 110.90}},
        {!"Jefferson",                    {1996.90, -1449.60, -89.00, 2056.80, -1350.70, 110.90}},
        {!"Jefferson",                    {2124.60, -1494.00, -89.00, 2266.20, -1449.60, 110.90}},
        {!"Jefferson",                    {2056.80, -1372.00, -89.00, 2281.40, -1210.70, 110.90}},
        {!"Jefferson",                    {2056.80, -1210.70, -89.00, 2185.30, -1126.30, 110.90}},
        {!"Jefferson",                    {2185.30, -1210.70, -89.00, 2281.40, -1154.50, 110.90}},
        {!"Jefferson",                    {2056.80, -1449.60, -89.00, 2266.20, -1372.00, 110.90}},
        {!"Julius Thruway East",          {2623.10, 943.20, -89.00, 2749.90, 1055.90, 110.90}},
        {!"Julius Thruway East",          {2685.10, 1055.90, -89.00, 2749.90, 2626.50, 110.90}},
        {!"Julius Thruway East",          {2536.40, 2442.50, -89.00, 2685.10, 2542.50, 110.90}},
        {!"Julius Thruway East",          {2625.10, 2202.70, -89.00, 2685.10, 2442.50, 110.90}},
        {!"Julius Thruway North",         {2498.20, 2542.50, -89.00, 2685.10, 2626.50, 110.90}},
        {!"Julius Thruway North",         {2237.40, 2542.50, -89.00, 2498.20, 2663.10, 110.90}},
        {!"Julius Thruway North",         {2121.40, 2508.20, -89.00, 2237.40, 2663.10, 110.90}},
        {!"Julius Thruway North",         {1938.80, 2508.20, -89.00, 2121.40, 2624.20, 110.90}},
        {!"Julius Thruway North",         {1534.50, 2433.20, -89.00, 1848.40, 2583.20, 110.90}},
        {!"Julius Thruway North",         {1848.40, 2478.40, -89.00, 1938.80, 2553.40, 110.90}},
        {!"Julius Thruway North",         {1704.50, 2342.80, -89.00, 1848.40, 2433.20, 110.90}},
        {!"Julius Thruway North",         {1377.30, 2433.20, -89.00, 1534.50, 2507.20, 110.90}},
        {!"Julius Thruway South",         {1457.30, 823.20, -89.00, 2377.30, 863.20, 110.90}},
        {!"Julius Thruway South",         {2377.30, 788.80, -89.00, 2537.30, 897.90, 110.90}},
        {!"Julius Thruway West",          {1197.30, 1163.30, -89.00, 1236.60, 2243.20, 110.90}},
        {!"Julius Thruway West",          {1236.60, 2142.80, -89.00, 1297.40, 2243.20, 110.90}},
        {!"Juniper Hill",                 {-2533.00, 578.30, -7.60, -2274.10, 968.30, 200.00}},
        {!"Juniper Hollow",               {-2533.00, 968.30, -6.10, -2274.10, 1358.90, 200.00}},
        {!"K.A.C.C. Military Fuels",      {2498.20, 2626.50, -89.00, 2749.90, 2861.50, 110.90}},
        {!"Kincaid Bridge",               {-1339.80, 599.20, -89.00, -1213.90, 828.10, 110.90}},
        {!"Kincaid Bridge",               {-1213.90, 721.10, -89.00, -1087.90, 950.00, 110.90}},
        {!"Kincaid Bridge",               {-1087.90, 855.30, -89.00, -961.90, 986.20, 110.90}},
        {!"King's",                       {-2329.30, 458.40, -7.60, -1993.20, 578.30, 200.00}},
        {!"King's",                       {-2411.20, 265.20, -9.10, -1993.20, 373.50, 200.00}},
        {!"King's",                       {-2253.50, 373.50, -9.10, -1993.20, 458.40, 200.00}},
        {!"LVA Freight Depot",            {1457.30, 863.20, -89.00, 1777.40, 1143.20, 110.90}},
        {!"LVA Freight Depot",            {1375.60, 919.40, -89.00, 1457.30, 1203.20, 110.90}},
        {!"LVA Freight Depot",            {1277.00, 1087.60, -89.00, 1375.60, 1203.20, 110.90}},
        {!"LVA Freight Depot",            {1315.30, 1044.60, -89.00, 1375.60, 1087.60, 110.90}},
        {!"LVA Freight Depot",            {1236.60, 1163.40, -89.00, 1277.00, 1203.20, 110.90}},
        {!"Las Barrancas",                {-926.10, 1398.70, -3.00, -719.20, 1634.60, 200.00}},
        {!"Las Brujas",                   {-365.10, 2123.00, -3.00, -208.50, 2217.60, 200.00}},
        {!"Las Colinas",                  {1994.30, -1100.80, -89.00, 2056.80, -920.80, 110.90}},
        {!"Las Colinas",                  {2056.80, -1126.30, -89.00, 2126.80, -920.80, 110.90}},
        {!"Las Colinas",                  {2185.30, -1154.50, -89.00, 2281.40, -934.40, 110.90}},
        {!"Las Colinas",                  {2126.80, -1126.30, -89.00, 2185.30, -934.40, 110.90}},
        {!"Las Colinas",                  {2747.70, -1120.00, -89.00, 2959.30, -945.00, 110.90}},
        {!"Las Colinas",                  {2632.70, -1135.00, -89.00, 2747.70, -945.00, 110.90}},
        {!"Las Colinas",                  {2281.40, -1135.00, -89.00, 2632.70, -945.00, 110.90}},
        {!"Las Payasadas",                {-354.30, 2580.30, 2.00, -133.60, 2816.80, 200.00}},
        {!"Las Venturas Airport",         {1236.60, 1203.20, -89.00, 1457.30, 1883.10, 110.90}},
        {!"Las Venturas Airport",         {1457.30, 1203.20, -89.00, 1777.30, 1883.10, 110.90}},
        {!"Las Venturas Airport",         {1457.30, 1143.20, -89.00, 1777.40, 1203.20, 110.90}},
        {!"Las Venturas Airport",         {1515.80, 1586.40, -12.50, 1729.90, 1714.50, 87.50}},
        {!"Last Dime Motel",              {1823.00, 596.30, -89.00, 1997.20, 823.20, 110.90}},
        {!"Leafy Hollow",                 {-1166.90, -1856.00, 0.00, -815.60, -1602.00, 200.00}},
        {!"Liberty City",                 {-1000.00, 400.00, 1300.00, -700.00, 600.00, 1400.00}},
        {!"Lil' Probe Inn",               {-90.20, 1286.80, -3.00, 153.80, 1554.10, 200.00}},
        {!"Linden Side",                  {2749.90, 943.20, -89.00, 2923.30, 1198.90, 110.90}},
        {!"Linden Station",               {2749.90, 1198.90, -89.00, 2923.30, 1548.90, 110.90}},
        {!"Linden Station",               {2811.20, 1229.50, -39.50, 2861.20, 1407.50, 60.40}},
        {!"Little Mexico",                {1701.90, -1842.20, -89.00, 1812.60, -1722.20, 110.90}},
        {!"Little Mexico",                {1758.90, -1722.20, -89.00, 1812.60, -1577.50, 110.90}},
        {!"Los Flores",                   {2581.70, -1454.30, -89.00, 2632.80, -1393.40, 110.90}},
        {!"Los Flores",                   {2581.70, -1393.40, -89.00, 2747.70, -1135.00, 110.90}},
        {!"Los Santos International",     {1249.60, -2394.30, -89.00, 1852.00, -2179.20, 110.90}},
        {!"Los Santos International",     {1852.00, -2394.30, -89.00, 2089.00, -2179.20, 110.90}},
        {!"Los Santos International",     {1382.70, -2730.80, -89.00, 2201.80, -2394.30, 110.90}},
        {!"Los Santos International",     {1974.60, -2394.30, -39.00, 2089.00, -2256.50, 60.90}},
        {!"Los Santos International",     {1400.90, -2669.20, -39.00, 2189.80, -2597.20, 60.90}},
        {!"Los Santos International",     {2051.60, -2597.20, -39.00, 2152.40, -2394.30, 60.90}},
        {!"Marina",                       {647.70, -1804.20, -89.00, 851.40, -1577.50, 110.90}},
        {!"Marina",                       {647.70, -1577.50, -89.00, 807.90, -1416.20, 110.90}},
        {!"Marina",                       {807.90, -1577.50, -89.00, 926.90, -1416.20, 110.90}},
        {!"Market",                       {787.40, -1416.20, -89.00, 1072.60, -1310.20, 110.90}},
        {!"Market",                       {952.60, -1310.20, -89.00, 1072.60, -1130.80, 110.90}},
        {!"Market",                       {1072.60, -1416.20, -89.00, 1370.80, -1130.80, 110.90}},
        {!"Market",                       {926.90, -1577.50, -89.00, 1370.80, -1416.20, 110.90}},
        {!"Market Station",               {787.40, -1410.90, -34.10, 866.00, -1310.20, 65.80}},
        {!"Martin Bridge",                {-222.10, 293.30, 0.00, -122.10, 476.40, 200.00}},
        {!"Missionary Hill",              {-2994.40, -811.20, 0.00, -2178.60, -430.20, 200.00}},
        {!"Montgomery",                   {1119.50, 119.50, -3.00, 1451.40, 493.30, 200.00}},
        {!"Montgomery",                   {1451.40, 347.40, -6.10, 1582.40, 420.80, 200.00}},
        {!"Montgomery Intersection",      {1546.60, 208.10, 0.00, 1745.80, 347.40, 200.00}},
        {!"Montgomery Intersection",      {1582.40, 347.40, 0.00, 1664.60, 401.70, 200.00}},
        {!"Mulholland",                   {1414.00, -768.00, -89.00, 1667.60, -452.40, 110.90}},
        {!"Mulholland",                   {1281.10, -452.40, -89.00, 1641.10, -290.90, 110.90}},
        {!"Mulholland",                   {1269.10, -768.00, -89.00, 1414.00, -452.40, 110.90}},
        {!"Mulholland",                   {1357.00, -926.90, -89.00, 1463.90, -768.00, 110.90}},
        {!"Mulholland",                   {1318.10, -910.10, -89.00, 1357.00, -768.00, 110.90}},
        {!"Mulholland",                   {1169.10, -910.10, -89.00, 1318.10, -768.00, 110.90}},
        {!"Mulholland",                   {768.60, -954.60, -89.00, 952.60, -860.60, 110.90}},
        {!"Mulholland",                   {687.80, -860.60, -89.00, 911.80, -768.00, 110.90}},
        {!"Mulholland",                   {737.50, -768.00, -89.00, 1142.20, -674.80, 110.90}},
        {!"Mulholland",                   {1096.40, -910.10, -89.00, 1169.10, -768.00, 110.90}},
        {!"Mulholland",                   {952.60, -937.10, -89.00, 1096.40, -860.60, 110.90}},
        {!"Mulholland",                   {911.80, -860.60, -89.00, 1096.40, -768.00, 110.90}},
        {!"Mulholland",                   {861.00, -674.80, -89.00, 1156.50, -600.80, 110.90}},
        {!"Mulholland Intersection",      {1463.90, -1150.80, -89.00, 1812.60, -768.00, 110.90}},
        {!"North Rock",                   {2285.30, -768.00, 0.00, 2770.50, -269.70, 200.00}},
        {!"Ocean Docks",                  {2373.70, -2697.00, -89.00, 2809.20, -2330.40, 110.90}},
        {!"Ocean Docks",                  {2201.80, -2418.30, -89.00, 2324.00, -2095.00, 110.90}},
        {!"Ocean Docks",                  {2324.00, -2302.30, -89.00, 2703.50, -2145.10, 110.90}},
        {!"Ocean Docks",                  {2089.00, -2394.30, -89.00, 2201.80, -2235.80, 110.90}},
        {!"Ocean Docks",                  {2201.80, -2730.80, -89.00, 2324.00, -2418.30, 110.90}},
        {!"Ocean Docks",                  {2703.50, -2302.30, -89.00, 2959.30, -2126.90, 110.90}},
        {!"Ocean Docks",                  {2324.00, -2145.10, -89.00, 2703.50, -2059.20, 110.90}},
        {!"Ocean Flats",                  {-2994.40, 277.40, -9.10, -2867.80, 458.40, 200.00}},
        {!"Ocean Flats",                  {-2994.40, -222.50, -0.00, -2593.40, 277.40, 200.00}},
        {!"Ocean Flats",                  {-2994.40, -430.20, -0.00, -2831.80, -222.50, 200.00}},
        {!"Octane Springs",               {338.60, 1228.50, 0.00, 664.30, 1655.00, 200.00}},
        {!"Old Venturas Strip",           {2162.30, 2012.10, -89.00, 2685.10, 2202.70, 110.90}},
        {!"Palisades",                    {-2994.40, 458.40, -6.10, -2741.00, 1339.60, 200.00}},
        {!"Palomino Creek",               {2160.20, -149.00, 0.00, 2576.90, 228.30, 200.00}},
        {!"Paradiso",                     {-2741.00, 793.40, -6.10, -2533.00, 1268.40, 200.00}},
        {!"Pershing Square",              {1440.90, -1722.20, -89.00, 1583.50, -1577.50, 110.90}},
        {!"Pilgrim",                      {2437.30, 1383.20, -89.00, 2624.40, 1783.20, 110.90}},
        {!"Pilgrim",                      {2624.40, 1383.20, -89.00, 2685.10, 1783.20, 110.90}},
        {!"Pilson Intersection",          {1098.30, 2243.20, -89.00, 1377.30, 2507.20, 110.90}},
        {!"Pirates in Men's Pants",       {1817.30, 1469.20, -89.00, 2027.40, 1703.20, 110.90}},
        {!"Playa del Seville",            {2703.50, -2126.90, -89.00, 2959.30, -1852.80, 110.90}},
        {!"Prickle Pine",                 {1534.50, 2583.20, -89.00, 1848.40, 2863.20, 110.90}},
        {!"Prickle Pine",                 {1117.40, 2507.20, -89.00, 1534.50, 2723.20, 110.90}},
        {!"Prickle Pine",                 {1848.40, 2553.40, -89.00, 1938.80, 2863.20, 110.90}},
        {!"Prickle Pine",                 {1938.80, 2624.20, -89.00, 2121.40, 2861.50, 110.90}},
        {!"Queens",                       {-2533.00, 458.40, 0.00, -2329.30, 578.30, 200.00}},
        {!"Queens",                       {-2593.40, 54.70, 0.00, -2411.20, 458.40, 200.00}},
        {!"Queens",                       {-2411.20, 373.50, 0.00, -2253.50, 458.40, 200.00}},
        {!"Randolph Industrial Estate",   {1558.00, 596.30, -89.00, 1823.00, 823.20, 110.90}},
        {!"Redsands East",                {1817.30, 2011.80, -89.00, 2106.70, 2202.70, 110.90}},
        {!"Redsands East",                {1817.30, 2202.70, -89.00, 2011.90, 2342.80, 110.90}},
        {!"Redsands East",                {1848.40, 2342.80, -89.00, 2011.90, 2478.40, 110.90}},
        {!"Redsands West",                {1236.60, 1883.10, -89.00, 1777.30, 2142.80, 110.90}},
        {!"Redsands West",                {1297.40, 2142.80, -89.00, 1777.30, 2243.20, 110.90}},
        {!"Redsands West",                {1377.30, 2243.20, -89.00, 1704.50, 2433.20, 110.90}},
        {!"Redsands West",                {1704.50, 2243.20, -89.00, 1777.30, 2342.80, 110.90}},
        {!"Regular Tom",                  {-405.70, 1712.80, -3.00, -276.70, 1892.70, 200.00}},
        {!"Richman",                      {647.50, -1118.20, -89.00, 787.40, -954.60, 110.90}},
        {!"Richman",                      {647.50, -954.60, -89.00, 768.60, -860.60, 110.90}},
        {!"Richman",                      {225.10, -1369.60, -89.00, 334.50, -1292.00, 110.90}},
        {!"Richman",                      {225.10, -1292.00, -89.00, 466.20, -1235.00, 110.90}},
        {!"Richman",                      {72.60, -1404.90, -89.00, 225.10, -1235.00, 110.90}},
        {!"Richman",                      {72.60, -1235.00, -89.00, 321.30, -1008.10, 110.90}},
        {!"Richman",                      {321.30, -1235.00, -89.00, 647.50, -1044.00, 110.90}},
        {!"Richman",                      {321.30, -1044.00, -89.00, 647.50, -860.60, 110.90}},
        {!"Richman",                      {321.30, -860.60, -89.00, 687.80, -768.00, 110.90}},
        {!"Richman",                      {321.30, -768.00, -89.00, 700.70, -674.80, 110.90}},
        {!"Robada Intersection",          {-1119.00, 1178.90, -89.00, -862.00, 1351.40, 110.90}},
        {!"Roca Escalante",               {2237.40, 2202.70, -89.00, 2536.40, 2542.50, 110.90}},
        {!"Roca Escalante",               {2536.40, 2202.70, -89.00, 2625.10, 2442.50, 110.90}},
        {!"Rockshore East",               {2537.30, 676.50, -89.00, 2902.30, 943.20, 110.90}},
        {!"Rockshore West",               {1997.20, 596.30, -89.00, 2377.30, 823.20, 110.90}},
        {!"Rockshore West",               {2377.30, 596.30, -89.00, 2537.30, 788.80, 110.90}},
        {!"Rodeo",                        {72.60, -1684.60, -89.00, 225.10, -1544.10, 110.90}},
        {!"Rodeo",                        {72.60, -1544.10, -89.00, 225.10, -1404.90, 110.90}},
        {!"Rodeo",                        {225.10, -1684.60, -89.00, 312.80, -1501.90, 110.90}},
        {!"Rodeo",                        {225.10, -1501.90, -89.00, 334.50, -1369.60, 110.90}},
        {!"Rodeo",                        {334.50, -1501.90, -89.00, 422.60, -1406.00, 110.90}},
        {!"Rodeo",                        {312.80, -1684.60, -89.00, 422.60, -1501.90, 110.90}},
        {!"Rodeo",                        {422.60, -1684.60, -89.00, 558.00, -1570.20, 110.90}},
        {!"Rodeo",                        {558.00, -1684.60, -89.00, 647.50, -1384.90, 110.90}},
        {!"Rodeo",                        {466.20, -1570.20, -89.00, 558.00, -1385.00, 110.90}},
        {!"Rodeo",                        {422.60, -1570.20, -89.00, 466.20, -1406.00, 110.90}},
        {!"Rodeo",                        {466.20, -1385.00, -89.00, 647.50, -1235.00, 110.90}},
        {!"Rodeo",                        {334.50, -1406.00, -89.00, 466.20, -1292.00, 110.90}},
        {!"Royal Casino",                 {2087.30, 1383.20, -89.00, 2437.30, 1543.20, 110.90}},
        {!"San Andreas Sound",            {2450.30, 385.50, -100.00, 2759.20, 562.30, 200.00}},
        {!"Santa Flora",                  {-2741.00, 458.40, -7.60, -2533.00, 793.40, 200.00}},
        {!"Santa Maria Beach",            {342.60, -2173.20, -89.00, 647.70, -1684.60, 110.90}},
        {!"Santa Maria Beach",            {72.60, -2173.20, -89.00, 342.60, -1684.60, 110.90}},
        {!"Shady Cabin",                  {-1632.80, -2263.40, -3.00, -1601.30, -2231.70, 200.00}},
        {!"Shady Creeks",                 {-1820.60, -2643.60, -8.00, -1226.70, -1771.60, 200.00}},
        {!"Shady Creeks",                 {-2030.10, -2174.80, -6.10, -1820.60, -1771.60, 200.00}},
        {!"Sobell Rail Yards",            {2749.90, 1548.90, -89.00, 2923.30, 1937.20, 110.90}},
        {!"Spinybed",                     {2121.40, 2663.10, -89.00, 2498.20, 2861.50, 110.90}},
        {!"Starfish Casino",              {2437.30, 1783.20, -89.00, 2685.10, 2012.10, 110.90}},
        {!"Starfish Casino",              {2437.30, 1858.10, -39.00, 2495.00, 1970.80, 60.90}},
        {!"Starfish Casino",              {2162.30, 1883.20, -89.00, 2437.30, 2012.10, 110.90}},
        {!"Temple",                       {1252.30, -1130.80, -89.00, 1378.30, -1026.30, 110.90}},
        {!"Temple",                       {1252.30, -1026.30, -89.00, 1391.00, -926.90, 110.90}},
        {!"Temple",                       {1252.30, -926.90, -89.00, 1357.00, -910.10, 110.90}},
        {!"Temple",                       {952.60, -1130.80, -89.00, 1096.40, -937.10, 110.90}},
        {!"Temple",                       {1096.40, -1130.80, -89.00, 1252.30, -1026.30, 110.90}},
        {!"Temple",                       {1096.40, -1026.30, -89.00, 1252.30, -910.10, 110.90}},
        {!"The Camel's Toe",              {2087.30, 1203.20, -89.00, 2640.40, 1383.20, 110.90}},
        {!"The Clown's Pocket",           {2162.30, 1783.20, -89.00, 2437.30, 1883.20, 110.90}},
        {!"The Emerald Isle",             {2011.90, 2202.70, -89.00, 2237.40, 2508.20, 110.90}},
        {!"The Farm",                     {-1209.60, -1317.10, 114.90, -908.10, -787.30, 251.90}},
        {!"The Four Dragons Casino",      {1817.30, 863.20, -89.00, 2027.30, 1083.20, 110.90}},
        {!"The High Roller",              {1817.30, 1283.20, -89.00, 2027.30, 1469.20, 110.90}},
        {!"The Mako Span",                {1664.60, 401.70, 0.00, 1785.10, 567.20, 200.00}},
        {!"The Panopticon",               {-947.90, -304.30, -1.10, -319.60, 327.00, 200.00}},
        {!"The Pink Swan",                {1817.30, 1083.20, -89.00, 2027.30, 1283.20, 110.90}},
        {!"The Sherman Dam",              {-968.70, 1929.40, -3.00, -481.10, 2155.20, 200.00}},
        {!"The Strip",                    {2027.40, 863.20, -89.00, 2087.30, 1703.20, 110.90}},
        {!"The Strip",                    {2106.70, 1863.20, -89.00, 2162.30, 2202.70, 110.90}},
        {!"The Strip",                    {2027.40, 1783.20, -89.00, 2162.30, 1863.20, 110.90}},
        {!"The Strip",                    {2027.40, 1703.20, -89.00, 2137.40, 1783.20, 110.90}},
        {!"The Visage",                   {1817.30, 1863.20, -89.00, 2106.70, 2011.80, 110.90}},
        {!"The Visage",                   {1817.30, 1703.20, -89.00, 2027.40, 1863.20, 110.90}},
        {!"Unity Station",                {1692.60, -1971.80, -20.40, 1812.60, -1932.80, 79.50}},
        {!"Valle Ocultado",               {-936.60, 2611.40, 2.00, -715.90, 2847.90, 200.00}},
        {!"Verdant Bluffs",               {930.20, -2488.40, -89.00, 1249.60, -2006.70, 110.90}},
        {!"Verdant Bluffs",               {1073.20, -2006.70, -89.00, 1249.60, -1842.20, 110.90}},
        {!"Verdant Bluffs",               {1249.60, -2179.20, -89.00, 1692.60, -1842.20, 110.90}},
        {!"Verdant Meadows",              {37.00, 2337.10, -3.00, 435.90, 2677.90, 200.00}},
        {!"Verona Beach",                 {647.70, -2173.20, -89.00, 930.20, -1804.20, 110.90}},
        {!"Verona Beach",                 {930.20, -2006.70, -89.00, 1073.20, -1804.20, 110.90}},
        {!"Verona Beach",                 {851.40, -1804.20, -89.00, 1046.10, -1577.50, 110.90}},
        {!"Verona Beach",                 {1161.50, -1722.20, -89.00, 1323.90, -1577.50, 110.90}},
        {!"Verona Beach",                 {1046.10, -1722.20, -89.00, 1161.50, -1577.50, 110.90}},
        {!"Vinewood",                     {787.40, -1310.20, -89.00, 952.60, -1130.80, 110.90}},
        {!"Vinewood",                     {787.40, -1130.80, -89.00, 952.60, -954.60, 110.90}},
        {!"Vinewood",                     {647.50, -1227.20, -89.00, 787.40, -1118.20, 110.90}},
        {!"Vinewood",                     {647.70, -1416.20, -89.00, 787.40, -1227.20, 110.90}},
        {!"Whitewood Estates",            {883.30, 1726.20, -89.00, 1098.30, 2507.20, 110.90}},
        {!"Whitewood Estates",            {1098.30, 1726.20, -89.00, 1197.30, 2243.20, 110.90}},
        {!"Willowfield",                  {1970.60, -2179.20, -89.00, 2089.00, -1852.80, 110.90}},
        {!"Willowfield",                  {2089.00, -2235.80, -89.00, 2201.80, -1989.90, 110.90}},
        {!"Willowfield",                  {2089.00, -1989.90, -89.00, 2324.00, -1852.80, 110.90}},
        {!"Willowfield",                  {2201.80, -2095.00, -89.00, 2324.00, -1989.90, 110.90}},
        {!"Willowfield",                  {2541.70, -1941.40, -89.00, 2703.50, -1852.80, 110.90}},
        {!"Willowfield",                  {2324.00, -2059.20, -89.00, 2541.70, -1852.80, 110.90}},
        {!"Willowfield",                  {2541.70, -2059.20, -89.00, 2703.50, -1941.40, 110.90}},
        {!"Yellow Bell Station",          {1377.40, 2600.40, -21.90, 1492.40, 2687.30, 78.00}},
        {!"Los Santos",                   {44.60, -2892.90, -242.90, 2997.00, -768.00, 900.00}},
        {!"Las Venturas",                 {869.40, 596.30, -242.90, 2997.00, 2993.80, 900.00}},
        {!"Bone County",                  {-480.50, 596.30, -242.90, 869.40, 2993.80, 900.00}},
        {!"Tierra Robada",                {-2997.40, 1659.60, -242.90, -480.50, 2993.80, 900.00}},
        {!"Tierra Robada",                {-1213.90, 596.30, -242.90, -480.50, 1659.60, 900.00}},
        {!"San Fierro",                   {-2997.40, -1115.50, -242.90, -1213.90, 1659.60, 900.00}},
        {!"Red County",                   {-1213.90, -768.00, -242.90, 2997.00, 596.30, 900.00}},
        {!"Flint County",                 {-1213.90, -2892.90, -242.90, 44.60, -768.00, 900.00}},
        {!"Whetstone",                    {-2997.40, -2892.90, -242.90, -1213.90, -1115.50, 900.00}}
    };
    new
        name[32] = "San Andreas";

    for (new i = 0; i != sizeof(g_arrZoneData); i ++) if((fX >= g_arrZoneData[i][e_ZoneArea][0] && fX <= g_arrZoneData[i][e_ZoneArea][3]) && (fY >= g_arrZoneData[i][e_ZoneArea][1] && fY <= g_arrZoneData[i][e_ZoneArea][4]) && (fZ >= g_arrZoneData[i][e_ZoneArea][2] && fZ <= g_arrZoneData[i][e_ZoneArea][5])) {
        strunpack(name, g_arrZoneData[i][e_ZoneName]);

        break;
    }
    return name;
}

ReplaceString(text[])
{
    new replace[128];
    format(replace, sizeof(replace), text);

    strreplace(replace, "(e)", "\n");
    strreplace(replace, "(n)", "\n");
    strreplace(replace, "(b)", "{0049FF}");
    strreplace(replace, "(bl)", "{000000}");
    strreplace(replace, "(w)", "{FFFFFF}");
    strreplace(replace, "(r)", "{FF3333}");
    strreplace(replace, "(g)", "{37DB45}");
    strreplace(replace, "(y)", "{F3FF02}");
    return replace;
}

// ConvertTimestamp(Timestamp:timestamp, bool:date = true)
// {
//     new output[256];

//     if(date) TimeFormat(timestamp + Timestamp:UTC_07, "%a %d %b %Y, %T", output);
//     else TimeFormat(timestamp + Timestamp:UTC_07, "%T", output);

//     return output;
// }

ReturnName(playerid)
{
    static
        name[MAX_PLAYER_NAME + 1];

    GetPlayerName(playerid, name, sizeof(name));
    if(pData[playerid][pMaskOn] == 1)
        format(name, sizeof(name), "Mask_#%d", pData[playerid][pMaskID]);

    return name;
}

//Format Money
FormatMoney(Float:amount, delimiter[2]=".", comma[2]=",")
{
	#define MAX_MONEY_String 16
	new txt[MAX_MONEY_String];
	format(txt, MAX_MONEY_String, "%d", floatround(amount));
	new l = strlen(txt);
	if (amount < 0) // -
	{
		if (l > 2) strins(txt,delimiter,l-2);
		if (l > 5) strins(txt,comma,l-5);
		if (l > 8) strins(txt,comma,l-8);
	}
	else
	{//1000000
		if (l > 2) strins(txt,delimiter,l-2);
		if (l > 5) strins(txt,comma,l-5);
		if (l > 9) strins(txt,comma,l-8);
	}
//	if (l <= 2) format(txt,sizeof( szStr ),"00,%s",txt);
	return txt;
}

RandomEx(min, max)
{
    return random(max - min) + min;
}
IsNumeric(const str[])
{
	for (new i = 0, l = strlen(str); i != l; i ++)
    {
        if(i == 0 && str[0] == '-')
        continue;

      	else if(str[i] < '0' || str[i] > '9')
		return 0;
	}
	return 1;
}

//Date and Time
GetMonth(bulan)
{
    static
        month[12];

    switch (bulan) {
        case 1: month = "January";
        case 2: month = "February";
        case 3: month = "March";
        case 4: month = "April";
        case 5: month = "May";
        case 6: month = "June";
        case 7: month = "July";
        case 8: month = "August";
        case 9: month = "September";
        case 10: month = "October";
        case 11: month = "November";
        case 12: month = "December";
    }
    return month;
}

ReturnTime()
{
    static
        date[6],
        string[72];

    getdate(date[2], date[1], date[0]);
    gettime(date[3], date[4], date[5]);

    format(string, sizeof(string), "%02d %s %d, %02d:%02d:%02d", date[0],GetMonth(date[1]), date[2], date[3], date[4], date[5]);
    return string;
}

// ConvertHBEColor(value) 
// {
//     new color;
//     if(value >= 90 && value <= 100)
//         color = 0x1b9913FF;
//     else if(value >= 80 && value < 90)
//         color = 0x1b9913FF;
//     else if(value >= 70 && value < 80)
//         color = 0x1a7f08FF;
//     else if(value >= 60 && value < 70)
//         color = 0x326305FF;
//     else if(value >= 50 && value < 60)
//         color = 0x375d04FF;
//     else if(value >= 40 && value < 50)
//         color = 0x603304FF;
//     else if(value >= 30 && value < 40)
//         color = 0xd72800FF;
//     else if(value >= 10 && value < 30)
//         color = 0xfb3508FF;
//     else if(value >= 0 && value < 10)
//         color = 0xFF0000FF;
//     else 
//         color = COLOR_WHITE;

//     return color;
// }

// ConvertDamageVehicleColor(Float:value) 
// {
//     new color;
//     if(value >= 900 && value <= 1000)
//         color = 0x1b9913FF;
//     else if(value >= 800 && value < 900)
//         color = 0x1b9913FF;
//     else if(value >= 700 && value < 800)
//         color = 0x1a7f08FF;
//     else if(value >= 600 && value < 700)
//         color = 0x326305FF;
//     else if(value >= 500 && value < 600)
//         color = 0x375d04FF;
//     else if(value >= 400 && value < 500)
//         color = 0x603304FF;
//     else if(value >= 300 && value < 400)
//         color = 0xFF0000FF;
//     else 
//         color = COLOR_WHITE;

//     return color;
// }

// ConvertFuelVehicleColor(value) 
// {
//     new color;
//     if(value >= 900 && value <= 1000)
//         color = 0x1b9913FF;
//     else if(value >= 800 && value < 900)
//         color = 0x1b9913FF;
//     else if(value >= 700 && value < 800)
//         color = 0x1a7f08FF;
//     else if(value >= 600 && value < 700)
//         color = 0x326305FF;
//     else if(value >= 500 && value < 600)
//         color = 0x375d04FF;
//     else if(value >= 400 && value < 500)
//         color = 0x603304FF;
//     else if(value >= 300 && value < 400)
//         color = 0xd72800FF;
//     else if(value >= 100 && value < 300)
//         color = 0xfb3508FF;
//     else if(value >= 0 && value < 100)
//         color = 0xFF0000FF;
//     else 
//         color = COLOR_WHITE;

//     return color;
// }

AnticheatCheck(playerid)
{
	// Speedhacking
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && GetVehicleSpeed(GetPlayerVehicleID(playerid)) > 350 && pData[playerid][pAdmin] < 2)
	{
		SendStaffMessage(COLOR_YELLOW, "AdmWarning: %s[%i] is possibly speedhacking, speed: %.1f km/h.", pData[playerid][pName], playerid, GetVehicleSpeed(GetPlayerVehicleID(playerid)));
	}

	// Jetpack
	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK && pData[playerid][pAdmin] < 2)
	{
		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s was auto-kicked by %s, reason: Jetpack", pData[playerid][pName]);
		KickEx(playerid);
	}

	// Flying hacks
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		switch(GetPlayerAnimationIndex(playerid))
		{
			case 958, 1538, 1539, 1543:
			{
				new
					Float:z,
					Float:vx,
					Float:vy,
					Float:vz;

				GetPlayerPos(playerid, z, z, z);
				GetPlayerVelocity(playerid, vx, vy, vz);

				if((z > 20.0) && (0.9 <= floatsqroot((vx * vx) + (vy * vy) + (vz * vz)) <= 1.9) && pData[playerid][pAdmin] < 2)
				{
					SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s was auto-kicked by BotCmd, reason: Flying Hacks", pData[playerid][pName]);
					KickEx(playerid);
				}
			}
		}
	}
}

ProxDetectorS(Float:radi, playerid, targetid) 
{

	if(WatchingTV[playerid] != 1)
	{
	    if(Spectating[targetid] != 0 && pData[playerid][pAdmin] < 2)
	    {
	    	return 0;
	    }

		new
			Float: fp_playerPos[3];

		GetPlayerPos(targetid, fp_playerPos[0], fp_playerPos[1], fp_playerPos[2]);

		if(IsPlayerInRangeOfPoint(playerid, radi, fp_playerPos[0], fp_playerPos[1], fp_playerPos[2]) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(targetid))
		{
			return 1;
		}
	}
	return 0;
}

ColouredText(text[])
{
	//Credits to RyDeR`
	new
	    pos = -1,
	    string[(128 + 16)]
	;
	strmid(string, text, 0, 128, (sizeof(string) - 16));

	while((pos = strfind(string, "#", true, (pos + 1))) != -1)
	{
	    new
	        i = (pos + 1),
	        hexCount
		;
		for( ; ((string[i] != 0) && (hexCount < 6)); ++i, ++hexCount)
		{
		    if (!(('a' <= string[i] <= 'f') || ('A' <= string[i] <= 'F') || ('0' <= string[i] <= '9')))
		    {
		        break;
		    }
		}
		if ((hexCount == 6) && !(hexCount < 6))
		{
			string[pos] = '{';
			strins(string, "}", i);
		}
	}
	return string;
}

FixText(text[])
{
	new len = strlen(text);
	if (len > 1)
	{
		for(new i = 0; i < len; i++)
		{
			if (text[i] == 92)
			{
			    if (text[i+1] == 'n')
			    {
					text[i] = '\n';
					for(new j = i+1; j < len; j++) text[j] = text[j+1], text[j+1] = 0;
					continue;
			    }
			}
		}
	}
	return 1;
}

GetVehicleOffset(vehicleid, OffsetTypes:type,&Float:x,&Float:y,&Float:z)
{
	new Float:fPos[4],Float:fSize[3];

	if(!IsValidVehicle(vehicleid)){
		x = y =	z = 0.0;
		return 0;
	} else {
		GetVehiclePos(vehicleid,fPos[0],fPos[1],fPos[2]);
		GetVehicleZAngle(vehicleid,fPos[3]);
		GetVehicleModelInfo(GetVehicleModel(vehicleid),VEHICLE_MODEL_INFO_SIZE,fSize[0],fSize[1],fSize[2]);

		switch(type){
			case VEHICLE_OFFSET_BOOT: {
				x = fPos[0] - (floatsqroot(fSize[1] + fSize[1]) * floatsin(-fPos[3],degrees));
				y = fPos[1] - (floatsqroot(fSize[1] + fSize[1]) * floatcos(-fPos[3],degrees));
 				z = fPos[2];
			}
			case VEHICLE_OFFSET_HOOD: {
				x = fPos[0] + (floatsqroot(fSize[1] + fSize[1]) * floatsin(-fPos[3],degrees));
				y = fPos[1] + (floatsqroot(fSize[1] + fSize[1]) * floatcos(-fPos[3],degrees));
	 			z = fPos[2];
			}
			case VEHICLE_OFFSET_ROOF: {
				x = fPos[0];
				y = fPos[1];
				z = fPos[2] + floatsqroot(fSize[2]);
			}
		}
	}
	return 1;
}

GetPlayerNameEx(playerid)
{
	new
		name[MAX_PLAYER_NAME];

	GetPlayerName(playerid, name, sizeof(name));
	return name;
}

GetRPName(playerid)
{
	new
		name[MAX_PLAYER_NAME];

	GetPlayerName(playerid, name, sizeof(name));

	for(new i = 0, l = strlen(name); i < l; i ++)
	{
	    if(name[i] == '_')
	    {
	        name[i] = ' ';
		}
	}

	return name;
}