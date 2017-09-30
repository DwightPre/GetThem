AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

--ENT.Model = {"models/hunter/blocks/cube075x2x1.mdl"}
ENT.StartHealth = 100

function ENT:Initialize()
	if self:GetModel() == "models/error.mdl" then
	self:SetModel(Model("models/hunter/blocks/cube1x1x1.mdl")) end
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetHealth(self.StartHealth)
	
	local phys = self:GetPhysicsObject()
	if phys and phys:IsValid() then
		phys:Wake()
	end
end

function ENT:PhysicsCollide(data, physobj)

end

function ENT:Think()
	
end

function ENT:Use(activator, caller)

end

function ENT:OnTakeDamage(dmginfo)
	self:SetHealth(self:Health() - dmginfo:GetDamage())
	if self:Health() <= 0 then self:DoDeath() end
end

function ENT:DoDeath()
	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())
	util.Effect("HelicopterMegaBomb", effectdata)
	self:Remove()
end

function ENT:OnRemove()
	self:StopParticles()
end