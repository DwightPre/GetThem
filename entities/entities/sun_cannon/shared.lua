ENT.Type = "anim"
--ENT.Base = "base_gmodentity"
ENT.PrintName = "Sun Cannon"
ENT.Author = "Gnossienne"
ENT.Spawnable = true
ENT.AdminSpawnable = true

function SpawnSunCannon(ply, cmd, args)
	local trace = {}
	trace.start = ply:EyePos()
	trace.endpos = trace.start + ply:GetAimVector() * 1000
	trace.filter = ply
	local tr = util.TraceLine(trace)
	ent = ents.Create("sun_cannon")
	ent:SetPos(tr.HitPos)
	ent:Spawn()
end
concommand.Add( "Spawn_Sun_Cannon", SpawnSunCannon)
