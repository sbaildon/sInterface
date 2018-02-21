local _, ns = ...
local E = ns.E

local function StyleActionButton(button)
	if not button or button.__styled then return end
    
	local buttonName = button:GetName()

	local icon = _G[buttonName.."Icon"]
	icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	-- Border around button
	local normalTexture = button:GetNormalTexture()
	normalTexture:SetTexture(nil)
	normalTexture.SetTexture = function() end

	-- Used when the button is empty
	local floatingBG = _G[buttonName.."FloatingBG"]
	if floatingBG then floatingBG:Hide() end

	local shadowFrame = CreateFrame("Frame", buttonName.."sInterfaceSkin", button)
	shadowFrame:SetAllPoints(button)
	E:ShadowedBorder(shadowFrame)

	button.__styled = true
end

local function StyleAllActionButtons()
	for i = 1, NUM_ACTIONBAR_BUTTONS do
		StyleActionButton(_G["ActionButton"..i])
		StyleActionButton(_G["MultiBarBottomLeftButton"..i])
		StyleActionButton(_G["MultiBarBottomRightButton"..i])
		StyleActionButton(_G["MultiBarRightButton"..i])
		StyleActionButton(_G["MultiBarLeftButton"..i])
	end
	for i = 1, 6 do
		StyleActionButton(_G["OverrideActionBarButton"..i])
	end

	for i=1, NUM_PET_ACTION_SLOTS do
		StyleActionButton(_G["PetActionButton"..i])
	end

	for i=1, NUM_STANCE_SLOTS do
		StyleActionButton(_G["StanceButton"..i])
	end

	for i=1, NUM_POSSESS_SLOTS do
		StyleActionButton(_G["PossessButton"..i])
	end
end

StyleAllActionButtons()