include("shared.lua")

function ENT:Draw()
	self.Entity:DrawModel()
		
	local str = 10
	local height = self.Entity:Health()

	local Pos = self:GetPos() 
	local Ang = self:GetAngles()

	Ang:RotateAroundAxis(Ang:Up(), 90)
	cam.Start3D2D(Pos + Ang:Right() * 20, Ang, 0.080)
	draw.SimpleText( "".. tostring(height) , "DermaLarge", 0, -10, Color( 255,255,255 ), 1, 0 )
	draw.RoundedBox( 12, -130, 20, height /2, 20,  Color( 0,0,155 ) ) 
	cam.End3D2D()
	end
	/*
	--can be extremely expensive to process. 
	hook.Add( "PreDrawHalos", "AddHalos", function()
	halo.Add( ents.FindByClass( "gt_spike*" ), Color( 255, 0, 0 ), 5, 5, 2)
	end )
	*/

	function ENT:DrawTranslucent()
		self:Draw()
	end