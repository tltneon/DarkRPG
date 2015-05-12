-- Creating fonts here, use a web safe font.

local function EOTI_CreateFont(size)
	surface.CreateFont( "EOTI_HUD_"..size, {
	font = "Trebuchet MS",
	size = size,
	weight = 800,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
	} )
end

EOTI_CreateFont(18)
EOTI_CreateFont(19)
EOTI_CreateFont(20)