local _, ns = ...
local E, C = ns.E, ns.C

if not C.progressBars.enabled then return end;

local ProgressBars = ns.sInterfaceProgressBars
local barName = "artifactPower"

local function getArtifactName()
	local _, _, name = C_ArtifactUI.GetEquippedArtifactInfo()
	return name
end

local function getArtifactCurrent()
	if (not HasArtifactEquipped() or UnitHasVehicleUI('player')) then return 0 end
	local _, _, _, _, totalPower, traitsLearned, _, _, _, _, _, _, tier = C_ArtifactUI.GetEquippedArtifactInfo()
	local _, power = MainMenuBar_GetNumArtifactTraitsPurchasableFromXP(traitsLearned, totalPower, tier)
	return power
end

-- local function getArtifactMax()
-- 	if (not HasArtifactEquipped() or UnitHasVehicleUI('player')) then return 0 end
-- 	local _, _, _, _, totalPower = C_ArtifactUI.GetEquippedArtifactInfo()
-- 	return totalPower
-- end

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
	local max = getArtifactNextTraitCost()
	local cur = getArtifactCurrent()

	self:SetMinMaxValues(0, max)
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