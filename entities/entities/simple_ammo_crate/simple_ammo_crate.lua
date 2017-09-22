AddCSLuaFile("shared.lua")


function ENT:Initialize()
self:SetModel("models/Items/ammocrate_smg1.mdl")

self:PhysicsInit( SOLID_VPHYSICS )
self:SetMoveType( MOVETYPE_VPHYSICS )
self:SetSolid( SOLID_VPHYSICS )

end

function ENT:Use(activator, caller)
		caller:GiveAmmo(30,activator:GetActiveWeapon():GetPrimaryAmmoType())
end

list.Set( "NPC", "simple_ammo_crate", {
	Name = "GT ammo crate",
	Class = "simple_ammo_crate",
	Category = "NextBot"
} )
