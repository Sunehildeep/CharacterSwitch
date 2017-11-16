/**
 * Copyright (c) 2017 Sunehildeep Charachter Switcher (CharachterSwitch)
 *
 * This program is free software: you can redistribute it and/or modify it under the terms of the
 * GNU General Public License as published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without
 * even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with this program.
 * If not, see <http://www.gnu.org/licenses/>.
*/

 /* 
    ScriptName    : CharachterSwitch
    Author        : Sunehildeep
    Version       : 2.0
    Edited        : 12/10/2017
    License       : GNU General v3.0
    Developers    : Xeon™
*/

// Script (Includes)
#include <a_samp>
#include <audio>
#include <fader>

// Script (Configurations)
// Skins Ids (Skin1, Skin2, Skin3, Skin4)
static u_Skin[4] = {10, 50, 100, 111};
const

	// Max Slots
	s_MaxSlots = 100,
	
	//Teleportation Delay limit
	Teleportation_Delay = 15 //in seconds
;

#undef MAX_PLAYERS
#define MAX_PLAYERS s_MaxSlots

// Script (Variables)
new 
	Level[MAX_PLAYERS] = 0,
	Float:PlayerPosition[MAX_PLAYERS][3],
	Text:g_TextDraw[6],
	PlayerText:p_TextDraw[MAX_PLAYERS][4],
	Audio_Handle[MAX_PLAYERS]
	
;

// Script (Constants)
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

#define Audio_PlayEx(%0,%1) Audio_Stop(%0,%1), Audio_Handle[%0] = Audio_Play(playerid,%1)
#define FlashPlayerScreen(%0) TextDrawFadeBoxForPlayer(playerid, g_TextDraw[5], 0x33AA33AA, 0x33AA33AA, 10)
 
// Script (Callbacks)
public OnFilterScriptInit()
{
    Audio_SetPack("default_pack");

	g_TextDraw[0] = TextDrawCreate(560.000000, 336.000000, "_");
	g_TextDraw[1] = TextDrawCreate(593.000000, 336.000000, "_");
	g_TextDraw[2] = TextDrawCreate(560.000000, 374.000000, "_");
	g_TextDraw[3] = TextDrawCreate(593.000000, 374.000000, "_");
	for(new i = 0; i < 4; i++)
	{
		TextDrawFont(g_TextDraw[i], 1);
		TextDrawLetterSize(g_TextDraw[i], 0.600000, 3.999998);
		TextDrawTextSize(g_TextDraw[i], 281.500000, 31.500000);
		TextDrawSetOutline(g_TextDraw[i], 1);
		TextDrawSetShadow(g_TextDraw[i], 0);
		TextDrawAlignment(g_TextDraw[i], 2);
		TextDrawColor(g_TextDraw[i], -1);
		TextDrawBackgroundColor(g_TextDraw[i], 255);
		TextDrawBoxColor(g_TextDraw[i], 135);
		TextDrawUseBox(g_TextDraw[i], 1);
		TextDrawSetProportional(g_TextDraw[i], 1);
		TextDrawSetSelectable(g_TextDraw[i], 0);
		TextDrawFont(g_TextDraw[i], 1);
	}
	
    g_TextDraw[4] = TextDrawCreate(327.000000, 2.000000, "_");
	TextDrawFont(g_TextDraw[4], 1);
	TextDrawLetterSize(g_TextDraw[4], 0.600000, 49.499988);
	TextDrawTextSize(g_TextDraw[4], 358.500000, 650.000000);
	TextDrawSetOutline(g_TextDraw[4], 1);
	TextDrawSetShadow(g_TextDraw[4], 0);
	TextDrawAlignment(g_TextDraw[4], 2);
	TextDrawColor(g_TextDraw[4], -1);
	TextDrawBackgroundColor(g_TextDraw[4], 255);
	TextDrawBoxColor(g_TextDraw[4], 0x33AA33AA);
	TextDrawUseBox(g_TextDraw[4], 1);
	TextDrawSetProportional(g_TextDraw[4], 1);
	TextDrawSetSelectable(g_TextDraw[4], 0);
	
	g_TextDraw[5] = TextDrawCreate(0.0, 0.0, "_"); 
    TextDrawTextSize(g_TextDraw[5], 640.0, 480.0); 
    TextDrawLetterSize(g_TextDraw[5], 0.0, 50.0); 
    TextDrawUseBox(g_TextDraw[5], 1); 
	return 1;
}

public OnPlayerConnect(playerid)
{
	Audio_Handle[playerid] = -1;
	
	p_TextDraw[playerid][0] = CreatePlayerTextDraw(playerid, 541.000000, 338.000000, "HUD:radar_burgershot");
	p_TextDraw[playerid][1] = CreatePlayerTextDraw(playerid, 543.000000, 377.000000, "HUD:radar_burgershot");
	for(new i = 0; i < 2; i++)
	{
		PlayerTextDrawFont(playerid, p_TextDraw[playerid][i], 5);
		PlayerTextDrawLetterSize(playerid, p_TextDraw[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, p_TextDraw[playerid][i], 35.500000, 30.500000);
		PlayerTextDrawSetOutline(playerid, p_TextDraw[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, p_TextDraw[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, p_TextDraw[playerid][i], 1);
		PlayerTextDrawColor(playerid, p_TextDraw[playerid][i], -1094795521);
		PlayerTextDrawBackgroundColor(playerid, p_TextDraw[playerid][i], -256);
		PlayerTextDrawBoxColor(playerid, p_TextDraw[playerid][i], -741092558);
		PlayerTextDrawUseBox(playerid, p_TextDraw[playerid][i], i);
		PlayerTextDrawSetProportional(playerid, p_TextDraw[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, p_TextDraw[playerid][i], 1);
		PlayerTextDrawSetPreviewModel(playerid, p_TextDraw[playerid][i], u_Skin[i]);
		PlayerTextDrawSetPreviewRot(playerid, p_TextDraw[playerid][i], -10.000000, 0.000000, -20.000000, 0.780000);
		PlayerTextDrawSetPreviewVehCol(playerid, p_TextDraw[playerid][i], 18, 1);
	}
	
	p_TextDraw[playerid][2] = CreatePlayerTextDraw(playerid, 577.000000, 371.000000, "HUD:radar_burgershot");
	p_TextDraw[playerid][3] = CreatePlayerTextDraw(playerid, 574.000000, 332.000000, "HUD:radar_burgershot");
	for(new i = 2; i < 4; i++)
	{
		PlayerTextDrawFont(playerid, p_TextDraw[playerid][i], 5);
		PlayerTextDrawLetterSize(playerid, p_TextDraw[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, p_TextDraw[playerid][i], 37.000000, 40.000000);
		PlayerTextDrawSetOutline(playerid, p_TextDraw[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, p_TextDraw[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, p_TextDraw[playerid][i], 1);
		PlayerTextDrawColor(playerid, p_TextDraw[playerid][i], -1);
		PlayerTextDrawBackgroundColor(playerid, p_TextDraw[playerid][i], 0);
		PlayerTextDrawBoxColor(playerid, p_TextDraw[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, p_TextDraw[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, p_TextDraw[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, p_TextDraw[playerid][i], 1);
		PlayerTextDrawSetPreviewModel(playerid, p_TextDraw[playerid][i], u_Skin[i]);
		PlayerTextDrawSetPreviewRot(playerid, p_TextDraw[playerid][i], -10.000000, 0.000000, -20.000000, 1.000000);
		PlayerTextDrawSetPreviewVehCol(playerid, p_TextDraw[playerid][i], 1, 1);
	}

	return 1;
}

public OnPlayerDisconnect(playerid)
{
	for(new i = 0; i < 4; i++) PlayerTextDrawDestroy(playerid, p_TextDraw[playerid][i]);
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
		        Audio_Handle[playerid] = Audio_Play(playerid,2);
		        ShowTDS(playerid);
				SetPVarInt(playerid, "CharactersActivated", 1);
			}
			case 1:
			{
		        Audio_Stop(playerid, Audio_Handle[playerid]);
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
	new id = -1;
	for(new i = 0; i < 4; i++)
	{
	    if(playertextid == p_TextDraw[playerid][i])
	    {
			id = i;
   			break;
	    }
	}
	if(id == -1) return printf("Something went wrrong while prasing the playertextdraw id: OnPlayerClickPlayerTextDraw(%d, %d)", playerid, _:playertextid);
	SetPlayerSkin(playerid, u_Skin[id]);
	SwitchCharacter(playerid, 1, id);
	return 1;
}

forward SwitchCharacter(playerid, level, id);
public SwitchCharacter(playerid, level, id)
{
	FlashPlayerScreen(playerid);
    switch(level)
    {
        case 1:
        {
            if(GetPVarInt(playerid,"Teleportation") > gettime()) return SendClientMessage(playerid, -1, "The character switch isn't available at the moment.");
            SetPVarInt(playerid,"Teleportation", gettime() + Teleportation_Delay);
			Level[playerid] = 50;
			
            Audio_PlayEx(playerid, 1);
			
            TogglePlayerControllable(playerid, 0);
			GetPlayerPos(playerid, PlayerPosition[playerid][0], PlayerPosition[playerid][1], PlayerPosition[playerid][2]);
            InterpolateCameraPos(playerid, PlayerPosition[playerid][0], PlayerPosition[playerid][1], PlayerPosition[playerid][2], PlayerPosition[playerid][0], PlayerPosition[playerid][1], PlayerPosition[playerid][2]+50, 600, CAMERA_MOVE);
			InterpolateCameraLookAt(playerid, PlayerPosition[playerid][0], PlayerPosition[playerid][1], PlayerPosition[playerid][2], PlayerPosition[playerid][0], PlayerPosition[playerid][1], PlayerPosition[playerid][2], 100, CAMERA_MOVE);
            switch(id)
			{
				case 0:
				{
					SetPlayerPos(playerid, -2596.6675,1358.2278,6.6957);
					SetPlayerFacingAngle(playerid, 71.2003);
				}
				case 1:
				{
					SetPlayerPos(playerid, 718.4906, -1477.3024, 5.4688);
					SetPlayerFacingAngle(playerid, 357.9947);
				}
				case 2:
				{
					SetPlayerPos(playerid, 1241.2084, -2057.6521, 60.0190);
					SetPlayerFacingAngle(playerid, 94.9352);
				}
				case 3:
				{
					SetPlayerPos(playerid, 1249.7258, -2047.9263, 59.9209);
					SetPlayerFacingAngle(playerid, 90.2055);
				}
			}
			SetTimerEx("SwitchCharacter", 1000, false, "ii", playerid, 2);
            HideTDS(playerid);
        }
        case 2..4:
        {
            Audio_PlayEx(playerid, 1);
            InterpolateCameraPos(playerid, PlayerPosition[playerid][0], PlayerPosition[playerid][1], PlayerPosition[playerid][2]+Level[playerid], PlayerPosition[playerid][0], PlayerPosition[playerid][1], PlayerPosition[playerid][2]+(Level[playerid]+50), 600, CAMERA_MOVE);
            InterpolateCameraLookAt(playerid, PlayerPosition[playerid][0], PlayerPosition[playerid][1], PlayerPosition[playerid][2], PlayerPosition[playerid][0], PlayerPosition[playerid][1], PlayerPosition[playerid][2], 600, CAMERA_MOVE);
		    Level[playerid] += 50;
			SetTimerEx("SwitchCharacter", 1000, false, "ii", playerid, level+1);
        }
        case 5:
        {	
			new Float:Pos[3];
			GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
            InterpolateCameraPos(playerid, PlayerPosition[playerid][0], PlayerPosition[playerid][1], PlayerPosition[playerid][2]+Level[playerid], Pos[0], Pos[1], Pos[2]+Level[playerid], 3000, CAMERA_MOVE);
            InterpolateCameraLookAt(playerid, PlayerPosition[playerid][0], PlayerPosition[playerid][1], PlayerPosition[playerid][2], Pos[0], Pos[1], Pos[2], 3000, CAMERA_MOVE);
			for(new i = 0; i < 3; i++) PlayerPosition[playerid][i] = Pos[i];
			SetTimerEx("SwitchCharacter", 4000, false, "ii", playerid, 6);
        }
        case 6..8:
        {
            Audio_PlayEx(playerid, 1);
            InterpolateCameraPos(playerid, PlayerPosition[playerid][0], PlayerPosition[playerid][1], PlayerPosition[playerid][2]+Level[playerid], PlayerPosition[playerid][0], PlayerPosition[playerid][1], PlayerPosition[playerid][2]+(Level[playerid]-50), 600, CAMERA_MOVE);
            InterpolateCameraLookAt(playerid, PlayerPosition[playerid][0], PlayerPosition[playerid][1], PlayerPosition[playerid][2], PlayerPosition[playerid][0], PlayerPosition[playerid][1], PlayerPosition[playerid][2], 600, CAMERA_MOVE);
			Level[playerid] -= 50;
			SetTimerEx("SwitchCharacter", 1000, false, "ii", playerid, level+1);
		}
        case 9:
        {
			new Float:Pos[3];
			GetXYZBehindOfPlayer(playerid, Pos[0], Pos[1], Pos[2]);
			InterpolateCameraPos(playerid, PlayerPosition[playerid][0], PlayerPosition[playerid][1], PlayerPosition[playerid][2]+50, Pos[0], Pos[1], Pos[2], 2000, CAMERA_MOVE);
			InterpolateCameraLookAt(playerid, PlayerPosition[playerid][0], PlayerPosition[playerid][1], PlayerPosition[playerid][2], PlayerPosition[playerid][0], PlayerPosition[playerid][1], PlayerPosition[playerid][2], 2000, CAMERA_MOVE);
			SetTimerEx("SetCameraBehindPlayerEx", 3000, false, "i", playerid);
        }
    }
    return true;
}

forward SetCameraBehindPlayerEx(playerid);
public SetCameraBehindPlayerEx(playerid)
{
    TogglePlayerControllable(playerid, true);
    SetCameraBehindPlayer(playerid);
	return 1;
}

public OnTextDrawFade(Text:text, forplayerid, bool:isbox, newcolor, finalcolor)
{
    if(text == g_TextDraw[4])
    {
        if (newcolor == 0xB22222AA)
        {
            TextDrawFadeBoxForPlayer(forplayerid, g_TextDraw[4], 0xB22222AA, 0, 10);
        }
        else if (newcolor == 0)
        {
            TextDrawHideForPlayer(forplayerid, g_TextDraw[4]);
        }
    }
    return 1;
}

ShowTDS(playerid)
{
	for(new i = 0; i < 5; i++) 
	{
		TextDrawShowForPlayer(playerid, g_TextDraw[i]);
		if(i < 4) PlayerTextDrawShow(playerid, p_TextDraw[playerid][i]);
	}
	SelectTextDraw(playerid, 0xFF0000FF);
	return 1;
}

HideTDS(playerid)
{
	CancelSelectTextDraw(playerid);
	for(new i = 0; i < 5; i++) 
	{
		TextDrawHideForPlayer(playerid, g_TextDraw[i]);
		if(i < 4) PlayerTextDrawHide(playerid, p_TextDraw[playerid][i]);
	}
	return 1;
}

GetXYZBehindOfPlayer(playerid, &Float:x, &Float:y, &Float:z, Float:distance=3.5) // Y_Less
{
	new Float:a;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, a);
	x += (distance * floatsin(a, degrees));
	y += (distance * floatcos(a, degrees));
	z += 1;
	return 1;
}

