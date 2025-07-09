-------------------------------------------------------
-- Material Overlay 1.0 - Garry Newman 17th Dec 2005 --
-------------------------------------------------------


function pp_DrawOverlay( )

	-- Switched off
	if ( convar.GetString( "pp_overlay" ) == "" ) then return end


	-- Update the effect textures
	mat.UpdateScreenEffectTexture()
	mat.UpdateRefractTexture()


	-- Find the material - it sucks to do this every frame but whatever.
	local pMat =  mat.GetMaterial( convar.GetString( "pp_overlay" ) )


	-- Remove some variables to make it not look like ass (We should set these back after but it's late)
	mat.SetMaterialVar_Num( pMat, "$envmap", 0 )
	mat.SetMaterialVar_Num( pMat, "$envmaptint", 0 )


	-- Set the refraction from the console command
	mat.SetMaterialVar_Num( pMat, "$refractamount", convar.GetFloat( "pp_overlay_refractamount" ) )


	mat.IdentityMatrix()
	mat.DrawScreenSpaceQuad( pMat )
	mat.PopMatrix()

end


AddHook( "DrawSceneFinished", pp_DrawOverlay )


