AddCSLuaFile()
LevelCurve = {}
LevelCurve[0] = 0
LevelCurve[1] =	0
LevelCurve[2] =	30
LevelCurve[3] =	91
LevelCurve[4] =	174
LevelCurve[5] =	276
LevelCurve[6] =	394
LevelCurve[7] =	527
LevelCurve[8] =	675
LevelCurve[9] =	836
LevelCurve[10] = 1009
LevelCurve[11] = 1194
LevelCurve[12] = 1391
LevelCurve[13] = 1599
LevelCurve[14] = 1817
LevelCurve[15] = 2046
LevelCurve[16] = 2285
LevelCurve[17] = 2533
LevelCurve[18] = 2792
LevelCurve[19] = 3059
LevelCurve[20] = 3335
LevelCurve[21] = 3621
LevelCurve[22] = 3914
LevelCurve[23] = 4217
LevelCurve[24] = 4528
LevelCurve[25] = 4847
LevelCurve[26] = 5174
LevelCurve[27] = 5509
LevelCurve[28] = 5852
LevelCurve[29] = 6203
LevelCurve[30] = 6561
LevelCurve[31] = 6927
LevelCurve[32] = 7300
LevelCurve[33] = 7680
LevelCurve[34] = 8068
LevelCurve[35] = 8462
LevelCurve[36] = 8864
LevelCurve[37] = 9273
LevelCurve[38] = 9688
LevelCurve[39] = 10111
LevelCurve[40] = 10540
LevelCurve[41] = 10975
LevelCurve[42] = 11418
LevelCurve[43] = 11866
LevelCurve[44] = 12322
LevelCurve[45] = 12783
LevelCurve[46] = 13251
LevelCurve[47] = 13726
LevelCurve[48] = 14206
LevelCurve[49] = 14693
LevelCurve[50] = 15186
LevelCurve[51] = 15685
LevelCurve[52] = 16190
LevelCurve[53] = 16700
LevelCurve[54] = 17217
LevelCurve[55] = 17740
LevelCurve[56] = 18268
LevelCurve[57] = 18803
LevelCurve[58] = 19343
LevelCurve[59] = 19889
LevelCurve[60] = 20440
LevelCurve[61] = 20997
LevelCurve[62] = 21560
LevelCurve[63] = 22128
LevelCurve[64] = 22702
LevelCurve[65] = 23281
LevelCurve[66] = 23866
LevelCurve[67] = 24456
LevelCurve[68] = 25052
LevelCurve[69] = 25653
LevelCurve[70] = 26259
LevelCurve[71] = 26871
LevelCurve[72] = 27487
LevelCurve[73] = 28110
LevelCurve[74] = 28737
LevelCurve[75] = 29369
LevelCurve[76] = 30007
LevelCurve[77] = 30649
LevelCurve[78] = 31297
LevelCurve[79] = 31950
LevelCurve[80] = 32608
LevelCurve[81] = 33271
LevelCurve[82] = 33939
LevelCurve[83] = 34612
LevelCurve[84] = 35290
LevelCurve[85] = 35972
LevelCurve[86] = 36660
LevelCurve[87] = 37352
LevelCurve[88] = 38050
LevelCurve[89] = 38752
LevelCurve[90] = 39459
LevelCurve[91] = 40171
LevelCurve[92] = 40887
LevelCurve[93] = 41608
LevelCurve[94] = 42334
LevelCurve[95] = 43065
LevelCurve[96] = 43800
LevelCurve[97] = 44541
LevelCurve[98] = 45285
LevelCurve[99] = 46034
LevelCurve[100] = 46788

if (SERVER) then
//---------------//
//LEVELXP&TOKEN	//
//--------------//

local meta = FindMetaTable("Player")

function meta:AddLevel( amount )
	self:SetLevel( self:GetLevel() + amount )
end

function meta:LevelUp( amount )
	self:SetNetworkedInt( "level", amount + 1 )
	self:PrintMessage( HUD_PRINTTALK, "[GetThem]Level up! ")
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
/*
function playerMeta:IsLevel(amount)
	return (self:GetLevel() - amount) >= 0
end
*/
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