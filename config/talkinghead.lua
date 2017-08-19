local _, ns = ...
local E, C = ns.E, ns.C

C["talkinghead"] = {
	enabled = true,
	position = { "BOTTOM", UIParent, "BOTTOM", 0, E:HeightPercentage(10) },
	scale = 0.85
}
