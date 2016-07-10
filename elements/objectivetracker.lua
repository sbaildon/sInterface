local unpack = unpack
local ObjectiveTrackerFrame = ObjectiveTrackerFrame

local frame = CreateFrame("Frame")

local cfg = {}
cfg.pos = {"TOPRIGHT", UIParent, "TOPLEFT", 280, -20}
cfg.pos_raid = {"TOPRIGHT", "oUF_SkaarjRaid", "BOTTOMLEFT", 260, -20}

local gettingSet
local function AdjustSetPoint(self,...)
	if gettingSet then return end
 	gettingSet = true
 	local raidindex = UnitInRaid("player")
 	local pos = (raidindex == nil) and cfg.pos or cfg.pos_raid

	self:SetPoint(unpack(pos))

    -- if InCombatLockdown() then
    --   frame:RegisterEvent("PLAYER_REGEN_ENABLED")
    -- end
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