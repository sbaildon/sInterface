local otf = ObjectiveTrackerFrame
otf:SetMovable(true)
otf:SetUserPlaced(true)
otf:ClearAllPoints()
otf:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 40, -25)
otf:SetMovable(false)
otf:RegisterEvent("GROUP_ROSTER_UPDATE");

local function objective_mover(self, event, ...)
	local raidindex = UnitInRaid("player")
	if (raidindex == nil) then
		self:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 40, -25)
	else
		self:SetPoint("TOPLEFT", oUF_SkaarjRaid, "BOTTOMLEFT", 30, -25)
	end
end
otf:HookScript("OnEvent", objective_mover);
