-- Not sure if overwriting blizzard variables is a good idea?
BUFF_HORIZ_SPACING = -8

local cfg = {
	durationHeight = 12,
	auraSize = 26
}

local function style(buff)
	if not buff or (buff and buff.styled) then return end

	local name = buff:GetName()
	local icon = _G[name.."Icon"]
	icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	buff:SetSize(cfg.auraSize, cfg.auraSize)

	local font, _ = buff.duration:GetFont()
	buff.duration:SetParent(buff)
	buff.duration:SetPoint("TOP", buff, "BOTTOM", 0, 5)
	buff.duration:SetJustifyH("CENTER")
	buff.duration:SetFont(font, cfg.durationHeight, "OUTLINE")

	local shadow = CreateFrame("Frame", nil, buff)
	shadow:SetFrameLevel(1)
	shadow:SetFrameStrata(buff:GetFrameStrata())
	shadow:SetPoint("TOPLEFT", buff, "TOPLEFT", -3, 3)
	shadow:SetPoint("BOTTOMRIGHT", buff, "BOTTOMRIGHT", 3, -3)
	shadow:SetBackdrop({
		edgeFile = "Interface\\AddOns\\sInterface\\media\\shadow_border",
		edgeSize = 5,
		insets = { left = 0, right = 0, top = 0, bottom = 0 }
	})
	shadow:SetBackdropColor(0, 0, 0, 0)
	shadow:SetBackdropBorderColor(0, 0, 0, 0.7)
	

	buff:SetBackdrop({
		edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 1,
		insets = { left = 0, right = 0, top = 0, bottom = 0 }
	})
	buff:SetBackdropBorderColor(0, 0, 0, 1)	

	buff.styled = true
end

local function updateAnchors()
	if BUFF_ACTUAL_DISPLAY == 0 then return end

	local buff = _G["BuffButton1"]
	if (Minimap:IsShown()) then
		buff:SetPoint("TOPRIGHT", Minimap, "TOPLEFT", BUFF_HORIZ_SPACING, 0);
	else
		buff:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", BUFF_HORIZ_SPACING, BUFF_HORIZ_SPACING);
	end
	

	for i = 1, BUFF_ACTUAL_DISPLAY do
		local buff = _G["BuffButton"..i]
		style(buff)
	end
end

hooksecurefunc("BuffFrame_UpdateAllBuffAnchors", updateAnchors)
Minimap:HookScript("OnHide", updateAnchors)
Minimap:HookScript("OnShow", updateAnchors)
