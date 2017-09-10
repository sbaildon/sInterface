local _, ns = ...
local E, C = ns.E, ns.C

if not C.actionbars.enabled then return end

local ICON_WIDTH = 27
local ICON_HEIGHT = 33
local MICRO_BUTTONS = MICRO_BUTTONS

local micromenu = ns.sInterfaceBars.micromenu

micromenu:SetSize(ICON_WIDTH * #MICRO_BUTTONS, ICON_HEIGHT)

RegisterStateDriver(micromenu, "visibility", C.actionbars.micromenu.visibility or "show")

micromenu:SetPoint(unpack(C.actionbars.micromenu.position));
hooksecurefunc("UpdateMicroButtons", function()
	UpdateMicroButtonsParent(micromenu)
	_G[MICRO_BUTTONS[1]]:ClearAllPoints()
	_G[MICRO_BUTTONS[1]]:SetPoint("TOPLEFT", micromenu, "TOPLEFT", 0, 20)
	for i = 2, #MICRO_BUTTONS do
		_G[MICRO_BUTTONS[i]]:ClearAllPoints()
		_G[MICRO_BUTTONS[i]]:SetPoint("TOPLEFT", _G[MICRO_BUTTONS[i-1]], "TOPRIGHT", -1, 0)
	end
	if C.actionbars.micromenu.two_rows then
		local lastmicrobutton = math.floor((#MICRO_BUTTONS + 1 ) / 2)
		_G[MICRO_BUTTONS[lastmicrobutton+1]]:SetPoint("TOPLEFT", _G[MICRO_BUTTONS[1]], "BOTTOMLEFT", 0, 21)
		micromenu:SetSize(ICON_WIDTH * lastmicrobutton, 70)
	end
end)
