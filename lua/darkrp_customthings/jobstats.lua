/*------------------------------------------------------------------------------------------------------------
------------------------------------- Emperor of the Internet Presents... ------------------------------------
--------------------------------------------------------------------------------------------------------------
-------------------------- ██████╗  █████╗ ██████╗ ██╗  ██╗██████╗ ██████╗ ████████╗ -------------------------
-------------------------- ██╔══██╗██╔══██╗██╔══██╗██║ ██╔╝██╔══██╗██╔══██╗██╔═════╝ -------------------------
-------------------------- ██║  ██║███████║██████╔╝█████╔╝ ██████╔╝██████╔╝██║  ███╗ -------------------------
-------------------------- ██║  ██║██╔══██║██╔══██╗██╔═██╗ ██╔══██╗██╔═══╝ ██║   ██║ -------------------------
-------------------------- ██████╔╝██║  ██║██║  ██║██║  ██╗██║  ██║██║    ╚████████║ -------------------------
-------------------------- ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═══════╝ -------------------------
--------------------------------------------------------------------------------------------------------------
-------------------------------------------- DARKRPG JOBSTATS.LUA --------------------------------------------
--------------------------------------------------------------------------------------------------------------

-- If you do not add a stat to a job, that stat will default to the config.lua stats settings automatically.
-- Adding nil defaults a stat to the config.lua settings, and adding -1 turns that stat off.
-- EXAMPLE: 'health = { nil , 5 }' will be 100hp with a 5% gain per level if config.lua sets base health to 100.
-- EXAMPLE: 'armor = { 100 , -1 }' will be 0 armor, with 0% gain per level because the -1 turns them both off.

-- IMPORTANT NOTES, CHECK CONSOLE FOR DARKRPG ERROR IF YOU SEE THIS
-- Misspelling or not having a 'TEAM_' job, will default that job to the config.lua settings, check console.
-- If jobs.lua is not included during load, its a typo causing it, you are probably missing a , or {} symbol.
-- Try not to delete these instructions, add your custom jobs on line 68.

--------------------------------------------------------------------------------------------------------------
------------------------------------------------ STATS SYNTAX ------------------------------------------------
--------------------------------------------------------------------------------------------------------------

stat = { base, next }

-- stat = Stat Variable		( health, evade, burn, damage, etc. -- see examples below. )
-- base = Base Value		( Starting value at Level 1; if base is 10, Armor is set to 10 or 10% Critical )
-- next = Per Level Bonus	( Percentage gain every level; at Lv.10 with next at 1, you gain 10% of a stat  )

-------------------------------------------------- EXAMPLES --------------------------------------------------

move   = {  15, 25 }		-- runs ultra slow at lv.1 (15u), then by lv, 20 moving at 3x normal speed (515u)
burn   = { 999, 99 }		-- if DarkRPG.Stats.Burn.Max is set to 75%, defaults to 75% resist, not 999%
health = { nil,  1 }		-- health set to DarkRPG.Stats.Health.Base, you gain 1% bonus every level
evade  = { 10 , -1 }		-- evade is set to 10%, you don't receive any bonus each level (-1)

--------------------------------------------------------------------------------------------------------------
----------------------------------------------- WEAPONS SYNTAX -----------------------------------------------
--------------------------------------------------------------------------------------------------------------

weapons = {
	{lvl, vip, wpnclass, wpnname },
	{lvl, vip, wpnclass, wpnname },
	{lvl, vip, wpnclass, wpnname },
	-- Max of 10 Weapons Per Job --
}
-- lvl = Minimum Level Restriction 	( Must be a number or nil; nil disables any non-donators/admins from using )
-- vip = VIP/Donator Bypass 		( true = donators get the weapon at any level )
-- wpnclass = Weapon Class Name		( Spawn a gun in Q menu, then check console to find it's class name )
-- wpnname = Weapon Name Label		( Custom name, can be any string, like 'VIP Only Glock', value is optional )

-- You can only have a maximum of 10 weapon unlocks, additional unlocks will not appear on the character sheet.
-- Long custom weapon names will clip off the page, and not including wpnname will default it to the class name.

-------------------------------------------------- EXAMPLES --------------------------------------------------

{1,	  false, "weapon_glock2", 	"Glockenspiel" }, -- Lv.1 or higher, on the Player Sheet its called Glockenspiel 
{20,  true , "weapon_ak472",	"Big Russian"  }, -- Lv.20, or donators get it at any level
{nil, true , "unarrest_stick",	"VIP Unarrest" }, -- nil/true means only vips / admins can get this item
{nil, false, "ls_sniper",		"Admin Sniper" }, -- nil/false means only admins can get this item

--------------------------------------------------------------------------------------------------------------
----------------------------------- MODIFY OR ADD VALUES BELOW THIS LINE! ----------------------------------*/

DarkRPG.createJobStats({
	team 	= TEAM_EXAMPLE,
	
	health 	= { nil, nil },
	move 	= { nil, nil },
	jump 	= { nil, nil },
	
	armor 	= { nil, nil },
	evade 	= { nil, nil },
	mirror 	= { nil, nil },
	
	normal	= { nil, nil },
	endur	= { nil, nil },
	burn	= { nil, nil },
	crush	= { nil, nil },
	explode	= { nil, nil },
	
	salary	= { nil, nil },
	buy		= { nil, nil },
	prison	= { nil, nil },
	
	damage	= { nil, nil },
	speed	= { nil, nil },
	mag		= { nil, nil },
	ammo	= { nil, nil },
	crit	= { nil, nil },
	
	weapons = {
		{1, true, "weapon_glock2", "Example Glock"},
	}
})

-- Citizens have it the worst!
DarkRPG.createJobStats({
	team = TEAM_CITIZEN,
	health 	= { 100,1.25},
	salary	= { nil, 3 	},
	buy		= { nil, 1 	},
	endur	= {   5,   1},
	weapons = {
		{1,	 false, "weapon_crowbar",	"Rusty Crowbar"},
		{nil,true,	"weapon_fiveseven2","Sovereign's 5-7"},
	}
})

-- Medics: now beefier with faster healing and better defensive capabilities.
DarkRPG.createJobStats({
	team = TEAM_MEDIC,
	health 	= { 125,  2	},
	move 	= { nil, .4 },
	evade 	= { nil, .5 },
	normal	= { nil, .6 },
	salary	= { 5  ,  2 },
	speed	= { nil, .75},
	
	weapons = {
		{1,	 false, "med_kit", 		"Medical Kit"}, --Medkit heals faster the higher the speed stat.
		{10, true , "weapon_p2282", "Medical P228"},
		{nil,false, "weapon_m42", 	"Medical AK47"},
	}
})

-- That is the sound of the police.
DarkRPG.createJobStats({
	team = TEAM_POLICE,
	health 	= { 100,   1 },
	armor 	= { 20,  2.5 },
	crit 	= { nil, .25 },
	prison	= { 90,  nil },
	damage	= { nil,   1 },
	speed	= { nil,  .3 },
	mag		= { nil,   1 },
	ammo	= { nil, 2.5 },
	
	weapons = {
		{1,  false,	"weapon_stunstick",	"Stunstick"},
		{8,  false,	"weapon_p2282","P228 Handgun"},
		{15, false,	"weapon_mp52",		"MP5"},
		{25, false,	"weapon_m42",		"M4 Rifle"},
	}
})

-- Chief of Police gets a hand grenade.
DarkRPG.createJobStats({
	team = TEAM_CHIEF,
	health 	= { 110,   1 },
	armor 	= { 35,    1 },
	normal	= { nil,   1 },
	crit 	= { nil,  .5 },
	buy		= { nil, 1.3 },
	prison	= { 100, nil },
	damage	= { nil, 1.5 },
	speed	= { nil,  .5 },
	mag		= { nil, 1.3 },
	ammo	= { nil, 3.5 },
	
	weapons = {
		{1,  false,	"weapon_stunstick",		"Stunstick"},
		{10, true, 	"weapon_pumpshotgun2", 	"Chief's Shotgun"},
		{20, true, 	"weapon_m42", 		  	"Last Resort M16A4"},
		{25, true,	"weapon_frag",			"HE Grenade"},
		{nil,false,	"ls_sniper",			"Admin Sniper"},
	}
})

-- Gangsters are significantly more dangerous.
DarkRPG.createJobStats({
	team = TEAM_GANG,
	health 	= { 100,   1},
	armor 	= { 10 ,   5},
	crit 	= { nil,  .2},
	buy		= { 100,  .4},
	prison	= { 5, 	   1},
	damage	= { nil, 1.2},
	speed	= { nil,  .5},
	mag		= { nil,  .5},
	crit	= { nil, .25},
	
	weapons = {
		{1,	false, "lockpick",     	"Lockpick"},
		{5, false, "weapon_glock2", "Stolen Glock"},
		{15,false, "weapon_mac102", "Imported Mac 10"},
		{30, true, "weapon_ak472", 	"The Kalashnikov"},
	}
})

-- Its difficult to prosecute a mob boss.
DarkRPG.createJobStats({
	team = TEAM_MOB,
	health 	= { 100,  1.5},
	crit 	= { nil,  .3 },
	buy		= { 10,    1 },
	prison	= { 5 ,  7.5 },
	damage	= { nil, 1.2 },
	speed	= { nil, .5  },
	mag		= { nil, .5  },
	crit	= { nil, .25 },
	
	weapons = {
		{5,   false, "weapon_glock2", 	"Stolen Glock"},
		{12,  true,  "weapon_deagle2",	"Desert Eagle"},
		{nil, true,  "med_kit", 	  	"Medical Kit"},
	}
})

-- Gun Dealers are pretty adept marksmen as well as resellers.
DarkRPG.createJobStats({
	team = TEAM_GUN,
	
	armor 	= {  10,   5 },
	normal	= { nil,  .4 },
	buy		= { nil, 2.5 },
	
	damage	= { nil, 1.3 },
	speed	= { nil, .35 },
	mag		= { nil,  .5 },
	ammo	= { nil,   5 },
	crit	= { nil, 0.3 },
	
	weapons = {
		{1,  false,	"weaponchecker","Weapon Checker"},
		{7, false, "weapon_deagle2","The Hand Cannon"},
	}
})

-- Slippery Hobos are known for their sick ninja dodging skills and terrible credit.
DarkRPG.createJobStats({
	team 	= TEAM_HOBO,
	jump	= {	nil,  1 },
	move	= {	nil,  2 },
	evade	= {	5,	 .5 },
	mirror	= {	1, .25 },
	salary	= { nil, -1	},
	buy		= { nil, -1	},
	
	weapons = {
		{1,  false, "weapon_fists",  "Hobo Fists"},
		{7,  true, 	"weapon_crowbar", "Hobobar"},
		{nil,false,	"weapon_rpg", 	 "Hobo RPG"},
	}
})

-- Mayors bring in the big bucks.
DarkRPG.createJobStats({
	team 	= TEAM_MAYOR,
	armor 	= { 10,    5 },
	evade 	= { nil, 0.5 },
	salary	= { nil,   5 },
	buy		= { nil, 1.5 },
	prison	= { 75,  2.5 },
	
	weapons = {
		{15, true,	"weapon_mp52",		"Senatorial MP5"},
		{nil,true,	"med_kit",			"Emergency Medkit"},
		{nil,true,	"weapon_slam",		"Defensive SLAMs"},
		{nil,false,	"ls_sniper",		"Mayoral Sniper"},
	}
})