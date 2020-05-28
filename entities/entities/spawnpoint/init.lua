AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

/*do not change*/
ENT.Used = false
ENT.GaveGuns = false
delay = 0

if (GAMEMODE_NAME == "getthem") then 
	ENT.MaxSpawnUses = 3		 -- Times New SpawnPoint Can Get Used
	ENT.AllowToBreak = true 	 -- Take Damage, GetThem
else
	ENT.AllowToBreak = false	 -- Take No Damage, Sandbox	
end
	
function ENT:Initialize()
	self.Weapons = {}
	--self.Ammo = {}

    self:SetModel("models/props_junk/terracotta01.mdl")
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )	
	self:SetNWString( "playerowner", "Press USE Key!")
	
	if (self.AllowToBreak) then 
		self:SetHealth(self.MaxSpawnUses)
	else
		self:SetHealth(0)
	end
	
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		return phys:GetMass()
	end

end

function OnSpawnHook( player )

	if player.NewPlayerSpawn and player.NewPlayerSpawn:IsValid() then
		player:SetPos( player.NewPlayerSpawn:GetPos() + Vector( 0, 0, 16 ))
		--player.NewPlayerSpawn:SetHealth(player.NewPlayerSpawn:Health() -1)
	
		if (player.NewPlayerSpawn.AllowToBreak) then 
		player.NewPlayerSpawn:SetHealth(player.NewPlayerSpawn:Health() -1)
		else
		player.NewPlayerSpawn:SetHealth(player.NewPlayerSpawn:Health() +1)
		end
	--print( "Player Respawned!" )
	end
end

function OnDeathHook( ply )

		ply.NewPlayerSpawn.Weapons =  {}
		ply.NewPlayerSpawn.Ammo = {} //overwrite it
		
		if ply.NewPlayerSpawn and (ply:GetName() == ply.NewPlayerSpawn:GetNWString( "playerowner")) then
		
		for k,v in pairs(ply:GetWeapons()) do
			table.insert(ply.NewPlayerSpawn.Weapons, v:GetClass())		
		end
		
		ply.Weapons = ply:GetWeapons()
		for i=1, #ply.Weapons do
		local wep = ply.Weapons[ i ] //index the weapon 
		local type = wep:GetPrimaryAmmoType() //index the type of the ammo
		local count = ply:GetAmmoCount(type) //index the count of the ammo

		--ply.NewPlayerSpawn.Ammo[ type ] = count // set the ammo
		--table.insert(self.Weapons, ply.Weapons)
		--table.insert(self.Ammo,count)	
		end
		
		
		
--		print("-- DEAD! HOOK ADDED! --")
--		print("-- Weapons! --")
--		PrintTable( self.Weapons )
--		print("-- Ammo! --")
--		PrintTable( self.Ammo )
		ply.NewPlayerSpawn.GaveGuns = false
		
		end
		
		end


function ENT:Touch(ent)

	if table.IsEmpty( self.Weapons ) then return end
	
	if ent:IsPlayer() and (self:GetNWString( "playerowner") == ent:GetName()) and self.GaveGuns == false then
		ent:StripWeapons()
		--PrintTable( self.Weapons )
		for k,v in pairs(self.Weapons)do
			ent:Give(v)
		end

		--for k,v in pairs(self.Ammo) do
		--	ent:GiveAmmo(k, v) 
		--end
	self.GaveGuns = true
	end

end



function ENT:OnTakeDamage(dmginfo)
	if (self.AllowToBreak) then 
		self:SetHealth(self:Health() - 1)
		self.GaveGuns = true
	end
end

function ENT:SpawnFunction(ply, tr, ClassName)
	if (!tr.HitWorld) then return end
	local SpawnAng = ply:EyeAngles()
	SpawnAng.y = SpawnAng.y + 180
	SpawnAng.p = 0
	local ent = ents.Create(ClassName)
	ent:SetAngles( SpawnAng )
	ent:SetPos(tr.HitPos + Vector(0, 0, 20))
	ent:Spawn()
 
	return ent
end

function ENT:OnRemove()
	hook.Remove( "PlayerSpawn", "CreateNewSpawn" )
end
local sounds = {
	spawnset  = "garrysmod/content_downloaded.wav"
}

function ENT:Use( activator, caller )
	if ( IsValid( self.LastUser )) then return end
	if (self.Used) then return end
	
	hook.Add( "PlayerSpawn", "CreateNewSpawn", OnSpawnHook )
	
	activator.NewPlayerSpawn = self.Entity
	activator:SetNetworkedVector( "SpawnPos", self.Entity:GetPos() + Vector(0, 0, 10) )
	--activator:PrintMessage( HUD_PRINTCENTER, "New Spawn Point Set!" )
	self:EmitSound( sounds.spawnset )
	self.Used =true
	self:SetNWString( "playerowner", activator:GetName())
	self:SetColor(team.GetColor( activator:Team()))

	hook.Add("PlayerDeath", "SaveAllTheWeapons", OnDeathHook )
		
end


function ENT:Think()
	if ( !IsValid( self.LastUser ) || !self.LastUser:KeyDown( IN_USE ) ) then
		self.LastUser = nil
	end
	
	local delay = 2
	local lastOccurance = -delay 	
	
	local timeElapsed = CurTime() - lastOccurance
	if timeElapsed < delay then
		--print( "cooldown" )
	else
		if self:Health()  <= 0 and (self.AllowToBreak) and self.GaveGuns then	 -- timer fails.
		self:Remove()
		end
	lastOccurance = CurTime()
	end	
	
	
end

function ENT:OnRemove() 
hook.Remove( "PlayerDeath", "SaveAllTheWeapons" )
end

/*
-- DEAD! HOOK ADDED! --
-- Weapons! --
1	=	gmod_tool
2	=	gmod_camera
3	=	weapon_physgun
4	=	weapon_pistol
5	=	weapon_357
6	=	weapon_ar2
7	=	weapon_rpg
8	=	weapon_shotgun
9	=	weapon_smg1
-- Ammo! --
-1	=	0
1	=	30
3	=	0
4	=	60
5	=	0
7	=	0
8	=	3

*/