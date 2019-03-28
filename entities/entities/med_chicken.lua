AddCSLuaFile()

ENT.Base = "base_nextbot"
ENT.Spawnable = true

function ENT:Initialize()
    self:SetModel( "models/chicken/chicken.mdl" )
	self:SetSkin( math.random(0, 1) );
    self:SetMaterial("models/props_farm/chicken_brown")
    self:SetHealth(80)   
	self.LoseTargetDist	= 2000	-- How far the enemy has to be before we lose them
	self.SearchRadius 	= 1000	-- How far to search for enemies 
	self:HealPlayer()
end
/*
hook.Add("PlayerSpawnedNPC","attachtobone",function( ply, self )
    local model = ents.Create("prop_physics")	
    model:SetModel("models/weapons/w_medkit.mdl")
	model:SetModelScale( model:GetModelScale() / 1.5, 1 )
	model:FollowBone( self, 0 ) 
    model:SetPos( self:GetPos()+ Vector(0, 0, 15))
	model:SetOwner(self)
    model:SetAngles(self:GetAngles()+ Vector(0, 90, 0):Angle())
--	self:SetNWEntity("MedicChickenOwner", ply)
    self:DeleteOnRemove(model)
    model:SetParent(self)
    model:Spawn()
end)
*/
function ENT:HealPlayer()
timer.Create( "HealPlayer", 2, 0, function() 
    for _,ply in pairs(ents.FindInSphere(self:GetPos(),256)) do
        if (self:GetNWEntity( "MedicChickenOwner") == ply) then
           -- ply:SetHealth(math.Clamp(ply:Health() + 2, 0, 130))
            ply:SetHealth(math.Clamp(ply:Health() + 2, 0, ply:GetMaxHealth()))
        end
    end	
end )
end


function ENT:SetEnemy( ent )
	self.Enemy = ent
end
function ENT:GetEnemy()
	return self.Enemy
end

function ENT:RunBehaviour()
  while true do
	if ( self:HaveEnemy() ) then
		self.loco:FaceTowards( self:GetEnemy():GetPos() )	
		coroutine.wait(3)
		self:PlaySequence( "walk01" , 0.5) 
		coroutine.yield()
		self:ChaseEnemy() 				
	else		
		coroutine.wait(3) --
		self:PlaySequence( "idle01" , 0.5) 
		coroutine.yield() 
		self:MoveToPos( self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 400 ) -- Walk to a random place within about 400 units ( yielding )
	end	
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



function ENT:HaveEnemy()
	if ( self:GetEnemy() and IsValid( self:GetEnemy() ) ) then
		if ( self:GetRangeTo( self:GetEnemy():GetPos() ) > self.LoseTargetDist ) then
			return self:FindEnemy()
		elseif ( self:GetEnemy():IsPlayer() and !self:GetEnemy():Alive() ) then
			return self:FindEnemy()
		end
		return true
	else
		return self:FindEnemy()
	end
end

function ENT:FindEnemy()
	local _ents = ents.FindInSphere( self:GetPos(), self.SearchRadius )
	for k, v in pairs( _ents ) do
		if ( v:IsPlayer() and v == self:GetNWEntity( "MedicChickenOwner")) then
			self:SetEnemy( v )
			return true
		end
	end
	self:SetEnemy( nil )
	return false
end

function ENT:ChaseEnemy( options )

	local options = options or {}

	local path = Path( "Follow" )
	path:SetMinLookAheadDistance( options.lookahead or 300 )
	path:SetGoalTolerance( options.tolerance or 20 )
	path:Compute( self, self:GetEnemy():GetPos() )

	if ( !path:IsValid() ) then return "failed" end

	while ( path:IsValid() and self:HaveEnemy() ) do

		if ( path:GetAge() > 0.1 ) then				
			path:Compute( self, self:GetEnemy():GetPos() )
		end
		
		path:Update( self )							

		if ( options.draw ) then path:Draw() end

		if ( self.loco:IsStuck() ) then
			self:HandleStuck()
			return "stuck"
		end

		coroutine.yield()
	end
	
	return "ok"
	
end

function ENT:OnRemove()
timer.Remove( "HealPlayer" ) 

for k, ply in pairs( player.GetAll() ) do
	if (ply == self:GetNWEntity( "MedicChickenOwner")) then
	ply:SetNWBool( "Bought_MedChicken", false )
	end
end

end

list.Set( "NPC", "med_chicken",
{    Name = "Medic Chicken",
     Class = "med_chicken",
    Category = "Bot"
})