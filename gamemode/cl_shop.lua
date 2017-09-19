--Selfmade weaponshop! :)

if SERVER then

function GivePlayerAWeapon( ply, cmd, args )
--Pistol
	if args[1] == "pistol" then
	if ply:GetXp() > 800 then
	--ply:StripWeapons()
	    ply:Give("weapon_pistol")
		ply:Give("weapon_crowbar")
		ply:ChatPrint("You got a pistol!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 800 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
	end
--SMG
	if args[1] == "smg" then --if the 1st argument is "smg" then do:
	if ply:GetXp() > 1000 then
		--ply:StripWeapons()
		ply:Give("weapon_smg1")
		ply:Give("weapon_crowbar")
		ply:ChatPrint("You got an SMG!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 1000 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end
--Crossbow
	if args[1] == "crossbow" then
	if ply:GetXp() > 1000 then
		--ply:StripWeapons()
		ply:Give("weapon_crossbow")
		ply:GiveAmmo( 10, "XBowBolt", true )
		ply:Give("weapon_crowbar")
		ply:ChatPrint("You got an crossbow!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 1000 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough X$P!")
	end
     end
--Shotgun
	if args[1] == "shotgun" then
	if ply:GetXp() > 1000 then
	--ply:StripWeapons()
		ply:Give("weapon_shotgun")
		ply:Give("weapon_crowbar")
		ply:ChatPrint("You got an shotgun!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 1000 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

--AR2
	if args[1] == "ar2" then
	if ply:GetXp() > 1000 then
	--ply:StripWeapons()
		ply:Give("weapon_ar2")
		ply:Give("weapon_crowbar")
		ply:ChatPrint("You got an AR2!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 1000 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

--Frag
	if args[1] == "frag" then
	if ply:GetXp() > 500 then
	ply:StripWeapons()
		ply:Give("weapon_frag")
		--ply:GiveAmmo( 1, "weapon_frag")
		ply:Give("weapon_crowbar")
		ply:ChatPrint("You got a frag!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 500 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

--Pistol Ammo
	if args[1] == "pistolammo" then
	if ply:GetXp() > 200 then
		ply:GiveAmmo( 200, "Pistol")
	 	ply:ChatPrint("You got pistol ammo!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 200 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

--SMG Ammo
	if args[1] == "smgammo" then
	if ply:GetXp() > 400 then
		ply:GiveAmmo(100,"smg1");
	 	ply:ChatPrint("You got SMG ammo!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 400 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

--Bolt Ammo
	if args[1] == "blotammo" then
	if ply:GetXp() > 400 then
		ply:GiveAmmo( 40, "XBowBolt")
	 	ply:ChatPrint("You got crossbow ammo!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 400 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

--Shotgun Ammo
	if args[1] == "shotgunammo" then
	if ply:GetXp() > 400 then
		ply:GiveAmmo( 40, "Buckshot")
	 	ply:ChatPrint("You got Buckshot!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 400 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

--AR2 Ammo
	if args[1] == "AR2ammo" then
	if ply:GetXp() > 400 then
		ply:GiveAmmo( 120, "AR2")
	 	ply:ChatPrint("You got AR2 ammo!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 400 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

--Alyxgun
	if args[1] == "Alyxgun" then
	if ply:GetXp() > 1200 then
		ply:Give("weapon_alyxgun")
	 	ply:ChatPrint("You got Alyxgun!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 1200 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

--alyxgun Ammo
	if args[1] == "Alyxgunammo" then
	if ply:GetXp() > 100 then
		ply:GiveAmmo( 50, "Alyxgun")
		--ply:Give("weapon_alyxgun")
	 	ply:ChatPrint("You got Alyx's gun ammo!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 100 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

-- Flashlight
	if args[1] == "flashlight" then
	if ply:GetXp() > 100 then
		ply:AllowFlashlight( true )
	 	ply:ChatPrint("You got a Flashlight!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 100 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

-- 150HP
	if args[1] == "HP" then
	if ply:GetXp() > 300 then
		ply:SetHealth( 150 )
		ply:SetMaxHealth( 150 )
	 	ply:ChatPrint("You got 150HP!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 300 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

-- Armor
	if args[1] == "armor" then
	if ply:GetXp() > 500 then
	ply:SetArmor( 100 )
	 	ply:ChatPrint("You got armor!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 500 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

-- Sprint
	if args[1] == "sprint" then
	if ply:GetXp() > 500 then
	ply:SetRunSpeed(720)
	 	ply:ChatPrint("You're 2X faster now!!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 500 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

-- Gman
	if args[1] == "gman" then
	if ply:GetXp() > 200 then
	ply:SetModel("models/player/gman_high.mdl")
	 	ply:ChatPrint("You're Gman!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 200 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

-- Cop
	if args[1] == "cop" then
	if ply:GetXp() > 200 then
	ply:SetModel("models/player/police.mdl")
	 	ply:ChatPrint("You're a cop!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 200 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

-- skeleton
	if args[1] == "skeleton" then
	if ply:GetXp() > 200 then
	ply:SetModel("models/player/skeleton.mdl")
	 	ply:ChatPrint("You're a skeleton!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 200 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

-- phoenix
	if args[1] == "phoenix" then
	if ply:GetXp() > 200 then
	ply:SetModel("models/player/phoenix.mdl")
	 	ply:ChatPrint("You're a phoenix!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 200 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end

-- zombie
	if args[1] == "zombie" then
	if ply:GetXp() > 200 then
	ply:SetModel("models/player/zombie_classic.mdl")
	 	ply:ChatPrint("You're a zombie! Aargh!")
		local current_xp = ply:GetXp()
	ply:SetXp( current_xp - 200 )
		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
	else
	ply:ChatPrint ( "Not Enough $!")
	end
     end
		 -- Guard
		 	if args[1] == "Guard" then
		 	if ply:GetXp() > 200 then

		 	local Guard1 = ents.Create("simple_nextbot")
		 	--Guard1:SetModel( "models/player/hostage/hostage_02.mdl" )
		 	--Guard1:AddEntityRelationship(player.GetByID(1), D_NU, 99 )
		 	Guard1:SetPos(ply:GetEyeTrace().HitPos)
		 	Guard1:SetHealth(200)
			Guard1:SetTeamId(ply:Team())
		 	Guard1:Spawn()
			Guard1:GiveWeapon("weapon_smg1")
		 	Guard1:SetName("Guard1")

		 	ply:ChatPrint("You got a Guard!")
		 	end
		 	local current_xp = ply:GetXp()
		 	ply:SetXp( current_xp - 200 )
		 		ply:ChatPrint( "Your $ is: " .. ply:GetXp() )
		 	else
		 	ply:ChatPrint ( "Not Enough $!")
		 	end
end

concommand.Add("weapon_take", GivePlayerAWeapon)

elseif CLIENT then

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
EntityButton:SetPos(10, 35)
EntityButton:SetText("HP Box (200)")
EntityButton:SetTextColor( Color( 0, 0, 255, 255 ) )
EntityButton.DoClick = function() RunConsoleCommand("weapon_take", "Guard") WeaponFrame:Close() end

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
				icon:SetModel( "models/Items/HealthKit.mdl" )
				icon:SetSize( 1000, 1000 )
				icon:SetCamPos(Vector (50, 50, 120))
				icon:SetLookAt( Vector( 0, 0, 0 ) )
				icon:Center()
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
end
