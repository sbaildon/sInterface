local _, ns = ...
local E, C = ns.E, ns.C

if not C.progressBars.enabled then return end;

local ProgressBars = ns.sInterfaceProgressBars
local barName = "reputation"

local PARAGON = PARAGON

local reactions = {}

for eclass, color in next, FACTION_BAR_COLORS do
	reactions[eclass] = {color.r, color.g, color.b}
end
-- Paragon
reactions[MAX_REPUTATION_REACTION + 1] = {0, 0.5, 0.9}

-- local function getReputationCurrent()
-- 	local _, _, _, _, cur = GetWatchedFactionInfo()

-- 	return cur
-- end

-- local function getReputationMax()
-- 	local _, _, _, max = GetWatchedFactionInfo()

-- 	return max
-- end

-- local function getReputationName()
-- 	local name = GetWatchedFactionInfo()
-- 	return name
-- end

local function GetReputation()
	local pendingReward
	local name, standingID, min, max, cur, factionID = GetWatchedFactionInfo()

	local friendID, _, _, _, _, _, standingText, _, nextThreshold = GetFriendshipReputation(factionID)
	if (friendID) then
		if (not nextThreshold) then
			min, max, cur = 0, 1, 1 -- force a full bar when maxed out
		end
		standingID = 5 -- force friends' color
	else
		local value, paragonNextThreshold, _, hasRewardPending = C_Reputation.GetFactionParagonInfo(factionID)
		if (value) then
			cur = value % paragonNextThreshold
			min = 0
			max = paragonNextThreshold
			pendingReward = hasRewardPending
			standingID = MAX_REPUTATION_REACTION + 1 -- force paragon's color
			standingText = PARAGON
		end
	end

	max = max - min
	cur = cur - min
	-- cur and max are both 0 for maxed out factions
	if(cur == max) then
		cur, max = 1, 1
	end
	standingText = standingText or GetText('FACTION_STANDING_LABEL' .. standingID, UnitSex('player'))

	return cur, max, name, factionID, standingID, standingText, pendingReward
end

local function Update(bar)
	local cur, max, name, _, standingID = GetReputation()
	if (name) then
		bar:SetAnimatedValues(cur, 0, max, standingID)
		local colors = reactions[standingID]
		bar:SetStatusBarColor(colors[1], colors[2], colors[3])
	end
end

local function Disable(bar)
	bar:UnregisterEvent("UPDATE_FACTION")
end

local function Enable(bar)
	bar:RegisterEvent("UPDATE_FACTION")
	Update(bar)
end

local function reputationVisibility(self, selectedFactionIndex)
	local shouldEnable
	if (selectedFactionIndex ~= nil) then
		if (selectedFactionIndex > 0) and (selectedFactionIndex <= GetNumFactions()) then
			shouldEnable = true
		end
	elseif (not not (GetWatchedFactionInfo())) then
		shouldEnable = true
	end

	if (shouldEnable) then
		Enable(self.Reputation)
		ProgressBars:EnableBar(barName)
	else
		Disable(self.Reputation)
		ProgressBars:DisableBar(barName)
	end
end

local reputationHolder = ProgressBars:CreateBar(barName)
reputationHolder:SetHeight(C.progressBars.reputation.height)
reputationHolder:SetScript("OnEvent", reputationVisibility)
hooksecurefunc('SetWatchedFactionIndex', function(selectedFactionIndex)
	reputationVisibility(reputationHolder, selectedFactionIndex or 0)
end)

local reputation = CreateFrame("StatusBar", "ProgressBar", reputationHolder, "AnimatedStatusBarTemplate")
reputation:SetMatchBarValueToAnimation(true)
reputation:SetAllPoints(reputationHolder)
reputation:SetStatusBarTexture(C.general.texture, "ARTWORK")
reputation:SetScript("OnEvent", Update)
reputationHolder.Reputation = reputation
C_Timer.After(1, function()
	reputationVisibility(reputationHolder, nil)
end)

local tooltip = GameTooltip
reputationHolder:SetScript("OnEnter", function(self)
	local cur, max, name, _, _, standingText = GetReputation()
	tooltip:SetOwner(self, "ANCHOR_CURSOR")
	tooltip:ClearLines()
	tooltip:AddLine(name)
	tooltip:AddDoubleLine("Standing", standingText, 1, 1, 1)
	tooltip:AddDoubleLine("Current", E:CommaValue(cur), 1, 1, 1)
	tooltip:AddDoubleLine("Required", E:CommaValue(max), 1, 1, 1)
	tooltip:AddDoubleLine("To level", E:CommaValue((max-cur)), 1, 1, 1)

	tooltip:Show()
end)
reputationHolder:SetScript("OnLeave", function(self)
	tooltip:Hide()
end)