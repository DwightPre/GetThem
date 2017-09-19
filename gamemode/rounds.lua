function GM:UpdateSettings()

    --round.Time = GetConVar( "round.Time" ):GetInt()

end	
	
if (SERVER) then
	round = {}

	-- Variables Round-System
	round.Clean = true
	round.Enable = true
	round.Break	= 20	-- second breaks
	round.Time	= 60*10	-- minute rounds
	--round.Time = CreateConVar("round.Time", "0")
	--round.Break = CreateConVar("round.Break", "0")
	
	-- Read Variables
	round.TimeLeft = -1
	round.Breaking = false
	
	///////////////////////////////////////////////////
	/////////////////     ROUNDSYSTEM//////////////////
	//////////////////////////////////////////////////
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
	-- (Anything that may need to happen when the round begins)
	
	round.Broadcast("Round starting! Round ends in " .. string.FormattedTime(round.Time, "%02i") .. " Minute(s)!")
	round.TimeLeft = round.Time
end

function round.End()
	-- (Anything that may need to happen when the round ends)
	

	
	--------Best Player Shizzl------------
	local BestScore = 0 
	local BestPlayer
 
	for k,v in pairs( player.GetAll() ) do  
	local Frags = v:Frags()       
	if Frags > BestScore then     
		BestPlayer = v:Name()
		v:AddXp( v:Frags()*30 )
		v:PrintMessage( HUD_PRINTTALK, "[WON!] + " .. v:Frags()*30 .. " $!");
		BestScore = Frags  

	
	end
	end
 
	if BestScore != 0 then
	round.Broadcast("" .. BestPlayer .. " has won " .. BestScore*30 .. " $ with ".. tostring(BestScore) .. " spawned humans!") 
	end
	---------------------------
	
	roundTimer = round.Time + round.Break
	round.Broadcast("Round over! Next round in " .. round.Break .. " Seconds")
	round.TimeLeft = round.Break
	
	if round.Clean == true then
	
	RunConsoleCommand("clean_map");
	for k,v in pairs( player.GetAll() ) do  
		v:SetFrags( 0 )
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


------------------------------------CLIENT------------------------------------
elseif CLIENT then

function RoundHud()

if(GetGlobalInt("NPCteam1") ~= null) then
draw.WordBox( 6, ScrW() * 0.507, ScrH() * 0.06, "Blue[ ".. GetGlobalInt("NPCteam1") .. " ]","DermaLarge",Color(200,200,200,50),Color(0,0,255,255))
else
draw.WordBox( 6, ScrW() * 0.507, ScrH() * 0.06, "Blue[ ".. 0 .. " ]","DermaLarge",Color(200,200,200,50),Color(0,0,255,255))
end

if(GetGlobalInt("NPCteam2") ~= null) then
draw.WordBox( 6, ScrW() * 0.44, ScrH() * 0.06, "Red[ ".. GetGlobalInt("NPCteam2") .. " ]","DermaLarge",Color(200,200,200,50),Color(255,0,0,255))
else
draw.WordBox( 6, ScrW() * 0.44, ScrH() * 0.06, "Red[ ".. 0 .. " ]","DermaLarge",Color(200,200,200,50),Color(255,0,0,255))
end

draw.WordBox( 6, ScrW() * 0.44, ScrH() * 0.01, "Round Time: ".. GetGlobalInt("roundTimer") ,"DermaLarge",Color(200,0,0,255),Color(255,255,255,255))

 end
hook.Add("HUDPaint","Top",RoundHud)

end

