local _, ns = ...
local C = ns.C

if not C.objectivetracker.enabled then return end

local ObjectiveTrackerFrame = ObjectiveTrackerFrame

local gettingSet = false
local function AdjustSetPoint(self,...)
	if gettingSet then return end
	gettingSet = true
	self:SetPoint(unpack(C.objectivetracker.pos))
	gettingSet = false
end

hooksecurefunc(ObjectiveTrackerFrame, "SetPoint", AdjustSetPoint)