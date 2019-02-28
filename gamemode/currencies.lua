AddCSLuaFile()

if (SERVER) then
//---------------//
// 	XP&TOKEN	//
//--------------//

local meta = FindMetaTable("Player")

function meta:AddLevel( amount )
	self:SetLevel( self:GetLevel() + amount )
end

function meta:LevelUp( amount )
	self:SetNetworkedInt( "level", amount + 1 )
	self:SaveLevel()
end

function meta:SaveLevel()
	local Level = self:GetLevel()
	self:SetPData( "level", Level )
end

function meta:SaveLevelTXT()
	file.Write( gmod.GetGamemode().Name .."/Level/".. string.gsub(self:SteamID(), ":", "_") ..".txt", tostring(self:GetLevel()) )
end

function meta:TakeLevel( amount )
   self:AddLevel( -amount )
end

function meta:GetLevel()
	return self:GetNetworkedInt( "level" )
end

function meta:SetLevel( amount )
	self:SetNetworkedInt( "level", amount )
	self:SaveLevel()
end

function meta:SetLevelExp( amount )
	self:SetNetworkedInt( "levelXP", amount )
	self:SaveLevelExp()
end

function meta:SaveLevelExp()
	local LevelXP = self:GetLevelXP()
	self:SetPData( "levelXP", LevelXP )
end

function meta:CanLevelUp( level, xp)
	totalxp = LevelCurve[level]
	if (xp >= totalxp) then
		self:LevelUp(level)
		self:SetLevelExp(xp - totalxp)
	end
end

------------------------

function meta:AddLevelXP( amount )
	self:SetLevelExp( self:GetLevelXP() + amount )
end

function meta:SaveLevelXPTXT()
	file.Write( gmod.GetGamemode().Name .."/LevelXP/".. string.gsub(self:SteamID(), ":", "_") ..".txt", tostring(self:GetLevelXP()) )
end

function meta:TakeLevelXP( amount )
   self:AddLevelXP( -amount )
end

function meta:GetLevelXP()
	return self:GetNetworkedInt( "levelXP" )
end

----------------------------

util.AddNetworkString( "Notification" )

function meta:SendNotification( ply, message )
	--local ply = Entity( 1 )	
	if string.find(string.lower(message), "-") then
		net.Start( "Notification" )
		net.WriteString("" .. message)
		net.WriteDouble(2)
		net.Send( ply)
	else
		net.Start( "Notification" )
		net.WriteString("+ " .. message)
		net.WriteDouble(2) 
		net.Send( ply )
	end
end

function meta:AddXp( amount ,ply )
	local current_xp = self:GetXp()
	local TotalEarndxp = ( current_xp + amount )
	self:SendNotification( ply, amount )	
		
	if string.find(string.lower(amount), "-")then
		self:SetXp( current_xp + amount )
	else	
		timer.Create( "counting", 0.02, amount, function()
		self:SetXp(self:GetXp() +1)
	end)
	
	if current_xp == TotalEarndxp then
		timer.Stop( "counting")
	end	
	end	
end

function meta:SetXp( amount )
	self:SetNetworkedInt( "Xp", amount )
	self:SaveXp()
end

function meta:SaveXp()
	local experience = self:GetXp()
	self:SetPData( "xp", experience )
end

function meta:SaveXpTXT()
	file.Write( gmod.GetGamemode().Name .."/Xp/".. string.gsub(self:SteamID(), ":", "_") ..".txt", tostring(self:GetXp()) )
end

function meta:TakeXp( amount ,ply )
   self:AddXp( -amount ,ply )
end

function meta:GetXp()
	return self:GetNetworkedInt( "Xp" )
end
--
function meta:AddToken( amount )
	local current_token = self:GetToken()
	self:SetToken( current_token + amount )
end

function meta:SetToken( amount )
	self:SetNetworkedInt( "Token", amount )
	self:SaveToken()
end

function meta:SaveToken()
	local cash = self:GetToken()
	self:SetPData( "token", cash )
end

function meta:SaveTokenTXT()
	file.Write( gmod.GetGamemode().Name .."/Token/".. string.gsub(self:SteamID(), ":", "_") ..".txt", tostring(self:GetToken()) )
end

function meta:TakeToken( amount )
   self:AddToken( -amount )
end

function meta:GetToken()
	return self:GetNetworkedInt( "Token" )
end
--

end