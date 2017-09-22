AddCSLuaFile()

ENT.Base 			= "base_nextbot"
ENT.Spawnable		= true

local teamID

local bullet = {}

local delay = 0

function ENT:Initialize()

	self:SetModel("models/mossman.mdl")
	self:SetHealth(400)

end

function ENT:RunBehaviour()
while(true) do
self:StartActivity( ACT_IDLE )
end
end

function ENT:BehaveUpdate( fInterval )
	if ( !self.BehaveThread ) then return end
		local ent = ents.FindInSphere( self:GetPos(), 200 )
		for k,v in pairs( ent ) do
			if v:IsPlayer() && v:Team() != teamID then
				self.loco:FaceTowards( v:GetPos() )
				self:SetEnemy(v)
				self:ShootEnemy()
			end
			end
end

function ENT:SetTeamId(teamNr)
	teamID = teamNr
end

function ENT:GiveWeapon(wep)

local wep = ents.Create(wep)
local pos = self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos -- location of the hand attachment
        wep:SetOwner(self) -- sets the owner to self
	wep:SetPos(pos) --sets the position of the gun to "pos"

	wep:Spawn() -- spawns the weapon
	wep:SetSolid(SOLID_NONE) --collision stuff

	wep:SetParent(self)  -- sets the weapon's parent to self

	wep.IsNPCWeapon = true
	wep:Fire("setparentattachment", "anim_attachment_RH") -- binds the weapon to the attachment of its parent
	wep:AddEffects(EF_BONEMERGE) -- merges the weapon with the model's bones to make it look like he's actually holding it

self.Weapon = wep

end

function ENT:ShootEnemy()

			  local bullet = {}
        bullet.Num = 1
        bullet.Src = self.Weapon:GetPos()+Vector(0,0,0)
        bullet.Dir = self:GetEnemy():WorldSpaceCenter()-(self.Weapon:GetPos()+Vector(0,0,-20))
        bullet.Spread = Vector(10,10,0)
        bullet.Tracer = 1
        bullet.TracerName = "Tracer"
        bullet.Force = 1
        bullet.Damage = math.random(1,3)
        bullet.AmmoType = "Pistol"
if CurTime() < delay then return end
self:FireBullets( bullet )
delay = CurTime() + 0.3
self:MuzzleFlash()



end

function ENT:SetEnemy( ent )
	self.Enemy = ent
end
function ENT:GetEnemy()
	return self.Enemy
end


list.Set( "NPC", "simple_nextbot", {
	Name = "Simple bot",
	Class = "simple_nextbot",
	Weapons = { "weapon_smg1" },
	Category = "NextBot"
} )



-- AddCSLuaFile()
--
-- ENT.Base = "base_nextbot"
-- ENT.Spawnable = false
--
-- function ENT:Initialize()
--
-- 	--self:SetModel( "models/props_halloween/ghost_no_hat.mdl" )
-- 	--self:SetModel( "models/props_wasteland/controlroom_filecabinet002a.mdl" )
-- 	self:SetModel( "models/mossman.mdl" )
--
-- end
--
-- function ENT:BehaveAct()
-- end
--
-- function ENT:RunBehaviour()
--
-- 	while ( true ) do
--
-- 		-- walk somewhere random
-- 		self:StartActivity( ACT_WALK ) -- walk anims
-- 		self.loco:SetDesiredSpeed( 100 ) -- walk speeds
-- 		self:MoveToPos( self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 200 ) -- walk to a random place within about 200 units (yielding)
--
-- 		self:StartActivity( ACT_IDLE ) -- revert to idle activity
--
-- 		self:PlaySequenceAndWait( "idle_to_sit_ground" ) -- Sit on the floor
-- 		self:SetSequence( "sit_ground" ) -- Stay sitting
-- 		coroutine.wait( self:PlayScene( "scenes/eli_lab/mo_gowithalyx01.vcd" ) ) -- play a scene and wait for it to finish before progressing
-- 		self:PlaySequenceAndWait( "sit_ground_to_idle" ) -- Get up
--
-- 		-- find the furthest away hiding spot
-- 		local pos = self:FindSpot( "random", { type = 'hiding', radius = 5000 } )
--
-- 		-- if the position is valid
-- 		if ( pos ) then
-- 			self:StartActivity( ACT_RUN ) -- run anim
-- 			self.loco:SetDesiredSpeed( 200 ) -- run speed
-- 			self:PlayScene( "scenes/npc/female01/watchout.vcd" ) -- shout something while we run just for a laugh
-- 			self:MoveToPos( pos ) -- move to position (yielding)
-- 			self:PlaySequenceAndWait( "fear_reaction" ) -- play a fear animation
-- 			self:StartActivity( ACT_IDLE ) -- when we finished, go into the idle anim
-- 		else
--
-- 			-- some activity to signify that we didn't find shit
--
-- 		end
--
-- 		coroutine.yield()
--
-- 	end
--
--
-- end
--
-- --
-- -- List the NPC as spawnable
-- --
-- list.Set( "NPC", "simple_nextbot", {
-- 	Name = "Test NPC",
-- 	Class = "simple_nextbot",
-- 	Category = "Nextbot"
-- } )

-- AddCSLuaFile()
--
-- ENT.Base 			= "base_nextbot"
-- ENT.Spawnable		= true
--
-- function ENT:Initialize()
--
-- 	self:SetModel("models/player/gman_high.mdl")
--
-- 	self.LoseTargetDist	= 2000	-- How far the enemy has to be before we lose them
-- 	self.SearchRadius 	= 1000	-- How far to search for enemies
--
-- end
--
-- ----------------------------------------------------
-- -- ENT:Get/SetEnemy()
-- -- Simple functions used in keeping our enemy saved
-- ----------------------------------------------------
-- function ENT:SetEnemy( ent )
-- 	self.Enemy = ent
-- end
-- function ENT:GetEnemy()
-- 	return self.Enemy
-- end
--
-- ----------------------------------------------------
-- -- ENT:HaveEnemy()
-- -- Returns true if we have a enemy
-- ----------------------------------------------------
-- function ENT:HaveEnemy()
-- 	-- If our current enemy is valid
-- 	if ( self:GetEnemy() and IsValid( self:GetEnemy() ) ) then
-- 		-- If the enemy is too far
-- 		if ( self:GetRangeTo( self:GetEnemy():GetPos() ) > self.LoseTargetDist ) then
-- 			-- If the enemy is lost then call FindEnemy() to look for a new one
-- 			-- FindEnemy() will return true if an enemy is found, making this function return true
-- 			return self:FindEnemy()
-- 		-- If the enemy is dead( we have to check if its a player before we use Alive() )
-- 		elseif ( self:GetEnemy():IsPlayer() and !self:GetEnemy():Alive() ) then
-- 			return self:FindEnemy()		-- Return false if the search finds nothing
-- 		end
-- 		-- The enemy is neither too far nor too dead so we can return true
-- 		return true
-- 	else
-- 		-- The enemy isn't valid so lets look for a new one
-- 		return self:FindEnemy()
-- 	end
-- end
--
-- ----------------------------------------------------
-- -- ENT:FindEnemy()
-- -- Returns true and sets our enemy if we find one
-- ----------------------------------------------------
-- function ENT:FindEnemy()
-- 	-- Search around us for entities
-- 	-- This can be done any way you want eg. ents.FindInCone() to replicate eyesight
-- 	local _ents = ents.FindInSphere( self:GetPos(), self.SearchRadius )
-- 	-- Here we loop through every entity the above search finds and see if it's the one we want
-- 	for k, v in pairs( _ents ) do
-- 		if ( v:IsPlayer() ) then
-- 			-- We found one so lets set it as our enemy and return true
-- 			self:SetEnemy( v )
-- 			return true
-- 		end
-- 	end
-- 	-- We found nothing so we will set our enemy as nil ( nothing ) and return false
-- 	self:SetEnemy( nil )
-- 	return false
-- end
--
-- ----------------------------------------------------
-- -- ENT:RunBehaviour()
-- -- This is where the meat of our AI is
-- ----------------------------------------------------
-- function ENT:RunBehaviour()
-- 	-- This function is called when the entity is first spawned. It acts as a giant loop that will run as long as the NPC exists
-- 	while ( true ) do
-- 		-- Lets use the above mentioned functions to see if we have/can find a enemy
-- 		if ( self:HaveEnemy() ) then
-- 			-- Now that we have an enemy, the code in this block will run
-- 			self.loco:FaceTowards( self:GetEnemy():GetPos() )	-- Face our enemy
-- 			self:PlaySequenceAndWait( "plant" )		-- Lets make a pose to show we found a enemy
-- 			self:PlaySequenceAndWait( "hunter_angry" )-- Play an animation to show the enemy we are angry
-- 			self:PlaySequenceAndWait( "unplant" )	-- Get out of the pose
-- 			self:StartActivity( ACT_RUN )			-- Set the animation
-- 			self.loco:SetDesiredSpeed( 450 )		-- Set the speed that we will be moving at. Don't worry, the animation will speed up/slow down to match
-- 			self.loco:SetAcceleration( 900 )			-- We are going to run at the enemy quickly, so we want to accelerate really fast
-- 			self:ChaseEnemy() 						-- The new function like MoveToPos.
-- 			self.loco:SetAcceleration( 400 )			-- Set this back to its default since we are done chasing the enemy
-- 			self:PlaySequenceAndWait( "charge_miss_slide" )	-- Lets play a fancy animation when we stop moving
-- 			self:StartActivity( ACT_IDLE )			--We are done so go back to idle
-- 			-- Now once the above function is finished doing what it needs to do, the code will loop back to the start
-- 			-- unless you put stuff after the if statement. Then that will be run before it loops
-- 		else
-- 			-- Since we can't find an enemy, lets wander
-- 			-- Its the same code used in Garry's test bot
-- 			self:StartActivity( ACT_WALK )			-- Walk anmimation
-- 			self.loco:SetDesiredSpeed( 200 )		-- Walk speed
-- 			self:MoveToPos( self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 400 ) -- Walk to a random place within about 400 units ( yielding )
-- 			self:StartActivity( ACT_IDLE )
-- 		end
-- 		-- At this point in the code the bot has stopped chasing the player or finished walking to a random spot
-- 		-- Using this next function we are going to wait 2 seconds until we go ahead and repeat it
-- 		coroutine.wait( 2 )
--
-- 	end
--
-- end
--
-- ----------------------------------------------------
-- -- ENT:ChaseEnemy()
-- -- Works similarly to Garry's MoveToPos function
-- -- except it will constantly follow the
-- -- position of the enemy until there no longer
-- -- is one.
-- ----------------------------------------------------
-- function ENT:ChaseEnemy( options )
--
-- 	local options = options or {}
--
-- 	local path = Path( "Follow" )
-- 	path:SetMinLookAheadDistance( options.lookahead or 300 )
-- 	path:SetGoalTolerance( options.tolerance or 20 )
-- 	path:Compute( self, self:GetEnemy():GetPos() )		-- Compute the path towards the enemies position
--
-- 	if ( !path:IsValid() ) then return "failed" end
--
-- 	while ( path:IsValid() and self:HaveEnemy() ) do
--
-- 		if ( path:GetAge() > 0.1 ) then					-- Since we are following the player we have to constantly remake the path
-- 			path:Compute( self, self:GetEnemy():GetPos() )-- Compute the path towards the enemy's position again
-- 		end
-- 		path:Update( self )								-- This function moves the bot along the path
--
-- 		if ( options.draw ) then path:Draw() end
-- 		-- If we're stuck, then call the HandleStuck function and abandon
-- 		if ( self.loco:IsStuck() ) then
-- 			self:HandleStuck()
-- 			return "stuck"
-- 		end
--
-- 		coroutine.yield()
--
-- 	end
--
-- 	return "ok"
--
-- end
--
-- list.Set( "NPC", "simple_nextbot", {
-- 	Name = "Simple bot",
-- 	Class = "simple_nextbot",
-- 	Category = "NextBot"
-- } )
