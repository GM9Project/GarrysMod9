--------------------------------------------------------------------
-- A simple script to emulate the registering of console commands --
--------------------------------------------------------------------



	gConsoleCommands = {};



	function ConCommand ( incommand, ... )	

		if ( gConsoleCommands[ incommand ] ~= nil ) then

			gConsoleCommands[ incommand ]( playerid, unpack(arg) );
			return true;

		end

		return false;

	end




	function CONCOMMAND( command, funct )

		convar.AddCommand( command )
		gConsoleCommands[ command ] = funct;

	end
	

	function CONVAR( command, defvalue )

		convar.AddConVar( command, defaultvalue )

	end