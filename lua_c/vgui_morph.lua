
CONCOMMAND( "morph", cc_Morph )
function cc_Morph()
	vgui.window.Popup( gMorph.Windows.main )
end


function Morph_Clear()
	gMorph.Clear = true
end

function Morph_Buff_refBl()
	gMorph.CanvasMat = gMorph.CanvasMat_Blur
end

function Morph_Buff_ref()
	gMorph.CanvasMat = gMorph.CanvasMat_Normal
end

function Morph_Buff_nrm()
	gMorph.CanvasMat = gMorph.CanvasMat_Plain
end

function morph_refractsize( Obj )
	gMorph.Refraction = vgui.slider.GetValue( Obj )
end

function morph_brushsize( Obj )
	gMorph.BrushSize = vgui.slider.GetValue( Obj )
end


--if ( gMorph ~= nil ) then

	gMorph = {}
	gMorph.Windows = {}
	gMorph.Brush = {}
	gMorph.Brush[0] = mat.GetMaterial( "gmod/morph/brush1" )

	gMorph.BrushSize = 100
	gMorph.Alpha = 0.03

	gMorph.Refraction = 0.30

	gMorph.CanvasMat_Normal = mat.GetMaterial( "gmod/morph/refract" )
	gMorph.CanvasMat_Blur = mat.GetMaterial( "gmod/morph/refract_blur" )
	gMorph.CanvasMat_Plain = mat.GetMaterial( "gmod/fb" )

	gMorph.CanvasMat = gMorph.CanvasMat_Normal

	gMorph.CanvasTex = mat.GetMoBlurTex()

	gMorph.Clear = true

	gMorph.CurPos = {}
	gMorph.CurPos.x = 0
	gMorph.CurPos.y = 0

	gMorph.Windows.main = vgui.window.Create( "Morph" )
	vgui.SetScheme( gMorph.Windows.main, "GModScheme" )
	vgui.window.SetSizeable( gMorph.Windows.main, false )
	vgui.window.Popup( gMorph.Windows.main )
	vgui.SetPos( gMorph.Windows.main, 20, 50 );
	vgui.SetSize( gMorph.Windows.main, 150, 300 );

	local Btn = 0
	Btn = vgui.button.Create( "Clear Morphing" )
	vgui.SetParent( Btn, gMorph.Windows.main )
	vgui.SetPos( Btn, 10, 25 )
	vgui.SetSize( Btn, 130, 23 )
	vgui.button.OnPress( Btn, "Morph_Clear" )

	Btn = vgui.button.Create( "Screenshot" )
	vgui.SetParent( Btn, gMorph.Windows.main )
	vgui.SetPos( Btn, 10, 55 )
	vgui.SetSize( Btn, 130, 23 )
	vgui.button.SetConsoleCommand( Btn, "jpeg" )

	Btn = vgui.button.Create( "Rfrct" )
	vgui.SetParent( Btn, gMorph.Windows.main )
	vgui.SetPos( Btn, 10, 85 )
	vgui.SetSize( Btn, 40, 23 )
	vgui.button.OnPress( Btn, "Morph_Buff_ref" )

	Btn = vgui.button.Create( "Rf Blr" )
	vgui.SetParent( Btn, gMorph.Windows.main )
	vgui.SetPos( Btn, 55, 85 )
	vgui.SetSize( Btn, 40, 23 )
	vgui.button.OnPress( Btn, "Morph_Buff_refBl" )

	Btn = vgui.button.Create( "Nrmal" )
	vgui.SetParent( Btn, gMorph.Windows.main )
	vgui.SetPos( Btn, 100, 85 )
	vgui.SetSize( Btn, 40, 23 )
	vgui.button.OnPress( Btn, "Morph_Buff_nrm" )

	Btn = vgui.slider.Create( "", "Brush Size" )
	vgui.slider.SetRange( Btn, 10, 300, true )
	vgui.SetParent( Btn, gMorph.Windows.main )
	vgui.SetPos( Btn, 10, 120 )
	vgui.SetSize( Btn, 130, 28 )
	vgui.slider.OnChange( Btn, "morph_brushsize" )
	vgui.slider.SetValue( Btn, gMorph.BrushSize )

	Btn = vgui.slider.Create( "", "Refraction Size" )
	vgui.slider.SetRange( Btn, -1, 1, true )
	vgui.SetParent( Btn, gMorph.Windows.main )
	vgui.SetPos( Btn, 10, 150 )
	vgui.SetSize( Btn, 130, 28 )
	vgui.slider.OnChange( Btn, "morph_refractsize" )
	vgui.slider.SetValue( Btn, gMorph.Refraction )

--end


function DrawMorph( )

	mat.UpdateScreenEffectTexture()
	mat.IdentityMatrix()


	local iHoverPanel = vgui.GetMouseOver()


	if (vgui.CursorVisible() and iHoverPanel == nil ) then
	
		local pSavedRT = mat.GetRenderTarget()

		-- Draw onto canvas here
		mat.SetRenderTarget( gMorph.CanvasTex )

		if (gMorph.Clear) then
			gMorph.Clear = false
			mat.Clear( 128, 128, 128, 255 )
		end

	
		if (input.MouseDown( MOUSE_LEFT )) then
	
			if ( gMorph.CurPos.x > 0 ) then
 
				local r = ((gMorph.CurPos.x - input.CursorX()) * 0.01) + 0.5
				local g = ((gMorph.CurPos.y - input.CursorY()) * 0.01) + 0.5

				sprite2d.SetColor( 0.03, r, g, 0.5 )
				sprite2d.SetMat( gMorph.Brush[0] )
				sprite2d.DrawSprite( input.CursorX(), input.CursorY(), gMorph.BrushSize, gMorph.BrushSize );

			end

		else

			gMorph.CurPos.x = 0
			gMorph.CurPos.y = 0

		end


		mat.SetRenderTarget( pSavedRT )

	end

	if (gMorph.CanvasMat == gMorph.CanvasMat_Plain ) then
		mat.SetMaterialVar_Tex( gMorph.CanvasMat, "$basetexture", gMorph.CanvasTex )
	else
		mat.SetMaterialVar_Num( gMorph.CanvasMat, "$refractamount", gMorph.Refraction )
		mat.SetMaterialVar_Tex( gMorph.CanvasMat, "$normalmap", gMorph.CanvasTex )
		--mat.SetMaterialVar_Tex( gMorph.CanvasMat, "$dudvmap", gMorph.CanvasTex )

	end

	mat.DrawScreenSpaceQuad( gMorph.CanvasMat )


	if ( vgui.CursorVisible() and iHoverPanel == nil ) then

		-- Draw our brush
		sprite2d.SetColor( 1, 1, 1, 1 )
		sprite2d.SetMat( gMorph.Brush[0] )
		sprite2d.DrawSprite( input.CursorX(), input.CursorY(), gMorph.BrushSize, gMorph.BrushSize );

		gMorph.CurPos.x = input.CursorX()
		gMorph.CurPos.y = input.CursorY()

	end

	mat.PopMatrix()


end


if ( gMorph.DrawHook ~= nil ) then

	UnHookEvent( gMorph.DrawHook )
	gMorph.DrawHook = nil

end


gMorph.DrawHook = AddHook( "DrawSceneFinished", DrawMorph )
