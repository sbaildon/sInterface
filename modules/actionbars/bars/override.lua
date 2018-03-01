local _, ns = ...
local C = ns.C

if not C.actionbars.enabled then return end

local NUM_OVERRIDE_BUTTONS = NUM_OVERRIDE_BUTTONS
local BUTTON_SPACING = 6
local BUTTON_SIZE = ActionButton1:GetHeight()

local overridebar = ns.sInterfaceBars.overridebar

overridebar:SetSize((BUTTON_SIZE*NUM_OVERRIDE_BUTTONS) + (BUTTON_SPACING*(NUM_OVERRIDE_BUTTONS-1)), BUTTON_SIZE)
overridebar:SetPoint(unpack(C.actionbars.overridebar.position))

-- OverrideActionBar
OverrideActionBar:SetParent(overridebar)
OverrideActionBar:ClearAllPoints()
OverrideActionBar:SetAllPoints()
for i = 1, NUM_OVERRIDE_BUTTONS do
	local button = _G["OverrideActionBarButton"..i]
	if not button then break end
	button:SetSize(BUTTON_SIZE, BUTTON_SIZE)
	if i == 1 then
		button:SetPoint("TOPLEFT", overridebar, "TOPLEFT")
		button:SetPoint("BOTTOMLEFT", overridebar, "BOTTOMLEFT")
	else
		button:SetPoint("TOPLEFT", _G["OverrideActionBarButton"..i-1], "TOPRIGHT", 6, 0)
	end

end
RegisterStateDriver(overridebar, "visibility", C.actionbars.overridebar.visibility or "[overridebar][vehicleui][possessbar,@vehicle,exists] show; hide")
RegisterStateDriver(OverrideActionBar, "visibility", C.actionbars.overridebar.visibility or "[overridebar][vehicleui][possessbar,@vehicle,exists] show; hide")

OverrideActionBar.LeaveButton:ClearAllPoints()
OverrideActionBar.LeaveButton:SetSize(BUTTON_SIZE, BUTTON_SIZE)
OverrideActionBar.LeaveButton:SetPoint(unpack(C.actionbars.vehicleexit.position))
RegisterStateDriver(OverrideActionBar.LeaveButton, "visibility", C.actionbars.vehicleexit.visibility or "show")
