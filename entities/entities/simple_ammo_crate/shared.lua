AddCSLuaFile()

ENT.Base = "base_entity"
ENT.Spawnable = true

function ENT:Initialize()
end

if ( SERVER ) then
	include( "simple_ammo_crate.lua" )
else
	function ENT:Draw()
		self:DrawModel()
	end
	function ENT:DrawTranslucent()
		self:Draw()
	end
end
