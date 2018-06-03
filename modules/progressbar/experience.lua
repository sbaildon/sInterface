local _, ns = ...
local E, C = ns.E, ns.C

if not C.progressBars.enabled then return end;

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
	self:UnregisterEvent("HONOR_PRESTIGE_UPDATE")
	self:UnregisterEvent("UPDATE_EXHAUSTION")
end

local function xpEnable(self)
	self:RegisterEvent("PLAYER_XP_UPDATE")
	self:RegisterEvent("HONOR_LEVEL_UPDATE")
	self:RegisterEvent("HONOR_XP_UPDATE")
	self:RegisterEvent("HONOR_PRESTIGE_UPDATE")
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
		ns.ProgressBars.Insert(self)
		self:Show()
	else
		xpDisable(self.Experience)
		self:Hide()
		ns.ProgressBars.Remove(self)
	end
end


local experienceHolder = CreateFrame("Frame", "experienceHolder", UIParent)
experienceHolder:SetHeight(C.progressBars.experience.height)
experienceHolder:SetPoint("LEFT", ns.ProgressBars, "LEFT")
experienceHolder:SetPoint("RIGHT", ns.ProgressBars, "RIGHT")
experienceHolder:RegisterEvent('PLAYER_LEVEL_UP')
experienceHolder:RegisterEvent('DISABLE_XP_GAIN')
experienceHolder:RegisterEvent('ENABLE_XP_GAIN')
experienceHolder:RegisterEvent("PLAYER_ENTERING_WORLD")
experienceHolder:SetScript("OnEvent", xpVisibility)
hooksecurefunc('SetWatchingHonorAsXP', function(...)
	xpVisibility(experienceHolder)
end)
E:ShadowedBorder(experienceHolder)

local experience = CreateFrame("StatusBar", "ProgressBar", experienceHolder)
experience:SetAllPoints(experienceHolder)
experience:SetStatusBarTexture(C.general.texture, "ARTWORK")
experience:SetFrameLevel(2)
experience:SetScript("OnEvent", xpUpdate)
experienceHolder.Experience = experience

local rested = CreateFrame("StatusBar", "ProgressBarRested", experience)
rested:SetStatusBarTexture(C.general.texture, "ARTWORK")
rested:SetAllPoints(experience)
rested:SetStatusBarColor(0, 2/5, 1)
rested:SetFrameLevel(1)
experience.Rested = rested