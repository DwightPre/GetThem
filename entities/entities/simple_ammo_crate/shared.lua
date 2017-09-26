AddCSLuaFile()

ENT.Base = "base_entity"
ENT.Spawnable = true

maxtakes = 10

function ENT:Initialize()
end

if ( SERVER ) then
	include( "simple_ammo_crate.lua" )
else

local str = ""

	net.Receive("maxtakes", function()
	str = net.ReadString()
	end)

	function ENT:Draw()
	self:DrawModel()

	local Pos = self:GetPos()
	local Ang = self:GetAngles()

	Ang:RotateAroundAxis(Ang:Up(), 90)

	cam.Start3D2D(Pos + Ang:Up() * 16, Ang, 0.090)
	surface.SetDrawColor( 0, 0, 0, 150 )
	surface.DrawRect( -300, -100, 600, 178 )
	surface.SetDrawColor( Color( 229,228,55 ))
	surface.DrawOutlinedRect( -300, -100, 600, 178 )

	draw.SimpleText( "Ammo Crate ", "DermaLarge", 0, -55, Color( 255,255,255 ), 1, 0 )
	draw.SimpleText( "" .. str, "DermaLarge", 0, -10, Color( 255,255,255 ), 1, 0 )
	cam.End3D2D()

	end

	function ENT:DrawTranslucent()
		self:Draw()
	end

end
