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
	
	if activator:GetActiveWeapon():GetClass() == ("weapon_frag") then
	caller:GiveAmmo(3,activator:GetActiveWeapon():GetPrimaryAmmoType())
	else 

	if activator:GetActiveWeapon():GetClass() == ("weapon_crossbow") then
	caller:GiveAmmo(5,activator:GetActiveWeapon():GetPrimaryAmmoType())
	else
	
	caller:GiveAmmo(30,activator:GetActiveWeapon():GetPrimaryAmmoType())
	end
	end
	
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
