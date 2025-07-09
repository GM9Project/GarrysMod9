--------------------------------------------
-- Bloom 1.0 - Garry Newman 17th Dec 2005 --
--------------------------------------------



-- A table to hold the bloom settings

if ( gStBloom == nil ) then

	gStBloom = {}

end



-- Initialize - cache stuff.
function pp_DrawBloomInit( )

	Msg("Bloom initialized\n")

	-- Load the materials we're going to use.

	gStBloom.matDownsample = mat.GetMaterial( "pp/g_downsample" )
	gStBloom.matBlurX = mat.GetMaterial( "pp/g_blurx" )
	gStBloom.matBlurY = mat.GetMaterial( "pp/g_blury" )
	gStBloom.matBloom = mat.GetMaterial( "pp/g_bloom" )


	-- Cache the textures we'll use

	gStBloom.texBloom0 = mat.GetBloomTex0()
	gStBloom.texBloom1 = mat.GetBloomTex1()

end



function pp_DrawBloom( )

	-- No bloom for people with shit graphics cards.
	if ( mat.GetDXLevel() < 80 ) then return end
	if ( not mat.SupportsPixelShaders_2_0() ) then return end

	-- Switched off
	if ( convar.GetInt( "pp_bloom" ) == 0 ) then return end


	-- Copy the screen to the effect texture
	mat.UpdateScreenEffectTexture()


	-- Store the last render target so we can set it back.
	local pLastRT = mat.GetRenderTarget()


	-- Set the material variables from the console commands
	mat.SetMaterialVar_Tex( gStBloom.matBlurX, "$basetexture", gStBloom.texBloom0 )
	mat.SetMaterialVar_Tex( gStBloom.matBlurY, "$basetexture", gStBloom.texBloom1 )
	mat.SetMaterialVar_Tex( gStBloom.matBloom, "$basetexture", gStBloom.texBloom0 )

	mat.SetMaterialVar_Num( gStBloom.matBlurX, "$size", convar.GetFloat( "pp_bloom_sizeh" ) )
	mat.SetMaterialVar_Num( gStBloom.matBlurY, "$size", convar.GetFloat( "pp_bloom_sizev" ) )
	local fColor = convar.GetFloat( "pp_bloom_colour" )
	mat.SetMaterialVar_Num( gStBloom.matBloom, "$levelr", convar.GetFloat( "pp_bloom_levelr" ) * fColor )
	mat.SetMaterialVar_Num( gStBloom.matBloom, "$levelg", convar.GetFloat( "pp_bloom_levelg" ) * fColor )
	mat.SetMaterialVar_Num( gStBloom.matBloom, "$levelb", convar.GetFloat( "pp_bloom_levelb" ) * fColor )
	mat.SetMaterialVar_Num( gStBloom.matDownsample, "$darken", convar.GetFloat( "pp_bloom_darken" ) )
	mat.SetMaterialVar_Num( gStBloom.matDownsample, "$multiply", convar.GetFloat( "pp_bloom_multiply" ) )


	-- Set the camera so it's easier to draw a quad
	mat.IdentityMatrix()

	
	-- Downsample
	mat.SetRenderTarget( gStBloom.texBloom0 )
	mat.DrawScreenSpaceQuad( gStBloom.matDownsample )

	-- Do blur

	for i=1, convar.GetInt( "pp_bloom_blurpasses" ) do

		mat.SetRenderTarget( gStBloom.texBloom1 )
		mat.DrawScreenSpaceQuad( gStBloom.matBlurX )

		mat.SetRenderTarget( gStBloom.texBloom0 )
		mat.DrawScreenSpaceQuad( gStBloom.matBlurY )

	end

	-- Draw to the screen
	mat.SetRenderTarget( pLastRT )
	mat.DrawScreenSpaceQuad( gStBloom.matBloom )


	-- Return the camera
	mat.PopMatrix()

end



-- If we're reloading the script then remove the old hooks (this is really just a development thing)

if ( gStBloom.InitHook ~= nil ) then UnHookEvent( gStBloom.InitHook ) end
if ( gStBloom.DrawHook ~= nil ) then UnHookEvent( gStBloom.DrawHook ) end


-- Register the hooks so our functions will actually do stuff.

gStBloom.DrawHook = AddHook( "DrawSceneFinished", pp_DrawBloom )
gStBloom.InitHook = AddHook( "LevelInitPreEntity", pp_DrawBloomInit )

