ActiveTab = 1

gtObject = {}

gtObject[1] = {
		"Pistol",
		800,
		"weaponsTab",
		100,
		50,
		50,
		10,
		"weapon_pistol",
		"models/weapons/w_Pistol.mdl",
		"Weapon",
}

gtObject[2] = {
	"SMG",
	1000,
	"weaponsTab",
	100,
	50,
	210,
	10,
	"weapon_smg1",
	"models/weapons/w_smg1.mdl",
	"Weapon",
}

gtObject[3] = {
	"Crossbow",
	1000,
	"weaponsTab",
	100,
	50,
	370,
	10,
	"weapon_crossbow",
	"models/weapons/w_IRifle.mdl",
	"Weapon",
}

gtObject[4] = {
	"Shotgun",
	1000,
	"weaponsTab",
	100,
	50,
	50,
	60,
	"weapon_shotgun",
	"models/weapons/w_IRifle.mdl",
	"Weapon",
}

gtObject[5] = {
	"AR",
	1000,
	"weaponsTab",
	100,
	50,
	210,
	60,
	"weapon_ar2",
	"models/weapons/w_IRifle.mdl",
	"Weapon",
}

gtObject[6] = {
	"Frag",
	500,
	"weaponsTab",
	100,
	50,
	370,
	60,
	"weapon_frag",
	"models/weapons/w_IRifle.mdl",
	"Weapon",
}

gtObject[7] = {
	"Alyxgun",
	1200,
	"weaponsTab",
	100,
	50,
	50,
	110,
	"weapon_alyxgun",
	"models/weapons/w_IRifle.mdl",
	"Weapon",
}

gtObject[8] = {
	"Pistol ammo",
	200,
	"weaponsTab",
	0,
	0,
	50,
	10,
	"",
	"models/weapons/w_IRifle.mdl",
	"Ammo",
	"Pistol",
}
gtObject[9] = {
	"SMG Ammo",
	400,
	"weaponsTab",
	0,
	0,
	210,
	10,
	"",
	"models/weapons/w_IRifle.mdl",
	"Ammo",
	"smg1",
}
gtObject[10] = {
	"Crossbow Ammo",
	400,
	"weaponsTab",
	0,
	0,
	370,
	10,
	"",
	"models/weapons/w_IRifle.mdl",
	"Ammo",
	"XBowBolt",
}
gtObject[11] = {
	"Shotgun ammo",
	400,
	"weaponsTab",
	0,
	0,
	50,
	60,
	"",
	"models/weapons/w_IRifle.mdl",
	"Ammo",
	"Buckshot"
}
gtObject[12] = {
	"AR2 ammo",
	400,
	"weaponsTab",
	0,
	0,
	210,
	60,
	"",
	"models/weapons/w_IRifle.mdl",
	"Ammo",
	"AR2",
}
gtObject[13] = {
	"Alyxgun ammo",
	400,
	"weaponsTab",
	0,
	0,
	370,
	60,
	"",
	"models/weapons/w_IRifle.mdl",
	"Ammo",
	"Alyxgun",
}
gtObject[14] = {
	"Flashlight",
	100,
	"weaponsTab",
	0,
	0,
	50,
	10,
	"",
	"models/weapons/w_IRifle.mdl",
	"Ability",
}
gtObject[15] = {
	"HP",
	300,
	"weaponsTab",
	0,
	0,
	210,
	10,
	"",
	"models/weapons/w_IRifle.mdl",
	"Ability",
}
gtObject[16] = {
	"Armor",
	400,
	"weaponsTab",
	0,
	0,
	370,
	10,
	"",
	"models/weapons/w_IRifle.mdl",
	"Ability",
}
gtObject[17] = {
	"Sprint",
	500,
	"weaponsTab",
	0,
	0,
	50,
	60,
	"",
	"models/weapons/w_IRifle.mdl",
	"Ability",
}

gtObject[18] = {
	"Gman",
	200,
	"weaponsTab",
	0,
	0,
	50,
	10,
	"",
	"models/weapons/w_IRifle.mdl",
	"Model",
}
gtObject[19] = {
	"Cop",
	200,
	"weaponsTab",
	0,
	0,
	210,
	10,
	"",
	"models/weapons/w_IRifle.mdl",
	"Model",
}
gtObject[20] = {
	"Skeleton",
	200,
	"weaponsTab",
	0,
	0,
	370,
	10,
	"",
	"models/weapons/w_IRifle.mdl",
	"Model",
}
gtObject[21] = {
	"Zombie",
	200,
	"weaponsTab",
	0,
	0,
	50,
	60,
	"",
	"models/weapons/w_IRifle.mdl",
	"Model",
}
gtObject[22] = {
	"Ammo crate",
	200,
	"weaponsTab",
	0,
	0,
	50,
	10,
	"",
	"models/weapons/w_IRifle.mdl",
	"Entity",
}
gtObject[23] = {
	"Guard",
	200,
	"weaponsTab",
	0,
	0,
	210,
	10,
	"",
	"models/weapons/w_IRifle.mdl",
	"Entity",
}
gtObject[24] = {
	"Health Kit",
	200,
	"weaponsTab",
	0,
	0,
	370,
	10,
	"",
	"models/weapons/w_IRifle.mdl",
	"Entity",
}


if SERVER then

  function GivePlayerAWeapon(ply, cmd, args)

    for key, value in pairs(gtObject) do

      if(args[1] == gtObject[key][1]) then
        local entity = gtObject[key]
				local current_xp = ply:GetXp()
				if(current_xp > entity[2]) then

					local Category = entity[10]

					if(Category == "Weapon") then
          	ply:Give(entity[8])
          	ply:ChatPrint("You got a " .. entity[1] .. "!")
          	ply:SetXp( current_xp - entity[2] )
						if(entity[1] == "Frag") then
							ply:GiveAmmo(1, "Grenade")
						end

					elseif(Category == "Ammo") then
						ply:GiveAmmo(200, entity[11])

					elseif(Category == "Ability") then
						local Ability = entity[1]
						if(Ability == "Flashlight") then
							ply:AllowFlashlight( true )
						elseif(Ability == "HP") then
							ply:SetMaxHealth( 150 )
						elseif(Ability == "Armor") then
							ply:SetArmor( 100 )
						elseif(Ability == "Sprint") then
							ply:SetRunSpeed(720)
						end

					elseif(Category == "Model") then
						ply:SetModel(entity[9])

					elseif(Category == "Entity") then

						local GTEntity = entity[1]

						if(GTEntity == "Ammo crate") then
							local ammo_crate1 = ents.Create("simple_ammo_crate")
							ammo_crate1:SetPos(ply:GetEyeTrace().HitPos + Vector(0,0,17))
							ammo_crate1:SetHealth(200)
							ammo_crate1:Spawn()
							ammo_crate1:SetName("ammo_crate1")

						elseif(GTEntity == "Guard") then
							local i = 0
							local Guard1 = ents.Create("simple_nextbot")
							Guard1:SetPos(ply:GetEyeTrace().HitPos)
							Guard1:SetHealth(200)
							Guard1:SetTeamId(ply:Team())
						 	Guard1:Spawn()
							Guard1:GiveWeapon("weapon_smg1")
							i = i + 1
							Guard1:SetName("Guard %i")
						end
					end
    	else

      ply:ChatPrint("Not Enough cash to purchase " .. entity[1] .. "")

      end
    end
  end
end
  concommand.Add("weapon_take", GivePlayerAWeapon)

elseif CLIENT then

function WeaponSelectorDerma()

local WeaponFrame = vgui.Create("DFrame")
WeaponFrame:SetSize(720, 600)
WeaponFrame:Center()
WeaponFrame:SetTitle("")
WeaponFrame:SetDraggable(true)
WeaponFrame:SetSizable(false)
WeaponFrame:ShowCloseButton(true)
WeaponFrame:MakePopup()
WeaponFrame.Paint = function(self, w, h) draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0 ) ) end

local DLabel = vgui.Create( "DLabel", WeaponFrame )
DLabel:SetPos( 10, 5 )
surface.CreateFont("TitleLayout", {
	font = "DermaLarge",
	size = 40
})

DLabel:SetSize(500, 70)
DLabel:SetFont("TitleLayout")
DLabel:SetText( "GetThem's Shop" )

local sheet = vgui.Create( "DColumnSheet", WeaponFrame )
sheet:Dock( FILL )
sheet:DockPadding(0, 60 ,0 ,0)

local weaponsTab = vgui.Create( "DPanel", sheet )
weaponsTab:Dock( FILL )
weaponsTab.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0 ) ) end
sheet:AddSheet( "Weapons", weaponsTab, "icon16/lightning.png" )

local ammoTab = vgui.Create( "DPanel", sheet )
ammoTab:Dock( FILL )
ammoTab.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0 ) ) end
sheet:AddSheet( "Ammo", ammoTab, "icon16/package_add.png" )

local SpecialsTab = vgui.Create( "DPanel", sheet )
SpecialsTab:Dock( FILL )
SpecialsTab.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0 ) ) end
sheet:AddSheet( "Abilities", SpecialsTab, "icon16/star.png" )

local ModelTab = vgui.Create( "DPanel", sheet )
ModelTab:Dock( FILL )
ModelTab.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0 ) ) end
sheet:AddSheet( "Player Model", ModelTab, "icon16/user_orange.png" )

local EntitiesTab = vgui.Create( "DPanel", sheet )
EntitiesTab:Dock( FILL )
EntitiesTab.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0 ) ) end
sheet:AddSheet( "Entities", EntitiesTab, "icon16/user_orange.png" )

local PrevPanel = vgui.Create( "DPanel" , WeaponFrame )
PrevPanel:SetPos( 300, 320 )
PrevPanel:SetSize( 250, 250 )

local CostPanel = vgui.Create( "DPanel" , WeaponFrame )
CostPanel:SetPos( 130, 530 )
CostPanel:SetSize( 140, 40)

local CostText = vgui.Create( "DLabel" , CostPanel )
CostText:SetPos( 6, -5 )
CostText:SetFont("CloseCaption_Bold")
CostText:SetColor( Color( 0, 0, 0 ) )
CostText:SetText( "Cost: " )
CostText:SetSize( 200 , 50)

for key,value in pairs(gtObject) do
  local entity = gtObject[key]
	local Buttons = {}
	local Button = Button[key]
	local Category = entity[10]

	if(Category == "Weapon") then
  	Button = vgui.Create("DButton", weaponsTab)
	elseif(Category == "Ammo") then
		Button = vgui.Create("DButton", ammoTab)
	elseif(Category == "Ability") then
		Button = vgui.Create("DButton", SpecialsTab)
	elseif(Category == "Model") then
		Button = vgui.Create("DButton", ModelTab)
	elseif(Category == "Entity") then
		Button = vgui.Create("DButton", EntitiesTab)
	end

Button:SetSize(150, 45)
Button:SetPos(entity[6], entity[7])
Button:SetText(entity[1])
Button.DoClick = function() RunConsoleCommand("weapon_take", entity[1]) WeaponFrame:Close() end

Button.OnCursorEntered = function()
  local icon = vgui.Create( "DModelPanel", PrevPanel )
    icon:SetModel( entity[9] )
    icon:SetSize( 1000, 1000 )
    icon:SetCamPos(Vector (0, entity[4], entity[5]))
    icon:SetLookAt( Vector( 0, 0, 0 ) )
    icon:Center()
    CostText:SetText( "Cost: " .. tostring(entity[2]) .. "")
    function icon:LayoutEntity( Entity ) return end
  end
  Button.OnCursorExited = function()
    CostText:SetText( "Cost: ")
  PrevPanel:Clear()
  end

end

end
  concommand.Add("shop", WeaponSelectorDerma)
end
