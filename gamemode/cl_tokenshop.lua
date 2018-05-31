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
	"- Respawn wait",
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

local TradeTab = vgui.Create( "DPanel", sheet )
TradeTab:Dock( FILL )
TradeTab.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0, 175 ) ) CostPanel2:Hide() CostText2:Hide() end
sheet:AddSheet( "Trade", TradeTab, "icon16/money_dollar.png" )

for key,value in pairs(gtObject2) do
  local entity = gtObject2[key]
	local Buttons = {}
	local Button = Button[key]
	local Category = entity[3]

	if(Category == "Loadout") then
  	Button = vgui.Create("DButton", SpecialsTab)
	elseif(Category == "Entities") then
  	Button = vgui.Create("DButton", EntitiesTab)
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
	end

	elseif Button:GetText() == "Enable Guard" then 
	if  (LocalPlayer():GetNWBool( "CanBuy_Guard") == true) then 
	Button:SetColor( Color(0, 102, 0) )
	Button:SetText("Guard Enabled")	
	end 

	elseif Button:GetText() == "Enable Spike" then 
	if  (LocalPlayer():GetNWBool( "CanBuy_Spike") == true)then 
	Button:SetColor( Color(0, 102, 0) ) 
	Button:SetText("Spike Enabled")
	end 

	elseif Button:GetText() == "Enable Builder" then 
	if (LocalPlayer():GetNWBool( "CanBuy_Builder") == true) then 
	Button:SetColor( Color(0, 102, 0) )
	Button:SetText("Builder Enabled")
	end 
	
end

Button.OnCursorEntered = function()
	if entity[2] == 1 then
    CostText2:SetText( "Cost: " .. tostring(entity[2]) .. " Token")
	else
	CostText2:SetText( "Cost: " .. tostring(entity[2]) .. " Tokens")
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
				
				
				if(Special == "+1 Token") and current_money > entity[2] then 
				ply:TakeXp ( Price , ply )
				
				timer.Simple( 3, function()
				ply:AddToken( 1 )
				
				net.Start( "Notification" )
				net.WriteString("+ 1 Token")
				net.WriteDouble(4)
				net.Send( ply ) end )
				return end 
						
						
				if(current_token > entity[2]) then
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
				
				if(Special == "- Respawn wait") then
				ply:SetNWInt("DeathWait", 2)
				end				

				if(Special == "Get Little") then
				
					local ShrinkTime 	= 2*60
					local ShrinkVol 	= 1.3
					local DidShrink 	= ply:GetModelScale()
					
					if DidShrink 	< 	1 	then
					ply:ChatPrint("You're still little!")
					ply:AddToken(Price)
					else
					ply:SetModelScale( ply:GetModelScale() / ShrinkVol, 10 )
					end
					
					timer.Create( "BackToNormal", ShrinkTime, 1, function() 
					ply:ChatPrint("You're Getting Bigger!")
					ply:SetModelScale( 1, 10 )
					end )
				
				end				
								
				if (Special == "Enable Guard") then
				if (ply:GetNWBool( "CanBuy_Guard") == false)  then
				ply:SetNWBool( "CanBuy_Guard", true )
				else
				ply:AddToken(Price)
				ply:ChatPrint("Already Bought!")
				end
				end
				
				if (Special == "Enable Ammobox") then
				if (ply:GetNWBool( "CanBuy_Ammobox") == false) then
				ply:SetNWBool( "CanBuy_AmmoBox", true )
				else
				ply:AddToken(Price)
				ply:ChatPrint("Already Bought!")
				end
				end
				
				if (Special == "Enable Spike") then
				if (ply:GetNWBool( "CanBuy_Spike") == false) then
				ply:SetNWBool( "CanBuy_Spike", true )
				else
				ply:AddToken(Price)
				ply:ChatPrint("Already Bought!")
				end
				end
				
				if (Special == "Enable Builder") then
				if (ply:GetNWBool( "CanBuy_Builder") == false) then
				ply:SetNWBool( "CanBuy_Builder", true )
				else
				ply:AddToken(Price)
				ply:ChatPrint("Already Bought!")
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