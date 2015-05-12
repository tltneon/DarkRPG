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
--------------------------------------- DARKRPG DEFAULT CLIENT SETTINGS --------------------------------------
--------------------------------------------------------------------------------------------------------------

-- Used fonts are generated in fonts.lua, default is Trebuchet MS.
DarkRPG.Config.FontTitle 	= "EOTI_HUD_20"
DarkRPG.Config.FontLevel 	= "EOTI_HUD_19"
DarkRPG.Config.FontInfos 	= "EOTI_HUD_18"

-- Key to toggle the character sheet on and off
-- F3 allows you to move the GUI around your screen.
DarkRPG.Config.ToggleKey 	= KEY_F2

-- Position of the character sheet on server join.
DarkRPG.Config.LeftMode		= false						--if false, PosX will come from the right side of the screen
DarkRPG.Config.TopMode		= true						--if true, PosY will start from the bottom of the screen.
DarkRPG.Config.PosX 		= 50
DarkRPG.Config.PosY 		= 50

-- Font Colors used in the Character Sheet
DarkRPG.Config.ColorTitle 	= Color(200,200,200)
DarkRPG.Config.ColorSubT  	= Color(200,150,20)
DarkRPG.Config.ColorMax		= Color(0,112,221)
DarkRPG.Config.ColorUpgrade	= Color(30,200,30)
DarkRPG.Config.ColorDefault	= Color(200,200,200)
DarkRPG.Config.ColorFail	= Color(200,20,20)
DarkRPG.Config.ColorPass	= Color(30,200,30)
DarkRPG.Config.ColorInfo	= Color(100,80,20)

-- Titles of attribute groups on the character sheet.
DarkRPG.Stats.Titles.Body	= "Physical"
DarkRPG.Stats.Titles.Def	= "Defense"
DarkRPG.Stats.Titles.Char	= "Charisma"
DarkRPG.Stats.Titles.Resist	= "Resists"
DarkRPG.Stats.Titles.Weap	= "Weapon"
DarkRPG.Stats.Titles.Unlock	= "Unlocks"
	
-- Names for attributes on the character sheet.
DarkRPG.Stats.Health.Name 	= "Health"
DarkRPG.Stats.Move.Name		= "Movement"
DarkRPG.Stats.Jump.Name		= "Jump Height"
DarkRPG.Stats.Armor.Name	= "Armor"
DarkRPG.Stats.Evade.Name	= "Evasion"
DarkRPG.Stats.Mirror.Name	= "Reflection"
DarkRPG.Stats.Salary.Name	= "Salary Increase"
DarkRPG.Stats.Buy.Name		= "Buy Reduction"
DarkRPG.Stats.Prison.Name	= "Prison Reduction"
DarkRPG.Stats.Normal.Name	= "Normal"
DarkRPG.Stats.Endur.Name	= "Endurance"
DarkRPG.Stats.Burn.Name		= "Burning"
DarkRPG.Stats.Crush.Name	= "Crushing"
DarkRPG.Stats.Explode.Name	= "Explosion"
DarkRPG.Stats.Damage.Name	= "Damage"
DarkRPG.Stats.Speed.Name	= "Speed"
DarkRPG.Stats.Mag.Name		= "Magazine Size"
DarkRPG.Stats.Ammo.Name		= "Starting Ammo"
DarkRPG.Stats.Crit.Name		= "Critical Chance"

-- Tips and Hints listed on the character sheet
DarkRPG.Config.Hint			= "Press F2 key to toggle this character sheet on or off."
DarkRPG.Config.HintSpeed	= 15
DarkRPG.Config.Hints		= {
	"Press F2 key to toggle this character sheet on or off.",
	"This is the DarkRPG: Leveling and Stats System 1.0!",
	"DarkRPG 1.0 was created by Emperor of the Internet.",
	"MAX means you have maxed out this stat for this job.",
	"Next is the percent bonus you receive every level.",
	"Base is your base stats for this job at Level 1.",
	"Mod is how much your base stats are being modified.",
	"Weapon bonuses effect only the weapons in Unlocks.",
	"Brought to you by [ INSERT SERVER NAME HERE ]!",
	"F3 then click and drag to move this character sheet.",
	"Blue text means you've hit the server limit for a stat.",
	"Percent Based stats will only range from 0 to 100%",
	"Add your own messages or hints in config_gui.lua!",
	DarkRPG.Stats.Normal.Name.." Resist: reduces ALL damage upto "..DarkRPG.Stats.Normal.Max.."%",
	DarkRPG.Stats.Endur.Name.." Resist: reduces drowning damage upto "..DarkRPG.Stats.Endur.Max.."%",
	DarkRPG.Stats.Explode.Name.." Resist: reduces explode damage upto "..DarkRPG.Stats.Explode.Max.."%",
	DarkRPG.Stats.Crush.Name.." Resist: reduces fall/prop damage upto "..DarkRPG.Stats.Crush.Max.."%",
	DarkRPG.Stats.Burn.Name.." Resist: reduces fire/ignite damage upto "..DarkRPG.Stats.Burn.Max.."%",
	DarkRPG.Stats.Evade.Name..": chance to avoid incoming damage upto "..DarkRPG.Stats.Evade.Max.."%",
	DarkRPG.Stats.Mirror.Name..": chance to reflect damage back upto "..DarkRPG.Stats.Mirror.Max.."%",
}