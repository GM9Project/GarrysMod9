

-- bind b "clua_openscript  vgui_win.lua"



--if ( win == nil ) then

	TestWindow = {}

-- Main Window
	TestWindow.main = vgui.window.Create( "Garry's Test Window!" )
	vgui.SetScheme( TestWindow.main, "GModScheme" )
	vgui.window.SetSizeable( TestWindow.main, false )
	vgui.window.Popup( TestWindow.main )
	vgui.SetPos( TestWindow.main, 20, 20 );
	vgui.SetSize( TestWindow.main, ScreenWidth() / 2, 180 );
	
-- Small label
	TestWindow.toplabel = vgui.label.Create( "This is a LABEL!" )
	vgui.SetParent( TestWindow.toplabel, TestWindow.main )
	vgui.SetPos( TestWindow.toplabel, 30, 30 )
	vgui.SetSize( TestWindow.toplabel, 200, 30 )	

-- Big label
	TestWindow.biglabel = vgui.label.Create( "This is a different font!" )
	vgui.SetParent( TestWindow.biglabel, TestWindow.main )
	vgui.SetPos( TestWindow.biglabel, 30, 55 )
	vgui.SetSize( TestWindow.biglabel, 300, 30 )
	vgui.label.SetFont( TestWindow.biglabel, "SpawnMenuTitle" )

-- Big coloured label
	TestWindow.biglabel2 = vgui.label.Create( "This is a different colour!" )
	vgui.SetParent( TestWindow.biglabel2, TestWindow.main )
	vgui.SetPos( TestWindow.biglabel2, 30, 85 )
	vgui.SetSize( TestWindow.biglabel2, 300, 30 )
	vgui.label.SetFont( TestWindow.biglabel2, "SpawnMenuTitle" )

-- Big outlined label
	TestWindow.biglabel3 = vgui.label.Create( "This is bloody outlined!" )
	vgui.SetParent( TestWindow.biglabel3, TestWindow.main )
	vgui.SetPos( TestWindow.biglabel3, 30, 120 )
	vgui.SetSize( TestWindow.biglabel3, 300, 30 )
	vgui.label.SetFont( TestWindow.biglabel3, "SpawnMenuTitle" )
	vgui.SetTextOutline( TestWindow.biglabel3, true, 0, 0, 0, 255 )


-- Say Hello to my little friend!
	TestWindow.button1 = vgui.button.Create( "Say Hello!" )
	vgui.button.SetConsoleCommand( TestWindow.button1, "say \"Hello.\"" )
	vgui.SetParent( TestWindow.button1, TestWindow.main )
	vgui.SetPos( TestWindow.button1, 300, 40 )
	vgui.SetSize( TestWindow.button1, 70, 23 )


-- Cheeky Button
	TestWindow.button2 = vgui.button.Create( "Cheeky Button!" )
	vgui.SetParent( TestWindow.button2, TestWindow.main )
	vgui.SetPos( TestWindow.button2, 300, 80 )
	vgui.SetSize( TestWindow.button2, 100, 23 )
	vgui.button.OnPress( TestWindow.button2, "TestWindow_MoveButton" )



	-- Tell the window panel to call this function when it applies the scheme settings.
	vgui.OnApplyScheme( TestWindow.main, "TestWindow_ApplyScheme" )
	vgui.OnPaint( TestWindow.main, "TestWindow_Paint" )

--end


function TestWindow_ApplyScheme( pPanel )

	-- Colours are set here because if they're automatically reverted back to the default
	-- scheme colour by the engine.. grr

	vgui.SetBgColor( pPanel, 50, 60, 70, 240 );
	vgui.SetBgFadeColor( pPanel, 30, 30, 40, 150 );
	vgui.SetFgColor( TestWindow.biglabel2, 100, 255, 100, 200 );
	vgui.SetFgColor( TestWindow.biglabel3, 30, 100, 30, 200 );

end


function TestWindow_MoveButton( pPanel )

	local x = vgui.PosX( pPanel )
	local y = vgui.PosY( pPanel )

	if (x ==300) then x = 390 else x = 300 end

	vgui.SetPos( pPanel, x, y )

end


function TestWindow_Paint( pPanel )


	if ( input.MouseDown( 0 ) ) then
		Msg("LEFT!!!");
	end

	if ( input.MouseDown( 1 ) ) then
		Msg("RIGHT!!!");
	end

--	Msg ( "X: " .. input.CursorX() .. " - Y:" .. input.CursorY() .. "\n" );

end



function InitCanvasMode( )

	ScreenMat = mat.GetMaterial( "gmod/fb" )
	CanvasTex = mat.GetMoBlurTex()

end

AddHook( "LevelInitPreEntity", InitCanvasMode )


function DrawCanvas( )

	-- camera!
	mat.IdentityMatrix()

	
	local pSavedRT = mat.GetRenderTarget()

	-- Draw onto canvas here
	mat.SetRenderTarget( CanvasTex )

	mat.Clear( 255, 255, 0, 0 );


	if ( input.MouseDown( 0 ) ) then
		mat.Clear( 255, 0, 0, 0 );
	end


	mat.SetRenderTarget( pSavedRT )



	mat.SetMaterialVar_Num( ScreenMat, "$alpha", 1.0 )
	mat.SetMaterialVar_Tex( ScreenMat, "$basetexture", CanvasTex )
	mat.DrawScreenSpaceQuad( ScreenMat )
	mat.PopMatrix()

end

AddHook( "DrawSceneFinished", DrawCanvas )
