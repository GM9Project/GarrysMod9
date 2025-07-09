



-- Helpful debug recursive table printer from
-- http://www.gammon.com.au/forum/bbshowpost.php?bbsubject_id=4903

	
	function tprint (t, indent, done)

	  done = done or {}
	  indent = indent or ""

	  for key, value in pairs (t) do

	    Msg( indent )

	    if type (value) == "table" and not done [value] then

	      done [value] = true
	      tprint (value, indent .. key .. ".", done)

	    else

	      Warn (tostring (key) )
	      Msg (" ( ")
	      Msg (tostring(value) .. " )\n")

	    end

	  end

	end

	function Clamp( cur, min, max )

		if ( cur < min ) then
			return min
		end

		if ( cur > max ) then
			return max
		end


		return cur
	end