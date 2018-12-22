AddCSLuaFile()

ENT.Base = "base_nextbot"
ENT.Spawnable = true

function ENT:Initialize()
	self:SetModel( "models/chicken/chicken.mdl" )
	--self:SetMaterial("models/props_farm/chicken_brown")
	self:SetSolid(  SOLID_BBOX )
	self:SetHealth(100)	
end

function ENT:BehaveAct()

end

function ENT:OnLandOnGround()

end

function ENT:BehaveStart()
	self.BehaveThread = coroutine.create( function() 
	self:PlaySequence( "idle01" , 0.5) 
	self.BehaveThread = nil --Fix: ENT:RunBehaviour() has finished executing! ,don't need that
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

	self:EmitSound( "chicken/chicken_death_0"..math.random( 1, 3 )..".wav" );

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
