local addon, ns = ...
local globals = ns.globals

config = {
  tanking = true,
  tickRate = 0.1
}

stuff = {
  colours = {
    secure = { 0, 255, 0 },
    insecure = { 255, 124, 0 },
    na = { 255, 0, 0 }
  }
}

local sPlates, events = CreateFrame("FRAME"), {};


local function IsPlayerEffectivelyTank()
	local assignedRole = UnitGroupRolesAssigned("player");
	if ( assignedRole == "NONE" ) then
		local spec = GetSpecialization();
		return spec and GetSpecializationRole(spec) == "TANK";
	end

	return assignedRole == "TANK";
end

local function AggroColour()
  print("ticking")
    local plates = C_NamePlate.GetNamePlates()
    for _, plateFrame in ipairs (plates) do
      isTanking, status, threatpct, rawthreatpct, threatvalue = UnitDetailedThreatSituation("player", plateFrame.UnitFrame.displayedUnit)
      if (isTanking) then
        if status == 3 then
          r, g, b = unpack(stuff.colours.secure)
        elseif status == 2 then
          r, g, b = unpack(stuff.colours.insecure)
        else
          r, g, b = unpack(stuff.colours.na)
        end
        plateFrame.UnitFrame.healthBar.barTexture:SetVertexColor (r, g, b1)
      end

    end
end

function events:PLAYER_REGEN_ENABLED(...)
  inCombatTicker:Cancel()
end

function events:PLAYER_REGEN_DISABLED(...)
  if (config.tanking and IsPlayerEffectivelyTank()) then
    inCombatTicker = C_Timer.NewTicker(config.tickRate, AggroColour)
  end
end

function events:NAME_PLATE_UNIT_ADDED(unitBarId)
  namePlate = C_NamePlate.GetNamePlateForUnit(unitBarId)
  namePlate.UnitFrame.name:SetPoint("BOTTOM", namePlate.UnitFrame.healthBar, "TOP", 0, 0)
  namePlate.UnitFrame.healthBar.barTexture:SetTexture(globals.media.bar)
  namePlate.UnitFrame.healthBar.border:Hide();
end

function events:NAME_PLATE_UNIT_REMOVED(...)
end

sPlates:SetScript("OnEvent", function(self, event, ...)
  events[event](self, ...); -- call one of the functions above
end);
for k, v in pairs(events) do
 sPlates:RegisterEvent(k); -- Register all events for which handlers have been defined
end
-- --
-- local function eventHandler(self, event, unitBarId)
--   local plates = C_NamePlate.GetNamePlates()
--   if (event == "PLAYER_REGEN_ENABLED") then
--     r, g, b = 0, 255, 0
--   else
--     r, g, b = 0, 0, 255
--   end
--   for _, plateFrame in ipairs (plates) do
--     plateFrame.UnitFrame.healthBar.barTexture:SetVertexColor (r, g, b)
--     for key,value in pairs(plateFrame) do print(key,value) end
--   end
-- --   if (event == "NAME_PLATE_UNIT_ADDED") then
-- --     local namePlate = C_NamePlate.GetNamePlateForUnit(unitBarId);
-- --     print("/* BEGIN */")
-- --     for key,value in pairs(namePlate.UnitFrame) do print(key,value) end
-- --     print("/* END */")

-- --     return
-- --   end
-- end
--
