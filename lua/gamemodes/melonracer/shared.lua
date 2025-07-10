
GM.Name 		= "MelonRacer"
GM.Author 		= "N/A"
GM.Email 		= "N/A"
GM.Website 		= "N/A"
GM.TeamBased 	= false

function GM:Initialize()

	self.BaseClass.Initialize( self )
	
	self.State = "waiting"
	
end

function GM:Think()

	if ( CLIENT ) then self:HUDThink() end
	
end


function GM:GetNumLaps()
	return 3
end
