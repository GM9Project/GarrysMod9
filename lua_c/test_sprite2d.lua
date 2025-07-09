
MelonMat = mat.GetMaterial( "gmod/melonracer/melon" )

MelonPos = {}
MelonPos.x = ScreenWidth() / 2.0
MelonPos.y = 200

MelonVel = {}
MelonVel.x = 500
MelonVel.y = 500

function DrawMyMeshStuff( )

	MelonPos.x = MelonPos.x + (MelonVel.x * Tick())
	MelonPos.y = MelonPos.y + (MelonVel.y * Tick())

	MelonVel.y = MelonVel.y + (1000 * Tick())

	if (MelonPos.x < 0 or MelonPos.x > ScreenWidth()) then 
		MelonVel.x = MelonVel.x * -1.0 
	end
		
	if (MelonPos.y < 0 or MelonPos.y > ScreenHeight()) then 
		MelonVel.y = MelonVel.y * -1.0 
	end

	Clamp( MelonPos.x, 0, ScreenWidth() )
	Clamp( MelonPos.y, 0, ScreenHeight() )

	sprite2d.Begin()

	sprite2d.SetMat( MelonMat )

	local Width = 100;

	if (MelonVel.x < 0) then Width = -100 end;

	sprite2d.DrawSprite( MelonPos.x, MelonPos.y, Width, 100 );

	sprite2d.End()

end

AddHook( "DrawSceneFinished", DrawMyMeshStuff )
