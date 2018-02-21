local _, ns = ...
local C = ns.C

if not C.actionbars.enabled then return end

local ICON_SIZE = MainMenuBarBackpackButton:GetHeight()

local bags = ns.sInterfaceBars.bags

bags:SetSize(ICON_SIZE*5, ICON_SIZE)
RegisterStateDriver(bags, "visibility", C.actionbars.bags.visibility or  "show")

bags:SetPoint(unpack(C.actionbars.bags.position));
hooksecurefunc("UpdateMicroButtons", function()
	for i = 0, 3 do
		local bag = _G["CharacterBag"..i.."Slot"]
		if not C.actionbars.bags.show_all then bag:Hide() end
		bag:SetParent(bags)
	end
	if not C.actionbars.bags.show_all then bags:SetWidth(ICON_SIZE) end
	MainMenuBarBackpackButton:SetParent(bags)
	MainMenuBarBackpackButton:ClearAllPoints()
	MainMenuBarBackpackButton:SetPoint("BOTTOMRIGHT", bags, "BOTTOMRIGHT", 0, 0)
end)
