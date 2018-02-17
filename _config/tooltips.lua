local _, ns = ...
local E, C = ns.E, ns.C

C["tooltips"] = {
	enabled = true,
	anchor_cursor = false,
	-- pos will be unused if anchor_cursor is set
	pos  = { "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -E:WidthPercentage(7), E:HeightPercentage(8) },
}
