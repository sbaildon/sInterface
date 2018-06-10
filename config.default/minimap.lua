local _, ns = ...
local C = ns.C

C["minimap"] = {
	enabled = true,
	position = { "TOPRIGHT", UIParent, "TOPRIGHT", -C.general.edgeSpacing, -C.general.edgeSpacing },
	width = 150,
	height = 150
}

