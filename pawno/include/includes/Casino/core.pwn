#include <YSI\y_iterate>

#define MAX_CASINO 100
#define INVALID_CASINO_ID -1

enum E_CASINO_DATA
{
    cID,
    cName[128],
    cOwner,
    cOwnerName[128],
    cPrice,
    cVault,
    
    Float:cPosExtX,
    Float:cPosExtY,
    Float:cPosExtZ,
    Float:cPosExtA,

    Float:cPosIntX,
    Float:cPosIntY,
    Float:cPosIntZ,
    Float:cPosIntA,

    cPosInterior,
    cPosWorld,

    cPickup,
    cCheckpoint,
    Text3D:cText,
    cInt
}
new 
    CasinoData[MAX_CASINO][E_CASINO_DATA],
    Iterator: Casino<MAX_CASINO>;


new 
    Player_DiceOffer[MAX_PLAYERS],
    Player_DiceOfferPrice[MAX_PLAYERS]
;