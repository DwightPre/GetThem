AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include("shared.lua")

function ENT:SpawnFunction( ply, tr )
        if ( !tr.Hit ) then return end
        local SpawnPos = tr.HitPos + tr.HitNormal * 16
        local ent = ents.Create( "sun_cannon" )
                ent:SetPos( SpawnPos )
        ent:Spawn()
        ent:Activate()
        return ent

end

function ENT:Initialize()
	self:SetModel("models/props/CS_militia/reloadingpress01.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	--self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	if phys and phys:IsValid() then
		phys:Wake()
	end
	self:SetMoveType(MOVETYPE_NONE)
end

function ENT:OnTakeDamage(dmg)
	return false
end

function ENT:OnRemove()
	if (self.light:IsValid()) then
		self.light:SetParent()
		self.light:Fire("TurnOff",0,0);
		self.light:Fire("kill",0,0.1)
	end
end

function ENT:Explode(pos,magnitude,time)
	local time_ = time or 0
	local bang = ents.Create("env_explosion")
	bang:SetPos(pos)
	bang:SetKeyValue("iMagnitude",magnitude)
	bang:Spawn()
	bang:Fire("explode","",time_)
	bang:Fire("kill","",time_+1.5)
end
