local _, ns = ...
local E, C = ns.E, ns.C

if not C.actionbars.enabled then return end

local HiddenBlizzardArt = CreateFrame("Frame")
HiddenBlizzardArt:Hide()

for _, frame in next, {
	MainMenuBar,
	OverrideActionBarExpBar, OverrideActionBarHealthBar,
	OverrideActionBarPowerBar, OverrideActionBarPitchFrame
} do
	frame:SetParent(HiddenBlizzardArt)
end

for _, texture in next, {
	"_BG",
	"EndCapL",
	"EndCapR",
	"_Border",
	"Divider1",
	"Divider2",
	"Divider3",
	"ExitBG",
	"MicroBGL",
	"MicroBGR",
	"_MicroBGMid",
	"ButtonBGL",
	"ButtonBGR",
	"_ButtonBGMid"
} do
	OverrideActionBar[texture]:Hide()
end
