include( 'shared.lua' )
include("cl_score.lua")
include("cl_shop.lua")
include("cl_tokenshop.lua")
include("playerInfo.lua")
include("rounds.lua")
include("cl_holster.lua")
include("minigame.lua")
include("Tutorialframe.lua")

LevelCurve = {}
LevelCurve[0] = 0
LevelCurve[1] =	0
LevelCurve[2] =	30
LevelCurve[3] =	91
LevelCurve[4] =	174
LevelCurve[5] =	276
LevelCurve[6] =	394
LevelCurve[7] =	527
LevelCurve[8] =	675
LevelCurve[9] =	836
LevelCurve[10] = 1009
LevelCurve[11] = 1194
LevelCurve[12] = 1391
LevelCurve[13] = 1599
LevelCurve[14] = 1817
LevelCurve[15] = 2046
LevelCurve[16] = 2285
LevelCurve[17] = 2533
LevelCurve[18] = 2792
LevelCurve[19] = 3059
LevelCurve[20] = 3335
LevelCurve[21] = 3621
LevelCurve[22] = 3914
LevelCurve[23] = 4217
LevelCurve[24] = 4528
LevelCurve[25] = 4847
LevelCurve[26] = 5174
LevelCurve[27] = 5509
LevelCurve[28] = 5852
LevelCurve[29] = 6203
LevelCurve[30] = 6561
LevelCurve[31] = 6927
LevelCurve[32] = 7300
LevelCurve[33] = 7680
LevelCurve[34] = 8068
LevelCurve[35] = 8462
LevelCurve[36] = 8864
LevelCurve[37] = 9273
LevelCurve[38] = 9688
LevelCurve[39] = 10111
LevelCurve[40] = 10540
LevelCurve[41] = 10975
LevelCurve[42] = 11418
LevelCurve[43] = 11866
LevelCurve[44] = 12322
LevelCurve[45] = 12783
LevelCurve[46] = 13251
LevelCurve[47] = 13726
LevelCurve[48] = 14206
LevelCurve[49] = 14693
LevelCurve[50] = 15186
LevelCurve[51] = 15685
LevelCurve[52] = 16190
LevelCurve[53] = 16700
LevelCurve[54] = 17217
LevelCurve[55] = 17740
LevelCurve[56] = 18268
LevelCurve[57] = 18803
LevelCurve[58] = 19343
LevelCurve[59] = 19889
LevelCurve[60] = 20440
LevelCurve[61] = 20997
LevelCurve[62] = 21560
LevelCurve[63] = 22128
LevelCurve[64] = 22702
LevelCurve[65] = 23281
LevelCurve[66] = 23866
LevelCurve[67] = 24456
LevelCurve[68] = 25052
LevelCurve[69] = 25653
LevelCurve[70] = 26259
LevelCurve[71] = 26871
LevelCurve[72] = 27487
LevelCurve[73] = 28110
LevelCurve[74] = 28737
LevelCurve[75] = 29369
LevelCurve[76] = 30007
LevelCurve[77] = 30649
LevelCurve[78] = 31297
LevelCurve[79] = 31950
LevelCurve[80] = 32608
LevelCurve[81] = 33271
LevelCurve[82] = 33939
LevelCurve[83] = 34612
LevelCurve[84] = 35290
LevelCurve[85] = 35972
LevelCurve[86] = 36660
LevelCurve[87] = 37352
LevelCurve[88] = 38050
LevelCurve[89] = 38752
LevelCurve[90] = 39459
LevelCurve[91] = 40171
LevelCurve[92] = 40887
LevelCurve[93] = 41608
LevelCurve[94] = 42334
LevelCurve[95] = 43065
LevelCurve[96] = 43800
LevelCurve[97] = 44541
LevelCurve[98] = 45285
LevelCurve[99] = 46034
LevelCurve[100] = 46788

-- Clientside only stuff goes here

local meta = FindMetaTable("Player")

function meta:GetXp()
	return self:GetNetworkedInt( "xp" )
end

function meta:GetToken()
	return self:GetNetworkedInt( "token" )
end

function meta:GetLevel()
	return self:GetNetworkedInt("level") or 0
end

function meta:GetLevelXP()
	return self:GetNetworkedInt("levelXP") or 0
end

function meta:GetTotalLevelXp( level )
	return LevelCurve[level]
end

function meta:SetLevelXP( amount )
	self:SetNetworkedInt( "levelXP", amount )
	self:SaveLevelXP()
end

function meta:SaveLevelXP()
	local LevelXP = self:GetLevelXP()
	self:SetPData( "levelXP", LevelXP )
end

-- Notifications Receiving & HUD
net.Receive( "Notification",  function()

local Notification = net.ReadString()
local NotificationLenght = string.len( Notification )
local DrawImage = net.ReadDouble() --1:None --2:$ --3:Death --4:Token

	--Panel
	NotifyPanel = vgui.Create( "DNotify" )
	NotifyPanel:SetPos(ScrW()/1.17, ScrH()/8.9)
	NotifyPanel:SetLife(2)
	if DrawImage == 2 or DrawImage == 4 then 
	NotifyPanel:SetSize( 180, 51.2 )
	elseif DrawImage == 3 then
	NotifyPanel:SetSize( 180, 100 )
	NotifyPanel:SetLife(5)
	end if DrawImage == 4 then
	NotifyPanel:SetLife(3)
	end

	--Background
	local Background = vgui.Create( "DPanel", NotifyPanel )
	Background:Dock( FILL )
	Background:SetBackgroundColor(  Color(64, 64, 64, 155) )

	--Label
	local lbl = vgui.Create( "DLabel", Background )
	lbl:SetPos( 10, -10)
	lbl:SetAutoStretchVertical()
	lbl:SetSize( 130, 80)
	lbl:SetText( "" )
	lbl:SetText( Notification )
	lbl:SetTextColor( Color( 255, 200, 0 ) )
	lbl:SetFont( "DermaLarge" )
	lbl:SetWrap( true )	
	if DrawImage == 2 then 
	lbl:SetPos( 10, -10) 
	elseif DrawImage == 3 then
	lbl:SetPos( 10, 10) 
	lbl:SetSize( 130, 85)
	elseif DrawImage == 4 then
	lbl:SetPos( 10, -10) 
	lbl:SetTextColor( Color( 255, 114, 0 ) )
	end
	
	--Images
	if DrawImage == 2 then
	local DollarIMG = vgui.Create( "DImage", Background )
	DollarIMG:SetPos( 136, 5 )	
	DollarIMG:SetSize( 40, 40 )
	DollarIMG:SetImage( "icon16/money_dollar.png" )
	elseif DrawImage == 3 then
	local CancelIMG = vgui.Create( "DImage", Background )
	CancelIMG:SetPos( 136, 30 )	
	CancelIMG:SetSize( 40, 40 )
	CancelIMG:SetImage( "icon16/cancel.png" )
	elseif DrawImage == 4 then
	local TokenIMG = vgui.Create( "DImage", Background )
	TokenIMG:SetPos( 136, 5 )	
	TokenIMG:SetSize( 40, 40 )
	TokenIMG:SetImage( "icon16/money_yen.png" )
	end
	
	NotifyPanel:AddItem( Background )	
end)

local function RecvMyUmsg3( data3 )

--print( "roundTimer" ..data3:ReadString() );
--put here because [ Warning: Unhandled usermessage 'RoundTimer' ]

end
usermessage.Hook( "RoundTimer", RecvMyUmsg3 );

function RemoveDeadRag( ent )

	if (ent == NULL) or (ent == nil) then return end
	if (ent:GetClass() == "class C_ClientRagdoll") then
		if ent:IsValid() and !(ent == NULL) then
			SafeRemoveEntityDelayed(ent, 5)
		end
	end
	
end
hook.Add("OnEntityCreated", "RemoveDeadRag", RemoveDeadRag)

hook.Add( "HUDShouldDraw", "hide hud", function( name )
     if ( name == "CHudHealth" or name == "CHudBattery" ) then
         return false
     end
end )
