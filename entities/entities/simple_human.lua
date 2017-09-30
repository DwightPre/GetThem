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
	self:ResetSequence( self:LookupSequence( "walk01" ) );
	self:SetPlaybackRate( self:SequenceDuration() + 0.2 );
end

function ENT:OnKilled( dmg )

	local effect = EffectData()
	effect:SetOrigin(self:GetPos() + Vector(0, 0, -10))
	util.Effect("ManhackSparks", effect)

hook.Call( "OnNPCKilled", GAMEMODE, self, dmg:GetAttacker(), dmg:GetInflictor() )
self:Remove()

end

list.Set( "NPC", "simple_human",
{    Name = "Simple Human",
     Class = "simple_human",
    Category = "Bot"
})
