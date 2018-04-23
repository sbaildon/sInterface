local _, ns = ...
local E, C = ns.E, ns.C

if not C.progressBars.enabled then return end;

local reactions = {}

for eclass, color in next, FACTION_BAR_COLORS do
	reactions[eclass] = {color.r, color.g, color.b}
end
-- Paragon
reactions[MAX_REPUTATION_REACTION + 1] = {0, 0.5, 0.9}

local function getReputationCurrent()
	local _, _, _, _, cur = GetWatchedFactionInfo()

	return cur
end

local function getReputationMax()
	local _, _, _, max = GetWatchedFactionInfo()

	return max
end

local function getReputationFaction()
	local _, _, _, _, _, factionID = GetWatchedFactionInfo()

	return factionID
end

local function GetReputation()
	local pendingReward
	local name, standingID, min, max, cur, factionID = GetWatchedFactionInfo()

	local friendID, _, _, _, _, _, standingText, _, nextThreshold = GetFriendshipReputation(factionID)
	if(friendID) then
		if(not nextThreshold) then
			min, max, cur = 0, 1, 1 -- force a full bar when maxed out
		end
		standingID = 5 -- force friends' color
	else
		local value, nextThreshold, _, hasRewardPending = C_Reputation.GetFactionParagonInfo(factionID)
		if(value) then
			cur = value % nextThreshold
			min = 0
			max = nextThreshold
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

local function reputationUpdate(self)
	local cur, max, name, factionID, standingID, standingText, pendingReward = GetReputation()
	if(name) then
		self:SetMinMaxValues(0, max)
		self:SetValue(cur)
		local colors = reactions[standingID]
		self:SetStatusBarColor(colors[1], colors[2], colors[3])
	end
end

local function reputationDisable(self)
	self:UnregisterEvent("UPDATE_FACTION")
end

local function reputationEnable(self)
	self:RegisterEvent("UPDATE_FACTION")
	reputationUpdate(self)
end

local function reputationVisibility(self, selectedFactionIndex)
	local shouldEnable
	if (selectedFactionIndex ~= nil) then
		if (selectedFactionIndex > 0) and (selectedFactionIndex < GetNumFactions()) then
			shouldEnable = true
		end
	elseif (not not (GetWatchedFactionInfo())) then
		shouldEnable = true
	end

	if (shouldEnable) then
		reputationEnable(self.Reputation)
		ns.ProgressBars.Insert(self)
		self:Show()
	else
		reputationDisable(self.Reputation)
		ns.ProgressBars.Remove(self)
		self:Hide()
	end
end

local reputationHolder = CreateFrame("Frame", "reputationHolder", UIParent)
reputationHolder:SetHeight(C.progressBars.reputation.height)
reputationHolder:SetPoint("LEFT", ns.ProgressBars, "LEFT")
reputationHolder:SetPoint("RIGHT", ns.ProgressBars, "RIGHT")
reputationHolder:SetScript("OnEvent", reputationVisibility)
hooksecurefunc('SetWatchedFactionIndex', function(selectedFactionIndex)
	reputationVisibility(reputationHolder, selectedFactionIndex or 0)
end)
E:ShadowedBorder(reputationHolder)

local reputation = CreateFrame("StatusBar", "ProgressBar", reputationHolder)
reputation:SetAllPoints(reputationHolder)
reputation:SetStatusBarTexture(C.general.texture, "ARTWORK")
reputation:SetScript("OnEvent", reputationUpdate)
reputationHolder.Reputation = reputation
reputationVisibility(reputationHolder, nil)