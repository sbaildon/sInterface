local addon, ns = ...
local E = ns.E

if not E:C('talkinghead', 'enabled') then return end

local TalkingHeadAnchor = CreateFrame("Frame", addon.."TalkingHeadAnchor", UIParent)
TalkingHeadAnchor:SetScale(E:C('talkinghead', 'scale'))
TalkingHeadAnchor:SetPoint(unpack(E:C('talkinghead', 'position')))
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
