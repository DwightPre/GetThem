AddCSLuaFile()

ENT.Base = "base_nextbot" -- This entity is based on "base_ai"
ENT.Spawnable = true

function ENT:Initialize()

	self:SetModel( "models/chicken/chicken.mdl" ) -- Sets the model of the NPC.
	self:SetSolid(  SOLID_BBOX ) -- This entity uses a solid bounding box for collisions.
	self:SetHealth(100)

end

function ENT:BehaveAct()

end

function ENT:OnLandOnGround()

end

function ENT:RunBehaviour()

end

function ENT:OnKilled( dmg )

hook.Call( "OnNPCKilled", GAMEMODE, self, dmg:GetAttacker(), dmg:GetInflictor() )
self:Remove()

end

list.Set( "NPC", "simple_human",
{    Name = "Simple Human",
     Class = "simple_human",
    Category = "Bot"
})
