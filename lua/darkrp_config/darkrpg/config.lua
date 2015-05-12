--------------------------------------------------------------------------------------------------------------
------------------------------------- Emperor of the Internet Presents... ------------------------------------
--------------------------------------------------------------------------------------------------------------
-------------------------- ██████╗  █████╗ ██████╗ ██╗  ██╗██████╗ ██████╗ ████████╗ -------------------------
-------------------------- ██╔══██╗██╔══██╗██╔══██╗██║ ██╔╝██╔══██╗██╔══██╗██╔═════╝ -------------------------
-------------------------- ██║  ██║███████║██████╔╝█████╔╝ ██████╔╝██████╔╝██║  ███╗ -------------------------
-------------------------- ██║  ██║██╔══██║██╔══██╗██╔═██╗ ██╔══██╗██╔═══╝ ██║   ██║ -------------------------
-------------------------- ██████╔╝██║  ██║██║  ██║██║  ██╗██║  ██║██║    ╚████████║ -------------------------
-------------------------- ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═══════╝ -------------------------
--------------------------------------------------------------------------------------------------------------
--------------------------------------- DARKRPG DEFAULT SERVER SETTINGS --------------------------------------
--------------------------------------------------------------------------------------------------------------

-- Base = Default starting value at Lv.1.			e.g. Health = 100 at Lv.1
-- Next = Percent bonus every level.				e.g. At lv.10 you have 110 Health (with a 1% bonus)
-- Max  = Maximum allowed percent bonus.			e.g. At Lv.999 you have 175 Health (with Max of 75%)

-- Everyone's default starting health, and the Max value is unlimited.
DarkRPG.Stats.Health.Base 	= 100
DarkRPG.Stats.Health.Next 	= 1.25
DarkRPG.Stats.Health.Max 	= 200

-- Everyone's default run speed, the DarkRP default is 240 and the Max value is 2000ish.
DarkRPG.Stats.Move.Base 	= DarkRP.GAMEMODE.Config.runspeed or 240
DarkRPG.Stats.Move.Next 	= 0.15
DarkRPG.Stats.Move.Max 		= 75

-- Everyone's default jumping power, the DarkRP default is 200 and the Max value is unlimited.
DarkRPG.Stats.Jump.Base		= 200
DarkRPG.Stats.Jump.Next 	= 0.25
DarkRPG.Stats.Jump.Max 		= 90

-- Everyone's default armor on spawn.
DarkRPG.Stats.Armor.Base	= 0
DarkRPG.Stats.Armor.Next	= 0.5
DarkRPG.Stats.Armor.Max		= 75

-- Everyone's default evasion, it completely blocks all incoming damage.
DarkRPG.Stats.Evade.Base	= 0
DarkRPG.Stats.Evade.Next	= 0.1
DarkRPG.Stats.Evade.Max		= 20

-- Everyone's default reflection damage, it reverses 100% of incoming damage back at the attacker
-- Makes a manhack noise on damage reflect, clamped to a Max of 0 to 50% for server performance concerns.
DarkRPG.Stats.Mirror.Base	= 0
DarkRPG.Stats.Mirror.Next	= 0
DarkRPG.Stats.Mirror.Max	= 10

-- Everyone's default percentage salary bonus, value is based on the salary in DarkRP's jobs.lua.
DarkRPG.Stats.Salary.Base	= 0
DarkRPG.Stats.Salary.Next	= 2
DarkRPG.Stats.Salary.Max	= 100

-- Everyone's reduction to buyign entities, shipments, guns, etc.
-- Clamped to 100% because above 100% Max to stop infinite money exploiting, 
DarkRPG.Stats.Buy.Base		= 0
DarkRPG.Stats.Buy.Next		= 0.5
DarkRPG.Stats.Buy.Max		= 50

-- Everyone's default Prison Timer reduction.
-- Clamped to 100% because you can't serve negative minutes in prison.
DarkRPG.Stats.Prison.Base	= 0
DarkRPG.Stats.Prison.Next	= 1.5
DarkRPG.Stats.Prison.Max	= 95

-- Normal damage resistance, if none of the four below resists are triggered, it defaults to Normal value.
-- Recommend keeping the max value low as this is ALL types of damage.
DarkRPG.Stats.Normal.Base	= 0
DarkRPG.Stats.Normal.Next	= 0.2
DarkRPG.Stats.Normal.Max	= 20

-- Endurance damage resistance, default setting reduces drowning, suffocation and poison damage (headcrab spit).
DarkRPG.Stats.Endur.Base 	= 0
DarkRPG.Stats.Endur.Next 	= 0.75
DarkRPG.Stats.Endur.Max 	= 90

-- Burning damage resistance, default setting reduces burning damage from ULX Ignite or fire.
DarkRPG.Stats.Burn.Base 	= 0
DarkRPG.Stats.Burn.Next 	= 0.5
DarkRPG.Stats.Burn.Max 		= 90

-- Crushing damage resistance, default setting reduces falling and prop kill damage.
DarkRPG.Stats.Crush.Base 	= 0
DarkRPG.Stats.Crush.Next 	= 0.75
DarkRPG.Stats.Crush.Max 	= 90

-- Explosion damage resistance, default setting reduces bombs, rockets and blast damage.
DarkRPG.Stats.Explode.Base 	= 0
DarkRPG.Stats.Explode.Next 	= 0.35
DarkRPG.Stats.Explode.Max 	= 90

-- Chance for a critical strike, works with anything that does damage, increase is based on DarkRPG.Config.CritScale
DarkRPG.Stats.Crit.Base 	= 0
DarkRPG.Stats.Crit.Next 	= 0.2
DarkRPG.Stats.Crit.Max 		= 15

-- Weapon bonuses will ONLY affect Weapons Unlocked in jobstats.lua, this is to avoid weapon cheating / exploiting.
-- Works on literally any weapon from any weapon pack from the Workshop.
-- Unlocked weapons cannot be dropped.

-- Base is based on your UNLOCKED weapon's SWEP.Primary.Damage, increases your weapon's damage.
DarkRPG.Stats.Damage.Next 	= 0.75
DarkRPG.Stats.Damage.Max 	= 75

-- Base is based on your UNLOCKED weapon's SWEP.Primary.Delay, increases attack speed, minimum value is 0.05 seconds.
DarkRPG.Stats.Speed.Next 	= 0.1
DarkRPG.Stats.Speed.Max 	= 45

-- Base is based on your UNLOCKED weapon's SWEP.Primary.ClipSize, increases how much ammo your gun's magazine holds.
DarkRPG.Stats.Mag.Next 		= 0.4
DarkRPG.Stats.Mag.Max 		= 35

-- Base is based on your UNLOCKED weapon's SWEP.Primary.DefaultClip, increases how much spare ammo you spawn with.
DarkRPG.Stats.Ammo.Next 	= 2.5
DarkRPG.Stats.Ammo.Max 		= 200

--------------------------------------------------------------------------------------------------------------
--------------------------------------------- ADVANCED SETTINGS ----------------------------------------------
--------------------------------------------------------------------------------------------------------------

-- How long ( in seconds ) after spawning that the weapons and stats are set. ( cannot go below 1 second )
DarkRPG.Config.EquipTimer	= 1

-- How much damage a critical scales your damage, 1.5 = 150% damage bonus.
DarkRPG.Config.CritScale	= 1.5

-- What types of damage a resist attribute can resist.				
DarkRPG.Config.Crushing		= { DMG_FALL  , DMG_CRUSH }		-- Reduces Falling and Prop Kill
DarkRPG.Config.Explosion	= { DMG_BLAST }					-- Explosions
DarkRPG.Config.Burning		= { DMG_BURN  , 268435464 }		-- Fire and ULX Ignite
DarkRPG.Config.Endurance	= { DMG_DROWN , DMG_POISON }	-- Drowning and Headcrab Poison

-- Admin Weapon Unlock Settings
DarkRPG.Config.AdminMethods	= true		-- true = uses IsAdmin() / IsSuperAdmin() along with AdminGroups below, likely unnecessary in most situations.
DarkRPG.Config.AdminIgnore 	= true 		-- If true, Admins will receive ALL Weapons on a Job.
DarkRPG.Config.AdminGroups	= {			-- Sets the UserGroups for AdminIgnore.
	"admin",
	"superadmin",
}

-- User Groups which will receive VIP enabled weapons. (Checks FAdmin, Evolve and ULX all at once)
-- Donators get all weapon unlocks in a job that are VIP activated regardless of any level.
DarkRPG.Config.DonatorGroups= {
	"donator",
}

-- Sound that players when you spawn, level up and when you open / close the character sheet.
-- Only accepts sounds located in the '../sound/darkrpg/' folder.
DarkRPG.Config.SpawnSound	= "revive.wav"
DarkRPG.Config.OpenSound	= "open.wav"
DarkRPG.Config.CloseSound	= "close.wav"
DarkRPG.Config.LevelSound	= "ding.wav"

-- The background image used for the character sheet, default it is set to darkMarble.png
DarkRPG.Config.CurrentMotif	= "darkMarble.png"
DarkRPG.Config.SentMotifs	= { 
	"bioCell.png",
	"combineMetal.png",
	"rustGrunge.png",
	"darkMarble.png",
}

-- To create your own background follow these steps:
-- 1 - Use one of the .pngs in '/materials/darkrpg/' as a guide for making your gui.
-- 2 - Add the file name below into SentMotifs to force users to download it.
-- 3 - Put your image in '/materials/darkrpg/' on your server.
-- 4 - Set the CurrentMotif to one of the files listed in SentMotifs.