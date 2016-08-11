local AddOn, ns = ...
local E, C = CreateFrame('Frame', 'sEngine'), {}
ns.E, ns.C = E, C

local shadowTex = "Interface\\AddOns\\sInterface\\media\\shadow_border"

function E:ShadowedBorder(frame)
	local border = CreateFrame('Frame', nil, frame)
	border:SetFrameStrata('BACKGROUND')
	border:SetFrameLevel(0)
	border:SetPoint('TOPLEFT', frame, 'TOPLEFT', -1, 1)
	border:SetPoint('BOTTOMRIGHT', frame, 'BOTTOMRIGHT', 1, -1)
	border:SetBackdrop({
		edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 1,
		bgFile = nil,
		insets = {left = 0, right = 0, top = 0, bottom = 0}
	})
	border:SetBackdropColor(0, 0, 0, 0.6)

	local backdrop = CreateFrame('Frame', nil, frame)
	backdrop:SetFrameStrata('BACKGROUND')
	backdrop:SetFrameLevel(0)
	backdrop:SetPoint('TOPLEFT', frame, 'TOPLEFT', -1, 1)
	backdrop:SetPoint('BOTTOMRIGHT', frame, 'BOTTOMRIGHT', 1, -1)
	backdrop:SetBackdrop({
		edgeFile = nil, edgeSize = 1,
		bgFile = [=[Interface\ChatFrame\ChatFrameBackground]=],
		insets = {left = 0, right = 0, top = 0, bottom = 0}
	})
	backdrop:SetBackdropColor(0, 0, 0, 0.2)

	local shadow = CreateFrame('Frame', nil, frame)
	shadow:SetFrameStrata('BACKGROUND')
	shadow:SetPoint('TOPLEFT', frame, 'TOPLEFT', -4, 4)
	shadow:SetPoint('BOTTOMRIGHT', frame, 'BOTTOMRIGHT', 4, -4)
	shadow:SetBackdrop({
		edgeFile = shadowTex, edgeSize = 5,
	})
	shadow:SetBackdropBorderColor(0, 0, 0, 0.7)
end

SLASH_RELOADUI1 = '/rl'
SlashCmdList.RELOADUI = ReloadUI
