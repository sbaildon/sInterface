local _, ns = ...
local C = ns.C

if not C.actionbars.enabled then return end

local HiddenBlizzardArt = CreateFrame("Frame")
HiddenBlizzardArt:Hide()

for _, frame in next, {
	MainMenuBarArtFrame.PageNumber, ActionBarUpButton,ActionBarDownButton,
	MainMenuXPBarTextureLeftCap,MainMenuXPBarTextureRightCap,MainMenuXPBarTextureMid,
	StanceBarLeft, StanceBarMiddle, StanceBarRight, MainMenuBarArtFrameBackground,
	MainMenuExpBar,MainMenuBarMaxLevelBar, MainMenuBarArtFrame.LeftEndCap, MainMenuBarArtFrame.RightEndCap,
	OverrideActionBarExpBar, OverrideActionBarExpBarXpL, OverrideActionBarExpBarXpR,
	OverrideActionBarExpBarXpMid, OverrideActionBarPowerBar, OverrideActionBarHealthBar, MicroButtonAndBagsBar}
do	frame:SetParent(HiddenBlizzardArt) end

StatusTrackingBarManager:Hide()

for i = 1,2  do _G["PossessBackground"..i]:SetParent(HiddenBlizzardArt) end
for i = 0,1  do _G["SlidingActionBarTexture"..i]:SetParent(HiddenBlizzardArt) end

MainMenuBarArtFrame:EnableMouse(false)
MainMenuBar:EnableMouse(false)

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