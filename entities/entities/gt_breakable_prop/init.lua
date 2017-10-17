AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

--ENT.Model = {"models/hunter/blocks/cube075x2x1.mdl"}
ENT.StartHealth = 500
delay = 0

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
--if CurTime() < delay then return end
if self:Health() < (self.StartHealth) and caller:GetActiveWeapon():GetClass() == "gt_builder" then
self:SetHealth(self:Health() +20)

--delay = CurTime() + 0.3
else
if self:Health() == (self.StartHealth) and caller:GetActiveWeapon():GetClass() == "gt_builder" then
self:Remove() // for now..
end
end

if self:Health() == (self.StartHealth) then self:SetColor(Color(255,255,255,255)) end

end

function ENT:OnTakeDamage(dmginfo)
	self:SetHealth(self:Health() - dmginfo:GetDamage())
	if self:Health() < (self.StartHealth/1.1) then self:SetColor(Color(255,60,0,255)) end --454
	if self:Health() < (self.StartHealth/1.2) then self:SetColor(Color(200,60,0,255)) end --416
	if self:Health() < (self.StartHealth/1.5) then self:SetColor(Color(145,60,0,255)) end --333
	if self:Health() < (self.StartHealth/2) then self:SetColor(Color(90,0,60,255)) end --250
	if self:Health() < (self.StartHealth/3) then self:SetColor(Color(45,0,60,200)) end --166
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