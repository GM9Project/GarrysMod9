include( 'shared.lua' )
include( 'cl_hud.lua' )
include( 'skin.lua' )
include( 'vgui_compass.lua' )

/*
	Create fonts
*/
surface.CreateFont( "coolvetica", 48, 500, true, false, "MelonLarge" )
surface.CreateFont( "coolvetica", 26, 500, true, false, "MelonMedium" )

local sndCountDown = Sound( "hl1/fvox/bell.wav" )
local sndGo = Sound( "plats/elevbell1.wav" )
local sndWrongWay = Sound( "buttons/button8.wav" )


/*

 Here the VGUI panel containing all the winner screen info is in the one file.
 
 We load it from the file, into a table using vgui.RegisterFile.
 
 We then create a vgui panel from that table.
 
 The PlayerWin function receives a usermessage from the server when a player
   has won. It shows the winner vgui, and sets a timer to close it.

*/

local pnlWinnerScreen = vgui.RegisterFile( "vgui_winnerscreen.lua" )
local WinnerVGUI = vgui.CreateFromTable( pnlWinnerScreen )

local function PlayerWin( m )

	local HideTime =  m:ReadLong() - CurTime()
	local WinnerName = m:ReadString()
	local Wins = m:ReadLong()

	WinnerVGUI:SetWinner( WinnerName, Wins )
	WinnerVGUI:Show()
	
	timer.Simple( HideTime, function() WinnerVGUI:Hide() end )
	
end

usermessage.Hook( "PlayerWin", PlayerWin )

/*

	This is called from the server for all of the countdown letters.
	
	It creates sprites and animates them. They are automatically 
	 deleted because SetTerm is called.
	 
*/
function FireCountdown( name )

	surface.PlaySound( sndCountDown )
	SplashSlow( name )
	
end

function WrongWay( name )

	surface.PlaySound( sndWrongWay )
	SplashSlow( name )
	
end

function SplashSlow( name )

	local sprite = CreateSprite( Material(name) )
	
	sprite:SetTerm( 1 )
	sprite:SetPos( ScrW()*0.5, ScrH() * 0.3 )
	sprite:SetSize( 10, 10 )
	sprite:SetColor( Color(0,0,0,255) )
	
	sprite:SizeTo( ScrH() * 0.4, ScrH() * 0.4, 0.3, 0 )
	sprite:ColorTo( Color(255, 255, 255, 255), 0.3, 0 )
	
	sprite:ColorTo( Color(255, 255, 255, 0), 0.5, 0.5 )
	sprite:MoveTo( ScrW()*0.5, ScrH() * 0.1, 0.5, 0.5 )
	sprite:SizeTo( ScrH() * 0.3, ScrH() * 0.7, 0.5, 0.5 )
	
	SplashFade( name )
	
end

/*

	As above, but a slightly different effect for the "go"
	
*/
function FireGo( name )

	SplashFade( name )
	surface.PlaySound( sndGo )
	
end

function SplashFade( name )

	local sprite = CreateSprite( Material(name) )
	sprite:SetTerm( 0.5 )
	sprite:SetPos( ScrW()*0.5, ScrH() * 0.3 )
	sprite:SetSize( 10, 10 )
	sprite:SetColor( Color(255,255,255,255) )
	
	sprite:SizeTo( ScrH() * 0.6, ScrH() * 0.6, 0.5, 0 )
	sprite:ColorTo( Color(255, 255, 255, 0), 0.5, 0 )
	
end

/*

	A quick and dirty "get ready" sign, to explain the lack of controls on the starting line.
	
	Although this seems easy and a good idea, it isn't. This is called using BroadcastLua on the
	 server. Which means that if anyone joins after that has been called, but before the race has 
	 started, they won't see it.
	
*/
function PreStart( timestart )

	local TimeTo = timestart - CurTime()
	local InTime = 1
	
	local top = VGUIRect( 0, 0, ScrW(), 50 )
		top:SetTerm( TimeTo )
		top:SetColor( Color( 0,0,0, 255 ) )
		top:MoveTo( 0, top:GetTall() * -1, InTime, TimeTo-InTime, 2 )
		
	local lbl = vgui.Create( "DLabel", top )
		lbl:SetText( "Get Ready!" )
		lbl:SetFont( "MelonLarge" )
		lbl:SetTextColor( Color(255, 255, 255, 200) )
		lbl:SizeToContents()
		lbl:Center()
		
end
