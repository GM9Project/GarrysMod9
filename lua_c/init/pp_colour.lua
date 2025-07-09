-------------------------------------------------
-- Colour Mod 1.0 - Garry Newman 17th Dec 2005 --
-------------------------------------------------


if ( gStColour == nil ) then

	gStColour  = {}

end



-- Initialize - cache stuff.
function pp_DrawColourInit( )

	gStColour.matColour = mat.GetMaterial( "pp/colour" )

end



function pp_DrawColour( )

	if ( mat.GetDXLevel() < 80 ) then return end
	if ( not mat.SupportsPixelShaders_2_0() ) then return end
	if ( convar.GetInt( "pp_colour" ) == 0 ) then return end

	mat.UpdateScreenEffectTexture()

	-- Bah - I really need an "if changed" kind of thing.
	mat.SetMaterialVar_Num( gStColour.matColour, "$pp_colour_addr", convar.GetFloat( "pp_colour_addr" ) )
	mat.SetMaterialVar_Num( gStColour.matColour, "$pp_colour_addg", convar.GetFloat( "pp_colour_addg" ) )
	mat.SetMaterialVar_Num( gStColour.matColour, "$pp_colour_addb", convar.GetFloat( "pp_colour_addb" ) )
	mat.SetMaterialVar_Num( gStColour.matColour, "$pp_colour_brightness", convar.GetFloat( "pp_colour_brightness" ) )
	mat.SetMaterialVar_Num( gStColour.matColour, "$pp_colour_contrast", convar.GetFloat( "pp_colour_contrast" ) )
	mat.SetMaterialVar_Num( gStColour.matColour, "$pp_colour_colour", convar.GetFloat( "pp_colour_colour" ) )
	mat.SetMaterialVar_Num( gStColour.matColour, "$pp_colour_mulr", convar.GetFloat( "pp_colour_mulr" ) )
	mat.SetMaterialVar_Num( gStColour.matColour, "$pp_colour_mulg", convar.GetFloat( "pp_colour_mulg" ) )
	mat.SetMaterialVar_Num( gStColour.matColour, "$pp_colour_mulb", convar.GetFloat( "pp_colour_mulb" ) )


	mat.IdentityMatrix()
	mat.DrawScreenSpaceQuad( gStColour.matColour )
	mat.PopMatrix()

end



if ( gStColour.InitHook ~= nil ) then UnHookEvent( gStColour.InitHook ) end
if ( gStColour.DrawHook ~= nil ) then UnHookEvent( gStColour.DrawHook ) end

gStColour.DrawHook = AddHook( "DrawSceneFinished", pp_DrawColour )
gStColour.InitHook = AddHook( "LevelInitPreEntity", pp_DrawColourInit )

