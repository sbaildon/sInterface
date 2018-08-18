local _, ns = ...
local E, C = ns.E, ns.C

if not C.progressBars.enabled then return end;

local ProgressBars = ns.sInterfaceProgressBars
local barName = "azerite"

local function GetAzerite()
	local azeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem();

	if (not azeriteItemLocation) then
		return;
	end

	local xp, totalLevelXP = C_AzeriteItem.GetAzeriteItemXPInfo(azeriteItemLocation);
	local currentLevel = C_AzeriteItem.GetPowerLevel(azeriteItemLocation);
	local xpToNextLevel = totalLevelXP - xp;

	return currentLevel, xp, totalLevelXP, xpToNextLevel
end

local function Update(bar)
	local level, cur, max = GetAzerite();
	bar:SetAnimatedValues(cur, 0, max, level)
end

local function Disable(bar)
	bar:UnregisterEvent("AZERITE_ITEM_EXPERIENCE_CHANGED")
end

local function Enable(bar)
	bar:RegisterEvent("AZERITE_ITEM_EXPERIENCE_CHANGED")
	Update(bar)
end

local function Visibility(self)
	if C_AzeriteItem.HasActiveAzeriteItem() then
		Enable(self.Azerite)
		ProgressBars:EnableBar(barName)
	else
		Disable(self.Azerite)
		ProgressBars:DisableBar(barName)
	end
end

local azeriteHolder = ProgressBars:CreateBar(barName)
azeriteHolder:SetHeight(C.progressBars.azerite.height)
azeriteHolder:RegisterEvent("UNIT_INVENTORY_CHANGED")
azeriteHolder:RegisterEvent("PLAYER_ENTERING_WORLD")
azeriteHolder:SetScript("OnEvent", Visibility)

local azerite = CreateFrame("StatusBar", "ProgressBar", azeriteHolder, "AnimatedStatusBarTemplate")
azerite:SetMatchBarValueToAnimation(true)
azerite:SetAllPoints(azeriteHolder)
azerite:SetStatusBarTexture(C.general.texture, "ARTWORK")
azerite:SetScript("OnEvent", Update)
azerite:SetStatusBarColor(ARTIFACT_BAR_COLOR:GetRGB())
azeriteHolder.Azerite = azerite

local tooltip = GameTooltip
azeriteHolder:SetScript("OnEnter", function(self)
	local currentLevel, xp, totalLevelXP, xpToNextLevel = GetAzerite();
	tooltip:SetOwner(self, "ANCHOR_CURSOR")
	tooltip:ClearLines()
	tooltip:AddLine("Azerite")
	tooltip:AddDoubleLine("Level", currentLevel, 1, 1, 1)
	tooltip:AddDoubleLine("Current", E:CommaValue(xp), 1, 1, 1)
	tooltip:AddDoubleLine("Required", E:CommaValue(totalLevelXP), 1, 1, 1)
	tooltip:AddDoubleLine("To level", E:CommaValue(xpToNextLevel), 1, 1, 1)

	tooltip:Show()
end)
azeriteHolder:SetScript("OnLeave", function(self)
	tooltip:Hide()
end)