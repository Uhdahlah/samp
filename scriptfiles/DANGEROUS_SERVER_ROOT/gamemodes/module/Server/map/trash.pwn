
RemoveTrash(playerid)
{
    RemoveBuildingForPlayer(playerid, 3574, 2092.689, -2043.400, 15.070, 0.250);
}

CreateTrash()
{
 	tmpobjid = CreateDynamicObject(11737, 2075.286621, -2049.403076, 14.830096, 89.799942, 0.000000, 89.199966, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterialText(tmpobjid, 0, "ANTRI", 50, "Ariel", 35, 1, 0xFFFF0000, 0xFFFFFFFF, 1);
	tmpobjid = CreateDynamicObject(18244, 2075.031005, -2046.390747, 17.836658, 93.000045, -3.899999, 92.999969, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterialText(tmpobjid, 0, "SIDEJOB\nTRASHMASTER", 50, "Ariel", 20, 1, 0xFFFF0000, 0xFFFFFFFF, 1);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	tmpobjid = CreateDynamicObject(2773, 2076.561767, -2050.132568, 13.046877, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	tmpobjid = CreateDynamicObject(2773, 2076.561767, -2052.323730, 13.046877, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
}
