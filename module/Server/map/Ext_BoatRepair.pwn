RemoveBoatRepair(playerid)
{
    RemoveBuildingForPlayer(playerid, 3623, 2618.860, -2429.300, 17.070, 0.250);
    RemoveBuildingForPlayer(playerid, 3709, 2618.860, -2429.300, 17.070, 0.250);
    RemoveBuildingForPlayer(playerid, 1307, 2649.899, -2419.689, 12.289, 0.250);
    RemoveBuildingForPlayer(playerid, 3623, 2660.479, -2429.300, 17.070, 0.250);
    RemoveBuildingForPlayer(playerid, 3709, 2660.479, -2429.300, 17.070, 0.250);
    RemoveBuildingForPlayer(playerid, 3623, 2639.550, -2429.300, 17.070, 0.250);
    RemoveBuildingForPlayer(playerid, 3709, 2639.550, -2429.300, 17.070, 0.250);
    RemoveBuildingForPlayer(playerid, 1307, 2629.209, -2419.689, 12.289, 0.250);
    RemoveBuildingForPlayer(playerid, 1226, 2624.330, -2452.149, 16.414, 0.250);
}

CreateBoatRepair()
{
    tmpobjid = CreateDynamicObject(19457, 2596.128906, -2439.865966, 14.323619, 0.000000, 0.000000, -47.100009, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 8401, "vgshpground", "vegaspawnwall02_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19457, 2611.627197, -2423.987304, 14.323619, 0.000000, 0.000000, -47.100009, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 8401, "vgshpground", "vegaspawnwall02_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19457, 2617.691650, -2418.351562, 14.323619, 0.000000, 0.000000, -47.100009, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 8401, "vgshpground", "vegaspawnwall02_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19457, 2625.991699, -2415.200927, 14.323619, 0.000000, 0.000000, -90.900001, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 8401, "vgshpground", "vegaspawnwall02_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19457, 2639.596435, -2420.147216, 14.323619, 0.000000, 0.000000, 179.100006, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 8401, "vgshpground", "vegaspawnwall02_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19457, 2639.447021, -2429.721923, 14.323619, 0.000000, 0.000000, 179.100006, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 8401, "vgshpground", "vegaspawnwall02_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19457, 2639.296142, -2439.371337, 14.323619, 0.000000, 0.000000, 179.100006, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 8401, "vgshpground", "vegaspawnwall02_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19457, 2639.174072, -2449.009521, 14.323619, 0.000000, 0.000000, 179.100006, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 8401, "vgshpground", "vegaspawnwall02_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19457, 2590.554199, -2447.461914, 14.323619, 0.000000, 0.000000, -25.700008, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 8401, "vgshpground", "vegaspawnwall02_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19457, 2587.041992, -2454.761474, 14.323619, 0.000000, 0.000000, -25.700008, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 8401, "vgshpground", "vegaspawnwall02_128", 0x00000000);
    tmpobjid = CreateDynamicObject(7709, 2598.371093, -2437.714843, 14.400629, 0.000000, 0.000000, -47.200016, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterialText(tmpobjid, 0, "Los Santos\nBoat Repair\nCenter", 130, "Arial", 80, 1, 0xFFFFFFFF, 0x00000000, 1);
    tmpobjid = CreateDynamicObject(7709, 2609.477294, -2425.916748, 14.400629, 0.000000, 0.000000, -47.200016, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterialText(tmpobjid, 0, "Los Santos\nBoat Repair\nCenter", 130, "Arial", 80, 1, 0xFFFFFFFF, 0x00000000, 1);
    tmpobjid = CreateDynamicObject(19433, 2622.552001, -2457.409667, 11.839093, 90.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2622.552001, -2455.591064, 11.839093, 90.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2619.109130, -2457.409667, 11.839093, 89.999992, 89.999992, -89.999992, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2619.109130, -2455.591064, 11.839093, 89.999992, 89.999992, -89.999992, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2615.227050, -2457.409667, 11.839093, 89.999992, 89.999992, -89.999977, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2615.227050, -2455.591064, 11.839093, 89.999992, 89.999992, -89.999977, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2611.285156, -2457.409667, 11.839093, 89.999992, 90.000000, -89.999969, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2611.285156, -2455.591064, 11.839093, 89.999992, 90.000000, -89.999969, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2607.354248, -2457.409667, 11.839093, 89.999992, 90.000015, -89.999961, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2607.354248, -2455.591064, 11.839093, 89.999992, 90.000015, -89.999961, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2603.095214, -2457.409667, 11.839093, 89.999992, 90.000030, -89.999961, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2603.095214, -2455.591064, 11.839093, 89.999992, 90.000030, -89.999961, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2598.933593, -2457.409667, 11.839093, 89.999992, 90.000045, -89.999961, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2598.933593, -2455.591064, 11.839093, 89.999992, 90.000045, -89.999961, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2594.844482, -2457.409667, 11.839093, 89.999992, 90.000061, -89.999961, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2594.844482, -2455.591064, 11.839093, 89.999992, 90.000061, -89.999961, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2590.503906, -2457.409667, 11.839093, 89.999992, 90.000076, -89.999961, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2590.503906, -2455.591064, 11.839093, 89.999992, 90.000076, -89.999961, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2620.911865, -2459.118652, 11.849094, 89.999992, 89.999992, 0.000022, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2617.441894, -2459.118652, 11.849094, 89.999992, 89.999992, 0.000022, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2613.963134, -2459.118652, 11.849094, 89.999992, 89.999992, 0.000022, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2610.462646, -2459.118652, 11.849094, 89.999992, 89.999992, 0.000022, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2606.952392, -2459.118652, 11.849094, 89.999992, 89.999992, 0.000022, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2603.491699, -2459.118652, 11.849094, 89.999992, 89.999992, 0.000022, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2599.992187, -2459.118652, 11.849094, 89.999992, 89.999992, 0.000022, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2596.521484, -2459.118652, 11.849094, 89.999992, 89.999992, 0.000022, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2593.011718, -2459.118652, 11.849094, 89.999992, 89.999992, 0.000022, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2589.691406, -2459.118652, 11.849094, 89.999992, 89.999992, 0.000022, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2591.259765, -2458.367919, 11.099098, 180.000000, 270.000000, 0.000022, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2594.718994, -2458.367919, 11.099098, 180.000000, 270.000000, 0.000022, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2598.109130, -2458.367919, 11.099098, 180.000000, 270.000000, 0.000022, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2601.438720, -2458.367919, 11.099098, 180.000000, 270.000000, 0.000022, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2604.828857, -2458.367919, 11.099098, 180.000000, 270.000000, 0.000022, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2608.258544, -2458.367919, 11.099098, 180.000000, 270.000000, 0.000022, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2611.748046, -2458.367919, 11.099098, 180.000000, 270.000000, 0.000022, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19433, 2614.587158, -2458.367919, 11.099098, 180.000000, 270.000000, 0.000022, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "orange", 0x00000000);
    tmpobjid = CreateDynamicObject(19387, 2638.291748, -2464.385742, 3.679999, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 6205, "lawartg", "luxorwall01_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19369, 2635.081298, -2464.376220, 3.670000, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 6205, "lawartg", "luxorwall01_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19369, 2631.881347, -2464.376220, 3.670000, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 6205, "lawartg", "luxorwall01_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19369, 2639.821777, -2462.707275, 3.670000, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 6205, "lawartg", "luxorwall01_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19369, 2639.821777, -2459.538330, 3.670000, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 6205, "lawartg", "luxorwall01_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19369, 2639.821777, -2456.358886, 3.670000, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 6205, "lawartg", "luxorwall01_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19369, 2638.122070, -2462.818847, 5.330001, 0.000000, 90.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 6205, "lawartg", "luxorwall01_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19369, 2634.620361, -2462.848876, 5.330001, 0.000000, 90.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 6205, "lawartg", "luxorwall01_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19369, 2631.149658, -2462.848876, 5.330001, 0.000000, 90.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 6205, "lawartg", "luxorwall01_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19369, 2631.149658, -2459.661132, 5.330001, 0.000000, 90.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 6205, "lawartg", "luxorwall01_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19369, 2634.609130, -2459.661132, 5.330001, 0.000000, 90.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 6205, "lawartg", "luxorwall01_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19369, 2638.000000, -2459.661132, 5.330001, 0.000000, 90.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 6205, "lawartg", "luxorwall01_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19369, 2638.000000, -2456.468994, 5.330001, 0.000000, 90.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 6205, "lawartg", "luxorwall01_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19369, 2634.548095, -2456.468994, 5.330001, 0.000000, 90.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 6205, "lawartg", "luxorwall01_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19369, 2631.087158, -2456.468994, 5.330001, 0.000000, 90.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 6205, "lawartg", "luxorwall01_128", 0x00000000);
    tmpobjid = CreateDynamicObject(7914, 2622.187255, -2465.695068, 7.760001, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterialText(tmpobjid, 0, "Los Santos\nBoat Repair\nCenter", 130, "Arial", 90, 1, 0xFFFFFFFF, 0x00000000, 2);
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    tmpobjid = CreateDynamicObject(984, 2636.323242, -2459.169921, 13.276472, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(10282, 2635.127685, -2451.212890, 13.532802, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(11313, 2631.118652, -2452.355468, 13.732812, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(984, 2616.203369, -2459.169921, 13.276472, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(984, 2603.372802, -2459.169921, 13.276472, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(984, 2590.585205, -2459.169921, 13.276472, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1412, 2622.608886, -2456.536865, 12.749551, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(12929, 2634.997558, -2448.438476, 12.612813, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(5837, 2607.523437, -2435.161865, 14.183603, 0.000000, 0.000000, -41.799995, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1238, 2602.898681, -2432.468505, 13.050619, 0.000000, 0.000000, 45.099979, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1238, 2602.204833, -2431.152587, 13.050619, 0.000000, 0.000000, 45.099979, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1238, 2601.750732, -2429.952392, 13.050619, 0.000000, 0.000000, 45.099979, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1238, 2601.332031, -2428.857421, 13.050619, 0.000000, 0.000000, 45.099979, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1238, 2602.513671, -2429.201904, 13.050619, 0.000000, 0.000000, 45.099979, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1238, 2603.632080, -2429.836425, 13.050619, 0.000000, 0.000000, 45.099979, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1238, 2605.005126, -2430.584960, 13.050619, 0.000000, 0.000000, 45.099979, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1257, 2617.093750, -2420.509277, 13.875000, 0.000000, 0.000000, 135.899978, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1372, 2613.035400, -2423.534912, 12.750491, 0.000000, 0.000000, 41.599990, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1372, 2611.660156, -2424.757568, 12.750491, 0.000000, 0.000000, 41.599990, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(984, 2577.785400, -2459.169921, 13.276472, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(984, 2568.982177, -2459.169921, 13.276472, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(984, 2562.560302, -2465.701660, 13.276472, 0.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(984, 2562.560302, -2478.519531, 13.276472, 0.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(984, 2562.560302, -2487.630859, 13.276472, 0.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19802, 2637.501953, -2464.439453, 1.910000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1428, 2633.821533, -2464.868652, 3.450000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19900, 2637.030761, -2464.851074, 1.970000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19899, 2614.134277, -2466.566894, 1.990000, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19899, 2616.704833, -2466.566894, 1.990000, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19900, 2618.301513, -2466.508789, 1.990000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19900, 2612.541992, -2466.508789, 1.990000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19815, 2609.716552, -2466.109375, 3.620000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(984, 2641.925781, -2467.344970, 2.799999, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(984, 2632.106201, -2473.696044, 2.799999, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(984, 2614.685058, -2473.696044, 2.799999, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(984, 2598.444580, -2473.696044, 2.799999, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(984, 2588.265136, -2467.344970, 2.799999, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(11495, 2640.216796, -2486.616699, 0.646317, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1472, 2640.256347, -2473.786376, 1.776317, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1472, 2640.256347, -2474.937500, 1.206317, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(11495, 2623.416015, -2486.616699, 0.646317, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1472, 2623.455566, -2473.786376, 1.776317, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1472, 2623.455566, -2474.937500, 1.206317, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(11495, 2606.620849, -2486.616699, 0.646317, 0.000000, 0.000015, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1472, 2606.660400, -2473.786376, 1.776317, 0.000000, 0.000015, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1472, 2606.660400, -2474.937500, 1.206317, 0.000000, 0.000015, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(11495, 2590.175537, -2486.616699, 0.646317, 0.000000, 0.000022, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1472, 2590.215087, -2473.786376, 1.776317, 0.000000, 0.000022, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1472, 2590.215087, -2474.937500, 1.206317, 0.000000, 0.000022, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1290, 2614.958984, -2473.417236, 7.566319, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1290, 2637.798339, -2473.417236, 7.566319, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1290, 2591.207519, -2473.417236, 7.566319, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(3465, 2590.170654, -2497.372558, 1.999442, 0.000000, 0.000000, 89.699996, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(3465, 2606.701660, -2497.459472, 1.999442, 0.000000, 0.000000, 89.699996, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(3465, 2623.612060, -2497.547851, 1.999442, 0.000000, 0.000000, 89.699996, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(3465, 2640.362792, -2497.636230, 1.999442, 0.000000, 0.000000, 89.699996, -1, -1, -1, 300.00, 300.00); 

}