include( 'shared.lua' )
include("cl_score.lua")
include("cl_shop.lua")
include("playerInfo.lua")
include("rounds.lua")


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
local DrawImage = net.ReadDouble()

	--Panel
	NotifyPanel = vgui.Create( "DNotify" )
	NotifyPanel:SetPos(ScrW()/1.17, ScrH()/8.9)
	NotifyPanel:SetLife(2)
	if NotificationLenght < 6 then NotifyPanel:SetSize( 180, 51.2 )
	else
	NotifyPanel:SetSize( 180, 80 )
	NotifyPanel:SetLife(5)
	end

	--Background
	local Background = vgui.Create( "DPanel", NotifyPanel )
	Background:Dock( FILL )
	Background:SetBackgroundColor(  Color(64, 64, 64, 155) )

	--Label
	local lbl = vgui.Create( "DLabel", Background )
	lbl:SetPos( 10, -10)
	lbl:SetAutoStretchVertical()
	lbl:SetSize( 130, 72 )
	lbl:SetText( "" )
	lbl:SetText( Notification )
	lbl:SetTextColor( Color( 255, 200, 0 ) )
	lbl:SetFont( "DermaLarge" )
	lbl:SetWrap( true )	
	if NotificationLenght < 6 then lbl:SetPos( 10, -10) else lbl:SetPos( 10, 5) end
	
	--Images
	if DrawImage == 2 then
	local DollarIMG = vgui.Create( "DImage", Background )
	DollarIMG:SetPos( 136, 5 )	
	DollarIMG:SetSize( 40, 40 )
	DollarIMG:SetImage( "icon16/money_dollar.png" )
	elseif DrawImage == 3 then
	local CancelIMG = vgui.Create( "DImage", Background )
	CancelIMG:SetPos( 136, 20 )	
	CancelIMG:SetSize( 40, 40 )
	CancelIMG:SetImage( "icon16/cancel.png" )
	end
	
	NotifyPanel:AddItem( Background )	
end)

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