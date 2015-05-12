-- Sends from Server to Client the player's current level
util.AddNetworkString("darkrpg_ply")
local meta = FindMetaTable("Player")
function meta:DarkRPGUpdateClient(args)
	net.Start("darkrpg_ply")
	net.WriteTable(args)
	net.Send(self)
end

-- Scans through weapons for a particular job and figures out which weapons to issue the spawning player.
function DarkRPG.giveWeapons( ply, index , level )
	if DarkRPG[index].weapons == nil 
	or !istable(DarkRPG[index].weapons) 
	or DarkRPG[index].weapons == {} 
	or #DarkRPG[index].weapons == 0 then return end

	for k, wpn in pairs( DarkRPG[index].weapons ) do
		if DarkRPG.checkWeaponUnlock( ply , wpn[1] , wpn[2] , level )
		then 
			ply:Give( wpn[3] )
			wpn = ply:GetWeapon( wpn[3] )
			
			if wpn.Primary != nil then
				if wpn.Primary.Damage != nil then
					val = { wpn.Primary.Damage, DarkRPG[index].damage[2] }
					val = DarkRPG.calculateStat( level , false, DarkRPG.Stats.Damage, val )
					wpn.Primary.Damage = val.Final
				end
				if wpn.Primary.DefaultClip != nil then
					val = { wpn.Primary.DefaultClip, DarkRPG[index].ammo[2] }
					val = DarkRPG.calculateStat( level , false, DarkRPG.Stats.Ammo, val )
					ply:GiveAmmo( math.floor(val.Final - val.Base) , wpn:GetPrimaryAmmoType() )
				end
				if wpn.Primary.ClipSize != nil then
					val = { wpn.Primary.ClipSize, DarkRPG[index].mag[2] }
					val = DarkRPG.calculateStat( level , false, DarkRPG.Stats.Mag, val )
					wpn.Primary.ClipSize = val.Final
				end
				if wpn.Primary.Delay != nil then
					val = { wpn.Primary.Delay, DarkRPG[index].speed[2] }
					val = DarkRPG.calculateStat( level , true, DarkRPG.Stats.Speed, val )
					wpn.Primary.Delay = math.Clamp ( wpn.Primary.Delay * ( 1.0 - ( val.Final / 100 ) ) , 0.05 , wpn.Primary.Delay )
				end
			end
		end
	end
end


function DarkRPG.playerSpawn( ply )
	local val, level, index
	
	index = ply:getJobTable().team or "DEFAULT"
	index = (DarkRPG[index] != nil and index) or "DEFAULT"
	level = ply:getDarkRPVar('level') or 1
	
	-- Sets SERVER value for Health
	val = DarkRPG.calculateStat( level, false, DarkRPG.Stats.Health, DarkRPG[index].health )
	ply:SetHealth( val.Final )
	ply:SetMaxHealth( val.Final )
	
	-- Sets SERVER value for Armor
	val = DarkRPG.calculateStat( level , false, DarkRPG.Stats.Armor, DarkRPG[index].armor )
	ply:SetArmor( val.Final )
	
	-- Sets SERVER value for Jump Power
	val = DarkRPG.calculateStat( level , false, DarkRPG.Stats.Jump, DarkRPG[index].jump )
	ply:SetJumpPower( val.Final )
	
	-- Sets SERVER values for Run Speed
	val = DarkRPG.calculateStat( level , false, DarkRPG.Stats.Move, DarkRPG[index].move )
	ply:SetNWFloat( 'Darkrpg_move', val.Final )
	ply:SetRunSpeed( val.Final or DarkRP.GAMEMODE.Config.runspeed or 240 )
	
	-- Sets SERVER values for Evade
	val = DarkRPG.calculateStat( level , true, DarkRPG.Stats.Evade, DarkRPG[index].evade )
	ply:SetNWFloat( 'Darkrpg_evade', val.Final )
	
	-- Sets SERVER values for Reflect Damage / Mirror
	val = DarkRPG.calculateStat( level , true, DarkRPG.Stats.Mirror, DarkRPG[index].mirror )
	ply:SetNWFloat( 'Darkrpg_mirror', math.Clamp( val.Final , 0, 50 ) ) -- Kills the ability to set reflect above 90
	
	-- Sets SERVER values for Normal
	val = DarkRPG.calculateStat( level , true, DarkRPG.Stats.Normal, DarkRPG[index].normal )
	val = 1.0 - ( val.Final*0.01 )
	ply:SetNWFloat( 'Darkrpg_normal', val )
	
	-- Sets SERVER values for Endurance
	val = DarkRPG.calculateStat( level , true, DarkRPG.Stats.Endur, DarkRPG[index].endur )
	val = 1.0 - ( val.Final*0.01 )
	ply:SetNWFloat( 'Darkrpg_endur', val )
	
	-- Sets SERVER values for Burning
	val = DarkRPG.calculateStat( level , true, DarkRPG.Stats.Burn, DarkRPG[index].burn )
	val = 1.0 - ( val.Final*0.01 )
	ply:SetNWFloat( 'Darkrpg_burn', val )
	
	-- Sets SERVER values for Crushing / Prop Kill
	val = DarkRPG.calculateStat( level , true, DarkRPG.Stats.Crush, DarkRPG[index].crush )
	val = 1.0 - ( val.Final*0.01 )
	ply:SetNWFloat( 'Darkrpg_crush', val )
	
	-- Sets SERVER values for Explosion
	val = DarkRPG.calculateStat( level , true, DarkRPG.Stats.Explode, DarkRPG[index].explode )
	val = 1.0 - ( val.Final*0.01 )
	ply:SetNWFloat( 'Darkrpg_explode', val )
	
	-- Sets SERVER values for Critical Chance
	val = DarkRPG.calculateStat( level , true, DarkRPG.Stats.Crit, DarkRPG[index].crit )
	ply:SetNWFloat( 'Darkrpg_crit', val.Final )
	
	-- Sets SERVER values for Buy Reduction
	val = DarkRPG.calculateStat( level , true, DarkRPG.Stats.Buy, DarkRPG[index].buy )
	val = (val.Final*0.01)
	ply:SetNWFloat( 'Darkrpg_buy', val )
	
	-- Sets SERVER values for Prison Reduction
	val = DarkRPG.calculateStat( level , true, DarkRPG.Stats.Prison, DarkRPG[index].prison )
	val = GAMEMODE.Config.jailtimer - GAMEMODE.Config.jailtimer*(val.Final*0.01)
	ply:SetNWFloat( 'Darkrpg_prison', val )
	
	-- Sets SERVER values for Salary Increase
	val = DarkRPG.calculateStat( level , true, DarkRPG.Stats.Salary, DarkRPG[index].salary )
	val = (val.Final*0.01)
	ply:SetNWFloat( 'Darkrpg_salary', val )
	
	-- Runs the check for giving players their weapons and buffing their damage.
	DarkRPG.giveWeapons( ply , index , level )
end

-- Code which runs on job switch or player respawn.
function DarkRPG.playerSpawnTimer( ply )
	timer.Simple( math.Clamp( DarkRPG.Config.EquipTimer , 1, DarkRPG.Config.EquipTimer ), function() 
		if !ply:Alive() then return end
		DarkRPG.playerSpawn(ply)
		ply:DarkRPGUpdateClient( {(ply:getDarkRPVar('level') or 1)} )
	end)
end
hook.Add("PlayerSpawn", 		"DarkRPG_PlayerSpawn", 		function(ply) DarkRPG.playerSpawnTimer( ply ) end )
hook.Add("OnPlayerChangedTeam", "DarkRPG_PlayerSpawnTeam", 	function(ply) DarkRPG.playerSpawnTimer( ply ) end )

-- Override the player movement for the movement trait.
function DarkRPG.movementUpdate( ply )
	ply:SetWalkSpeed( DarkRP.GAMEMODE.Config.runspeed or 160 )
	ply:SetRunSpeed( ply:GetNWFloat( 'Darkrpg_move' , DarkRP.GAMEMODE.Config.runspeed) or 240 )
	return true
end
hook.Add("UpdatePlayerSpeed", "DarkRPG_movementUpdate", function(ply) DarkRPG.movementUpdate( ply ) return true end )

-- Checks for damage resistances and scales damage, critical hits, evade and reflects.
local mirrordmg
hook.Add("EntityTakeDamage", "DarkRPG_resistCheck", function ( ply , dmg ) 
	if ply:IsPlayer() then
	
		local atk, dtype, scale
		
		-- Since 'PlayerShouldTakeDamage' does not have dmginfo value in the hook, 
		-- this variable saves it for use in that hook.
		mirrordmg = dmg
		
		-- Sets damage scaling and runs the critical hit check!
		scale = 1
		atk = dmg:GetAttacker()
		if atk:GetNWFloat( 'Darkrpg_crit' , -1) >= math.random(1,100) then
			scale = DarkRPG.Config.CritScale
		end
		
		--Check all five damage types
		dtype = dmg:GetDamageType() 
		if table.HasValue( DarkRPG.Config.Explosion, dtype ) 
		then dmg:ScaleDamage( ply:GetNWFloat( 'Darkrpg_explode' , 1.0) * scale )
		elseif table.HasValue( DarkRPG.Config.Endurance,dtype ) 
		then dmg:ScaleDamage( ply:GetNWFloat( 'Darkrpg_endur' 	, 1.0) * scale )
		elseif table.HasValue( DarkRPG.Config.Crushing, dtype )
		then dmg:ScaleDamage( ply:GetNWFloat( 'Darkrpg_crush' 	, 1.0) * scale )
		elseif table.HasValue( DarkRPG.Config.Burning, 	dtype )
		then dmg:ScaleDamage( ply:GetNWFloat( 'Darkrpg_burn' 	, 1.0) * scale )
		else dmg:ScaleDamage( ply:GetNWFloat( 'Darkrpg_normal' 	, 1.0) * scale )
		end
		
		return ply, dmg
	end
	
end)

-- Required, runs immediately after the ResistCheck and determines if damage should be applied.
hook.Add( "PlayerShouldTakeDamage" , "DarkRPG_TakeDamageEnable" , function( ply, atk )
	if ply:IsPlayer() then
	
		--evade check
		if ply:GetNWFloat( 'Darkrpg_evade' , -1) >= math.random(1,100) 
		then
			ply:EmitSound("weapons/fx/rics/ric"..math.random(1,5)..".wav")
			return false
		elseif atk != nil and atk != ply and ((atk:IsPlayer() and atk:Alive()) or atk:IsNPC())
		then
			--mirror check
			if ply:GetNWFloat( 'Darkrpg_mirror' , -1) >= math.random(1,100) then
				ply:EmitSound("npc/manhack/grind"..math.random(1,5)..".wav")
				atk:TakeDamageInfo(mirrordmg)
				return false
			end
		else return true end
	end
	return true
end)

-- Overrides the purchase cost for most items, vehicles and doors are disabled due to exploitation from buy / reselling and gaining money.
function DarkRPG.buyBonus(ply,price)
	ply:addMoney( ply:GetNWFloat( 'Darkrpg_buy' , 1.0) *  price )
end
hook.Add("playerBoughtCustomEntity", 	"DarkRPG_BuyCustomEnt", function(ply,entTable,ent,price) DarkRPG.buyBonus( ply, price ) end)
hook.Add("playerBoughtAmmo", 			"DarkRPG_BuyAmmo", 		function(ply,entTable,ent,price) DarkRPG.buyBonus( ply, price ) end)
hook.Add("playerBoughtPistol", 			"DarkRPG_BuyPistol", 	function(ply,entTable,ent,price) DarkRPG.buyBonus( ply, price ) end)
hook.Add("playerBoughtShipment", 		"DarkRPG_BuyShipment", 	function(ply,entTable,ent,price) DarkRPG.buyBonus( ply, price ) end)

-- Cancels out the arrest and runs it again with the player's reduced jail timer.
-- arrestCheck stops an infinite regress of arrest recursions, b/c the DarkRP Hook does not accept return values to update the arrest.
local arrestCheck = false
hook.Add("playerArrested", "DarkRPG_Prison", function( ply , timer , cop ) 
	if !arrestCheck then
		arrestCheck = true
		ply:arrest( ply:GetNWFloat( 'Darkrpg_prison' , DarkRP.GAMEMODE.Config.jailtimer) , cop )
		return true
	else
		arrestCheck = false
	end
end)

-- Overrides the Player's Salary settings with the NWVar settings.
hook.Add( "playerGetSalary", "DarkRPG_Salary", function( ply , amount ) 
	local newamt = ply:GetNWFloat( 'Darkrpg_salary' , 0 ) * amount + 1.0
	newamt = math.floor(newamt + amount) or amount
	return false, "Payday! You have received $"..newamt.."!", newamt
end)

-- Stops the player from dropping the modded Unlock weapons.
function playerWeaponDropCheck( ply , weapon )

	local index = ply:getJobTable().team or "DEFAULT"
	index = (DarkRPG[index] != nil and index) or "DEFAULT"

	if 	DarkRPG[index].weapons != nil 
	and DarkRPG[index].weapons != {}
	then 
		for k, wpn in pairs( DarkRPG[index].weapons ) do
			if wpn[3] == weapon:GetClass() 
			then return false end
		end
	end
end
hook.Add( "canDropWeapon", "DarkRPG_StopWeaponDrop", playerWeaponDropCheck )
