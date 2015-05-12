-- Runs all clientside files.
 
print("<----- Emperor of the Internet Presents... ----->")
print("██████╗  █████╗ ██████╗ ██╗  ██╗██████╗ ██████╗ ██████╗ ")
print("██╔══██╗██╔══██╗██╔══██╗██║ ██╔╝██╔══██╗██╔══██╗██╔════╝ ")
print("██║  ██║███████║██████╔╝█████╔╝ ██████╔╝██████╔╝██║  ███╗")
print("██║  ██║██╔══██║██╔══██╗██╔═██╗ ██╔══██╗██╔═══╝ ██║   ██║")
print("██████╔╝██║  ██║██║  ██║██║  ██╗██║  ██║██║    ╚██████")
print("╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚════╝ ")
print("<--------------- DarkRPG CLIENT ---------------->")
print("DarkRPG CLIENT: Running 'cl_init.lua'!")
print("DarkRPG SERVER: Sending Clientside Files!")

AddCSLuaFile( "darkrp_config/darkrpg/config.lua" ) 
AddCSLuaFile( "darkrp_config/darkrpg/config_gui.lua" )
AddCSLuaFile( "darkrp_customthings/jobstats.lua" )
AddCSLuaFile( "darkrp_modules/darkrpg/core/stats.lua" )
AddCSLuaFile( "darkrp_modules/darkrpg/core/stats_cl.lua" )  
AddCSLuaFile( "darkrp_modules/darkrpg/core/font.lua" )             
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
 
DarkRPG.Stats.Display		 	= {}
DarkRPG.Stats.Display.Titles	= {}

DarkRPG.Stats.Display.Health 	= {}
DarkRPG.Stats.Display.Move	 	= {}
DarkRPG.Stats.Display.Jump 		= {}

DarkRPG.Stats.Display.Armor 	= {}
DarkRPG.Stats.Display.Evade 	= {} 
DarkRPG.Stats.Display.Mirror 	= {}  

DarkRPG.Stats.Display.Salary 	= {}
DarkRPG.Stats.Display.Buy 		= {}
DarkRPG.Stats.Display.Prison 	= {}

DarkRPG.Stats.Display.Normal 	= {}
DarkRPG.Stats.Display.Endur 	= {}      
DarkRPG.Stats.Display.Burn 		= {}
DarkRPG.Stats.Display.Crush 	= {}
DarkRPG.Stats.Display.Explode 	= {}          
     
DarkRPG.Stats.Display.Damage 	= {}
DarkRPG.Stats.Display.Speed 	= {}     
DarkRPG.Stats.Display.Mag 		= {}
DarkRPG.Stats.Display.Ammo 		= {}
DarkRPG.Stats.Display.Crit 		= {}  
  
DarkRPG.Stats.Display.Weapons	= {} 

print("DarkRPG CLIENT: Including 'font.lua'!")

include( "darkrp_modules/darkrpg/core/font.lua" ) 

print("DarkRPG CLIENT: Including 'config.lua'!")

include( "darkrp_config/darkrpg/config.lua" )    

for k, src in pairs( DarkRPG.Config.SentMotifs ) do
	resource.AddFile( "materials/darkrpg/"..src )
end

resource.AddFile( "sound/darkrpg/"..DarkRPG.Config.OpenSound  )
resource.AddFile( "sound/darkrpg/"..DarkRPG.Config.CloseSound )
resource.AddFile( "sound/darkrpg/"..DarkRPG.Config.SpawnSound )
resource.AddFile( "sound/darkrpg/"..DarkRPG.Config.LevelSound )

DarkRPG.Stats.Damage.Base 	= 0
DarkRPG.Stats.Speed.Base 	= 0
DarkRPG.Stats.Mag.Base 		= 0
DarkRPG.Stats.Ammo.Base 	= 0

print("DarkRPG CLIENT: Including 'config_gui.lua'!")

include( "darkrp_config/darkrpg/config_gui.lua" )

print("DarkRPG CLIENT: Including 'stats.lua'!")

include( "darkrp_modules/darkrpg/core/stats.lua" )

print("DarkRPG CLIENT: Including 'stat_cl.lua'!")

include( "darkrp_modules/darkrpg/core/stats_cl.lua" )  

print("DarkRPG CLIENT: Including 'jobs.lua'!")
 
include( "darkrp_customthings/jobstats.lua" )   

print("DarkRPG CLIENT: Including 'frame.lua'!")
                                               
include( "darkrp_modules/darkrpg/core/frame.lua" )    

print("DarkRPG CLIENT: Finished Loading!")  
print("<----------------------------------------------->")
print("If files are not included, that means there is a ")
print("typo or missing , or {} from jobs, or config_gui.")
print("<----------------------------------------------->")                      
