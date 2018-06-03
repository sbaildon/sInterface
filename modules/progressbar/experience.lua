local _, ns = ...
local E, C = ns.E, ns.C

if not C.progressBars.enabled then return end;

local barName = "experience"
local ProgressBars = ns.sInterfaceProgressBars

ProgressBars:RegisterBar(barName)

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

-- local function getRested()
-- 	return (IsWatchingHonorAsXP() and GetHonorExhaustion or GetXPExhaustion)() or 0
-- end

local function xpUpdate(self)
	local cur = getExperienceCurrent()
	local max = getExperienceMax()
	-- local exhaustion = getRested()

	ProgressBars:SetBarValues(barName, 0, max, cur)

	if (IsWatchingHonorAsXP()) then
		ProgressBars:SetBarColor(barName, 1, 1/4, 0)
	else
		ProgressBars:SetBarColor(barName, 1, 0, 1, 1)
	end
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
		ProgressBars:EnableBar(barName)
		self:RegisterEvent("PLAYER_XP_UPDATE")
		self:RegisterEvent("HONOR_LEVEL_UPDATE")
		self:RegisterEvent("HONOR_XP_UPDATE")
		self:RegisterEvent("HONOR_PRESTIGE_UPDATE")
		self:RegisterEvent("UPDATE_EXHAUSTION")
		xpUpdate()
	else
		ProgressBars:DisableBar(barName)
		self:UnregisterEvent("PLAYER_XP_UPDATE")
		self:UnregisterEvent("HONOR_LEVEL_UPDATE")
		self:UnregisterEvent("HONOR_XP_UPDATE")
		self:UnregisterEvent("HONOR_PRESTIGE_UPDATE")
		self:UnregisterEvent("UPDATE_EXHAUSTION")
	end
end

local eventFrame = CreateFrame("Frame", "eventHolder", UIParent)
eventFrame:RegisterEvent('PLAYER_LEVEL_UP')
eventFrame:RegisterEvent('DISABLE_XP_GAIN')
eventFrame:RegisterEvent('ENABLE_XP_GAIN')
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:SetScript("OnEvent", xpVisibility)
hooksecurefunc('SetWatchingHonorAsXP', function(...)
	xpVisibility(eventFrame)
end)
eventFrame:SetScript("OnEvent", xpUpdate)

-- local rested = CreateFrame("StatusBar", "ProgressBarRested", experience)
-- rested:SetStatusBarTexture(C.general.texture, "ARTWORK")
-- rested:SetAllPoints(experience)
-- rested:SetStatusBarColor(0, 2/5, 1)
-- rested:SetFrameLevel(1)
-- experience.Rested = rested