AddCSLuaFile()
if (SERVER) then

function WalkingChickSpawnPos( ply, cmd, args )
	
for k, v in pairs( ents.FindByClass("walking_chicken") ) do
	SafeRemoveEntity(v); 
end;
	
if (game.GetMap() == "a_first_getthem_gamemode_map" and gmod.GetGamemode().Name == "GetThem" and player.GetCount() == 1 ) then

	SpawnWalkingChicken(Vector(918.897339,427.933289,0.031249)		  ,1)
	SpawnWalkingChicken(Vector(-1434.525269,313.426086,0.031249)	  ,2)
	SpawnWalkingChicken(Vector(352.082520,-212.207367,0.031250)	  	,3)
	SpawnWalkingChicken(Vector(2608.112305,-125.986931,0.031249)  	,4)
	SpawnWalkingChicken(Vector(3475.459961,-217.824478,0.031250)  	,5)
	SpawnWalkingChicken(Vector(-1899.735352,1399.361938 ,0.031250)	,6)
	SpawnWalkingChicken(Vector(-2789.600586,1761.397705 ,0.031250)	,7)
	SpawnWalkingChicken(Vector(-630.960144 ,2208.980957 ,0.031250)	,8)
	SpawnWalkingChicken(Vector(2410.988770,3034.870117 ,129.031250)	,9)
	SpawnWalkingChicken(Vector(1436.917847,2566.935059,0.031250)	  ,10)
	SpawnWalkingChicken(Vector(-2926.504883 ,741.407898,0.031248) 	,11)
	SpawnWalkingChicken(Vector(-1425.671143,2813.013428,0.031250) 	,12)
	SpawnWalkingChicken(Vector(-751.684631,2229.169189 ,129.031250)	,13)
	SpawnWalkingChicken(Vector(-2604.170166,473.866455 ,0.031246)	  ,14)
	SpawnWalkingChicken(Vector(1901.933472,445.317505,0.031250)	  	,15)
	SpawnWalkingChicken(Vector(-2889.968750,229.736343 ,132.188248)	,16)

		--ply:StripWeapons()
		ply:AllowFlashlight( true )
		ply:Give("weapon_pistol")
		ply:Give("weapon_smg1")
		ply:GiveAmmo( 	200, "Pistol", true )
		ply:GiveAmmo(	150, "SMG1"	)
		
end

end
concommand.Add( "SpawnTheWalkingChickens", WalkingChickSpawnPos )


function SpawnWalkingChicken(position,num)
	local walkchick = ents.Create("walking_chicken") 
	local pos = position
	pos.z = pos.z - walkchick:OBBMaxs().z
	walkchick:SetPos( pos )
	walkchick:SetName("" .. num)
	walkchick:Spawn()
	print("Walking chicken spawned on position: " .. tostring(position) .. "[" .. walkchick:GetName() .. "]")
end 

function AskToPlay( ply, cmd, args )
	if (game.GetMap() == "a_first_getthem_gamemode_map" and player.GetCount() == 1 ) then
	net.Start("PlayMiniGame")
	net.Send(ply)
	end
end
concommand.Add( "MiniGame", AskToPlay )

end

if (CLIENT) then

net.Receive( "PlayMiniGame", function()
	
	if not IsValid(Tutorialframe) and not IsValid(Minigameframe) then	
	Minigameframe = vgui.Create( "DFrame" )
	Minigameframe:SetSize(380, 230)
	Minigameframe:Center()
	Minigameframe:SetTitle("The Search For Chicken Continuous")
	Minigameframe:SetDraggable(true)
	Minigameframe:SetSizable(false)
	Minigameframe:ShowCloseButton(true)
	Minigameframe:MakePopup()
	Minigameframe.Paint = function(self, w, h) draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0, 175 ) ) end
	
	local TextDLabel = vgui.Create( "DLabel", Minigameframe )
	TextDLabel:SetPos( 6, -25 )
	TextDLabel:SetSize(365, 200)
	TextDLabel:SetFont( "Trebuchet18" )
	TextDLabel:SetText( " It looks like you are alone in the server."..
	" \n While waiting for players, would you like to play a mini-game?"..
	" \n Find chickens everywhere around the map!"..
	" \n You also earn money! Try to find them all to earn a token!" )
	
	local PlayButton = vgui.Create( "DButton", Minigameframe ) 
	PlayButton:SetText( "Play Mini Game While Waiting" )					
	PlayButton:SetPos( 60, 140 )
	PlayButton:SetSize( 250, 30 )					
	PlayButton.DoClick = function()	
	Minigameframe:Close()
	RunConsoleCommand( "SpawnTheWalkingChickens" )			
	end
	
	local NoThanksButton = vgui.Create( "DButton", Minigameframe ) 
	NoThanksButton:SetText( "I'll Just Wait" )					
	NoThanksButton:SetPos( 60, 180 )
	NoThanksButton:SetSize( 250, 30 )					
	NoThanksButton.DoClick = function()	
	Minigameframe:Close()
	--RunConsoleCommand( "say", "I'll wait.." )			
	end
	
	end
	
end)
--cleanup when playerjoin?
end