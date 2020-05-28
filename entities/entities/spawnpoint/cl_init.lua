include("shared.lua")
 
surface.CreateFont( "SpawnPointFont", {
	font = "DebugFixed",
	size = 20,
	antialias = true,
} )

function ENT:Draw()
	self:DrawModel()
	self.Entity:DrawModel()

	local str = self:GetNWString( "playerowner")
	local str2 = self:Health()
	local Pos = self:GetPos()
	local Ang = self:GetAngles()

	Ang:RotateAroundAxis(Ang:Up(), 90)
	cam.Start3D2D(Pos + Ang:Up() * 15, Ang, 0.090)
	surface.SetDrawColor( 0, 0, 0, 150 )
	surface.DrawRect( -75, -75, 150, 140 )
	surface.SetDrawColor(self:GetColor())
	surface.DrawOutlinedRect( -75, -75, 150, 140 )

	draw.SimpleText( "Spawn Point:", "SpawnPointFont", 0, -55, Color(221,70,55), 1, 0 )
	draw.SimpleText( "" .. tostring(str), "SpawnPointFont", 0, -10, Color( 255,255,255 ), 1, 0 )
	draw.SimpleText( "(" .. tostring(str2).. ")", "SpawnPointFont", 0, 20, Color( 255,255,255 ), 1, 0 )
	cam.End3D2D()
end

function ENT:DrawTranslucent()
	self:Draw()
end