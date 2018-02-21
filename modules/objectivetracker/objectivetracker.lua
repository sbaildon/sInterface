local _, ns = ...
local C = ns.C

if not C.objectivetracker.enabled then return end

local ObjectiveTrackerFrame = ObjectiveTrackerFrame

local frame = CreateFrame("Frame")

local gettingSet
local function AdjustSetPoint(self,...)
  if gettingSet then return end
  gettingSet = true
  local raidindex = UnitInRaid("player")
  local pos = (raidindex == nil) and C.objectivetracker.pos or C.objectivetracker.pos_raid

	self:SetPoint(unpack(pos))
	gettingSet = false
end

frame:SetScript("OnEvent", function(self,event)
  if not event == "GROUP_ROSTER_UPDATE" then
    self:UnregisterEvent(event)
  end
  if event == "PLAYER_LOGIN" then
    self.point = {ObjectiveTrackerFrame:GetPoint()}
    hooksecurefunc(ObjectiveTrackerFrame, "SetPoint", AdjustSetPoint)
  end
  if not InCombatLockdown() then
    ObjectiveTrackerFrame:SetPoint(unpack(self.point))
  end
end)

frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("GROUP_ROSTER_UPDATE")
