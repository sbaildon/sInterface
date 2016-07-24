local addon, ns = ...
local globals = ns.globals

config = {
	tanking = true,
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

hooksecurefunc("CompactUnitFrame_UpdateHealthColor", function(frame)
	if UnitIsPlayer(frame.unit) or not UnitAffectingCombat("player") then return end
	if not (config.tanking and IsPlayerEffectivelyTank())  then return end

	status = UnitThreatSituation("player", frame.unit)
	if status == nil then return end
	if status == 3 then
		r, g, b = unpack(stuff.colours.secure)
	elseif status == 2 then
		r, g, b = unpack(stuff.colours.insecure)
	else
		r, g, b = unpack(stuff.colours.na)
	end
	frame.healthBar.barTexture:SetVertexColor (r, g, b)
end)

hooksecurefunc("CompactUnitFrame_UpdateName", function(frame)
	frame.name:SetTextColor(1, 1, 1, 1)
	local font, _ = frame.name:GetFont()
	frame.name:SetFont(font, 10, "OUTLINE")
end)

function events:NAME_PLATE_CREATED(unitBarId)
	namePlate = unitBarId
	namePlate.UnitFrame.healthBar.barTexture:SetTexture(globals.media.bar)
	namePlate.UnitFrame.healthBar.border:Hide();

	namePlate.UnitFrame.name:ClearAllPoints()
	namePlate.UnitFrame.name:SetPoint("BOTTOM", namePlate.UnitFrame.healthBar, "TOP")
	namePlate.UnitFrame.name:SetTextColor(1,1,1,1)
	namePlate.UnitFrame.name:Hide()
end

sPlates:SetScript("OnEvent", function(self, event, ...)
  events[event](self, ...); -- call one of the functions above
end);
for k, v in pairs(events) do
 sPlates:RegisterEvent(k); -- Register all events for which handlers have been defined
end
