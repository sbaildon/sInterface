local _, ns = ...
local E, C = ns.E, ns.C

if not C.chat.enabled then return end

ChatFrameMenuButton:HookScript("OnShow", ChatFrameMenuButton.Hide)
ChatFrameMenuButton:Hide()

QuickJoinToastButton:HookScript("OnShoW", QuickJoinToastButton.Hide)
QuickJoinToastButton:Hide()

ChatFontNormal:SetFont(STANDARD_TEXT_FONT, 12)

FCFTab_UpdateColors = function(self, selected)
	if selected then
		self:GetFontString():SetTextColor(1, 0.75, 0, 1)
	else
		self:GetFontString():SetTextColor(0.5, 0.5, 0.5, 1)
	end
end

local function style(self)
	if not self or self.styled then return end

	local name = self:GetName()

	self:SetClampRectInsets(0, 0, 0, 0)
	self:SetMaxResize(UIParent:GetWidth(), UIParent:GetHeight())
	self:SetMinResize(100, 50)

	self:SetFont(C.chat.font, C.chat.fontSize)

	local tab = _G[name.."Tab"]
	tab:SetScript("OnEnter", function(self)
		self:SetAlpha(1)
	end)
	tab:SetScript("OnLeave", function(self)
		self:SetAlpha(0.3)
	end)
	local tabFs = tab:GetFontString()
	tabFs:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")

	local bframe = _G[name.."ButtonFrame"]
	bframe:Hide()
	bframe:HookScript("OnShow", bframe.Hide)

	_G[name.."EditBoxLeft"]:Hide()
	_G[name.."EditBoxMid"]:Hide()
	_G[name.."EditBoxRight"]:Hide()
	local eb = _G[name.."EditBox"]
	eb:SetAltArrowKeyMode(false)
	eb:ClearAllPoints()
	eb:SetPoint("BOTTOM", self, "TOP", 0, 22)
	eb:SetPoint("LEFT", self, -5, 0)
	eb:SetPoint("RIGHT", self, 10, 0)

	_G[name.."TabLeft"]:SetTexture(nil)
	_G[name.."TabMiddle"]:SetTexture(nil)
	_G[name.."TabRight"]:SetTexture(nil)
	_G[name.."TabSelectedLeft"]:SetTexture(nil)
	_G[name.."TabSelectedMiddle"]:SetTexture(nil)
	_G[name.."TabSelectedRight"]:SetTexture(nil)
	_G[name.."TabHighlightLeft"]:SetTexture(nil)
	_G[name.."TabHighlightMiddle"]:SetTexture(nil)
	_G[name.."TabHighlightRight"]:SetTexture(nil)
	_G[name.."TopTexture"]:SetTexture(nil)
	_G[name.."RightTexture"]:SetTexture(nil)
	_G[name.."BottomTexture"]:SetTexture(nil)
	_G[name.."LeftTexture"]:SetTexture(nil)
	_G[name.."Background"]:SetTexture(nil)

	self.styled = true
end

for i = 1, NUM_CHAT_WINDOWS do
	style(_G["ChatFrame"..i])
end

hooksecurefunc("FCF_OpenTemporaryWindow", function()
	for _, chatFrameName in pairs(CHAT_FRAMES) do
		local frame = _G[chatFrameName]
		if frame.isTemporary then
			style(frame)
		end
	end
end)

hooksecurefunc("FloatingChatFrame_Update", function()
	FCF_SetLocked(ChatFrame1, false)

	ChatFrame1:ClearAllPoints()
	ChatFrame1:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", C.general.edgeSpacing, C.general.edgeSpacing)
	ChatFrame1:SetUserPlaced(true)
	ChatFrame1:SetHeight(115)

	FCF_SetLocked(ChatFrame1, true)
end)

local function ColourByClass()
	local cti = getmetatable(ChatTypeInfo).__index
	for k,v in pairs(cti) do
		v.colorNameByClass = true
	end
end

local ChatLogin = CreateFrame('Frame', nil)
ChatLogin:RegisterEvent('PLAYER_LOGIN')
ChatLogin:SetScript('OnEvent', ColourByClass)
