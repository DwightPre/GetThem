include( 'shared.lua' )


-- Clientside only stuff goes here

function killcounter()  
draw.WordBox( 6, ScrW() - ScrW() + 30, ScrH() - 215 , "" .. LocalPlayer():GetNWInt("killcounter") .. " kills","DermaLarge",Color(200,0,0,0),Color(255,255,255,255))

if(GetGlobalInt("NPCteam1") ~= null) then
draw.WordBox( 6, ScrW() * 0.507, ScrH() * 0.06, "Blue[ ".. GetGlobalInt("NPCteam1") .. " ]","DermaLarge",Color(200,200,200,50),Color(0,0,255,255))
else
draw.WordBox( 6, ScrW() * 0.507, ScrH() * 0.06, "Blue[ ".. 0 .. " ]","DermaLarge",Color(200,200,200,50),Color(0,0,255,255))
end

if(GetGlobalInt("NPCteam2") ~= null) then
draw.WordBox( 6, ScrW() * 0.44, ScrH() * 0.06, "Red[ ".. GetGlobalInt("NPCteam2") .. " ]","DermaLarge",Color(200,200,200,50),Color(255,0,0,255))
else
draw.WordBox( 6, ScrW() * 0.44, ScrH() * 0.06, "Red[ ".. 0 .. " ]","DermaLarge",Color(200,200,200,50),Color(255,0,0,255))  
end

draw.WordBox( 6, ScrW() * 0.44, ScrH() * 0.01, "Round Time: ".. GetGlobalInt("roundTimer") ,"DermaLarge",Color(200,0,0,255),Color(255,255,255,255))
draw.WordBox( 6, ScrW() - ScrW() + 30 , ScrH() - 275 , "" .. LocalPlayer():Frags() .. " spawned","DermaLarge",Color(200,0,0,0),Color(255,255,255,255))
 
  end
hook.Add("HUDPaint","KillCounter",killcounter) 

function RoundedBoxHook()
draw.RoundedBox( 6, 30, ScrH()-160, 220, 50, Color(5, 10, 10, 100) );
draw.RoundedBox( 6, 30, ScrH()-220, 220, 50, Color(5, 10, 10, 100) );
draw.RoundedBox( 6, 30, ScrH()-280, 220, 50, Color(5, 10, 10, 100) );


--surface.SetTexture(surface.GetTextureID("icon16/user.png"))
--surface.DrawTexturedRect(ScrW() * 0.5, ScrH() * 0.1,16,16)


end
hook.Add("HUDPaint", "RoundedBoxHud", RoundedBoxHook)


local meta = FindMetaTable("Player")

function meta:GetXp()
	return self:GetNetworkedInt( "Xp" )
end


function hud()
local xp = tostring(LocalPlayer():GetXp())

draw.SimpleText("$ " .. xp .. "", "DermaLarge", 40, ScrH() - 90 - 60, Color(255,0,0,255))

end 

hook.Add("HUDPaint", "XPHUD", hud)

 
local function RecvMyUmsg( data )

print( "Team1 (Blue): "..data:ReadString());
 
end

 local function RecvMyUmsg2( data2 )
 
print( "Team2 (Red): "..data2:ReadString() );
 
end

 local function RecvMyUmsg3( data3 )
 
--print( "roundTimer" ..data3:ReadString() );
 
end



usermessage.Hook( "RoundTimer", RecvMyUmsg3 );
usermessage.Hook( "TEAMTWO", RecvMyUmsg2 );
usermessage.Hook( "TEAMONE", RecvMyUmsg );
 
 --Selfmade weaponshop! :)

function WeaponSelectorDerma()

local WeaponFrame = vgui.Create("DFrame")
WeaponFrame:SetSize(520, 400)
WeaponFrame:Center()
WeaponFrame:SetTitle("Shop")
WeaponFrame:SetDraggable(true)
WeaponFrame:SetSizable(false)
WeaponFrame:ShowCloseButton(true)
WeaponFrame:MakePopup()

--WeaponFrame:AddSheet( "Guns", WeaponFrame, "gui/silkicons/user", false, false, "Guns/Ammo" )

local sheet = vgui.Create( "DPropertySheet", WeaponFrame )
sheet:Dock( FILL )

local weaponsTab = vgui.Create( "DPanel", sheet )
weaponsTab.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 128, 255 ) ) end
sheet:AddSheet( "Weapons", weaponsTab, "icon16/lightning.png" )

local ammoTab = vgui.Create( "DPanel", sheet )
ammoTab.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 255, 128, 0 ) ) end
sheet:AddSheet( "Ammo", ammoTab, "icon16/package_add.png" )

local SpecialsTab = vgui.Create( "DPanel", sheet )
SpecialsTab.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 255, 128 ) ) end
sheet:AddSheet( "Abilities", SpecialsTab, "icon16/star.png" )

local ModelTab = vgui.Create( "DPanel", sheet )
ModelTab.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 231, 66, 35 ) ) end
sheet:AddSheet( "Player Model", ModelTab, "icon16/user_orange.png" )

local EntitiesTab = vgui.Create( "DPanel", sheet )
EntitiesTab.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 231, 66, 35 ) ) end
sheet:AddSheet( "Entities", EntitiesTab, "icon16/user_orange.png" )

local PistolButton = vgui.Create("DButton", weaponsTab)
PistolButton:SetSize(100, 30)
PistolButton:SetPos(10, 35)
PistolButton:SetText("Pistol (800)")
PistolButton.DoClick = function() RunConsoleCommand("weapon_take", "pistol") WeaponFrame:Close() end --make it run our "weapon_take" console command with "pistol" as the 1st argument and then close the menu

local SMGButton = vgui.Create("DButton", weaponsTab)
SMGButton:SetSize(100, 30)
SMGButton:SetPos(140, 35)
SMGButton:SetText("SMG (1.000)")
SMGButton.DoClick = function() RunConsoleCommand("weapon_take", "smg") WeaponFrame:Close() end

local CRSBButton = vgui.Create("DButton", weaponsTab)
CRSBButton:SetSize(100, 30)
CRSBButton:SetPos(270, 35)
CRSBButton:SetText("Crossbow (1.000)")
CRSBButton.DoClick = function() RunConsoleCommand("weapon_take", "crossbow") WeaponFrame:Close() end

local ShotButton = vgui.Create("DButton", weaponsTab)
ShotButton:SetSize(100, 30)
ShotButton:SetPos(400, 35)

ShotButton:SetText("Shotgun (1.000)")
ShotButton.DoClick = function() RunConsoleCommand("weapon_take", "shotgun") WeaponFrame:Close() end

local ARButton = vgui.Create("DButton", weaponsTab)
ARButton:SetSize(100, 30)
ARButton:SetPos(10, 70)
ARButton:SetText("AR2(1.000)")
ARButton.DoClick = function() RunConsoleCommand("weapon_take", "ar2") WeaponFrame:Close() end

local FragButton = vgui.Create("DButton", weaponsTab)
FragButton:SetSize(100, 30)
FragButton:SetPos(140, 70)
FragButton:SetText("Frag(500)")
FragButton.DoClick = function() RunConsoleCommand("weapon_take", "frag") WeaponFrame:Close() end

local AlyxButton = vgui.Create("DButton", weaponsTab)
AlyxButton:SetSize(100, 30)
AlyxButton:SetPos(270, 70)
AlyxButton:SetText("Alyxgun(1200)")
AlyxButton.DoClick = function() RunConsoleCommand("weapon_take", "Alyxgun") WeaponFrame:Close() end

-------------------------------------------------------------------
local PistolAmmoButton = vgui.Create("DButton", ammoTab)
PistolAmmoButton:SetSize(100, 30)
PistolAmmoButton:SetPos(10, 35)
PistolAmmoButton:SetText("Pistol Ammo (200)")
PistolAmmoButton:SetTextColor( Color( 255, 0, 0, 255 ) )
PistolAmmoButton.DoClick = function() RunConsoleCommand("weapon_take", "pistolammo") WeaponFrame:Close() end

local PistolAmmoButton2 = vgui.Create("DButton", ammoTab)
PistolAmmoButton2:SetSize(100, 30)
PistolAmmoButton2:SetPos(140, 35)
PistolAmmoButton2:SetText("SMG Ammo (400)")
PistolAmmoButton2:SetTextColor( Color( 255, 0, 0, 255 ) )
PistolAmmoButton2.DoClick = function() RunConsoleCommand("weapon_take", "smgammo") WeaponFrame:Close() end

local PistolAmmoButton3 = vgui.Create("DButton", ammoTab)
PistolAmmoButton3:SetSize(100, 30)
PistolAmmoButton3:SetPos(270, 35)
PistolAmmoButton3:SetText("Crossbow Ammo (400)")
PistolAmmoButton3:SetTextColor( Color( 255, 0, 0, 255 ) )
PistolAmmoButton3.DoClick = function() RunConsoleCommand("weapon_take", "blotammo") WeaponFrame:Close() end

local PistolAmmoButton4 = vgui.Create("DButton", ammoTab)
PistolAmmoButton4:SetSize(100, 30)
PistolAmmoButton4:SetPos(400, 35)
PistolAmmoButton4:SetText("Shotgun Ammo (400)")
PistolAmmoButton4:SetTextColor( Color( 255, 0, 0, 255 ) )
PistolAmmoButton4.DoClick = function() RunConsoleCommand("weapon_take", "shotgunammo") WeaponFrame:Close() end

local PistolAmmoButton5 = vgui.Create("DButton", ammoTab)
PistolAmmoButton5:SetSize(100, 30)
PistolAmmoButton5:SetPos(10, 70)
PistolAmmoButton5:SetText("AR2 Ammo (400)")
PistolAmmoButton5:SetTextColor( Color( 255, 0, 0, 255 ) )
PistolAmmoButton5.DoClick = function() RunConsoleCommand("weapon_take", "AR2ammo") WeaponFrame:Close() end

local PistolAmmoButton6 = vgui.Create("DButton", ammoTab)
PistolAmmoButton6:SetSize(100, 30)
PistolAmmoButton6:SetPos(140, 70)
PistolAmmoButton6:SetText("Alyxgun ammo(100)")
PistolAmmoButton6:SetTextColor( Color( 255, 0, 0, 255 ) )
PistolAmmoButton6.DoClick = function() RunConsoleCommand("weapon_take", "Alyxgunammo") WeaponFrame:Close() end
-------------------------------------------------------------------------------
local FlashlightButton = vgui.Create("DButton", SpecialsTab)
FlashlightButton:SetSize(100, 30)
FlashlightButton:SetPos(10, 35)
FlashlightButton:SetText("flashlight(100)")
FlashlightButton:SetTextColor( Color( 0, 0, 255, 255 ) )
FlashlightButton.DoClick = function() RunConsoleCommand("weapon_take", "flashlight") WeaponFrame:Close() end

local HPButton = vgui.Create("DButton", SpecialsTab)
HPButton:SetSize(100, 30)
HPButton:SetPos(140, 35)
HPButton:SetText("150HP(300)")
HPButton:SetTextColor( Color( 0, 0, 255, 255 ) )
HPButton.DoClick = function() RunConsoleCommand("weapon_take", "HP") WeaponFrame:Close() end

local ArmorButton = vgui.Create("DButton", SpecialsTab)
ArmorButton:SetSize(100, 30)
ArmorButton:SetPos(270, 35)
ArmorButton:SetText("Armor (500)")
ArmorButton:SetTextColor( Color( 0, 0, 255, 255 ) )
ArmorButton.DoClick = function() RunConsoleCommand("weapon_take", "armor") WeaponFrame:Close() end

local SprintButton = vgui.Create("DButton", SpecialsTab)
SprintButton:SetSize(100, 30)
SprintButton:SetPos(400, 35)
SprintButton:SetText("Sprint (500)")
SprintButton:SetTextColor( Color( 0, 0, 255, 255 ) )
SprintButton.DoClick = function() RunConsoleCommand("weapon_take", "sprint") WeaponFrame:Close() end
-------------------------------------------------------------

local Model1Button = vgui.Create("DButton", ModelTab)
Model1Button:SetSize(100, 30)
Model1Button:SetPos(10, 35)
Model1Button:SetText("Gman (200)")
Model1Button:SetTextColor( Color( 0, 0, 255, 255 ) )
Model1Button.DoClick = function() RunConsoleCommand("weapon_take", "gman") WeaponFrame:Hide() end

local Model2Button = vgui.Create("DButton", ModelTab)
Model2Button:SetSize(100, 30)
Model2Button:SetPos(140, 35)
Model2Button:SetText("Cop (200)")
Model2Button:SetTextColor( Color( 0, 0, 255, 255 ) )
Model2Button.DoClick = function() RunConsoleCommand("weapon_take", "cop") WeaponFrame:Close() end

local Model3Button = vgui.Create("DButton", ModelTab)
Model3Button:SetSize(100, 30)
Model3Button:SetPos(270, 35)
Model3Button:SetText("Skeleton (200)")
Model3Button:SetTextColor( Color( 0, 0, 255, 255 ) )
Model3Button.DoClick = function() RunConsoleCommand("weapon_take", "skeleton") WeaponFrame:Close() end

local Model4Button = vgui.Create("DButton", ModelTab)
Model4Button:SetSize(100, 30)
Model4Button:SetPos(400, 35)
Model4Button:SetText("Phoenix (200)")
Model4Button:SetTextColor( Color( 0, 0, 255, 255 ) )
Model4Button.DoClick = function() RunConsoleCommand("weapon_take", "phoenix") WeaponFrame:Close() end

local Model5Button = vgui.Create("DButton", ModelTab)
Model5Button:SetSize(100, 30)
Model5Button:SetPos(10, 70)
Model5Button:SetText("Zombie (200)")
Model5Button:SetTextColor( Color( 0, 0, 255, 255 ) )
Model5Button.DoClick = function() RunConsoleCommand("weapon_take", "zombie") WeaponFrame:Close() end

local EntityButton = vgui.Create("DButton", EntitiesTab)
EntityButton:SetSize(100, 30)
EntityButton:SetPos(10, 70)
EntityButton:SetText("Bla (200)")
EntityButton:SetTextColor( Color( 0, 0, 255, 255 ) )
EntityButton.DoClick = function() RunConsoleCommand("weapon_take", "zombie") WeaponFrame:Close() end

-- |||||||||||||||||||||||||||||

local PrevPanel = vgui.Create( "DPanel" , WeaponFrame )
PrevPanel:SetPos( 300, 180 )
PrevPanel:SetSize( 200, 200 )

			PistolButton.OnCursorEntered = function()
				local icon = vgui.Create( "DModelPanel", PrevPanel )
					icon:SetModel( "models/weapons/w_Pistol.mdl" )
					icon:SetSize( 1000, 1000 )
					icon:SetCamPos(Vector (0, 100, 50))
					icon:SetLookAt( Vector( 0, 0, 0 ) )
					icon:Center()
					function icon:LayoutEntity( Entity ) return end
				end

			SMGButton.OnCursorEntered = function()
			local icon = vgui.Create( "DModelPanel", PrevPanel )
				icon:SetModel( "models/weapons/w_smg1.mdl" )
				icon:SetSize( 1000, 1000 )
				icon:SetCamPos(Vector (0, 100, 50))
				icon:SetLookAt( Vector( 0, 0, 0 ) )
				icon:Center()
				function icon:LayoutEntity( Entity ) return end
			end

			CRSBButton.OnCursorEntered = function()
			local icon = vgui.Create( "DModelPanel", PrevPanel )
				icon:SetModel( "models/weapons/w_crossbow.mdl" )
				icon:SetSize( 600, 600 )
				icon:SetCamPos(Vector (0, 100, 50))
				icon:SetLookAt( Vector( 0, 0, 0 ) )
				icon:Center()
				function icon:LayoutEntity( Entity ) return end
			end

			ShotButton.OnCursorEntered = function()
			local icon = vgui.Create( "DModelPanel", PrevPanel )
				icon:SetModel( "models/weapons/w_shotgun.mdl" )
				icon:SetSize( 1000, 1000 )
				icon:SetCamPos(Vector (0, 100, 50))
				icon:SetLookAt( Vector( 0, 0, 0 ) )
				icon:Center()
				function icon:LayoutEntity( Entity ) return end
			end

			ARButton.OnCursorEntered = function()
			local icon = vgui.Create( "DModelPanel", PrevPanel )
				icon:SetModel( "models/weapons/w_IRifle.mdl" )
				icon:SetSize( 600, 600 )
				icon:SetCamPos(Vector (0, 100, 50))
				icon:SetLookAt( Vector( 0, 0, 0 ) )
				icon:Center()
				function icon:LayoutEntity( Entity ) return end
			end

			FragButton.OnCursorEntered = function()
			local icon = vgui.Create( "DModelPanel", PrevPanel )
				icon:SetModel( "models/weapons/w_eq_fraggrenade_thrown.mdl" )
				icon:SetSize( 1000, 1000 )
				icon:SetCamPos(Vector (0, 100, 50))
				icon:SetLookAt( Vector( 0, 0, 0 ) )
				icon:Center()
				function icon:LayoutEntity( Entity ) return end
			end

			AlyxButton.OnCursorEntered = function()
			local icon = vgui.Create( "DModelPanel", PrevPanel )
				icon:SetModel( "models/weapons/w_Pistol.mdl" )
				icon:SetSize( 1000, 1000 )
				icon:SetCamPos(Vector (0, 100, 50))
				icon:SetLookAt( Vector( 0, 0, 0 ) )
				icon:Center()
				function icon:LayoutEntity( Entity ) return end
			end

			PistolAmmoButton.OnCursorEntered = function()
			local icon = vgui.Create( "DModelPanel", PrevPanel )
				icon:SetModel( "models/Items/357ammobox.mdl" )
				icon:SetSize( 1000, 1000 )
				icon:SetLookAt( Vector( 0, 0, 0 ) )
				icon:Center()
				function icon:LayoutEntity( Entity ) return end
			end

			PistolAmmoButton2.OnCursorEntered = function()
			local icon = vgui.Create( "DModelPanel", PrevPanel )
				icon:SetModel( "models/Items/357ammobox.mdl" )
				icon:SetSize( 1000, 1000 )
				icon:SetLookAt( Vector( 0, 0, 0 ) )
				icon:Center()
				function icon:LayoutEntity( Entity ) return end
			end

			PistolAmmoButton3.OnCursorEntered = function()
			local icon = vgui.Create( "DModelPanel", PrevPanel )
				icon:SetModel( "models/Items/357ammobox.mdl" )
				icon:SetSize( 1000, 1000 )
				icon:SetLookAt( Vector( 0, 0, 0 ) )
				icon:Center()
				function icon:LayoutEntity( Entity ) return end
			end

			PistolAmmoButton4.OnCursorEntered = function()
			local icon = vgui.Create( "DModelPanel", PrevPanel )
				icon:SetModel( "models/Items/357ammobox.mdl" )
				icon:SetSize( 1000, 1000 )
				icon:SetLookAt( Vector( 0, 0, 0 ) )
				icon:Center()
				function icon:LayoutEntity( Entity ) return end
			end

			PistolAmmoButton5.OnCursorEntered = function()
			local icon = vgui.Create( "DModelPanel", PrevPanel )
				icon:SetModel( "models/Items/357ammobox.mdl" )
				icon:SetSize( 1000, 1000 )
				icon:SetLookAt( Vector( 0, 0, 0 ) )
				icon:Center()
				function icon:LayoutEntity( Entity ) return end
			end

			PistolAmmoButton6.OnCursorEntered = function()
			local icon = vgui.Create( "DModelPanel", PrevPanel )
				icon:SetModel( "models/Items/357ammobox.mdl" )
				icon:SetSize( 1000, 1000 )
				icon:SetLookAt( Vector( 0, 0, 0 ) )
				icon:Center()
				function icon:LayoutEntity( Entity ) return end
			end

			HPButton.OnCursorEntered = function()
			local icon = vgui.Create( "DModelPanel", PrevPanel )
				icon:SetModel( "models/Items/HealthKit.mdl" )
				icon:SetSize( 1000, 1000 )
				icon:SetCamPos(Vector (50, 50, 120))
				icon:SetLookAt( Vector( 0, 0, 0 ) )
				icon:Center()
				function icon:LayoutEntity( Entity ) return end
			end

			ArmorButton.OnCursorEntered = function()
			local icon = vgui.Create( "DModelPanel", PrevPanel )
				icon:SetModel( "models/Items/HealthKit.mdl" )
				icon:SetSize( 1000, 1000 )
				icon:SetCamPos(Vector (50, 50, 120))
				icon:SetLookAt( Vector( 0, 0, 0 ) )
				icon:Center()
				function icon:LayoutEntity( Entity ) return end
			end

			Model1Button.OnCursorEntered = function()
			local icon = vgui.Create( "DModelPanel", PrevPanel )
				icon:SetModel( "models/player/gman_high.mdl" )
				icon:SetPos( -50, -50 )
				icon:SetSize( 300, 300 )
			end

			Model2Button.OnCursorEntered = function()
			local icon = vgui.Create( "DModelPanel", PrevPanel )
				icon:SetModel( "models/player/police.mdl" )
				icon:SetPos( -50, -50 )
				icon:SetSize( 300, 300 )
			end

			Model3Button.OnCursorEntered = function()
			local icon = vgui.Create( "DModelPanel", PrevPanel )
				icon:SetParent( PrevPanel )
				icon:SetPos( -50, -50 )
				icon:SetSize( 300, 300 )
				icon:SetModel( "models/player/skeleton.mdl" )
			end

			Model4Button.OnCursorEntered = function()
			local icon = vgui.Create( "DModelPanel", PrevPanel )
				icon:SetParent( PrevPanel )
				icon:SetPos( -50, -50 )
				icon:SetSize( 300, 300 )
				icon:SetModel( "models/player/phoenix.mdl" )
			end

			Model5Button.OnCursorEntered = function()
			local icon = vgui.Create( "DModelPanel", PrevPanel )
				icon:SetParent( PrevPanel )
				icon:SetPos( -50, -50 )
				icon:SetSize( 300, 300 )
				icon:SetModel( "models/player/zombie_classic.mdl" )
			end

			EntityButton.OnCursorEntered = function()
				local icon = vgui.Create( "DModelPanel", PrevPanel )
				icon:SetParent( PrevPanel )
				icon:SetPos( -50, -50 )
				icon:SetSize( 300, 300 )
				icon:SetModel( "models/player/phoenix.mdl" )
			end

		PistolButton.OnCursorExited = function()
		PrevPanel:Clear()
		end
		SMGButton.OnCursorExited = function()
		PrevPanel:Clear()
		end
		CRSBButton.OnCursorExited = function()
		PrevPanel:Clear()
		end
		ShotButton.OnCursorExited = function()
		PrevPanel:Clear()
		end
		ARButton.OnCursorExited = function()
		PrevPanel:Clear()
		end
		FragButton.OnCursorExited = function()
		PrevPanel:Clear()
		end
		AlyxButton.OnCursorExited = function()
		PrevPanel:Clear()
		end
		PistolAmmoButton.OnCursorExited = function()
		PrevPanel:Clear()
		end
		PistolAmmoButton2.OnCursorExited = function()
		PrevPanel:Clear()
		end
		PistolAmmoButton3.OnCursorExited = function()
		PrevPanel:Clear()
		end
		PistolAmmoButton4.OnCursorExited = function()
		PrevPanel:Clear()
		end
		PistolAmmoButton5.OnCursorExited = function()
		PrevPanel:Clear()
		end
		PistolAmmoButton6.OnCursorExited = function()
		PrevPanel:Clear()
		end
		HPButton.OnCursorExited = function()
		PrevPanel:Clear()
		end
		ArmorButton.OnCursorExited = function()
		PrevPanel:Clear()
		end
		Model1Button.OnCursorExited = function()
		PrevPanel:Clear()
		end
		Model2Button.OnCursorExited = function()
		PrevPanel:Clear()
		end
		Model3Button.OnCursorExited = function()
		PrevPanel:Clear()
		end
		Model4Button.OnCursorExited = function()
		PrevPanel:Clear()
		end
		Model5Button.OnCursorExited = function()
		PrevPanel:Clear()
		end
		EntityButton.OnCursorExited = function()
			PrevPanel:Clear()
		end


			end
			
concommand.Add("shop", WeaponSelectorDerma)
			 
/////////////////////////////////////////////
////////////////////SCOREBORD////////////////
/////////////////////////////////////////////

if CLIENT then
    local Scoreboard_Roundness = 8
	--local Scoreboard_Color = Color(team.GetColor( LocalPlayer():Team() ))
	
	local Scoreboard_Color = Color(25, 255, 255, 1)
	local Scoreboard_XGap = 6
	local Scoreboard_YGap = 6
	local Scoreboard_TitleToNamesGap = 4

	local Title_Height = 12
	local Title_Color = Color(0, 0, 0, 255)
	local Title_Font = "ScoreboardTitleFont"
	local Title_Text = "GetThem"
	local Title_BackgroundRoundness = 4
	local Title_BackgroundColor = Color(85, 243, 36, 200)
	
	--
	
	local Players_Spacing = 4
	local Players_EdgeGap = 4
	local Players_BackgroundRoundness = 4
	local Players_BackgroundColor = Color(25, 250, 250, 150)

	local PlayerBar_Height = 24
	local PlayerBar_Color = Color(0, 0, 0, 255)
	
    --function PlyColor( ply, Team )
    --      local Colour = team.GetColor(ply:Team()) or Color(0,0,0)
    --     -- chat.AddText(Color(255,255,255),"(CHAT) ",Colour,ply:Nick(),Color(255,255,255),": "..strText)
		--  --local Title_BackgroundColor = Color(Colour)
		--  local Scoreboard_Color = Color(Colour)
    --end

	local PlayerBar_Font = "ScoreboardPlayersFont"
	local PlayerBar_BackgroundRoundness = 4
	local PlayerBar_BackgroundColor = Color(25, 250, 250, 150)

	local InfoBar_Height = 32
	local InfoBar_Color = Color(0, 0, 0, 255)
	local InfoBar_Font = "ScoreboardInfoFont"
	local InfoBar_BackgroundRoundness = 4
	local InfoBar_BackgroundColor = Color(85, 243, 36, 200)

	local 	Columns = {}
			Columns[1] = {name="Name", command=function(self, arg) return tostring(arg:Name()) end}
			Columns[2] = {name="Team", command=function(self, arg) return tostring(arg:Team()) end}
			Columns[3] = {name="Humans", command=function(self, arg) return tostring(arg:Frags()) end}

	surface.CreateFont("ScoreboardTitleFont", {
		font		= "CloseCaption_Normal",
		size		= 42,
		weight		= 1000,
		antialias 	= true
	})

	surface.CreateFont("ScoreboardInfoFont", {
		font		= "CloseCaption_Normal",
		size		= 28,
		weight		= 1000,
		antialias 	= true
	})

	surface.CreateFont("ScoreboardPlayersFont", {
		font		= "CloseCaption_Normal",
		size		= 18,
		weight		= 500,
		antialias 	= true
	})

----------LAUNCH SEQUENCE----------
	local CreateScoreboard = function()
		Scoreboard = vgui.Create("DFrame")
		Scoreboard:SetSize(ScrW()*.75, ScrH()*.75)
		Scoreboard:SetPos((ScrW()*.25)*.5, (ScrH()*.25)*.5)
		Scoreboard:SetTitle("")
		Scoreboard:SetDraggable(false)
		Scoreboard:ShowCloseButton(false)
		Scoreboard.Open = function(self)
			Scoreboard:SetVisible(true)
		end
		Scoreboard.Close = function(self)
			Scoreboard:SetVisible(false)
		end
		Scoreboard.Paint = function(self) 
			draw.RoundedBox(Scoreboard_Roundness, 0, 0, self:GetWide(), self:GetTall(), Scoreboard_Color)
		end
		 
		Scoreboard.TitlePanel = vgui.Create("DPanel")
		Scoreboard.TitlePanel:SetParent(Scoreboard)
		Scoreboard.TitlePanel:SetPos(Scoreboard_XGap, Scoreboard_YGap)
		surface.SetFont(Title_Font)
		local w, h = surface.GetTextSize(Title_Text)
		local Height = h+(Title_Height*2)
		Scoreboard.TitlePanel:SetSize(Scoreboard:GetWide()-(Scoreboard_XGap*2), Height)
		Scoreboard.TitlePanel.Paint = function(self)
			draw.RoundedBox(Title_BackgroundRoundness, 0, 0, self:GetWide(), self:GetTall(), Title_BackgroundColor)
			surface.SetFont(Title_Font)
			surface.SetTextColor(Title_Color.r, Title_Color.g, Title_Color.b, Title_Color.a)
			--surface.SetTextColor(team.GetColor( LocalPlayer():Team() ))
			
			surface.SetTextPos(self:GetWide()*.5-(w*.5), self:GetTall()*.5-(h*.5))
			surface.DrawText(Title_Text)
		end

		local Column_Width = Scoreboard:GetWide()-(Scoreboard_XGap*2)
		local ColumnGap_Width = (Column_Width/#Columns)
		local ColumnGap_Half = ColumnGap_Width*.5

		Scoreboard.NamesListPanel = vgui.Create("DPanelList")
		Scoreboard.NamesListPanel.PlayerBars = {}
		Scoreboard.NamesListPanel.NextRefresh = CurTime()+3
		Scoreboard.NamesListPanel:SetParent(Scoreboard)
		Scoreboard.NamesListPanel:SetPos(Scoreboard_XGap, Scoreboard_YGap+Scoreboard.TitlePanel:GetTall()+Scoreboard_TitleToNamesGap+InfoBar_Height)
		Scoreboard.NamesListPanel:SetSize(Scoreboard:GetWide()-(Scoreboard_XGap*2), Scoreboard:GetTall()-(Scoreboard.TitlePanel:GetTall())-(Scoreboard_YGap*2)-(Scoreboard_TitleToNamesGap)-InfoBar_Height)
		Scoreboard.NamesListPanel:SetSpacing(Players_Spacing)
		Scoreboard.NamesListPanel:SetPadding(Players_EdgeGap)
		Scoreboard.NamesListPanel:EnableHorizontal(false)
		Scoreboard.NamesListPanel:EnableVerticalScrollbar(true)
		Scoreboard.NamesListPanel.Refill = function(self)
			self:Clear()

			for k, pl in pairs(player.GetAll()) do
				local ID = tostring(pl:SteamID())
				self.PlayerBars[ID] = vgui.Create("DPanel")
				self.PlayerBars[ID]:SetPos(0, 0)
				self.PlayerBars[ID]:SetSize(Scoreboard.NamesListPanel:GetWide()-(Players_Spacing*2), PlayerBar_Height)
				self.PlayerBars[ID].Paint = function(self)
					draw.RoundedBox(PlayerBar_BackgroundRoundness, 0, 0, self:GetWide(), self:GetTall(), PlayerBar_BackgroundColor)

					surface.SetFont(PlayerBar_Font)
					surface.SetTextColor(PlayerBar_Color.r, PlayerBar_Color.g, PlayerBar_Color.b, PlayerBar_Color.a)
					for k, v in pairs(Columns) do
						local w, h = surface.GetTextSize(v:command(pl))
						if k==1 then
							surface.SetTextPos((ColumnGap_Half*k)-(w*.5), self:GetTall()*.5-(h*.5))
						else
							surface.SetTextPos((ColumnGap_Width*(k-1))+(ColumnGap_Half)-(w*.5), self:GetTall()*.5-(h*.5))
						end
						surface.DrawText(v:command(pl))
					end
				end

				self:AddItem(self.PlayerBars[ID])
			end
		end
		Scoreboard.NamesListPanel.Think = function(self)
			if self:IsVisible() then
				if Scoreboard.NamesListPanel.NextRefresh < CurTime() then
					Scoreboard.NamesListPanel.NextRefresh = CurTime()+3
					Scoreboard.NamesListPanel:Refill()
				end
			end
		end
		Scoreboard.NamesListPanel.Paint = function(self)
			draw.RoundedBox(Players_BackgroundRoundness, 0, 0, self:GetWide(), self:GetTall(), Players_BackgroundColor)
		end

		Scoreboard.InfoBar = vgui.Create("DPanel")
		Scoreboard.InfoBar:SetParent(Scoreboard)
		Scoreboard.InfoBar:SetPos(Scoreboard_XGap, Scoreboard_YGap+Scoreboard.TitlePanel:GetTall()+Scoreboard_TitleToNamesGap)
		Scoreboard.InfoBar:SetSize(Scoreboard:GetWide()-(Scoreboard_XGap*2), InfoBar_Height)
		Scoreboard.InfoBar.Paint = function(self)
			draw.RoundedBox(InfoBar_BackgroundRoundness, 0, 0, self:GetWide(), self:GetTall(), InfoBar_BackgroundColor)
			surface.SetFont(InfoBar_Font)
			surface.SetTextColor(InfoBar_Color.r, InfoBar_Color.g, InfoBar_Color.b, InfoBar_Color.a)
			for k, v in pairs(Columns) do
				local w, h = surface.GetTextSize(v.name)
				if k==1 then
					surface.SetTextPos((ColumnGap_Half*k)-(w*.5), self:GetTall()*.5-(h*.5))
				else
					surface.SetTextPos((ColumnGap_Width*(k-1))+(ColumnGap_Half)-(w*.5), self:GetTall()*.5-(h*.5))
				end
				surface.DrawText(v.name)
			end
		end

		Scoreboard.NamesListPanel:Refill()
	end


----------Hooks----------
	function ScoreboardOpened()
		if !ValidPanel(Scoreboard) then
			CreateScoreboard()
		end

		Scoreboard:Open()
		gui.EnableScreenClicker(true)
		return true
	end
	hook.Add("ScoreboardShow", "Open scoreboard.", ScoreboardOpened)

	function ScoreboardClosed()
		if !ValidPanel(Scoreboard) then
			CreateScoreboard()
		end

		gui.EnableScreenClicker(false)
		Scoreboard:Close()
		return true
	end
	hook.Add("ScoreboardHide", "Close scoreboard.", ScoreboardClosed)
end
