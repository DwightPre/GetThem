AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

include("rounds.lua") -- Enable/disable rounds.
--include("cl_shop.lua") -- Shop!
--AddCSLuaFile("cl_score.lua") --

/*
  ________        __ ___________.__
 /  _____/  _____/  |\__    ___/|  |__   ____   _____
/   \  ____/ __ \   __\|    |   |  |  \_/ __ \ /     \
\    \_\  \  ___/|  |  |    |   |   Y  \  ___/|  Y Y  \
 \______  /\___  >__|  |____|   |___|  /\___  >__|_|  /
        \/     \/                    \/     \/      \/
*/

if ( SERVER ) then

	XP_STARTAMOUNT = 0

	function xFirstSpawn( ply )
		local experience = ply:GetPData( "xp" )

		if experience == nil then
			ply:SetPData("xp", XP_STARTAMOUNT)
			ply:SetXp( XP_STARTAMOUNT )
		else
		ply:SetXp( experience )
		end
	end

	hook.Add( "PlayerInitialSpawn", "xPlayerInitialSpawn", xFirstSpawn )

	function PrintXp( pl )
		pl:ChatPrint( "Your xp is: " .. pl:GetXp() )
	end

	function xPlayerDisconnect( ply )
		print("Player Disconnect: Xp saved to SQLLite and TXT")
		ply:SaveXp()
		ply:SaveXpTXT()
	end

	concommand.Add( "xp_get", PrintXp )

end

	///////////////////////////////////////////////////
	/////////////////SHOP!!////////////////////////////
	//////////////////////////////////////////////////
function Shop( ply )
	ply:ConCommand("shop")
end
hook.Add("ShowHelp", "MyHook", Shop)

concommand.Add("spawn_crate",function(ply,cmd,args)
	local crate = ents.Create("item_ammo_crate")
	crate:SetPos(ply:GetEyeTrace().HitPos)
	crate:SetAngles(ply:GetForward():Normalize():Angle())
	crate:SetKeyValue("AmmoType",1)
end)

function GivePlayerAWeapon( ply, cmd, args )
	--Pistol
	if args[1] == "pistol" then
	if ply:GetXp() > 800 then
	--ply:StripWeapons()
	    ply:Give("weapon_pistol")
		ply:Give("weapon_crowbar")
		ply:ChatPrint("You got a pistol!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 800 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
	end
	--SMG
	if args[1] == "smg" then --if the 1st argument is "smg" then do:
	if ply:GetXp() > 1000 then
		--ply:StripWeapons()
		ply:Give("weapon_smg1")
		ply:Give("weapon_crowbar")
		ply:ChatPrint("You got an SMG!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 1000 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end
	--Crossbow
	if args[1] == "crossbow" then
	if ply:GetXp() > 1000 then
		--ply:StripWeapons()
		ply:Give("weapon_crossbow")
		ply:GiveAmmo( 10, "XBowBolt", true )
		ply:Give("weapon_crowbar")
		ply:ChatPrint("You got an crossbow!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 1000 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough X$P!")
	end
     end
--Shotgun
	if args[1] == "shotgun" then
	if ply:GetXp() > 1000 then
	--ply:StripWeapons()
		ply:Give("weapon_shotgun")
		ply:Give("weapon_crowbar")
		ply:ChatPrint("You got an shotgun!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 1000 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

--AR2
	if args[1] == "ar2" then
	if ply:GetXp() > 1000 then
	--ply:StripWeapons()
		ply:Give("weapon_ar2")
		ply:Give("weapon_crowbar")
		ply:ChatPrint("You got an AR2!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 1000 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

--Frag
	if args[1] == "frag" then
	if ply:GetXp() > 500 then
	ply:StripWeapons()
		ply:Give("weapon_frag")
		--ply:GiveAmmo( 1, "weapon_frag")
		ply:Give("weapon_crowbar")
		ply:ChatPrint("You got a frag!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 500 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

--Pistol Ammo
	if args[1] == "pistolammo" then
	if ply:GetXp() > 200 then
		ply:GiveAmmo( 200, "Pistol")
	 	ply:ChatPrint("You got pistol ammo!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 200 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

--SMG Ammo
	if args[1] == "smgammo" then
	if ply:GetXp() > 400 then
		ply:GiveAmmo(100,"smg1");
	 	ply:ChatPrint("You got SMG ammo!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 400 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

--Bolt Ammo
	if args[1] == "blotammo" then
	if ply:GetXp() > 400 then
		ply:GiveAmmo( 40, "XBowBolt")
	 	ply:ChatPrint("You got crossbow ammo!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 400 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

--Shotgun Ammo
	if args[1] == "shotgunammo" then
	if ply:GetXp() > 400 then
		ply:GiveAmmo( 40, "Buckshot")
	 	ply:ChatPrint("You got Buckshot!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 400 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

--AR2 Ammo
	if args[1] == "AR2ammo" then
	if ply:GetXp() > 400 then
		ply:GiveAmmo( 120, "AR2")
	 	ply:ChatPrint("You got AR2 ammo!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 400 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

--Alyxgun
	if args[1] == "Alyxgun" then
	if ply:GetXp() > 1200 then
		ply:Give("weapon_alyxgun")
	 	ply:ChatPrint("You got Alyxgun!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 1200 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

--alyxgun Ammo
	if args[1] == "Alyxgunammo" then
	if ply:GetXp() > 100 then
		ply:GiveAmmo( 50, "Alyxgun")
		--ply:Give("weapon_alyxgun")
	 	ply:ChatPrint("You got Alyx's gun ammo!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 100 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

-- Flashlight
	if args[1] == "flashlight" then
	if ply:GetXp() > 100 then
		ply:AllowFlashlight( true )
	 	ply:ChatPrint("You got a Flashlight!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 100 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

-- 150HP
	if args[1] == "HP" then
	if ply:GetXp() > 300 then
		ply:SetHealth( 150 )
		ply:SetMaxHealth( 150 )
	 	ply:ChatPrint("You got 150HP!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 300 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

-- Armor
	if args[1] == "armor" then
	if ply:GetXp() > 500 then
	ply:SetArmor( 100 )
	 	ply:ChatPrint("You got armor!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 500 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

-- Sprint
	if args[1] == "sprint" then
	if ply:GetXp() > 500 then
	ply:SetRunSpeed(720)
	 	ply:ChatPrint("You're 2X faster now!!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 500 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

-- Gman
	if args[1] == "gman" then
	if ply:GetXp() > 200 then
	ply:SetModel("models/player/gman_high.mdl")
	 	ply:ChatPrint("You're Gman!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 200 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

-- Cop
	if args[1] == "cop" then
	if ply:GetXp() > 200 then
	ply:SetModel("models/player/police.mdl")
	 	ply:ChatPrint("You're a cop!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 200 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

-- skeleton
	if args[1] == "skeleton" then
	if ply:GetXp() > 200 then
	ply:SetModel("models/player/skeleton.mdl")
	 	ply:ChatPrint("You're a skeleton!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 200 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

-- phoenix
	if args[1] == "phoenix" then
	if ply:GetXp() > 200 then
	ply:SetModel("models/player/phoenix.mdl")
	 	ply:ChatPrint("You're a phoenix!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 200 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

-- zombie
	if args[1] == "zombie" then
	if ply:GetXp() > 200 then
	ply:SetModel("models/player/zombie_classic.mdl")
	 	ply:ChatPrint("You're a zombie! Aargh!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 200 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

end

concommand.Add("weapon_take", GivePlayerAWeapon)

	///////////////////////////////////////////////////
	/////////////////SPAWN/////////////////////////////
	//////////////////////////////////////////////////

function GM:PlayerInitialSpawn(ply)
	ply:PrintMessage( HUD_PRINTTALK, "[GetThem]Welcome to the server, " .. ply:Nick() )
	local teamn = math.random(1, 2)
    math.randomseed(os.time())

    if team.NumPlayers(1) < team.NumPlayers(2) then
    ply:SetTeam(1)
	ply:SetModel( "models/player/hostage/hostage_02.mdl" )
    else
    ply:SetTeam(2)
	ply:SetModel( "models/player/Group03/Female_04.mdl" )
	end
end

	////////////////////////////////////////////////////
	/////////////////////CHANGE TEAM FUNCTION///////////
	////////////////////////////////////////////////////

function GM:PlayerLoadout(ply)
    if (ply:Team() == 1) then
        ply:Give("weapon_crowbar")
		ply:PrintMessage( HUD_PRINTTALK, "[GetThem]You are in team Blue!");
    else
        ply:Give("weapon_crowbar")
		ply:PrintMessage( HUD_PRINTTALK, "[GetThem]You are in team Red!");
end
	end

function GM:Initialize()
    timer.Create( "Healthgain", 1, 0, function()
	for k, ply in pairs( player.GetAll() ) do
if ply:Health() < ply:GetMaxHealth() then
	ply:SetHealth( ply:Health() + 1 )
	end
	end
	end)
end

	///////////////////////////////////////////////////
	/////////////////SPAWN NPC/////////////////////////
	//////////////////////////////////////////////////

function KeyPressed (ply, key)
if ( key == IN_USE ) then

if (ply:Health()>10) then
if (ply:Team() == 1) then
	SetGlobalInt("NPCteam1", GetGlobalInt("NPCteam1") + 1 )
	ply:SetHealth( ply:Health() - 10 )
	ply:AddFrags( 1 )
	local npc = ents.Create("npc_citizen")
	npc:AddEntityRelationship(player.GetByID(1), D_NU, 99 )
	npc:SetPos(ply:GetEyeTrace().HitPos)
	npc:SetHealth(99)
	npc:Spawn()
	npc:SetName("TEAM1")

else
	SetGlobalInt("NPCteam2", GetGlobalInt("NPCteam2") + 1 )
	ply:SetHealth( ply:Health() - 10 )
	ply:AddFrags( 1 )
	local npc = ents.Create("npc_citizen")
	npc:AddEntityRelationship(player.GetByID(1), D_NU, 99 )
	npc:SetPos(ply:GetEyeTrace().HitPos)
	npc:SetHealth(99)
	npc:Spawn()
	npc:SetName("TEAM2")
	npc:DrawShadow( false )
	npc:SetColor(255, 0, 0, 255)

	end
		end
			end
				end

hook.Add( "KeyPress", "KeyPressedHook", KeyPressed )

	///////////////////////////////////////////////////
	/////////////////DONT MOVE NPC////////////////////
	//////////////////////////////////////////////////

function GM:Think()

	for _, npc in pairs( ents.FindByClass( "npc_*" ) ) do

		if ( IsValid( npc ) && npc:IsNPC() && npc:GetMovementActivity() != ACT_COVER  ) then
			npc:SetMovementActivity( ACT_COVER  )
		end

	end

end

	///////////////////////////////////////////////////
	/////////////////ReMOVE dead NPC////////////////////
	//////////////////////////////////////////////////

--function RemoveDeadRag( ent )
/*
	if (ent == NULL) or (ent == nil) then return end
	if (ent:GetClass() == "class C_ClientRagdoll") then
		if ent:IsValid() and !(ent == NULL) then
			SafeRemoveEntityDelayed(ent,0)
			game.RemoveRagdolls()
		end
	end
	*/
--end
--hook.Add("OnEntityCreated", "RemoveDeadRag", RemoveDeadRag)




	///////////////////////////////////////////////////
	/////////////////KILLED FUNCTIONS/////////////////
	//////////////////////////////////////////////////

function GM:OnNPCKilled( victim, killer, weapon )
	if victim:GetName() == "SpecialOne" then
	killer:AddXp( math.random(600, 1000) )
	for k,v in pairs(player.GetAll()) do
		v:PrintMessage( HUD_PRINTTALK, "[GetThem]A Special NPC has been killed.");
	end
	end


	if killer:Team() == 1 and victim:GetName() == "TEAM1" then
	SetGlobalInt("NPCteam1", GetGlobalInt("NPCteam1") - 1)
	killer:AddXp( math.random(-600, -1000) )
	else
	if killer:Team() == 2 and victim:GetName() == "TEAM2" then
	SetGlobalInt("NPCteam2", GetGlobalInt("NPCteam2") - 1 )
	killer:AddXp( math.random(-600, -1000) )
	end

    if killer:Team() == 1 and victim:GetName() == "TEAM2" then
	killer:AddXp( math.random(60, 100) )
	killer:SetNWInt("killcounter", killer:GetNWInt("killcounter") + 1)
	SetGlobalInt("NPCteam2", GetGlobalInt("NPCteam2") - 1)

	else
	if killer:Team() == 2 and victim:GetName() == "TEAM1" then
	killer:AddXp( math.random(60, 100) )
	killer:SetNWInt("killcounter", killer:GetNWInt("killcounter") + 1)
	SetGlobalInt("NPCteam1", GetGlobalInt("NPCteam1") - 1)
	end
	end

	end
	hook.Call("HUDPaint");
end


function GM:PlayerDeath( victim, inflictor, killer )
	if killer:Team() == 1 and victim:Team() == 2 then
	killer:AddXp( math.random(60, 500) )
	else
	if killer:Team() == 2 and victim:Team() == 1 then
	killer:AddXp( math.random(60, 500) )
	end
	end
end
	///////////////////////////////////////////////////
	/////////////////AUTO - DOOR FUNCTION/////////////
	//////////////////////////////////////////////////

local DoorTypes = { "func_door", "func_door_rotating", "prop_door_rotating" }

timer.Create( "DoorCheck", 1, 0, function()
    for k,v in pairs(DoorTypes) do
        for k2,v2 in pairs(ents.FindByClass(v)) do
            local EntTable = ents.FindInSphere(v2:GetPos(), 80)
            local PlayerTable = {}
            for _,ent in pairs(EntTable) do
                if ent:IsPlayer() then
                    table.insert(PlayerTable, ent)
                end
            end

            if table.Count(PlayerTable) > 0 then
                v2:Fire("open", "")
            else
                v2:Fire("close", "")
            end
        end
    end
end )


/*
function GM:PlayerDeath( victim, inflictor, attacker )
	if (attacker ~= victim) then
	attacker:AddXp( math.random(100, 200) )
	attacker:SetNWInt("killcounter", attacker:GetNWInt("killcounter") + 1)
    end


end
*/

	//////////////////////////////////////////////////
	/////////////////OLD '//' vieuw-function///////////
	//////////////////////////////////////////////////
function ISaid( ply, text, team )
			--local aliveNPCs1 = #ents.FindByName( "TEAM1" )
			--local aliveNPCs2 = #ents.FindByName( "TEAM2" )
			local SpecialOne = #ents.FindByName( "SpecialOne" )


    if (string.sub(text, 1, 2) == "//") then
	for k, v in ipairs( player.GetAll() ) do
	--v:PrintMessage( HUD_PRINTTALK, "The Blue Team Has " .. tostring( aliveNPCs1 ) .. " NPC's, The Red Team Has " .. tostring( aliveNPCs2 ) .. " NPC's." )
	v:PrintMessage( HUD_PRINTTALK, "There are " .. tostring( SpecialOne ) .. " Special NPC's." )

	end
	end

end

hook.Add( "PlayerSay", "ISaid", ISaid );

	///////////////////////////////////////////////////
	/////////////////ADMIN FUNCTIONS//////////////////
	//////////////////////////////////////////////////

function change_team( ply )
if (ply:Team() == 1) then
  ply:SetTeam(2)
  ply:PrintMessage( HUD_PRINTTALK, "[GetThem]You have been changed from team!");
else
  ply:SetTeam(1)
  ply:PrintMessage( HUD_PRINTTALK, "[GetThem]You have been changed from team!");
end

end
concommand.Add( "change_team", change_team )


function GM:PlayerNoClip(ply, on)
	if ply:IsAdmin() then
	return true
	end
	return false
end

function RestartMap(ply)
if ply:IsAdmin() then
game.CleanUpMap()
SetGlobalInt("NPCteam1", 0)
SetGlobalInt("NPCteam2", 0)

	for k,v in pairs(player.GetAll()) do
		v:Spawn()
		--v:PrintMessage( HUD_PRINTTALK, "[GetThem]The map has been cleaned!");
	end
end
end
concommand.Add( "clean_map", RestartMap )

function SpecialOne(ply)
if ply:IsAdmin() then
	for k,v in pairs(player.GetAll()) do
		v:PrintMessage( HUD_PRINTTALK, "[GetThem]A special NPC has spawned!");
	end
	local npc = ents.Create("npc_pigeon")
	npc:AddEntityRelationship(player.GetByID(1), D_NU, 99 )
	npc:SetPos(ply:GetEyeTrace().HitPos)
	npc:SetHealth(99)
	npc:Spawn()
	for k, v in pairs( ents.GetAll() ) do
	npc:DrawShadow( false )
	npc:SetName("SpecialOne")
	end
end
end
concommand.Add( "spawn_special", SpecialOne )

function PhysgunGive(ply)
if ply:IsAdmin() then
ply:Give("weapon_physgun")
end
end
concommand.Add( "give_physgun", PhysgunGive )


 function spawn_prop1(ply)
if ply:IsAdmin() then
barrel=ents.Create("prop_physics")
barrel:SetModel("models/props_lab/blastdoor001c.mdl")
barrel:SetPos(ply:GetEyeTrace().HitPos)
barrel:Spawn()
end
end
concommand.Add( "spawn_prop1", spawn_prop1 )


	///////////////////////////////////////////////////
	///////////////// XP  ////////////////////////////
	//////////////////////////////////////////////////

local meta = FindMetaTable("Player")

function meta:AddXp( amount )
	local current_xp = self:GetXp()
	self:SetXp( current_xp + amount )
end

function meta:SetXp( amount )
	self:SetNetworkedInt( "Xp", amount )
	self:SaveXp()
end

function meta:SaveXp()
	local experience = self:GetXp()
	self:SetPData( "xp", experience )
end

function meta:SaveXpTXT()
	file.Write( gmod.GetGamemode().Name .."/Xp/".. string.gsub(self:SteamID(), ":", "_") ..".txt", self:GetXpString() )
end

function meta:TakeXp( amount )
   self:AddXp( -amount )
end

function meta:GetXp()
	return self:GetNetworkedInt( "Xp" )
end



	/////////////////////////////////////////////////////////////
	/////////////////PAIDAY FUNCTION/////////////////////////////
	//TEAM 1 PAYDAY is diffrent than TEAM 2? now global..////////
		timer.Create( "GivePoints", 600, 0, function() //300
			local aliveNPCs1 = #ents.FindByName( "TEAM1" )
			local aliveNPCs2 = #ents.FindByName( "TEAM2" )
			for k, v in ipairs( player.GetAll() ) do
				v:AddXp( (aliveNPCs1 + aliveNPCs2) * 5 )
				v:PrintMessage( HUD_PRINTTALK, "[PAYDAY!]Every NPC is money, here are your " .. tostring( (aliveNPCs1 + aliveNPCs2) * 5 ) .. " points!");
			end
		end )
