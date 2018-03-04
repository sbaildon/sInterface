local _, ns = ...
local C = ns.C

local media = "Interface\\AddOns\\sInterface\\media\\"

C["general"] = {
	texture = media..'bar',
	edgeSpacing = 20,
	oocAlpha = 0.3,

	displayFont = {
		typeface = media.."AlegreyaSans-Bold.ttf",
		size = 12,
		flag = "OUTLINE"
	},

	bodyFont = {
		typeface = media.."AlegreyaSans-Medium.ttf",
		size = 12,
		flag = "NONE"
	}
}

C["gameinfo"] = {
	screen_width = GetScreenWidth() * UIParent:GetEffectiveScale(),
	screen_height = GetScreenHeight() * UIParent:GetEffectiveScale()
}
