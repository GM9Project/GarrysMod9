
if ( gStIRON == nil ) then gStIRON = {} end

function SetAimPos( vOffset )

	render.SetViewOrigin( vOffset );

	local vAimAngle = vector3( 0, 0, 0 );
	vAimAngle.x = EndPos.x - vOffset.x;
	vAimAngle.y = EndPos.y - vOffset.y;
	vAimAngle.z = EndPos.z - vOffset.z;

	render.SetViewAngles( VectorAngles(vAimAngle) );

end

function pp_DrawIronSight( )

	mat.IdentityMatrix()
	gStIRON.pSavedRT = mat.GetRenderTarget()
	gStIRON.SaveVO = render.GetViewOrigin();
	gStIRON.SaveVA = render.GetViewAngles();

	local vRight = VectorRight( gStIRON.SaveVA );
	local vUp = VectorUp( gStIRON.SaveVA );
	
	local NewView = vector3( gStIRON.SaveVO.x, gStIRON.SaveVO.y, gStIRON.SaveVO.z );

	NewView.x = NewView.x + vRight.x * 5.5;
	NewView.y = NewView.y + vRight.y * 5.5;
	NewView.z = NewView.z + vRight.z * 5.5;

	NewView.x = NewView.x - vUp.x * 2.5;
	NewView.y = NewView.y - vUp.y * 2.5;
	NewView.z = NewView.z - vUp.z * 2.5;

	render.SetViewOrigin( NewView );

	-- We're drawing the scene AGAIN so it will half yout frame rate (it's a test)
	render.RenderView();

	render.SetViewOrigin( gStIRON.SaveVO );

	mat.PopMatrix()


end


if ( gStIRON.DrawHook ~= nil ) then UnHookEvent( gStIRON.DrawHook ) end
gStIRON.DrawHook = AddHook( "EndFrame", pp_DrawIronSight )

