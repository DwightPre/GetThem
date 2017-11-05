include("shared.lua")

if CLIENT then
function ENT:Draw()
	self.Entity:DrawModel()
	
	
	local str = 10
	local height = self.Entity:Health()

	local Pos = self:GetPos()
	local Ang = self:GetAngles()

	Ang:RotateAroundAxis(Ang:Up(), 90)

	cam.Start3D2D(Pos + Ang:Up() * 20, Ang, 0.090)
	--surface.SetDrawColor( 0, 0, 0, 150 )
	--urface.DrawRect( -300, -100, 600, 178 )
	--surface.SetDrawColor( Color( 229,228,55 ))
	--surface.DrawOutlinedRect( -300, -100, 600, 178 )

	--draw.SimpleText( "Prop Health", "DermaLarge", 0, -55, Color( 255,255,255 ), 1, 0 )
	draw.SimpleText( "".. tostring(height) , "DermaLarge", 0, -10, Color( 255,255,255 ), 1, 0 )
	draw.RoundedBox( 12, -130, 20, height /2, 20,  Color( 229,228,55 ) ) 
	cam.End3D2D()

	end

	function ENT:DrawTranslucent()
		self:Draw()
	end
end