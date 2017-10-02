AddCSLuaFile("shared.lua")

delay = 0
ENT.MaxTakes = 10

function ENT:Initialize()
self:SetModel("models/Items/ammocrate_smg1.mdl")

self:PhysicsInit( SOLID_VPHYSICS )
self:SetMoveType( MOVETYPE_VPHYSICS )
self:SetSolid( SOLID_VPHYSICS )
self:SetHealth(self.MaxTakes)
	

end

function ENT:Use(activator, caller)

	local ammo = self.Entity:Health()
	
	if CurTime() < delay then return end
	caller:GiveAmmo(30,activator:GetActiveWeapon():GetPrimaryAmmoType())
	delay = CurTime() + 0.7
	
	if ammo > 1 then
	self:SetHealth(self:Health() -1)
	else
	self:Remove()
	self:SetHealth(self.MaxTakes)
	end
end

list.Set( "NPC", "simple_ammo_crate", {
	Name = "GT ammo crate",
	Class = "simple_ammo_crate",
	Category = "NextBot"
} )
