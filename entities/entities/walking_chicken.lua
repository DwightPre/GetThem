AddCSLuaFile();

ENT.Base 		= "base_nextbot";
ENT.Spawnable 	= true;

local chicken_mdl = "models/chicken/chicken.mdl";

function ENT:Initialize()
	self:SetModel( chicken_mdl );
	self:SetSkin( math.random(0, 1) );
	self:SetMaterial("models/props_farm/chicken_white")

	self.Panicking = false;
	self.IsPanicking = false;
end

function ENT:GetPanick()
	return self.Panicking or self.IsPanicking;
end

function ENT:RunAway( panic )
	self.SetSpeed = 101;
	self.MovingToOffset = 300;
	
	local anim = ( panic and "run01flap" ) or "run01";
	self:ResetSequence( self:LookupSequence( anim ) );
	self:SetPlaybackRate( self:SequenceDuration() + 0.5 );

	self.loco:SetDesiredSpeed( self.SetSpeed );
	
	self:MoveToPos( self:GetPos() + Vector( math.random( -1, 1 ), math.random( -1, 1 ), 0 ) * self.MovingToOffset );

	if ( !panic ) then coroutine.wait( 2 ); end
end

function ENT:WalkAway()
	self.SetSpeed = 14;
	self.MovingToOffset = 70;
	
	self:ResetSequence( self:LookupSequence( "walk01" ) );
	self:SetPlaybackRate( self:SequenceDuration() + 0.2 );

	self.loco:SetDesiredSpeed( self.SetSpeed );
	
	self:MoveToPos( self:GetPos() + Vector( math.random( -1, 1 ), math.random( -1, 1 ), 0 ) * self.MovingToOffset );

	coroutine.wait( 2 );
end

function ENT:MoveToPos( pos, options )
	local options = options or {}

	local path = Path( "Follow" )
	path:SetMinLookAheadDistance( options.lookahead or 300 )
	path:SetGoalTolerance( options.tolerance or 20 )
	path:Compute( self, pos )

	if ( !path:IsValid() ) then return "failed" end

	self.HasPanicked = false;

	while ( path:IsValid() ) do
		path:Update( self )

		if ( options.draw ) then
			path:Draw()
		end

		if ( self.loco:IsStuck() ) then
			self:HandleStuck()
			return "stuck"
		end

		if ( options.maxage ) then
			if ( path:GetAge() > options.maxage ) then return "timeout" end
		end

		if ( options.repath ) then
			if ( path:GetAge() > options.repath ) then path:Compute( self, pos ) end
		end

		if ( self.Panicking and !self.IsPanicking ) then
			self.Panicking = false;
			self.IsPanicking = true;

			self:RunAway( true );
		end

		coroutine.yield()
	end

	if ( !self.IsPanicking ) then
		self:StartActivity( ACT_IDLE );
		self.HasPanicked = true;
	else
		self.IsPanicking = false;
		self.Panicking = false;

		coroutine.wait( 0.1 );
	end

	return "ok"
end

function ENT:RunBehaviour()
	while ( !self:GetPanick() ) do
		if ( math.random( 1, 10 ) == 3 ) then
			self:RunAway();
		else
			self:RunAway();
		end
	end
end

function ENT:OnInjured( dmginfo )
	local attacker = dmginfo:GetAttacker()
	
	self:EmitSound( "ambient/creatures/chicken_death_0"..math.random( 1, 3 )..".wav" );
	attacker:AddXp( 50 , attacker );
	self:Remove();
	
	local walkingchickens = ((#ents.FindByClass( "walking_chicken" ))-1);
	if walkingchickens == 0 then
    attacker:PrintMessage( HUD_PRINTTALK, "[GetThem]You found all the hiding chickens! +500$ +1 Token" );
    attacker:AddXp( 500 , attacker );
    attacker:AddToken( 1 )
	else
  if walkingchickens == 1 then
		attacker:PrintMessage( HUD_PRINTTALK, "[GetThem]One chicken left! +500$ " );
		attacker:AddXp( 500 , attacker );
  else
		attacker:PrintMessage( HUD_PRINTTALK, "[GetThem] " .. tostring( walkingchickens ) .. " chickens are still hiding!" );
  end
	end
end

list.Set( "NPC", "Chicken",
{
	Name = "Chicken",
	Class = "npc_chicken",
	Category = "CS:GO"
} );