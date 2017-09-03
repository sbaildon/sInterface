local _, ns = ...
local E, C = ns.E, ns.C

if not C.actionbars.enabled then return end

local ICON_WIDTH = CharacterMicroButton:GetWidth()
local ICON_HEIGHT = CharacterMicroButton:GetHeight()

local micromenu = CreateFrame("Frame", "sInterfaceMicromenu", UIParent)
micromenu:SetSize(ICON_WIDTH*11, ICON_HEIGHT)
RegisterStateDriver(micromenu, "visibility", C.actionbars.micromenu.visibility or "show")

micromenu:SetPoint(unpack(C.actionbars.micromenu.position));
hooksecurefunc("UpdateMicroButtons", function()
	UpdateMicroButtonsParent(micromenu)
	_G[MICRO_BUTTONS[1]]:ClearAllPoints()
	_G[MICRO_BUTTONS[1]]:SetPoint("TOPLEFT", micromenu, "TOPLEFT", 0, 0)
end)
