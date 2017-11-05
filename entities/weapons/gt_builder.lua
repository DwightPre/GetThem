
AddCSLuaFile()

if (SERVER) then
        SWEP.Weight                     = 5
        SWEP.AutoSwitchTo               = false
        SWEP.AutoSwitchFrom             = false
end

if ( CLIENT ) then
		SWEP.PrintName				    = "GT Builder"
		SWEP.Instructions 				= "Mouse 2 to place prop"

        SWEP.DrawAmmo                   = false
        SWEP.DrawWeaponInfoBox          = false     
        SWEP.BounceWeaponIcon           = false    
        SWEP.SwayScale                  = 1.0         
        SWEP.BobScale                   = 1.0          
   --   SWEP.WepSelectIcon              = surface.GetTextureID( "weapons/swep" )
        SWEP.ViewModelFOV               = 75
        SWEP.ViewModelFlip              = false
end

SWEP.Category                 		    = "Builder Weapon"

SWEP.Author                             = "Dwight-Pre"
SWEP.Contact                            = ""
SWEP.Purpose						    = "Spawns Base Props"

SWEP.Spawnable                          = false
SWEP.AdminSpawnable                     = false

SWEP.Slot = 5
SWEP.SlotPos = 1

SWEP.ViewModel = Model(  "models/weapons/v_crowbar.mdl" )
SWEP.WorldModel = Model( "models/hunter/blocks/cube05x05x05.mdl" )

SWEP.TracerType                         = "Tracer"

SWEP.InfiniteAmmo                       = true
SWEP.UseScope                           = false
SWEP.WeaponDeploySpeed                  = 1

SWEP.Primary.ClipSize                   = -1
SWEP.Primary.DefaultClip                = -1
//SWEP.Primary.Automatic                = false
SWEP.Primary.Ammo                       = "none"

SWEP.Secondary.ClipSize                 = -1
SWEP.Secondary.DefaultClip              = -1
SWEP.Secondary.Automatic                = false
SWEP.Secondary.Ammo       			    = "none"
			  
function SWEP:Reload()
            
end

function SWEP:Initialize()

end

/* --Prop Selection Menu
function SWEP:Reload()
if CurTime() < delay then return end
RunConsoleCommand("gt_propmenu");
delay = CurTime() + 0.7
end */

function SWEP:Think()
end

if (SERVER) then

function SWEP:SecondaryAttack()
--self:SetBlock( "models/props_interiors/Furniture_shelf01a.mdl")
--self:SetBlock( "models/hunter/blocks/cube1x1x1.mdl")
--self:SetBlock( "models/hunter/blocks/cube05x05x05.mdl")
--self:SetBlock( "models/hunter/blocks/cube075x2x1.mdl")
self:SetBlock( "models/hunter/blocks/cube075x075x075.mdl")
end

function SWEP:PrimaryAttack()
--self:SetBlock( "models/hunter/blocks/cube05x05x05.mdl" )
--self:SetBlock( "models/hunter/blocks/cube05x05x05.mdl" )
end


function GiveBlock (model)
self:SetBlock( model)
end


function SWEP:SetBlock( model_file )

local tr = self.Owner:GetEyeTrace()
local SpawnPos = tr.HitPos + tr.HitNormal * 20
local xpos = math.floor( SpawnPos.x / 36.5 ) * 36.5 + 18.25
local ypos = math.floor( SpawnPos.y / 36.5 ) * 36.5 + 18.25
local zpos = math.floor( SpawnPos.z / 36.5 ) * 36.5 + 18.25
local distvec = tr.HitPos - self.Owner:GetPos()

	//get eye trace
	local zpos = 0
	local tr = self:GetOwner():GetEyeTrace()
	local startpos = self:GetOwner():GetShootPos()
	local isBlock = false
	
	local tracedata = {}
	tracedata.start = startpos
	tracedata.endpos = tr.HitPos + tr.HitNormal * 20
	tracedata.filter = self.Owner

	//check if the trace hit anything
	local checktr = util.TraceLine(tracedata)
	if checktr.HitNonWorld then
		target = checktr.Entity
		if ( target ) then 
			isBlock = true 
		end
	end
	
	local checkent = 0
	local checkvec = Vector(0,0,0)
	if tr.HitNonWorld then
		checkent = tr.Entity
		checkvec = checkent:GetPos()
	end
	
	//if no block is nearby or blocking
	if ( tr.HitWorld == true && isBlock == false)  then 
	zpos = math.floor( SpawnPos.z / 36.5 ) * 36.5 + 0
	end 
	
if ( isBlock == false && tr.HitWorld == false ) then
		
	//check: placing on top, bottom, or the four sides
	local hitz = tr.HitPos.z
	local checkvecz = checkvec.z
	local hmc = hitz - checkvecz   //hmc should be about '16' when placing on top OR on bottom (w/ propchange can be diff.)
	if (hitz < 0) then
		hitz = - hitz
	end
	if (checkvecz <0) then
		checkvecz = - checkvecz
	end
	local hmc2 = hitz - checkvecz
	if (hmc2 < 0) then
		hmc2 = - hmc2
	end
		
	// top OR bottom		
	local toporbottom = 0
	if (hmc2 > 15.9 && hmc2 < 16.1) then 
		if (hmc < 0) then
		toporbottom = 2
		end
		if (hmc > 0) then
		toporbottom = 1
		end
	end
		
		if (toporbottom == 0) then  //one of the four sides
			if (tr.HitPos.z > checkvec.z) then
				zpos = math.floor( SpawnPos.z / 36.5 ) * 36.5 + 0
				end
			if (tr.HitPos.z < checkvec.z) then
				zpos = math.floor( SpawnPos.z / 36.5 ) * 36.5 + 0//36.5
				end
		end
		
		if (toporbottom == 1) then //top
			zpos = math.floor( SpawnPos.z / 36.5 ) * 36.5 + 36.5
			if ((SpawnPos.z - zpos) < -1) then
				zpos = math.floor( SpawnPos.z / 36.5) * 36.5 + 0
			end
			end
		
		if (toporbottom == 2) then //bottom
			zpos = math.floor( SpawnPos.z / 36.5 ) * 36.5 + 0
			if ((SpawnPos.z - zpos) > 1) then
			zpos =math.floor( SpawnPos.z / 36.5 ) * 36.5 + 36.5
			end
			end		
end
		
//Spawn Code
	--if self.Owner:GetToken() > 0 then
	local ent = ents.Create( "gt_breakable_prop" )
	--local ent = ents.Create("prop_physics")
	if ( !IsValid( ent ) ) then return end
	ent:SetModel( model_file )
	ent:SetPos( Vector(xpos,ypos,zpos) )
	ent:SetMaterial("models/props_pipes/GutterMetal01a")
	--ent:SetAngles( self.Owner:EyeAngles() )
	--ent:SetHealth(400) 
	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if ( !IsValid( phys ) ) then ent:Remove() return end

//freeze
	local l = ent:GetPhysicsObject()
    if l:IsValid() then
        l:EnableMotion(false)
		l:Sleep(false) 
	end
	
	--self.Owner:SetToken( self.Owner:GetToken() -1)
	--end
end

elseif CLIENT then

function SWEP:DrawHUD()
local tr = self.Owner:GetEyeTrace()
local SpawnPos = tr.HitPos + tr.HitNormal * 20
local xpos = math.floor( SpawnPos.x / 36.5 ) * 36.5 + 18.25
local ypos = math.floor( SpawnPos.y / 36.5 ) * 36.5 + 18.25
local 				zpos = math.floor( SpawnPos.z / 36.5 ) * 36.5 + 0//36.5

	if not self.destinationModel then
		self.destinationModel = ClientsideModel("models/hunter/blocks/cube075x075x075.mdl")
		self.destinationModel:SetModel("models/hunter/blocks/cube075x075x075.mdl")
		self.destinationModel:SetColor(Color( 70, 70, 70, 200))
		self.destinationModel:SetRenderMode(RENDERMODE_TRANSALPHA)
	end
	
	self.destinationModel:SetPos(Vector(xpos,ypos,zpos))
	local textPos = self.destinationModel:GetPos():ToScreen()
	draw.DrawText( "7", "Marlett", textPos.x, textPos.y, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
end

function SWEP:OnRemove()
	if self.destinationModel then
		SafeRemoveEntity(self.destinationModel)
	end
end
end
/*
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
*/