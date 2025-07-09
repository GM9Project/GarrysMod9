--------------------------------------------------
-- Motion Blur 1.0 - Garry Newman 17th Dec 2005 --
--------------------------------------------------


if ( gStMoBlur == nil ) then

	gStMoBlur  = {}

end



-- Initialize - cache stuff.
function pp_DrawMotionBlurInit( )

	gStMoBlur.matMoBlur = mat.GetMaterial( "gmod/motionblur" )
	gStMoBlur.matScreen = mat.GetMaterial( "gmod/fb" )
	gStMoBlur.texMoBlur = mat.GetMoBlurTex()
	gStMoBlur.NextUpdate = 0

end



function pp_DrawMotionBlur( )

	if ( convar.GetInt( "pp_motionblur" ) == 0 ) then return end


	-- camera!
	mat.UpdateScreenEffectTexture()
	mat.IdentityMatrix()


	-- Update the buffer with the current screen
	if ( gStMoBlur.NextUpdate <= game.CurTime() ) then

		mat.SetMaterialVar_Num( gStMoBlur.matScreen, "$alpha", convar.GetFloat( "pp_motionblur_addalpha" ) )
		mat.SetMaterialVar_Num( gStMoBlur.matScreen, "$blur", 1 )
		
		local pSavedRT = mat.GetRenderTarget()
		mat.SetRenderTarget( gStMoBlur.texMoBlur )
		 mat.DrawScreenSpaceQuad( gStMoBlur.matScreen )
		mat.SetRenderTarget( pSavedRT )

		gStMoBlur.NextUpdate = game.CurTime() + convar.GetFloat( "pp_motionblur_time" )

	end


	-- Draw the motion blur buffer to the screen
	mat.SetMaterialVar_Num( gStMoBlur.matMoBlur, "$alpha", convar.GetFloat( "pp_motionblur_drawalpha" ) )
	mat.SetMaterialVar_Tex( gStMoBlur.matMoBlur, "$basetexture", gStMoBlur.texMoBlur )
	mat.DrawScreenSpaceQuad( gStMoBlur.matMoBlur )

	mat.PopMatrix()

end



if ( gStMoBlur.InitHook ~= nil ) then UnHookEvent( gStMoBlur.InitHook ) end
if ( gStMoBlur.DrawHook ~= nil ) then UnHookEvent( gStMoBlur.DrawHook ) end

gStMoBlur.DrawHook = AddHook( "DrawSceneFinished", pp_DrawMotionBlur )
gStMoBlur.InitHook = AddHook( "LevelInitPreEntity", pp_DrawMotionBlurInit )

