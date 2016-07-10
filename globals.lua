local addon, ns = ...
local globals = CreateFrame("Frame")
ns.globals = globals

local media_path = "Interface\\AddOns\\sInterface\\media\\"

globals.media = {
	shadow = media_path.."shadow_border",
	bar = media_path.."bar",
	font = media_path.."font.ttf",
	mail = media_path.."mail"
}