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

local function xpUpdate(self)
	local cur = getExperienceCurrent()
	local max = getExperienceMax()
	local exhaustion = getRested()

	self:SetMinMaxValues(0, max)
	self:SetValue(cur)
	self.Rested:SetMinMaxValues(0, max)
	self.Rested:SetValue(math.min(cur + exhaustion, max))
end

local function xpUpdateColor(self)
	if (IsWatchingHonorAsXP()) then
		self:SetStatusBarColor(1, 1/4, 0)
	else
		self:SetStatusBarColor(1, 0, 1, 1)
	end
end

local function xpDisable(self)
	self:UnregisterEvent("PLAYER_XP_UPDATE")
	self:UnregisterEvent("HONOR_LEVEL_UPDATE")
	self:UnregisterEvent("HONOR_XP_UPDATE")
	self:UnregisterEvent("UPDATE_EXHAUSTION")
end

local function xpEnable(self)
	self:RegisterEvent("PLAYER_XP_UPDATE")
	self:RegisterEvent("HONOR_LEVEL_UPDATE")
	self:RegisterEvent("HONOR_XP_UPDATE")
	self:RegisterEvent("UPDATE_EXHAUSTION")
	xpUpdate(self)
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
		xpEnable(self.Experience)
		xpUpdateColor(self.Experience)
		ProgressBars:EnableBar(barName)
	else
		xpDisable(self.Experience)
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

local experience = CreateFrame("StatusBar", "Experience", experienceHolder)
experience:SetAllPoints(experienceHolder)
experience:SetStatusBarTexture(C.general.texture, "ARTWORK")
experience:SetFrameLevel(2)
experience:SetScript("OnEvent", xpUpdate)
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