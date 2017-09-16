
GM.Name 	= "GetThem"
GM.Author 	= "Dwight M."
GM.Email 	= ""
GM.Website 	= ""

team.SetUp( 1, "Blue", Color( 0, 0, 255, 255) )
team.SetUp( 2, "Red", Color( 255, 0, 0, 255) )

/*
function GM:Initialize()
	self.BaseClass.Initialize( self )
	--team.SetUp( 1, "Blue", Color( 0, 0, 255, 255) )
	--team.SetUp( 2, "Red", Color( 255, 0, 0, 255) )

end
--GM.NoPlayerSuicide 				= true	// Set to true to prevent players from committing suicide.



*/ 

/*function GM:CreateTeams()
   team.SetUp(1, "Blue", Color(0, 0, 255, 255), false)
   team.SetUp(2, "Red", Color(255, 0, 0, 255), false)

end
*/
DeriveGamemode( "base" )