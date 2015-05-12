
-- Parses and generates Client Stats for display on the HUD
function DarkRPG.concatClientStat( level , percent , atr , base )
	local rpg = DarkRPG.calculateStat( level, percent, atr, base)
	local gui = DarkRPG.Config
	
	---------------------------------
	if rpg.Mod <= 0
	then
		rpg.ColorMod = gui.ColorDefault or Color(200,200,200)
	elseif rpg.Mod >= atr.Max 
	then
		rpg.ColorMod = gui.ColorMax or Color(0,112,221)
	end
	
	---------------------------------
	if rpg.Next <= 0 
	or rpg.Mod >= atr.Max 
	or percent and rpg.Base >= atr.Max
	then 
		rpg.Next = "MAX"
		rpg.ColorNext = gui.ColorMax or Color(0,112,221)
	else 
		rpg.Next = "+"..rpg.Next.."%"
		rpg.ColorNext = gui.ColorUpgrade or Color(30,200,30)
	end
	
	---------------------------------
	if rpg.Final > 0 and rpg.Mod >= atr.Max 
	then
		rpg.ColorFinal = gui.ColorMax or Color(0,112,221)
	elseif rpg.Final > rpg.Base
	then
		rpg.ColorFinal = gui.ColorUpgrade or Color(30,200,30)
	end
	
	---------------------------------
	if percent
	then
		if rpg.Base >= atr.Max
		then
			rpg.Mod = "+"..atr.Max.."%"
			rpg.ColorMod = gui.ColorMax or Color(0,112,221)
		else
			rpg.Mod = "+"..rpg.Mod.."%"
		end
		
		rpg.Base = "+"..rpg.Base.."%"
		rpg.Final = rpg.Final.."%"
	else
		rpg.Mod = "+"..rpg.Mod.."%"
	end
	
	return rpg
end

-- Processes the weapon table values for display on the HUD.
function DarkRPG.concatWeapons( level , weapons )
	local rpg = DarkRPG.verifyWeaponTable( weapons )
	local gui = DarkRPG.Config
	local arr = {}
	
	if weapons == nil then return end
	
	for k, wpn in pairs( weapons ) do
		arr[k] = {}
		
		arr[k].Name = wpn[4] or string.sub(wpn[3],1,12) or "[NO WEAPON]"
	
		if wpn[1] != nil and wpn[2]
		then
			arr[k].Lock = wpn[1].."/VIP"
		elseif wpn[2]
		then 
			arr[k].Lock = "VIP"
		elseif wpn[1] != nil
		then
			arr[k].Lock = "Lv."..wpn[1]
		else
			arr[k].Lock = "Admin"
		end
		
		if DarkRPG.checkWeaponUnlock( LocalPlayer() , wpn[1] , wpn[2] , level )
		then
			arr[k].Color = gui.ColorPass
		end
	end
	
	return arr
end

-- Updates the Client's display to show the new stats
function DarkRPG.defineClientStats( level )
	local index, dply
	
	index = LocalPlayer():getJobTable().team or "DEFAULT"
	index = (DarkRPG[index] != nil and index) or "DEFAULT"
	dply = {}
	
	dply.jobname= LocalPlayer():getJobTable().name
	dply.level	= level
	dply.Health	= DarkRPG.concatClientStat( level , false, DarkRPG.Stats.Health	, DarkRPG[index].health )
	dply.Move 	= DarkRPG.concatClientStat( level , false, DarkRPG.Stats.Move 	, DarkRPG[index].move	)
	dply.Jump	= DarkRPG.concatClientStat( level , false, DarkRPG.Stats.Jump 	, DarkRPG[index].jump	)
	dply.Armor 	= DarkRPG.concatClientStat( level , false, DarkRPG.Stats.Armor	, DarkRPG[index].armor	)
	dply.Evade 	= DarkRPG.concatClientStat( level , true , DarkRPG.Stats.Evade	, DarkRPG[index].evade	)
	dply.Mirror	= DarkRPG.concatClientStat( level , true , DarkRPG.Stats.Mirror	, DarkRPG[index].mirror	)
	dply.Salary = DarkRPG.concatClientStat( level , true , DarkRPG.Stats.Salary	, DarkRPG[index].salary	)
	dply.Buy 	= DarkRPG.concatClientStat( level , true , DarkRPG.Stats.Buy	, DarkRPG[index].buy	)
	dply.Prison = DarkRPG.concatClientStat( level , true , DarkRPG.Stats.Prison	, DarkRPG[index].prison	)
	dply.Normal = DarkRPG.concatClientStat( level , true , DarkRPG.Stats.Normal	, DarkRPG[index].normal	)
	dply.Endur 	= DarkRPG.concatClientStat( level , true , DarkRPG.Stats.Endur	, DarkRPG[index].endur	)
	dply.Burn 	= DarkRPG.concatClientStat( level , true , DarkRPG.Stats.Burn	, DarkRPG[index].burn	)
	dply.Crush 	= DarkRPG.concatClientStat( level , true , DarkRPG.Stats.Crush	, DarkRPG[index].crush	)
	dply.Explode= DarkRPG.concatClientStat( level , true , DarkRPG.Stats.Explode, DarkRPG[index].explode)
	dply.Damage = DarkRPG.concatClientStat( level , false, DarkRPG.Stats.Damage	, DarkRPG[index].damage	)
	dply.Speed 	= DarkRPG.concatClientStat( level , true , DarkRPG.Stats.Speed	, DarkRPG[index].speed	)
	dply.Mag 	= DarkRPG.concatClientStat( level , false, DarkRPG.Stats.Mag	, DarkRPG[index].mag	)
	dply.Ammo 	= DarkRPG.concatClientStat( level , false, DarkRPG.Stats.Ammo	, DarkRPG[index].ammo	)
	dply.Crit 	= DarkRPG.concatClientStat( level , true , DarkRPG.Stats.Crit	, DarkRPG[index].crit	)
	
	dply.Weapons = DarkRPG.concatWeapons( level , DarkRPG[index].weapons )
	
	DarkRPG.Stats.Display = dply
end

-- Receives the sent value from the server
net.Receive("darkrpg_ply", function(len)
	local tbl = net.ReadTable()
	DarkRPG.defineClientStats( tbl[1] )
	LocalPlayer():EmitSound(DarkRPG.Config.SpawnSound)
end )