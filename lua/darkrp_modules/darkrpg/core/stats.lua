--Verifies the user values for jobs.lua in case the server host failed to input them correctly ; used in createJobStats
function DarkRPG.verifyJobValue( job , cfg )
	return (job != nil and istable(job) and #job == 2 and job)
		or (cfg != nil and istable(cfg) and {cfg.Base,cfg.Next})	
		or {-1,-1}
end

function DarkRPG.verifyWeaponTable( weapons )
	if weapons == nil or !istable(weapons) then return nil end
	
	local arr = {}
	for k, wpn in pairs( weapons ) do
		if (isnumber(wpn[1]) or wpn[1] == nil)
		and isbool(wpn[2]) 
		and isstring(wpn[3]) 
		then
			table.insert( arr , wpn )
		end
	end
	return arr
end

function DarkRPG.createJobStats( job )
	if job.team == nil then print("DarkRPG: TEAM NOT FOUND! CHECK jobs.lua") return end
	local arr = {}
	
	arr.health 	= DarkRPG.verifyJobValue( job.health 	, DarkRPG.Stats.Health 	)
	arr.move 	= DarkRPG.verifyJobValue( job.move 		, DarkRPG.Stats.Move 	)
	arr.jump 	= DarkRPG.verifyJobValue( job.jump 		, DarkRPG.Stats.Jump	)
	arr.armor 	= DarkRPG.verifyJobValue( job.armor 	, DarkRPG.Stats.Armor 	)
	arr.evade 	= DarkRPG.verifyJobValue( job.evade 	, DarkRPG.Stats.Evade 	)
	arr.mirror 	= DarkRPG.verifyJobValue( job.mirror 	, DarkRPG.Stats.Mirror 	)
	arr.salary	= DarkRPG.verifyJobValue( job.salary	, DarkRPG.Stats.Salary	)
	arr.buy		= DarkRPG.verifyJobValue( job.buy		, DarkRPG.Stats.Buy		)
	arr.prison	= DarkRPG.verifyJobValue( job.prison	, DarkRPG.Stats.Prison	)
	arr.normal	= DarkRPG.verifyJobValue( job.normal	, DarkRPG.Stats.Normal	)
	arr.endur	= DarkRPG.verifyJobValue( job.endur		, DarkRPG.Stats.Endur	)
	arr.burn	= DarkRPG.verifyJobValue( job.burn		, DarkRPG.Stats.Burn	)
	arr.crush	= DarkRPG.verifyJobValue( job.crush		, DarkRPG.Stats.Crush	)
	arr.explode	= DarkRPG.verifyJobValue( job.explode	, DarkRPG.Stats.Explode	)
	arr.damage	= DarkRPG.verifyJobValue( job.damage	, DarkRPG.Stats.Damage	)
	arr.speed	= DarkRPG.verifyJobValue( job.speed		, DarkRPG.Stats.Speed	)
	arr.mag		= DarkRPG.verifyJobValue( job.mag		, DarkRPG.Stats.Mag		)
	arr.ammo	= DarkRPG.verifyJobValue( job.ammo		, DarkRPG.Stats.Ammo	)
	arr.crit	= DarkRPG.verifyJobValue( job.crit		, DarkRPG.Stats.Crit	)
	
	arr.weapons	= DarkRPG.verifyWeaponTable( job.weapons )
	
	DarkRPG[job.team] = arr
end

--Creates A Default Job using DarkRPG.Config settings in case a job does not have any stats.
DarkRPG.createJobStats({
	team = "DEFAULT"
})

--Formula used to calculate and define a attribute's Name, Base, Next, Mod and Final values for the player.
function DarkRPG.calculateStat( level , ispercent , atr , base )
	local stats = {}
	stats.Name 	= atr.Name
	stats.Base 	= base[1] or atr.Base or 0
	stats.Base	= math.Clamp( stats.Base , 0 , stats.Base )
	
	stats.Next  = base[2] or atr.Next or 0
	stats.Next	= math.Clamp( stats.Next , 0 , stats.Next )

	if stats.Base < 0 or stats.Next <= 0 then 
		stats.Mod 	= 0
		stats.Next  = 0
		stats.Final = math.floor( stats.Base )
		return stats
	end
	
	stats.Mod = math.floor( math.Clamp( stats.Next * level, 0, atr.Max ))
	
	if ispercent 
	then stats.Final = math.floor( math.Clamp( stats.Base + stats.Mod , 0 , 100 ) )
	else stats.Final = math.Round( stats.Base + ( stats.Base * stats.Mod * 0.01 ) , 2 )
	end
	
	return stats
end

function DarkRPG.donatorCheck( ply )					--Use your check for VIP, Donator, Supporter, etc -- example at http://wiki.darkrp.com/index.php/Donator_Job_configuration#NOTES
	if DarkRPG.Config.DonatorGroups == nil or DarkRPG.Config.DonatorGroups == {} then return end
	
	for k, vip in pairs( DarkRPG.Config.DonatorGroups ) do
		return ply:GetNWString("usergroup") == vip		--FAdmin Default Admin Mod Installed with DarkRP
			or ply:GetUserGroup() == vip				--ULX Admin Mod check for "donator"
			or ply:GetNWString("EV_UserGroup") == vip	--Evolve Admin Mod Syntax
	end
end

function DarkRPG.adminCheck( ply )					--Use your check for VIP, Donator, Supporter, etc -- example at http://wiki.darkrp.com/index.php/Donator_Job_configuration#NOTES
	if DarkRPG.Config.AdminMethods then 
		return (ply:IsAdmin() or ply:IsSuperAdmin())
	end
	if DarkRPG.Config.AdminGroups == nil or DarkRPG.Config.AdminGroups == {} then return end
	for k, vip in pairs( DarkRPG.Config.AdminGroups ) do
		return ply:GetNWString("usergroup") == vip		--FAdmin Default Admin Mod Installed with DarkRP
			or ply:GetUserGroup() == vip				--ULX Admin Mod check for "donator"
			or ply:GetNWString("EV_UserGroup") == vip	--Evolve Admin Mod Syntax
	end
end

function DarkRPG.checkWeaponUnlock( ply , rlvl , vip , lvl )
	return (rlvl != nil and rlvl <= lvl)
		or (vip and DarkRPG.donatorCheck( ply ))
		or (DarkRPG.Config.AdminIgnore and DarkRPG.adminCheck( ply ))
end

function DarkRPG.playerLevelUp( ply , id , old , new )
	if  id == "level" 
	and isnumber(old) 
	and isnumber(new) 
	and old < new 
	and ply:Alive()
	then
		if CLIENT and not SERVER 
		then ply:EmitSound( DarkRPG.Config.LevelSound )
		else DarkRPG.playerSpawn( ply )
			 ply:DarkRPGUpdateClient({(ply:getDarkRPVar('level') or 1)})
		end
	end
end
hook.Add("DarkRPVarChanged","DarkRPG_PlayerLevelUp", DarkRPG.playerLevelUp )