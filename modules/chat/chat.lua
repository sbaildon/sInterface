local _, ns = ...
local E, C = ns.E, ns.C

TypeInfo = { "SYSTEM", "SAY", "PARTY", "RAID", "GUILD", "OFFICER", "YELL", "WHISPER",
	"SMART_WHISPER", "WHISPER_INFORM", "REPLY", "EMOTE", "TEXT_EMOTE", "MONSTER_SAY",
	"MONSTER_PARTY", "MONSTER_YELL", "MONSTER_WHISPER", "MONSTER_EMOTE", "CHANNEL",
	"CHANNEL_JOIN", "CHANNEL_LEAVE", "CHANNEL_LIST", "CHANNEL_NOTICE", "CHANNEL_NOTICE_USER",
	"TARGETICONS", "AFK", "DND", "IGNORED", "SKILL", "LOOT", "CURRENCY", "MONEY",
	"OPENING", "TRADESKILLS", "PET_INFO", "COMBAT_MISC_INFO", "COMBAT_XP_GAIN", 
	"COMBAT_HONOR_GAIN", "COMBAT_FACTION_CHANGE", "BG_SYSTEM_NEUTRAL",
	"BG_SYSTEM_HORDE", "RAID_LEADER", "RAID_WARNING", "RAID_BOSS_WHISPER",
	"RAID_BOSS_EMOTE", "QUEST_BOSS_EMOTE", "FILTERED", "INSTANCE_CHAT",
	"INSTANCE_CHAT_LEADER", "RESTRICTED", "CHANNEL1", "CHANNEL2", "CHANNEL3",  
	"CHANNEL4", "CHANNEL5", "CHANNEL6", "CHANNEL7", "CHANNEL8", "CHANNEL9", "CHANNEL10",
	"ACHIEVEMENT", "GUILD_ACHIEVEMENT", "PARTY_LEADER", "BN_WHISPER", "BN_WHISPER_INFORM",
	"BN_ALERT", "BN_BROADCAST", "BN_BROADCAST_INFORM", "BN_INLINE_TOAST_ALERT", 
	"BN_INLINE_TOAST_BROADCAST", "BN_INLINE_TOAST_BROADCAST_INFORM", "BN_WHISPER_PLAYER_OFFLINE",
	"COMBAT_GUILD_XP_GAIN", "PET_BATTLE_COMBAT_LOG", "PET_BATTLE_INFO", "GUILD_ITEM_LOOTED"
} -- why on earth does iterating over ChatTypeInfo not work?

ChatFrameMenuButton:HookScript("OnShow", ChatFrameMenuButton.Hide)
ChatFrameMenuButton:Hide()

FriendsMicroButton:HookScript("OnShoW", FriendsMicroButton.Hide)
FriendsMicroButton:Hide()

ChatFontNormal:SetFont(STANDARD_TEXT_FONT, 12)

FCFTab_UpdateColors = function(self, selected)
	if selected then
		self:GetFontString():SetTextColor(1, 0.75, 0, 1)
	else
		self:GetFontString():SetTextColor(0.5, 0.5, 0.5, 1)
	end
end

local function style(self)
	if not self or (self and self.styled) then return end

	local name = self:GetName()

	self:SetClampRectInsets(0, 0, 0, 0)
	self:SetMaxResize(UIParent:GetWidth(), UIParent:GetHeight())
	self:SetMinResize(100, 50)

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
	ChatFrame1:SetHeight(110)

	FCF_SetLocked(ChatFrame1, true)
end)

local function ColourByClass()
	for i = 1,#TypeInfo do
		local info = ChatTypeInfo[TypeInfo[i]]
		info.colorNameByClass = true
	end
end

local ChatLogin = CreateFrame('Frame', nil)
ChatLogin:RegisterEvent('PLAYER_LOGIN')
ChatLogin:SetScript('OnEvent', ColourByClass)

