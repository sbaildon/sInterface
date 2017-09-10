local _, ns = ...
local E, C = ns.E, ns.C

if not C.actionbars.enabled then return end

local BUTTON_SIZE = ActionButton1:GetHeight()

local extrabar = CreateFrame("Frame", "sInterfaceExtraBar", UIParent, "SecureHandlerStateTemplate")
extrabar:SetSize(BUTTON_SIZE, BUTTON_SIZE)
extrabar:SetPoint(unpack(C.actionbars.extrabar.position))

ExtraActionBarFrame:SetParent(extrabar)
ExtraActionBarFrame:SetAllPoints()
ExtraActionBarFrame.ignoreFramePositionManager = true
RegisterStateDriver(extrabar, "Visibility", C.actionbars.extrabar.visibility or "[petbattle][overridebar][vehicleui] hide; show")
