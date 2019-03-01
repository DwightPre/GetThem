AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.StartHealth = 500
delay = 0

function ENT:Initialize()
	self:SetModel(Model("models/props_junk/TrafficCone001a.mdl"))
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetHealth(self.StartHealth)
	self:SetModelScale( self:GetModelScale() * 2.5, 10 )
	self:SetMaterial("models/debug/debugwhite")
	--Freeze
	local phys = self:GetPhysicsObject()
	if phys and phys:IsValid() then
		phys:EnableMotion(false)
		phys:Sleep(false) 
		phys:Wake()
	end
end

function ENT:PhysicsCollide(data, physobj)

end

function ENT:Think()
	if self:Health() < (self.StartHealth/1.1) then self:SetColor(Color(255,60,0,255)) end
	if self:Health() < (self.StartHealth/1.2) then self:SetColor(Color(200,60,0,255)) end 
	if self:Health() < (self.StartHealth/1.5) then self:SetColor(Color(145,60,0,255)) end 
	if self:Health() < (self.StartHealth/2) then self:SetColor(Color(90,0,60,255)) end
	if self:Health() < (self.StartHealth/3) then self:SetColor(Color(45,0,60,200)) end 
	if self:Health() <= 0 then self:DoDeath() end
end

function ENT:Use(activator, caller)

end

function ENT:OnTakeDamage(dmginfo)
	self:SetHealth(self:Health() - dmginfo:GetDamage())
end

function ENT:DoDeath()
	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())
	util.Effect("HelicopterMegaBomb", effectdata)
	self:EmitSound( "ambient/explosions/explode_" .. math.random( 1, 9 ) .. ".wav" )
	self:Remove()
end

function ENT:OnRemove()
	self:StopParticles()
end

function ENT:Touch( touchentity )
	if touchentity:IsPlayer() then
	touchentity:TakeDamage(2)
	touchentity:ScreenFade( SCREENFADE.OUT ,  Color( 255, 0, 0, 128 ), 0.3, 0 )
	self:SetHealth(self:Health() -10)
	
	local vel = touchentity:GetForward()
	vel.z = 0
	vel:Normalize()
	if touchentity:IsOnGround() then
		vel = vel * 20
		touchentity:SetPos(touchentity:GetPos() + Vector(0, 0, 1))
		vel.z = vel.z + 10
	else
		vel = vel * 2
	end
	if not touchentity:IsOnGround() and touchentity:GetVelocity().z < 0 then
		vel.z = touchentity:GetVelocity().z * - 1
	end
	vel.z = vel.z + 90
	touchentity:SetVelocity(vel)
	
	end
end