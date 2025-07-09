
-- Sprite 2D, sprite drawing library
-- Garry Newman 29/12/2005



sprite2d = {}

sprite2d.ScrW = ScreenWidth() * 0.5
sprite2d.ScrH = ScreenHeight() * 0.5

sprite2d.color = {}
sprite2d.color.a = 1.0
sprite2d.color.r = 1.0
sprite2d.color.g = 1.0
sprite2d.color.b = 1.0


sprite2d.SetMat = function( in_mat )
	mat.BindMaterial( in_mat )
end

sprite2d.Begin = function()
	mat.IdentityMatrix()
end

sprite2d.End = function()
	mat.PopMatrix()
	sprite2d.SetColor( 1, 1, 1, 1 )
end

sprite2d.SetColor = function( a, r, g, b)
	sprite2d.color.a = a
	sprite2d.color.r = r
	sprite2d.color.g = g
	sprite2d.color.b = b
end

-- Draws a sprite. Placement is the center of the sprite.

sprite2d.DrawSprite = function( iPosX, iPosY, iWidth, iHeight )

	iPosX = iPosX / sprite2d.ScrW
	iPosX = iPosX - 1.0;

	iPosY = iPosY / sprite2d.ScrH
	iPosY = 1.0 - iPosY;

	iWidth = iWidth / sprite2d.ScrW
	iHeight = iHeight / sprite2d.ScrH

	iPosY = iPosY - iHeight * 0.5
	iPosX = iPosX - iWidth * 0.5

	iWidth = iWidth + iPosX
	iHeight = iHeight + iPosY

	mat.StartMesh( MATERIAL_QUADS,  1 )

	mat.VertexColor( sprite2d.color.r, sprite2d.color.g, sprite2d.color.b, sprite2d.color.a )
	mat.VertexTexCoord( 0, 0 )
	mat.VertexPos( iPosX, iHeight, 0.0 )
	mat.AdvanceVertex()

	mat.VertexColor( sprite2d.color.r, sprite2d.color.g, sprite2d.color.b, sprite2d.color.a )
	mat.VertexTexCoord( 1, 0 )
	mat.VertexPos( iWidth, iHeight, 0.0 )
	mat.AdvanceVertex()

	mat.VertexColor( sprite2d.color.r, sprite2d.color.g, sprite2d.color.b, sprite2d.color.a )
	mat.VertexTexCoord( 1, 1 )
	mat.VertexPos( iWidth, iPosY, 0.0 )
	mat.AdvanceVertex()

	mat.VertexColor( sprite2d.color.r, sprite2d.color.g, sprite2d.color.b, sprite2d.color.a )
	mat.VertexTexCoord( 0, 1 )
	mat.VertexPos( iPosX, iPosY, 0.0 )
	mat.AdvanceVertex()

	mat.EndMesh()

end
