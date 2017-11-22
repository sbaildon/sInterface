local _, ns = ...
local E, C = ns.E, ns.C

C["tooltips"] = {
	enabled = true,
	anchor_cursor = false,
	-- pos will be unused if anchor_cursor is set
	pos  = { "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -E:WidthPercentage(7), E:HeightPercentage(8) },
	font = STANDARD_TEXT_FONT,
	backdrop = { bgFile = "Interface\\Buttons\\WHITE8x8",
		edgeFile = "Interface\\Buttons\\WHITE8x8",
		tiled = false, edgeSize = 1,
		insets = { left = 0, right = 0, top = 0, bottom = 0 },
	},
	bgColor = { 0.03, 0.03, 0.03, 0.8 },
}
