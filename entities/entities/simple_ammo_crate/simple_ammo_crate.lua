AddCSLuaFile("shared.lua")

delay = 0
maxtakes = 9

function ENT:Initialize()
self:SetModel("models/Items/ammocrate_smg1.mdl")

self:PhysicsInit( SOLID_VPHYSICS )
self:SetMoveType( MOVETYPE_VPHYSICS )
self:SetSolid( SOLID_VPHYSICS )


end

function ENT:Use(activator, caller)
	if CurTime() < delay then return end
	caller:GiveAmmo(30,activator:GetActiveWeapon():GetPrimaryAmmoType())
	delay = CurTime() + 0.7
	if maxtakes > 0 then
	maxtakes = maxtakes	-1
	else
	self:Remove()
	maxtakes = 9
	end
	util.AddNetworkString("maxtakes")
	net.Start("maxtakes")
	net.WriteString(maxtakes)
	net.Broadcast()
end

list.Set( "NPC", "simple_ammo_crate", {
	Name = "GT ammo crate",
	Class = "simple_ammo_crate",
	Category = "NextBot"
} )
