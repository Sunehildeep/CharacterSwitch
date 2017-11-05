#include <a_samp>
#include <audio>

#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

//Change this to the skins you want the characters to have.
#define SKIN1   10
#define SKIN2   50
#define SKIN3   100
#define SKIN4   111

new Float:OldPos[MAX_PLAYERS][4],Float:NewPos[MAX_PLAYERS][3];
new Text:textdraw_0;
new Text:textdraw_1;
new Text:textdraw_2;
new Text:textdraw_3;
new Text:textdraw_8;
new PlayerText:textdraw_4[MAX_PLAYERS];
new PlayerText:textdraw_5[MAX_PLAYERS];
new PlayerText:textdraw_6[MAX_PLAYERS];
new PlayerText:textdraw_7[MAX_PLAYERS];
new handle[MAX_PLAYERS];

public OnFilterScriptInit()
{
    Audio_SetPack("default_pack");

	textdraw_0 = TextDrawCreate(560.000000, 336.000000, "_");
	TextDrawFont(textdraw_0, 1);
	TextDrawLetterSize(textdraw_0, 0.600000, 3.999998);
	TextDrawTextSize(textdraw_0, 281.500000, 31.500000);
	TextDrawSetOutline(textdraw_0, 1);
	TextDrawSetShadow(textdraw_0, 0);
	TextDrawAlignment(textdraw_0, 2);
	TextDrawColor(textdraw_0, -1);
	TextDrawBackgroundColor(textdraw_0, 255);
	TextDrawBoxColor(textdraw_0, 135);
	TextDrawUseBox(textdraw_0, 1);
	TextDrawSetProportional(textdraw_0, 1);
	TextDrawSetSelectable(textdraw_0, 0);

	textdraw_1 = TextDrawCreate(593.000000, 336.000000, "_");
	TextDrawFont(textdraw_1, 1);
	TextDrawLetterSize(textdraw_1, 0.600000, 3.999998);
	TextDrawTextSize(textdraw_1, 281.500000, 31.500000);
	TextDrawSetOutline(textdraw_1, 1);
	TextDrawSetShadow(textdraw_1, 0);
	TextDrawAlignment(textdraw_1, 2);
	TextDrawColor(textdraw_1, -1);
	TextDrawBackgroundColor(textdraw_1, 255);
	TextDrawBoxColor(textdraw_1, 135);
	TextDrawUseBox(textdraw_1, 1);
	TextDrawSetProportional(textdraw_1, 1);
	TextDrawSetSelectable(textdraw_1, 0);

	textdraw_2 = TextDrawCreate(560.000000, 374.000000, "_");
	TextDrawFont(textdraw_2, 1);
	TextDrawLetterSize(textdraw_2, 0.600000, 3.999998);
	TextDrawTextSize(textdraw_2, 281.500000, 31.500000);
	TextDrawSetOutline(textdraw_2, 1);
	TextDrawSetShadow(textdraw_2, 0);
	TextDrawAlignment(textdraw_2, 2);
	TextDrawColor(textdraw_2, -1);
	TextDrawBackgroundColor(textdraw_2, 255);
	TextDrawBoxColor(textdraw_2, 135);
	TextDrawUseBox(textdraw_2, 1);
	TextDrawSetProportional(textdraw_2, 1);
	TextDrawSetSelectable(textdraw_2, 0);

	textdraw_3 = TextDrawCreate(593.000000, 374.000000, "_");
	TextDrawFont(textdraw_3, 1);
	TextDrawLetterSize(textdraw_3, 0.600000, 3.999998);
	TextDrawTextSize(textdraw_3, 281.500000, 31.500000);
	TextDrawSetOutline(textdraw_3, 1);
	TextDrawSetShadow(textdraw_3, 0);
	TextDrawAlignment(textdraw_3, 2);
	TextDrawColor(textdraw_3, -1);
	TextDrawBackgroundColor(textdraw_3, 255);
	TextDrawBoxColor(textdraw_3, 135);
	TextDrawUseBox(textdraw_3, 1);
	TextDrawSetProportional(textdraw_3, 1);
	TextDrawSetSelectable(textdraw_3, 0);

    textdraw_8 = TextDrawCreate(327.000000, 2.000000, "_");
	TextDrawFont(textdraw_8, 1);
	TextDrawLetterSize(textdraw_8, 0.600000, 49.499988);
	TextDrawTextSize(textdraw_8, 358.500000, 650.000000);
	TextDrawSetOutline(textdraw_8, 1);
	TextDrawSetShadow(textdraw_8, 0);
	TextDrawAlignment(textdraw_8, 2);
	TextDrawColor(textdraw_8, -1);
	TextDrawBackgroundColor(textdraw_8, 255);
	TextDrawBoxColor(textdraw_8, -8388543);
	TextDrawUseBox(textdraw_8, 1);
	TextDrawSetProportional(textdraw_8, 1);
	TextDrawSetSelectable(textdraw_8, 0);
	return 1;
}

public OnPlayerConnect(playerid)
{
	handle[playerid] = -1;

	textdraw_4[playerid] = CreatePlayerTextDraw(playerid, 541.000000, 338.000000, "HUD:radar_burgershot");
	PlayerTextDrawFont(playerid, textdraw_4[playerid], 5);
	PlayerTextDrawLetterSize(playerid, textdraw_4[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, textdraw_4[playerid], 35.500000, 30.500000);
	PlayerTextDrawSetOutline(playerid, textdraw_4[playerid], 1);
	PlayerTextDrawSetShadow(playerid, textdraw_4[playerid], 0);
	PlayerTextDrawAlignment(playerid, textdraw_4[playerid], 1);
	PlayerTextDrawColor(playerid, textdraw_4[playerid], -1094795521);
	PlayerTextDrawBackgroundColor(playerid, textdraw_4[playerid], -256);
	PlayerTextDrawBoxColor(playerid, textdraw_4[playerid], -741092558);
	PlayerTextDrawUseBox(playerid, textdraw_4[playerid], 1);
	PlayerTextDrawSetProportional(playerid, textdraw_4[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, textdraw_4[playerid], 1);
	PlayerTextDrawSetPreviewModel(playerid, textdraw_4[playerid], SKIN1);
	PlayerTextDrawSetPreviewRot(playerid, textdraw_4[playerid], -10.000000, 0.000000, -20.000000, 0.780000);
	PlayerTextDrawSetPreviewVehCol(playerid, textdraw_4[playerid], 18, 1);

	textdraw_5[playerid] = CreatePlayerTextDraw(playerid, 574.000000, 332.000000, "HUD:radar_burgershot");
	PlayerTextDrawFont(playerid, textdraw_5[playerid], 5);
	PlayerTextDrawLetterSize(playerid, textdraw_5[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, textdraw_5[playerid], 37.000000, 40.000000);
	PlayerTextDrawSetOutline(playerid, textdraw_5[playerid], 1);
	PlayerTextDrawSetShadow(playerid, textdraw_5[playerid], 0);
	PlayerTextDrawAlignment(playerid, textdraw_5[playerid], 1);
	PlayerTextDrawColor(playerid, textdraw_5[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, textdraw_5[playerid], 0);
	PlayerTextDrawBoxColor(playerid, textdraw_5[playerid], 50);
	PlayerTextDrawUseBox(playerid, textdraw_5[playerid], 1);
	PlayerTextDrawSetProportional(playerid, textdraw_5[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, textdraw_5[playerid], 1);
	PlayerTextDrawSetPreviewModel(playerid, textdraw_5[playerid], SKIN2);
	PlayerTextDrawSetPreviewRot(playerid, textdraw_5[playerid], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, textdraw_5[playerid], 1, 1);

	textdraw_6[playerid] = CreatePlayerTextDraw(playerid, 543.000000, 377.000000, "HUD:radar_burgershot");
	PlayerTextDrawFont(playerid, textdraw_6[playerid], 5);
	PlayerTextDrawLetterSize(playerid, textdraw_6[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, textdraw_6[playerid], 35.500000, 30.500000);
	PlayerTextDrawSetOutline(playerid, textdraw_6[playerid], 1);
	PlayerTextDrawSetShadow(playerid, textdraw_6[playerid], 0);
	PlayerTextDrawAlignment(playerid, textdraw_6[playerid], 1);
	PlayerTextDrawColor(playerid, textdraw_6[playerid], -1094795521);
	PlayerTextDrawBackgroundColor(playerid, textdraw_6[playerid], -256);
	PlayerTextDrawBoxColor(playerid, textdraw_6[playerid], -741092558);
	PlayerTextDrawUseBox(playerid, textdraw_6[playerid], 1);
	PlayerTextDrawSetProportional(playerid, textdraw_6[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, textdraw_6[playerid], 1);
	PlayerTextDrawSetPreviewModel(playerid, textdraw_6[playerid], SKIN3);
	PlayerTextDrawSetPreviewRot(playerid, textdraw_6[playerid], -10.000000, 0.000000, -20.000000, 0.780000);
	PlayerTextDrawSetPreviewVehCol(playerid, textdraw_6[playerid], 18, 1);

	textdraw_7[playerid] = CreatePlayerTextDraw(playerid, 577.000000, 371.000000, "HUD:radar_burgershot");
	PlayerTextDrawFont(playerid, textdraw_7[playerid], 5);
	PlayerTextDrawLetterSize(playerid, textdraw_7[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, textdraw_7[playerid], 37.000000, 40.000000);
	PlayerTextDrawSetOutline(playerid, textdraw_7[playerid], 1);
	PlayerTextDrawSetShadow(playerid, textdraw_7[playerid], 0);
	PlayerTextDrawAlignment(playerid, textdraw_7[playerid], 1);
	PlayerTextDrawColor(playerid, textdraw_7[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, textdraw_7[playerid], 0);
	PlayerTextDrawBoxColor(playerid, textdraw_7[playerid], 50);
	PlayerTextDrawUseBox(playerid, textdraw_7[playerid], 1);
	PlayerTextDrawSetProportional(playerid, textdraw_7[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, textdraw_7[playerid], 1);
	PlayerTextDrawSetPreviewModel(playerid, textdraw_7[playerid], SKIN4);
	PlayerTextDrawSetPreviewRot(playerid, textdraw_7[playerid], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, textdraw_7[playerid], 1, 1);

	return 1;
}

public OnPlayerDisconnect(playerid)
{
	PlayerTextDrawDestroy(playerid, textdraw_4[playerid]);
	PlayerTextDrawDestroy(playerid, textdraw_5[playerid]);
	PlayerTextDrawDestroy(playerid, textdraw_6[playerid]);
	PlayerTextDrawDestroy(playerid, textdraw_7[playerid]);
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(PRESSED(KEY_WALK))
    {
        switch(GetPVarInt(playerid,"CharactersActivated"))
        {
            case 0:
            {
		        handle[playerid] = Audio_Play(playerid,2);
		        ShowTDS(playerid);
				SetPVarInt(playerid, "CharactersActivated", 1);
			}
			case 1:
			{
		        Audio_Stop(playerid, handle[playerid]);
		        HideTDS(playerid);
				DeletePVar(playerid,"CharactersActivated");
			}
        }
    }
    return 1;
}

public Audio_OnClientConnect(playerid)
{
   Audio_TransferPack(playerid);
   return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	if(playertextid == textdraw_4[playerid]) // Skin 1
	{
	    SwitchCharacter(playerid, 1, -2596.6675,1358.2278,6.6957, 71.2003);
	    SetPlayerPos(playerid, -2596.6675,1358.2278,6.6957); // Change the position
		SetPlayerFacingAngle(playerid, 71.2003);
		SetPlayerSkin(playerid, SKIN1);
	}
	else if(playertextid == textdraw_5[playerid]) // Skin 2
	{
 		SwitchCharacter(playerid, 1, 718.4906, -1477.3024, 5.4688, 357.9947);
 		SetPlayerPos(playerid, 718.4906, -1477.3024, 5.4688); // Change the position
		SetPlayerFacingAngle(playerid, 357.9947);
		SetPlayerSkin(playerid, SKIN2);
	}
	else if(playertextid == textdraw_6[playerid]) // Skin 3
	{
 		SwitchCharacter(playerid, 1, 1241.2084, -2057.6521, 60.0190, 94.9352);
 		SetPlayerPos(playerid, 1241.2084, -2057.6521, 60.0190); // Change the position
		SetPlayerFacingAngle(playerid, 94.9352);
		SetPlayerSkin(playerid, SKIN3);
	}
	else if(playertextid == textdraw_7[playerid]) // Skin 4
	{
		SwitchCharacter(playerid, 1, 1249.7258, -2047.9263, 59.9209, 90.2055);
		SetPlayerPos(playerid, 1249.7258, -2047.9263, 59.9209); // Change the position
		SetPlayerFacingAngle(playerid, 90.2055);
		SetPlayerSkin(playerid, SKIN4);
	}
	return 1;
}

forward SwitchCharacter(playerid, level, Float:cX, Float:cY, Float:cZ, Float:cA);
public SwitchCharacter(playerid, level, Float:cX, Float:cY, Float:cZ, Float:cA)
{
    switch(level)
    {
        case 1:
        {
            if(GetPVarInt(playerid,"Teleportation") > gettime()) return SendClientMessage(playerid, -1, "The character switch isn't available at the moment.");
            SetPVarInt(playerid,"Teleportation",gettime() + 13);
            Audio_Stop(playerid, handle[playerid]);
            handle[playerid] = Audio_Play(playerid,1);
            OldPos[playerid][0] = cX,OldPos[playerid][1] = cY,OldPos[playerid][2] = cZ,OldPos[playerid][3] = cA;
            GetPlayerPos(playerid, NewPos[playerid][0],NewPos[playerid][1],NewPos[playerid][2]);
            TogglePlayerControllable(playerid,0);
            SetPlayerCameraPos(playerid, NewPos[playerid][0],NewPos[playerid][1],NewPos[playerid][2]+20);
            SetPlayerCameraLookAt(playerid, NewPos[playerid][0],NewPos[playerid][1],NewPos[playerid][2]);
            SetTimerEx("SwitchCharacter",1000,false,"ii",playerid,2);
            HideTDS(playerid);
        }
        case 2:
        {
            Audio_Stop(playerid, handle[playerid]); handle[playerid] = Audio_Play(playerid,1);
            SetPlayerCameraPos(playerid, NewPos[playerid][0],NewPos[playerid][1],NewPos[playerid][2]+50);
            SetPlayerCameraLookAt(playerid, NewPos[playerid][0],NewPos[playerid][1],NewPos[playerid][2]);
            SetTimerEx("SwitchCharacter",1000,false,"ii",playerid,3);
        }
        case 3:
        {
            Audio_Stop(playerid, handle[playerid]); handle[playerid] = Audio_Play(playerid,1);
            SetPlayerCameraPos(playerid, NewPos[playerid][0],NewPos[playerid][1],NewPos[playerid][2]+100);
            SetPlayerCameraLookAt(playerid, NewPos[playerid][0],NewPos[playerid][1],NewPos[playerid][2]);
            SetTimerEx("SwitchCharacter",1000,false,"ii",playerid,4);
        }
        case 4:
        {
            Audio_Stop(playerid, handle[playerid]); handle[playerid] = Audio_Play(playerid,1);
            SetPlayerCameraPos(playerid, NewPos[playerid][0],NewPos[playerid][1],NewPos[playerid][2]+200);
            SetPlayerCameraLookAt(playerid, NewPos[playerid][0],NewPos[playerid][1],NewPos[playerid][2]);
            SetTimerEx("SwitchCharacter",1000,false,"ii",playerid,5);
        }
        case 5:
        {
            if(IsPlayerInAnyVehicle(playerid))
            {
                SetVehiclePos(GetPlayerVehicleID(playerid),OldPos[playerid][0],OldPos[playerid][1],OldPos[playerid][2]);
                SetVehicleZAngle(GetPlayerVehicleID(playerid),OldPos[playerid][3]);
            }
            else
            {
                SetPlayerPos(playerid,OldPos[playerid][0],OldPos[playerid][1],OldPos[playerid][2]);
                SetPlayerFacingAngle(playerid,OldPos[playerid][3]);
            }
            InterpolateCameraPos(playerid, NewPos[playerid][0],NewPos[playerid][1],NewPos[playerid][2]+200, OldPos[playerid][0],OldPos[playerid][1],OldPos[playerid][2]+200, 3000);
            InterpolateCameraLookAt(playerid, NewPos[playerid][0],NewPos[playerid][1],NewPos[playerid][2], OldPos[playerid][0],OldPos[playerid][1],OldPos[playerid][2], 3000);
            SetTimerEx("SwitchCharacter",4000,false,"ii",playerid,6);
        }
        case 6:
        {
            Audio_Stop(playerid, handle[playerid]); handle[playerid] = Audio_Play(playerid,1);
            SetPlayerCameraPos(playerid, OldPos[playerid][0],OldPos[playerid][1],OldPos[playerid][2]+100);
            SetPlayerCameraLookAt(playerid, OldPos[playerid][0],OldPos[playerid][1],OldPos[playerid][2]);
            SetTimerEx("SwitchCharacter",1000,false,"ii",playerid,7);
        }
        case 7:
        {
            Audio_Stop(playerid, handle[playerid]); handle[playerid] = Audio_Play(playerid,1);
            SetPlayerCameraPos(playerid, OldPos[playerid][0],OldPos[playerid][1],OldPos[playerid][2]+50);
            SetPlayerCameraLookAt(playerid, OldPos[playerid][0],OldPos[playerid][1],OldPos[playerid][2]);
            SetTimerEx("SwitchCharacter",1000,false,"ii",playerid,8);
        }
        case 8:
        {
            TogglePlayerControllable(playerid, true);
            SetCameraBehindPlayer(playerid);
        }
    }
    return true;
}

ShowTDS(playerid)
{
    			TextDrawShowForPlayer(playerid, textdraw_8);
		        TextDrawShowForPlayer(playerid, textdraw_0);
				TextDrawShowForPlayer(playerid, textdraw_1);
				TextDrawShowForPlayer(playerid, textdraw_2);
				TextDrawShowForPlayer(playerid, textdraw_3);
				PlayerTextDrawShow(playerid, textdraw_4[playerid]);
				PlayerTextDrawShow(playerid, textdraw_5[playerid]);
				PlayerTextDrawShow(playerid, textdraw_6[playerid]);
				PlayerTextDrawShow(playerid, textdraw_7[playerid]);
				SelectTextDraw(playerid, 0xFF0000FF);
				return 1;
}

HideTDS(playerid)
{
    		CancelSelectTextDraw(playerid);
			TextDrawHideForPlayer(playerid, textdraw_8);
			TextDrawHideForPlayer(playerid, textdraw_0);
			TextDrawHideForPlayer(playerid, textdraw_1);
			TextDrawHideForPlayer(playerid, textdraw_2);
			TextDrawHideForPlayer(playerid, textdraw_3);
			PlayerTextDrawHide(playerid, textdraw_4[playerid]);
			PlayerTextDrawHide(playerid, textdraw_5[playerid]);
			PlayerTextDrawHide(playerid, textdraw_6[playerid]);
			PlayerTextDrawHide(playerid, textdraw_7[playerid]);
			return 1;
}
