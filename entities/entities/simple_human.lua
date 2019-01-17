AddCSLuaFile()

ENT.Base = "base_nextbot"
ENT.Spawnable = true

function ENT:Initialize()
    self:SetModel( "models/chicken/chicken.mdl" )
	self:SetSkin( math.random(0, 1) );
    self:SetMaterial("models/props_farm/chicken_brown")
  --  self:SetSolid( SOLID_VPHYSICS  )
    self:SetHealth(100)    
end

function ENT:RunBehaviour()
  while true do
   coroutine.wait(3) -- the amount of time to wait in between actions, modifiable
    self:PlaySequence( "idle01" , 0.5) -- plays your sequence
    -- do some stuff here
    coroutine.yield() -- this is needed
  end
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
    hook.Call( "OnNPCKilled", GAMEMODE, self, dmg:GetAttacker(), dmg:GetInflictor() )
    self:Remove()
end

list.Set( "NPC", "simple_human",
{    Name = "Simple Human",
     Class = "simple_human",
    Category = "Bot"
})