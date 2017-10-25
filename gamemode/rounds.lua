AddCSLuaFile()
if (SERVER) then
	round = {}

	-- Variables Round-System
	round.Clean = true
	round.Enable = true
	round.Break	= 40	-- second breaks
	round.Time	= 60*10	-- minute rounds
	--round.Time = CreateConVar("round.Time", "0")
	--round.Break = CreateConVar("round.Break", "0")

	-- Read Variables
	round.TimeLeft = -1
	round.Breaking = false

//---------------//
// Round-System	//
//---------------//
util.AddNetworkString("Round_Timer")
util.AddNetworkString("Round_active")

local delay = 0
local roundTimer = round.Time

hook.Add( "Think", "CurTimeDelay", function()
 if CurTime() < delay then return end
	roundTimer = roundTimer - 1
	delay = CurTime() + 1

	Roundtimer1 = roundTimer
	umsg.Start("RoundTimer");
	umsg.String(Roundtimer1);
	umsg.End();

	local timeFormat = string.FormattedTime( Roundtimer1, "%02i:%02i" )
	SetGlobalInt ("roundTimer" , timeFormat)

end)

function round.Broadcast(Text)
	for k, v in pairs(player.GetAll()) do
		v:ConCommand("play buttons/button17.wav")
		v:ChatPrint(Text)
	end
end

function round.Begin()
	//---------------//
	// Round-Begin	//
	//---------------//

	round.Broadcast("Round starting! Round ends in " .. string.FormattedTime(round.Time, "%02i") .. " Minute(s)!")
	round.TimeLeft = round.Time
	
	SetGlobalInt( "TotalSpawns", 0)
	SetGlobalInt( "Kills", 0)
	SetGlobalInt( "Alive", 0)	
	SetGlobalInt( "Earned", 0)	
	
	SetGlobalInt( "TotalSpawns1", 0)
	SetGlobalInt( "Kills1", 0)
	SetGlobalInt( "Alive1", 0)
	SetGlobalInt( "Earned1", 0)
	
	SetGlobalString( "BestPlayer", "Team Red")
	SetGlobalString( "BestPlayer1", "Team Blue")
	
	SetGlobalString( "SteamID" , "STEAM_0:1:35932665") -- Random good pic
	SetGlobalString( "SteamID1" , "STEAM_0:1:35932665")
	
end

function round.End()
	//---------------//
	// Round End	//
	//--------------//
	
	SetGlobalInt( "Alive", GetGlobalInt("NPCteam2") )
	SetGlobalInt( "Alive1", GetGlobalInt("NPCteam1") )
	
	//------------------//
	// Best Team Player	//
	//------------------//
	local BestScore = 0
	local BestScore1 = 0
	local BestPlayer

for k,v in pairs( player.GetAll() ) do
	local Frags = v:Frags()	
	
	if Frags > BestScore then
	if v:Team() == 2  then
	BestScore = Frags
	SetGlobalString( "BestPlayer", v:Name())
	SetGlobalInt( "TotalSpawns", team.TotalFrags( v:Team())) --v:Frags()
	SetGlobalInt( "Kills", v:GetNWInt("killcounter") )
	--SetGlobalInt( "Alive", GetGlobalInt("NPCteam2") )
	SetGlobalInt( "Earned", v:Frags()*20)		
	--if IsValid(v:SteamID()) then SetGlobalString( "SteamID" , v:SteamID()) end
	SetGlobalString( "SteamID" , v:SteamID())
	v:AddXp( v:Frags()*20 )
	v:PrintMessage( HUD_PRINTTALK, "[GetThem]Well played + " .. v:Frags()*20 .. " $!");	
	else 
	BestScore1 = Frags
	SetGlobalString( "BestPlayer1", v:Name())
	SetGlobalInt( "TotalSpawns1", team.TotalFrags( v:Team()))
	SetGlobalInt( "Kills1", v:GetNWInt("killcounter") )
	--SetGlobalInt( "Alive1", GetGlobalInt("Alive1") )
	SetGlobalInt( "Earned1", v:Frags()*20)	
	--if IsValid(v:SteamID()) then SetGlobalString( "SteamID1" , v:SteamID()) end
	SetGlobalString( "SteamID1" , v:SteamID())
	v:AddXp( v:Frags()*20 )
	v:PrintMessage( HUD_PRINTTALK, "[GetThem]Well played + " .. v:Frags()*20 .. " $!");	
	end

	local AliveTeam1 =  GetGlobalInt("Alive")
	local AliveTeam2 =  GetGlobalInt("Alive1")
	
	if AliveTeam1 > AliveTeam2 then
	v:PrintMessage( HUD_PRINTTALK,"[GetThem]Red has won 1 token and " .. AliveTeam1*30 .. " $ with ".. tostring(AliveTeam1) .. " live(s)!" .. "")
	--round.Broadcast("[" .. v:Name() .. "] Has won 1 token and " .. AliveTeam1*30 .. " $ with ".. tostring(AliveTeam1) .. " live(s)!" .. "")
	if v:Team() == 2 then v:AddToken( 1 ) v:AddXp(AliveTeam1*30)  SetGlobalInt( "Earned", (GetGlobalInt( "Earned") +( AliveTeam1*30))) end
	else
	v:PrintMessage( HUD_PRINTTALK,"[GetThem]Blue has won 1 token and " .. AliveTeam2*30 .. " $ with ".. tostring(AliveTeam2) .. " live(s)!" .. "")
	--round.Broadcast("[" .. v:Name() .. "] Has won 1 token and " .. AliveTeam2*30 .. " $ with ".. tostring(AliveTeam2) .. " live(s)!" .. "")
	if v:Team() == 1 then v:AddToken( 1 ) v:AddXp(AliveTeam2*30) SetGlobalInt( "Earned1", (GetGlobalInt( "Earned1") +( AliveTeam2*30))) end	
	end
	end
	
	v:ConCommand("EndStats") --Show EndStatsHud
end

---------------------------

	roundTimer = round.Time + round.Break
	round.Broadcast("Round over! Next round in " .. round.Break .. " Seconds")
	round.TimeLeft = round.Break

	if round.Clean == true then
	RunConsoleCommand("clean_map");
	for k,v in pairs( player.GetAll() ) do
		v:SetFrags( 0 )
		v:SetNWInt("killcounter", 0)
		v:ConCommand("CloseEndStats")
	end
	end
end

function round.Handle()
if (round.Enable == true) then
	if (round.TimeLeft == -1) then -- Start the first round
		round.Begin()
		return
	end

	round.TimeLeft = round.TimeLeft - 1

	if (round.TimeLeft == 0) then
		if (round.Breaking) then
			round.Begin()
			round.Breaking = false
		else
			round.End()
			round.Breaking = true
		end
	end
end
end

timer.Create("round.Handle", 1, 0, round.Handle)


//---------------//
// 	CLIENT!		//
//---------------//
elseif CLIENT then

local ourMat = Material( "background.png" ) 

hook.Add( "HUDPaint", "RoundHud", function()

	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( ourMat	)
	surface.DrawTexturedRect( ScrW() /2 - 160, 5, 320, 75 )

	if(GetGlobalInt("NPCteam1") == null) then
	draw.WordBox( 17, ScrW() /2 + 108, ScrH() * 0.0095, "".. "0" .. "","DermaLarge",Color(0,0,0,0),Color(255,255,255,255))
	else
	if (GetGlobalInt("NPCteam1")  > 9) then
	draw.WordBox( 17, ScrW() /2 + 108, ScrH() * 0.0095, "".. GetGlobalInt("NPCteam1") .. "","DermaLarge",Color(0,0,0,0),Color(255,255,255,255))
	else
	draw.WordBox( 17, ScrW() /2 + 108, ScrH() * 0.0095, "".. GetGlobalInt("NPCteam1") .. "","DermaLarge",Color(0,0,0,0),Color(255,255,255,255))
	end
	end

	if(GetGlobalInt("NPCteam2") == null) then
	draw.WordBox( 17, ScrW() /2 - 160, ScrH() * 0.0095, "".. "0" .. "","DermaLarge",Color(0,0,0,0),Color(255,255,255,255))
	else
	if (GetGlobalInt("NPCteam2")  > 9) then
	draw.WordBox( 17, ScrW() /2 - 160, ScrH() * 0.0095, "".. GetGlobalInt("NPCteam2") .. "","DermaLarge",Color(0,0,0,0),Color(255,255,255,255))
	else
	draw.WordBox( 17, ScrW() /2 - 160, ScrH() * 0.0095, "".. GetGlobalInt("NPCteam2") .. "","DermaLarge",Color(0,0,0,0),Color(255,255,255,255))
	end
	end

	draw.WordBox( 12, ScrW() /2 - 48, ScrH() * 0.009, "".. GetGlobalInt("roundTimer") ,"DermaLarge",Color(0,0,0,0),Color(255,255,255,255))

end )

function EndStatsHud()
	local show = false
	//------------------//
	// Best Player Hud	//
	//-----------------//
	local Frame = vgui.Create("DFrame")
	Frame:SetSize(ScrW(), ScrH())
	Frame:Center()
	Frame:SetTitle("")
	Frame:SetDraggable(false)
	Frame:SetSizable(false)
	Frame:ShowCloseButton(true)
	Frame:MakePopup()
	Frame.Paint = function(self, w, h) draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0, 175 ) ) --end
	
	show = true
	Frame.OnClose = function() --works?
	show = false
	end

	--Layer: 1 (box)
	draw.RoundedBox(4, ScrW()/3.56, ScrH()/1.99, ScrW()/2.13, ScrH()/25.6, Color(12, 0, 255, 100))
	draw.RoundedBox(4, ScrW()/3.56, ScrH()/4.76, ScrW()/2.13, ScrH()/4.65, Color(255, 0, 72, 127))
	draw.RoundedBox(4, ScrW()/3.56, ScrH()/5.85, ScrW()/2.13, ScrH()/25.6, Color(255, 0, 0, 100))
	draw.RoundedBox(4, ScrW()/3.56, ScrH()/1.85, ScrW()/2.13, ScrH()/4.65, Color(12, 0, 255, 127))
	
	--Layer: 2 (text)
	draw.DrawText(" " .. GetGlobalString("BestPlayer") .. " " , "DermaLarge", ScrW()/2.13, ScrH()/5.85, Color(0, 0, 0, 255))
	draw.DrawText("Total Spawns: " .. GetGlobalInt("TotalSpawns"), "Arial24", ScrW()/1.88, ScrH()/4.02, Color(1, 1, 1, 221))
	draw.DrawText("Alive: " .. GetGlobalInt("Alive"), "Arial24", ScrW()/1.88, ScrH()/3.47, Color(1, 1, 1, 221))
	draw.DrawText("Kills: " .. GetGlobalInt("Kills"), "Arial24", ScrW()/1.88, ScrH()/3.06, Color(1, 1, 1, 221))
	draw.DrawText("Earned: " .. GetGlobalInt("Earned") .. " $", "Arial24", ScrW()/1.88, ScrH()/2.73, Color(1, 1, 1, 221))

	draw.DrawText(" " .. GetGlobalString("BestPlayer1") .. " ", "DermaLarge", ScrW()/2.13, ScrH()/1.99, Color(0, 0, 0, 255))
	draw.DrawText("Total Spawns: " .. GetGlobalInt("TotalSpawns1"), "Arial24", ScrW()/1.88, ScrH()/1.72, Color(1, 1, 1, 221))
	draw.DrawText("Alive: " ..  GetGlobalInt("Alive1"), "Arial24", ScrW()/1.88, ScrH()/1.61, Color(1, 1, 1, 221))
	draw.DrawText("Kills: " .. GetGlobalInt("Kills1"), "Arial24", ScrW()/1.88, ScrH()/1.52, Color(1, 1, 1, 221))
	draw.DrawText("Earned: " .. GetGlobalInt("Earned1") .. " $", "Arial24", ScrW()/1.88, ScrH()/1.43, Color(1, 1, 1, 221))
	
	--Medal Image
	local Goldmedal = vgui.Create( "DImage", Frame )	
	Goldmedal:SetSize(  ScrW()/32, ScrH()/25.6 )	
	Goldmedal:SetImage( "icon16/medal_gold_1.png" )
	
	local Goldmedal1 = vgui.Create( "DImage", Frame )
	Goldmedal1:SetSize(  ScrW()/32, ScrH()/25.6 )
	Goldmedal1:SetImage( "icon16/medal_gold_1.png" )
	
	--Cross Image
	local Cross = vgui.Create( "DImage", Frame )	
	Cross:SetSize(  ScrW()/32, ScrH()/25.6 )	
	Cross:SetImage( "icon16/cross.png" )
	
	local Cross1 = vgui.Create( "DImage", Frame )
	Cross1:SetSize(  ScrW()/32, ScrH()/25.6 )
	Cross1:SetImage( "icon16/cross.png" )
	
	if GetGlobalInt("Alive1") > GetGlobalInt("Alive") then
	Goldmedal:SetPos( ScrW()/3.37, ScrH()/1.99 )
	Goldmedal1:SetPos( ScrW()/1.42, ScrH()/1.99 )
	Cross:SetPos( ScrW()/3.37, ScrH()/5.85 )
	Cross1:SetPos( ScrW()/1.42, ScrH()/5.85 )
	else if GetGlobalInt("Alive") > GetGlobalInt("Alive1") then
	Goldmedal:SetPos( ScrW()/3.37, ScrH()/5.85 )
	Goldmedal1:SetPos( ScrW()/1.42, ScrH()/5.85 )
	Cross:SetPos( ScrW()/3.37, ScrH()/1.99 )
	Cross1:SetPos( ScrW()/1.42, ScrH()/1.99 )	
	else
	Goldmedal:Hide()
	Goldmedal1:Hide()
	Cross:Hide()
	Cross1:Hide()
	end	
	end
	
	local Texture13 = vgui.Create( "AvatarImage", Frame ) 
	Texture13:SetSize( 128, 128 )
	Texture13:SetPos( ScrW()/3.2, ScrH()/4.02 )
	Texture13:SetSteamID( util.SteamIDTo64(GetGlobalString( "SteamID")) , 128 )

	local Texture14 =  vgui.Create( "AvatarImage", Frame ) 
	Texture14:SetSize( 128, 128 )
	Texture14:SetPos( ScrW()/3.2, ScrH()/1.72 )
	Texture14:SetSteamID( util.SteamIDTo64(GetGlobalString( "SteamID1")) , 128 )
	end		
	--// End HUD Code //--
	
	function CloseEndStatsHud()
	timer.Create( "CloseStats", 15, 1, function() 
	if show == true then Frame:Close() end 
	end)
	end
	concommand.Add("CloseEndStats", CloseEndStatsHud)
	
	end
concommand.Add("EndStats", EndStatsHud)
end