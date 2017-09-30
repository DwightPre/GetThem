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
