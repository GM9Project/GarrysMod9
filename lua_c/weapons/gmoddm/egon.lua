
-- First attempt at a server AND clientside weapon


	function onInit( )
	end
	
	
	function onPickup( playerid )
	end
	
	
	function onDrop( playerid )
	end


	function onRemove( )
	end


	function onThink( )
	end
	

	function onPrimaryAttack( )	
	end


	function onSecondaryAttack( )		
	end


	function Deploy( )
	end
	
		
	function Holster( )
	end
	

	function onReload( )
		return true;
	end


	function getDamage()
		return 10;
	end

	function getPrimaryShotDelay()
		return 0.2;
	end

	function getPrimaryIsAutomatic()
		return true;
	end

	function getBulletSpread()
		return vector3( 0.01, 0.01, 0.01 );
	end

	function getViewKick()
		return vector3( 0.5, 0.0, 0.0);
	end

	function getViewKickRandom()
		return vector3( 0.5, 0.5, 0.2 );
	end

	function getNumShotsPrimary()
		return 1;
	end

	function getPrimaryAmmoType()
		return "pistol";
	end

	function getMaxClipPrimary() -- return -1 if it doesn't use clips
		return 25;
	end
	
	function getDefClipPrimary() -- ammo in gun by default
		return 25;
	end
	
	function getTracerFreqPrimary() -- 0 = none, 1 = every bullet, 2 = every 2nd bullet etc
		return 2;
	end
	
	
	function getDamageSecondary()
		return 10;
	end

	function getSecondaryShotDelay()
		return 0.2;
	end

	function getSecondaryIsAutomatic()
		return false;
	end

	function getBulletSpreadSecondary()
		return vector3( 0.001, 0.001, 0.001 );
	end

	function getViewKickSecondary()
		return vector3( 0.5, 0.0, 0.0);
	end

	function getViewKickRandomSecondary()
		return vector3( 0.5, 0.5, 0.2 );
	end

	function getNumShotsSecondary()
		return 1;
	end

	function getSecondaryAmmoType()
		return "pistol";
	end

	function getMaxClipSecondary() -- return -1 if it doesn't use clips
		return -1;
	end

	function getDefClipSecondary()
		return 0;
	end
	
	function getTracerFreqSecondary()
		return 2;
	end
	
	
	function getViewModel( )
		return "models/weapons/v_smg_ump45.mdl";
	end

	function getWorldModel( )
		return "models/weapons/w_smg_ump45.mdl";
	end

	function getClassName() 
		return "weapon_scripted";
	end

	function getHUDMaterial( )
		return "gmod/SWEP/default";
	end

	function getDeathIcon( )
		return "swep_default";
	end

	function getWeaponSwapHands()
		return false	
	end

	function getWeaponFOV()
		return 70
	end

	function getWeaponSlot()
		return 5	
	end

	function getWeaponSlotPos()
		return 2
	end

	function getFiresUnderwater()
		return true
	end

	function getReloadsSingly()
		return false
	end


	function getAnimPrefix() 
		return "smg";
	end


	function getPrintName()
		return "Egon";
	end

	function getPrimaryScriptOverride()
		return 2;
	end

	function getSecondaryScriptOverride()
		return 0;
	end