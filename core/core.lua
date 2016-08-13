local AddOn, ns = ...
local E, C = CreateFrame('Frame', 'sEngine'), {}
ns.E, ns.C = E, C

local shadowTex = "Interface\\AddOns\\sInterface\\media\\shadow_border"

function E:ShadowedBorder(anchor)
	local frame = anchor.GetTexture and anchor:GetParent() or anchor

	local border = CreateFrame('Frame', nil, frame)
	border:SetFrameStrata('BACKGROUND')
	border:SetFrameLevel(0)
	border:SetPoint('TOPLEFT', anchor, 'TOPLEFT', -1, 1)
	border:SetPoint('BOTTOMRIGHT', anchor, 'BOTTOMRIGHT', 1, -1)
	border:SetBackdrop({
		bgFile = [=[Interface\ChatFrame\ChatFrameBackground]=],
		insets = {left = 0, right = 0, top = 0, bottom = 0}
	})
	border:SetBackdropColor(0, 0, 0, 0.6)

	local shadow = CreateFrame('Frame', nil, frame)
	shadow:SetFrameStrata('BACKGROUND')
	shadow:SetPoint('TOPLEFT', anchor, 'TOPLEFT', -4, 4)
	shadow:SetPoint('BOTTOMRIGHT', anchor, 'BOTTOMRIGHT', 4, -4)
	shadow:SetBackdrop({
		edgeFile = shadowTex, edgeSize = 5,
	})
	shadow:SetBackdropBorderColor(0, 0, 0, 0.7)
end

function E:RegisterHideAnimation(frame)
        frame.hideAnimation = frame:CreateAnimationGroup()
        frame.hideAnimation.alpha = frame.hideAnimation:CreateAnimation("Alpha")
        frame.hideAnimation.alpha:SetStartDelay(0.5)
        frame.hideAnimation.alpha:SetFromAlpha(frame:GetAlpha())
        frame.hideAnimation.alpha:SetToAlpha(0)
        frame.hideAnimation.alpha:SetDuration(frame:GetAlpha()/5)
        frame.hideAnimation.alpha:SetSmoothing("OUT")
        frame.hideAnimation:HookScript("OnFinished", function()
                frame:Hide()
        end)

end

function E:RegisterRevealAnimation(frame)
        frame.revealAnimation = frame:CreateAnimationGroup()
        frame.revealAnimation.alpha = frame.revealAnimation:CreateAnimation("Alpha")
        frame.revealAnimation.alpha:SetFromAlpha(frame:GetAlpha())
        frame.revealAnimation.alpha:SetToAlpha(1)
        frame.revealAnimation.alpha:SetDuration(4.2)
        frame.revealAnimation.alpha:SetSmoothing("OUT")
        frame.revealAnimation:HookScript("OnPlay", function()
                frame:Show()
        end)
end

function E:FontString(options)
	local o = options
	if not o.parent then return end

	local string = o.parent:CreateFontString(nil, o.layer or 0)
	string:SetFont(o.font or C.general.font, o.fontSize or C.general.fontSize, o.fontFlag or C.general.fontFlag)
	string:SetTextColor(o.r or 1, o.g or 1, o.b or 1)
	string:SetJustifyH(o.justify or 'LEFT')

	return string
end


SLASH_RELOADUI1 = '/rl'
SlashCmdList.RELOADUI = ReloadUI
