local AddOn, ns = ...
local E, C = CreateFrame('Frame', 'sEngine'), {}
ns.E, ns.C = E, C

local shadowTex = "Interface\\AddOns\\sInterface\\media\\shadow_border"

function E:ShadowedBorder(anchor)
	local frame = anchor.GetTexture and anchor:GetParent() or anchor

	BACKDROP_OFFSET = 3
	BACKDROP_INSET  = 2

	local backdrop = CreateFrame('Frame', nil, frame)
	backdrop:SetFrameStrata('BACKGROUND')
	backdrop:SetFrameLevel(0)
	backdrop:SetPoint('TOPLEFT', anchor, 'TOPLEFT', -BACKDROP_OFFSET, BACKDROP_OFFSET)
	backdrop:SetPoint('BOTTOMRIGHT', anchor, 'BOTTOMRIGHT', BACKDROP_OFFSET, -BACKDROP_OFFSET)
	backdrop:SetBackdrop({
		bgFile = [=[Interface\ChatFrame\ChatFrameBackground]=],
		insets = {left = BACKDROP_INSET, right = BACKDROP_INSET, top = BACKDROP_INSET, bottom = BACKDROP_INSET}
	})
	backdrop:SetBackdropColor(0, 0, 0, 0.6)

	SHADOW_OFFSET   = 5
	SHADOW_EDGESIZE = 5

	local shadow = CreateFrame('Frame', nil, frame)
	shadow:SetFrameStrata('BACKGROUND')
	shadow:SetPoint('TOPLEFT', anchor, 'TOPLEFT', -SHADOW_OFFSET, SHADOW_OFFSET)
	shadow:SetPoint('BOTTOMRIGHT', anchor, 'BOTTOMRIGHT', SHADOW_OFFSET, -SHADOW_OFFSET)
	shadow:SetBackdrop({
		edgeFile = shadowTex, edgeSize = SHADOW_EDGE,
	})
	shadow:SetBackdropBorderColor(0, 0, 0, 0.7)
end

function E:RegisterAlphaAnimation(frame)
	frame.alphaAnimation = frame:CreateAnimationGroup()
	frame.alphaAnimation.alpha = frame.alphaAnimation:CreateAnimation("Alpha")
	frame.alphaAnimation.alpha:SetDuration(0.2)
	frame.alphaAnimation.alpha:SetSmoothing("OUT")
	function frame:PlayAlpha(toAlpha, startDelay)
		local startDelay = startDelay or 0.0
		local enableMouse = toAlpha ~= 0 and true or false

		if self.EnableMouse and not InCombatLockdown() then
			self:EnableMouse(enableMouse)
		end
		self.alphaAnimation.alpha:SetStartDelay(startDelay)
		self.alphaAnimation.alpha:SetFromAlpha(self:GetAlpha())
		self.alphaAnimation.alpha:SetToAlpha(toAlpha)
		self.alphaAnimation:SetToFinalAlpha(toAlpha)
		self.alphaAnimation:Play()
	end
	function frame:PlayReveal()
		self:PlayAlpha(1, 0.0)
	end
	function frame:PlayHide()
		self:PlayAlpha(0, 0.5)
	end
end

function E:FontString(options)
	local o = options
	if not o.parent then return end

	local string = o.parent:CreateFontString(nil, o.layer or "ARTWORK")
	string:SetFont(o.font or C.general.displayFont.typeface, o.fontSize or C.general.displayFont.size, o.fontFlag or C.general.displayFont.flag)
	string:SetTextColor(o.r or 1, o.g or 1, o.b or 1)
	string:SetJustifyH(o.justify or 'LEFT')

	return string
end

function E:HeightPercentage(percentage)
	return (GetScreenHeight() / UIParent:GetEffectiveScale()) * (percentage / 100)
end

function E:WidthPercentage(percentage)
	return (GetScreenWidth() / UIParent:GetEffectiveScale()) * (percentage / 100)
end

function E:PlayerIsTank()
	local assignedRole = UnitGroupRolesAssigned("player")
	if (assignedRole == "NONE") then
		local spec = GetSpecialization()
		return spec and GetSpecializationRole(spec) == "TANK"
	end

	return assignedRole == "TANK"
end

SLASH_RELOADUI1 = '/rl'
SlashCmdList.RELOADUI = ReloadUI
