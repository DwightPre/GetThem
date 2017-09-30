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

function ENT:BehaveStart()
	self.BehaveThread = coroutine.create( function() 
	
	self:PlaySequence( "walk01" , 0.5) 
	self.BehaveThread = nil --Fix: ENT:RunBehaviour() has finished executing!
	
end )
end

function ENT:RunBehaviour()	

end

function ENT:PlaySequence( name, speed )
	local len = self:SetSequence( name )
	speed = speed or 1

	self:ResetSequenceInfo()
	self:SetCycle( 0 )
	self:SetPlaybackRate( speed )
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
