local _, ns = ...
local E, C = ns.E, ns.C

if not C.progressBars.enabled then return end;

local PARAGON = PARAGON

local barName = "reputation"
local ProgressBars = ns.sInterfaceProgressBars

ProgressBars:RegisterBar(barName)

local reactions = {}
for eclass, color in next, FACTION_BAR_COLORS do
	reactions[eclass] = {color.r, color.g, color.b}
end
reactions[MAX_REPUTATION_REACTION + 1] = {0, 0.5, 0.9} -- Paragon

-- local function getReputationCurrent()
-- 	local _, _, _, _, cur = GetWatchedFactionInfo()

-- 	return cur
-- end

-- local function getReputationMax()
-- 	local _, _, _, max = GetWatchedFactionInfo()

-- 	return max
-- end

-- local function getReputationFaction()
-- 	local _, _, _, _, _, factionID = GetWatchedFactionInfo()

-- 	return factionID
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

local function reputationUpdate()
	local cur, max, name, _, standingID = GetReputation()
	if (name) then
		ProgressBars:SetBarValues(barName, 0, max, cur)

		local colors = reactions[standingID]
		ProgressBars:SetBarColor(barName, colors[1], colors[2], colors[3])
	end
end

local function reputationVisibility(self, selectedFactionIndex)
	local shouldEnable = false
	if (selectedFactionIndex ~= nil) then
		if (selectedFactionIndex > 0) and (selectedFactionIndex <= GetNumFactions()) then
			shouldEnable = true
		end
	elseif (not not (GetWatchedFactionInfo())) then
		shouldEnable = true
	end

	if (shouldEnable) then
		ProgressBars:EnableBar(barName)
		reputationUpdate()
		self:RegisterEvent("UPDATE_FACTION")
	else
		ProgressBars:DisableBar(barName)
		self:UnregisterEvent("UPDATE_FACTION")
	end
end

local eventFrame = CreateFrame("Frame", "eventHolder", UIParent)
hooksecurefunc('SetWatchedFactionIndex', function(selectedFactionIndex)
	reputationVisibility(eventFrame, selectedFactionIndex or 0)
end)
eventFrame:SetScript("OnEvent", reputationUpdate)
reputationVisibility(eventFrame, nil)