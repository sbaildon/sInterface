local _, ns = ...
local E, C = ns.E, ns.C

if not C.progressBars.enabled then return end;

if (not HasArtifactEquipped()) then return end
if (HasArtifactEquipped() and C_ArtifactUI.IsEquippedArtifactDisabled()) then return end

-- Here be dragons
-- This code does not work anymore, and artifacts are disabled in 8.0.1

local ProgressBars = ns.sInterfaceProgressBars
local barName = "artifactPower"

local function getArtifactName()
	local _, _, name = C_ArtifactUI.GetEquippedArtifactInfo()
	return name
end

local function GetNumTraitsLearnable(numTraitsLearned, power, tier)
	local numPoints = 0;
	local powerForNextTrait = C_ArtifactUI.GetCostForPointAtRank(numTraitsLearned, tier)
	while power >= powerForNextTrait and powerForNextTrait > 0 do
		power = power - powerForNextTrait

		numTraitsLearned = numTraitsLearned + 1
		numPoints = numPoints + 1

		powerForNextTrait = C_ArtifactUI.GetCostForPointAtRank(numTraitsLearned, tier)
	end
	return numPoints, power, powerForNextTrait
end

local itemID, altItemID, name, icon, artifactTotalXP, pointsSpent, quality, artifactAppearanceID, appearanceModID, itemAppearanceID, altItemAppearanceID, altOnTop, artifactTier = C_ArtifactUI.GetEquippedArtifactInfo();
print("itemID", itemID)
print("altItemID", altItemID)
print("name", name)
print("icon", icon)
print("artifactTotalXP", artifactTotalXP)
print("pointsSpent", pointsSpent)
print("quality", quality)
print("artifactAppearanceID", artifactAppearanceID)
print("appearanceModID", appearanceModID)
print("itemAppearanceID", itemAppearanceID)
print("altItemAppearanceID", altItemAppearanceID)
print("altOnTop", altOnTop)
print("artifactTier", artifactTier)

function ArtifactBarGetNumArtifactTraitsPurchasableFromXP(pointsSpent, artifactXP, artifactTier)
	local numPoints = 0;
	local xpForNextPoint = C_ArtifactUI.GetCostForPointAtRank(pointsSpent, artifactTier);
	while artifactXP >= xpForNextPoint and xpForNextPoint > 0 do
		artifactXP = artifactXP - xpForNextPoint;

		pointsSpent = pointsSpent + 1;
		numPoints = numPoints + 1;

		xpForNextPoint = C_ArtifactUI.GetCostForPointAtRank(pointsSpent, artifactTier);
	end
	return numPoints, artifactXP, xpForNextPoint;
end

local numPointsAvailableToSpend, xp, xpForNextPoint = ArtifactBarGetNumArtifactTraitsPurchasableFromXP(artifactPointsSpent, artifactTotalXP, artifactTier);

local function getArtifactCurrent()
	if (not UnitHasVehicleUI('player')) then
		local azeriteItemLocation = C_AzeriteItem and C_AzeriteItem.FindActiveAzeriteItem()
		if (azeriteItemLocation) then
			local power = C_AzeriteItem.GetAzeriteItemXPInfo(azeriteItemLocation)
			return power
		elseif (HasArtifactEquipped()) then
			local _, _, _, _, unspentPower, numTraitsLearned, _, _, _, _, _, _, tier = C_ArtifactUI.GetEquippedArtifactInfo()
			local _, power = GetNumTraitsLearnable(numTraitsLearned, unspentPower, tier)
			return power
		end
	end
end

local function getArtifactMax()
	if (not HasArtifactEquipped() or UnitHasVehicleUI('player')) then return 0 end
	local _, _, _, _, totalPower = C_ArtifactUI.GetEquippedArtifactInfo()
	return totalPower
end

local function getArtifactUntilNext()
	if (not HasArtifactEquipped() or UnitHasVehicleUI('player')) then return 0 end
	local _, _, _, _, totalPower, traitsLearned, _, _, _, _, _, _, tier = C_ArtifactUI.GetEquippedArtifactInfo()
	local _, power, powerForNextTrait = MainMenuBar_GetNumArtifactTraitsPurchasableFromXP(traitsLearned, totalPower, tier)
	return powerForNextTrait - power
end

-- local function getArtifactUntilNextPercent()
-- 	if (not HasArtifactEquipped() or UnitHasVehicleUI('player')) then return end
-- 	local _, _, _, _, totalPower, traitsLearned, _, _, _, _, _, _, tier = C_ArtifactUI.GetEquippedArtifactInfo()
-- 	local _, power, powerForNextTrait = MainMenuBar_GetNumArtifactTraitsPurchasableFromXP(traitsLearned, totalPower, tier)
-- 	return math.floor(((power / powerForNextTrait) * 100) + 0.5)
-- end

local function getArtifactNextTraitCost()
	if (not HasArtifactEquipped() or UnitHasVehicleUI('player')) then return 0 end
	local _, _, _, _, totalPower, traitsLearned, _, _, _, _, _, _, tier = C_ArtifactUI.GetEquippedArtifactInfo()
	local _, _, powerForNextTrait = MainMenuBar_GetNumArtifactTraitsPurchasableFromXP(traitsLearned, totalPower, tier)
	return powerForNextTrait
end

local function getArtifactLearnableTraits()
	if (not HasArtifactEquipped() or UnitHasVehicleUI('player')) then return end
	local _, _, _, _, totalPower, traitsLearned, _, _, _, _, _, _, tier = C_ArtifactUI.GetEquippedArtifactInfo()
	local numTraitsLearnable = MainMenuBar_GetNumArtifactTraitsPurchasableFromXP(traitsLearned, totalPower, tier)
	return numTraitsLearnable
end

-- local function getArtifactTraitsLearned()
-- 	if (not HasArtifactEquipped() or UnitHasVehicleUI('player')) then return end
-- 	local _, _, _, _, _, traitsLearned = C_ArtifactUI.GetEquippedArtifactInfo()
-- 	return traitsLearned
-- end

-- local function getArtifactTier()
-- 	if (not HasArtifactEquipped() or UnitHasVehicleUI('player')) then return end
-- 	local _, _, _, _, _, _, _, _, _, _, _, _, tier = C_ArtifactUI.GetEquippedArtifactInfo()
-- 	return tier
-- end

local function artifactXpUpdate(self)
	-- local max = getArtifactNextTraitCost()
	local cur = getArtifactCurrent()

	self:SetMinMaxValues(0, 1)
	self:SetValue(cur)
end

local function artifactXpDisable(self)
	self:UnregisterEvent("ARTIFACT_XP_UPDATE")
	self:UnregisterEvent("UNIT_INVENTORY_CHANGED")
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end

local function artifactXpEnable(self)
	self:RegisterEvent("ARTIFACT_XP_UPDATE")
	self:RegisterEvent("UNIT_INVENTORY_CHANGED")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	artifactXpUpdate(self)
end

local function artifactVisibility(self)
	if (not HasArtifactEquipped()) then
		artifactXpDisable(self.ArtifactPower)
		ProgressBars:DisableBar(barName)
		return
	end

	artifactXpEnable(self.ArtifactPower)
	ProgressBars:EnableBar(barName)
end

local artifactHolder = ProgressBars:CreateBar(barName)
artifactHolder:SetHeight(C.progressBars.artifactPower.height)
artifactHolder:RegisterEvent("UNIT_INVENTORY_CHANGED")
artifactHolder:RegisterEvent("ARTIFACT_XP_UPDATE")
artifactHolder:RegisterEvent("PLAYER_ENTERING_WORLD")
artifactHolder:SetScript("OnEvent", artifactVisibility)

local artifact = CreateFrame("StatusBar", "ProgressBar", artifactHolder)
artifact:SetAllPoints(artifactHolder)
artifact:SetStatusBarTexture(C.general.texture, "ARTWORK")
artifact:SetStatusBarColor(GetItemQualityColor(6))
artifact:SetScript("OnEvent", artifactXpUpdate)
artifactHolder.ArtifactPower = artifact

local tooltip = GameTooltip
artifactHolder:SetScript("OnEnter", function(self)
	tooltip:SetOwner(self, "ANCHOR_CURSOR")
	tooltip:ClearLines()
	tooltip:AddLine(getArtifactName())
	tooltip:AddDoubleLine("Current", E:CommaValue(getArtifactCurrent()), 1, 1, 1)
	tooltip:AddDoubleLine("Required", E:CommaValue(getArtifactNextTraitCost()), 1, 1, 1)
	tooltip:AddDoubleLine("To next trait", E:CommaValue(getArtifactUntilNext()), 1, 1, 1)

	local learnableTraits = getArtifactLearnableTraits()
	if learnableTraits > 0 then
		tooltip:AddDoubleLine("Learnable traits", E:CommaValue(learnableTraits), 1, 1, 1)
	end

	tooltip:Show()
end)
artifactHolder:SetScript("OnLeave", function(self)
	tooltip:Hide()
end)