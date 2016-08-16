local _, ns = ...
local C = ns.C

C["coolbar"] = {
	width = 160,
	height = 15,
	oocTransparency = 0.3,
	pos = { "TOP", "oUF_sInterfacePlayer", "BOTTOM", 0, -50 },
	disabled = {
		[GetItemInfo(6948) or "Hearthstone"] = true,
	}
}

