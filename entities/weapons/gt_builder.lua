if SERVER then

AddCSLuaFile()

SWEP.Weight = 5

SWEP.Base = "weapon_base"

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

elseif CLIENT then

SWEP.PrintName = "GT Builder"

SWEP.Slot = 5
SWEP.SlotPos = 1

SWEP.DrawAmmo = false

SWEP.DrawCrosshair = true

end

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = 3
SWEP.Secondary.DefaultClip = 3
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "gwDashCharges"

SWEP.SwingSound = "Weapon_Crowbar.Single"
SWEP.HitSound = "Weapon_Crowbar.Melee_Hit"
SWEP.HitWorldSound = "Weapon_Crowbar.Melee_HitWorld"

SWEP.AllowDrop = false
SWEP.Kind = WEAPON_MELEE
SWEP.HoldType = "melee"

SWEP.Delay = 0.7
SWEP.Range = 85
SWEP.Damage = 20
SWEP.AutoSpawnable = false

SWEP.Author = "Dwight-Pre"
SWEP.Contact = ""
SWEP.Purpose = "Spawns Base Props"
SWEP.Instructions = "Mouse 2"

SWEP.Category = "weapons"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.ViewModel = "models/weapons/v_crowbar.mdl"
SWEP.WorldModel = "models/hunter/blocks/cube05x05x05.mdl"


function SWEP:Initialize()

end

--Prop Selection Menu
function SWEP:Reload()
if CurTime() < delay then return end
RunConsoleCommand("gt_propmenu");
delay = CurTime() + 0.7
end

function SWEP:Think()
end

function SWEP:SecondaryAttack()
self:SetBlock( "models/props_interiors/Furniture_shelf01a.mdl")
end

function SWEP:PrimaryAttack()
--self:SetBlock( "models/hunter/blocks/cube05x05x05.mdl" )
--self:SetBlock( "models/hunter/blocks/cube05x05x05.mdl" )
end

function GiveBlock (model)
self:SetBlock( model)
end

function SWEP:SetBlock( model_file )
if self.Owner:GetToken() > 0 then
	local ent = ents.Create( "gt_breakable_prop" )
	if ( !IsValid( ent ) ) then return end
	ent:SetModel( model_file )
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 60 ) )
	ent:SetAngles( self.Owner:EyeAngles() )
	ent:Health(500)
	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if ( !IsValid( phys ) ) then ent:Remove() return end

	--freeze
	local l = ent:GetPhysicsObject()
    if l:IsValid() then
        l:EnableMotion(false)
		l:Sleep(false) 
	end
	
	self.Owner:SetToken( self.Owner:GetToken() -1)
	end
end


if (CLIENT) then
function openPropMenu( ply, cmd, args )
	//create main frame
    frame = vgui.Create( "DFrame" )
	frame:SetSize(400, 300)
	frame:Center()
	frame:SetTitle("Prop Menu")
	frame:SetDraggable(true)
	frame:SetSizable(false)
	frame:ShowCloseButton(true)
	frame:MakePopup()
	frame.Paint = function(self, w, h) draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0, 175 ) ) end
	
	//create Panel
	prop_1 = vgui.Create("DButton", frame)
	local border = 5
	prop_1:SetParent( frame )  
	prop_1:SetPos( 60+border, 60+border )
	prop_1:SetSize(100,50)
	prop_1:PerformLayout() 
	prop_1:SetText("Prop1")
	prop_1.DoClick = function()
	--self:GiveBlock( "models/hunter/blocks/cube05x05x05.mdl" )
	frame:Close()
	end
	prop_2 = vgui.Create("DButton", frame)
	prop_2:SetParent( frame )  
	prop_2:SetPos( 180+border, 60+border )
	prop_2:SetSize(100,50)
	prop_2:PerformLayout() 
	prop_2:SetText("Prop2")
	end
	
concommand.Add("gt_propmenu", openPropMenu )
end