local addon, ns = ...
local C = ns.C

local colours = {
	secure = { 0, 255, 0 },
	insecure = { 255, 124, 0 },
	na = { 255, 0, 0 }
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
	if not (C.np.tankMode and IsPlayerEffectivelyTank())  then return end

	local status = UnitThreatSituation("player", frame.unit)
	if status == nil then return end
	if status == 3 then
		r, g, b = unpack(colours.secure)
	elseif status == 2 then
		r, g, b = unpack(colours.insecure)
	else
		r, g, b = unpack(colours.na)
	end
	frame.healthBar.barTexture:SetVertexColor (r, g, b)
end)

hooksecurefunc("CompactUnitFrame_UpdateName", function(frame)
	if UnitIsPlayer(frame.unit) then
		frame.name:SetText(UnitName(frame.unit))
	end
	frame.name:SetTextColor(1, 1, 1, 1)
	local font, _ = frame.name:GetFont()
	frame.name:SetFont(font, 10, "OUTLINE")
end)

hooksecurefunc("DefaultCompactNamePlateFrameSetupInternal", function(namePlate)
	namePlate.healthBar:SetStatusBarTexture("Interface\\AddOns\\sInterface\\media\\bar")
	namePlate.healthBar.border:Hide()

	namePlate.castBar:SetStatusBarTexture("Interface\\AddOns\\sInterface\\media\\bar")
	namePlate.castBar:SetHeight(4)

	namePlate.castBar.Icon:ClearAllPoints()
	namePlate.castBar.Icon:SetHeight(namePlate.castBar:GetHeight() + namePlate.healthBar:GetHeight())
	namePlate.castBar.Icon:SetWidth(namePlate.castBar:GetHeight() + namePlate.healthBar:GetHeight())
	namePlate.castBar.Icon:SetPoint("BOTTOMRIGHT", namePlate.castBar, "BOTTOMLEFT", 0, 0)

	namePlate.name:SetParent(namePlate.healthBar)
	namePlate.name:SetPoint("BOTTOM", namePlate.healthBar, "TOP", 0, -2)
	namePlate.name:SetTextColor(1,1,1,1)

	if not (namePlate.healthBar.shadowFrame) then
		local shadowFrame = CreateFrame("Frame", nil, namePlate.healthBar)
		shadowFrame:SetFrameStrata("BACKGROUND")
		shadowFrame:SetPoint("TOPLEFT", namePlate.healthBar, "TOPLEFT", -3, 3)
		shadowFrame:SetPoint("BOTTOMRIGHT", namePlate.healthBar, "BOTTOMRIGHT", 3, -3)
		shadowFrame:SetBackdrop({
			edgeFile = "Interface\\AddOns\\sInterface\\media\\shadow_border",
			edgeSize = 5,
		})
		shadowFrame:SetBackdropBorderColor(0, 0, 0, 0.7)
		namePlate.healthBar.shadowFrame = shadowFrame
	end
end)
--end

sPlates:SetScript("OnEvent", function(self, event, ...)
  events[event](self, ...); -- call one of the functions above
end);
for k, v in pairs(events) do
 sPlates:RegisterEvent(k); -- Register all events for which handlers have been defined
end
