include( 'shared.lua' )
include("cl_score.lua")
include("cl_shop.lua")
include("cl_tokenshop.lua")
include("playerInfo.lua")
include("rounds.lua")
include("cl_holster.lua")


-- Clientside only stuff goes here
local meta = FindMetaTable("Player")

function meta:GetXp()
	return self:GetNetworkedInt( "Xp" )
end

function meta:GetToken()
	return self:GetNetworkedInt( "Token" )
end

-- Notifications Receiving & HUD
net.Receive( "Notification",  function()

local Notification = net.ReadString()
local NotificationLenght = string.len( Notification )
local DrawImage = net.ReadDouble() --1:None --2:$ --3:Death --4:Token

	--Panel
	NotifyPanel = vgui.Create( "DNotify" )
	NotifyPanel:SetPos(ScrW()/1.17, ScrH()/8.9)
	NotifyPanel:SetLife(2)
	if DrawImage == 2 or DrawImage == 4 then 
	NotifyPanel:SetSize( 180, 51.2 )
	elseif DrawImage == 3 then
	NotifyPanel:SetSize( 180, 100 )
	NotifyPanel:SetLife(5)
	end if DrawImage == 4 then
	NotifyPanel:SetLife(3)
	end

	--Background
	local Background = vgui.Create( "DPanel", NotifyPanel )
	Background:Dock( FILL )
	Background:SetBackgroundColor(  Color(64, 64, 64, 155) )

	--Label
	local lbl = vgui.Create( "DLabel", Background )
	lbl:SetPos( 10, -10)
	lbl:SetAutoStretchVertical()
	lbl:SetSize( 130, 80)
	lbl:SetText( "" )
	lbl:SetText( Notification )
	lbl:SetTextColor( Color( 255, 200, 0 ) )
	lbl:SetFont( "DermaLarge" )
	lbl:SetWrap( true )	
	if DrawImage == 2 then 
	lbl:SetPos( 10, -10) 
	elseif DrawImage == 3 then
	lbl:SetPos( 10, 10) 
	lbl:SetSize( 130, 85)
	elseif DrawImage == 4 then
	lbl:SetPos( 10, -10) 
	lbl:SetTextColor( Color( 255, 114, 0 ) )
	end
	
	--Images
	if DrawImage == 2 then
	local DollarIMG = vgui.Create( "DImage", Background )
	DollarIMG:SetPos( 136, 5 )	
	DollarIMG:SetSize( 40, 40 )
	DollarIMG:SetImage( "icon16/money_dollar.png" )
	elseif DrawImage == 3 then
	local CancelIMG = vgui.Create( "DImage", Background )
	CancelIMG:SetPos( 136, 30 )	
	CancelIMG:SetSize( 40, 40 )
	CancelIMG:SetImage( "icon16/cancel.png" )
	elseif DrawImage == 4 then
	local TokenIMG = vgui.Create( "DImage", Background )
	TokenIMG:SetPos( 136, 5 )	
	TokenIMG:SetSize( 40, 40 )
	TokenIMG:SetImage( "icon16/money_yen.png" )
	end
	
	NotifyPanel:AddItem( Background )	
end)

local function RecvMyUmsg3( data3 )

--print( "roundTimer" ..data3:ReadString() );
--put here because [ Warning: Unhandled usermessage 'RoundTimer' ]


end
usermessage.Hook( "RoundTimer", RecvMyUmsg3 );

function RemoveDeadRag( ent )

	if (ent == NULL) or (ent == nil) then return end
	if (ent:GetClass() == "class C_ClientRagdoll") then
		if ent:IsValid() and !(ent == NULL) then
			SafeRemoveEntityDelayed(ent, 5)
		end
	end
	
end
hook.Add("OnEntityCreated", "RemoveDeadRag", RemoveDeadRag)

hook.Add( "HUDShouldDraw", "hide hud", function( name )
     if ( name == "CHudHealth" or name == "CHudBattery" ) then
         return false
     end
end )
