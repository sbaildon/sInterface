local _, ns = ...
local C = ns.C
  
C["tooltips"] = {
	pos  = { "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -180, 180 },
	font = STANDARD_TEXT_FONT,
	backdrop = { bgFile = "Interface\\Buttons\\WHITE8x8", 
		edgeFile = "Interface\\Buttons\\WHITE8x8",
		tiled = false, edgeSize = 1,
		insets = { left = 0, right = 0, top = 0, bottom = 0 },
	},
	bgColor = { 0.03, 0.03, 0.03, 0.8 },
}
