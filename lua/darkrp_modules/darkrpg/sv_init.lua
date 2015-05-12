-- Runs all serverside files.
 
print("<----- Emperor of the Internet Presents... ----->")
print("██████╗  █████╗ ██████╗ ██╗  ██╗██████╗ ██████╗ ██████╗ ")
print("██╔══██╗██╔══██╗██╔══██╗██║ ██╔╝██╔══██╗██╔══██╗██╔════╝ ")
print("██║  ██║███████║██████╔╝█████╔╝ ██████╔╝██████╔╝██║  ███╗")
print("██║  ██║██╔══██║██╔══██╗██╔═██╗ ██╔══██╗██╔═══╝ ██║   ██║")
print("██████╔╝██║  ██║██║  ██║██║  ██╗██║  ██║██║    ╚██████")
print("╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚════╝ ")
print("<--------------- DarkRPG SERVER ---------------->")
print("DarkRPG SERVER: Running 'sv_init.lua'!")
print("DarkRPG SERVER: Sending Client Files.")

AddCSLuaFile( "darkrp_modules/darkrpg/core/font.lua" ) 
AddCSLuaFile( "darkrp_config/darkrpg/config.lua" ) 
AddCSLuaFile( "darkrp_config/darkrpg/config_gui.lua" )
AddCSLuaFile( "darkrp_customthings/jobstats.lua" )
AddCSLuaFile( "darkrp_modules/darkrpg/core/stats.lua" )
AddCSLuaFile( "darkrp_modules/darkrpg/core/stats_cl.lua" )             
AddCSLuaFile( "darkrp_modules/darkrpg/core/frame.lua" )
AddCSLuaFile( "darkrp_modules/darkrpg/cl_init.lua" )

print("DarkRPG SERVER: Declaring Object Variables!")

DarkRPG 		= {}
DarkRPG.Config 	= {}
DarkRPG.Stats 	= {}

DarkRPG.Stats.Titles	= {}

DarkRPG.Stats.Health 	= {}
DarkRPG.Stats.Move 		= {}
DarkRPG.Stats.Jump 		= {}

DarkRPG.Stats.Armor 	= {}
DarkRPG.Stats.Evade 	= {}
DarkRPG.Stats.Mirror 	= {}

DarkRPG.Stats.Salary 	= {}
DarkRPG.Stats.Buy 		= {}
DarkRPG.Stats.Prison 	= {}

DarkRPG.Stats.Normal 	= {}
DarkRPG.Stats.Endur 	= {}
DarkRPG.Stats.Burn 		= {}
DarkRPG.Stats.Crush	 	= {}
DarkRPG.Stats.Explode	= {}

DarkRPG.Stats.Damage 	= {}
DarkRPG.Stats.Speed 	= {}
DarkRPG.Stats.Mag 		= {}
DarkRPG.Stats.Ammo 		= {}
DarkRPG.Stats.Crit 		= {}

print("DarkRPG SERVER: Including 'config.lua'!")

include("darkrp_config/darkrpg/config.lua") 

DarkRPG.Stats.Damage.Base 	= 0
DarkRPG.Stats.Speed.Base 	= 0
DarkRPG.Stats.Mag.Base 		= 0
DarkRPG.Stats.Ammo.Base 	= 0

for k, src in pairs( DarkRPG.Config.SentMotifs ) do
	resource.AddFile( "materials/darkrpg/"..src )
end

resource.AddFile( "sound/darkrpg/"..DarkRPG.Config.OpenSound  )
resource.AddFile( "sound/darkrpg/"..DarkRPG.Config.CloseSound )
resource.AddFile( "sound/darkrpg/"..DarkRPG.Config.SpawnSound )
resource.AddFile( "sound/darkrpg/"..DarkRPG.Config.LevelSound )

print("DarkRPG SERVER: Including 'stats.lua'!")

include( "darkrp_modules/darkrpg/core/stats.lua" )

print("DarkRPG SERVER: Including 'jobs.lua'!")

include( "darkrp_customthings/jobstats.lua" ) 

print("DarkRPG SERVER: Including 'stats_sv.lua'!")

include( "darkrp_modules/darkrpg/core/stats_sv.lua" )                                
  
print("DarkRPG SERVER: Equipping all players!")

for k, ply in pairs( player.GetAll() ) do
	DarkRPG.playerSpawnTimer( ply )
end   
             
print("DarkRPG SERVER: Finished Loading!")  
print("<----------------------------------------------->")
print("If files are not included, that means there is a ")
print("typo or missing , or {} from jobs, or config_gui.")
print("<----------------------------------------------->")
