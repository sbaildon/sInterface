local _, ns = ...
local E, C, U_C = ns.E, ns.C, ns.U_C

local shadowTex = "Interface\\AddOns\\sInterface\\media\\shadow_border"

function E:ShadowedBorder(anchor)
	local frame = anchor.GetTexture and anchor:GetParent() or anchor

	local BACKDROP_OFFSET = 3
	local BACKDROP_INSET  = 2

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

	local SHADOW_OFFSET   = 5
	local SHADOW_EDGESIZE = 5

	local shadow = CreateFrame('Frame', nil, frame)
	shadow:SetFrameStrata('BACKGROUND')
	shadow:SetPoint('TOPLEFT', anchor, 'TOPLEFT', -SHADOW_OFFSET, SHADOW_OFFSET)
	shadow:SetPoint('BOTTOMRIGHT', anchor, 'BOTTOMRIGHT', SHADOW_OFFSET, -SHADOW_OFFSET)
	shadow:SetBackdrop({
		edgeFile = shadowTex, edgeSize = SHADOW_EDGESIZE,
	})
	shadow:SetBackdropBorderColor(0, 0, 0, 0.7)
end

function E:RegisterAlphaAnimation(frame)
	frame.alphaAnimation = frame:CreateAnimationGroup()
	frame.alphaAnimation.alpha = frame.alphaAnimation:CreateAnimation("Alpha")
	frame.alphaAnimation.alpha:SetDuration(0.2)
	frame.alphaAnimation.alpha:SetSmoothing("OUT")
	function frame:PlayAlpha(toAlpha, startDelay)
		local delay = startDelay or 0.0
		local enableMouse = toAlpha ~= 0 and true or false

		if self.EnableMouse and not InCombatLockdown() then
			self:EnableMouse(enableMouse)
		end
		self.alphaAnimation.alpha:SetStartDelay(delay)
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

function E:PlayerIsTank()
	local assignedRole = UnitGroupRolesAssigned("player")
	if (assignedRole == "NONE") then
		local spec = GetSpecialization()
		return spec and GetSpecializationRole(spec) == "TANK"
	end

	return assignedRole == "TANK"
end

function E:CommaValue(number)  -- credit http://richard.warburton.it
	if not number then return end

	local left ,num, right = string.match(number,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

local function merge(t1, t2)
	for k, v in pairs(t2) do
		if (type(v) == "table") and (type(t1[k] or false) == "table") then
			merge(t1[k], t2[k])
		else
			t1[k] = v
		end
	end
	return t1
end

if (U_C) then
	C = merge(C, U_C)
end

SLASH_RELOADUI1 = '/rl'
SlashCmdList.RELOADUI = ReloadUI