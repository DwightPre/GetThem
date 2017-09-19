include( 'shared.lua' )
include("cl_score.lua")
include("cl_shop.lua")
include("playerInfo.lua")

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

function RemoveDeadRag( ent )

	if (ent == NULL) or (ent == nil) then return end
	if (ent:GetClass() == "class C_ClientRagdoll") then
		if ent:IsValid() and !(ent == NULL) then
			SafeRemoveEntityDelayed(ent, 5)
			--game.RemoveRagdolls()
		end
	end

end
hook.Add("OnEntityCreated", "RemoveDeadRag", RemoveDeadRag)
