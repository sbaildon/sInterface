local _, ns = ...
local E, C = ns.E, ns.C

if not C.mirrortimer.enabled then return end;

for i = 1, 3 do
	local mir = _G["MirrorTimer"..i]

	local mirBorder = _G["MirrorTimer"..i.."Border"]
	mirBorder:Hide()

	local region = ({mir:GetRegions()})
		region[3]:SetAlpha(0)
		region[1]:SetAlpha(0)

	local mirSB = _G["MirrorTimer"..i.."StatusBar"]
		E:ShadowedBorder(mirSB)
		mirSB:SetStatusBarTexture(C.general.texture)
		mirSB:SetBackdropColor(0, 0, 0, 0)
		mirSB:SetSize(mir:GetWidth(), mir:GetHeight()/3)

	local mirT = _G["MirrorTimer"..i.."Text"]
		mirT:ClearAllPoints()
		mirT:SetPoint("CENTER", mir, "TOP", 0, 0)
		mirT:SetFontObject("GameFontHighlightOutline")
end
