AddCSLuaFile()

local LevelForSpawner = 3
local LevelForBuilder = 5
local LevelForAssault = 4
local LevelForScavenger = 10



if (CLIENT) then

net.Receive("ShowClasses", function ( len, pl )
	local Class_select = vgui.Create( "DFrame" )
	Class_select:SetPos( math.Round(ScrW() * 0.25) , math.Round(ScrH() * 0.25) )
	Class_select:SetSize( math.Round(ScrW() * 0.5), math.Round(ScrH() * 0.5) )
	Class_select:SetTitle( "" )
	--Class_select:ShowCloseButton( false )
	Class_select:ShowCloseButton( true )
	Class_select:SetDraggable ( false )
	Class_select:SetVisible( true )
	Class_select:MakePopup( )
	
	local blur = Material("pp/blurscreen") --https://gmod.facepunch.com/f/gmoddev/mlnc/How-would-I-add-blur-to-a-DFrame/1/
	local function DrawBlur(panel, amount)
	local x, y = panel:LocalToScreen(0, 0)
	local scrW, scrH = ScrW(), ScrH()
	surface.SetDrawColor(255, 255, 255)
	surface.SetMaterial(blur)
	for i = 1, 3 do
		blur:SetFloat("$blur", (i / 3) * (amount or 6))
		blur:Recompute()
		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
	end
	end
	
	function Class_select:Paint()
		DrawBlur(self, 3)
		draw.RoundedBox( 0, 0, 0, self:GetWide(), self:GetTall(), Color( 10,10,10,200) )
		draw.SimpleText("SELECT YOUR CLASS","DermaLarge", math.Round(Class_select:GetWide() * 0.35), math.Round(Class_select:GetTall() * 0.060), Color(255, 255, 255, 255), 0, 0)
		draw.RoundedBox( 0, 0, self:GetTall() - math.Round(Class_select:GetTall() * 0.0037), self:GetWide(), math.Round(Class_select:GetTall() * 0.0037), Color( 256,256,256,256) )
		draw.RoundedBox( 0, 0, 0, self:GetWide(), math.Round(Class_select:GetTall() * 0.0037), Color( 256,256,256,256) )
		draw.RoundedBox( 0, 0, math.Round(Class_select:GetTall() * 0.1851), self:GetWide(), math.Round(Class_select:GetTall() * 0.0037), Color( 256,256,256,256) )

		local TexturedQuadStructure = {
			texture = surface.GetTextureID( 'custom/smg' ),
			color	= Color( 255, 255, 255, 255 ),
			x 	= math.Round(Class_select:GetWide() * 0.05),
			y 	= math.Round(Class_select:GetTall() * 0.2222),
			w 	= math.Round(ScrW() * 0.1041),
			h 	=  math.Round(ScrH() * 0.0925)
		}
		draw.TexturedQuad( TexturedQuadStructure )
		draw.SimpleText("ASSAULT","Trebuchet24",  math.Round(Class_select:GetWide() * 0.085), math.Round(Class_select:GetTall() * 0.4074), Color(255, 255, 255, 255), 0, 0)
		draw.RoundedBox( 0, math.Round(ScrW() * 0.025), math.Round(ScrH() * 0.25), math.Round(Class_select:GetWide() * 0.1770), math.Round(Class_select:GetTall() * 0.0037), Color( 256,256,256,256) )
	--	draw.SimpleText("Normal speed","Trebuchet18",  math.Round(Class_select:GetWide() * 0.085), math.Round(Class_select:GetTall() * 0.5092), Color(255, 255, 255, 255), 0, 0)
		draw.SimpleText("Shotgun","Trebuchet18", math.Round(Class_select:GetWide() * 0.085), math.Round(Class_select:GetTall() * 0.5462), Color(255, 255, 255, 255), 0, 0)
		draw.SimpleText("Pistol","Trebuchet18", math.Round(Class_select:GetWide() * 0.085), math.Round(Class_select:GetTall() * 0.5833), Color(255, 255, 255, 255), 0, 0)
		draw.SimpleText("SMG","Trebuchet18", math.Round(Class_select:GetWide() * 0.085), math.Round(Class_select:GetTall() * 0.6203), Color(255, 255, 255, 255), 0, 0)
		draw.SimpleText("100 Armor","Trebuchet18", math.Round(Class_select:GetWide() * 0.085), math.Round(Class_select:GetTall() * 0.6574), Color(255, 200, 255, 255), 0, 0)
		
		local TexturedQuadStructure1 = {
			texture = surface.GetTextureID( 'custom/rpg' ),
			color	= Color( 255, 255, 255, 255 ),
			x 	= math.Round(Class_select:GetWide() * 0.25),
			y 	= math.Round(Class_select:GetTall() * 0.2222),
			w 	= math.Round(ScrW() * 0.1041),
			h 	= math.Round(ScrH() * 0.0925)
		}
		draw.TexturedQuad( TexturedQuadStructure1 )
		draw.SimpleText("BUILDER","Trebuchet24", math.Round(Class_select:GetWide() * 0.300), math.Round(Class_select:GetTall() * 0.4074), Color(255, 255, 255, 255), 0, 0)
		draw.RoundedBox( 0, math.Round(ScrW() * 0.135), math.Round(ScrH() * 0.25), math.Round(Class_select:GetWide() * 0.1770), math.Round(Class_select:GetTall() * 0.0037), Color( 256,256,256,256) )
	--	draw.SimpleText("Slow speed(0.5)","Trebuchet18", math.Round(Class_select:GetWide() * 0.3), math.Round(Class_select:GetTall() * 0.5092), Color(255, 255, 255, 255), 0, 0)
		draw.SimpleText("Pistol","Trebuchet18", math.Round(Class_select:GetWide() * 0.3), math.Round(Class_select:GetTall() * 0.5462), Color(255, 255, 255, 255), 0, 0)
		draw.SimpleText("40 Armour","Trebuchet18", math.Round(Class_select:GetWide() * 0.3), math.Round(Class_select:GetTall() * 0.5833), Color(255, 255, 255, 255), 0, 0)
		draw.SimpleText("GT Builder","Trebuchet18", math.Round(Class_select:GetWide() * 0.3), math.Round(Class_select:GetTall() * 0.6203), Color(255, 255, 255, 255), 0, 0)
		draw.SimpleText("+ 90 Ammo!","Trebuchet18", math.Round(Class_select:GetWide() * 0.3), math.Round(Class_select:GetTall() * 0.6574), Color(255, 200, 255, 255), 0, 0)
		
		local TexturedQuadStructure2 = {
			texture = surface.GetTextureID( 'custom/crossbow' ),
			color	= Color( 255, 255, 255, 255 ),
			x 	= math.Round(Class_select:GetWide() * 0.46),
			y 	= math.Round(Class_select:GetTall() * 0.2222),
			w 	= math.Round(ScrW() * 0.1041),
			h 	= math.Round(ScrH() * 0.0925)
		}
		draw.TexturedQuad( TexturedQuadStructure2 )
		draw.SimpleText("SCAVENGER","Trebuchet24", math.Round(Class_select:GetWide() * 0.51), math.Round(Class_select:GetTall() * 0.4074), Color(255, 255, 255, 255), 0, 0)
		draw.RoundedBox( 0, math.Round(ScrW() * 0.240), math.Round(ScrH() * 0.25), math.Round(Class_select:GetWide() * 0.1770), math.Round(Class_select:GetTall() * 0.0037), Color( 256,256,256,256) )
	--	draw.SimpleText("Fast speed(1.25)","Trebuchet18", math.Round(Class_select:GetWide() * 0.51), math.Round(Class_select:GetTall() * 0.5092), Color(255, 255, 255, 255), 0, 0)
		draw.SimpleText("Pistol","Trebuchet18",  math.Round(Class_select:GetWide() * 0.51), math.Round(Class_select:GetTall() * 0.5462), Color(255, 255, 255, 255), 0, 0)
		draw.SimpleText("4 grenades","Trebuchet18",  math.Round(Class_select:GetWide() * 0.51), math.Round(Class_select:GetTall() * 0.5833), Color(255, 255, 255, 255), 0, 0)
		draw.SimpleText("Crossbow","Trebuchet18",  math.Round(Class_select:GetWide() * 0.51), math.Round(Class_select:GetTall() * 0.6203), Color(255, 255, 255, 255), 0, 0)
		draw.SimpleText("Unlocks AmmoBox!","Trebuchet18",  math.Round(Class_select:GetWide() * 0.51), math.Round(Class_select:GetTall() * 0.6574), Color(255, 200, 255, 255), 0, 0)
		
		local TexturedQuadStructure3 = {
			texture = surface.GetTextureID( 'custom/spawner' ),
			color	= Color( 255, 255, 255, 255 ),
			x 	= math.Round(Class_select:GetWide() * 0.67),
			y 	= math.Round(Class_select:GetTall() * 0.2222),
			w 	= math.Round(ScrW() * 0.1041),
			h 	= math.Round(ScrH() * 0.0925)
		}
		draw.TexturedQuad( TexturedQuadStructure3 )
		draw.SimpleText("SPAWNER","Trebuchet24", math.Round(Class_select:GetWide() * 0.71), math.Round(Class_select:GetTall() * 0.4074), Color(255, 255, 255, 255), 0, 0)
		draw.RoundedBox( 0, math.Round(ScrW() * 0.345), math.Round(ScrH() * 0.25), math.Round(Class_select:GetWide() * 0.1770), math.Round(Class_select:GetTall() * 0.0037), Color( 256,256,256,256) )
	--	draw.SimpleText("Fast speed(1.25)","Trebuchet18", math.Round(Class_select:GetWide() * 0.71), math.Round(Class_select:GetTall() * 0.5092), Color(255, 255, 255, 255), 0, 0)
		draw.SimpleText("Pistol","Trebuchet18",  math.Round(Class_select:GetWide() * 0.710), math.Round(Class_select:GetTall() * 0.5462), Color(255, 255, 255, 255), 0, 0)
		draw.SimpleText(".357 Magnum","Trebuchet18",  math.Round(Class_select:GetWide() * 0.71), math.Round(Class_select:GetTall() * 0.5833), Color(255, 255, 255, 255), 0, 0)
		draw.SimpleText("15 Armor","Trebuchet18",  math.Round(Class_select:GetWide() * 0.71), math.Round(Class_select:GetTall() * 0.6203), Color(255, 255, 255, 255), 0, 0)
		draw.SimpleText("Medkit!","Trebuchet18",  math.Round(Class_select:GetWide() * 0.71), math.Round(Class_select:GetTall() * 0.6574), Color(255, 200, 255, 255), 0, 0)
		
	end
	if !Class_select.Open then
		Class_select:MoveTo(math.Round(ScrW() * 0.25),  math.Round(ScrH() * 0.25) , 0)
	else
		Class_select:SetKeyboardInputEnabled(false)
	end
	
	local assault_button = vgui.Create( "DButton", Class_select )
	assault_button:SetPos(  math.Round(Class_select:GetWide() * 0.04),math.Round(Class_select:GetTall() * 0.7222) )
	assault_button:SetSize( math.Round(ScrW() * 0.1030), math.Round(ScrH() * 0.0277) )
	assault_button:SetText( "Choose Class" )

	assault_button.Paint = function()
		draw.RoundedBox( 8, 0, 0, assault_button:GetWide(), assault_button:GetTall(), Color( 128,0,0,200 ) )
		surface.DrawRect( 0, 0, assault_button:GetWide(), assault_button:GetTall() )
	end
	
	local builder_button = vgui.Create( "DButton", Class_select )
	builder_button:SetPos(  math.Round(Class_select:GetWide() * 0.26),math.Round(Class_select:GetTall() * 0.7222) )
	builder_button:SetSize( math.Round(ScrW() * 0.1030), math.Round(ScrH() * 0.0277) )
	builder_button:SetText( "Choose Class" )

	builder_button.Paint = function()
		draw.RoundedBox( 8, 0, 0, builder_button:GetWide(), builder_button:GetTall(), Color( 128,0,0,200 ) )
		surface.DrawRect( 0, 0, builder_button:GetWide(), builder_button:GetTall() )
	end
	
	local scavenger_button = vgui.Create( "DButton", Class_select )
	scavenger_button:SetPos(   math.Round(Class_select:GetWide() * 0.48),math.Round(Class_select:GetTall() * 0.7222) )
	scavenger_button:SetSize( math.Round(ScrW() * 0.1030), math.Round(ScrH() * 0.0277) )
	scavenger_button:SetText( "Choose Class" )

	scavenger_button.Paint = function()
		draw.RoundedBox( 8, 0, 0, scavenger_button:GetWide(), scavenger_button:GetTall(), Color( 128,0,0,200 ) )
		surface.DrawRect( 0, 0, scavenger_button:GetWide(), scavenger_button:GetTall() )
	end
	
	local spawner_button = vgui.Create( "DButton", Class_select )
	spawner_button:SetPos(   math.Round(Class_select:GetWide() * 0.70),math.Round(Class_select:GetTall() * 0.7222) )
	spawner_button:SetSize( math.Round(ScrW() * 0.1030), math.Round(ScrH() * 0.0277) )
	spawner_button:SetText( "Choose Class" )

	spawner_button.Paint = function()
		draw.RoundedBox( 8, 0, 0, spawner_button:GetWide(), spawner_button:GetTall(), Color( 128,0,0,200 ) )
		surface.DrawRect( 0, 0, spawner_button:GetWide(), spawner_button:GetTall() )
	end
	
	if (LocalPlayer():GetLevel()  < LevelForSpawner) then 
	spawner_button:SetColor( Color(0, 102, 0) ) 
	spawner_button:SetText("Unlocks at level " .. LevelForSpawner )
	spawner_button:SetEnabled( disable ) 
	end

	if (LocalPlayer():GetLevel()  < LevelForAssault) then 
	assault_button:SetColor( Color(0, 102, 0) ) 
	assault_button:SetText("Unlocks at level " .. LevelForAssault )
	assault_button:SetEnabled( disable ) 
	end
	
	if (LocalPlayer():GetLevel()  < LevelForBuilder) then 
	builder_button:SetColor( Color(0, 102, 0) ) 
	builder_button:SetText("Unlocks at level " .. LevelForBuilder )
	builder_button:SetEnabled( disable ) 
	end
	
	if (LocalPlayer():GetLevel()  < LevelForScavenger) then 
	scavenger_button:SetColor( Color(0, 102, 0) ) 
	scavenger_button:SetText("Unlocks at level " .. LevelForScavenger )
	scavenger_button:SetEnabled( disable ) 
	end
	

	if (LocalPlayer():GetNWString("PlayerClass") == "Spawner") then
	spawner_button:SetEnabled( disable )
	spawner_button:SetText("You are a Spawner!")	
	elseif (LocalPlayer():GetNWString("PlayerClass") == "Scavenger") then
	scavenger_button:SetEnabled( disable )
	scavenger_button:SetText("You are a Scavenger!")
	elseif (LocalPlayer():GetNWString("PlayerClass") == "Builder") then
	builder_button:SetEnabled( disable )
	builder_button:SetText("You are a Builder!")
	elseif (LocalPlayer():GetNWString("PlayerClass") == "Assault") then
	assault_button:SetEnabled( disable )
	assault_button:SetText("You are a Assault!")
	end

	
	assault_button.DoClick = function()
	RunConsoleCommand( "assault_class" )		
	end
	
	builder_button.DoClick = function()
	RunConsoleCommand( "builder_class" )	
	end
	
	scavenger_button.DoClick = function()
	RunConsoleCommand( "scavenger_class" )	
	end
	
	spawner_button.DoClick = function()
	RunConsoleCommand( "spawner_class" )	
	end
		
end)

end

if (SERVER) then

function SetClassSpawner(ply, cmd, command)
if (ply:GetLevel()  >= LevelForSpawner) and(ply:GetNWString("PlayerClass") != "Spawner") then
		ply:Give("weapon_pistol")
		ply:Give("weapon_357")
		ply:Give("gt_medkit")
		ply:SetArmor(15)
		--ply:SetRunSpeed(ply:GetRunSpeed()*1.2)
		ply:GiveAmmo(50, "Pistol", true )
		ply:GiveAmmo(6, "357"	)
		ply:SetNWString("PlayerClass" , "Spawner")	
end		
end  
concommand.Add("spawner_class", SetClassSpawner)

function SetClassScavenger(ply, cmd, command)
	if (ply:GetLevel()  >= LevelForScavenger) and (ply:GetNWString("PlayerClass") != "Scavenger") then 
		ply:Give("weapon_pistol")
		ply:GiveAmmo(150, "Pistol", true )
		ply:Give("weapon_frag")
		ply:GiveAmmo(3, "Grenade")
		ply:Give("weapon_crossbow")
		ply:GiveAmmo(20, "XBowBolt")
		ply:SetRunSpeed(500)
		ply:SetNWString("PlayerClass" , "Scavenger")	
		
		if (ply:GetNWBool( "CanBuy_Ammobox") == false) then
			ply:SetNWBool( "CanBuy_AmmoBox", true )
		end
	end
end  
concommand.Add("scavenger_class", SetClassScavenger)

function SetClassBuilder(ply, cmd, command)
	if (ply:GetLevel()  >= LevelForBuilder) and (ply:GetNWString("PlayerClass") != "Builder") then 
		ply:Give("gt_builder")
		ply:GiveAmmo(90, "Battery", true )
		ply:SetArmor(40)
		ply:Give("weapon_pistol")
		ply:GiveAmmo(90, "Pistol", true )
		--ply:GiveAmmo( 	200, "Pistol", true )
		ply:SetNWString("PlayerClass" , "Builder")		
	end
end  
concommand.Add("builder_class", SetClassBuilder)

function SetClassAssault(ply, cmd, command)
	if (ply:GetLevel()  >= LevelForAssault) and (ply:GetNWString("PlayerClass") != "Assault")  then 
		ply:Give("weapon_pistol")
		ply:GiveAmmo(100, "Pistol", true )
		ply:Give("weapon_smg1")
		ply:GiveAmmo(180, "smg1", true )
		ply:Give("weapon_shotgun")		
		ply:SetArmor(100)
		ply:SetNWString("PlayerClass" , "Assault")		
	end

end  
concommand.Add("assault_class", SetClassAssault)

end