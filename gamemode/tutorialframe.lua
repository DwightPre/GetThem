AddCSLuaFile()
if (SERVER) then
	
util.AddNetworkString( "ShowTutorial" ) 

  function TutorialFunc( ply, cmd, args )
    if(gmod.GetGamemode().Name == "GetThem") then	
      net.Start("ShowTutorial")
      net.Send(ply)
    end
  end
  concommand.Add( "Tutorial", TutorialFunc )
  
end
if (CLIENT) then

net.Receive( "ShowTutorial", function()
	
	if not IsValid(Tutorialframe) then	
  Tutorialframe = vgui.Create( "DFrame" )
	Tutorialframe:SetSize(380, 230)
	Tutorialframe:Center()
	Tutorialframe:SetTitle(" ")
	Tutorialframe:SetDraggable(true)
	Tutorialframe:SetSizable(false)
	Tutorialframe:ShowCloseButton(true)
	Tutorialframe:MakePopup()
	Tutorialframe.Paint = function(self, w, h) draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0, 255 ) ) end
	
	local BigTextDLabel = vgui.Create( "DLabel", Tutorialframe )
	BigTextDLabel:SetPos( 6, -85 )
	BigTextDLabel:SetSize(365, 200)
	BigTextDLabel:SetFont( "Trebuchet24" )
	BigTextDLabel:SetText( "How To Play Get Them" )
	BigTextDLabel:SetColor( Color( 255, 0, 0 ) )
	
	local TextDLabel = vgui.Create( "DLabel", Tutorialframe )
	TextDLabel:SetPos( 6, 5 )
	TextDLabel:SetSize(365, 200)
	TextDLabel:SetFont( "Trebuchet18" )
	TextDLabel:SetText( "\n- Try to hide as many chickens as possible to receive bonuses!" ..
	"\n- Keep your team's score alive by defending your chickens!"..
	"\n- Search other's team chickens - kill them!"..
	"\n"..
	"\n- F1 for Shop - buy weapons, armor,.."..
	"\n- F2 for Token Shop"..
	"\n"..
	"\n- Unlock different abilities to make the game even better!"..
	"\n")	
	
	local PlayButton = vgui.Create( "DButton", Tutorialframe ) 
	PlayButton:SetText( "I'll got it!" )					
	PlayButton:SetPos( 110, 190 )
	PlayButton:SetSize( 150, 30 )					
	PlayButton.DoClick = function()	
	Tutorialframe:Close()
	RunConsoleCommand( "MiniGame" )			
  end

	end
	
end)

end