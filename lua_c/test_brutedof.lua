-------------------------------------------------
-- Proper DOF 1.0 - Garry Newman 22nd Dec 2005 --
-------------------------------------------------

if ( gStPDOF == nil ) then gStPDOF = {} end

function pp_DrawProperDOFInit( )

	gStPDOF.matMoBlur = mat.GetMaterial( "gmod/motionblur" )
	gStPDOF.matScreen = mat.GetMaterial( "gmod/fb" )
	gStPDOF.texMoBlur = mat.GetMoBlurTex()

end



gStPDOF.Passes = 5.0
gStPDOF.Mult = 1.9


function SetAimPos( vOffset )

	render.SetViewOrigin( vOffset );

	local vAimAngle = vector3( 0, 0, 0 );
	vAimAngle.x = EndPos.x - vOffset.x;
	vAimAngle.y = EndPos.y - vOffset.y;
	vAimAngle.z = EndPos.z - vOffset.z;

	render.SetViewAngles( VectorAngles(vAimAngle) );

end

function DoScene( vOffset, fAlpha )

	vOffset.x =  (vOffset.x * gStPDOF.Mult * fAlpha )
	vOffset.y =  (vOffset.y * gStPDOF.Mult * fAlpha )
	vOffset.z =  (vOffset.z * gStPDOF.Mult * fAlpha )

	SetAimPos( vector3(gStPDOF.SaveVO.x + vOffset.x, gStPDOF.SaveVO.y + vOffset.y, gStPDOF.SaveVO.z + vOffset.z) );
	render.RenderView();

	mat.SetMaterialVar_Num( gStPDOF.matScreen, "$alpha",  0.5  )
	mat.SetMaterialVar_Num( gStPDOF.matScreen, "$blur", 0 )
	mat.SetRenderTarget( gStPDOF.texMoBlur )
	mat.DrawScreenSpaceQuad( gStPDOF.matScreen )
	mat.SetRenderTarget( gStPDOF.pSavedRT )
	mat.UpdateScreenEffectTexture()

	SetAimPos( vector3(gStPDOF.SaveVO.x - vOffset.x, gStPDOF.SaveVO.y - vOffset.y, gStPDOF.SaveVO.z - vOffset.z) );
	render.RenderView();

	mat.SetMaterialVar_Num( gStPDOF.matScreen, "$alpha",  0.5 )
	mat.SetMaterialVar_Num( gStPDOF.matScreen, "$blur", 0 )
	mat.SetRenderTarget( gStPDOF.texMoBlur )
	mat.DrawScreenSpaceQuad( gStPDOF.matScreen )
	mat.SetRenderTarget( gStPDOF.pSavedRT )
	mat.UpdateScreenEffectTexture()

	
end


function pp_DrawProperDOF( )

	mat.IdentityMatrix()
	gStPDOF.pSavedRT = mat.GetRenderTarget()
	gStPDOF.SaveVO = render.GetViewOrigin();
	gStPDOF.SaveVA = render.GetViewAngles();

	local vRight = VectorRight( gStPDOF.SaveVA );
	local vUp = VectorUp( gStPDOF.SaveVA );

	trace.Line( gStPDOF.SaveVO, VectorForward(gStPDOF.SaveVA), 4096 )
	EndPos = trace.EndPos();


	mat.UpdateScreenEffectTexture()
	mat.SetMaterialVar_Num( gStPDOF.matScreen, "$alpha",  1.0  )
	mat.SetRenderTarget( gStPDOF.texMoBlur )
	mat.DrawScreenSpaceQuad( gStPDOF.matScreen )
	mat.SetRenderTarget( gStPDOF.pSavedRT )
	


	for i=0, gStPDOF.Passes do
		DoScene( vUp, (gStPDOF.Passes-i) / gStPDOF.Passes );
		DoScene( vRight,  (gStPDOF.Passes-i) / gStPDOF.Passes );
	end

	--mat.UpdateScreenEffectTexture()
	-- Draw the composure to the screen.
	mat.SetMaterialVar_Num( gStPDOF.matMoBlur, "$alpha", 0.5 )
	mat.SetMaterialVar_Tex( gStPDOF.matMoBlur, "$basetexture", gStPDOF.texMoBlur )
	mat.DrawScreenSpaceQuad( gStPDOF.matMoBlur )

	render.SetViewOrigin( gStPDOF.SaveVO );

	mat.PopMatrix()


end



if ( gStPDOF.InitHook ~= nil ) then UnHookEvent( gStPDOF.InitHook ) end
if ( gStPDOF.DrawHook ~= nil ) then UnHookEvent( gStPDOF.DrawHook ) end

gStPDOF.DrawHook = AddHook( "EndFrame", pp_DrawProperDOF )
gStPDOF.InitHook = AddHook( "LevelInitPreEntity", pp_DrawProperDOFInit )

