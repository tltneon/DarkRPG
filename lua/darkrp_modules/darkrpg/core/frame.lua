local hCenter, vCenter, edgeLeft, curText, levelSize, mat, ui, offx, offy

-- Client GUI settings

ui = DarkRPG.Config

ui.Width = 360
ui.Height = 600
ui.X = (DarkRPG.Config.LeftMode and ui.PosX) or (surface.ScreenWidth() - (ui.PosX + ui.Width))
ui.Y = (DarkRPG.Config.TopMode and ui.PosY) or (surface.ScreenHeight() - (ui.PosY + ui.Width))

hCenter = ui.X + ui.Width / 2
vCenter = ui.Y + ui.Height / 2
edgeLeft = ui.X + 30

surface.SetFont(ui.FontLevel)
levelSize = surface.GetTextSize("Size")/2

-- Precache the Material and Sound Effects

mat = Material( "darkrpg/"..DarkRPG.Config.CurrentMotif or "darkrpg/darkMarble.png" )
DarkRPG.Config.SpawnSound	= Sound( "darkrpg/"..DarkRPG.Config.SpawnSound )
DarkRPG.Config.OpenSound	= Sound( "darkrpg/"..DarkRPG.Config.OpenSound  )
DarkRPG.Config.CloseSound	= Sound( "darkrpg/"..DarkRPG.Config.CloseSound )
DarkRPG.Config.LevelSound	= Sound( "darkrpg/"..DarkRPG.Config.LevelSound )

-- Rotates the hints on the character sheet.
local function DarkRPG_ChangeHints()
	DarkRPG.Config.Hint = DarkRPG.Config.Hints[ math.random(1, #DarkRPG.Config.Hints) ]
end

local function DarkRPG_drawStat( atr , yaxis ) 
	curText.text = atr.Name or "NIL"
	curText.font = ui.FontInfos
	curText.pos[1] = edgeLeft + 10
	curText.pos[2] = yaxis
	curText.xalign = TEXT_ALIGN_LEFT
	curText.color = ui.ColorSubT or Color(200,150,20)
	
	draw.Text(curText)
	
	curText.text = atr.Final or "NIL"
	curText.pos[1] = edgeLeft + 170
	curText.xalign = TEXT_ALIGN_RIGHT
	curText.color = atr.ColorFinal or ui.ColorDefault or Color(200,200,200)
	
	draw.Text(curText)
	
	curText.text = atr.Base or "NIL"
	curText.pos[1] = curText.pos[1] + 40
	curText.color = atr.ColorBase or ui.ColorDefault or Color(200,200,200)
	
	draw.Text(curText)
	
	curText.text = atr.Mod or "NIL"
	curText.pos[1] = curText.pos[1] + 45
	curText.color = atr.ColorMod or ui.ColorUpgrade or Color(200,200,200)
	
	draw.Text(curText)
	
	curText.text = atr.Next or "NIL"
	curText.pos[1] = curText.pos[1] + 45
	curText.color = atr.ColorNext or ui.ColorUpgrade or Color(200,200,200)
	
	draw.Text(curText)
end

local function DarkRPG_drawTitle( title , yaxis )
	curText.text = title or "NIL"
	curText.font = ui.FontTitle
	curText.pos[1] = edgeLeft
	curText.pos[2] = yaxis
	curText.xalign = TEXT_ALIGN_LEFT
	curText.color = ui.ColorTitle or Color(200,200,200)
	
	draw.Text(curText)
end

local function DarkRPG_drawUnlock( wpn , xaxis , yaxis )
	if wpn == nil then return end
	curText.text = wpn.Name or "NIL"
	curText.font = ui.FontInfos
	curText.pos[1] = xaxis + 10
	curText.pos[2] = yaxis
	curText.xalign = TEXT_ALIGN_LEFT
	curText.color = ui.ColorSubT or Color(200,150,20)
	
	draw.Text(curText)
	
	curText.text = wpn.Lock or "NIL"
	curText.pos[1] = xaxis + 150
	curText.xalign = TEXT_ALIGN_RIGHT
	curText.color = wpn.Color or ui.ColorFail or Color(200,150,20)
	
	draw.Text(curText)
end

local function DarkRPG_drawInfo( yaxis )
	curText.text = DarkRPG.Config.Hint
	curText.font = ui.FontInfos
	curText.pos[1] = edgeLeft
	curText.pos[2] = ui.Y + ui.Height - 27
	curText.xalign = TEXT_ALIGN_LEFT
	curText.color = ui.ColorInfo or Color(200,150,20)
	
	draw.Text(curText)
end

local function DarkRPG_drawHeadline()
	curText.text = LocalPlayer():Nick() or "Anonymous"
	curText.font = ui.FontTitle
	curText.pos[1] = hCenter
	curText.pos[2] = ui.Y + 20
	curText.xalign = TEXT_ALIGN_CENTER
	curText.yalign = TEXT_ALIGN_TOP
	curText.color = ui.ColorTitle or Color(200,200,200)
	
	draw.Text(curText)
	
	curText.text = "Lv. "..(DarkRPG.Stats.Display.level or "??").." "..(DarkRPG.Stats.Display.jobname or "Unknown Job")
	curText.font = ui.FontLevel
	curText.pos[2] = curText.pos[2] + levelSize + 10
	curText.xalign = TEXT_ALIGN_CENTER
	curText.yalign = TEXT_ALIGN_TOP
	curText.color = ui.ColorSubT or Color(200,150,20)
	
	draw.Text(curText)
	
	curText.text = "Final"
	curText.pos[1] = edgeLeft + 170
	curText.pos[2] = curText.pos[2] + 25
	curText.xalign = TEXT_ALIGN_RIGHT
	curText.color = ui.ColorTitle or Color(200,200,200)
	
	draw.Text(curText)
	
	curText.text = "Base"
	curText.pos[1] = curText.pos[1] + 40
	
	draw.Text(curText)
	
	curText.text = "Mod"
	curText.pos[1] = curText.pos[1] + 45
	
	draw.Text(curText)
	
	curText.text = "Next"
	curText.pos[1] = curText.pos[1] + 45
	
	draw.Text(curText)
	
end

local function DarkRPG_playerHUD()
	local x , y , stat , tle
	stat = DarkRPG.Stats.Display
	tle  = DarkRPG.Stats.Titles
	
	curText = {}
	curText.pos = {}
	
	surface.SetDrawColor( 255, 255, 255 )
	surface.SetMaterial( mat )
	surface.DrawTexturedRect(ui.X,ui.Y,380,636)
	
	DarkRPG_drawHeadline()
	
	curText.yalign = TEXT_ALIGN_TOP
	y = levelSize + 3
	
	DarkRPG_drawTitle( tle.Body, 	curText.pos[2] )
	DarkRPG_drawStat( stat.Health, 	curText.pos[2] + y + 2 )
	DarkRPG_drawStat( stat.Move, 	curText.pos[2] + y )
	DarkRPG_drawStat( stat.Jump, 	curText.pos[2] + y )
	
	DarkRPG_drawTitle( tle.Def, 	curText.pos[2] + 18 )
	DarkRPG_drawStat( stat.Armor, 	curText.pos[2] + y + 2 )
	DarkRPG_drawStat( stat.Evade, 	curText.pos[2] + y )
	DarkRPG_drawStat( stat.Mirror,	curText.pos[2] + y )
	
	DarkRPG_drawTitle( tle.Char, 	curText.pos[2] + 18 )
	DarkRPG_drawStat( stat.Salary,	curText.pos[2] + y + 2 )
	DarkRPG_drawStat( stat.Buy, 	curText.pos[2] + y )
	DarkRPG_drawStat( stat.Prison, 	curText.pos[2] + y )
	
	DarkRPG_drawTitle( tle.Resist,	curText.pos[2] + 18 )
	DarkRPG_drawStat( stat.Normal, 	curText.pos[2] + y + 2 )
	DarkRPG_drawStat( stat.Endur, 	curText.pos[2] + y )
	DarkRPG_drawStat( stat.Burn, 	curText.pos[2] + y )
	DarkRPG_drawStat( stat.Crush, 	curText.pos[2] + y )
	DarkRPG_drawStat( stat.Explode, curText.pos[2] + y )
	
	DarkRPG_drawTitle( tle.Weap,	curText.pos[2] + 18 )
	DarkRPG_drawStat( stat.Damage, 	curText.pos[2] + y + 2 )
	DarkRPG_drawStat( stat.Crit, 	curText.pos[2] + y )
	DarkRPG_drawStat( stat.Speed, 	curText.pos[2] + y )
	DarkRPG_drawStat( stat.Mag, 	curText.pos[2] + y )
	DarkRPG_drawStat( stat.Ammo, 	curText.pos[2] + y )
	
	DarkRPG_drawTitle( tle.Unlock,curText.pos[2] + 18 )
	
	x = curText.pos[2]
	if stat.Weapons != nil and stat.Weapons != {} then
	
	DarkRPG_drawUnlock( stat.Weapons[1] , edgeLeft , curText.pos[2] + y + 2 )
	DarkRPG_drawUnlock( stat.Weapons[2] , edgeLeft , curText.pos[2] + y )
	DarkRPG_drawUnlock( stat.Weapons[3] , edgeLeft , curText.pos[2] + y )
	DarkRPG_drawUnlock( stat.Weapons[4] , edgeLeft , curText.pos[2] + y )
	DarkRPG_drawUnlock( stat.Weapons[5] , edgeLeft , curText.pos[2] + y )
	
	curText.pos[2] = x
	x = edgeLeft + 150
	
	DarkRPG_drawUnlock( stat.Weapons[6] , x , curText.pos[2] + y  + 2 )
	DarkRPG_drawUnlock( stat.Weapons[7] , x , curText.pos[2] + y )
	DarkRPG_drawUnlock( stat.Weapons[8] , x , curText.pos[2] + y )
	DarkRPG_drawUnlock( stat.Weapons[9]	, x , curText.pos[2] + y )
	DarkRPG_drawUnlock( stat.Weapons[10], x , curText.pos[2] + y )
	
	end
	
	DarkRPG_drawInfo()
end
hook.Add( "HUDPaint", "DarkRPG_playerHUD", function() 
	DarkRPG_playerHUD() 
	timer.Create( "DarkRPG_Hints" , DarkRPG.Config.HintSpeed , 0 , function() DarkRPG_ChangeHints() end)
end )

local function DarkRPG_BlankStats()
	DarkRPG.Stats.Display.Damage.Base = "N/A"
	DarkRPG.Stats.Display.Ammo.Base = "N/A"
	DarkRPG.Stats.Display.Speed.Base = "N/A"
	DarkRPG.Stats.Display.Mag.Base = "N/A"
		
	DarkRPG.Stats.Display.Damage.Final = "N/A"
	DarkRPG.Stats.Display.Ammo.Final = "N/A"
	DarkRPG.Stats.Display.Speed.Final = "N/A"
	DarkRPG.Stats.Display.Mag.Final = "N/A"
end

local function DarkRPG_UpdateWeaponHUD(wpn)
	local index, level, val
	index = LocalPlayer():getJobTable().team or "DEFAULT"
	index = (DarkRPG[index] != nil and index) or "DEFAULT"
	level = DarkRPG.Stats.Display.level
	
	if 	wpn.Primary == nil 
	or  DarkRPG[index].weapons == nil 
	or  DarkRPG[index].weapons == {}
	then 
		DarkRPG_BlankStats()
		return true
	end
	
	for k, weps in pairs( DarkRPG[index].weapons ) do
		if weps[3] == wpn:GetClass() then
			DarkRPG.Stats.Display.Damage = DarkRPG.concatClientStat( level , false, DarkRPG.Stats.Damage, { (wpn.Primary.Damage or 0)		, DarkRPG[index].damage[2] 	} )
			DarkRPG.Stats.Display.Ammo 	 = DarkRPG.concatClientStat( level , false, DarkRPG.Stats.Ammo	, { (wpn.Primary.DefaultClip or 0)	, DarkRPG[index].ammo[2]   	} )
			DarkRPG.Stats.Display.Mag 	 = DarkRPG.concatClientStat( level , false, DarkRPG.Stats.Mag	, { (wpn.Primary.ClipSize or 0)		, DarkRPG[index].mag[2] 	} )
			DarkRPG.Stats.Display.Speed  = DarkRPG.concatClientStat( level , true , DarkRPG.Stats.Speed	, { DarkRPG.Stats.Speed.Base		, DarkRPG[index].speed[2]   } )
			return
		end
	end
	DarkRPG_BlankStats()
end
hook.Add( "PlayerSwitchWeapon", "DarkRPG_WeaponSwitch", function( ply, old, new ) DarkRPG_UpdateWeaponHUD( new ) end)

-- Key variables used for hud moving and visibility.
local hudIsMoving = false
local hudIsVisible = true
local keyIsDown = false

-- Axis Aligned Bounding Box from the Upper Hand Corner, used for moving the HUD.
local function aaBB_mouseCorner( x, y, w, h )
  return gui.MouseX() >= x  
	 and gui.MouseX() <  x+w 
     and gui.MouseY() >= y 
     and gui.MouseY() <  y+h
end

-- Checks to see if you clicked your mouse
hook.Add( "GUIMousePressed", "DarkRPG_MousePressed", function()
	if aaBB_mouseCorner( ui.X, ui.Y, ui.Width, ui.Height ) then
		hudIsMoving = true
		offx = ui.X - gui.MouseX()
		offy = ui.Y - gui.MouseY()
	end
end)

hook.Add( "GUIMouseReleased", "DarkRPG_MouseReleased", function()
	hudIsMoving = false
end)

hook.Add( "Think", "DarkRPG_ToggleHUD", function()
	local key = input.IsKeyDown( DarkRPG.Config.ToggleKey )
	if key and !keyIsDown then 
		
		keyIsDown = true
		
	elseif keyIsDown and !key then
	
		keyIsDown = false
		hudIsVisible = !hudIsVisible
		
		if hudIsVisible 
		then 
			hook.Add( "HUDPaint" , "DarkRPG_playerHUD" , DarkRPG_playerHUD )
			LocalPlayer():EmitSound(DarkRPG.Config.OpenSound)
			timer.Create( "DarkRPG_Hints" , DarkRPG.Config.HintSpeed , 0 , function() DarkRPG_ChangeHints() end)
		else 
			hook.Remove( "HUDPaint", "DarkRPG_playerHUD" )
			LocalPlayer():EmitSound(DarkRPG.Config.CloseSound)
			timer.Remove( "DarkRPG_Hints" )
		end
	elseif hudIsMoving then
		ui.X = math.Clamp( gui.MouseX() + offx , -300 , surface.ScreenWidth() - 60 )
		ui.Y = math.Clamp( gui.MouseY() + offy , -540 , surface.ScreenHeight() - 60 )
		hCenter = ui.X + ui.Width / 2
		vCenter = ui.Y + ui.Height / 2
		edgeLeft = ui.X + 30
	end
end )