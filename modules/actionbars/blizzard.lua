local _, ns = ...
local E, C = ns.E, ns.C

if not C.actionbars.enabled then return end

local HiddenBlizzardArt = CreateFrame("Frame")
HiddenBlizzardArt:Hide()

for _, frame in next, {
	MainMenuBarPageNumber,ActionBarUpButton,ActionBarDownButton, 
	MainMenuXPBarTextureLeftCap,MainMenuXPBarTextureRightCap,MainMenuXPBarTextureMid,
	StanceBarLeft, StanceBarMiddle, StanceBarRight,
	MainMenuExpBar,MainMenuBarMaxLevelBar, MainMenuBarLeftEndCap, MainMenuBarRightEndCap,
	ReputationWatchBar,ReputationWatchBar.StatusBar,
	HonorWatchBar,HonorWatchBar.StatusBar,
	ArtifactWatchBar,ArtifactWatchBar.StatusBar }
do	frame:SetParent(HiddenBlizzardArt) end

for i = 0,3  do _G["MainMenuBarTexture"..i]:SetParent(HiddenBlizzardArt) end
for i = 0,3  do _G["MainMenuMaxLevelBar"..i]:SetParent(HiddenBlizzardArt) end
for i = 1,2  do _G["PossessBackground"..i]:SetParent(HiddenBlizzardArt) end
for i = 0,1  do _G["SlidingActionBarTexture"..i]:SetParent(HiddenBlizzardArt) end
for i = 1,19 do _G["MainMenuXPBarDiv"..i]:SetParent(HiddenBlizzardArt) end

for i = 0,3 do ReputationWatchBar.StatusBar["WatchBarTexture"..i]:SetParent(HiddenBlizzardArt) end
for i = 0,3 do ArtifactWatchBar.StatusBar["WatchBarTexture"..i]:SetParent(HiddenBlizzardArt) end
for i = 0,3 do HonorWatchBar.StatusBar["WatchBarTexture"..i]:SetParent(HiddenBlizzardArt) end
for i = 0,3 do ReputationWatchBar.StatusBar["XPBarTexture"..i]:SetParent(HiddenBlizzardArt) end
for i = 0,3 do ArtifactWatchBar.StatusBar["XPBarTexture"..i]:SetParent(HiddenBlizzardArt) end
for i = 0,3 do HonorWatchBar.StatusBar["XPBarTexture"..i]:SetParent(HiddenBlizzardArt) end

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