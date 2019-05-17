AddCSLuaFile()
gtObject2 = {}

gtObject2[1] = {
	"++ HP", 			--Name
	2, 					--Price
	"Loadout",			--Tab Location
	50,					--Posx
	10,					--Posy
	"You got more HP!"	--ChatPrint
}

gtObject2[2] = {
	"++ Armor",
	1,
	"Loadout",
	210,
	10,
	"You got more Armor to battle!"
}

gtObject2[3] = {
	"++ Sprint",
	2,
	"Loadout",
	370,
	10,
	"You are so fast now!"
}

gtObject2[4] = {
	"- Respawn Wait",
	1,
	"Loadout",
	50,
	60,
	"Death wait was reset successfully."
}

gtObject2[5] = {
	"Get Little",
	1,
	"Loadout",
	210,
	60,
	"You are 2 minutes little!"
}

gtObject2[6] = {
	"Enable Ammobox",
	1,
	"Entities",
	50,
	10,
	"You can now buy a Ammobox!"
}

gtObject2[7] = {
	"Enable Guard",
	1,
	"Entities",
	210,
	10,
	"You can now buy a Guard!"
}

gtObject2[8] = {
	"Enable Spike",
	1,
	"Entities",
	370,
	10,
	"You can now buy a Spike!"
}

gtObject2[9] = {
	"Enable Builder",
	1,
	"Entities",
	50,
	60,
	"You can now buy the GT_builder!"
}
gtObject2[10] = {
	"+1 Token",
	1000,
	"Trade",
	50,
	10,
	"You got one token!"
}
gtObject2[11] = {
	"+1000 $",
	1,
	"Trade",
	210,
	10,
	"You got 1000$!"
}
gtObject2[12] = {
	"Knife", 			
	2, 					
	"Weapons",			
	50,					
	10,					
	"You got the Speedrun Knife!"	
}
gtObject2[13] = {
	"Spawn with AR2", 			
	2, 					
	"Weapons",			
	50,					
	60,					
	"You now spawn with a AR2!"	
}
gtObject2[14] = {
	"Spawn with SMG", 			
	2, 					
	"Weapons",			
	210,					
	60,					
	"You now spawn with a SMG!"	
}
gtObject2[15] = {
	"Medic Chicken", 			
	2, 					
	"Entities",			
	210,					
	60,					
	"You now got a Medic Chicken following you!"	
}gtObject2[16] = {
	"Triple Jump", 			
	1, 					
	"Loadout",			
	370,					
	60,					
	"You now got Triple Jump!"	
}
gtObject2[17] = {
	"20% Discount", 			
	2, 					
	"Trade",			
	50,					
	60,					
	"You now got 20% discount in the Shop!"	
}

//---------------//
// Token	Shop!// 
//---------------//
if (CLIENT) then

function WeaponSelectorDerma2()

local WeaponFrame2 = vgui.Create("DFrame")
WeaponFrame2:SetSize(720, 600)
WeaponFrame2:Center()
WeaponFrame2:SetTitle("")
WeaponFrame2:SetDraggable(true)
WeaponFrame2:SetSizable(false)
WeaponFrame2:ShowCloseButton(true)
WeaponFrame2:MakePopup()
WeaponFrame2.Paint = function(self, w, h) draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0, 175 ) ) end

local DLabel = vgui.Create( "DLabel", WeaponFrame2 )
DLabel:SetPos( 10, 5 )
DLabel:SetSize(500, 70)
DLabel:SetFont("TitleLayout")
DLabel:SetTextColor( Color(240, 230, 240) )
DLabel:SetText( "  Token Shop" )

local sheet = vgui.Create( "DColumnSheet", WeaponFrame2 )
sheet:Dock( FILL )
sheet:DockPadding(0, 60 ,0 ,0)

local CostPanel2 = vgui.Create( "DPanel" , WeaponFrame2 )
CostPanel2:SetPos( 130, 530 )
CostPanel2:SetSize( 165, 40)

local CostText2 = vgui.Create( "DLabel" , CostPanel2 )
CostText2:SetPos( 6, -5 )
CostText2:SetFont("CloseCaption_Normal")
CostText2:SetColor(Color(0, 51, 204) )
CostText2:SetText( "Cost: " )
CostText2:SetSize( 200 , 50)

local SpecialsTab = vgui.Create( "DPanel", sheet )
SpecialsTab:Dock( FILL )
SpecialsTab.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0, 175 ) ) CostPanel2:Show() CostText2:Show()end
sheet:AddSheet( "Loadout", SpecialsTab, "icon16/user_suit.png" )

local EntitiesTab = vgui.Create( "DPanel", sheet )
EntitiesTab:Dock( FILL )
EntitiesTab.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0, 175 ) ) CostPanel2:Show() CostText2:Show() end
sheet:AddSheet( "Entities", EntitiesTab, "icon16/ruby_key.png" )

local WeaponTab = vgui.Create( "DPanel", sheet )
WeaponTab:Dock( FILL )
WeaponTab.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0, 175 ) ) CostPanel2:Show() CostText2:Show()end
sheet:AddSheet( "Weapons", WeaponTab, "icon16/lightning_go.png" )

local TradeTab = vgui.Create( "DPanel", sheet )
TradeTab:Dock( FILL )
TradeTab.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0, 175 ) ) CostPanel2:Show() CostText2:Show() end
sheet:AddSheet( "Trade", TradeTab, "icon16/money_dollar.png" )

local BackTab = vgui.Create( "DPanel", sheet )
BackTab:Dock( FILL )
BackTab.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0, 175 ) ) WeaponFrame2:Close() RunConsoleCommand("shop") end
sheet:AddSheet( "Go Back", BackTab, "icon16/arrow_undo.png" )

for key,value in pairs(gtObject2) do
  local entity = gtObject2[key]
	local Buttons = {}
	local Button = Button[key]
	local Category = entity[3]

	if(Category == "Loadout") then
  	Button = vgui.Create("DButton", SpecialsTab)
	elseif(Category == "Entities") then
  	Button = vgui.Create("DButton", EntitiesTab)
	elseif(Category == "Weapons") then
  	Button = vgui.Create("DButton", WeaponTab)	
	elseif(Category == "Trade") then
  	Button = vgui.Create("DButton", TradeTab)
	end

Button:SetSize(150, 45)
Button:SetPos(entity[4], entity[5])
Button:SetText(entity[1])
Button:SetColor( Color( 0, 0, 255 ) )
Button:SetFont("ButtonLayout")
Button.DoClick = function() RunConsoleCommand("givespecial", entity[1]) WeaponFrame2:Close() end

	if Button:GetText() == "Enable Ammobox" then 
	if (LocalPlayer():GetNWBool( "CanBuy_AmmoBox") == true) then 
	Button:SetColor( Color(0, 102, 0) ) 
	Button:SetText("Ammobox Enabled")
	Button:SetEnabled( disable ) 
	end

	elseif Button:GetText() == "Enable Guard" then 
	if  (LocalPlayer():GetNWBool( "CanBuy_Guard") == true) then 
	Button:SetColor( Color(0, 102, 0) )
	Button:SetText("Guard Enabled")	
	Button:SetEnabled( disable ) 
	end 

	elseif Button:GetText() == "Enable Spike" then 
	if  (LocalPlayer():GetNWBool( "CanBuy_Spike") == true)then 
	Button:SetColor( Color(0, 102, 0) ) 
	Button:SetText("Spike Enabled")
	Button:SetEnabled( disable ) 
	end 

	elseif Button:GetText() == "Enable Builder" then 
	if (LocalPlayer():GetNWBool( "CanBuy_Builder") == true) then 
	Button:SetColor( Color(0, 102, 0) )
	Button:SetText("Builder Enabled")
	Button:SetEnabled( disable ) 
	end
	
	elseif Button:GetText() == "Knife" then 
	if (LocalPlayer():HasWeapon( "gt_knife" )) then 
	Button:SetColor( Color(0, 102, 0) )
	Button:SetEnabled( disable ) 
	end
	
	elseif Button:GetText() == "Spawn with AR2" then 
	if (LocalPlayer():GetNWString( "SpawnWith") == "weapon_ar2") then 
	Button:SetColor( Color(0, 102, 0) )
	Button:SetText("[ AR2 ]")
	Button:SetEnabled( disable ) 
	end
	
	elseif Button:GetText() == "Spawn with SMG" then 
	if (LocalPlayer():GetNWString( "SpawnWith") == "weapon_smg1") then 
	Button:SetColor( Color(0, 102, 0) )
	Button:SetText("[ SMG ]")
	Button:SetEnabled( disable ) 
	end 

	elseif Button:GetText() == "++ HP" then 
	if (LocalPlayer():GetMaxHealth() >= 220) then 
	Button:SetColor( Color(0, 102, 0) )
	Button:SetEnabled( disable ) 
	end 
	
	elseif Button:GetText() == "++ Armor" then 
	if (LocalPlayer():Armor() >= 200) then 
	Button:SetColor( Color(0, 102, 0) )
	Button:SetEnabled( disable ) 
	end 	
	
	elseif Button:GetText() == "++ Sprint" then 
	if (LocalPlayer():GetRunSpeed() == 650) then 
	Button:SetColor( Color(0, 102, 0) )
	Button:SetEnabled( disable ) 
	end 	
	
	elseif Button:GetText() == "- Respawn Wait" then 
	if (LocalPlayer():GetNWInt("DeathWait") < 4 ) then 
	Button:SetColor( Color(0, 102, 0) )
	Button:SetEnabled( disable ) 
	end 	
	
	elseif Button:GetText() == "Get Little" then 
	if (LocalPlayer():GetModelScale() < 	1) then 
	Button:SetColor( Color(0, 102, 0) )
	Button:SetEnabled( disable ) 
	end 	
	
	elseif Button:GetText() == "Triple Jump" then 
	if (LocalPlayer():GetDTInt(24) == 2) then 
	Button:SetColor( Color(0, 102, 0) )
	Button:SetEnabled( disable ) 
	end 	
	
	elseif Button:GetText() == "Medic Chicken" then 
	if (LocalPlayer():GetNWBool("Bought_MedChicken")) then 
	Button:SetColor( Color(0, 102, 0) )
	Button:SetEnabled( disable ) 
	end 
	
	elseif Button:GetText() == "20% Discount" then 
	if (LocalPlayer():GetNWBool("Bought_ShopDiscount")) then 
	Button:SetColor( Color(0, 102, 0) )
	Button:SetEnabled( disable ) 
	end 	
end

Button.OnCursorEntered = function()
	if entity[2] > 100 then
	CostText2:SetText( "Cost: " .. tostring(entity[2]) .. " $")
	else
	
	if entity[2] == 1 then
    CostText2:SetText( "Cost: " .. tostring(entity[2]) .. " Token")
	else
	CostText2:SetText( "Cost: " .. tostring(entity[2]) .. " Tokens")
	end
	end
end

Button.OnCursorExited = function()
    CostText2:SetText( "Cost: ")
end

end
end
  concommand.Add("tokenshop", WeaponSelectorDerma2)


elseif (SERVER) then

function GivePlayerASpecial(ply, cmd, command)
    
	for key, value in pairs(gtObject2) do
		
      if(command[1] == gtObject2[key][1]) then
        local entity = gtObject2[key]
				local current_token = ply:GetToken()
				local current_money = ply:GetXp()
				
				local Special = entity[1]
				local Price = entity[2]
				local Message = entity[6]
				
				
				if(Special == "+1 Token") and current_money >= Price then 
				ply:TakeXp ( Price , ply )				
				timer.Simple( 3, function()
				ply:AddToken( 1 )	
				ply:ChatPrint(Message)	
				net.Start( "Notification" )
				net.WriteString("+ 1 Token")
				net.WriteDouble(4)
				net.Send( ply ) end )
				return end 
				
				if (Special == "20% Discount") and current_token >= Price then
				if (ply:GetLevel() >= 5) and (ply:GetNWBool( "Bought_ShopDiscount") == false) then
				ply:SetNWBool( "Bought_ShopDiscount", true )
				ply:TakeToken(Price)
				ply:ChatPrint(Message)
				net.Start( "Notification" )
				net.WriteString("- 2 Tokens")
				net.WriteDouble(4)
				net.Send( ply )
				else
				ply:ChatPrint("You must reach at least level 5!")
				end
				return end						
						
				if(current_token >= Price) then
				ply:TakeToken(Price)
				ply:ChatPrint(Message)
				net.Start( "Notification" )
				if Price == 1 then 
				net.WriteString("- " .. Price .. " Token")
				else 
				net.WriteString("- " .. Price .. " Tokens") 
				end
				net.WriteDouble(4)
				net.Send(ply)
				
				if(Special == "++ HP") then
				ply:SetMaxHealth(220)
				ply:SetHealth(150)			
				end
				
				if(Special == "++ Armor") then
				ply:SetArmor(200)
				end
				
				if(Special == "++ Sprint") then
				ply:SetRunSpeed(650)
				end
				
				if(Special == "- Respawn Wait") then
				ply:SetNWInt("DeathWait", 2)
				end	

				if(Special == "Knife") then
				ply:Give("gt_knife")
				end		
				
				if(Special == "Triple Jump") then
				ply:SetMaxJumpLevel(2)
				end		

				if (Special == "+1000 $") then
				timer.Simple( 3, function() ply:AddXp( 1000 , ply ) end )
				end

				if(Special == "Get Little") then
				
					local ShrinkTime 	= 2*60
					local ShrinkVol 	= 1.3
					
					ply:SetModelScale( ply:GetModelScale() / ShrinkVol, 10 )
					
					timer.Create( "BackToNormal", ShrinkTime, 1, function() 
					ply:ChatPrint("You're Getting Bigger!")
					ply:SetModelScale( 1, 10 )
					end )
				
				end
		
				if (Special == "Enable Guard") then
				if (ply:GetNWBool( "CanBuy_Guard") == false)  then
				ply:SetNWBool( "CanBuy_Guard", true )
				end
				end
				
				if (Special == "Enable Ammobox") then
				if (ply:GetNWBool( "CanBuy_Ammobox") == false) then
				ply:SetNWBool( "CanBuy_AmmoBox", true )
				end
				end
				
				if (Special == "Enable Spike") then
				if (ply:GetNWBool( "CanBuy_Spike") == false) then
				ply:SetNWBool( "CanBuy_Spike", true )
				end
				end
				
				if (Special == "Enable Builder") then
				if (ply:GetNWBool( "CanBuy_Builder") == false) then
				ply:SetNWBool( "CanBuy_Builder", true )
				end
				end

				if (Special == "Spawn with AR2") then
				if (ply:GetNWString("SpawnWith") == "none") or (ply:GetNWString("SpawnWith") == "weapon_smg1") then
				ply:SetNWString("SpawnWith" , "weapon_ar2")
				ply:Give("weapon_ar2")
				ply:GiveAmmo( 40, "AR2", true )
				end
				end
				
				if (Special == "Spawn with SMG") then
				if (ply:GetNWString("SpawnWith") == "none") or (ply:GetNWString("SpawnWith") == "weapon_ar2") then
				ply:SetNWString("SpawnWith" , "weapon_smg1")
				ply:Give("weapon_smg1")
				ply:GiveAmmo( 70, "smg1", true )
				end
				end
				
				if (Special == "Medic Chicken") then
				if (ply:GetNWBool( "Bought_MedChicken") == false) then
				ply:SetNWBool( "Bought_MedChicken", true )
				local MedChicken = ents.Create("med_chicken")
				MedChicken:SetPos(ply:GetEyeTrace().HitPos)
				MedChicken:SetNWEntity("MedicChickenOwner", ply)
				local model = ents.Create("prop_physics")	
				model:SetModel("models/weapons/w_medkit.mdl")
				model:SetModelScale( model:GetModelScale() / 1.5, 1 )
				model:FollowBone( MedChicken, 0 ) 
				model:SetPos( MedChicken:GetPos()+ Vector(0, 0, 15))
				model:SetOwner(MedChicken)
				model:SetAngles(MedChicken:GetAngles()+ Vector(0, 90, 0):Angle())
				model:SetParent(MedChicken)
				MedChicken:DeleteOnRemove(model)
				model:Spawn()
				MedChicken:Spawn()
				end
				end
				
				else				
				ply:ChatPrint ( "Not Enough Tokens!")
				end
				
	
	end

end

end  
concommand.Add("givespecial", GivePlayerASpecial)

end