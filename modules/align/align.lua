SLASH_ALIGN1 = "/align"

local vertical_rules = 128
local horizontal_rules = 72

local align = CreateFrame("Frame", "sInterfaceAlignFrame", UIParent)
align:SetAllPoints(UIParent)
align:Hide()

local verticalRuleSpacing = GetScreenWidth() / vertical_rules
local horizonalRuleSpacing = GetScreenHeight() / horizontal_rules
for i = 0, vertical_rules do
	local rule = align:CreateTexture(nil, "BACKGROUND")
	if i == (vertical_rules / 2) then
		rule:SetColorTexture(0.6, 0.8, 0.95, 0.5)
	elseif (i % 2) == 0 then
		rule:SetColorTexture(1, 1, 1, 0.2)
else
		rule:SetColorTexture(1, 1, 1, 0.075)
	end
	rule:SetPoint("TOPLEFT", align, "TOPLEFT", i * verticalRuleSpacing - 1, 0)
	rule:SetPoint("BOTTOMRIGHT", align, "BOTTOMLEFT", i * verticalRuleSpacing + 1, 0)
end
for i = 0, horizontal_rules do
	local rule = align:CreateTexture(nil, "BACKGROUND")
	if i == (horizontal_rules / 2) then
		rule:SetColorTexture(0.6, 0.8, 0.95, 0.5)
	elseif (i % 2) == 0 then
		rule:SetColorTexture(1, 1, 1, 0.2)
	else
		rule:SetColorTexture(1, 1, 1, 0.075)
	end
	rule:SetPoint("TOPLEFT", align, "TOPLEFT", 0, -i * horizonalRuleSpacing + 1)
	rule:SetPoint("BOTTOMRIGHT", align, "TOPRIGHT", 0, -i * horizonalRuleSpacing - 1)
end

SlashCmdList["ALIGN"] = function()
	if align:IsShown() then
		align:Hide()
	else
		align:Show()
	end
end