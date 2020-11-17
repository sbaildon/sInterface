local _, ns = ...
local E = ns.E

if not E:C('objectivetracker', 'enabled') then return end

local ObjectiveTrackerFrame = ObjectiveTrackerFrame

local gettingSet = false
local function AdjustSetPoint(self,...)
	if gettingSet then return end
	gettingSet = true
	self:SetPoint(unpack(E:C('objectivetracker', 'pos')))
	gettingSet = false
end

hooksecurefunc(ObjectiveTrackerFrame, "SetPoint", AdjustSetPoint)
