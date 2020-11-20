local _, ns = ...
local E = ns.E

if not E:C('chat', 'enabled') then return end

ChatFrameMenuButton:HookScript("OnShow", ChatFrameMenuButton.Hide)
ChatFrameMenuButton:Hide()

ChatFrameToggleVoiceDeafenButton:HookScript("OnShow", ChatFrameMenuButton.Hide)
ChatFrameToggleVoiceDeafenButton:Hide()

ChatFrameToggleVoiceMuteButton:HookScript("OnShow", ChatFrameMenuButton.Hide)
ChatFrameToggleVoiceMuteButton:Hide()

ChatFrameChannelButton:HookScript("OnShow", ChatFrameMenuButton.Hide)
ChatFrameChannelButton:Hide()

QuickJoinToastButton:HookScript("OnShoW", QuickJoinToastButton.Hide)
QuickJoinToastButton:Hide()

hooksecurefunc("FCFTab_UpdateColors", function(self, selected)
	local string = self:GetFontString()
	local font, size = string:GetFont()
	string:SetFont(font, size, "OUTLINE")

	if selected then
		string:SetTextColor(1, 0.75, 0, 1)
	else
		string:SetTextColor(0.5, 0.5, 0.5, 1)
	end
end)

local function style(self)
	if not self or self.styled then return end

	local name = self:GetName()

	self:SetClampRectInsets(0, 0, 0, 0)
	self:SetMaxResize(UIParent:GetWidth(), UIParent:GetHeight())
	self:SetMinResize(100, 50)
	local font, _, flags = ChatFontNormal:GetFont()
	self:SetFont(font, E:C('chat', 'fontSize'), flags)

	local tab = _G[name.."Tab"]
	tab:SetScript("OnEnter", function(self)
		self:SetAlpha(1)
	end)
	tab:SetScript("OnLeave", function(self)
		self:SetAlpha(0.3)
		self:GetFontString():SetFontObject("GameFontNormalOutline")
	end)
	local tabFs = tab:GetFontString()
	tabFs:SetFontObject("GameFontNormalOutline")

	local bframe = _G[name.."ButtonFrame"]
	bframe:Hide()
	bframe:HookScript("OnShow", bframe.Hide)

	_G[name.."EditBoxLeft"]:Hide()
	_G[name.."EditBoxMid"]:Hide()
	_G[name.."EditBoxRight"]:Hide()
	local eb = _G[name.."EditBox"]
	eb:SetAltArrowKeyMode(false)
	eb:ClearAllPoints()
	eb:SetPoint("BOTTOM", tab, "TOP", 0, -10)
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
	ChatFrame1:SetPoint(unpack(E:C('chat', 'position')))
	ChatFrame1:SetUserPlaced(true)
	ChatFrame1:SetHeight(E:C('chat', 'height'))
	ChatFrame1:SetWidth(E:C('chat', 'width'))

	FCF_SetLocked(ChatFrame1, true)
end)

local function ColourByClass()
	local cti = getmetatable(ChatTypeInfo).__index
	for _, v in pairs(cti) do
		v.colorNameByClass = true
	end
end

local ChatLogin = CreateFrame('Frame', nil)
ChatLogin:RegisterEvent('PLAYER_LOGIN')
ChatLogin:SetScript('OnEvent', ColourByClass)
