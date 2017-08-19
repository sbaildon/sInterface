local addon, ns = ...
local E, C = ns.E, ns.C

if not C.talkinghead.enabled then return end

local TalkingHeadAnchor = CreateFrame("Frame", addon.."TalkingHeadAnchor", UIParent)
TalkingHeadAnchor:SetScale(C["talkinghead"].scale)
TalkingHeadAnchor:SetPoint(unpack(C["talkinghead"].position))
TalkingHeadAnchor:SetSize(1,1)

TalkingHeadAnchor:RegisterEvent('ADDON_LOADED')
TalkingHeadAnchor:SetScript('OnEvent', function(self, event, ...)
	local addonname = ...
	if (addonname == "Blizzard_TalkingHeadUI") then
		TalkingHeadFrame:SetParent(TalkingHeadAnchor)
		TalkingHeadFrame:ClearAllPoints()
		TalkingHeadFrame:SetPoint("CENTER")
		TalkingHeadFrame.ignoreFramePositionManager = true
		self:UnregisterAllEvents()
	end
end)
