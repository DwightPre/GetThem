AddCSLuaFile()

ENT.Base = "base_nextbot" -- This entity is based on "base_ai"
ENT.Spawnable = true

local teamID

local bullet = {}

local delay = 0

function ENT:Initialize()

	self:SetModel( "models/Combine_Soldier.mdl" ) 
	self:SetSolid(  SOLID_BBOX )
	self:SetHealth(400)
	self:SetOwner( self.Owner )

end

function ENT:BehaveAct()

end

function ENT:OnLandOnGround()
--self.IdleAnim = (ACT_IDLE)
--self:StartActivity(self.IdleAnim)
end

function ENT:RunBehaviour()
while(true) do

self:StartActivity(ACT_IDLE)

end
end



function ENT:SetTeamId(teamNr)
	teamID = teamNr
	self:SetNWInt( 'Team', teamNr )
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

function ENT:BehaveUpdate( fInterval )
	if ( !self.BehaveThread ) then return end

		local ent = ents.FindInSphere( self:GetPos(), 300 )
		for k,v in pairs( ent ) do
			if v:IsPlayer() && v:Team() != self:GetNWInt( 'Team' ) then
				self.loco:FaceTowards( v:GetPos() )
				self:SetEnemy(v)
				self.IdleAnim = (ACT_IDLE_AIM_STIMULATED)
				self:StartActivity(self.IdleAnim)
				self:ShootEnemy()
			end
			end
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
	delay = CurTime() + 0.1
	self:MuzzleFlash()
end

function ENT:SetEnemy( ent )
	self.Enemy = ent
end

function ENT:GetEnemy()
	return self.Enemy
end

list.Set( "NPC", "simple_nextbot",     {    Name = "Simple nextbot",
                                        Class = "simple_nextbot",
                                        Category = "Bot"
                                    })