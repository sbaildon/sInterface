local _, ns = ...
local E, C = ns.E, ns.C

if not C.progressBars.enabled then return end;

local ProgressBars = ns.sInterfaceProgressBars
local barName = "experience"

local function playerMaxLevel()
	local levelRestriction = GetRestrictedAccountData()

	return ((levelRestriction > 0) and levelRestriction or MAX_PLAYER_LEVEL)
end

local function  getExperienceCurrent()
	return (IsWatchingHonorAsXP() and UnitHonor or UnitXP)("player")
end

local function getExperienceMax()
	return (IsWatchingHonorAsXP() and UnitHonorMax or UnitXPMax)("player")
end

local function getLevel()
	return (IsWatchingHonorAsXP() and UnitHonorLevel or UnitLevel)("player")
end

-- local function getExperiencePercent()
-- 	return math.floor(getCurrentExpereience() / getExperienceMax() * 100 + 0.5)
-- end

local function getRested()
	return (IsWatchingHonorAsXP() and GetHonorExhaustion or GetXPExhaustion)() or 0
end

local function Update(bar)
	local cur = getExperienceCurrent()
	local max = getExperienceMax()
	local exhaustion = getRested()
	local level = getLevel()

	bar:SetAnimatedValues(cur, 0, max, level)
	bar.Rested:SetMinMaxValues(0, max)
	bar.Rested:SetValue(math.min(cur + exhaustion, max))
end

local function UpdateColor(bar)
	if (IsWatchingHonorAsXP()) then
		bar:SetStatusBarColor(1, 1/4, 0)
	else
		bar:SetStatusBarColor(1, 0, 1, 1)
	end
end

local function Disable(bar)
	bar:UnregisterEvent("PLAYER_XP_UPDATE")
	bar:UnregisterEvent("HONOR_LEVEL_UPDATE")
	bar:UnregisterEvent("HONOR_XP_UPDATE")
	bar:UnregisterEvent("UPDATE_EXHAUSTION")
end

local function Enable(bar)
	bar:RegisterEvent("PLAYER_XP_UPDATE")
	bar:RegisterEvent("HONOR_LEVEL_UPDATE")
	bar:RegisterEvent("HONOR_XP_UPDATE")
	bar:RegisterEvent("UPDATE_EXHAUSTION")
	Update(bar)
end

local function xpVisibility(self)
	local shouldEnable = true
	if (UnitLevel("player") == playerMaxLevel()) and (not IsWatchingHonorAsXP()) then
		shouldEnable = false
	end

	if (IsXPUserDisabled()) then
		shouldEnable = false
	end

	if (shouldEnable) then
		Enable(self.Experience)
		UpdateColor(self.Experience)
		ProgressBars:EnableBar(barName)
	else
		Disable(self.Experience)
		ProgressBars:DisableBar(barName)
	end
end

local experienceHolder = ProgressBars:CreateBar(barName)
experienceHolder:SetHeight(C.progressBars.experience.height)
experienceHolder:RegisterEvent('PLAYER_LEVEL_UP')
experienceHolder:RegisterEvent('DISABLE_XP_GAIN')
experienceHolder:RegisterEvent('ENABLE_XP_GAIN')
experienceHolder:RegisterEvent("PLAYER_ENTERING_WORLD")
experienceHolder:SetScript("OnEvent", xpVisibility)
hooksecurefunc('SetWatchingHonorAsXP', function(...)
	xpVisibility(experienceHolder)
end)

local experience = CreateFrame("StatusBar", "Experience", experienceHolder, "AnimatedStatusBarTemplate")
experience:SetMatchBarValueToAnimation(true)
experience:SetAllPoints(experienceHolder)
experience:SetStatusBarTexture(C.general.texture, "ARTWORK")
experience:SetFrameLevel(2)
experience:SetScript("OnEvent", Update)
experienceHolder.Experience = experience

local rested = CreateFrame("StatusBar", "ExperienceRested", experience)
rested:SetStatusBarTexture(C.general.texture, "ARTWORK")
rested:SetAllPoints(experience)
rested:SetStatusBarColor(0, 2/5, 1)
rested:SetFrameLevel(1)
experience.Rested = rested

local tooltip = GameTooltip
experienceHolder:SetScript("OnEnter", function(self)
	tooltip:SetOwner(self, "ANCHOR_CURSOR")
	tooltip:ClearLines()
	tooltip:AddLine(IsWatchingHonorAsXP() and "Honor" or "Experience")
	tooltip:AddDoubleLine("Level", getLevel(), 1, 1, 1)
	tooltip:AddDoubleLine("Current", E:CommaValue(getExperienceCurrent()), 1, 1, 1)
	tooltip:AddDoubleLine("Required", E:CommaValue(getExperienceMax()), 1, 1, 1)
	tooltip:AddDoubleLine("To level", E:CommaValue((getExperienceMax()-getExperienceCurrent())), 1, 1, 1)

	local rested = getRested()
	if rested > 0 then
		tooltip:AddDoubleLine("Rested", E:CommaValue(rested), 1, 1, 1)
	end

	tooltip:Show()
end)
experienceHolder:SetScript("OnLeave", function(self)
	tooltip:Hide()
end)