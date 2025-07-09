
-- TESTING YOU FUCKS DON'T BITCH THAT IT ISN@T OPTIMIZED


function DrawMyMeshStuff( )

	MeshDrawMaterial = mat.GetMaterial( "gmod/melonracer/title" )


	mat.IdentityMatrix()

		-- Set the material we're going to use
		mat.BindMaterial( MeshDrawMaterial )

		mat.StartMesh( MATERIAL_QUADS,  1 )

		mat.VertexColor( 1, 1, 1, 1 )
		mat.VertexTexCoord( 0, 0 )
		mat.VertexPos( -1.0, 1.0, 0.0 )
		mat.AdvanceVertex()

		mat.VertexColor( 1, 1, 1, 1 )
		mat.VertexTexCoord( 1, 0 )
		mat.VertexPos( 1.0, 1.0, 0.0 )
		mat.AdvanceVertex()

		mat.VertexColor( 1, 1, 1, 1 )
		mat.VertexTexCoord( 1, 1 )
		mat.VertexPos( 1.0, -1.0, 0.0 )
		mat.AdvanceVertex()

		mat.VertexColor( 1, 1, 1, 1 )
		mat.VertexTexCoord( 0, 1 )
		mat.VertexPos( -1.0, -1.0, 0.0 )
		mat.AdvanceVertex()

		mat.EndMesh()


	mat.PopMatrix()

end

AddHook( "DrawSceneFinished", DrawMyMeshStuff )
