#include <YSI\y_hooks>
#define MAX_CHAR 3  

enum E_CHAR
{
	cID,
	cName[MAX_PLAYER_NAME],
	cIP[16],
	cPassword[65],
	cSalt[17],
    cCharName,
    cCharName2,
    cCharName3,
	cCharBan,
	cCharBanReason,
	cChar1[128],
	cChar2[128],
	cChar3[128],
	cCharLevel1,
	cCharLevel2,
	cCharLevel3,
	cCharLastLogin1[128],
	cCharLastLogin2[128],
	cCharLastLogin3[128],
	cCharReferrals,
	cCharPinCode,
	cCharTime,
	cCharOn
};
new charData[MAX_PLAYERS][E_CHAR];
